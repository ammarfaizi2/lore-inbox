Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWIAEi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWIAEi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWIAEiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:38:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:21675 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932113AbWIAEiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:38:46 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:38:38 +1000
Message-Id: <1060901043838.27488@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 006 of 19] knfsd: lockd: Make nlm_host_rebooted use the nsm_handle
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  This patch makes the SM_NOTIFY handling understand and use
  the nsm_handle.

  To make it a bit clear what is happening:
    nlmclent_prepare_reclaim and nlmclnt_finish_reclaim
    get open-coded into 'reclaimer'
  The result is tidied up.
  Then some of that functionality is moved out into
  nlm_host_rebooted (which calls nlmclnt_recovery which
    starts a thread which runs reclaimer).

  Also host_rebooted now finds an nsm_handle rather than a
  host, then then iterates over all hosts and deals with
  each host that shares that nsm_handle.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>
 
### Diffstat output
 ./fs/lockd/clntlock.c         |   55 ++++++++++++-----------------------
 ./fs/lockd/host.c             |   65 ++++++++++++++++++++++++++++++------------
 ./fs/lockd/svc4proc.c         |    2 -
 ./fs/lockd/svcproc.c          |    2 -
 ./include/linux/lockd/lockd.h |    4 +-
 5 files changed, 70 insertions(+), 58 deletions(-)

diff .prev/fs/lockd/clntlock.c ./fs/lockd/clntlock.c
--- .prev/fs/lockd/clntlock.c	2006-08-31 17:00:03.000000000 +1000
+++ ./fs/lockd/clntlock.c	2006-08-31 17:02:23.000000000 +1000
@@ -144,43 +144,12 @@ u32 nlmclnt_grant(const struct sockaddr_
  */
 
 /*
- * Someone has sent us an SM_NOTIFY. Ensure we bind to the new port number,
- * that we mark locks for reclaiming, and that we bump the pseudo NSM state.
- */
-static void nlmclnt_prepare_reclaim(struct nlm_host *host)
-{
-	down_write(&host->h_rwsem);
-	if (host->h_nsmhandle)
-		host->h_nsmhandle->sm_monitored = 0;
-	host->h_state++;
-	host->h_nextrebind = 0;
-	nlm_rebind_host(host);
-
-	/*
-	 * Mark the locks for reclaiming.
-	 */
-	list_splice_init(&host->h_granted, &host->h_reclaim);
-
-	dprintk("NLM: reclaiming locks for host %s\n", host->h_name);
-}
-
-static void nlmclnt_finish_reclaim(struct nlm_host *host)
-{
-	host->h_reclaiming = 0;
-	up_write(&host->h_rwsem);
-	dprintk("NLM: done reclaiming locks for host %s", host->h_name);
-}
-
-/*
  * Reclaim all locks on server host. We do this by spawning a separate
  * reclaimer thread.
  */
 void
-nlmclnt_recovery(struct nlm_host *host, u32 newstate)
+nlmclnt_recovery(struct nlm_host *host)
 {
-	if (host->h_nsmstate == newstate)
-		return;
-	host->h_nsmstate = newstate;
 	if (!host->h_reclaiming++) {
 		nlm_get_host(host);
 		__module_get(THIS_MODULE);
@@ -200,18 +169,30 @@ reclaimer(void *ptr)
 	daemonize("%s-reclaim", host->h_name);
 	allow_signal(SIGKILL);
 
+	down_write(&host->h_rwsem);
+
 	/* This one ensures that our parent doesn't terminate while the
 	 * reclaim is in progress */
 	lock_kernel();
 	lockd_up(0); /* note: this cannot fail as lockd is already running */
 
-	nlmclnt_prepare_reclaim(host);
-	/* First, reclaim all locks that have been marked. */
+	dprintk("lockd: reclaiming locks for host %s", host->h_name);
+
 restart:
 	nsmstate = host->h_nsmstate;
+
+	/* Force a portmap getport - the peer's lockd will
+	 * most likely end up on a different port.
+	 */
+	host->h_nextrebind = 0;
+	nlm_rebind_host(host);
+
+	/* First, reclaim all locks that have been granted. */
+	list_splice_init(&host->h_granted, &host->h_reclaim);
 	list_for_each_entry_safe(fl, next, &host->h_reclaim, fl_u.nfs_fl.list) {
 		list_del_init(&fl->fl_u.nfs_fl.list);
 
+		/* Why are we leaking memory here? --okir */
 		if (signalled())
 			continue;
 		if (nlmclnt_reclaim(host, fl) != 0)
@@ -219,11 +200,13 @@ restart:
 		list_add_tail(&fl->fl_u.nfs_fl.list, &host->h_granted);
 		if (host->h_nsmstate != nsmstate) {
 			/* Argh! The server rebooted again! */
-			list_splice_init(&host->h_granted, &host->h_reclaim);
 			goto restart;
 		}
 	}
-	nlmclnt_finish_reclaim(host);
+
+	host->h_reclaiming = 0;
+	up_write(&host->h_rwsem);
+	dprintk("NLM: done reclaiming locks for host %s", host->h_name);
 
 	/* Now, wake up all processes that sleep on a blocked lock */
 	list_for_each_entry(block, &nlm_blocked, b_list) {

diff .prev/fs/lockd/host.c ./fs/lockd/host.c
--- .prev/fs/lockd/host.c	2006-08-31 17:01:00.000000000 +1000
+++ ./fs/lockd/host.c	2006-08-31 17:02:03.000000000 +1000
@@ -290,28 +290,57 @@ void nlm_release_host(struct nlm_host *h
  * has rebooted.
  * Release all resources held by that peer.
  */
-void nlm_host_rebooted(const struct sockaddr_in *sin, const struct nlm_reboot *argp)
-{
-	struct nlm_host *host;
-	int server;
+void nlm_host_rebooted(const struct sockaddr_in *sin,
+				const char *hostname, int hostname_len,
+				u32 new_state)
+{
+	struct nsm_handle *nsm;
+	struct nlm_host	*host, **hp;
+	int		hash;
 
-	/* Obtain the host pointer for this NFS server and try to
-	 * reclaim all locks we hold on this server.
-	 */
-	server = (argp->proto & 1)? 1 : 0;
-	host = nlm_lookup_host(server, sin, argp->proto >> 1, argp->vers,
-			argp->mon, argp->len);
-	if (host == NULL)
+	dprintk("lockd: nlm_host_rebooted(%s, %u.%u.%u.%u)\n",
+			hostname, NIPQUAD(sin->sin_addr));
+
+	/* Find the NSM handle for this peer */
+	if (!(nsm = __nsm_find(sin, hostname, hostname_len, 0)))
 		return;
 
-	if (server == 0) {
-		/* We are client, he's the server: try to reclaim all locks. */
-		nlmclnt_recovery(host, argp->state);
-	} else {
-		/* He's the client, we're the server: delete all locks held by the client */
-		nlmsvc_free_host_resources(host);
+	/* When reclaiming locks on this peer, make sure that
+	 * we set up a new notification */
+	nsm->sm_monitored = 0;
+
+	/* Mark all hosts tied to this NSM state as having rebooted.
+	 * We run the loop repeatedly, because we drop the host table
+	 * lock for this.
+	 * To avoid processing a host several times, we match the nsmstate.
+	 */
+again:	mutex_lock(&nlm_host_mutex);
+	for (hash = 0; hash < NLM_HOST_NRHASH; hash++) {
+		for (hp = &nlm_hosts[hash]; (host = *hp); hp = &host->h_next) {
+			if (host->h_nsmhandle == nsm
+			 && host->h_nsmstate != new_state) {
+				host->h_nsmstate = new_state;
+				host->h_state++;
+
+				nlm_get_host(host);
+				mutex_unlock(&nlm_host_mutex);
+
+				if (host->h_server) {
+					/* We're server for this guy, just ditch
+					 * all the locks he held. */
+					nlmsvc_free_host_resources(host);
+				} else {
+					/* He's the server, initiate lock recovery. */
+					nlmclnt_recovery(host);
+				}
+
+				nlm_release_host(host);
+				goto again;
+			}
+		}
 	}
-	nlm_release_host(host);
+
+	mutex_unlock(&nlm_host_mutex);
 }
 
 /*

diff .prev/fs/lockd/svc4proc.c ./fs/lockd/svc4proc.c
--- .prev/fs/lockd/svc4proc.c	2006-08-31 16:59:53.000000000 +1000
+++ ./fs/lockd/svc4proc.c	2006-08-31 17:02:03.000000000 +1000
@@ -438,7 +438,7 @@ nlm4svc_proc_sm_notify(struct svc_rqst *
 	 */
 	memset(&saddr, 0, sizeof(saddr));
 	saddr.sin_addr.s_addr = argp->addr;
-	nlm_host_rebooted(&saddr, argp);
+	nlm_host_rebooted(&saddr, argp->mon, argp->len, argp->state);
 
 	return rpc_success;
 }

diff .prev/fs/lockd/svcproc.c ./fs/lockd/svcproc.c
--- .prev/fs/lockd/svcproc.c	2006-08-31 16:59:39.000000000 +1000
+++ ./fs/lockd/svcproc.c	2006-08-31 17:02:03.000000000 +1000
@@ -467,7 +467,7 @@ nlmsvc_proc_sm_notify(struct svc_rqst *r
 	 */
 	memset(&saddr, 0, sizeof(saddr));
 	saddr.sin_addr.s_addr = argp->addr;
-	nlm_host_rebooted(&saddr, argp);
+	nlm_host_rebooted(&saddr, argp->mon, argp->len, argp->state);
 
 	return rpc_success;
 }

diff .prev/include/linux/lockd/lockd.h ./include/linux/lockd/lockd.h
--- .prev/include/linux/lockd/lockd.h	2006-08-31 17:00:03.000000000 +1000
+++ ./include/linux/lockd/lockd.h	2006-08-31 17:02:03.000000000 +1000
@@ -164,7 +164,7 @@ struct nlm_wait * nlmclnt_prepare_block(
 void		  nlmclnt_finish_block(struct nlm_wait *block);
 int		  nlmclnt_block(struct nlm_wait *block, struct nlm_rqst *req, long timeout);
 u32		  nlmclnt_grant(const struct sockaddr_in *addr, const struct nlm_lock *);
-void		  nlmclnt_recovery(struct nlm_host *, u32);
+void		  nlmclnt_recovery(struct nlm_host *);
 int		  nlmclnt_reclaim(struct nlm_host *, struct file_lock *);
 
 /*
@@ -179,7 +179,7 @@ struct nlm_host * nlm_get_host(struct nl
 void		  nlm_release_host(struct nlm_host *);
 void		  nlm_shutdown_hosts(void);
 extern struct nlm_host *nlm_find_client(void);
-extern void	  nlm_host_rebooted(const struct sockaddr_in *, const struct nlm_reboot *);
+extern void	  nlm_host_rebooted(const struct sockaddr_in *, const char *, int, u32);
 struct nsm_handle *nsm_find(const struct sockaddr_in *, const char *, int);
 void		  nsm_release(struct nsm_handle *);
 

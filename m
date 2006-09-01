Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWIAEir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWIAEir (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWIAEid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:38:33 -0400
Received: from mx1.suse.de ([195.135.220.2]:57561 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932103AbWIAEiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:38:22 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:38:14 +1000
Message-Id: <1060901043814.27440@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 002 of 19] knfsd: Consolidate common code for statd->lockd notification
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  Common code from nlm4svc_proc_sm_notify and nlmsvc_proc_sm_notify
  is moved into a new nlm_host_rebooted.

  This is in preparation of a patch that will change the
  reboot notification handling entirely.

Signed-off-by: okir@suse.de
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/host.c             |   30 ++++++++++++++++++++++++++++--
 ./fs/lockd/svc4proc.c         |   19 ++-----------------
 ./fs/lockd/svcproc.c          |   17 ++---------------
 ./include/linux/lockd/lockd.h |    5 +++--
 4 files changed, 35 insertions(+), 36 deletions(-)

diff .prev/fs/lockd/host.c ./fs/lockd/host.c
--- .prev/fs/lockd/host.c	2006-08-31 16:12:30.000000000 +1000
+++ ./fs/lockd/host.c	2006-08-31 16:16:24.000000000 +1000
@@ -39,7 +39,7 @@ static void			nlm_gc_hosts(void);
  * Find an NLM server handle in the cache. If there is none, create it.
  */
 struct nlm_host *
-nlmclnt_lookup_host(struct sockaddr_in *sin, int proto, int version)
+nlmclnt_lookup_host(const struct sockaddr_in *sin, int proto, int version)
 {
 	return nlm_lookup_host(0, sin, proto, version);
 }
@@ -58,7 +58,7 @@ nlmsvc_lookup_host(struct svc_rqst *rqst
  * Common host lookup routine for server & client
  */
 struct nlm_host *
-nlm_lookup_host(int server, struct sockaddr_in *sin,
+nlm_lookup_host(int server, const struct sockaddr_in *sin,
 					int proto, int version)
 {
 	struct nlm_host	*host, **hp;
@@ -260,6 +260,32 @@ void nlm_release_host(struct nlm_host *h
 }
 
 /*
+ * We were notified that the host indicated by address &sin
+ * has rebooted.
+ * Release all resources held by that peer.
+ */
+void nlm_host_rebooted(const struct sockaddr_in *sin, const struct nlm_reboot *argp)
+{
+	struct nlm_host *host;
+
+	/* Obtain the host pointer for this NFS server and try to
+	 * reclaim all locks we hold on this server.
+	 */
+	if ((argp->proto & 1)==0) {
+		/* We are client, he's the server: try to reclaim all locks. */
+		if ((host = nlmclnt_lookup_host(sin, argp->proto >> 1, argp->vers)) == NULL)
+			return;
+		nlmclnt_recovery(host, argp->state);
+	} else {
+		/* He's the client, we're the server: delete all locks held by the client */
+		if ((host = nlm_lookup_host(1, sin, argp->proto >> 1, argp->vers)) == NULL)
+			return;
+		nlmsvc_free_host_resources(host);
+	}
+	nlm_release_host(host);
+}
+
+/*
  * Shut down the hosts module.
  * Note that this routine is called only at server shutdown time.
  */

diff .prev/fs/lockd/svc4proc.c ./fs/lockd/svc4proc.c
--- .prev/fs/lockd/svc4proc.c	2006-08-31 16:12:30.000000000 +1000
+++ ./fs/lockd/svc4proc.c	2006-08-31 16:16:24.000000000 +1000
@@ -420,10 +420,6 @@ nlm4svc_proc_sm_notify(struct svc_rqst *
 					      void	        *resp)
 {
 	struct sockaddr_in	saddr = rqstp->rq_addr;
-	int			vers = argp->vers;
-	int			prot = argp->proto >> 1;
-
-	struct nlm_host		*host;
 
 	dprintk("lockd: SM_NOTIFY     called\n");
 	if (saddr.sin_addr.s_addr != htonl(INADDR_LOOPBACK)
@@ -438,21 +434,10 @@ nlm4svc_proc_sm_notify(struct svc_rqst *
 	/* Obtain the host pointer for this NFS server and try to
 	 * reclaim all locks we hold on this server.
 	 */
+	memset(&saddr, 0, sizeof(saddr));
 	saddr.sin_addr.s_addr = argp->addr;
+	nlm_host_rebooted(&saddr, argp);
 
-	if ((argp->proto & 1)==0) {
-		if ((host = nlmclnt_lookup_host(&saddr, prot, vers)) != NULL) {
-			nlmclnt_recovery(host, argp->state);
-			nlm_release_host(host);
-		}
-	} else {
-		/* If we run on an NFS server, delete all locks held by the client */
-
-		if ((host = nlm_lookup_host(1, &saddr, prot, vers)) != NULL) {
-			nlmsvc_free_host_resources(host);
-			nlm_release_host(host);
-		}
-	}
 	return rpc_success;
 }
 

diff .prev/fs/lockd/svcproc.c ./fs/lockd/svcproc.c
--- .prev/fs/lockd/svcproc.c	2006-08-31 16:12:30.000000000 +1000
+++ ./fs/lockd/svcproc.c	2006-08-31 16:16:24.000000000 +1000
@@ -449,9 +449,6 @@ nlmsvc_proc_sm_notify(struct svc_rqst *r
 					      void	        *resp)
 {
 	struct sockaddr_in	saddr = rqstp->rq_addr;
-	int			vers = argp->vers;
-	int			prot = argp->proto >> 1;
-	struct nlm_host		*host;
 
 	dprintk("lockd: SM_NOTIFY     called\n");
 	if (saddr.sin_addr.s_addr != htonl(INADDR_LOOPBACK)
@@ -466,19 +463,9 @@ nlmsvc_proc_sm_notify(struct svc_rqst *r
 	/* Obtain the host pointer for this NFS server and try to
 	 * reclaim all locks we hold on this server.
 	 */
+	memset(&saddr, 0, sizeof(saddr));
 	saddr.sin_addr.s_addr = argp->addr;
-	if ((argp->proto & 1)==0) {
-		if ((host = nlmclnt_lookup_host(&saddr, prot, vers)) != NULL) {
-			nlmclnt_recovery(host, argp->state);
-			nlm_release_host(host);
-		}
-	} else {
-		/* If we run on an NFS server, delete all locks held by the client */
-		if ((host = nlm_lookup_host(1, &saddr, prot, vers)) != NULL) {
-			nlmsvc_free_host_resources(host);
-			nlm_release_host(host);
-		}
-	}
+	nlm_host_rebooted(&saddr, argp);
 
 	return rpc_success;
 }

diff .prev/include/linux/lockd/lockd.h ./include/linux/lockd/lockd.h
--- .prev/include/linux/lockd/lockd.h	2006-08-31 16:16:24.000000000 +1000
+++ ./include/linux/lockd/lockd.h	2006-08-31 16:16:24.000000000 +1000
@@ -161,15 +161,16 @@ int		  nlmclnt_reclaim(struct nlm_host *
 /*
  * Host cache
  */
-struct nlm_host * nlmclnt_lookup_host(struct sockaddr_in *, int, int);
+struct nlm_host * nlmclnt_lookup_host(const struct sockaddr_in *, int, int);
 struct nlm_host * nlmsvc_lookup_host(struct svc_rqst *);
-struct nlm_host * nlm_lookup_host(int server, struct sockaddr_in *, int, int);
+struct nlm_host * nlm_lookup_host(int server, const struct sockaddr_in *, int, int);
 struct rpc_clnt * nlm_bind_host(struct nlm_host *);
 void		  nlm_rebind_host(struct nlm_host *);
 struct nlm_host * nlm_get_host(struct nlm_host *);
 void		  nlm_release_host(struct nlm_host *);
 void		  nlm_shutdown_hosts(void);
 extern struct nlm_host *nlm_find_client(void);
+extern void	  nlm_host_rebooted(const struct sockaddr_in *, const struct nlm_reboot *);
 
 
 /*

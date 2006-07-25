Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWGYB5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWGYB5j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWGYBzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:55:43 -0400
Received: from ns.suse.de ([195.135.220.2]:10476 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932393AbWGYBz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:55:26 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 25 Jul 2006 11:54:47 +1000
Message-Id: <1060725015447.21957@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 9] knfsd: Be more selective in which sockets lockd listens on.
References: <20060725114207.21779.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently lockd listens on UDP always, and TCP if CONFIG_NFSD_TCP 
is set.

However as lockd performs services of the client as well, this is a
problem.  If CONFIG_NfSD_TCP is not set, and a tcp mount is used, the
server will not be able to call back to lockd.

So:
 - add an option to lockd_up saying which protocol is needed
 - Always open sockets for which an explicit port was given, otherwise
   only open a socket of the type required
 - Change nfsd to do one lockd_up per socket rather than one per thread.

This
 - removes the dependancy on CONFIG_NFSD_TCP
 - means that lockd may open sockets other than at startup
 - means that lockd will *not* listen on UDP if the only
   mounts are TCP mount (and nfsd hasn't started).

The latter is the only one that concerns me at all - I don't know if
this might be a problem with some servers.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/clntlock.c        |    2 -
 ./fs/lockd/svc.c             |   47 ++++++++++++++++++++++++++++++++++++-------
 ./fs/nfs/super.c             |    6 +++--
 ./fs/nfsd/nfssvc.c           |   16 +++++++++-----
 ./include/linux/lockd/bind.h |    2 -
 5 files changed, 56 insertions(+), 17 deletions(-)

diff .prev/fs/lockd/clntlock.c ./fs/lockd/clntlock.c
--- .prev/fs/lockd/clntlock.c	2006-07-24 15:15:04.000000000 +1000
+++ ./fs/lockd/clntlock.c	2006-07-24 15:15:04.000000000 +1000
@@ -202,7 +202,7 @@ reclaimer(void *ptr)
 	/* This one ensures that our parent doesn't terminate while the
 	 * reclaim is in progress */
 	lock_kernel();
-	lockd_up();
+	lockd_up(0);
 
 	nlmclnt_prepare_reclaim(host);
 	/* First, reclaim all locks that have been marked. */

diff .prev/fs/lockd/svc.c ./fs/lockd/svc.c
--- .prev/fs/lockd/svc.c	2006-07-24 15:13:40.000000000 +1000
+++ ./fs/lockd/svc.c	2006-07-24 15:15:04.000000000 +1000
@@ -31,6 +31,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/svcsock.h>
+#include <net/ip.h>
 #include <linux/lockd/lockd.h>
 #include <linux/nfs.h>
 
@@ -46,6 +47,7 @@ EXPORT_SYMBOL(nlmsvc_ops);
 static DEFINE_MUTEX(nlmsvc_mutex);
 static unsigned int		nlmsvc_users;
 static pid_t			nlmsvc_pid;
+static struct svc_serv		*nlmsvc_serv;
 int				nlmsvc_grace_period;
 unsigned long			nlmsvc_timeout;
 
@@ -112,6 +114,7 @@ lockd(struct svc_rqst *rqstp)
 	 * Let our maker know we're running.
 	 */
 	nlmsvc_pid = current->pid;
+	nlmsvc_serv = serv;
 	complete(&lockd_start_done);
 
 	daemonize("lockd");
@@ -189,6 +192,7 @@ lockd(struct svc_rqst *rqstp)
 			nlmsvc_invalidate_all();
 		nlm_shutdown_hosts();
 		nlmsvc_pid = 0;
+		nlmsvc_serv = NULL;
 	} else
 		printk(KERN_DEBUG
 			"lockd: new process, skipping host shutdown\n");
@@ -205,11 +209,42 @@ lockd(struct svc_rqst *rqstp)
 	module_put_and_exit(0);
 }
 
+
+static int find_socket(struct svc_serv *serv, int proto)
+{
+	struct svc_sock *svsk;
+	int found = 0;
+	list_for_each_entry(svsk, &serv->sv_permsocks, sk_list)
+		if (svsk->sk_sk->sk_protocol == proto) {
+			found = 1;
+			break;
+		}
+	return found;
+}
+
+static int make_socks(struct svc_serv *serv, int proto)
+{
+	/* Make any sockets that are needed but not present.
+	 * If nlm_udpport or nlm_tcpport were set as module
+	 * options, make those sockets unconditionally
+	 */
+	int err = 0;
+	if (proto == IPPROTO_UDP || nlm_udpport)
+		if (!find_socket(serv, IPPROTO_UDP))
+			err = svc_makesock(serv, IPPROTO_UDP, nlm_udpport);
+	if (err)
+		return err;
+	if (proto == IPPROTO_TCP || nlm_tcpport)
+		if (!find_socket(serv, IPPROTO_TCP))
+			err= svc_makesock(serv, IPPROTO_TCP, nlm_tcpport);
+	return err;
+}
+
 /*
  * Bring up the lockd process if it's not already up.
  */
 int
-lockd_up(void)
+lockd_up(int proto) /* Maybe add a 'family' option when IPv6 is supported ?? */
 {
 	static int		warned;
 	struct svc_serv *	serv;
@@ -224,8 +259,10 @@ lockd_up(void)
 	/*
 	 * Check whether we're already up and running.
 	 */
-	if (nlmsvc_pid)
+	if (nlmsvc_pid) {
+		error = make_socks(nlmsvc_serv, proto);
 		goto out;
+	}
 
 	/*
 	 * Sanity check: if there's no pid,
@@ -242,11 +279,7 @@ lockd_up(void)
 		goto out;
 	}
 
-	if ((error = svc_makesock(serv, IPPROTO_UDP, nlm_udpport)) < 0 
-#ifdef CONFIG_NFSD_TCP
-	 || (error = svc_makesock(serv, IPPROTO_TCP, nlm_tcpport)) < 0
-#endif
-		) {
+	if ((error = make_socks(serv, proto)) < 0) {
 		if (warned++ == 0) 
 			printk(KERN_WARNING
 				"lockd_up: makesock failed, error=%d\n", error);

diff .prev/fs/nfs/super.c ./fs/nfs/super.c
--- .prev/fs/nfs/super.c	2006-07-24 15:15:04.000000000 +1000
+++ ./fs/nfs/super.c	2006-07-24 15:15:04.000000000 +1000
@@ -869,7 +869,8 @@ nfs_fill_super(struct super_block *sb, s
 
 	/* Start lockd here, before we might error out */
 	if (!(server->flags & NFS_MOUNT_NONLM))
-		lockd_up();
+		lockd_up((server->flags & NFS_MOUNT_TCP)
+			 ? IPPROTO_TCP : IPPROTO_UDP);
 
 	server->namelen  = data->namlen;
 	server->hostname = kmalloc(strlen(data->hostname) + 1, GFP_KERNEL);
@@ -1112,7 +1113,8 @@ static struct super_block *nfs_clone_sb(
 	nfs_copy_fh(&server->fh, data->fh);
 	sb = sget(&nfs_fs_type, nfs_compare_super, nfs_set_super, server);
 	if (!IS_ERR(sb) && sb->s_root == NULL && !(server->flags & NFS_MOUNT_NONLM))
-		lockd_up();
+		lockd_up((server->flags & NFS_MOUNT_TCP)
+			 ? IPPROTO_TCP : IPPROTO_UDP);
 	return sb;
 }
 

diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
--- .prev/fs/nfsd/nfssvc.c	2006-07-24 15:14:31.000000000 +1000
+++ ./fs/nfsd/nfssvc.c	2006-07-24 15:15:04.000000000 +1000
@@ -134,6 +134,9 @@ static int killsig = 0; /* signal that w
 static void nfsd_last_thread(struct svc_serv *serv)
 {
 	/* When last nfsd thread exits we need to do some clean-up */
+	struct svc_sock *svsk;
+	list_for_each_entry(svsk, &serv->sv_permsocks, sk_list)
+		lockd_down();
 	nfsd_serv = NULL;
 	nfsd_racache_shutdown();
 	nfs4_state_shutdown();
@@ -218,11 +221,16 @@ nfsd_svc(unsigned short port, int nrserv
 		error = svc_makesock(nfsd_serv, IPPROTO_UDP, port);
 		if (error < 0)
 			goto failure;
-
+		error = lockd_up(IPPROTO_UDP);
+		if (error < 0)
+			goto failure;
 #ifdef CONFIG_NFSD_TCP
 		error = svc_makesock(nfsd_serv, IPPROTO_TCP, port);
 		if (error < 0)
 			goto failure;
+		error = lockd_up(IPPROTO_TCP);
+		if (error < 0)
+			goto failure;
 #endif
 		do_gettimeofday(&nfssvc_boot);		/* record boot time */
 	} else
@@ -306,8 +314,6 @@ nfsd(struct svc_rqst *rqstp)
 
 	nfsdstats.th_cnt++;
 
-	lockd_up();				/* start lockd */
-
 	me.task = current;
 	list_add(&me.list, &nfsd_list);
 
@@ -364,13 +370,11 @@ nfsd(struct svc_rqst *rqstp)
 				break;
 		killsig = signo;
 	}
-	/* Clear signals before calling lockd_down() and svc_exit_thread() */
+	/* Clear signals before calling svc_exit_thread() */
 	flush_signals(current);
 
 	lock_kernel();
 
-	/* Release lockd */
-	lockd_down();
 	list_del(&me.list);
 	nfsdstats.th_cnt --;
 

diff .prev/include/linux/lockd/bind.h ./include/linux/lockd/bind.h
--- .prev/include/linux/lockd/bind.h	2006-07-24 15:15:04.000000000 +1000
+++ ./include/linux/lockd/bind.h	2006-07-24 15:15:04.000000000 +1000
@@ -30,7 +30,7 @@ extern struct nlmsvc_binding *	nlmsvc_op
  * Functions exported by the lockd module
  */
 extern int	nlmclnt_proc(struct inode *, int, struct file_lock *);
-extern int	lockd_up(void);
+extern int	lockd_up(int proto);
 extern void	lockd_down(void);
 
 #endif /* LINUX_LOCKD_BIND_H */

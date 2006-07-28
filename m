Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWG1FKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWG1FKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 01:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWG1FKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 01:10:32 -0400
Received: from ns2.suse.de ([195.135.220.15]:46288 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932090AbWG1FK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 01:10:29 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Jul 2006 15:09:45 +1000
Message-Id: <1060728050945.361@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 4] knfsd: Drop 'serv' option to svc_recv and svc_process
References: <20060728150606.29533.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It isn't needed as it is available in rqstp->rq_server,
and dropping it allows some local vars to be dropped.

Cc: "J. Bruce Fields" <bfields@fieldses.org>

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/svc.c                 |    7 +++----
 ./fs/nfsd/nfssvc.c               |    6 ++----
 ./include/linux/sunrpc/svc.h     |    2 +-
 ./include/linux/sunrpc/svcsock.h |    2 +-
 ./net/sunrpc/svc.c               |    3 ++-
 ./net/sunrpc/svcsock.c           |    3 ++-
 6 files changed, 11 insertions(+), 12 deletions(-)

diff .prev/fs/lockd/svc.c ./fs/lockd/svc.c
--- .prev/fs/lockd/svc.c	2006-07-28 11:34:32.000000000 +1000
+++ ./fs/lockd/svc.c	2006-07-28 11:56:20.000000000 +1000
@@ -98,7 +98,6 @@ static inline void clear_grace_period(vo
 static void
 lockd(struct svc_rqst *rqstp)
 {
-	struct svc_serv	*serv = rqstp->rq_server;
 	int		err = 0;
 	unsigned long grace_period_expire;
 
@@ -114,7 +113,7 @@ lockd(struct svc_rqst *rqstp)
 	 * Let our maker know we're running.
 	 */
 	nlmsvc_pid = current->pid;
-	nlmsvc_serv = serv;
+	nlmsvc_serv = rqstp->rq_server;
 	complete(&lockd_start_done);
 
 	daemonize("lockd");
@@ -164,7 +163,7 @@ lockd(struct svc_rqst *rqstp)
 		 * Find a socket with data available and call its
 		 * recvfrom routine.
 		 */
-		err = svc_recv(serv, rqstp, timeout);
+		err = svc_recv(rqstp, timeout);
 		if (err == -EAGAIN || err == -EINTR)
 			continue;
 		if (err < 0) {
@@ -177,7 +176,7 @@ lockd(struct svc_rqst *rqstp)
 		dprintk("lockd: request from %08x\n",
 			(unsigned)ntohl(rqstp->rq_addr.sin_addr.s_addr));
 
-		svc_process(serv, rqstp);
+		svc_process(rqstp);
 
 	}
 

diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
--- .prev/fs/nfsd/nfssvc.c	2006-07-28 11:34:33.000000000 +1000
+++ ./fs/nfsd/nfssvc.c	2006-07-28 11:55:59.000000000 +1000
@@ -323,7 +323,6 @@ update_thread_usage(int busy_threads)
 static void
 nfsd(struct svc_rqst *rqstp)
 {
-	struct svc_serv	*serv = rqstp->rq_server;
 	struct fs_struct *fsp;
 	int		err;
 	struct nfsd_list me;
@@ -373,8 +372,7 @@ nfsd(struct svc_rqst *rqstp)
 		 * Find a socket with data available and call its
 		 * recvfrom routine.
 		 */
-		while ((err = svc_recv(serv, rqstp,
-				       60*60*HZ)) == -EAGAIN)
+		while ((err = svc_recv(rqstp, 60*60*HZ)) == -EAGAIN)
 			;
 		if (err < 0)
 			break;
@@ -387,7 +385,7 @@ nfsd(struct svc_rqst *rqstp)
 		/* Process request with signals blocked.  */
 		sigprocmask(SIG_SETMASK, &allowed_mask, NULL);
 
-		svc_process(serv, rqstp);
+		svc_process(rqstp);
 
 		/* Unlock export hash tables */
 		exp_readunlock();

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-07-28 11:34:32.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2006-07-28 11:54:16.000000000 +1000
@@ -321,7 +321,7 @@ struct svc_serv *  svc_create(struct svc
 int		   svc_create_thread(svc_thread_fn, struct svc_serv *);
 void		   svc_exit_thread(struct svc_rqst *);
 void		   svc_destroy(struct svc_serv *);
-int		   svc_process(struct svc_serv *, struct svc_rqst *);
+int		   svc_process(struct svc_rqst *);
 int		   svc_register(struct svc_serv *, int, unsigned short);
 void		   svc_wake_up(struct svc_serv *);
 void		   svc_reserve(struct svc_rqst *rqstp, int space);

diff .prev/include/linux/sunrpc/svcsock.h ./include/linux/sunrpc/svcsock.h
--- .prev/include/linux/sunrpc/svcsock.h	2006-07-28 11:34:33.000000000 +1000
+++ ./include/linux/sunrpc/svcsock.h	2006-07-28 11:54:40.000000000 +1000
@@ -57,7 +57,7 @@ struct svc_sock {
  */
 int		svc_makesock(struct svc_serv *, int, unsigned short);
 void		svc_delete_socket(struct svc_sock *);
-int		svc_recv(struct svc_serv *, struct svc_rqst *, long);
+int		svc_recv(struct svc_rqst *, long);
 int		svc_send(struct svc_rqst *);
 void		svc_drop(struct svc_rqst *);
 void		svc_sock_update_bufs(struct svc_serv *serv);

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2006-07-28 11:34:32.000000000 +1000
+++ ./net/sunrpc/svc.c	2006-07-28 11:53:47.000000000 +1000
@@ -253,13 +253,14 @@ svc_register(struct svc_serv *serv, int 
  * Process the RPC request.
  */
 int
-svc_process(struct svc_serv *serv, struct svc_rqst *rqstp)
+svc_process(struct svc_rqst *rqstp)
 {
 	struct svc_program	*progp;
 	struct svc_version	*versp = NULL;	/* compiler food */
 	struct svc_procedure	*procp = NULL;
 	struct kvec *		argv = &rqstp->rq_arg.head[0];
 	struct kvec *		resv = &rqstp->rq_res.head[0];
+	struct svc_serv		*serv = rqstp->rq_server;
 	kxdrproc_t		xdr;
 	u32			*statp;
 	u32			dir, prog, vers, proc,

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-07-28 11:34:33.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-07-28 11:55:15.000000000 +1000
@@ -1176,9 +1176,10 @@ svc_sock_update_bufs(struct svc_serv *se
  * Receive the next request on any socket.
  */
 int
-svc_recv(struct svc_serv *serv, struct svc_rqst *rqstp, long timeout)
+svc_recv(struct svc_rqst *rqstp, long timeout)
 {
 	struct svc_sock		*svsk =NULL;
+	struct svc_serv		*serv = rqstp->rq_server;
 	int			len;
 	int 			pages;
 	struct xdr_buf		*arg;

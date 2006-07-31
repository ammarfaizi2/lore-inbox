Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWGaAmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWGaAmO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWGaAmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:42:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39053 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932497AbWGaAl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:41:58 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 10:41:52 +1000
Message-Id: <1060731004152.29195@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 11] knfsd: convert sk_inuse to atomic_t
References: <20060731103458.29040.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Greg Banks <gnb@melbourne.sgi.com>

knfsd: Convert the svc_sock->sk_inuse counter from an int protected
by svc_serv->sv_lock, to an atomic.  This reduces the number of places
we need to take the (effectively global) svc_serv->sv_lock.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/sunrpc/svcsock.h |    2 +-
 ./net/sunrpc/svcsock.c           |   29 +++++++++++------------------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff .prev/include/linux/sunrpc/svcsock.h ./include/linux/sunrpc/svcsock.h
--- .prev/include/linux/sunrpc/svcsock.h	2006-07-31 09:56:44.000000000 +1000
+++ ./include/linux/sunrpc/svcsock.h	2006-07-31 09:58:07.000000000 +1000
@@ -21,7 +21,7 @@ struct svc_sock {
 	struct sock *		sk_sk;		/* INET layer */
 
 	struct svc_serv *	sk_server;	/* service for this socket */
-	unsigned int		sk_inuse;	/* use count */
+	atomic_t		sk_inuse;	/* use count */
 	unsigned long		sk_flags;
 #define	SK_BUSY		0			/* enqueued/receiving */
 #define	SK_CONN		1			/* conn pending */

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-07-31 09:56:44.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-07-31 09:58:07.000000000 +1000
@@ -206,7 +206,7 @@ svc_sock_enqueue(struct svc_sock *svsk)
 				"svc_sock_enqueue: server %p, rq_sock=%p!\n",
 				rqstp, rqstp->rq_sock);
 		rqstp->rq_sock = svsk;
-		svsk->sk_inuse++;
+		atomic_inc(&svsk->sk_inuse);
 		rqstp->rq_reserved = serv->sv_bufsz;
 		svsk->sk_reserved += rqstp->rq_reserved;
 		wake_up(&rqstp->rq_wait);
@@ -235,7 +235,7 @@ svc_sock_dequeue(struct svc_serv *serv)
 	list_del_init(&svsk->sk_ready);
 
 	dprintk("svc: socket %p dequeued, inuse=%d\n",
-		svsk->sk_sk, svsk->sk_inuse);
+		svsk->sk_sk, atomic_read(&svsk->sk_inuse));
 
 	return svsk;
 }
@@ -285,17 +285,11 @@ void svc_reserve(struct svc_rqst *rqstp,
 static inline void
 svc_sock_put(struct svc_sock *svsk)
 {
-	struct svc_serv *serv = svsk->sk_server;
-
-	spin_lock_bh(&serv->sv_lock);
-	if (!--(svsk->sk_inuse) && test_bit(SK_DEAD, &svsk->sk_flags)) {
-		spin_unlock_bh(&serv->sv_lock);
+	if (atomic_dec_and_test(&svsk->sk_inuse) && test_bit(SK_DEAD, &svsk->sk_flags)) {
 		dprintk("svc: releasing dead socket\n");
 		sock_release(svsk->sk_sock);
 		kfree(svsk);
 	}
-	else
-		spin_unlock_bh(&serv->sv_lock);
 }
 
 static void
@@ -907,7 +901,7 @@ svc_tcp_accept(struct svc_sock *svsk)
 					  struct svc_sock,
 					  sk_list);
 			set_bit(SK_CLOSE, &svsk->sk_flags);
-			svsk->sk_inuse ++;
+			atomic_inc(&svsk->sk_inuse);
 		}
 		spin_unlock_bh(&serv->sv_lock);
 
@@ -1239,7 +1233,7 @@ svc_recv(struct svc_rqst *rqstp, long ti
 	spin_lock_bh(&serv->sv_lock);
 	if ((svsk = svc_sock_dequeue(serv)) != NULL) {
 		rqstp->rq_sock = svsk;
-		svsk->sk_inuse++;
+		atomic_inc(&svsk->sk_inuse);
 		rqstp->rq_reserved = serv->sv_bufsz;	
 		svsk->sk_reserved += rqstp->rq_reserved;
 	} else {
@@ -1271,7 +1265,7 @@ svc_recv(struct svc_rqst *rqstp, long ti
 	spin_unlock_bh(&serv->sv_lock);
 
 	dprintk("svc: server %p, socket %p, inuse=%d\n",
-		 rqstp, svsk, svsk->sk_inuse);
+		 rqstp, svsk, atomic_read(&svsk->sk_inuse));
 	len = svsk->sk_recvfrom(rqstp);
 	dprintk("svc: got len=%d\n", len);
 
@@ -1367,9 +1361,9 @@ svc_age_temp_sockets(unsigned long closu
 
 		if (!test_and_set_bit(SK_OLD, &svsk->sk_flags))
 			continue;
-		if (svsk->sk_inuse || test_bit(SK_BUSY, &svsk->sk_flags))
+		if (atomic_read(&svsk->sk_inuse) || test_bit(SK_BUSY, &svsk->sk_flags))
 			continue;
-		svsk->sk_inuse++;
+		atomic_inc(&svsk->sk_inuse);
 		list_move(le, &to_be_aged);
 		set_bit(SK_CLOSE, &svsk->sk_flags);
 		set_bit(SK_DETACHED, &svsk->sk_flags);
@@ -1430,6 +1424,7 @@ svc_setup_socket(struct svc_serv *serv, 
 	svsk->sk_odata = inet->sk_data_ready;
 	svsk->sk_owspace = inet->sk_write_space;
 	svsk->sk_server = serv;
+	atomic_set(&svsk->sk_inuse, 0);
 	svsk->sk_lastrecv = get_seconds();
 	INIT_LIST_HEAD(&svsk->sk_deferred);
 	INIT_LIST_HEAD(&svsk->sk_ready);
@@ -1575,7 +1570,7 @@ svc_delete_socket(struct svc_sock *svsk)
 		if (test_bit(SK_TEMP, &svsk->sk_flags))
 			serv->sv_tmpcnt--;
 
-	if (!svsk->sk_inuse) {
+	if (!atomic_read(&svsk->sk_inuse)) {
 		spin_unlock_bh(&serv->sv_lock);
 		if (svsk->sk_sock->file)
 			sockfd_put(svsk->sk_sock);
@@ -1656,10 +1651,8 @@ svc_defer(struct cache_req *req)
 		dr->argslen = rqstp->rq_arg.len >> 2;
 		memcpy(dr->args, rqstp->rq_arg.head[0].iov_base-skip, dr->argslen<<2);
 	}
-	spin_lock_bh(&rqstp->rq_server->sv_lock);
-	rqstp->rq_sock->sk_inuse++;
+	atomic_inc(&rqstp->rq_sock->sk_inuse);
 	dr->svsk = rqstp->rq_sock;
-	spin_unlock_bh(&rqstp->rq_server->sv_lock);
 
 	dr->handle.revisit = svc_revisit;
 	return &dr->handle;

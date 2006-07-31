Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWGaAm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWGaAm4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWGaAmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:42:32 -0400
Received: from cantor2.suse.de ([195.135.220.15]:43405 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964798AbWGaAmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:42:19 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 10:42:13 +1000
Message-Id: <1060731004213.29243@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 11] knfsd: split svc_serv into pools
References: <20060731103458.29040.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Greg Banks <gnb@melbourne.sgi.com>

knfsd: Split out the list of idle threads and pending sockets from
svc_serv into a new svc_pool structure, and allocate a fixed number
(in this patch, 1) of pools per svc_serv.  The new structure contains
a lock which takes over several of the duties of svc_serv->sv_lock,
which is now relegated to protecting only sv_tempsocks, sv_permsocks,
and sv_tmpcnt in svc_serv.

The point is to move the hottest fields out of svc_serv and into
svc_pool, allowing a following patch to arrange for a svc_pool per
NUMA node or per CPU.   This is a major step towards making the NFS
server NUMA-friendly.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/sunrpc/svc.h     |   25 +++++++
 ./include/linux/sunrpc/svcsock.h |    1 
 ./net/sunrpc/svc.c               |   56 +++++++++++++++--
 ./net/sunrpc/svcsock.c           |  123 +++++++++++++++++++++++++--------------
 4 files changed, 152 insertions(+), 53 deletions(-)

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-07-31 10:19:58.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2006-07-31 10:14:54.000000000 +1000
@@ -17,6 +17,25 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 
+
+/*
+ *
+ * RPC service thread pool.
+ *
+ * Pool of threads and temporary sockets.  Generally there is only
+ * a single one of these per RPC service, but on NUMA machines those
+ * services that can benefit from it (i.e. nfs but not lockd) will
+ * have one pool per NUMA node.  This optimisation reduces cross-
+ * node traffic on multi-node NUMA NFS servers.
+ */
+struct svc_pool {
+	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
+	spinlock_t		sp_lock;	/* protects all fields */
+	struct list_head	sp_threads;	/* idle server threads */
+	struct list_head	sp_sockets;	/* pending sockets */
+	unsigned int		sp_nrthreads;	/* # of threads in pool */
+} ____cacheline_aligned_in_smp;
+
 /*
  * RPC service.
  *
@@ -28,8 +47,6 @@
  * We currently do not support more than one RPC program per daemon.
  */
 struct svc_serv {
-	struct list_head	sv_threads;	/* idle server threads */
-	struct list_head	sv_sockets;	/* pending sockets */
 	struct svc_program *	sv_program;	/* RPC program */
 	struct svc_stat *	sv_stats;	/* RPC statistics */
 	spinlock_t		sv_lock;
@@ -44,6 +61,9 @@ struct svc_serv {
 
 	char *			sv_name;	/* service name */
 
+	unsigned int		sv_nrpools;	/* number of thread pools */
+	struct svc_pool *	sv_pools;	/* array of thread pools */
+
 	void			(*sv_shutdown)(struct svc_serv *serv);
 						/* Callback to use when last thread
 						 * exits.
@@ -121,6 +141,7 @@ struct svc_rqst {
 	int			rq_addrlen;
 
 	struct svc_serv *	rq_server;	/* RPC service definition */
+	struct svc_pool *	rq_pool;	/* thread pool */
 	struct svc_procedure *	rq_procinfo;	/* procedure info */
 	struct auth_ops *	rq_authop;	/* authentication flavour */
 	struct svc_cred		rq_cred;	/* auth info */

diff .prev/include/linux/sunrpc/svcsock.h ./include/linux/sunrpc/svcsock.h
--- .prev/include/linux/sunrpc/svcsock.h	2006-07-31 10:19:58.000000000 +1000
+++ ./include/linux/sunrpc/svcsock.h	2006-07-31 10:14:54.000000000 +1000
@@ -20,6 +20,7 @@ struct svc_sock {
 	struct socket *		sk_sock;	/* berkeley socket layer */
 	struct sock *		sk_sk;		/* INET layer */
 
+	struct svc_pool *	sk_pool;	/* current pool iff queued */
 	struct svc_serv *	sk_server;	/* service for this socket */
 	atomic_t		sk_inuse;	/* use count */
 	unsigned long		sk_flags;

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2006-07-31 10:19:58.000000000 +1000
+++ ./net/sunrpc/svc.c	2006-07-31 10:20:33.000000000 +1000
@@ -32,6 +32,7 @@ svc_create(struct svc_program *prog, uns
 	struct svc_serv	*serv;
 	int vers;
 	unsigned int xdrsize;
+	unsigned int i;
 
 	if (!(serv = kzalloc(sizeof(*serv), GFP_KERNEL)))
 		return NULL;
@@ -55,13 +56,33 @@ svc_create(struct svc_program *prog, uns
 		prog = prog->pg_next;
 	}
 	serv->sv_xdrsize   = xdrsize;
-	INIT_LIST_HEAD(&serv->sv_threads);
-	INIT_LIST_HEAD(&serv->sv_sockets);
 	INIT_LIST_HEAD(&serv->sv_tempsocks);
 	INIT_LIST_HEAD(&serv->sv_permsocks);
 	init_timer(&serv->sv_temptimer);
 	spin_lock_init(&serv->sv_lock);
 
+	serv->sv_nrpools = 1;
+	serv->sv_pools =
+		kcalloc(sizeof(struct svc_pool), serv->sv_nrpools,
+			GFP_KERNEL);
+	if (!serv->sv_pools) {
+		kfree(serv);
+		return NULL;
+	}
+
+	for (i = 0 ; i < serv->sv_nrpools ; i++) {
+		struct svc_pool *pool = &serv->sv_pools[i];
+
+		dprintk("initialising pool %u for %s\n",
+				i, serv->sv_name);
+
+		pool->sp_id = i;
+		INIT_LIST_HEAD(&pool->sp_threads);
+		INIT_LIST_HEAD(&pool->sp_sockets);
+		spin_lock_init(&pool->sp_lock);
+	}
+
+
 	/* Remove any stale portmap registrations */
 	svc_register(serv, 0, 0);
 
@@ -69,7 +90,7 @@ svc_create(struct svc_program *prog, uns
 }
 
 /*
- * Destroy an RPC service
+ * Destroy an RPC service.  Should be called with the BKL held
  */
 void
 svc_destroy(struct svc_serv *serv)
@@ -110,6 +131,7 @@ svc_destroy(struct svc_serv *serv)
 
 	/* Unregister service with the portmapper */
 	svc_register(serv, 0, 0);
+	kfree(serv->sv_pools);
 	kfree(serv);
 }
 
@@ -158,10 +180,11 @@ svc_release_buffer(struct svc_rqst *rqst
 }
 
 /*
- * Create a server thread
+ * Create a thread in the given pool.  Caller must hold BKL.
  */
-int
-svc_create_thread(svc_thread_fn func, struct svc_serv *serv)
+static int
+__svc_create_thread(svc_thread_fn func, struct svc_serv *serv,
+		    struct svc_pool *pool)
 {
 	struct svc_rqst	*rqstp;
 	int		error = -ENOMEM;
@@ -178,7 +201,11 @@ svc_create_thread(svc_thread_fn func, st
 		goto out_thread;
 
 	serv->sv_nrthreads++;
+	spin_lock_bh(&pool->sp_lock);
+	pool->sp_nrthreads++;
+	spin_unlock_bh(&pool->sp_lock);
 	rqstp->rq_server = serv;
+	rqstp->rq_pool = pool;
 	error = kernel_thread((int (*)(void *)) func, rqstp, 0);
 	if (error < 0)
 		goto out_thread;
@@ -193,17 +220,32 @@ out_thread:
 }
 
 /*
- * Destroy an RPC server thread
+ * Create a thread in the default pool.  Caller must hold BKL.
+ */
+int
+svc_create_thread(svc_thread_fn func, struct svc_serv *serv)
+{
+	return __svc_create_thread(func, serv, &serv->sv_pools[0]);
+}
+
+/*
+ * Called from a server thread as it's exiting.  Caller must hold BKL.
  */
 void
 svc_exit_thread(struct svc_rqst *rqstp)
 {
 	struct svc_serv	*serv = rqstp->rq_server;
+	struct svc_pool	*pool = rqstp->rq_pool;
 
 	svc_release_buffer(rqstp);
 	kfree(rqstp->rq_resp);
 	kfree(rqstp->rq_argp);
 	kfree(rqstp->rq_auth_data);
+
+	spin_lock_bh(&pool->sp_lock);
+	pool->sp_nrthreads--;
+	spin_unlock_bh(&pool->sp_lock);
+
 	kfree(rqstp);
 
 	/* Release the server */

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-07-31 10:19:58.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-07-31 10:15:26.000000000 +1000
@@ -46,7 +46,10 @@
 
 /* SMP locking strategy:
  *
- *	svc_serv->sv_lock protects most stuff for that service.
+ *	svc_pool->sp_lock protects most of the fields of that pool.
+ * 	svc_serv->sv_lock protects sv_tempsocks, sv_permsocks, sv_tmpcnt.
+ *	when both need to be taken (rare), svc_serv->sv_lock is first.
+ *	BKL protects svc_serv->sv_nrthread, svc_pool->sp_nrthread
  *	svc_sock->sk_defer_lock protects the svc_sock->sk_deferred list
  *	svc_sock->sk_flags.SK_BUSY prevents a svc_sock being enqueued multiply.
  *
@@ -82,22 +85,22 @@ static struct cache_deferred_req *svc_de
 static int svc_conn_age_period = 6*60;
 
 /*
- * Queue up an idle server thread.  Must have serv->sv_lock held.
+ * Queue up an idle server thread.  Must have pool->sp_lock held.
  * Note: this is really a stack rather than a queue, so that we only
- * use as many different threads as we need, and the rest don't polute
+ * use as many different threads as we need, and the rest don't pollute
  * the cache.
  */
 static inline void
-svc_serv_enqueue(struct svc_serv *serv, struct svc_rqst *rqstp)
+svc_thread_enqueue(struct svc_pool *pool, struct svc_rqst *rqstp)
 {
-	list_add(&rqstp->rq_list, &serv->sv_threads);
+	list_add(&rqstp->rq_list, &pool->sp_threads);
 }
 
 /*
- * Dequeue an nfsd thread.  Must have serv->sv_lock held.
+ * Dequeue an nfsd thread.  Must have pool->sp_lock held.
  */
 static inline void
-svc_serv_dequeue(struct svc_serv *serv, struct svc_rqst *rqstp)
+svc_thread_dequeue(struct svc_pool *pool, struct svc_rqst *rqstp)
 {
 	list_del(&rqstp->rq_list);
 }
@@ -148,6 +151,7 @@ static void
 svc_sock_enqueue(struct svc_sock *svsk)
 {
 	struct svc_serv	*serv = svsk->sk_server;
+	struct svc_pool *pool = &serv->sv_pools[0];
 	struct svc_rqst	*rqstp;
 
 	if (!(svsk->sk_flags &
@@ -156,10 +160,10 @@ svc_sock_enqueue(struct svc_sock *svsk)
 	if (test_bit(SK_DEAD, &svsk->sk_flags))
 		return;
 
-	spin_lock_bh(&serv->sv_lock);
+	spin_lock_bh(&pool->sp_lock);
 
-	if (!list_empty(&serv->sv_threads) && 
-	    !list_empty(&serv->sv_sockets))
+	if (!list_empty(&pool->sp_threads) &&
+	    !list_empty(&pool->sp_sockets))
 		printk(KERN_ERR
 			"svc_sock_enqueue: threads and sockets both waiting??\n");
 
@@ -179,6 +183,8 @@ svc_sock_enqueue(struct svc_sock *svsk)
 		dprintk("svc: socket %p busy, not enqueued\n", svsk->sk_sk);
 		goto out_unlock;
 	}
+	BUG_ON(svsk->sk_pool != NULL);
+	svsk->sk_pool = pool;
 
 	set_bit(SOCK_NOSPACE, &svsk->sk_sock->flags);
 	if (((atomic_read(&svsk->sk_reserved) + serv->sv_bufsz)*2
@@ -189,19 +195,20 @@ svc_sock_enqueue(struct svc_sock *svsk)
 		dprintk("svc: socket %p  no space, %d*2 > %ld, not enqueued\n",
 			svsk->sk_sk, atomic_read(&svsk->sk_reserved)+serv->sv_bufsz,
 			svc_sock_wspace(svsk));
+		svsk->sk_pool = NULL;
 		clear_bit(SK_BUSY, &svsk->sk_flags);
 		goto out_unlock;
 	}
 	clear_bit(SOCK_NOSPACE, &svsk->sk_sock->flags);
 
 
-	if (!list_empty(&serv->sv_threads)) {
-		rqstp = list_entry(serv->sv_threads.next,
+	if (!list_empty(&pool->sp_threads)) {
+		rqstp = list_entry(pool->sp_threads.next,
 				   struct svc_rqst,
 				   rq_list);
 		dprintk("svc: socket %p served by daemon %p\n",
 			svsk->sk_sk, rqstp);
-		svc_serv_dequeue(serv, rqstp);
+		svc_thread_dequeue(pool, rqstp);
 		if (rqstp->rq_sock)
 			printk(KERN_ERR 
 				"svc_sock_enqueue: server %p, rq_sock=%p!\n",
@@ -210,28 +217,30 @@ svc_sock_enqueue(struct svc_sock *svsk)
 		atomic_inc(&svsk->sk_inuse);
 		rqstp->rq_reserved = serv->sv_bufsz;
 		atomic_add(rqstp->rq_reserved, &svsk->sk_reserved);
+		BUG_ON(svsk->sk_pool != pool);
 		wake_up(&rqstp->rq_wait);
 	} else {
 		dprintk("svc: socket %p put into queue\n", svsk->sk_sk);
-		list_add_tail(&svsk->sk_ready, &serv->sv_sockets);
+		list_add_tail(&svsk->sk_ready, &pool->sp_sockets);
+		BUG_ON(svsk->sk_pool != pool);
 	}
 
 out_unlock:
-	spin_unlock_bh(&serv->sv_lock);
+	spin_unlock_bh(&pool->sp_lock);
 }
 
 /*
- * Dequeue the first socket.  Must be called with the serv->sv_lock held.
+ * Dequeue the first socket.  Must be called with the pool->sp_lock held.
  */
 static inline struct svc_sock *
-svc_sock_dequeue(struct svc_serv *serv)
+svc_sock_dequeue(struct svc_pool *pool)
 {
 	struct svc_sock	*svsk;
 
-	if (list_empty(&serv->sv_sockets))
+	if (list_empty(&pool->sp_sockets))
 		return NULL;
 
-	svsk = list_entry(serv->sv_sockets.next,
+	svsk = list_entry(pool->sp_sockets.next,
 			  struct svc_sock, sk_ready);
 	list_del_init(&svsk->sk_ready);
 
@@ -250,6 +259,7 @@ svc_sock_dequeue(struct svc_serv *serv)
 static inline void
 svc_sock_received(struct svc_sock *svsk)
 {
+	svsk->sk_pool = NULL;
 	clear_bit(SK_BUSY, &svsk->sk_flags);
 	svc_sock_enqueue(svsk);
 }
@@ -322,25 +332,33 @@ svc_sock_release(struct svc_rqst *rqstp)
 
 /*
  * External function to wake up a server waiting for data
+ * This really only makes sense for services like lockd
+ * which have exactly one thread anyway.
  */
 void
 svc_wake_up(struct svc_serv *serv)
 {
 	struct svc_rqst	*rqstp;
+	unsigned int i;
+	struct svc_pool *pool;
 
-	spin_lock_bh(&serv->sv_lock);
-	if (!list_empty(&serv->sv_threads)) {
-		rqstp = list_entry(serv->sv_threads.next,
-				   struct svc_rqst,
-				   rq_list);
-		dprintk("svc: daemon %p woken up.\n", rqstp);
-		/*
-		svc_serv_dequeue(serv, rqstp);
-		rqstp->rq_sock = NULL;
-		 */
-		wake_up(&rqstp->rq_wait);
+	for (i = 0 ; i < serv->sv_nrpools ; i++) {
+		pool = &serv->sv_pools[i];
+
+		spin_lock_bh(&pool->sp_lock);
+		if (!list_empty(&pool->sp_threads)) {
+			rqstp = list_entry(pool->sp_threads.next,
+					   struct svc_rqst,
+					   rq_list);
+			dprintk("svc: daemon %p woken up.\n", rqstp);
+			/*
+			svc_thread_dequeue(pool, rqstp);
+			rqstp->rq_sock = NULL;
+			 */
+			wake_up(&rqstp->rq_wait);
+		}
+		spin_unlock_bh(&pool->sp_lock);
 	}
-	spin_unlock_bh(&serv->sv_lock);
 }
 
 /*
@@ -606,7 +624,10 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
 	    /* udp sockets need large rcvbuf as all pending
 	     * requests are still in that buffer.  sndbuf must
 	     * also be large enough that there is enough space
-	     * for one reply per thread.
+	     * for one reply per thread.  We count all threads
+	     * rather than threads in a particular pool, which
+	     * provides an upper bound on the number of threads
+	     * which will access the socket.
 	     */
 	    svc_sock_setbufsize(svsk->sk_sock,
 				(serv->sv_nrthreads+3) * serv->sv_bufsz,
@@ -958,6 +979,11 @@ svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		/* sndbuf needs to have room for one request
 		 * per thread, otherwise we can stall even when the
 		 * network isn't a bottleneck.
+		 *
+		 * We count all threads rather than threads in a
+		 * particular pool, which provides an upper bound
+		 * on the number of threads which will access the socket.
+		 *
 		 * rcvbuf just needs to be able to hold a few requests.
 		 * Normally they will be removed from the queue 
 		 * as soon a a complete request arrives.
@@ -1173,13 +1199,16 @@ svc_sock_update_bufs(struct svc_serv *se
 }
 
 /*
- * Receive the next request on any socket.
+ * Receive the next request on any socket.  This code is carefully
+ * organised not to touch any cachelines in the shared svc_serv
+ * structure, only cachelines in the local svc_pool.
  */
 int
 svc_recv(struct svc_rqst *rqstp, long timeout)
 {
 	struct svc_sock		*svsk =NULL;
 	struct svc_serv		*serv = rqstp->rq_server;
+	struct svc_pool		*pool = rqstp->rq_pool;
 	int			len;
 	int 			pages;
 	struct xdr_buf		*arg;
@@ -1229,15 +1258,15 @@ svc_recv(struct svc_rqst *rqstp, long ti
 	if (signalled())
 		return -EINTR;
 
-	spin_lock_bh(&serv->sv_lock);
-	if ((svsk = svc_sock_dequeue(serv)) != NULL) {
+	spin_lock_bh(&pool->sp_lock);
+	if ((svsk = svc_sock_dequeue(pool)) != NULL) {
 		rqstp->rq_sock = svsk;
 		atomic_inc(&svsk->sk_inuse);
 		rqstp->rq_reserved = serv->sv_bufsz;	
 		atomic_add(rqstp->rq_reserved, &svsk->sk_reserved);
 	} else {
 		/* No data pending. Go to sleep */
-		svc_serv_enqueue(serv, rqstp);
+		svc_thread_enqueue(pool, rqstp);
 
 		/*
 		 * We have to be able to interrupt this wait
@@ -1245,26 +1274,26 @@ svc_recv(struct svc_rqst *rqstp, long ti
 		 */
 		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&rqstp->rq_wait, &wait);
-		spin_unlock_bh(&serv->sv_lock);
+		spin_unlock_bh(&pool->sp_lock);
 
 		schedule_timeout(timeout);
 
 		try_to_freeze();
 
-		spin_lock_bh(&serv->sv_lock);
+		spin_lock_bh(&pool->sp_lock);
 		remove_wait_queue(&rqstp->rq_wait, &wait);
 
 		if (!(svsk = rqstp->rq_sock)) {
-			svc_serv_dequeue(serv, rqstp);
-			spin_unlock_bh(&serv->sv_lock);
+			svc_thread_dequeue(pool, rqstp);
+			spin_unlock_bh(&pool->sp_lock);
 			dprintk("svc: server %p, no data yet\n", rqstp);
 			return signalled()? -EINTR : -EAGAIN;
 		}
 	}
-	spin_unlock_bh(&serv->sv_lock);
+	spin_unlock_bh(&pool->sp_lock);
 
-	dprintk("svc: server %p, socket %p, inuse=%d\n",
-		 rqstp, svsk, atomic_read(&svsk->sk_inuse));
+	dprintk("svc: server %p, pool %u, socket %p, inuse=%d\n",
+		 rqstp, pool->sp_id, svsk, atomic_read(&svsk->sk_inuse));
 	len = svsk->sk_recvfrom(rqstp);
 	dprintk("svc: got len=%d\n", len);
 
@@ -1565,7 +1594,13 @@ svc_delete_socket(struct svc_sock *svsk)
 
 	if (!test_and_set_bit(SK_DETACHED, &svsk->sk_flags))
 		list_del_init(&svsk->sk_list);
-	list_del_init(&svsk->sk_ready);
+    	/*
+	 * We used to delete the svc_sock from whichever list
+	 * it's sk_ready node was on, but we don't actually
+	 * need to.  This is because the only time we're called
+	 * while still attached to a queue, the queue itself
+	 * is about to be destroyed (in svc_destroy).
+	 */
 	if (!test_and_set_bit(SK_DEAD, &svsk->sk_flags))
 		if (test_bit(SK_TEMP, &svsk->sk_flags))
 			serv->sv_tmpcnt--;

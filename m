Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSKIDFI>; Fri, 8 Nov 2002 22:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264621AbSKIDFI>; Fri, 8 Nov 2002 22:05:08 -0500
Received: from mons.uio.no ([129.240.130.14]:44004 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S264620AbSKIDFC>;
	Fri, 8 Nov 2002 22:05:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15820.31982.708166.863447@charged.uio.no>
Date: Sat, 9 Nov 2002 04:11:42 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] slabify the sunrpc layer
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In order to better cope with low memory conditions, add slabs for
struct rpc_task and 'small' RPC buffers of <= 2k. Protect these using
mempools.

The only case where we appear to use buffers of > 2k is when
symlinking, and is due to the fact that the path can be up to 4k in
length. For the moment, we just use kmalloc(), but it may be worth it
some time in the near future to convert nfs_symlink() to use pages.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.46-05-mempool/include/linux/sunrpc/sched.h linux-2.5.46-06-rpcbuf/include/linux/sunrpc/sched.h
--- linux-2.5.46-05-mempool/include/linux/sunrpc/sched.h	2002-10-01 04:54:49.000000000 -0400
+++ linux-2.5.46-06-rpcbuf/include/linux/sunrpc/sched.h	2002-11-08 20:22:24.000000000 -0500
@@ -48,6 +48,7 @@
 	 */
 	struct rpc_message	tk_msg;		/* RPC call info */
 	__u32 *			tk_buffer;	/* XDR buffer */
+	size_t			tk_bufsize;
 	__u8			tk_garb_retry,
 				tk_cred_retry,
 				tk_suid_retry;
@@ -184,20 +185,16 @@
 struct rpc_task *rpc_wake_up_next(struct rpc_wait_queue *);
 void		rpc_wake_up_status(struct rpc_wait_queue *, int);
 void		rpc_delay(struct rpc_task *, unsigned long);
-void *		rpc_allocate(unsigned int flags, unsigned int);
-void		rpc_free(void *);
+void *		rpc_malloc(struct rpc_task *, size_t);
+void		rpc_free(struct rpc_task *);
 int		rpciod_up(void);
 void		rpciod_down(void);
 void		rpciod_wake_up(void);
 #ifdef RPC_DEBUG
 void		rpc_show_tasks(void);
 #endif
-
-static __inline__ void *
-rpc_malloc(struct rpc_task *task, unsigned int size)
-{
-	return rpc_allocate(task->tk_flags, size);
-}
+int		rpc_init_mempool(void);
+void		rpc_destroy_mempool(void);
 
 static __inline__ void
 rpc_exit(struct rpc_task *task, int status)
diff -u --recursive --new-file linux-2.5.46-05-mempool/net/sunrpc/auth_null.c linux-2.5.46-06-rpcbuf/net/sunrpc/auth_null.c
--- linux-2.5.46-05-mempool/net/sunrpc/auth_null.c	2002-10-07 10:44:54.000000000 -0400
+++ linux-2.5.46-06-rpcbuf/net/sunrpc/auth_null.c	2002-11-08 18:29:45.000000000 -0500
@@ -25,7 +25,7 @@
 	struct rpc_auth	*auth;
 
 	dprintk("RPC: creating NULL authenticator for client %p\n", clnt);
-	if (!(auth = (struct rpc_auth *) rpc_allocate(0, sizeof(*auth))))
+	if (!(auth = (struct rpc_auth *) kmalloc(sizeof(*auth),GFP_KERNEL)))
 		return NULL;
 	auth->au_cslack = 4;
 	auth->au_rslack = 2;
@@ -41,7 +41,7 @@
 {
 	dprintk("RPC: destroying NULL authenticator %p\n", auth);
 	rpcauth_free_credcache(auth);
-	rpc_free(auth);
+	kfree(auth);
 }
 
 /*
@@ -52,7 +52,7 @@
 {
 	struct rpc_cred	*cred;
 
-	if (!(cred = (struct rpc_cred *) rpc_allocate(flags, sizeof(*cred))))
+	if (!(cred = (struct rpc_cred *) kmalloc(sizeof(*cred),GFP_KERNEL)))
 		return NULL;
 	atomic_set(&cred->cr_count, 0);
 	cred->cr_flags = RPCAUTH_CRED_UPTODATE;
@@ -68,7 +68,7 @@
 static void
 nul_destroy_cred(struct rpc_cred *cred)
 {
-	rpc_free(cred);
+	kfree(cred);
 }
 
 /*
diff -u --recursive --new-file linux-2.5.46-05-mempool/net/sunrpc/auth_unix.c linux-2.5.46-06-rpcbuf/net/sunrpc/auth_unix.c
--- linux-2.5.46-05-mempool/net/sunrpc/auth_unix.c	2002-10-07 10:44:54.000000000 -0400
+++ linux-2.5.46-06-rpcbuf/net/sunrpc/auth_unix.c	2002-11-08 18:55:56.000000000 -0500
@@ -41,7 +41,7 @@
 	struct rpc_auth	*auth;
 
 	dprintk("RPC: creating UNIX authenticator for client %p\n", clnt);
-	if (!(auth = (struct rpc_auth *) rpc_allocate(0, sizeof(*auth))))
+	if (!(auth = (struct rpc_auth *) kmalloc(sizeof(*auth), GFP_KERNEL)))
 		return NULL;
 	auth->au_cslack = UNX_WRITESLACK;
 	auth->au_rslack = 2;	/* assume AUTH_NULL verf */
@@ -58,7 +58,7 @@
 {
 	dprintk("RPC: destroying UNIX authenticator %p\n", auth);
 	rpcauth_free_credcache(auth);
-	rpc_free(auth);
+	kfree(auth);
 }
 
 static struct rpc_cred *
@@ -70,7 +70,7 @@
 	dprintk("RPC:      allocating UNIX cred for uid %d gid %d\n",
 				current->uid, current->gid);
 
-	if (!(cred = (struct unx_cred *) rpc_allocate(flags, sizeof(*cred))))
+	if (!(cred = (struct unx_cred *) kmalloc(sizeof(*cred), GFP_KERNEL)))
 		return NULL;
 
 	atomic_set(&cred->uc_count, 0);
@@ -98,32 +98,10 @@
 	return (struct rpc_cred *) cred;
 }
 
-struct rpc_cred *
-authunix_fake_cred(struct rpc_task *task, uid_t uid, gid_t gid)
-{
-	struct unx_cred	*cred;
-
-	dprintk("RPC:      allocating fake UNIX cred for uid %d gid %d\n",
-				uid, gid);
-
-	if (!(cred = (struct unx_cred *) rpc_malloc(task, sizeof(*cred))))
-		return NULL;
-
-	atomic_set(&cred->uc_count, 1);
-	cred->uc_flags = RPCAUTH_CRED_DEAD|RPCAUTH_CRED_UPTODATE;
-	cred->uc_uid   = uid;
-	cred->uc_gid   = gid;
-	cred->uc_fsuid = uid;
-	cred->uc_fsgid = gid;
-	cred->uc_gids[0] = (gid_t) NOGROUP;
-
-	return task->tk_msg.rpc_cred = (struct rpc_cred *) cred;
-}
-
 static void
 unx_destroy_cred(struct rpc_cred *cred)
 {
-	rpc_free(cred);
+	kfree(cred);
 }
 
 /*
diff -u --recursive --new-file linux-2.5.46-05-mempool/net/sunrpc/clnt.c linux-2.5.46-06-rpcbuf/net/sunrpc/clnt.c
--- linux-2.5.46-05-mempool/net/sunrpc/clnt.c	2002-09-29 10:15:28.000000000 -0400
+++ linux-2.5.46-06-rpcbuf/net/sunrpc/clnt.c	2002-11-08 20:50:06.000000000 -0500
@@ -85,7 +85,7 @@
 	if (vers >= program->nrvers || !(version = program->version[vers]))
 		goto out;
 
-	clnt = (struct rpc_clnt *) rpc_allocate(0, sizeof(*clnt));
+	clnt = (struct rpc_clnt *) kmalloc(sizeof(*clnt), GFP_KERNEL);
 	if (!clnt)
 		goto out_no_clnt;
 	memset(clnt, 0, sizeof(*clnt));
@@ -125,7 +125,7 @@
 out_no_auth:
 	printk(KERN_INFO "RPC: Couldn't create auth handle (flavor %u)\n",
 		flavor);
-	rpc_free(clnt);
+	kfree(clnt);
 	clnt = NULL;
 	goto out;
 }
@@ -180,7 +180,7 @@
 		xprt_destroy(clnt->cl_xprt);
 		clnt->cl_xprt = NULL;
 	}
-	rpc_free(clnt);
+	kfree(clnt);
 	return 0;
 }
 
@@ -487,7 +487,7 @@
 	 * auth->au_wslack */
 	bufsiz = rpcproc_bufsiz(clnt, task->tk_msg.rpc_proc) + RPC_SLACK_SPACE;
 
-	if ((task->tk_buffer = rpc_malloc(task, bufsiz << 1)) != NULL)
+	if (rpc_malloc(task, bufsiz << 1) != NULL)
 		return;
 	printk(KERN_INFO "RPC: buffer allocation failed for task %p\n", task); 
 
@@ -522,7 +522,7 @@
 	task->tk_action = call_bind;
 
 	/* Default buffer setup */
-	bufsiz = rpcproc_bufsiz(clnt, task->tk_msg.rpc_proc)+RPC_SLACK_SPACE;
+	bufsiz = task->tk_bufsize >> 1;
 	sndbuf->head[0].iov_base = (void *)task->tk_buffer;
 	sndbuf->head[0].iov_len  = bufsiz;
 	sndbuf->tail[0].iov_len  = 0;
diff -u --recursive --new-file linux-2.5.46-05-mempool/net/sunrpc/sched.c linux-2.5.46-06-rpcbuf/net/sunrpc/sched.c
--- linux-2.5.46-05-mempool/net/sunrpc/sched.c	2002-09-29 10:15:30.000000000 -0400
+++ linux-2.5.46-06-rpcbuf/net/sunrpc/sched.c	2002-11-08 20:47:26.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/mempool.h>
 #include <linux/unistd.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
@@ -29,9 +30,15 @@
 #endif
 
 /*
- * We give RPC the same get_free_pages priority as NFS
+ * RPC slabs and memory pools
  */
-#define GFP_RPC			GFP_NOFS
+#define RPC_BUFFER_MAXSIZE	(2048)
+#define RPC_BUFFER_POOLSIZE	(8)
+#define RPC_TASK_POOLSIZE	(8)
+static kmem_cache_t	*rpc_task_slabp;
+static kmem_cache_t	*rpc_buffer_slabp;
+static mempool_t	*rpc_task_mempool;
+static mempool_t	*rpc_buffer_mempool;
 
 static void			__rpc_default_timer(struct rpc_task *task);
 static void			rpciod_killall(void);
@@ -80,24 +87,6 @@
 static spinlock_t rpc_sched_lock = SPIN_LOCK_UNLOCKED;
 
 /*
- * This is the last-ditch buffer for NFS swap requests
- */
-static u32			swap_buffer[PAGE_SIZE >> 2];
-static long			swap_buffer_used;
-
-/*
- * Make allocation of the swap_buffer SMP-safe
- */
-static __inline__ int rpc_lock_swapbuf(void)
-{
-	return !test_and_set_bit(1, &swap_buffer_used);
-}
-static __inline__ void rpc_unlock_swapbuf(void)
-{
-	clear_bit(1, &swap_buffer_used);
-}
-
-/*
  * Disable the timer for a given RPC task. Should be called with
  * rpc_queue_lock and bh_disabled in order to avoid races within
  * rpc_run_timer().
@@ -592,10 +581,7 @@
 				/* Release RPC slot and buffer memory */
 				if (task->tk_rqstp)
 					xprt_release(task);
-				if (task->tk_buffer) {
-					rpc_free(task->tk_buffer);
-					task->tk_buffer = NULL;
-				}
+				rpc_free(task);
 				goto restarted;
 			}
 			printk(KERN_ERR "RPC: dead task tries to walk away.\n");
@@ -676,63 +662,46 @@
 }
 
 /*
- * Allocate memory for RPC purpose.
+ * Allocate memory for RPC purposes.
  *
- * This is yet another tricky issue: For sync requests issued by
- * a user process, we want to make kmalloc sleep if there isn't
- * enough memory. Async requests should not sleep too excessively
- * because that will block rpciod (but that's not dramatic when
- * it's starved of memory anyway). Finally, swapout requests should
- * never sleep at all, and should not trigger another swap_out
- * request through kmalloc which would just increase memory contention.
- *
- * I hope the following gets it right, which gives async requests
- * a slight advantage over sync requests (good for writeback, debatable
- * for readahead):
- *
- *   sync user requests:	GFP_KERNEL
- *   async requests:		GFP_RPC		(== GFP_NOFS)
- *   swap requests:		GFP_ATOMIC	(or new GFP_SWAPPER)
+ * We try to ensure that some NFS reads and writes can always proceed
+ * by using a mempool when allocating 'small' buffers.
+ * In order to avoid memory starvation triggering more writebacks of
+ * NFS requests, we use GFP_NOFS rather than GFP_KERNEL.
  */
 void *
-rpc_allocate(unsigned int flags, unsigned int size)
+rpc_malloc(struct rpc_task *task, size_t size)
 {
-	u32	*buffer;
 	int	gfp;
 
-	if (flags & RPC_TASK_SWAPPER)
+	if (task->tk_flags & RPC_TASK_SWAPPER)
 		gfp = GFP_ATOMIC;
-	else if (flags & RPC_TASK_ASYNC)
-		gfp = GFP_RPC;
 	else
-		gfp = GFP_KERNEL;
-
-	do {
-		if ((buffer = (u32 *) kmalloc(size, gfp)) != NULL) {
-			dprintk("RPC:      allocated buffer %p\n", buffer);
-			return buffer;
-		}
-		if ((flags & RPC_TASK_SWAPPER) && size <= sizeof(swap_buffer)
-		    && rpc_lock_swapbuf()) {
-			dprintk("RPC:      used last-ditch swap buffer\n");
-			return swap_buffer;
-		}
-		if (flags & RPC_TASK_ASYNC)
-			return NULL;
-		yield();
-	} while (!signalled());
+		gfp = GFP_NOFS;
 
-	return NULL;
+	if (size > RPC_BUFFER_MAXSIZE) {
+		task->tk_buffer =  kmalloc(size, gfp);
+		if (task->tk_buffer)
+			task->tk_bufsize = size;
+	} else {
+		task->tk_buffer =  mempool_alloc(rpc_buffer_mempool, gfp);
+		if (task->tk_buffer)
+			task->tk_bufsize = RPC_BUFFER_MAXSIZE;
+	}
+	return task->tk_buffer;
 }
 
 void
-rpc_free(void *buffer)
+rpc_free(struct rpc_task *task)
 {
-	if (buffer != swap_buffer) {
-		kfree(buffer);
-		return;
+	if (task->tk_buffer) {
+		if (task->tk_bufsize == RPC_BUFFER_MAXSIZE)
+			mempool_free(task->tk_buffer, rpc_buffer_mempool);
+		else
+			kfree(task->tk_buffer);
+		task->tk_buffer = NULL;
+		task->tk_bufsize = 0;
 	}
-	rpc_unlock_swapbuf();
 }
 
 /*
@@ -774,11 +743,17 @@
 				current->pid);
 }
 
+static struct rpc_task *
+rpc_alloc_task(void)
+{
+	return (struct rpc_task *)mempool_alloc(rpc_task_mempool, GFP_NOFS);
+}
+
 static void
 rpc_default_free_task(struct rpc_task *task)
 {
 	dprintk("RPC: %4d freeing task\n", task->tk_pid);
-	rpc_free(task);
+	mempool_free(task, rpc_task_mempool);
 }
 
 /*
@@ -791,7 +766,7 @@
 {
 	struct rpc_task	*task;
 
-	task = (struct rpc_task *) rpc_allocate(flags, sizeof(*task));
+	task = rpc_alloc_task();
 	if (!task)
 		goto cleanup;
 
@@ -856,10 +831,7 @@
 		xprt_release(task);
 	if (task->tk_msg.rpc_cred)
 		rpcauth_unbindcred(task);
-	if (task->tk_buffer) {
-		rpc_free(task->tk_buffer);
-		task->tk_buffer = NULL;
-	}
+	rpc_free(task);
 	if (task->tk_client) {
 		rpc_release_client(task->tk_client);
 		task->tk_client = NULL;
@@ -1159,3 +1131,49 @@
 	spin_unlock(&rpc_sched_lock);
 }
 #endif
+
+void
+rpc_destroy_mempool(void)
+{
+	if (rpc_buffer_mempool)
+		mempool_destroy(rpc_buffer_mempool);
+	if (rpc_task_mempool)
+		mempool_destroy(rpc_task_mempool);
+	if (rpc_task_slabp && kmem_cache_destroy(rpc_task_slabp))
+		printk(KERN_INFO "rpc_task: not all structures were freed\n");
+	if (rpc_buffer_slabp && kmem_cache_destroy(rpc_buffer_slabp))
+		printk(KERN_INFO "rpc_buffers: not all structures were freed\n");
+}
+
+int
+rpc_init_mempool(void)
+{
+	rpc_task_slabp = kmem_cache_create("rpc_tasks",
+					     sizeof(struct rpc_task),
+					     0, SLAB_HWCACHE_ALIGN,
+					     NULL, NULL);
+	if (!rpc_task_slabp)
+		goto err_nomem;
+	rpc_buffer_slabp = kmem_cache_create("rpc_buffers",
+					     RPC_BUFFER_MAXSIZE,
+					     0, SLAB_HWCACHE_ALIGN,
+					     NULL, NULL);
+	if (!rpc_buffer_slabp)
+		goto err_nomem;
+	rpc_task_mempool = mempool_create(RPC_TASK_POOLSIZE,
+					    mempool_alloc_slab,
+					    mempool_free_slab,
+					    rpc_task_slabp);
+	if (!rpc_task_mempool)
+		goto err_nomem;
+	rpc_buffer_mempool = mempool_create(RPC_BUFFER_POOLSIZE,
+					    mempool_alloc_slab,
+					    mempool_free_slab,
+					    rpc_buffer_slabp);
+	if (!rpc_buffer_mempool)
+		goto err_nomem;
+	return 0;
+err_nomem:
+	rpc_destroy_mempool();
+	return -ENOMEM;
+}
diff -u --recursive --new-file linux-2.5.46-05-mempool/net/sunrpc/sunrpc_syms.c linux-2.5.46-06-rpcbuf/net/sunrpc/sunrpc_syms.c
--- linux-2.5.46-05-mempool/net/sunrpc/sunrpc_syms.c	2002-10-30 17:40:03.000000000 -0500
+++ linux-2.5.46-06-rpcbuf/net/sunrpc/sunrpc_syms.c	2002-11-08 20:51:52.000000000 -0500
@@ -25,8 +25,6 @@
 
 
 /* RPC scheduler */
-EXPORT_SYMBOL(rpc_allocate);
-EXPORT_SYMBOL(rpc_free);
 EXPORT_SYMBOL(rpc_execute);
 EXPORT_SYMBOL(rpc_init_task);
 EXPORT_SYMBOL(rpc_sleep_on);
@@ -134,6 +132,8 @@
 static int __init
 init_sunrpc(void)
 {
+	if (rpc_init_mempool() != 0)
+		return -ENOMEM;
 #ifdef RPC_DEBUG
 	rpc_register_sysctl();
 #endif
@@ -148,6 +148,7 @@
 static void __exit
 cleanup_sunrpc(void)
 {
+	rpc_destroy_mempool();
 	cache_unregister(&auth_domain_cache);
 	cache_unregister(&ip_map_cache);
 #ifdef RPC_DEBUG
diff -u --recursive --new-file linux-2.5.46-05-mempool/net/sunrpc/xprt.c linux-2.5.46-06-rpcbuf/net/sunrpc/xprt.c
--- linux-2.5.46-05-mempool/net/sunrpc/xprt.c	2002-10-30 17:41:17.000000000 -0500
+++ linux-2.5.46-06-rpcbuf/net/sunrpc/xprt.c	2002-11-08 19:24:34.000000000 -0500
@@ -1547,7 +1547,7 @@
  out_bad:
 	dprintk("RPC:      xprt_create_proto failed\n");
 	if (xprt)
-		rpc_free(xprt);
+		kfree(xprt);
 	return NULL;
 }
 
@@ -1586,7 +1586,7 @@
 	dprintk("RPC:      destroying transport %p\n", xprt);
 	xprt_shutdown(xprt);
 	xprt_close(xprt);
-	rpc_free(xprt);
+	kfree(xprt);
 
 	return 0;
 }


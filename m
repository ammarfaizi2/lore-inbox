Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbWJFPBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWJFPBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 11:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbWJFPBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 11:01:04 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:46779 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161048AbWJFPBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 11:01:01 -0400
Subject: [PATCH] lockdep: annotate nfs/nfsd in-kernel sockets
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: steved@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Neil Brown <neilb@suse.de>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 17:01:00 +0200
Message-Id: <1160146860.2792.111.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stick NFS sockets in their own class to avoid some lockdep warnings.
NFS sockets are never exposed to user-space, and will hence not trigger
certain code paths that would otherwise pose deadlock scenarios.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Steven Dickson <SteveD@redhat.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
---
 include/net/sock.h    |   19 +++++++++++++++++++
 kernel/lockdep.c      |    1 +
 net/core/sock.c       |   23 +++++------------------
 net/sunrpc/svcsock.c  |   33 +++++++++++++++++++++++++++++++++
 net/sunrpc/xprtsock.c |   33 +++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 18 deletions(-)

Index: linux-2.6/include/net/sock.h
===================================================================
--- linux-2.6.orig/include/net/sock.h
+++ linux-2.6/include/net/sock.h
@@ -745,6 +745,25 @@ static inline int sk_stream_wmem_schedul
  */
 #define sock_owned_by_user(sk)	((sk)->sk_lock.owner)
 
+/*
+ * Macro so as to not evaluate some arguments when
+ * lockdep is not enabled.
+ *
+ * Mark both the sk_lock and the sk_lock.slock as a
+ * per-address-family lock class.
+ */
+#define sock_lock_init_class_and_name(sk, sname, skey, name, key) 	\
+do {									\
+	sk->sk_lock.owner = NULL;					\
+	init_waitqueue_head(&sk->sk_lock.wq);				\
+	spin_lock_init(&(sk)->sk_lock.slock);				\
+	debug_check_no_locks_freed((void *)&(sk)->sk_lock,		\
+			sizeof((sk)->sk_lock));				\
+	lockdep_set_class_and_name(&(sk)->sk_lock.slock,		\
+		       	(skey), (sname));				\
+	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key));	\
+} while (0)
+
 extern void FASTCALL(lock_sock(struct sock *sk));
 extern void FASTCALL(release_sock(struct sock *sk));
 
Index: linux-2.6/kernel/lockdep.c
===================================================================
--- linux-2.6.orig/kernel/lockdep.c
+++ linux-2.6/kernel/lockdep.c
@@ -2643,6 +2643,7 @@ void debug_check_no_locks_freed(const vo
 	}
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL_GPL(debug_check_no_locks_freed);
 
 static void print_held_locks_bug(struct task_struct *curr)
 {
Index: linux-2.6/net/core/sock.c
===================================================================
--- linux-2.6.orig/net/core/sock.c
+++ linux-2.6/net/core/sock.c
@@ -806,24 +806,11 @@ lenout:
  */
 static void inline sock_lock_init(struct sock *sk)
 {
-	spin_lock_init(&sk->sk_lock.slock);
-	sk->sk_lock.owner = NULL;
-	init_waitqueue_head(&sk->sk_lock.wq);
-	/*
-	 * Make sure we are not reinitializing a held lock:
-	 */
-	debug_check_no_locks_freed((void *)&sk->sk_lock, sizeof(sk->sk_lock));
-
-	/*
-	 * Mark both the sk_lock and the sk_lock.slock as a
-	 * per-address-family lock class:
-	 */
-	lockdep_set_class_and_name(&sk->sk_lock.slock,
-				   af_family_slock_keys + sk->sk_family,
-				   af_family_slock_key_strings[sk->sk_family]);
-	lockdep_init_map(&sk->sk_lock.dep_map,
-			 af_family_key_strings[sk->sk_family],
-			 af_family_keys + sk->sk_family);
+	sock_lock_init_class_and_name(sk,
+			af_family_slock_key_strings[sk->sk_family],
+			af_family_slock_keys + sk->sk_family,
+			af_family_key_strings[sk->sk_family],
+			af_family_keys + sk->sk_family);
 }
 
 /**
Index: linux-2.6/net/sunrpc/xprtsock.c
===================================================================
--- linux-2.6.orig/net/sunrpc/xprtsock.c
+++ linux-2.6/net/sunrpc/xprtsock.c
@@ -1058,6 +1058,37 @@ static int xs_bindresvport(struct rpc_xp
 	return err;
 }
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key xs_key[2];
+static struct lock_class_key xs_slock_key[2];
+
+static inline void xs_reclassify_socket(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	BUG_ON(sk->sk_lock.owner != NULL);
+	switch (sk->sk_family) {
+		case AF_INET:
+			sock_lock_init_class_and_name(sk,
+				"slock-AF_INET-NFS", &xs_slock_key[0],
+				"sk_lock-AF_INET-NFS", &xs_key[0]);
+			break;
+
+		case AF_INET6:
+			sock_lock_init_class_and_name(sk,
+				"slock-AF_INET6-NFS", &xs_slock_key[1],
+				"sk_lock-AF_INET6-NFS", &xs_key[1]);
+			break;
+
+		default:
+			BUG();
+	}
+}
+#else
+static inline void xs_reclassify_socket(struct socket *sock)
+{
+}
+#endif
+
 /**
  * xs_udp_connect_worker - set up a UDP socket
  * @args: RPC transport to connect
@@ -1080,6 +1111,7 @@ static void xs_udp_connect_worker(void *
 		dprintk("RPC:      can't create UDP transport socket (%d).\n", -err);
 		goto out;
 	}
+	xs_reclassify_socket(sock);
 
 	if (xprt->resvport && xs_bindresvport(xprt, sock) < 0) {
 		sock_release(sock);
@@ -1163,6 +1195,7 @@ static void xs_tcp_connect_worker(void *
 			dprintk("RPC:      can't create TCP transport socket (%d).\n", -err);
 			goto out;
 		}
+		xs_reclassify_socket(sock);
 
 		if (xprt->resvport && xs_bindresvport(xprt, sock) < 0) {
 			sock_release(sock);
Index: linux-2.6/net/sunrpc/svcsock.c
===================================================================
--- linux-2.6.orig/net/sunrpc/svcsock.c
+++ linux-2.6/net/sunrpc/svcsock.c
@@ -84,6 +84,37 @@ static struct cache_deferred_req *svc_de
  */
 static int svc_conn_age_period = 6*60;
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key svc_key[2];
+static struct lock_class_key svc_slock_key[2];
+
+static inline void svc_reclassify_socket(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	BUG_ON(sk->sk_lock.owner != NULL);
+	switch (sk->sk_family) {
+		case AF_INET:
+			sock_lock_init_class_and_name(sk,
+				"slock-AF_INET-NFSD", &svc_slock_key[0],
+				"sk_lock-AF_INET-NFSD", &svc_key[0]);
+			break;
+
+		case AF_INET6:
+			sock_lock_init_class_and_name(sk,
+				"slock-AF_INET6-NFSD", &svc_slock_key[1],
+				"sk_lock-AF_INET6-NFSD", &svc_key[1]);
+			break;
+
+		default:
+			BUG();
+	}
+}
+#else
+static inline void svc_reclassify_socket(struct socket *sock)
+{
+}
+#endif
+
 /*
  * Queue up an idle server thread.  Must have pool->sp_lock held.
  * Note: this is really a stack rather than a queue, so that we only
@@ -1550,6 +1581,8 @@ svc_create_socket(struct svc_serv *serv,
 	if ((error = sock_create_kern(PF_INET, type, protocol, &sock)) < 0)
 		return error;
 
+	svc_reclassify_socket(sock);
+
 	if (type == SOCK_STREAM)
 		sock->sk->sk_reuse = 1; /* allow address reuse */
 	error = kernel_bind(sock, (struct sockaddr *) sin,



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWJIIy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWJIIy0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWJIIy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:54:26 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:39190 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S932412AbWJIIyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:54:24 -0400
Subject: [PATCH] lockdep: annotate nfs/nfsd in-kernel sockets
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       steved@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       David Miller <davem@davemloft.net>
In-Reply-To: <17706.1827.174148.860144@cse.unsw.edu.au>
References: <1160146860.2792.111.camel@taijtu>
	 <17705.40741.552103.194329@cse.unsw.edu.au>
	 <1160381521.2792.129.camel@taijtu>
	 <17706.1827.174148.860144@cse.unsw.edu.au>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 10:54:29 +0200
Message-Id: <1160384069.2792.148.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 18:24 +1000, Neil Brown wrote:

> > These:
> >   http://lkml.org/lkml/2006/7/13/84
> 
> Wouldn't have hurt to have that link in the changelog... or maybe an
> excerpt?

Done

> That is very much an nfs-client issue, so reclassifying the
> server-side sockets seems irrelevant.  Doesn't cause any harm though I
> suppose.

SteveD had a case that required the svc change, Steve was that the same
trace or another?

New patch:
---

Stick NFS sockets in their own class to avoid some lockdep warnings.
NFS sockets are never exposed to user-space, and will hence not trigger
certain code paths that would otherwise pose deadlock scenarios such as:

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
git-fetch/11540 is trying to acquire lock:
 (sk_lock-AF_INET){--..}, at: [<ffffffff80228062>] tcp_sendmsg+0x1f/0xb1a
but task is already holding lock:
 (&inode->i_alloc_sem){--..}, at: [<ffffffff8022f765>] notify_change+0x105/0x2f7
which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&inode->i_alloc_sem){--..}:
       [<ffffffff802ab792>] lock_acquire+0x4a/0x69
       [<ffffffff802a831c>] down_write+0x3a/0x47
       [<ffffffff8022f764>] notify_change+0x104/0x2f7
       [<ffffffff802e00c7>] do_truncate+0x52/0x72
       [<ffffffff80212d17>] may_open+0x1d5/0x231
       [<ffffffff8021c270>] open_namei+0x290/0x6b4
       [<ffffffff80229974>] do_filp_open+0x27/0x46
       [<ffffffff8021acb7>] do_sys_open+0x4e/0xcd
       [<ffffffff80234b2a>] sys_open+0x1a/0x1d
       [<ffffffff80262e4d>] system_call+0x7d/0x83
-> #2 (&sysfs_inode_imutex_key){--..}:
       [<ffffffff802ab792>] lock_acquire+0x4a/0x69
       [<ffffffff802691c2>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff8026939f>] mutex_lock+0x29/0x2e
       [<ffffffff8030ed74>] create_dir+0x2c/0x1e2
       [<ffffffff8030f32f>] sysfs_create_dir+0x59/0x78
       [<ffffffff8034cbd6>] kobject_add+0x114/0x1d8
       [<ffffffff803baa5d>] class_device_add+0xb5/0x49d
       [<ffffffff8042f982>] netdev_register_sysfs+0x98/0xa2
       [<ffffffff8042685f>] register_netdevice+0x28c/0x377
       [<ffffffff804269a4>] register_netdev+0x5a/0x69
       [<ffffffff8098a9f8>] loopback_init+0x4e/0x53
       [<ffffffff8098a8fe>] net_olddevs_init+0xb/0xb7
       [<ffffffff802709c0>] init+0x177/0x348
       [<ffffffff80263d9d>] child_rip+0x7/0x12
-> #1 (rtnl_mutex){--..}:
       [<ffffffff802ab792>] lock_acquire+0x4a/0x69
       [<ffffffff802691c2>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff8026939f>] mutex_lock+0x29/0x2e
       [<ffffffff8042d973>] rtnl_lock+0xf/0x12
       [<ffffffff8045c18a>] ip_mc_leave_group+0x1e/0xae
       [<ffffffff80446087>] do_ip_setsockopt+0x6ad/0x9b2
       [<ffffffff8044643a>] ip_setsockopt+0x2a/0x84
       [<ffffffff80454328>] udp_setsockopt+0xd/0x1c
       [<ffffffff8041f094>] sock_common_setsockopt+0xe/0x11
       [<ffffffff8041e20f>] sys_setsockopt+0x8e/0xb4
       [<ffffffff80262fd9>] tracesys+0xd0/0xdb
-> #0 (sk_lock-AF_INET){--..}:
       [<ffffffff802ab792>] lock_acquire+0x4a/0x69
       [<ffffffff8023726c>] lock_sock+0xd4/0xe7
       [<ffffffff80228061>] tcp_sendmsg+0x1e/0xb1a
       [<ffffffff80248ff8>] inet_sendmsg+0x45/0x53
       [<ffffffff80259dd3>] sock_sendmsg+0x110/0x130
       [<ffffffff8041ed0c>] kernel_sendmsg+0x3c/0x52
       [<ffffffff8853c9e9>] xs_tcp_send_request+0x117/0x320 [sunrpc]
       [<ffffffff8853b8d5>] xprt_transmit+0x105/0x21e [sunrpc]
       [<ffffffff8853a71e>] call_transmit+0x1f4/0x239 [sunrpc]
       [<ffffffff8853f06e>] __rpc_execute+0x9b/0x1e6 [sunrpc]
       [<ffffffff8853f1de>] rpc_execute+0x1a/0x1d [sunrpc]
       [<ffffffff885394ad>] rpc_call_sync+0x87/0xb9 [sunrpc]
       [<ffffffff885a5587>] nfs3_rpc_wrapper+0x2e/0x74 [nfs]
       [<ffffffff885a5870>] nfs3_proc_setattr+0x9b/0xd3 [nfs]
       [<ffffffff8859bffb>] nfs_setattr+0xe9/0x11e [nfs]
       [<ffffffff8022f7b4>] notify_change+0x154/0x2f7
       [<ffffffff802e00c7>] do_truncate+0x52/0x72
       [<ffffffff80212d17>] may_open+0x1d5/0x231
       [<ffffffff8021c270>] open_namei+0x290/0x6b4
       [<ffffffff80229974>] do_filp_open+0x27/0x46
       [<ffffffff8021acb7>] do_sys_open+0x4e/0xcd
       [<ffffffff80234b2a>] sys_open+0x1a/0x1d
       [<ffffffff80262fd9>] tracesys+0xd0/0xdb

other info that might help us debug this:

2 locks held by git-fetch/11540:
 #0:  (&inode->i_mutex){--..}, at: [<ffffffff802693a0>] mutex_lock+0x2a/0x2e
 #1:  (&inode->i_alloc_sem){--..}, at: [<ffffffff8022f765>] notify_change+0x105/0x2f7
stack backtrace:

Call Trace:
 [<ffffffff802719b8>] show_trace+0xaa/0x23d
 [<ffffffff80271b60>] dump_stack+0x15/0x17
 [<ffffffff802a99ec>] print_circular_bug_tail+0x6c/0x77
 [<ffffffff802aaff1>] __lock_acquire+0x853/0xa54
 [<ffffffff802ab793>] lock_acquire+0x4b/0x69
 [<ffffffff8023726d>] lock_sock+0xd5/0xe7
 [<ffffffff80228062>] tcp_sendmsg+0x1f/0xb1a
 [<ffffffff80248ff9>] inet_sendmsg+0x46/0x53
 [<ffffffff80259dd4>] sock_sendmsg+0x111/0x130
 [<ffffffff8041ed0d>] kernel_sendmsg+0x3d/0x52
 [<ffffffff8853c9ea>] :sunrpc:xs_tcp_send_request+0x118/0x320
 [<ffffffff8853b8d6>] :sunrpc:xprt_transmit+0x106/0x21e
 [<ffffffff8853a71f>] :sunrpc:call_transmit+0x1f5/0x239
 [<ffffffff8853f06f>] :sunrpc:__rpc_execute+0x9c/0x1e6
 [<ffffffff8853f1df>] :sunrpc:rpc_execute+0x1b/0x1d
 [<ffffffff885394ae>] :sunrpc:rpc_call_sync+0x88/0xb9
 [<ffffffff885a5588>] :nfs:nfs3_rpc_wrapper+0x2f/0x74
 [<ffffffff885a5871>] :nfs:nfs3_proc_setattr+0x9c/0xd3
 [<ffffffff8859bffc>] :nfs:nfs_setattr+0xea/0x11e
 [<ffffffff8022f7b5>] notify_change+0x155/0x2f7
 [<ffffffff802e00c8>] do_truncate+0x53/0x72
 [<ffffffff80212d18>] may_open+0x1d6/0x231
 [<ffffffff8021c271>] open_namei+0x291/0x6b4
 [<ffffffff80229975>] do_filp_open+0x28/0x46
 [<ffffffff8021acb8>] do_sys_open+0x4f/0xcd
 [<ffffffff80234b2b>] sys_open+0x1b/0x1d
 [<ffffffff80262fda>] tracesys+0xd1/0xdb

Where upon Herbert Xu said:
"We know this is a false positive because the NFS sockets are not
 exported to user-space and therefore #1 can't happen."

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Steven Dickson <SteveD@redhat.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Neil Brown <neilb@suse.de>
---
 include/net/sock.h    |   19 +++++++++++++++++++
 kernel/lockdep.c      |    1 +
 net/core/sock.c       |   23 +++++------------------
 net/sunrpc/svcsock.c  |   33 +++++++++++++++++++++++++++++++++
 net/sunrpc/xprtsock.c |   33 +++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 18 deletions(-)

Index: linux-2.6.18.noarch/include/net/sock.h
===================================================================
--- linux-2.6.18.noarch.orig/include/net/sock.h
+++ linux-2.6.18.noarch/include/net/sock.h
@@ -748,6 +748,25 @@ static inline int sk_stream_wmem_schedul
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
+	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);	\
+} while (0)
+
 extern void FASTCALL(lock_sock(struct sock *sk));
 extern void FASTCALL(release_sock(struct sock *sk));
 
Index: linux-2.6.18.noarch/kernel/lockdep.c
===================================================================
--- linux-2.6.18.noarch.orig/kernel/lockdep.c
+++ linux-2.6.18.noarch/kernel/lockdep.c
@@ -2638,6 +2638,7 @@ void debug_check_no_locks_freed(const vo
 	}
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL_GPL(debug_check_no_locks_freed);
 
 static void print_held_locks_bug(struct task_struct *curr)
 {
Index: linux-2.6.18.noarch/net/core/sock.c
===================================================================
--- linux-2.6.18.noarch.orig/net/core/sock.c
+++ linux-2.6.18.noarch/net/core/sock.c
@@ -810,24 +810,11 @@ lenout:
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
-			 af_family_keys + sk->sk_family, 0);
+	sock_lock_init_class_and_name(sk,
+			af_family_slock_key_strings[sk->sk_family],
+			af_family_slock_keys + sk->sk_family,
+			af_family_key_strings[sk->sk_family],
+			af_family_keys + sk->sk_family);
 }
 
 /**
Index: linux-2.6.18.noarch/net/sunrpc/xprtsock.c
===================================================================
--- linux-2.6.18.noarch.orig/net/sunrpc/xprtsock.c
+++ linux-2.6.18.noarch/net/sunrpc/xprtsock.c
@@ -1004,6 +1004,37 @@ static int xs_bindresvport(struct rpc_xp
 	return err;
 }
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key xs_key[2];
+static struct lock_class_key xs_slock_key[2];
+
+static inline void xs_reclassify_sock_lock(struct socket *sock)
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
+static inline void xs_reclassify_sock_lock(struct socket *sock)
+{
+}
+#endif
+
 /**
  * xs_udp_connect_worker - set up a UDP socket
  * @args: RPC transport to connect
@@ -1028,6 +1059,7 @@ static void xs_udp_connect_worker(void *
 		dprintk("RPC:      can't create UDP transport socket (%d).\n", -err);
 		goto out;
 	}
+	xs_reclassify_sock_lock(sock);
 
 	if (xprt->resvport && xs_bindresvport(xprt, sock) < 0) {
 		sock_release(sock);
@@ -1110,6 +1142,7 @@ static void xs_tcp_connect_worker(void *
 			dprintk("RPC:      can't create TCP transport socket (%d).\n", -err);
 			goto out;
 		}
+		xs_reclassify_sock_lock(sock);
 
 		if (xprt->resvport && xs_bindresvport(xprt, sock) < 0) {
 			sock_release(sock);
Index: linux-2.6.18.noarch/net/sunrpc/svcsock.c
===================================================================
--- linux-2.6.18.noarch.orig/net/sunrpc/svcsock.c
+++ linux-2.6.18.noarch/net/sunrpc/svcsock.c
@@ -73,6 +73,37 @@ static struct svc_deferred_req *svc_defe
 static int svc_deferred_recv(struct svc_rqst *rqstp);
 static struct cache_deferred_req *svc_defer(struct cache_req *req);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key svc_key[2];
+static struct lock_class_key svc_slock_key[2];
+
+static inline void svc_reclassify_sock_lock(struct socket *sock)
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
+static inline void svc_reclassify_sock_lock(struct socket *sock)
+{
+}
+#endif
+
 /*
  * Queue up an idle server thread.  Must have serv->sv_lock held.
  * Note: this is really a stack rather than a queue, so that we only
@@ -1403,6 +1434,8 @@ svc_create_socket(struct svc_serv *serv,
 	if ((error = sock_create_kern(PF_INET, type, protocol, &sock)) < 0)
 		return error;
 
+	svc_reclassify_sock_lock(sock);
+
 	if (sin != NULL) {
 		if (type == SOCK_STREAM)
 			sock->sk->sk_reuse = 1; /* allow address reuse */



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161188AbWJ3IPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbWJ3IPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 03:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWJ3IPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 03:15:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17344 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161188AbWJ3IPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 03:15:49 -0500
Subject: [PATCH] lockdep: annotate sk_lock nesting in AF_BLUETOOTH
From: Peter Zijlstra <pzijlstr@redhat.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>,
       Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 09:16:26 +0100
Message-Id: <1162196186.24143.158.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


=============================================
[ INFO: possible recursive locking detected ]
2.6.18-1.2726.fc6 #1
---------------------------------------------
hidd/2271 is trying to acquire lock:
 (sk_lock-AF_BLUETOOTH){--..}, at: [<f8d16241>] bt_accept_dequeue+0x26/0xc6
[bluetooth]

but task is already holding lock:
 (sk_lock-AF_BLUETOOTH){--..}, at: [<f8bce088>] l2cap_sock_accept+0x41/0x11e [l2cap]

other info that might help us debug this:
1 lock held by hidd/2271:
 #0:  (sk_lock-AF_BLUETOOTH){--..}, at: [<f8bce088>]
l2cap_sock_accept+0x41/0x11e [l2cap]

stack backtrace:
 [<c04051ed>] show_trace_log_lvl+0x58/0x16a
 [<c04057fa>] show_trace+0xd/0x10
 [<c0405913>] dump_stack+0x19/0x1b
 [<c043b7dc>] __lock_acquire+0x6ea/0x90d
 [<c043bf70>] lock_acquire+0x4b/0x6b
 [<c05b203b>] lock_sock+0xac/0xbc
 [<f8d16241>] bt_accept_dequeue+0x26/0xc6 [bluetooth]
 [<f8bce129>] l2cap_sock_accept+0xe2/0x11e [l2cap]
 [<c05b142e>] sys_accept+0xd8/0x179
 [<c05b1576>] sys_socketcall+0xa7/0x186
 [<c0403fb7>] syscall_call+0x7/0xb

classical case of nesting; bt_accept_dequeue() locks the children of the object
locked by l2cap_sock_accept().

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/net/sock.h    |   13 ++++++++++++-
 net/bluetooth/l2cap.c |    2 +-
 net/core/sock.c       |    6 +++---
 3 files changed, 16 insertions(+), 5 deletions(-)

Index: linux-2.6/include/net/sock.h
===================================================================
--- linux-2.6.orig/include/net/sock.h
+++ linux-2.6/include/net/sock.h
@@ -745,7 +745,18 @@ static inline int sk_stream_wmem_schedul
  */
 #define sock_owned_by_user(sk)	((sk)->sk_lock.owner)
 
-extern void FASTCALL(lock_sock(struct sock *sk));
+extern void FASTCALL(_lock_sock(struct sock *sk, int subclass));
+
+static inline void lock_sock(struct sock *sk)
+{
+	_lock_sock(sk, 0);
+}
+
+static inline void lock_sock_nested(struct sock *sk, int subclass)
+{
+	_lock_sock(sk, subclass);
+}
+
 extern void FASTCALL(release_sock(struct sock *sk));
 
 /* BH context may only use the following locking interface. */
Index: linux-2.6/net/bluetooth/l2cap.c
===================================================================
--- linux-2.6.orig/net/bluetooth/l2cap.c
+++ linux-2.6/net/bluetooth/l2cap.c
@@ -770,7 +770,7 @@ static int l2cap_sock_accept(struct sock
 	long timeo;
 	int err = 0;
 
-	lock_sock(sk);
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
 	if (sk->sk_state != BT_LISTEN) {
 		err = -EBADFD;
Index: linux-2.6/net/core/sock.c
===================================================================
--- linux-2.6.orig/net/core/sock.c
+++ linux-2.6/net/core/sock.c
@@ -1527,7 +1527,7 @@ void sock_init_data(struct socket *sock,
 	atomic_set(&sk->sk_refcnt, 1);
 }
 
-void fastcall lock_sock(struct sock *sk)
+void fastcall _lock_sock(struct sock *sk, int subclass)
 {
 	might_sleep();
 	spin_lock_bh(&sk->sk_lock.slock);
@@ -1538,11 +1538,11 @@ void fastcall lock_sock(struct sock *sk)
 	/*
 	 * The sk_lock has mutex_lock() semantics here:
 	 */
-	mutex_acquire(&sk->sk_lock.dep_map, 0, 0, _RET_IP_);
+	mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);
 	local_bh_enable();
 }
 
-EXPORT_SYMBOL(lock_sock);
+EXPORT_SYMBOL(_lock_sock);
 
 void fastcall release_sock(struct sock *sk)
 {



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbTJFEwR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 00:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263975AbTJFEwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 00:52:17 -0400
Received: from [61.95.227.64] ([61.95.227.64]:4736 "EHLO gateway.gsecone.com")
	by vger.kernel.org with ESMTP id S263972AbTJFEwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 00:52:11 -0400
Subject: Re: [PATCH 2.6.0-test6][X25] timer cleanup
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@osdl.org, netdev@oss.sgi.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20031002013620.6d8b6f10.davem@redhat.com>
References: <1065018387.7194.336.camel@lima.royalchallenge.com>
	 <20031001155623.06b89258.akpm@osdl.org>
	 <1065078208.4340.3.camel@lima.royalchallenge.com>
	 <20031002013620.6d8b6f10.davem@redhat.com>
Content-Type: text/plain
Organization: Global Security One
Message-Id: <1065362979.4370.34.camel@lima.royalchallenge.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 05 Oct 2003 19:39:39 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Thu, 2003-10-02 at 14:06, David S. Miller wrote:
> Please find a way to at least minimally test the protocols
> you are changing then, or find someone else who can.
I have tested the patch using LAPB over Ethernet (I do not have real
hardware) under linux-2.6.0-test5-uml1 and it works fine for me.

I used the x25_utils available at 
http://www.baty.hanse.de/linux-x25/utils/x25_utils-2.3.93.tar.gz

and have been successfully able to run X.25 telnet application.

I have updated the patch to fix a locking bug in x25_accept I
encountered while testing.

Thanks
Vinay

1. Replace del_timer, mod_timer sequences with mod_timer.
2. Add missing lock_sock/release_sock in x25_accept


 af_x25.c    |   15 +++++++++------
 x25_link.c  |   16 ++++++----------
 x25_timer.c |   47 +++++++++++++++--------------------------------
 3 files changed, 30 insertions(+), 48 deletions(-)

diff -urN linux-2.6.0-test6/net/x25/af_x25.c linux-2.6.0-test6-nvk/net/x25/af_x25.c
--- linux-2.6.0-test6/net/x25/af_x25.c	2003-09-09 11:12:07.000000000 +0530
+++ linux-2.6.0-test6-nvk/net/x25/af_x25.c	2003-10-05 19:23:45.000000000 +0530
@@ -345,10 +345,8 @@
 	if (atomic_read(&sk->sk_wmem_alloc) ||
 	    atomic_read(&sk->sk_rmem_alloc)) {
 		/* Defer: outstanding buffers */
-		init_timer(&sk->sk_timer);
 		sk->sk_timer.expires  = jiffies + 10 * HZ;
 		sk->sk_timer.function = x25_destroy_timer;
-		sk->sk_timer.data     = (unsigned long)sk;
 		add_timer(&sk->sk_timer);
 	} else {
 		/* drop last reference so sock_put will free */
@@ -463,6 +461,8 @@
 	goto out;
 }
 
+void x25_init_timers(struct sock *sk);
+
 static int x25_create(struct socket *sock, int protocol)
 {
 	struct sock *sk;
@@ -481,7 +481,7 @@
 	sock_init_data(sock, sk);
 	sk_set_owner(sk, THIS_MODULE);
 
-	init_timer(&x25->timer);
+	x25_init_timers(sk);
 
 	sock->ops    = &x25_proto_ops;
 	sk->sk_protocol = protocol;
@@ -537,7 +537,7 @@
 	x25->facilities = ox25->facilities;
 	x25->qbitincl   = ox25->qbitincl;
 
-	init_timer(&x25->timer);
+	x25_init_timers(sk);
 out:
 	return sk;
 }
@@ -760,13 +760,14 @@
 	if (sk->sk_type != SOCK_SEQPACKET)
 		goto out;
 
+	lock_sock(sk);
 	rc = x25_wait_for_data(sk, sk->sk_rcvtimeo);
 	if (rc)
-		goto out;
+		goto out2;
 	skb = skb_dequeue(&sk->sk_receive_queue);
 	rc = -EINVAL;
 	if (!skb->sk)
-		goto out;
+		goto out2;
 	newsk		 = skb->sk;
 	newsk->sk_pair   = NULL;
 	newsk->sk_socket = newsock;
@@ -779,6 +780,8 @@
 	newsock->sk    = newsk;
 	newsock->state = SS_CONNECTED;
 	rc = 0;
+out2:
+	release_sock(sk);
 out:
 	return rc;
 }
diff -urN linux-2.6.0-test6/net/x25/x25_link.c linux-2.6.0-test6-nvk/net/x25/x25_link.c
--- linux-2.6.0-test6/net/x25/x25_link.c	2003-09-09 11:12:07.000000000 +0530
+++ linux-2.6.0-test6-nvk/net/x25/x25_link.c	2003-10-01 19:50:04.000000000 +0530
@@ -51,15 +51,9 @@
 /*
  *	Linux set/reset timer routines
  */
-static void x25_start_t20timer(struct x25_neigh *nb)
+static inline void x25_start_t20timer(struct x25_neigh *nb)
 {
-	del_timer(&nb->t20timer);
-
-	nb->t20timer.data     = (unsigned long)nb;
-	nb->t20timer.function = &x25_t20timer_expiry;
-	nb->t20timer.expires  = jiffies + nb->t20;
-
-	add_timer(&nb->t20timer);
+	mod_timer(&nb->t20timer, jiffies + nb->t20);
 }
 
 static void x25_t20timer_expiry(unsigned long param)
@@ -71,12 +65,12 @@
 	x25_start_t20timer(nb);
 }
 
-static void x25_stop_t20timer(struct x25_neigh *nb)
+static inline void x25_stop_t20timer(struct x25_neigh *nb)
 {
 	del_timer(&nb->t20timer);
 }
 
-static int x25_t20timer_pending(struct x25_neigh *nb)
+static inline int x25_t20timer_pending(struct x25_neigh *nb)
 {
 	return timer_pending(&nb->t20timer);
 }
@@ -291,6 +285,8 @@
 	skb_queue_head_init(&nb->queue);
 
 	init_timer(&nb->t20timer);
+	nb->t20timer.data     = (unsigned long)nb;
+	nb->t20timer.function = &x25_t20timer_expiry;
 
 	dev_hold(dev);
 	nb->dev      = dev;
diff -urN linux-2.6.0-test6/net/x25/x25_timer.c linux-2.6.0-test6-nvk/net/x25/x25_timer.c
--- linux-2.6.0-test6/net/x25/x25_timer.c	2003-09-09 11:12:07.000000000 +0530
+++ linux-2.6.0-test6-nvk/net/x25/x25_timer.c	2003-10-01 19:50:04.000000000 +0530
@@ -43,15 +43,22 @@
 static void x25_heartbeat_expiry(unsigned long);
 static void x25_timer_expiry(unsigned long);
 
-void x25_start_heartbeat(struct sock *sk)
+void x25_init_timers(struct sock *sk)
 {
-	del_timer(&sk->sk_timer);
+	struct x25_opt *x25 = x25_sk(sk);
 
+	init_timer(&x25->timer);
+	x25->timer.data     = (unsigned long)sk;
+	x25->timer.function = &x25_timer_expiry;
+
+	/* initialized by sock_init_data */
 	sk->sk_timer.data     = (unsigned long)sk;
 	sk->sk_timer.function = &x25_heartbeat_expiry;
-	sk->sk_timer.expires  = jiffies + 5 * HZ;
+}
 
-	add_timer(&sk->sk_timer);
+void x25_start_heartbeat(struct sock *sk)
+{
+	mod_timer(&sk->sk_timer, jiffies + 5 * HZ);
 }
 
 void x25_stop_heartbeat(struct sock *sk)
@@ -63,52 +70,28 @@
 {
 	struct x25_opt *x25 = x25_sk(sk);
 
-	del_timer(&x25->timer);
-
-	x25->timer.data     = (unsigned long)sk;
-	x25->timer.function = &x25_timer_expiry;
-	x25->timer.expires  = jiffies + x25->t2;
-
-	add_timer(&x25->timer);
+	mod_timer(&x25->timer, jiffies + x25->t2);
 }
 
 void x25_start_t21timer(struct sock *sk)
 {
 	struct x25_opt *x25 = x25_sk(sk);
 
-	del_timer(&x25->timer);
-
-	x25->timer.data     = (unsigned long)sk;
-	x25->timer.function = &x25_timer_expiry;
-	x25->timer.expires  = jiffies + x25->t21;
-
-	add_timer(&x25->timer);
+	mod_timer(&x25->timer, jiffies + x25->t21);
 }
 
 void x25_start_t22timer(struct sock *sk)
 {
 	struct x25_opt *x25 = x25_sk(sk);
 
-	del_timer(&x25->timer);
-
-	x25->timer.data     = (unsigned long)sk;
-	x25->timer.function = &x25_timer_expiry;
-	x25->timer.expires  = jiffies + x25->t22;
-
-	add_timer(&x25->timer);
+	mod_timer(&x25->timer, jiffies + x25->t22);
 }
 
 void x25_start_t23timer(struct sock *sk)
 {
 	struct x25_opt *x25 = x25_sk(sk);
 
-	del_timer(&x25->timer);
-
-	x25->timer.data     = (unsigned long)sk;
-	x25->timer.function = &x25_timer_expiry;
-	x25->timer.expires  = jiffies + x25->t23;
-
-	add_timer(&x25->timer);
+	mod_timer(&x25->timer, jiffies + x25->t23);
 }
 
 void x25_stop_timer(struct sock *sk)



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbTIUMBl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 08:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbTIUMBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 08:01:41 -0400
Received: from [61.95.227.64] ([61.95.227.64]:29853 "EHLO gateway.gsecone.com")
	by vger.kernel.org with ESMTP id S262387AbTIUMBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 08:01:35 -0400
Subject: [PATCH 2.6.0-test5][NETROM] timer code cleanup
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: netdev@oss.sgi.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Global Security One
Message-Id: <1064145739.4349.28.camel@lima.royalchallenge.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 21 Sep 2003 17:32:19 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiles fine. Untested.

1. move timer initialization into nr_init_timers so that we can use mod_timer
2. remove skb queue purge in af_netrom as its already done by nr_clear_queues
3. Use del_timer_sync in nr_loopback_clear



 af_netrom.c   |   18 +++-------------
 nr_loopback.c |   31 +++++++----------------------
 nr_timer.c    |   62 ++++++++++++++++++++++++++--------------------------------
 3 files changed, 40 insertions(+), 71 deletions(-)


diff -urN linux-2.6.0-test5/net/netrom/af_netrom.c linux-2.6.0-test5-nvk/net/netrom/af_netrom.c
--- linux-2.6.0-test5/net/netrom/af_netrom.c	2003-09-09 11:12:08.000000000 +0530
+++ linux-2.6.0-test5-nvk/net/netrom/af_netrom.c	2003-09-21 16:36:12.000000000 +0530
@@ -62,6 +62,7 @@
 static spinlock_t nr_list_lock = SPIN_LOCK_UNLOCKED;
 
 static struct proto_ops nr_proto_ops;
+void nr_init_timers(struct sock *sk);
 
 static struct sock *nr_alloc_sock(void)
 {
@@ -279,17 +280,12 @@
 
 		kfree_skb(skb);
 	}
-	while ((skb = skb_dequeue(&sk->sk_write_queue)) != NULL) {
-		kfree_skb(skb);
-	}
 
 	if (atomic_read(&sk->sk_wmem_alloc) ||
 	    atomic_read(&sk->sk_rmem_alloc)) {
 		/* Defer: outstanding buffers */
-		init_timer(&sk->sk_timer);
-		sk->sk_timer.expires  = jiffies + 2 * HZ;
 		sk->sk_timer.function = nr_destroy_timer;
-		sk->sk_timer.data     = (unsigned long)sk;
+		sk->sk_timer.expires  = jiffies + 2 * HZ;
 		add_timer(&sk->sk_timer);
 	} else
 		sock_put(sk);
@@ -442,10 +438,7 @@
 	skb_queue_head_init(&nr->reseq_queue);
 	skb_queue_head_init(&nr->frag_queue);
 
-	init_timer(&nr->t1timer);
-	init_timer(&nr->t2timer);
-	init_timer(&nr->t4timer);
-	init_timer(&nr->idletimer);
+	nr_init_timers(sk);
 
 	nr->t1     = sysctl_netrom_transport_timeout;
 	nr->t2     = sysctl_netrom_transport_acknowledge_delay;
@@ -491,10 +484,7 @@
 	skb_queue_head_init(&nr->reseq_queue);
 	skb_queue_head_init(&nr->frag_queue);
 
-	init_timer(&nr->t1timer);
-	init_timer(&nr->t2timer);
-	init_timer(&nr->t4timer);
-	init_timer(&nr->idletimer);
+	nr_init_timers(sk);
 
 	onr = nr_sk(osk);
 
diff -urN linux-2.6.0-test5/net/netrom/nr_loopback.c linux-2.6.0-test5-nvk/net/netrom/nr_loopback.c
--- linux-2.6.0-test5/net/netrom/nr_loopback.c	2003-09-09 11:12:08.000000000 +0530
+++ linux-2.6.0-test5-nvk/net/netrom/nr_loopback.c	2003-09-21 13:36:05.000000000 +0530
@@ -14,19 +14,17 @@
 #include <net/netrom.h>
 #include <linux/init.h>
 
-static struct sk_buff_head loopback_queue;
-static struct timer_list loopback_timer;
+static void nr_loopback_timer(unsigned long);
 
-static void nr_set_loopback_timer(void);
+static struct sk_buff_head loopback_queue;
+static struct timer_list loopback_timer = TIMER_INITIALIZER(nr_loopback_timer, 0, 0);
 
-void nr_loopback_init(void)
+void __init nr_loopback_init(void)
 {
 	skb_queue_head_init(&loopback_queue);
-
-	init_timer(&loopback_timer);
 }
 
-static int nr_loopback_running(void)
+static inline int nr_loopback_running(void)
 {
 	return timer_pending(&loopback_timer);
 }
@@ -42,26 +40,13 @@
 		skb_queue_tail(&loopback_queue, skbn);
 
 		if (!nr_loopback_running())
-			nr_set_loopback_timer();
+			mod_timer(&loopback_timer, jiffies + 10);
 	}
 
 	kfree_skb(skb);
 	return 1;
 }
 
-static void nr_loopback_timer(unsigned long);
-
-static void nr_set_loopback_timer(void)
-{
-	del_timer(&loopback_timer);
-
-	loopback_timer.data     = 0;
-	loopback_timer.function = &nr_loopback_timer;
-	loopback_timer.expires  = jiffies + 10;
-
-	add_timer(&loopback_timer);
-}
-
 static void nr_loopback_timer(unsigned long param)
 {
 	struct sk_buff *skb;
@@ -80,12 +65,12 @@
 			dev_put(dev);
 
 		if (!skb_queue_empty(&loopback_queue) && !nr_loopback_running())
-			nr_set_loopback_timer();
+			mod_timer(&loopback_timer, jiffies + 10);
 	}
 }
 
 void __exit nr_loopback_clear(void)
 {
-	del_timer(&loopback_timer);
+	del_timer_sync(&loopback_timer);
 	skb_queue_purge(&loopback_queue);
 }
diff -urN linux-2.6.0-test5/net/netrom/nr_timer.c linux-2.6.0-test5-nvk/net/netrom/nr_timer.c
--- linux-2.6.0-test5/net/netrom/nr_timer.c	2003-09-09 11:12:08.000000000 +0530
+++ linux-2.6.0-test5-nvk/net/netrom/nr_timer.c	2003-09-21 15:23:46.000000000 +0530
@@ -36,69 +36,63 @@
 static void nr_t4timer_expiry(unsigned long);
 static void nr_idletimer_expiry(unsigned long);
 
-void nr_start_t1timer(struct sock *sk)
+void nr_init_timers(struct sock *sk)
 {
 	nr_cb *nr = nr_sk(sk);
 
-	del_timer(&nr->t1timer);
-
+	init_timer(&nr->t1timer);
 	nr->t1timer.data     = (unsigned long)sk;
 	nr->t1timer.function = &nr_t1timer_expiry;
-	nr->t1timer.expires  = jiffies + nr->t1;
+	
+	init_timer(&nr->t2timer);
+	nr->t2timer.data     = (unsigned long)sk;
+	nr->t2timer.function = &nr_t2timer_expiry;
+
+	init_timer(&nr->t4timer);
+	nr->t4timer.data     = (unsigned long)sk;
+	nr->t4timer.function = &nr_t4timer_expiry;
+
+	init_timer(&nr->idletimer);
+	nr->idletimer.data     = (unsigned long)sk;
+	nr->idletimer.function = &nr_idletimer_expiry;
 
-	add_timer(&nr->t1timer);
+	/* initialized by sock_init_data */
+	sk->sk_timer.data     = (unsigned long)sk;
+	sk->sk_timer.function = &nr_heartbeat_expiry;
 }
 
-void nr_start_t2timer(struct sock *sk)
+void nr_start_t1timer(struct sock *sk)
 {
 	nr_cb *nr = nr_sk(sk);
 
-	del_timer(&nr->t2timer);
+	mod_timer(&nr->t1timer, jiffies + nr->t1);
+}
 
-	nr->t2timer.data     = (unsigned long)sk;
-	nr->t2timer.function = &nr_t2timer_expiry;
-	nr->t2timer.expires  = jiffies + nr->t2;
+void nr_start_t2timer(struct sock *sk)
+{
+	nr_cb *nr = nr_sk(sk);
 
-	add_timer(&nr->t2timer);
+	mod_timer(&nr->t2timer, jiffies + nr->t2);
 }
 
 void nr_start_t4timer(struct sock *sk)
 {
 	nr_cb *nr = nr_sk(sk);
 
-	del_timer(&nr->t4timer);
-
-	nr->t4timer.data     = (unsigned long)sk;
-	nr->t4timer.function = &nr_t4timer_expiry;
-	nr->t4timer.expires  = jiffies + nr->t4;
-
-	add_timer(&nr->t4timer);
+	mod_timer(&nr->t4timer, jiffies + nr->t4);
 }
 
 void nr_start_idletimer(struct sock *sk)
 {
 	nr_cb *nr = nr_sk(sk);
 
-	del_timer(&nr->idletimer);
-
-	if (nr->idle > 0) {
-		nr->idletimer.data     = (unsigned long)sk;
-		nr->idletimer.function = &nr_idletimer_expiry;
-		nr->idletimer.expires  = jiffies + nr->idle;
-
-		add_timer(&nr->idletimer);
-	}
+	if (nr->idle > 0)
+		mod_timer(&nr->idletimer, jiffies + nr->idle);
 }
 
 void nr_start_heartbeat(struct sock *sk)
 {
-	del_timer(&sk->sk_timer);
-
-	sk->sk_timer.data     = (unsigned long)sk;
-	sk->sk_timer.function = &nr_heartbeat_expiry;
-	sk->sk_timer.expires  = jiffies + 5 * HZ;
-
-	add_timer(&sk->sk_timer);
+	mod_timer(&sk->sk_timer, jiffies + 5 * HZ);
 }
 
 void nr_stop_t1timer(struct sock *sk)



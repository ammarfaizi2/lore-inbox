Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTJAOH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTJAOH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:07:56 -0400
Received: from [61.95.227.64] ([61.95.227.64]:29596 "EHLO gateway.gsecone.com")
	by vger.kernel.org with ESMTP id S262106AbTJAOHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:07:46 -0400
Subject: [PATCH 2.6.0-test6][ROSE] timer cleanups (and couple of fixes)
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: netdev@oss.sgi.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Global Security One
Message-Id: <1065017300.7194.318.camel@lima.royalchallenge.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 01 Oct 2003 19:38:20 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



1. Use mod_timer
2. Use del_timer_sync in rose_loopback_clear 
3. Use static timer initializer
4. set skb->destructor = NULL wherever skb->sk = NULL before kfree_skb(skb)

I am not clear why skb->sk is set to NULL in the exit path in rose_loopback_clear.
Isn't it sufficient to purge the entire queue?

Let me know if this is the right fix.

 af_rose.c       |   10 +++------
 rose_link.c     |   21 +++++++++---------
 rose_loopback.c |   30 +++++++--------------------
 rose_route.c    |    7 ++----
 rose_timer.c    |   62 ++++++++++++++++++--------------------------------------
 5 files changed, 46 insertions(+), 84 deletions(-)

diff -urN -X dontdiff linux-2.6.0-test6/net/rose/af_rose.c linux-2.6.0-test6-nvk/net/rose/af_rose.c
--- linux-2.6.0-test6/net/rose/af_rose.c	2003-10-01 14:03:23.000000000 +0530
+++ linux-2.6.0-test6-nvk/net/rose/af_rose.c	2003-10-01 18:49:28.000000000 +0530
@@ -64,6 +64,7 @@
 
 ax25_address rose_callsign;
 
+void rose_init_timers(struct sock *sk);
 /*
  *	Convert a ROSE address into text.
  */
@@ -353,10 +354,8 @@
 	if (atomic_read(&sk->sk_wmem_alloc) ||
 	    atomic_read(&sk->sk_rmem_alloc)) {
 		/* Defer: outstanding buffers */
-		init_timer(&sk->sk_timer);
 		sk->sk_timer.expires  = jiffies + 10 * HZ;
 		sk->sk_timer.function = rose_destroy_timer;
-		sk->sk_timer.data     = (unsigned long)sk;
 		add_timer(&sk->sk_timer);
 	} else
 		sk_free(sk);
@@ -529,8 +528,7 @@
 	sock->ops    = &rose_proto_ops;
 	sk->sk_protocol = protocol;
 
-	init_timer(&rose->timer);
-	init_timer(&rose->idletimer);
+	rose_init_timers(sk);
 
 	rose->t1   = sysctl_rose_call_request_timeout;
 	rose->t2   = sysctl_rose_reset_request_timeout;
@@ -576,8 +574,7 @@
 	sk->sk_sleep    = osk->sk_sleep;
 	sk->sk_zapped   = osk->sk_zapped;
 
-	init_timer(&rose->timer);
-	init_timer(&rose->idletimer);
+	rose_init_timers(sk);
 
 	orose		= rose_sk(osk);
 	rose->t1	= orose->t1;
@@ -883,6 +880,7 @@
 
 	/* Now attach up the new socket */
 	skb->sk = NULL;
+	skb->destructor = NULL;
 	kfree_skb(skb);
 	sk->sk_ack_backlog--;
 	newsock->sk = newsk;
diff -urN -X dontdiff linux-2.6.0-test6/net/rose/rose_link.c linux-2.6.0-test6-nvk/net/rose/rose_link.c
--- linux-2.6.0-test6/net/rose/rose_link.c	2003-09-09 11:12:05.000000000 +0530
+++ linux-2.6.0-test6-nvk/net/rose/rose_link.c	2003-10-01 17:41:54.000000000 +0530
@@ -31,26 +31,25 @@
 static void rose_ftimer_expiry(unsigned long);
 static void rose_t0timer_expiry(unsigned long);
 
-void rose_start_ftimer(struct rose_neigh *neigh)
+void rose_neigh_init_timers(struct rose_neigh *neigh)
 {
-	del_timer(&neigh->ftimer);
+	init_timer(&neigh->t0timer);
+	neigh->t0timer.data     = (unsigned long)neigh;
+	neigh->t0timer.function = &rose_t0timer_expiry;
 
+	init_timer(&neigh->ftimer);
 	neigh->ftimer.data     = (unsigned long)neigh;
 	neigh->ftimer.function = &rose_ftimer_expiry;
-	neigh->ftimer.expires  = jiffies + sysctl_rose_link_fail_timeout;
+}
 
-	add_timer(&neigh->ftimer);
+void rose_start_ftimer(struct rose_neigh *neigh)
+{
+	mod_timer(&neigh->ftimer, jiffies + sysctl_rose_link_fail_timeout);
 }
 
 void rose_start_t0timer(struct rose_neigh *neigh)
 {
-	del_timer(&neigh->t0timer);
-
-	neigh->t0timer.data     = (unsigned long)neigh;
-	neigh->t0timer.function = &rose_t0timer_expiry;
-	neigh->t0timer.expires  = jiffies + sysctl_rose_restart_request_timeout;
-
-	add_timer(&neigh->t0timer);
+	mod_timer(&neigh->t0timer, jiffies + sysctl_rose_restart_request_timeout);
 }
 
 void rose_stop_ftimer(struct rose_neigh *neigh)
diff -urN -X dontdiff linux-2.6.0-test6/net/rose/rose_loopback.c linux-2.6.0-test6-nvk/net/rose/rose_loopback.c
--- linux-2.6.0-test6/net/rose/rose_loopback.c	2003-09-09 11:12:05.000000000 +0530
+++ linux-2.6.0-test6-nvk/net/rose/rose_loopback.c	2003-10-01 19:29:42.000000000 +0530
@@ -14,19 +14,17 @@
 #include <net/rose.h>
 #include <linux/init.h>
 
-static struct sk_buff_head loopback_queue;
-static struct timer_list loopback_timer;
+static void rose_loopback_timer(unsigned long);
 
-static void rose_set_loopback_timer(void);
+static struct sk_buff_head loopback_queue;
+static struct timer_list loopback_timer = TIMER_INITIALIZER(rose_loopback_timer, 0, 0);
 
-void rose_loopback_init(void)
+void __init rose_loopback_init(void)
 {
 	skb_queue_head_init(&loopback_queue);
-
-	init_timer(&loopback_timer);
 }
 
-static int rose_loopback_running(void)
+static inline int rose_loopback_running(void)
 {
 	return timer_pending(&loopback_timer);
 }
@@ -43,25 +41,12 @@
 		skb_queue_tail(&loopback_queue, skbn);
 
 		if (!rose_loopback_running())
-			rose_set_loopback_timer();
+			mod_timer(&loopback_timer, jiffies + 10);
 	}
 
 	return 1;
 }
 
-static void rose_loopback_timer(unsigned long);
-
-static void rose_set_loopback_timer(void)
-{
-	del_timer(&loopback_timer);
-
-	loopback_timer.data     = 0;
-	loopback_timer.function = &rose_loopback_timer;
-	loopback_timer.expires  = jiffies + 10;
-
-	add_timer(&loopback_timer);
-}
-
 static void rose_loopback_timer(unsigned long param)
 {
 	struct sk_buff *skb;
@@ -102,10 +87,11 @@
 {
 	struct sk_buff *skb;
 
-	del_timer(&loopback_timer);
+	del_timer_sync(&loopback_timer);
 
 	while ((skb = skb_dequeue(&loopback_queue)) != NULL) {
 		skb->sk = NULL;
+		skb->destructor = NULL;
 		kfree_skb(skb);
 	}
 }
diff -urN -X dontdiff linux-2.6.0-test6/net/rose/rose_route.c linux-2.6.0-test6-nvk/net/rose/rose_route.c
--- linux-2.6.0-test6/net/rose/rose_route.c	2003-10-01 14:03:23.000000000 +0530
+++ linux-2.6.0-test6-nvk/net/rose/rose_route.c	2003-10-01 17:41:54.000000000 +0530
@@ -49,6 +49,7 @@
 struct rose_neigh *rose_loopback_neigh;
 
 static void rose_remove_neigh(struct rose_neigh *);
+void rose_neigh_init_timers(struct rose_neigh *);
 
 /*
  *	Add a new route to a node, and in the process add the node and the
@@ -106,8 +107,7 @@
 
 		skb_queue_head_init(&rose_neigh->queue);
 
-		init_timer(&rose_neigh->ftimer);
-		init_timer(&rose_neigh->t0timer);
+		rose_neigh_init_timers(rose_neigh);
 
 		if (rose_route->ndigis != 0) {
 			if ((rose_neigh->digipeat = kmalloc(sizeof(ax25_digi), GFP_KERNEL)) == NULL) {
@@ -389,8 +389,7 @@
 
 	skb_queue_head_init(&rose_loopback_neigh->queue);
 
-	init_timer(&rose_loopback_neigh->ftimer);
-	init_timer(&rose_loopback_neigh->t0timer);
+	rose_neigh_init_timers(rose_loopback_neigh);
 
 	spin_lock_bh(&rose_neigh_list_lock);
 	rose_loopback_neigh->next = rose_neigh_list;
diff -urN -X dontdiff linux-2.6.0-test6/net/rose/rose_timer.c linux-2.6.0-test6-nvk/net/rose/rose_timer.c
--- linux-2.6.0-test6/net/rose/rose_timer.c	2003-09-09 11:12:05.000000000 +0530
+++ linux-2.6.0-test6-nvk/net/rose/rose_timer.c	2003-10-01 17:41:54.000000000 +0530
@@ -33,82 +33,62 @@
 static void rose_timer_expiry(unsigned long);
 static void rose_idletimer_expiry(unsigned long);
 
-void rose_start_heartbeat(struct sock *sk)
+void rose_init_timers(struct sock *sk)
 {
-	del_timer(&sk->sk_timer);
+	rose_cb *rose = rose_sk(sk);
+
+	init_timer(&rose->timer);
+	rose->timer.data     = (unsigned long)sk;
+	rose->timer.function = &rose_timer_expiry;
 
+	init_timer(&rose->idletimer);
+	rose->idletimer.data     = (unsigned long)sk;
+	rose->idletimer.function = &rose_idletimer_expiry;
+
+	/* initialized by sock_init_data */
 	sk->sk_timer.data     = (unsigned long)sk;
 	sk->sk_timer.function = &rose_heartbeat_expiry;
-	sk->sk_timer.expires  = jiffies + 5 * HZ;
+}
 
-	add_timer(&sk->sk_timer);
+void rose_start_heartbeat(struct sock *sk)
+{
+	mod_timer(&sk->sk_timer, jiffies + 5 * HZ);
 }
 
 void rose_start_t1timer(struct sock *sk)
 {
 	rose_cb *rose = rose_sk(sk);
 
-	del_timer(&rose->timer);
-
-	rose->timer.data     = (unsigned long)sk;
-	rose->timer.function = &rose_timer_expiry;
-	rose->timer.expires  = jiffies + rose->t1;
-
-	add_timer(&rose->timer);
+	mod_timer(&rose->timer, jiffies + rose->t1);
 }
 
 void rose_start_t2timer(struct sock *sk)
 {
 	rose_cb *rose = rose_sk(sk);
 
-	del_timer(&rose->timer);
-
-	rose->timer.data     = (unsigned long)sk;
-	rose->timer.function = &rose_timer_expiry;
-	rose->timer.expires  = jiffies + rose->t2;
-
-	add_timer(&rose->timer);
+	mod_timer(&rose->timer, jiffies + rose->t2);
 }
 
 void rose_start_t3timer(struct sock *sk)
 {
 	rose_cb *rose = rose_sk(sk);
 
-	del_timer(&rose->timer);
-
-	rose->timer.data     = (unsigned long)sk;
-	rose->timer.function = &rose_timer_expiry;
-	rose->timer.expires  = jiffies + rose->t3;
-
-	add_timer(&rose->timer);
+	mod_timer(&rose->timer, jiffies + rose->t3);
 }
 
 void rose_start_hbtimer(struct sock *sk)
 {
 	rose_cb *rose = rose_sk(sk);
 
-	del_timer(&rose->timer);
-
-	rose->timer.data     = (unsigned long)sk;
-	rose->timer.function = &rose_timer_expiry;
-	rose->timer.expires  = jiffies + rose->hb;
-
-	add_timer(&rose->timer);
+	mod_timer(&rose->timer, jiffies + rose->hb);
 }
 
 void rose_start_idletimer(struct sock *sk)
 {
 	rose_cb *rose = rose_sk(sk);
 
-	del_timer(&rose->idletimer);
-
-	if (rose->idle > 0) {
-		rose->idletimer.data     = (unsigned long)sk;
-		rose->idletimer.function = &rose_idletimer_expiry;
-		rose->idletimer.expires  = jiffies + rose->idle;
-
-		add_timer(&rose->idletimer);
-	}
+	if (rose->idle > 0)
+		mod_timer(&rose->idletimer, jiffies + rose->idle);
 }
 
 void rose_stop_heartbeat(struct sock *sk)




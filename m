Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSJHKto>; Tue, 8 Oct 2002 06:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbSJHKto>; Tue, 8 Oct 2002 06:49:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29569 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261857AbSJHKtm>;
	Tue, 8 Oct 2002 06:49:42 -0400
Date: Tue, 8 Oct 2002 13:05:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.40-mm2
In-Reply-To: <3DA0A144.8070301@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0210081303090.29540-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Oct 2002, Dave Hansen wrote:

> cc'ing Ingo, because I think this might be related to the timer bh
> removal.

could you try the attached patch against 2.5.41, does it help? It fixes
the bugs found so far plus makes del_timer_sync() a bit more robust by
re-checking timer pending-ness before exiting. There is one type of code
that might have relied on this kind of behavior of the old timer code.

	Ingo

--- linux/kernel/timer.c.orig	2002-10-08 12:39:46.000000000 +0200
+++ linux/kernel/timer.c	2002-10-08 12:49:50.000000000 +0200
@@ -266,29 +266,31 @@
 int del_timer_sync(timer_t *timer)
 {
 	tvec_base_t *base = tvec_bases;
-	int i, ret;
+	int i, ret = 0;
 
-	ret = del_timer(timer);
+del_again:
+	ret += del_timer(timer);
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for (i = 0; i < NR_CPUS; i++, base++) {
 		if (!cpu_online(i))
 			continue;
 		if (base->running_timer == timer) {
 			while (base->running_timer == timer) {
 				cpu_relax();
-				preempt_disable();
-				preempt_enable();
+				preempt_check_resched();
 			}
 			break;
 		}
-		base++;
 	}
+	if (timer_pending(timer))
+		goto del_again;
+
 	return ret;
 }
 #endif
 
 
-static void cascade(tvec_base_t *base, tvec_t *tv)
+static int cascade(tvec_base_t *base, tvec_t *tv)
 {
 	/* cascade all the timers from tv up one level */
 	struct list_head *head, *curr, *next;
@@ -310,7 +312,8 @@
 		curr = next;
 	}
 	INIT_LIST_HEAD(head);
-	tv->index = (tv->index + 1) & TVN_MASK;
+
+	return tv->index = (tv->index + 1) & TVN_MASK;
 }
 
 /***
@@ -322,26 +325,18 @@
  */
 static inline void __run_timers(tvec_base_t *base)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&base->lock, flags);
+	spin_lock_irq(&base->lock);
 	while ((long)(jiffies - base->timer_jiffies) >= 0) {
 		struct list_head *head, *curr;
 
 		/*
 		 * Cascade timers:
 		 */
-		if (!base->tv1.index) {
-			cascade(base, &base->tv2);
-			if (base->tv2.index == 1) {
-				cascade(base, &base->tv3);
-				if (base->tv3.index == 1) {
-					cascade(base, &base->tv4);
-					if (base->tv4.index == 1)
-						cascade(base, &base->tv5);
-				}
-			}
-		}
+		if (!base->tv1.index &&
+			(cascade(base, &base->tv2) == 1) &&
+				(cascade(base, &base->tv3) == 1) &&
+					cascade(base, &base->tv4) == 1)
+			cascade(base, &base->tv5);
 repeat:
 		head = base->tv1.vec + base->tv1.index;
 		curr = head->next;
@@ -370,7 +365,7 @@
 #if CONFIG_SMP
 	base->running_timer = NULL;
 #endif
-	spin_unlock_irqrestore(&base->lock, flags);
+	spin_unlock_irq(&base->lock);
 }
 
 /******************************************************************/


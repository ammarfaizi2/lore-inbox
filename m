Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbSJJG1u>; Thu, 10 Oct 2002 02:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262068AbSJJG1u>; Thu, 10 Oct 2002 02:27:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49032 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262065AbSJJG1t>;
	Thu, 10 Oct 2002 02:27:49 -0400
Date: Thu, 10 Oct 2002 08:45:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: 2.5.41-mm2
In-Reply-To: <3DA512B1.63287C02@digeo.com>
Message-ID: <Pine.LNX.4.44.0210100841280.4384-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Andrew Morton wrote:

>   Ingo's original per-cpu-pages patch was said to be mainly beneficial
>   for web-serving type things, but no specweb testing has been possible
>   for a week or two due to oopses in the timer code.

i sent my latest timer patch to Dave Hansen but have not heard back since.
I've attached the latest patch, this kernel also printks a bit more when
it sees invalid timer usage.

in any case, the oops Dave was seeing i believe was fixed by Linus (the
PgUp fix), and it was in the keyboard code. If there's anything else still
going on then the attached patch should either fix it or provide further
clues.

	Ingo

--- linux/kernel/timer.c.orig	2002-10-09 10:04:51.000000000 +0200
+++ linux/kernel/timer.c	2002-10-09 10:06:59.000000000 +0200
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
@@ -360,7 +355,10 @@
 			base->running_timer = timer;
 #endif
 			spin_unlock_irq(&base->lock);
-			fn(data);
+			if (!fn)
+				printk("Bad: timer %p has NULL fn. (data: %08lx)\n", timer, data);
+			else
+				fn(data);
 			spin_lock_irq(&base->lock);
 			goto repeat;
 		}
@@ -370,7 +368,7 @@
 #if CONFIG_SMP
 	base->running_timer = NULL;
 #endif
-	spin_unlock_irqrestore(&base->lock, flags);
+	spin_unlock_irq(&base->lock);
 }
 
 /******************************************************************/


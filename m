Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbSJIH4w>; Wed, 9 Oct 2002 03:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSJIH4w>; Wed, 9 Oct 2002 03:56:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46979 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261415AbSJIH4v>;
	Wed, 9 Oct 2002 03:56:51 -0400
Date: Wed, 9 Oct 2002 10:12:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.40-mm2
In-Reply-To: <3DA30B28.8070504@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0210091009020.6815-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Oct 2002, Dave Hansen wrote:

> Hehe.  That'll teach me to be optimistic.  This is unprocessed, but the
> EIP in tvec_bases should tell the whole story.  Something _nasty_ is
> going on.

could you try BK-curr with/without my latest patch? Linus and Vojtech
found and fixed a bug in the keyboard code that caused timer tasklet
oopses.

if it still keeps crashing then please add a printk like this:

	if (!fn)
		printk("Bad: NULL timer fn of timer %p (data %p).\n", 
				timer, data);
	else
		fn(data)

it's the fn's NULL-ness that causes the crashes, right?

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


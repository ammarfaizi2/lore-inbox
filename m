Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVD0VVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVD0VVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 17:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVD0VVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 17:21:14 -0400
Received: from mail.dif.dk ([193.138.115.101]:57756 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262027AbVD0VVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 17:21:02 -0400
Date: Wed, 27 Apr 2005 23:24:22 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Robert Love <rml@novell.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] preempt_count is int - remove cast and don't assign to
 unsigned type
Message-ID: <Pine.LNX.4.62.0504272310030.2481@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

Seeing that you merged my streamline-preempt_count-type-across-archs.patch 
(thanks), I believe the small patch below is in order. Please consider it 
for inclusion.


In kernel/sched.c the return value from preempt_count() is cast to an int. 
That made sense when preempt_count was defined as different types on 
different archs, but now that all archs use int for preempt_count the cast 
is not needed and should go away. The patch removes the cast.

In kernel/timer.c the return value from preempt_count() is assigned to a 
variable of type u32 and then that unsigned value is later compared to 
preempt_count(). Since preempt_count() returns an int, an int is what 
should be used to store its return value. Storing the result in an 
unsigned 32bit integer made a tiny bit of sense back when preempt_count 
was different types on different archs, but no more - let's not play 
signed vs unsigned comparison games when we don't have to. The patch 
modifies the code to use an int to hold the value.
While I was around that bit of code I also made two changes to a nearby 
(related) printk() - I modified it to specify the loglevel explicitly and 
also broke the line into a few pieces to avoid it being longer than 80 
chars and clarified the text a bit.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 kernel/sched.c |    2 +-
 kernel/timer.c |    8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)


--- linux-2.6.12-rc2-mm3-orig/kernel/sched.c.old	2005-04-27 23:05:37.000000000 +0200
+++ linux-2.6.12-rc2-mm3-orig/kernel/sched.c	2005-04-27 23:07:29.000000000 +0200
@@ -2624,7 +2624,7 @@ void fastcall add_preempt_count(int val)
 	/*
 	 * Underflow?
 	 */
-	BUG_ON(((int)preempt_count() < 0));
+	BUG_ON((preempt_count() < 0));
 	preempt_count() += val;
 	/*
 	 * Spinlock count overflowing soon?
--- linux-2.6.12-rc2-mm3-orig/kernel/timer.c	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/kernel/timer.c	2005-04-27 23:04:36.000000000 +0200
@@ -459,10 +459,14 @@ static inline void __run_timers(tvec_bas
 			detach_timer(timer, 1);
 			spin_unlock_irq(&base->t_base.lock);
 			{
-				u32 preempt_count = preempt_count();
+				int preempt_count = preempt_count();
 				fn(data);
 				if (preempt_count != preempt_count()) {
-					printk("huh, entered %p with %08x, exited with %08x?\n", fn, preempt_count, preempt_count());
+					printk(KERN_WARNING "huh, entered %p "
+					       "with preempt_count %08x, exited"
+					       " with %08x?\n",
+					       fn, preempt_count,
+					       preempt_count());
 					BUG();
 				}
 			}



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVCCTnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVCCTnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVCCTnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:43:06 -0500
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:30598 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S262520AbVCCT2r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:28:47 -0500
Message-ID: <42276746.6060600@ru.mvista.com>
Date: Thu, 03 Mar 2005 22:36:38 +0300
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, deactivate() scheduling issue
References: <20050204100347.GA13186@elte.hu> <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org> <20050209115121.GA13608@elte.hu> <Pine.LNX.4.58.0502091233360.4599@echo.lysdexia.org> <20050210075234.GC9436@elte.hu>
In-Reply-To: <20050210075234.GC9436@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------060601040702020004030807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060601040702020004030807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

please consider the following scenario for full RT kernel.

Task A is running then an irq is occured which in turn wakes up irq 
related thread (B) of a higher priority than A.

my current understanding that actual context switch between A and B will 
occure at preempt_schedule_irq() on the "return form irq " path.

in this case the following "if" statement in __schedule() always returns 
false since  preempt_schedule_irq() always sets up  PREEMPT_ACTIVE 
before __schedule() call.

         if ((prev->state & ~TASK_RUNNING_MUTEX) &&
                         !(preempt_count() & PREEMPT_ACTIVE)) {

as result the deactivate() is never called for preempted task A in this 
scenario. BUt if the task A is preempted while not in TASK_RUNNING state 
such behaviour seems incorrect since we get a task in not TASK_RUNNING 
state linked into a run queue.

An example:

drivers/net/irda/sir_dev.c: 76 (2.6.10 kernel)

         spin_lock_irqsave(&dev->tx_lock, flags); /* serialize th other 
tx operations */
         while (dev->tx_buff.len > 0) {    /* wait until tx idle */
                 spin_unlock_irqrestore(&dev->tx_lock, flags);
76:             set_current_state(TASK_UNINTERRUPTIBLE);
                 schedule_timeout(msecs_to_jiffies(10));
                 spin_lock_irqsave(&dev->tx_lock, flags);
         }

At  line 76 irqs are enabled, preemption is enabled.
Let assume the task A executes this code and gets preempted right after 
line 76. Task state is TASK_UNINTERRUPTIBLE but it will not be 
deactevated. Of cource this is the bug in set_current_state() 
utilization in this particular driver but schedule stuff should be 
robust to such bugs I believe. There are a lot such bugs in the kernel I 
believe.

Not sure what the actual reason for !(preempt_count() & PREEMPT_ACTIVE)) 
   condition is but if it's just a sort of optimization (not remove a 
task from run queue if it was preemped in TASK_RUNNING state) then 
probably it should be removed in order to save correctness. Patch attached.

	Eugeny


--------------060601040702020004030807
Content-Type: text/plain;
 name="sched.c.deactivate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched.c.deactivate.patch"

--- sched.c.orig	2005-03-03 22:35:16.000000000 +0300
+++ sched.c	2005-03-03 22:34:58.000000000 +0300
@@ -2891,8 +2891,7 @@
 	spin_lock_irq(&rq->lock);
 
 	switch_count = &prev->nvcsw; // TODO: temporary - to see it in vmstat
-	if ((prev->state & ~TASK_RUNNING_MUTEX) &&
-                       !(preempt_count() & PREEMPT_ACTIVE)) {
+	if ((prev->state & ~TASK_RUNNING_MUTEX)) {
  		switch_count = &prev->nvcsw;
 		if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
 				unlikely(signal_pending(prev))))

--------------060601040702020004030807--


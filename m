Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVC2Ivi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVC2Ivi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVC2Irw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:47:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:61864 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262219AbVC2Iqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:46:49 -0500
Date: Tue, 29 Mar 2005 10:45:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Eugeny S. Mints" <emints@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, deactivate() scheduling issue
Message-ID: <20050329084538.GB6507@elte.hu>
References: <20050204100347.GA13186@elte.hu> <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org> <20050209115121.GA13608@elte.hu> <Pine.LNX.4.58.0502091233360.4599@echo.lysdexia.org> <20050210075234.GC9436@elte.hu> <42276746.6060600@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42276746.6060600@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eugeny S. Mints <emints@ru.mvista.com> wrote:

> please consider the following scenario for full RT kernel.
> 
> Task A is running then an irq is occured which in turn wakes up irq 
> related thread (B) of a higher priority than A.
> 
> my current understanding that actual context switch between A and B will 
> occure at preempt_schedule_irq() on the "return form irq " path.
> 
> in this case the following "if" statement in __schedule() always returns 
> false since  preempt_schedule_irq() always sets up  PREEMPT_ACTIVE 
> before __schedule() call.
> 
>         if ((prev->state & ~TASK_RUNNING_MUTEX) &&
>                         !(preempt_count() & PREEMPT_ACTIVE)) {
> 
> as result the deactivate() is never called for preempted task A in this 
> scenario. BUt if the task A is preempted while not in TASK_RUNNING state 
> such behaviour seems incorrect since we get a task in not TASK_RUNNING 
> state linked into a run queue.

this behavior is intentional: 'forced preemption' (of any sort, even in 
the upstream kernel's CONFIG_PREEMPT model) should not impact the task's 
state. So it does not modify p->state. [ The TASK_RUNNING_MUTEX state 
furthermore enables wakeups to occur in an invariant way: even though 
technically the tasks are on the runqueue, a 'normal' wakeup is still 
noticed and later on acted upon.]

this is very important for forced preemption to not impact the coding 
model of kernel code that is normally tested with !PREEMPT. (the 
TASK_RUNNING_MUTEX scheduler feature furthermore enables us to preempt 
without impacting wakeup logic.)

> An example:
> 
> drivers/net/irda/sir_dev.c: 76 (2.6.10 kernel)
> 
>         spin_lock_irqsave(&dev->tx_lock, flags); /* serialize th other 
> tx operations */
>         while (dev->tx_buff.len > 0) {    /* wait until tx idle */
>                 spin_unlock_irqrestore(&dev->tx_lock, flags);
> 76:             set_current_state(TASK_UNINTERRUPTIBLE);
>                 schedule_timeout(msecs_to_jiffies(10));
>                 spin_lock_irqsave(&dev->tx_lock, flags);
>         }
> 
> At  line 76 irqs are enabled, preemption is enabled.
> Let assume the task A executes this code and gets preempted right after 
> line 76. Task state is TASK_UNINTERRUPTIBLE but it will not be 
> deactevated. Of cource this is the bug in set_current_state() 
> utilization in this particular driver but schedule stuff should be 
> robust to such bugs I believe. There are a lot such bugs in the kernel I 
> believe.

it is not a problem to have tasks with TASK_UNINTERRUPTIBLE on the 
runqueue - this happens every day with CONFIG_PREEMPT kernels, and it's 
fully intentional. Can you see any bugs caused by this behavior?

	Ingo

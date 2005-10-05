Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbVJEOlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbVJEOlG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVJEOlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:41:05 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:64174 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965183AbVJEOlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:41:04 -0400
Date: Wed, 5 Oct 2005 16:41:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051005144127.GA31755@elte.hu>
References: <20051004084405.GA24296@elte.hu> <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo,
> 
> I just notice that I get the following output:
> 
> BUG: gdm:4351 task might have lost a preemption check!
>  [<c010433f>] dump_stack+0x1f/0x30 (20)
>  [<c011c06f>] preempt_enable_no_resched+0x5f/0x70 (20)
>  [<c011b6c9>] sys_sched_yield+0x69/0xb0 (24)
>  [<c01033d6>] syscall_call+0x7/0xb (-8116)
> ---------------------------
> | preempt count: 00000000 ]
> | 0-level deep critical section nesting:
> ----------------------------------------
> 
> ------------------------------
> | showing all locks held by: |  (gdm/4351 [dbb727a0, 118]):
> ------------------------------
> 
> 
> I looked at this a little and the offending code is here in
> sys_sched_yield:
> 
> 	/*
> 	 * Since we are going to call schedule() anyway, there's
> 	 * no need to preempt or enable interrupts:
> 	 */
> 	spin_unlock_no_resched(&rq->lock);
> 
> 	__schedule();
> 
> So what's the reason for the message?  Is it to detect when a 
> preemption count goes to zero and isn't rescheduled?  At least in this 
> part of the kernel it's ok because it is just about to call schedule.  
> So is there some way to flag this call to not produce the message?  
> Since the message is only outputed once, it seems useless if it only 
> gets outputted on a false positive.

the patch below should solve this. I've added the warning to 
preempt_enable_no_resched() because we had bugs in this area, and i 
wanted to have a chance to review all 'potentially problematic' places.  
So i'm changing them to __preempt_enable_no_resched() when they turn out 
to be safe. (In the future we'll likely remove the debugging message and 
get rid of __preempt_enable_no_resched().)

	Ingo

Index: linux/include/linux/spinlock_api_up.h
===================================================================
--- linux.orig/include/linux/spinlock_api_up.h
+++ linux/include/linux/spinlock_api_up.h
@@ -45,7 +45,7 @@
   do { preempt_enable(); __release(lock); (void)(lock); } while (0)
 
 #define __UNLOCK_NO_RESCHED(lock) \
-  do { preempt_enable_no_resched(); __release(lock); (void)(lock); } while (0)
+  do { __preempt_enable_no_resched(); __release(lock); (void)(lock); } while (0)
 
 #define __UNLOCK_BH(lock) \
   do { preempt_enable_no_resched(); local_bh_enable(); __release(lock); (void)(lock); } while (0)

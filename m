Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUHNMbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUHNMbI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 08:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUHNMbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 08:31:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6882 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261184AbUHNMbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 08:31:02 -0400
Date: Sat, 14 Aug 2004 14:32:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040814123240.GA11034@elte.hu>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <411DF776.6090102@superbug.demon.co.uk> <20040814115139.GB9705@elte.hu> <411E0361.9020407@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411E0361.9020407@superbug.demon.co.uk>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* James Courtier-Dutton <James@superbug.demon.co.uk> wrote:

> This is just for info, now that we have a nice latency testing tool,
> we might as well collect some useful traces that we can later work on.
> 
> Here is a trace showing a latency of 39034us. 
> http://www.superbug.demon.co.uk/kernel/

> This looks to me to be a bug somewhere. Either in the O7 patch, or in
> the kernel. Surely, do_IRQ should happen quickly, and not take 39ms.

something's wrong indeed. Is this an x86 SMP system? If it's SMP then
please apply the patch below (ontop of -O7), it fixes an SMP false
positive bug in the latency timing code.

the process is looping somewhere. Here are the non-IRQ trace entries:

 0.001ms (+0.000ms): __switch_to (schedule)
 0.002ms (+0.000ms): finish_task_switch (schedule)
 0.002ms (+0.000ms): __preempt_spin_lock (schedule)
... [lots of IRQs] ...
 38.126ms (+0.362ms): preempt_schedule (schedule)
 38.126ms (+0.000ms): sched_clock (schedule)
 38.127ms (+0.000ms): find_next_bit (schedule)
 38.127ms (+0.000ms): task_timeslice (schedule)

this shows that we are looping in __preempt_spin_lock() - most likely
via schedule()'s reqacquire_kernel_lock() code.

i.e. another CPU is holding the big kernel lock and this CPU is looping. 
_but_ this CPU is fully preemptible so the trace produces this false
positive.

	Ingo

--- linux/kernel/sched.c.orig2	
+++ linux/kernel/sched.c	
@@ -4210,7 +4210,9 @@ void __sched __preempt_spin_lock(spinloc
 	do {
 		preempt_enable();
 		while (spin_is_locked(lock)) {
+			preempt_disable();
 			touch_preempt_timing();
+			preempt_enable();
 			cpu_relax();
 		}
 		preempt_disable();
@@ -4229,7 +4231,9 @@ void __sched __preempt_write_lock(rwlock
 	do {
 		preempt_enable();
 		while (rwlock_is_locked(lock)) {
+			preempt_disable();
 			touch_preempt_timing();
+			preempt_enable();
 			cpu_relax();
 		}
 		preempt_disable();

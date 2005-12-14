Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbVLNNsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVLNNsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVLNNsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:48:38 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:47824 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932533AbVLNNsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:48:38 -0500
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution
	patches
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, john stultz <johnstul@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051214084333.GA20284@elte.hu>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
	 <1134507927.18921.26.camel@localhost.localdomain>
	 <20051214084019.GA18708@elte.hu>  <20051214084333.GA20284@elte.hu>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 08:48:00 -0500
Message-Id: <1134568080.18921.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 09:43 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > hm, in that case it should be base->running that protects against this 
> > case. Did you run an UP PREEMPT_RT kernel? In that case could you 
> > check whether the fix below resolves the crash too?
> 
> try the patch below instead. (Thomas pointed out that the correct 
> dependency in this case is PREEMPT_SOFTIRQS)
> 
> 	Ingo
> 
> Index: linux/kernel/hrtimer.c
> ===================================================================
> --- linux.orig/kernel/hrtimer.c
> +++ linux/kernel/hrtimer.c
> @@ -118,7 +118,7 @@ static DEFINE_PER_CPU(struct hrtimer_bas
>   * Functions and macros which are different for UP/SMP systems are kept in a
>   * single place
>   */
> -#ifdef CONFIG_SMP
> +#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
>  
>  #define set_curr_timer(b, t)		do { (b)->curr_timer = (t); } while (0)
>  

With the above patch, I get the following soft lockup.

BUG: jitter_inc:3085, possible softlockup detected on CPU#0!
 [<c0104223>] dump_stack+0x23/0x30 (20)
 [<c014c226>] softlockup_detected+0x46/0x60 (24)
 [<c014c301>] softlockup_tick+0xc1/0xd0 (20)
 [<c0126aaa>] update_process_times+0x8a/0x180 (32)
 [<c013e79a>] handle_tick_update+0x5a/0x70 (16)
 [<c013e609>] timer_interrupt+0x39/0x110 (24)
 [<c014c77d>] handle_IRQ_event+0x7d/0x110 (52)
 [<c014cbfd>] __do_IRQ+0xcd/0x170 (44)
 [<c0105724>] do_IRQ+0x44/0x60 (28)
 [<c0103ce6>] common_interrupt+0x1a/0x20 (80)
 [<c0136b98>] hrtimer_cancel+0x18/0x20 (16)
 [<c0339d6d>] schedule_hrtimer+0x4d/0xb0 (44)
 [<c013723e>] hrtimer_nanosleep+0x5e/0x130 (104)
 [<c0137383>] sys_nanosleep+0x73/0x80 (36)
 [<c010329a>] syscall_call+0x7/0xb (-8116)
---------------------------
| preempt count: 00010001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0142b8c>] .... add_preempt_count+0x1c/0x20
.....[<c0136264>] ..   ( <= lock_hrtimer_base+0x34/0x80)

The system is locked up with this periodically spitting out.  My only
recourse is to hit the big P button (or the litter r one).

And going into gdb, I get:

(gdb) li *0xc0136b98
0xc0136b98 is in hrtimer_cancel (kernel/hrtimer.c:671).
666     int hrtimer_cancel(struct hrtimer *timer)
667     {
668             for (;;) {
669                     int ret = hrtimer_try_to_cancel(timer);
670
671                     if (ret >= 0)
672                             return ret;
673             }
674     }
675

So it may not really be locked, and if I waited a couple of hours, it
might actually finish (the test usually takes a couple of minutes to
run, and I let it run here for about 20 minutes).

Yeah, the above code would be very bad if this happens after preempting
the running timer.

So the fix to this, in the case of preempting the softirq, that we need
to introduce some wait queue that will allow processes to wait for the
softirq to finish, and then the softirq will wake up all the processes.

Ingo, would something like that fly?

-- Steve



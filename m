Return-Path: <linux-kernel-owner+w=401wt.eu-S932761AbWLSMEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbWLSMEn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 07:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWLSMEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 07:04:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48003 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932761AbWLSMEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 07:04:42 -0500
Date: Tue, 19 Dec 2006 13:01:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] debugging feature: SysRq-Q to print timers
Message-ID: <20061219120150.GA27819@elte.hu>
References: <20061214225913.3338f677.akpm@osdl.org> <20061216000440.GY3388@stusta.de> <20061216075658.GA16116@elte.hu> <20061218153103.57860bf8.akpm@osdl.org> <20061218234549.GB32353@redhat.com> <20061218160019.988171f5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218160019.988171f5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > /proc/timer-list is useful for profiling applications doing 
> > excessive wakeups. With the move towards being tickless, this is 
> > more important than ever, and giving users the right tools to find 
> > these problems themselves is important.
> > 
> 
> oic.  Nobody ever tells me squat.  <updates changelog>
> 
> Your explanation doesn't explain why we need this info in a sysrq 
> triggerable form.
> 
> And what about /proc/timer-stat?

/proc/timer_stats does timer profiling. You start it via:

	echo 1 > /proc/timer_stats

and then the profile info gathers into /proc/timer_stats. Useful way to 
look at it is:

	sort -n /proc/timer_stats

for example:

Timer Stats Version: v0.1
   1,     0 swapper          page_writeback_init (wb_timer_fn)
   1,  1898 modprobe         neigh_table_init_no_netlink (neigh_periodic_timer)
   1,     1 init             schedule_timeout (process_timeout)
   1,     1 swapper          neigh_table_init_no_netlink (neigh_periodic_timer)
   1,  2700 hald-addon-stor  do_nanosleep (hrtimer_wakeup)
   1,     6 softirq-timer/0  __netdev_watchdog_up (dev_watchdog)
   2,     1 swapper          queue_delayed_work_on (delayed_work_timer_fn)
   2,     1 swapper          queue_delayed_work_on (delayed_work_timer_fn)
   2,   480 IRQ 218          e1000_intr_msi (e1000_watchdog)
   3,  2652 yum-updatesd     schedule_timeout (process_timeout)
   4,  2472 pcscd            do_nanosleep (hrtimer_wakeup)
   4,  7824 sshd             sk_reset_timer (tcp_write_timer)
  13,   428 insmod           usb_hcd_poll_rh_status (rh_timer_func)
  13,   428 insmod           usb_hcd_poll_rh_status (rh_timer_func)
  13,   437 insmod           usb_hcd_submit_urb (rh_timer_func)
  19,    21 softirq-net-rx/  sk_reset_timer (tcp_delack_timer)
 164,  1868 kondemand/0      queue_delayed_work_on (delayed_work_timer_fn)
 164,  1869 kondemand/1      queue_delayed_work_on (delayed_work_timer_fn)
 282,     0 swapper          hrtimer_stop_sched_tick (hrtimer_sched_tick)
 321,     0 swapper          hrtimer_stop_sched_tick (hrtimer_sched_tick)
 335,     0 swapper          hrtimer_restart_sched_tick (hrtimer_sched_tick)
 408,     0 swapper          hrtimer_restart_sched_tick (hrtimer_sched_tick)
1755 total events, 585.534 events/sec

this shows us that the kondemand kernel threads are causing 90% of the 
timeout events on this system.

/proc/timer_list shows all currently pending timers, and all the state 
of the hardware timers. That is a bit different from timer_stat but 
still very useful: it gives us a snapshot into the current state of the 
(hr)timer subsystem. I needed it to debug a couple of high-res timers 
subsystem bugs. The SysRq trigger was useful for things like timer 
related boot hangs. (It's also useful to catch excessive waiters during 
bootup.)

	Ingo

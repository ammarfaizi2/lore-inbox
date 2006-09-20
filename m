Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWITO1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWITO1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 10:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWITO1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 10:27:24 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:35515 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751547AbWITO1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 10:27:23 -0400
Date: Wed, 20 Sep 2006 16:19:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: 2.6.18-rt1
Message-ID: <20060920141907.GA30765@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded 
from the usual place:

   http://redhat.com/~mingo/realtime-preempt/

This port to the 2.6.18 codebase was very complex (given that 5 major 
features moved from -rt into 2.6.18: rtmutex, pi-futex, genirq, gtod and 
lockdep), so it took quite some time to finish, but in exchange it 
includes nice new features and also lots of bugfixes.

In particular, a nasty softirq performance bug has been fixed, which 
caused the "5x slowdown under TCP" bug reported to lkml - those TCP 
performance figures are now on par with vanilla performance.

The biggest new features are:

 - Dynticks (a tickless kernel). This is a new feature we implemented 
   ontop of hrtimers for the -hrt patchqueue and now we merged it to -rt 
   too. There's a new config option: CONFIG_NO_HZ, which if enabled, 
   produces a system with fewer timer interrupts. Currently i686 and 
   x86_64 are tested, but in general a hrtimers-ready platform needs 
   minimal changes to support dynticks too. (from Thomas Gleixner and 
   me, the x86_64 port is from Arjan van de Ven)

 - Timer expiry statistics feature from Thomas Gleixner: 
   CONFIG_TIMER_STATS. Enable/disable via "echo 1[0] > /proc/tstats", 
   display via "cat /proc/stats".

   This kernel feature tracks the starting site (and expiry function) of 
   expired timers (both timer_list timers and hrtimers), and the number 
   of times they expired. This is a nice tool for those who'd like to 
   minimize the amount of timer ticks on their battery-based systems. 
   Sample output:

 Timerstats sample period: 3.888770 s
   12,     0 swapper          hrtimer_stop_sched_tick (hrtimer_sched_tick)
   15,     1 swapper          hcd_submit_urb (rh_timer_func)
    4,   959 kedac            schedule_timeout (process_timeout)
    1,     0 swapper          page_writeback_init (wb_timer_fn)
   28,     0 swapper          hrtimer_stop_sched_tick (hrtimer_sched_tick)
   22,  2948 IRQ 4            tty_flip_buffer_push (delayed_work_timer_fn)
    3,  3100 bash             schedule_timeout (process_timeout)
    1,     1 swapper          queue_delayed_work_on (delayed_work_timer_fn)
    1,     1 swapper          queue_delayed_work_on (delayed_work_timer_fn)
    1,     1 swapper          neigh_table_init_no_netlink (neigh_periodic_timer)
    1,  2292 ip               __netdev_watchdog_up (dev_watchdog)
    1,    23 events/1         do_cache_clean (delayed_work_timer_fn)
 90 total events, 30.0 events/sec

 - There's also a new runtime-configurable kernel option under 
   /proc/sys/kernel/timeout_granularity that allows the coarser expiry 
   of timer_list timers, and hence better batching of timer expiry. 
   (hrtimers are not affected) The value of this option gives a 
   'multiplier' to the standard HZ granularity.

 - Lock validator ported to -rt: it now checks all the sleeping lock
   variants in -rt too. This helps us catch not only deadlocks but also 
   raw-lock candidates, sooner than before.

 - The latest High Resolution Timers queue from Thomas Gleixner with 
   initial support for ARM and PPC. (Kevin Hilman, Deepak Saksena, 
   Sergei Shtylyov)

 - The latest GTOD (Generic Time Of Day) queue from John Stultz,
   including NTP cleanups from Roman Zippel.

 - The latest genirq queue: more irq-chip-ization of i686 and x86_64, 
   MSI cleanups from Eric W. Biederman et al.

 - The latest preemptible-RCU queue from Paul E McKenney and Dipankar
   Sarma.

 - (assorted fixes and improvements.)

Right now i686 and x86_64 are boot-tested, and ARM is compile-tested. 
The other architectures likely wont even build yet. This being the first 
2.6.18 based release of -rt, some tester caution is called for.

to build a 2.6.18-rt1 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.18.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.18-rt1

as usual, bugreports, fixes and suggestions are welcome,

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWFSWSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWFSWSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWFSWSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:18:11 -0400
Received: from mail.timesys.com ([65.117.135.102]:30151 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S964952AbWFSWSK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:18:10 -0400
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and
	dynamic HZ
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: mgross@linux.intel.com
Cc: Con Kolivas <kernel@kolivas.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060619215822.GA4178@linux.intel.com>
References: <1150643426.27073.17.camel@localhost.localdomain>
	 <449580CA.2060704@gmail.com>
	 <1150660202.27073.23.camel@localhost.localdomain>
	 <200606192209.38403.kernel@kolivas.org>
	 <1150720304.27073.70.camel@localhost.localdomain>
	 <20060619215822.GA4178@linux.intel.com>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 00:19:32 +0200
Message-Id: <1150755573.6780.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On Mon, 2006-06-19 at 14:58 -0700, mark gross wrote:
> I'm just giving this a test spin now on my desktop boot.  looking at uptime and cat /proc/interrupts 
> ~/work> uptime;cat /proc/interrupts 
>   2:51pm  up   0:28,  5 users,  load average: 0.00, 0.02, 0.08
> 	CPU0       
> 	0:      80007          XT-PIC  timer
> 	1:       1776          XT-PIC  i8042
> 	2:          0          XT-PIC  cascade
> 	8:          2          XT-PIC  rtc
> 	9:          0          XT-PIC  acpi
> 	11:       2156          XT-PIC  eth0
> 	12:       2879          XT-PIC  i8042
> 	14:      20402          XT-PIC  ide0
> 	15:         11          XT-PIC  ide1
> 	NMI:          0 
> 	LOC:          0 
> 	ERR:          0
> 	MIS:          0
> 
> or about 47.6 timer's a second.
> 
> This system is mostly idle, is this about right or should I expect even fewer timer ticks?

We did not track down all culprits of useless timer schedules, but there
are definitely a couple of user space programs which we identified, e.g.
redhat network, debian and ubuntu updates applets and similar
candidates.

> Is there a way to see timer stats?

Enable timer stats in the kernel config

$ echo start >/proc/timer_input 
$ do nothing for a while
$ cat /proc/timer_info

You get something like:

Function counter - Timer Top v0.9.9
collection period: 19.7 seconds
   1     0 swapper          verify_tsc_freq (verify_tsc_freq)
   1     6 events/0         do_cache_clean (delayed_work_timer_fn)
   1     0 swapper          i8042_interrupt (i8042_timer_func)
   2     0 swapper          neigh_periodic_timer (neigh_periodic_timer)
   2   148 pdflush          wb_kupdate (wb_timer_fn)
   1     1 swapper          init_tsc_clocksource (verify_tsc_freq)
   4     6 events/0         cache_reap (delayed_work_timer_fn)
   1  2508 sh               get_transaction (commit_timeout)
   1     0 swapper          page_writeback_init (wb_timer_fn)
   4     1 init             schedule_timeout (process_timeout)
   9     0 swapper          e100_watchdog (e100_watchdog)
   9     0 swapper          dev_watchdog (dev_watchdog)
   6     1 swapper          schedule_delayed_work_on (delayed_work_timer_fn)
   1     1 swapper          neigh_table_init_no_netlink (neigh_periodic_timer)
   1     1 swapper          i8042_probe (i8042_timer_func)
   3  3317 bash             schedule_timeout (process_timeout)
   1  2973 ifconfig         e100_up (e100_watchdog)
   1     0 swapper          __netdev_watchdog_up (dev_watchdog)
   4   893 kirqd            schedule_timeout (process_timeout)
   5     0 swapper          tty_flip_buffer_push (delayed_work_timer_fn)

repeat over time to find the tick wasters.

Also:

$ cat /proc/stat | grep nohz 

gives you some stats about the idle state

nohz cpu0 I:37390 S:30025 T:2108551 A:70 E: 26891
nohz cpu1 I:15480 S:12614 T:2109231 A:49 E: 14508
nohz total I:52870 S:42639 T:4217782 A:98 E:41399

where:

I: number of idle calls
S: number of idle calls, which can sleep for at least one tick
T: total time (in tick units) slept in idle calls
A: average sleep time per "can sleep" idle call (in tick units)
E: number of timer interrupt events


You might also try to slow down the timer wheel activity by batching the
timeouts into multiples of the scheduler tick (HZ) by doing

$ echo $FACTOR >/proc/sys/kernel/timeout_granularity

e.g. 
FACTOR=10 batches the timer wheel timers to 10ms on a HZ=1000 kernel
FACTOR=20 batches the timer wheel timers to 40ms on a HZ=250 kernel
.....

> FWIW Its nice to see this stuff start getting real.

Thanks,

	tglx



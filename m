Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbULHBGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbULHBGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbULHBGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:06:23 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:19101 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261980AbULHBFk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:05:40 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-2
Date: Tue, 7 Dec 2004 20:05:37 -0500
User-Agent: KMail/1.7
References: <OFD07DEEA4.7C243C76-ON86256F5F.007976EC@raytheon.com> <200412071340.42731.gene.heskett@verizon.net> <20041207214715.GB12879@elte.hu>
In-Reply-To: <20041207214715.GB12879@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200412072005.37486.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [141.153.76.102] at Tue, 7 Dec 2004 19:05:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 December 2004 16:47, Ingo Molnar wrote:
>
>could enable WAKEUP_TIMING and LATENCY_TRACING, boot into the new
> kernel and do:
>
> echo 0 > /proc/sys/kernel/preempt_max_latency
>
>then you'll get the worst-case trace in /proc/latency_trace. Does it
>show any millisecs-range latencies?

Here is a cat of that:
[root@coyote linux-2.6.10-rc2-mm3-V0.7.32-9]# cat /proc/latency_trace
preemption latency trace v1.1.3 on 2.6.10-rc2-mm3-V0.7.32-9
--------------------------------------------------------------------
 latency: 5 us, #22/22 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: X-3215 (uid:0 nice:-1 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> hardirq
               || / _---=> softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
   kmail-3488  0-h.2    0탎 : __trace_start_sched_wakeup
(try_to_wake_up)
   kmail-3488  0-h.1    0탎 : preempt_schedule (try_to_wake_up)
   kmail-3488  0        0탎 : __wake_up_common <X-3215> (72 74):
   kmail-3488  0-h.1    0탎 : try_to_wake_up (__wake_up_common)
   kmail-3488  0-h..    0탎 : preempt_schedule (try_to_wake_up)
   kmail-3488  0-h..    0탎 : preempt_schedule_irq (try_to_wake_up)
   kmail-3488  0-h..    1탎 : __schedule (preempt_schedule_irq)
   kmail-3488  0-h..    1탎 : profile_hit (__schedule)
   kmail-3488  0-h.1    1탎 : sched_clock (__schedule)
   kmail-3488  0-h.2    1탎 : dequeue_task (__schedule)
   kmail-3488  0-h.2    1탎 : recalc_task_prio (__schedule)
   kmail-3488  0-h.2    1탎 : effective_prio (recalc_task_prio)
   kmail-3488  0-h.2    2탎 : enqueue_task (__schedule)
       X-3215  0-..2    3탎 : __switch_to (__schedule)
       X-3215  0        4탎 : schedule <kmail-3488> (74 72):
       X-3215  0-..2    4탎 : finish_task_switch (__schedule)
       X-3215  0-..1    4탎 : trace_stop_sched_switched
(finish_task_switch)
       X-3215  0        5탎 : finish_task_switch <X-3215> (72 0):
       X-3215  0-..1    6탎 : trace_stop_sched_switched
(finish_task_switch)


vim:ft=help
------------------
 tvtime had been run long enough to expand the log about 10 megs
before I stopped it and did that 'cat' above.

>also, do this:
>
>  chrt -f 90 -p `pidof 'IRQ 8'`
>  chrt -f 91 -p `pidof 'IRQ 0'`

Now, this has been done, and another 30 second run of tvtime, which
generated about another 5 to 10 megs of this:
Dec  7 19:55:56 coyote kernel: wow!  That was a 21 millisec bump
Dec  7 19:55:56 coyote kernel: `IRQ 8'[838] is being piggy.
need_resched=0, cpu=0
Dec  7 19:55:56 coyote kernel: Read missed before next interrupt

and exited with this histogram output:
Dec  7 19:55:56 coyote kernel: rtc latency histogram of {tvtime/3869,
5538 samples}:
Dec  7 19:55:56 coyote kernel: 9 83
Dec  7 19:55:56 coyote kernel: 10 1793
Dec  7 19:55:56 coyote kernel: 11 1704
Dec  7 19:55:56 coyote kernel: 12 562
Dec  7 19:55:56 coyote kernel: 13 188
Dec  7 19:55:56 coyote kernel: 14 109
Dec  7 19:55:56 coyote kernel: 15 88
Dec  7 19:55:56 coyote kernel: 16 63
Dec  7 19:55:56 coyote kernel: 17 73
Dec  7 19:55:56 coyote kernel: 18 112
Dec  7 19:55:56 coyote kernel: 19 153
Dec  7 19:55:56 coyote kernel: 20 80
Dec  7 19:55:56 coyote kernel: 21 43
Dec  7 19:55:56 coyote kernel: 22 28
Dec  7 19:55:56 coyote kernel: 23 9
Dec  7 19:55:56 coyote kernel: 24 6
Dec  7 19:55:56 coyote kernel: 25 9
Dec  7 19:55:56 coyote kernel: 26 1
Dec  7 19:55:56 coyote kernel: 30 1
Dec  7 19:55:56 coyote kernel: 35 1
Dec  7 19:55:56 coyote kernel: 9999 432


>to make sure IRQ8 doesnt get preempted by other stuff. How often do
> you get the rtc histogram in the syslog? Does tvtime use /dev/rtc
> for normal operations perhaps?

I believe it does.  And with the above chrt options in effect,
tvtimes output to the logfile is essentially unchanged.

> If yes then you might want to disable RTC_HISTOGRAM.

And thats a recompile option?  Back in a few.

But couldn't find it.  And oddly, there were two reboots here as I'd
forgotten to update my grub.conf, and on the first one to 32-6, it
hung at the end of the mounting reports on screen, and took a lengthy
nap while doing something to the disks it wasn't reporting on-screen
but there was an extended period of intermittent disk activity, and
it eventually booted sometime after the blanker had kicked in.  I
took advantage of it to take a shower :)  I'd had that happen twice
before and panic'd, even hitting the reset button once and doing a
cold powerdown once, this before I noticed there was some disk
activity going on, so I figured what the hell and walked away to go
see what the missus was watching on the telly.  And when I came back
half an hour later I was looking at a login prompt once I'd moved the 
mouse.

Anyway it had time to collect some more stats, so heres that cat
again.

preemption latency trace v1.1.3 on 2.6.10-rc2-mm3-V0.7.32-9
--------------------------------------------------------------------
 latency: 5 us, #22/22 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: X-3215 (uid:0 nice:-1 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> hardirq
               || / _---=> softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
   kmail-3488  0-h.2    0탎 : __trace_start_sched_wakeup
(try_to_wake_up)
   kmail-3488  0-h.1    0탎 : preempt_schedule (try_to_wake_up)
   kmail-3488  0        0탎 : __wake_up_common <X-3215> (72 74):
   kmail-3488  0-h.1    0탎 : try_to_wake_up (__wake_up_common)
   kmail-3488  0-h..    0탎 : preempt_schedule (try_to_wake_up)
   kmail-3488  0-h..    0탎 : preempt_schedule_irq (try_to_wake_up)
   kmail-3488  0-h..    1탎 : __schedule (preempt_schedule_irq)
   kmail-3488  0-h..    1탎 : profile_hit (__schedule)
   kmail-3488  0-h.1    1탎 : sched_clock (__schedule)
   kmail-3488  0-h.2    1탎 : dequeue_task (__schedule)
   kmail-3488  0-h.2    1탎 : recalc_task_prio (__schedule)
   kmail-3488  0-h.2    1탎 : effective_prio (recalc_task_prio)
   kmail-3488  0-h.2    2탎 : enqueue_task (__schedule)
       X-3215  0-..2    3탎 : __switch_to (__schedule)
       X-3215  0        4탎 : schedule <kmail-3488> (74 72):
       X-3215  0-..2    4탎 : finish_task_switch (__schedule)
       X-3215  0-..1    4탎 : trace_stop_sched_switched
(finish_task_switch)
       X-3215  0        5탎 : finish_task_switch <X-3215> (72 0):
       X-3215  0-..1    6탎 : trace_stop_sched_switched
(finish_task_switch)


vim:ft=help
--------------------------
What is all this telling you/us?                    
                
-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.



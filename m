Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbULPPwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbULPPwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbULPPwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:52:50 -0500
Received: from tus-gate4.raytheon.com ([199.46.245.233]:65393 "EHLO
	tus-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S261374AbULPPwR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:52:17 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Date: Thu, 16 Dec 2004 09:50:40 -0600
Message-ID: <OF2ABD367B.A6A542F4-ON86256F6C.0057091E-86256F6C.00570972@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/16/2004 09:50:44 AM
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was curious about what was causing some of my "extended delays" during
a network stress test & captured a trace I'll summarize here & forward
the complete trace separately. If I read this right, it appears I just
had "bad luck" (lots of interrupts on the CPU with the RT task) but I
would be glad to hear of a better interpretation (if it fits the data).

The test set up was my two CPU SMP system. The kernel was .33-03 with
PREEMPT_DESKTOP and non threaded IRQ's. The RT program was a slight
variation of latencytest - modified to capture traces if the CPU loop
(nominal 1160 usec) took more than 20% longer than nominal. The non
RT stress program running concurrently was my network output test
which basically uses rcp to copy a file to another system.

       times in usec
       CPU   Latency  Cause
[00]     50      14   Audio IRQ
[01]    154      69   Network IRQ / soft IRQ
[02]     53      92   SMP timer / Network IRQ / soft IRQ
[03]     25      62   Network IRQ / soft IRQ
[04]     60       6   Network IRQ
[05]    133      70   Network IRQ / soft IRQ
[06]     53     211   Network IRQ / soft IRQ / reschedule
[07]     35      76   Network IRQ / soft IRQ
[08]     75     210   Network IRQ / soft IRQ / reschedule / soft IRQ
[09]     58     105   Audio IRQ / soft IRQ / reschedule
[10]     19     103   Network IRQ / soft IRQ
[11]     86      86   Network IRQ / soft IRQ
[12]     34     102   Network IRQ / soft IRQ
[13]     53      63   Network IRQ / soft IRQ
[14]     56      52   Network IRQ / soft IRQ / reschedule
[15]     72      23   SMP timer / soft IRQ
[16]     59       2   End of trace
Total  1075    1346   (2421 grand total - check)

None of the individual latencies are all that bad - both #06 and #08
were the worst at 210 usec. It may be possible to fix the specific causes
of those two traces (though I know we've also broken the network code
as well...). but it is the cumulative effect of the number of
interrupts that appear to be the problem.

I am also not so sure that PREEMPT_RT would have done much better
but have not run that test for a comparison. I worry about the
cost of rescheduling / IRQ threading overhead - which may explain
why I see PREEMPT_DESKTOP doing better than PREEMPT_RT in some of
my tests.

I guess I should also note that this trace appears to indicate that
ALSA is buffering audio for output [see the two interrupts during the
trace]. I expect the audio output to be a blocking write in latencytest
(that was the 2.4 behavior). Is there some way to get the same behavior
I saw in 2.4 on a 2.6 / ALSA audio set up? If you don't know, who should
I direct that question to?

  --Mark

preemption latency trace v1.1.4 on 2.6.10-rc3-mm1-V0.7.33-03
--------------------------------------------------------------------
 latency: 2421 탎, #2259/2259, CPU#0 | (M:preempt VP:0, KP:1, SP:0 HP:0
#P:2)
    -----------------
    | task: latencytest-tra-14143 (uid:0 nice:0 policy:1 rt_prio:99)
    -----------------
 => started at: <00000000>
 => ended at:   restore_all+0x5/0x21 <c0104000>

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
latencyt-14143 0...1    0탎 : user_trace_start (sys_gettimeofday)
latencyt-14143 0d...    0탎+< (0)                    [00]
latencyt-14143 0d.h.   50탎 : do_IRQ (8049af8 a 0)
... process audio interrupt ...
[I can argue - why did this come in here since the audio REALLY should
have finished during the write() call done later]
latencyt-14143 0d...   64탎!< (0)                    [01]
latencyt-14143 0d.h.  218탎 : do_IRQ (8049af9 b 0)
... process network IRQ / soft IRQ ...
latencyt-14143 0d...  287탎+< (0)                    [02]
latencyt-14143 0d...  340탎 : smp_apic_timer_interrupt (8049af9 0 0)
... timer / network IRQ / soft IRQ
latencyt-14143 0d...  432탎+< (0)                    [03]
latencyt-14143 0d.h.  457탎 : do_IRQ (8049af8 b 0)
... network IRQ / soft IRQ ...
latencyt-14143 0d...  519탎+< (0)                    [04]
latencyt-14143 0d.h.  579탎 : do_IRQ (8049af8 b 0)
... network IRQ  ...
latencyt-14143 0d...  585탎!< (0)                    [05]
latencyt-14143 0d.h.  718탎 : do_IRQ (8049af8 b 0)
... network IRQ / soft IRQ ...
latencyt-14143 0d...  788탎+< (0)                    [06]
latencyt-14143 0d.h.  841탎 : do_IRQ (8049af9 b 0)
... network IRQ / soft IRQ / reschedule
latencyt-14143 0d... 1052탎+< (0)                    [07]
latencyt-14143 0d.h. 1087탎 : do_IRQ (8049af8 b 0)
... network IRQ / soft IRQ
latencyt-14143 0d... 1163탎+< (0)                    [08]
latencyt-14143 0d.h. 1238탎 : do_IRQ (8049af8 b 0)
... network IRQ / soft IRQ / reschedule / timer / soft IRQ
latencyt-14143 0d... 1448탎+< (0)                    [09]
latencyt-14143 0d.h. 1506탎 : do_IRQ (8049af8 a 0)
... audio IRQ / soft IRQ / reschedule
[this on the other hand is closer to the right duration for the
audio interrupt]
latencyt-14143 0d... 1611탎+< (0)                    [10]
latencyt-14143 0d.h. 1630탎 : do_IRQ (8049af8 b 0)
... network IRQ / soft IRQ
latencyt-14143 0d... 1733탎+< (0)                    [11]
latencyt-14143 0d.h. 1819탎 : do_IRQ (8049af9 b 0)
... network IRQ / soft IRQ
latencyt-14143 0d... 1905탎+< (0)                    [12]
latencyt-14143 0d.h. 1939탎 : do_IRQ (8049af8 b 0)
... network IRQ / soft IRQ
latencyt-14143 0d... 2041탎+< (0)                    [13]
latencyt-14143 0d.h. 2094탎 : do_IRQ (8049af8 b 0)
... network IRQ / soft IRQ
latencyt-14143 0d... 2157탎+< (0)                    [14]
latencyt-14143 0d.h. 2213탎 : do_IRQ (8049af8 b 0)
... network IRQ / soft IRQ / reschedule
latencyt-14143 0d... 2265탎+< (0)                    [15]
latencyt-14143 0d... 2337탎 : smp_apic_timer_interrupt (8049af8 0 0)
... SMP timer / soft IRQ
latencyt-14143 0d... 2360탎+< (0)                    [16]
latencyt-14143 0.... 2419탎 > sys_gettimeofday (00000000 00000000 0000007b)
latencyt-14143 0.... 2419탎 : sys_gettimeofday (sysenter_past_esp)
latencyt-14143 0.... 2420탎 : user_trace_stop (sys_gettimeofday)
latencyt-14143 0...1 2421탎 : user_trace_stop (sys_gettimeofday)


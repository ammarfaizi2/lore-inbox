Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270933AbUJUUVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270933AbUJUUVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270919AbUJUURG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:17:06 -0400
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:57146 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S270932AbUJUUJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:09:25 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
Date: Thu, 21 Oct 2004 14:52:54 -0500
Message-ID: <OFBD58B218.511B165F-ON86256F34.006D366E-86256F34.006D36CF@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/21/2004 02:53:01 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -U9 Real-Time Preemption patch, which can be
>downloaded from:
>
>  http://redhat.com/~mingo/realtime-preempt/

This looks like a keeper. All results are with U9.2 (though it says
U9.1 in the system logs...).

I will send a separate message with details, but here is a summary of
the testing I have done so far.

[1] Boot up and init scripts.

Still get the BUG message after telinit 3
Oct 21 13:18:42 localhost kernel: eth0: RealTek RTL8139 at 0xdc00,
00:50:bf:39:11:fc, IRQ 11
Oct 21 13:18:42 localhost kernel: BUG: atomic counter underflow at:
...

but this is no longer fatal to system start up nor do I get any
further error messages related to the network card.

telinit 5 is successful without any problems.

[2] Initial audio / real time settings

Audio test was OK.
The script I use setting the real time environment now complains that
I cannot unthread the RTC nor audio (as expected) and doesn't appear
to cause any problems.

[3] Real time test

First time running my test (latencytest plus heavy non real time
operations), I got some nasty sounds from the speakers plus the
display / mouse locked up but unlocked when I was able to Ctrl-C
the job some time later. Rebuilt latencytest with a lower real time
priority to recover.

Second time, the test ran pretty much flawlessly. My background
job collecting latency trace data had only 4 hits in about 25-30
minutes of testing (> 200 usec). The summary data looked OK but
when I looked at the charts later the data is similar to what I
saw with -T3 with a few exceptions:

 [1] X11 stress with T3 had no significant CPU delays (> 100 usec)
with more "little" delays than U9. U9 had about 0.3% of the samples
with over 200 usec delays for the CPU task.

 [2] proc stress had similar results with U9 having 0.19% samples
over 100 usec delay and 0.04% samples over 200 usec delay.

 [3] Both network tests were great with both kernels (T3 and U9).
U9 was slightly better with 100% samples within 100 usec of nominal
value and T3 with 0.01% and 0.04% 100 usec delay samples on network
output / input respectively.

 [4] Disk write test was a little odd on U9, the first 30 seconds
had some long delays (max 630 usec) but then it settled down and
no long delays the remaining time period (total 5 minutes).

 [5] Disk copy test had a 5 second burp at the start (max 380 usec)
but it settled down as well.

 [6] Disk read test results were worse on U9 than T3. Both the
maximum delay (1.7 msec - over 100% overhead) and percentage of
longer delays (1.72% on U9, 0.22% on T3) were worse on U9. I
checked again, DMA mode was set to udma2 to prevent the long
latencies I saw in previous tests.

[4] Latency trace results.

Only a handful of traces during the test. Numbers below refer
to the file numbers (lt.xx).

00 - 229 usec, appears to be nmi during kmap_atomic; likely sampling
overhead.

01 - 67569 usec, this and next one appear to be that long delay where
the system gets "stuck" and finally finishes the work several clock
ticks later. Notice - this did not affect the application level
timing collection. The start was in flush_tlb_all (remove_vm_area)
ending at do_flush_tlb_all (flush_tlb_all). Several cycles of a
sequence like this were in between...

00000003 64.462ms (+0.137ms): __do_softirq (do_softirq)
00010002 64.599ms (+0.000ms): do_nmi (smp_call_function)
00010002 64.600ms (+0.000ms): do_nmi (check_preempt_timing)
00010002 64.600ms (+0.854ms): do_nmi (<00000046>)
00000002 65.454ms (+0.000ms): smp_apic_timer_interrupt (smp_call_function)
00010002 65.455ms (+0.000ms): profile_hook (profile_tick)
00010002 65.455ms (+0.000ms): _read_lock (profile_hook)
00010003 65.455ms (+0.000ms): _read_unlock (profile_tick)
00010002 65.456ms (+0.000ms): update_process_times
(smp_apic_timer_interrupt)
00010002 65.456ms (+0.000ms): update_one_process (update_process_times)
00010002 65.457ms (+0.000ms): run_local_timers (update_process_times)
00010002 65.457ms (+0.000ms): raise_softirq (update_process_times)
00010002 65.457ms (+0.000ms): scheduler_tick (update_process_times)
00010002 65.458ms (+0.000ms): sched_clock (scheduler_tick)
00010002 65.458ms (+0.000ms): _spin_lock (scheduler_tick)
00010003 65.459ms (+0.000ms): _spin_unlock (scheduler_tick)
00010002 65.459ms (+0.000ms): rebalance_tick (scheduler_tick)
00010002 65.460ms (+0.000ms): irq_exit (smp_apic_timer_interrupt)
00000003 65.460ms (+0.000ms): do_softirq (irq_exit)

02 - 1856 usec, same symptom as 01 but shorter duration.

03 - 224 usec, total trace follows...
preemption latency trace v1.0.7 on 2.6.9-rc4-mm1-RT-U9.1
-------------------------------------------------------
 latency: 224 us, entries: 7 (7)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
    -----------------
    | task: cat/7650, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: _spin_lock_irqsave+0x1f/0x80 <c0314e0f>
 => ended at:   _spin_unlock_irqrestore+0x20/0x50 <c0315200>
=======>
00000001 0.000ms (+0.000ms): _spin_lock_irqsave (avc_has_perm_noaudit)
00000001 0.000ms (+0.173ms): avc_insert (avc_has_perm_noaudit)
00010001 0.173ms (+0.000ms): do_nmi (avc_insert)
00010001 0.174ms (+0.000ms): do_nmi (cycles_to_usecs)
00010001 0.174ms (+0.047ms): do_nmi (<00000046>)
00000001 0.222ms (+0.000ms): memcpy (avc_has_perm_noaudit)
00000001 0.223ms (+0.000ms): _spin_unlock_irqrestore (avc_has_perm_noaudit)

That's it. Overall a very good performance for this kernel. I will
send the system log and full traces separately.

  --Mark


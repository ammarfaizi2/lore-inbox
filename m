Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbUKPVrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUKPVrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUKPVpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:45:11 -0500
Received: from mail3.utc.com ([192.249.46.192]:48792 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S261841AbUKPVnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:43:19 -0500
Message-ID: <419A745C.4040101@cybsft.com>
Date: Tue, 16 Nov 2004 15:42:52 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Schmidt <mista.tapas@gmx.net>
CC: Ingo Molnar <mingo@elte.hu>, Mark_H_Johnson@raytheon.com,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com>	<20041116184315.GA5492@elte.hu>	<419A5A53.6050100@cybsft.com>	<20041116212401.GA16845@elte.hu> <20041116222039.662f41ac@mango.fruits.de>
In-Reply-To: <20041116222039.662f41ac@mango.fruits.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt wrote:
> On Tue, 16 Nov 2004 22:24:01 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>great. The current release is meanwhile at -V0.7.27-10, which includes
>>other minor updates:
>>
> 
> 
> Ok, this one boots fine again for me (didn't test the ones betwen my last
> report and this one).
> 
> I have not yet tried to get this kernel to lock up yet, but i made another
> interesting observation:
> 
> irq 8 at prio 98 (only irq 1 with higher prio 99). running rtc_wakeup in the
> console (it runs SCHED_FIFO allright). Switching consoles (different text
> consoles - not swithcing to X, though this basically produces similar
> results) produces large jitters (around 1 ms) and occasional missed irq's
> and piggy messages. This is completely reproducable here. The rtc histogram
> doesn't show any large wakeup latencies.

Just a thought. What priority are you running rtc_wakup at? If you are 
doing something like:

schp.sched_priority = sched_get_priority_max(SCHED_FIFO); // which 
equates to a priority of 99

Then you it is actually running at a higher priority than the rtc, and 
it won't work very well. I tend to run rtc (IRQ 8) at 99 and the 
programs accessing it at 98 which seems to work reasonably well.

> 
> /proc/latency_trace doesn't show that high latencies either on console
> switch:
> 
> preemption latency trace v1.0.7 on 2.6.10-rc2-mm1-RT-V0.7.27-10
> -------------------------------------------------------
>  latency: 63 us, entries: 22 (22)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
>     -----------------
>     | task: IRQ 8/13, uid:0 nice:-5 policy:1 rt_prio:98
>     -----------------
>  => started at: try_to_wake_up+0x51/0x170 <c010f3a1>
>  => ended at:   finish_task_switch+0x51/0xb0 <c010f911>
> =======>
>     5 80010004 0.000ms (+0.000ms): trace_start_sched_wakeup (try_to_wake_up)
>     5 80010003 0.000ms (+0.000ms): (1) ((98))
>     5 80010003 0.000ms (+0.000ms): (13) ((5))
>     5 80010003 0.000ms (+0.000ms): try_to_wake_up (wake_up_process)
>     5 80010003 0.000ms (+0.000ms): (0) ((1))
>     5 80010002 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
>     5 80010002 0.000ms (+0.000ms): wake_up_process (redirect_hardirq)
>     5 80010001 0.000ms (+0.000ms): preempt_schedule (__do_IRQ)
>     5 80010001 0.000ms (+0.000ms): irq_exit (do_IRQ)
>     5 80000002 0.000ms (+0.000ms): do_softirq (irq_exit)
>     5 80000002 0.001ms (+0.061ms): __do_softirq (do_softirq)
>     5 00000000 0.062ms (+0.000ms): preempt_schedule (_mmx_memcpy)
>     5 90000000 0.062ms (+0.000ms): __schedule (preempt_schedule)
>     5 90000000 0.062ms (+0.000ms): profile_hit (__schedule)
>     5 90000001 0.062ms (+0.000ms): sched_clock (__schedule)
>    13 80000002 0.062ms (+0.000ms): __switch_to (__schedule)
>    13 80000002 0.062ms (+0.000ms): (5) ((13))
>    13 80000002 0.062ms (+0.000ms): (98) ((1))
>    13 80000002 0.062ms (+0.000ms): finish_task_switch (__schedule)
>    13 80000001 0.062ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
>    13 80000001 0.063ms (+0.003ms): (13) ((1))
>    13 80000001 0.066ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
> 
> I sometimes do get large values in /proc/latency_trace, but they seem to be
> unrelated to the console switching.
> 
> flo
> 


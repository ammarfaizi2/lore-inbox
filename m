Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbUKPWDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbUKPWDD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbUKPWCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:02:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:17558 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261836AbUKPVjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:39:31 -0500
X-Authenticated: #4399952
Date: Tue, 16 Nov 2004 22:40:23 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       Mark_H_Johnson@raytheon.com, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041116224023.5067328f@mango.fruits.de>
In-Reply-To: <20041116223312.4e289e62@mango.fruits.de>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com>
	<20041116184315.GA5492@elte.hu>
	<419A5A53.6050100@cybsft.com>
	<20041116212401.GA16845@elte.hu>
	<20041116222039.662f41ac@mango.fruits.de>
	<20041116223135.GA27250@elte.hu>
	<20041116223312.4e289e62@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 22:33:12 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> On Tue, 16 Nov 2004 23:31:35 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > and i'd suggest to chrt irq 1 back to below prio 90, maybe this explains
> > the console-switching latency? If you do a console-switch via the
> > keyboard then its priority 99 can get inherited by events/0 which then
> > does the quite expensive VGA console clearing/copying with priority 99,
> > possibly delaying rtc_wakeup quite significantly, easily for a
> > millisecond or so. So what you are seeing might be priority inheritance
> > handling at work!
> > 
> 
> ah, will try this right away..

now, doesn't seem to make a difference.. i gave IRQ 1 prio 40 and the
behaviour is the same.. BTW: what about IRQ 0? I tried at different prios
[40 and 99]. Doesn't make a difference either. As far as i understand it, it
really shouldn't make a difference either as in the interesting cases (app
woken up by irq) the scheduler is explicitly run anyways, right?

Here's another trace:

preemption latency trace v1.0.7 on 2.6.10-rc2-mm1-RT-V0.7.27-10
-------------------------------------------------------
 latency: 1056 us, entries: 22 (22)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: IRQ 0/2, uid:0 nice:0 policy:1 rt_prio:99
    -----------------
 => started at: try_to_wake_up+0x51/0x170 <c010f3a1>
 => ended at:   finish_task_switch+0x51/0xb0 <c010f911>
=======>
    5 80010004 0.000ms (+0.000ms): trace_start_sched_wakeup (try_to_wake_up)
    5 80010003 0.000ms (+0.000ms): (0) ((98))
    5 80010003 0.000ms (+0.000ms): (2) ((5))
    5 80010003 0.000ms (+0.000ms): try_to_wake_up (wake_up_process)
    5 80010003 0.000ms (+0.000ms): (0) ((1))
    5 80010002 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
    5 80010002 0.000ms (+0.000ms): wake_up_process (redirect_hardirq)
    5 80010001 0.000ms (+0.000ms): preempt_schedule (__do_IRQ)
    5 80010001 0.000ms (+0.000ms): irq_exit (do_IRQ)
    5 80000002 0.000ms (+0.000ms): do_softirq (irq_exit)
    5 80000002 0.001ms (+1.054ms): __do_softirq (do_softirq)
    5 00000000 1.055ms (+0.000ms): preempt_schedule (_mmx_memcpy)
    5 90000000 1.055ms (+0.000ms): __schedule (preempt_schedule)
    5 90000000 1.055ms (+0.000ms): profile_hit (__schedule)
    5 90000001 1.055ms (+0.000ms): sched_clock (__schedule)
    2 80000002 1.056ms (+0.000ms): __switch_to (__schedule)
    2 80000002 1.056ms (+0.000ms): (5) ((2))
    2 80000002 1.056ms (+0.000ms): (98) ((0))
    2 80000002 1.056ms (+0.000ms): finish_task_switch (__schedule)
    2 80000001 1.056ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
    2 80000001 1.056ms (+0.003ms): (2) ((0))
    2 80000001 1.060ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbULHIhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbULHIhP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 03:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbULHIhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 03:37:15 -0500
Received: from mx1.elte.hu ([157.181.1.137]:23425 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261151AbULHIhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 03:37:05 -0500
Date: Wed, 8 Dec 2004 09:34:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041208083447.GB7720@elte.hu>
References: <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <41B6839B.4090403@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B6839B.4090403@cybsft.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Could you explain what the attached trace means. It looks to me like
> the trace starts in try_to_wake_up when we are trying to wake amlat,
> but then before we finish we get a hit on IRQ 8 and run the IRQ
> handler???  Or do I somehow have it backwards? :)

>    amlat-4973  0-h.3    0?s : __trace_start_sched_wakeup (try_to_wake_up)
>    amlat-4973  0-h.3    1?s : _raw_spin_unlock (try_to_wake_up)
>    amlat-4973  0-h.2    1?s : preempt_schedule (try_to_wake_up)
>    amlat-4973  0        2?s : wake_up_process <IRQ 8-677> (0 1): 

this portion shows that amlat-4973 woke up IRQ_8-677. Subsequently the 
scheduler picked it from a list of 5 tasks:

>    amlat-4973  0-..2   13?s : trace_array (__schedule)
>    amlat-4973  0       14?s : __schedule <IRQ 8-677> (0 1): 
>    amlat-4973  0       14?s+: __schedule <amlat-4973> (1 2): 
>    amlat-4973  0       18?s+: __schedule <<unknown-792> (39 3a): 
>    amlat-4973  0       21?s : __schedule <<unknown-4> (69 6e): 
>    amlat-4973  0       21?s : __schedule <<unknown-4854> (73 78): 
>    amlat-4973  0-..2   22?s+: trace_array (__schedule)
>    IRQ 8-677   0-..2   31?s : __switch_to (__schedule)

IRQ_8's RT priority was 1, amlat's priority was 2, so IRQ-8 got
selected. (there were also other, SCHED_NORMAL tasks with pid 792, 4 and
4854 in the queue but they did not get selected) [ Note that in reality
the O(1) scheduler only considered IRQ_8 when picking the next task,
it's the tracer that listed all runnable tasks, to make it easier to
validate scheduler logic. This 'list all runnable tasks at schedule()
time' tracing is only done if both tracing and rw-deadlock detection is
enabled.]

in this trace you can see the new RT global balancing in the works as
well:

>    IRQ 8-677   0       32?s : schedule <amlat-4973> (1 0): 
>    IRQ 8-677   0-..2   32?s : finish_task_switch (__schedule)
>    IRQ 8-677   0-..2   33?s : smp_send_reschedule_allbutself (finish_task_switch)
>    IRQ 8-677   0-..2   33?s : __bitmap_weight (smp_send_reschedule_allbutself)
>    IRQ 8-677   0-..2   34?s : __send_IPI_shortcut (smp_send_reschedule_allbutself)

here the scheduler noticed that a higher-prio RT task (IRQ_8) preempted
a lower-prio but still RT task (amlat), and sent an IPI (inter-processor
interrupt) to another CPU in the system so that amlat can run on the
other CPU.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbULJLW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbULJLW3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 06:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbULJLW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 06:22:28 -0500
Received: from mx1.elte.hu ([157.181.1.137]:11916 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261174AbULJLWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 06:22:22 -0500
Date: Fri, 10 Dec 2004 12:22:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Mark_H_Johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041210112210.GC6855@elte.hu>
References: <OFADAD8EC1.8BCE1EC6-ON86256F65.005EFFA6@raytheon.com> <20041209173136.GE7975@elte.hu> <41B8B6C4.60200@cybsft.com> <20041209220632.GE14194@elte.hu> <41B92588.4060106@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B92588.4060106@cybsft.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> >here's the code:
> >
> >+static inline void trace_start_sched_wakeup(task_t *p, runqueue_t *rq)
> >+{
> >+       if (TASK_PREEMPTS_CURR(p, rq) && (p != rq->curr) && 
> >_need_resched())
> >+               __trace_start_sched_wakeup(p);
> >+}
> >
> >indeed this only triggers if the woken up task has a higher priority
> >than the waker... hm. Could you try to reverse the priorities of 
> >realfeel and IRQ8, does that produce traces?
> 
> I guess I really am slow. You laid it all out for me above and I still
> didn't get it until I looked at again. I still haven't been able to
> capture an actual trace from any of these programs, but thanks to your
> addition of logging all of the max latencies in 32-14 I can see that
> the traces were there until another trace pushes them out.

wakeup tracing can only work reliably if it's a higher-prio task that is
being woken up (to which the currently executing task is obliged to
preempt). Otherwise the currently executing task (the one which wakes up
the other task) could continue to execute indefinitely, making the
wakeup latency trace much less useful. Hence the priority check and the
need_resched() check: 'is the wakee higher-prio', and 'does the current
task really have to preempt right now'.

(hm, i think the _need_resched() check is in fact buggy, especially on
SMP systems: if there's a cross-CPU wakeup then _need_resched() wont be
set for the current task! Is this perhaps what you wanted to point out? 
I've uploaded the -32-17 kernel which has the _need_resched() check
removed.)

unfortunately this issue seems to hit realfeel/rtc_wakeup too: there the
common wakeup is done from the IRQ thread, which is higher-prio than
realfeel/rtc_wakeup! So wakeup tracing/timing doesnt get activated at
all for those types of wakeups.

a solution/workaround to this would be to 'reverse' the priorities of
the tasks: i.e. to make the IRQ thread prio 80, and to make realfeel
prio 90, and to look at the results. In theory realfeel shouldnt be
running when the next IRQ arrives, so this should produce meaningful
traces.

	Ingo

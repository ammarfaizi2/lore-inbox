Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVFVXh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVFVXh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVFVXhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:37:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8919 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262600AbVFVXdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:33:25 -0400
Date: Thu, 23 Jun 2005 01:32:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       William Weston <weston@sysex.net>
Subject: Re: [patch] fix SMT scheduler latency bug
Message-ID: <20050622233254.GA11486@elte.hu>
References: <20050622102541.GA10043@elte.hu> <200506230040.58846.kernel@kolivas.org> <20050622160458.GA28020@elte.hu> <200506230903.56351.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506230903.56351.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> > task_timeslice(p) is indeed constant over time, but smt_curr->time_slice
> > is not. So this condition opens up the possibility of a lower prio
> > thread accumulating a larger ->time_slice and thus reversing the
> > priority equation.
> 
> I'm not clear on how the value of ->time_slice can ever grow to larger 
> than task_timeslice(p). It starts at task_timeslice(p) and decrements 
> till it gets to 0 when it refills again.

I was thinking abut sched_exit(), there we let unused child timeslices 
'flow back' into the parent thread, if the child thread was shortlived. 
The check there does:

        if (p->first_time_slice) {
                p->parent->time_slice += p->time_slice;
                if (unlikely(p->parent->time_slice > task_timeslice(p)))
                        p->parent->time_slice = task_timeslice(p);
        }

notice that we check parent->time_slice against the child's 
task_timeslice(p), not against task_timeslice(p->parent). So if the 
child thread got reniced, it could cause a higher-than-normal amount of 
timeslices. But this should be a rare scenario, and the above code is 
more of a bug than a feature (will send a patch for it tomorrow), and it 
should not affect the workloads i was testing.

lets take a look at the second condition again:

                if ((p->time_slice * (100 - sd->per_cpu_gain) / 100) >
                        task_timeslice(smt_curr))
                                resched_task(smt_curr);

if this condition is true then we trigger a preemption at smt_curr. Now 
in the bug scenario, 'p' is a highprio task and smt_curr is a lowprio 
task. If p->time_slice (which fluctuates between task_timeslice(p) and 
0) happens to be low enough, preemption wont be triggered and we lose a 
wakeup in essence - 'p', despite being the highest-prio task around, 
wont be run until some CPU runs schedule() voluntarily. Ok?

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVFJHJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVFJHJq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 03:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVFJHJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 03:09:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28841 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262310AbVFJHJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 03:09:23 -0400
Date: Fri, 10 Jun 2005 09:02:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <20050610070214.GA31323@elte.hu>
References: <20050607170853.3f81007a.akpm@osdl.org> <1100910000.1118361416@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100910000.1118361416@flay>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin J. Bligh <mbligh@mbligh.org> wrote:

> > I'm assuming it was the CPU scheduler patches.  There are 36 of them ;)
> 
> Backed them all out ... performance thunks down to earth again, and is 
> actually the best I've seen it ever (probably 250Hz is helping, I used 
> to run 100 in -mjb for better benefit).
> 
> the +5081 item is the one to look at
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/kernbench.moe.png
> 
> Patch I used was here:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/patches/nosched
> 
> But it was just everything under the "CPU scheduler" section of your 
> series file.

we know from Nick's testing that the patches up to and including 
dynamic-sched-domains-ia64-changes.patch are probably OK. So the 
candidates for the regression are:

 sched-implement-nice-support-across-physical-cpus-on-smp.patch
 sched-change_prio_bias_only_if_queued.patch
 sched-account_rt_tasks_in_prio_bias.patch
 consolidate-preempt-options-into-kernel-kconfigpreempt.patch
 enable-preempt_bkl-on-preemptsmp-too.patch
 sched-tweak-idle-thread-setup-semantics.patch
 sched-voluntary-kernel-preemption.patch
 sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch
 sched-task_noninteractive.patch
 sched-run-sched_normal-tasks-with-real-time-tasks-on-smt-siblings.patch

there are two feature patches in this:

 enable-preempt_bkl-on-preemptsmp-too.patch
 sched-voluntary-kernel-preemption.patch

so make sure you have PREEMPT_BKL and PREEMPT_VOLUNTARY disabled.

these ones should not impact your workload's functionality (unless they 
are buggy):

 sched-account_rt_tasks_in_prio_bias.patch
 consolidate-preempt-options-into-kernel-kconfigpreempt.patch
 sched-tweak-idle-thread-setup-semantics.patch
 sched-run-sched_normal-tasks-with-real-time-tasks-on-smt-siblings.patch

and unless you are using separate nice levels, this one shouldnt make a 
difference in theory:

 sched-implement-nice-support-across-physical-cpus-on-smp.patch

which leaves the following 3 likely candidates:

 sched-change_prio_bias_only_if_queued.patch
 sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch
 sched-task_noninteractive.patch

so if you could do a run with all 3 of the above unapplied, that would 
be a good starting point. (But any of the others might be it too, if 
they contain some sort of bug.)

	Ingo

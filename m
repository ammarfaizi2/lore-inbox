Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVFJMEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVFJMEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 08:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVFJMEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 08:04:31 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:18855 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262265AbVFJMEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 08:04:20 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Date: Fri, 10 Jun 2005 22:03:15 +1000
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>
References: <20050607170853.3f81007a.akpm@osdl.org> <1100910000.1118361416@flay> <20050610070214.GA31323@elte.hu>
In-Reply-To: <20050610070214.GA31323@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506102203.15909.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2005 17:02, Ingo Molnar wrote:
> * Martin J. Bligh <mbligh@mbligh.org> wrote:
> > > I'm assuming it was the CPU scheduler patches.  There are 36 of them ;)
> >
> > Backed them all out ... performance thunks down to earth again, and is
> > actually the best I've seen it ever (probably 250Hz is helping, I used
> > to run 100 in -mjb for better benefit).
> >
> > the +5081 item is the one to look at
> > http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/kernbench.
> >moe.png
> >
> > Patch I used was here:
> >
> > http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/patches/nosched
> >
> > But it was just everything under the "CPU scheduler" section of your
> > series file.
>
> we know from Nick's testing that the patches up to and including
> dynamic-sched-domains-ia64-changes.patch are probably OK. So the
> candidates for the regression are:
>
>  sched-implement-nice-support-across-physical-cpus-on-smp.patch
>  sched-change_prio_bias_only_if_queued.patch
>  sched-account_rt_tasks_in_prio_bias.patch
>  consolidate-preempt-options-into-kernel-kconfigpreempt.patch
>  enable-preempt_bkl-on-preemptsmp-too.patch
>  sched-tweak-idle-thread-setup-semantics.patch
>  sched-voluntary-kernel-preemption.patch
>  sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch
>  sched-task_noninteractive.patch
>  sched-run-sched_normal-tasks-with-real-time-tasks-on-smt-siblings.patch
>
> there are two feature patches in this:
>
>  enable-preempt_bkl-on-preemptsmp-too.patch
>  sched-voluntary-kernel-preemption.patch
>
> so make sure you have PREEMPT_BKL and PREEMPT_VOLUNTARY disabled.
>
> these ones should not impact your workload's functionality (unless they
> are buggy):
>
>  sched-account_rt_tasks_in_prio_bias.patch
>  consolidate-preempt-options-into-kernel-kconfigpreempt.patch
>  sched-tweak-idle-thread-setup-semantics.patch
>  sched-run-sched_normal-tasks-with-real-time-tasks-on-smt-siblings.patch
>
> and unless you are using separate nice levels, this one shouldnt make a
> difference in theory:
>
>  sched-implement-nice-support-across-physical-cpus-on-smp.patch
>
> which leaves the following 3 likely candidates:
>
>  sched-change_prio_bias_only_if_queued.patch
>  sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch

These tend to run together so just try adding my four patches together. In 
retrospect I guess they're likely candidates because they also change the 
_ratio_ of balance which they should not so they are buggy as a group 
currently. Easy enough to fix but it will make it easy to pinpoint the 
problem if they're responsible.

sched-implement-nice-support-across-physical-cpus-on-smp.patch
sched-change_prio_bias_only_if_queued.patch
sched-account_rt_tasks_in_prio_bias.patch
sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch

Con

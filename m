Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTDVKWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 06:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbTDVKWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 06:22:47 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62642 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263062AbTDVKWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 06:22:44 -0400
Date: Tue, 22 Apr 2003 06:34:45 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Rick Lindsley <ricklind@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-A9 
In-Reply-To: <200304221018.h3MAItX11004@owlet.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0304220622570.24063-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, Rick Lindsley wrote:

> Ingo, several questions.
> 
> What makes this statement:
> 
>     * At this point it's sure that we have a SMT
>     * imbalance: this (physical) CPU is idle but
>     * another CPU has two (or more) tasks running.
> 
> true?  Do you mean "this cpu/sibling set are all idle but another
> cpu/sibling set are all non-idle"? [...]

yes, precisely.

> [...] Are we assuming that because both a physical processor and its
> sibling are not idle, that it is better to move a task from the sibling
> to a physical processor?  In other words, we are presuming that the case
> where the task on the physical processor and the task(s) on the
> sibling(s) are actually benefitting from the relationship is rare?

yes. This 'un-sharing' of contexts happens unconditionally, whenever we
notice the situation. (ie. whenever a CPU goes completely idle and notices
an overloaded physical CPU.) On the HT system i have i have measure this
to be a beneficial move even for the most trivial things like infinite
loop-counting.

the more per-logical-CPU cache a given SMT implementation has, the less
beneficial this move becomes - in that case the system should rather be
set up as a NUMA topology and scheduled via the NUMA scheduler.

>     * We wake up one of the migration threads (it
>     * doesnt matter which one) and let it fix things up:
> 
> So although a migration thread normally pulls tasks to it, we've altered
> migration_thread now so that when cpu_active_balance() is set for its
> cpu, it will go find a cpu/sibling set in which all siblings are busy
> (knowing it has a good chance of finding one), decrement nr_running in
> the runqueue it has found, call load_balance() on the queue which is
> idle, and hope that load_balance will again find the busy queue (the
> same queue as the migration thread's) and decide to move a task over?

yes.

> whew. So why are we perverting the migration thread to push rather than
> pull? If active_load_balance() finds a imbalance, why must we use such
> indirection?  Why decrement nr_running?  Couldn't we put together a
> migration_req_t for the target queue's migration thread?

i'm not sure what you mean by perverting the migration thread to push
rather to pull, as migration threads always push - it's not different in
this case either. Since the task in question is running in an
un-cooperative way at the moment of active-balancing, that CPU needs to
run the high-prio migration thread, which pushes the task to the proper
CPU after that point. [if the push is still necessary.]

we could use a migration_req_t for this, in theory, but active balancing
is independent of ->cpus_allowed, so some special code would still be
needed. Also, active balancing is non-queued by nature. Is there a big
difference?

> Making the migration thread TASK_UNINTERRUPTIBLE has the nasty side
> effect of artificially raising the load average.  Why is this changed?

agreed, this is an oversight, i fixed it in my tree.

	Ingo


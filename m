Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269107AbUJERjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269107AbUJERjs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269117AbUJERjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:39:48 -0400
Received: from fmr03.intel.com ([143.183.121.5]:55500 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269107AbUJERj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:39:28 -0400
Message-Id: <200410051739.i95HdD627957@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Peter Williams'" <pwil3058@bigpond.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: bug in sched.c:task_hot()
Date: Tue, 5 Oct 2004 10:39:20 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSqrZyi94gn7TS8ShaZM1HYdYzYQQAU3o0w
In-Reply-To: <41624E42.8030105@bigpond.net.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Current implementation of task_hot() has a performance bug in it
> that it will cause integer underflow.
>
> Variable "now" (typically passed in as rq->timestamp_last_tick)
> and p->timestamp are all defined as unsigned long long.  However,
> If former is smaller than the latter, integer under flow occurs
> which make the result of subtraction a huge positive number. Then
> it is compared to sd->cache_hot_time and it will wrongly identify
> a cache hot task as cache cold.
>
> This bug causes large amount of incorrect process migration across
> cpus (at stunning 10,000 per second) and we lost cache affinity very
> quickly and almost took double digit performance regression on a db
> transaction processing workload.  Patch to fix the bug.  Diff'ed against
> 2.6.9-rc3.
>

Peter Williams wrote on Tuesday, October 05, 2004 12:33 AM
> The interesting question is: How does now get to be less than timestamp?
>   This probably means that timestamp_last_tick is not a good way of
> getting a value for "now".  By the way, neither is sched_clock() when
> measuring small time differences as it is not monotonic (something that
> I had to allow for in my scheduling code).  I applied no such safeguards
> to the timing used by the load balancing code as I assumed that it
> already worked.

The reason now gets smaller than timestamp was because of random thing
that activate_task() do to p->timestamp.  Here are the sequence of events:

On timer tick, scheduler_tick() updates rq->timestamp_last_tick,
1 us later, process A wakes up, entering into run queue. activate_task()
updates p->timestamp.  At this time p->timestamp is larger than rq->
timestamp_last_tick.  Then another cpu goes into idle, tries load balancing,
It wrongly finds process A not cache hot (because of integer underflow),
moved it.  Then application runs on a cache cold CPU and suffer performance.

- Ken



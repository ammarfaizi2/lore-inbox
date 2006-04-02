Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWDBHIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWDBHIh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 03:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWDBHIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 03:08:36 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:611 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751368AbWDBHIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 03:08:36 -0400
Message-ID: <442F7871.4030405@bigpond.net.au>
Date: Sun, 02 Apr 2006 17:08:33 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smpnice loadbalancing with high priority tasks
References: <4428D112.7050704@bigpond.net.au> <20060328112521.A27574@unix-os.sc.intel.com> <4429BC61.7020201@bigpond.net.au> <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com> <442B3111.5030808@bigpond.net.au> <20060401204824.A8662@unix-os.sc.intel.com>
In-Reply-To: <20060401204824.A8662@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 2 Apr 2006 07:08:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> Peter,
> 
> There are still issues which we need to address.. These are surfacing
> as we are patching issue by issue(instead of addressing the root issue, which
> is: presence of high priority tasks messes up load balancing of normal
> priority tasks..)
> 
> for example
> 
> a) on a simple 4-way MP system, if we have one high priority and 4 normal
> priority tasks, with smpnice we would like to see the high priority task
> scheduled on one cpu, two other cpus getting one normal task each and the
> fourth cpu getting the remaining two normal tasks. but with smpnice that 
> extra normal priority task keeps jumping from one cpu to another cpu having
> the normal priority task.
> 
> This is because of the busiest_has_loaded_cpus, nr_loaded_cpus logic.. We
> are not including the cpu with high priority task in max_load calculations
> but including that in total and avg_load calcuations.. leading to max_load <
> avg_load and load balance between cpus running normal priority tasks(2 Vs 1)
> will always show imbalanace as one normal priority and the extra normal
> priority task will keep moving from one cpu to another cpu having
> normal priority task..

I can't see anything like this in the code.  Can you send a patch to fix 
what you think the problem in the is?

The effect you describe can be caused by other tasks running on the 
system (see below for fuller description).

> 
> b) on a simple DP system, if we have two high priority and two normal priority
> tasks, ideally we should schedule one high and one normal priority task on 
> each cpu.. current code doesn't find an imbalance if both the normal priority
> tasks gets scheduled on the same cpu(running one high priority task)

This is one of my standard tests and it works for me.  The only time the 
two normal priority tasks end up on the same CPU during my tests is when 
some other normal priority tasks (e.g. top, X.org) happen to be running 
when load balancing occurs.  This causes an imbalance and tasks that 
aren't actually on the CPU get moved to fix the imbalance.  This is 
usually the test tasks as (because they are hard spinners) they have a 
smaller interactive bonus than the other tasks and get preempted as a 
result.

> 
> there may not be benchmarks which expose these conditions.. but I think
> we haven't addressed the corner case conditions well enough..

Both of the problems you describe above are probably caused by the fact 
that there are other tasks (than those in your tests) running on your 
system and if they happen to be on a run queue at the time load 
balancing is done they will cause an imbalance to be detected that is 
different to what you expect based on a simplistic view of the world 
that only considers the test tasks.  When this happens tasks will get 
moved to restore balance.  This (in my opinion) is what you are seeing.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

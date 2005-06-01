Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVFASzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVFASzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVFASxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:53:02 -0400
Received: from mail.ccur.com ([208.248.32.212]:32115 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261161AbVFASld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:41:33 -0400
Subject: Re: SD_SHARE_CPUPOWER breaks scheduler fairness
From: Steve Rotolo <steve.rotolo@ccur.com>
Reply-To: steve.rotolo@ccur.com
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, bugsy@ccur.com
In-Reply-To: <200506020047.16752.kernel@kolivas.org>
References: <1117561608.1439.168.camel@whiz>
	 <200506011249.47655.kernel@kolivas.org>
	 <1117636171.22879.29.camel@bonefish>
	 <200506020047.16752.kernel@kolivas.org>
Content-Type: text/plain
Organization: Concurrent Computer Corporation
Message-Id: <1117651285.22879.73.camel@bonefish>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Wed, 01 Jun 2005 14:41:25 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2005 18:41:25.0880 (UTC) FILETIME=[84053F80:01C566D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 10:47, Con Kolivas wrote:

> I didn't miss the point, but I guess I should have made that clear too.
> 
> The number of tasks seen running on that sibling is still the same even if the 
> queue is forced to be idle (witness by top thinking the load is 1 on that 
> sibling even if it also shows quite a lot of idle time). It should therefore 
> not attract any more tasks to itself. 
> The task that is there will be trapped based on the fact that there is only 
> one task _only_ if the other sibling is indefinitely running real time tasks, 
> and _if_ there are other physical cpus we can use we should try to schedule 
> the trapped task away. If we have N physical cpus (and N*2 logical), and we 
> are running N real time threads I don't think we should expect to run 
> SCHED_NORMAL tasks as well. If we have <N real time tasks (where N > 1) then 
> we should still be able to run SCHED_NORMAL tasks, I agree. I'm a little 
> reluctant to tackle this at this stage with the number of SMP balancing 
> things already queued for -mm, but making a sibling appear more heavily laden 
> when "pegged" (nr_running + 1) should suffice.
> 

Consider what happens if:
- you have 2 physical cpus, 4 logical cpus
- you have 40 running SCHED_NORMAL tasks on a well balanced system --
roughly 10 on each runqueue
- start up a spinning SCHED_FIFO task on cpu 0

Assuming that cpu 1 is the sibling of 0, cpu 1 now has 10 SCHED_NORMAL
tasks that are totally screwed -- they will never, ever, run anywhere,
period.

Now consider what happens if I start up 40 more SCHED_NORMAL tasks.  The
load-balancer will kindly place 10 of them on cpu 1's runqueue so they
too can be screwed for all eternity.  Nice.

One more thing: I *think* wake_idle() tends to wake tasks to idle cpus
regardless of the idle cpu's runqueue length.  This is why I say the
idle cpu becomes a magnet for even more tasks, until the balancer
straightens things out again.

I guess the bottom-line is: given N logical cpus, 1/N of all
SCHED_NORMAL tasks may get stuck on a sibling cpu with no chance to
run.  All it takes is one spinning SCHED_FIFO task.  Sounds like a bug.

-- 
Steve


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVFBN3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVFBN3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVFBN3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:29:32 -0400
Received: from mail.ccur.com ([208.248.32.212]:22553 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261413AbVFBN31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:29:27 -0400
Subject: Re: SD_SHARE_CPUPOWER breaks scheduler fairness
From: Steve Rotolo <steve.rotolo@ccur.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org, bugsy@ccur.com
In-Reply-To: <200506020925.26320.kernel@kolivas.org>
References: <1117561608.1439.168.camel@whiz>
	 <200506020737.20098.kernel@kolivas.org>
	 <20050601231615.GA11301@tsunami.ccur.com>
	 <200506020925.26320.kernel@kolivas.org>
Content-Type: text/plain
Organization: Concurrent Computer Corporation
Message-Id: <1117719021.1436.56.camel@whiz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 02 Jun 2005 09:30:21 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2005 13:29:26.0562 (UTC) FILETIME=[18D9C020:01C56777]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Wild thought: how about doing this for the sibling ...
> >
> > 	rp->nr_running += SOME_BIG_NUMBER
> >
> > when a SCHED_FIFO task starts running on some cpu, and
> > undo the above when the cpu is released.   This fools
> > the load balancer into _gradually_ moving tasks off the
> > sibling, when the cpu is hogged by some SCHED_FIFO task,
> > but should have little effect if a SCHED_FIFO task takes
> > little cpu time.
> 
> A good thought, and one I had considered. SOME_BIG_NUMBER needs to be 
> meaninful for this to work. Ideally what we do is add the effective load from 
> the sibling cpu to the pegged cpu. However that's not as useful as it sounds 
> because we need to ensure both sibling runqueues are locked every time we 
> check the load value of one runqueue, and the last thing I want is to 
> introduce yet more locking. Also the value will vary wildly depending on 
> whether the task is pegged or not, and this changes in mainline many times in 
> less than .1s which means it would throw load balancing way off as the value 
> will effectively become meaningless.
> 

Just a few more thoughts on this....

I can't help but wonder if a similar problem exists even without HT. 
What if the load-balancer decides to keep a sched_normal task on a cpu
that is being dominated by a sched_fifo task.  The sched_normal task
should really be "balanced" to a different cpu but because nr_running is
the only balancing criteria that may not happen.  Runqueue business
ought to be weighted by the amount of time that sched_fifo tasks on that
runqueue have recently used.  So, load = rq->nr_running +
rq->recent_fifo_run_time.  I think this would make load-balancing more
correct.

Now back to HT sched_domains...  It seems to me that when
SD_SHARE_CPUPOWER is on, recent_fifo_run_time should apply to the whole
domain instead of a single runqueue, so that a cpu's load =
rq->nr_running + sd->recent_fifo_run_time.  But I don't know if this
suffers from the same runqueue locking problem that you pointed out.

-- 
Steve


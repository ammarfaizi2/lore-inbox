Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVFAXiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVFAXiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVFAXcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:32:05 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:25033 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261488AbVFAXX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:23:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: joe.korty@ccur.com
Subject: Re: SD_SHARE_CPUPOWER breaks scheduler fairness
Date: Thu, 2 Jun 2005 09:25:26 +1000
User-Agent: KMail/1.8
Cc: steve.rotolo@ccur.com, linux-kernel@vger.kernel.org, bugsy@ccur.com
References: <1117561608.1439.168.camel@whiz> <200506020737.20098.kernel@kolivas.org> <20050601231615.GA11301@tsunami.ccur.com>
In-Reply-To: <20050601231615.GA11301@tsunami.ccur.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506020925.26320.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005 09:16 am, Joe Korty wrote:
> > On Thu, 2 Jun 2005 04:41, Steve Rotolo wrote:
> > > I guess the bottom-line is: given N logical cpus, 1/N of all
> > > SCHED_NORMAL tasks may get stuck on a sibling cpu with no chance to
> > > run.  All it takes is one spinning SCHED_FIFO task.  Sounds like a bug.
> >
> > You're right, and excuse me for missing it. We have to let SCHED_NORMAL
> > tasks run for some period with rt tasks. There shouldn't be any
> > combination of mutually exclusive tasks for siblings.
> >
> > I'll work on something.
>
> Wild thought: how about doing this for the sibling ...
>
> 	rp->nr_running += SOME_BIG_NUMBER
>
> when a SCHED_FIFO task starts running on some cpu, and
> undo the above when the cpu is released.   This fools
> the load balancer into _gradually_ moving tasks off the
> sibling, when the cpu is hogged by some SCHED_FIFO task,
> but should have little effect if a SCHED_FIFO task takes
> little cpu time.

A good thought, and one I had considered. SOME_BIG_NUMBER needs to be 
meaninful for this to work. Ideally what we do is add the effective load from 
the sibling cpu to the pegged cpu. However that's not as useful as it sounds 
because we need to ensure both sibling runqueues are locked every time we 
check the load value of one runqueue, and the last thing I want is to 
introduce yet more locking. Also the value will vary wildly depending on 
whether the task is pegged or not, and this changes in mainline many times in 
less than .1s which means it would throw load balancing way off as the value 
will effectively become meaningless.

I already have a plan for this without really touching the load balancing.

Cheers,
Con

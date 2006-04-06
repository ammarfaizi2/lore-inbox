Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWDFSQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWDFSQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWDFSQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 14:16:06 -0400
Received: from dvhart.com ([64.146.134.43]:31431 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932221AbWDFSQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 14:16:05 -0400
From: Darren Hart <darren@dvhart.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: RT task scheduling
Date: Thu, 6 Apr 2006 11:16:01 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <200604052025.05679.darren@dvhart.com> <20060406073753.GA18349@elte.hu>
In-Reply-To: <20060406073753.GA18349@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604061116.02429.darren@dvhart.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 April 2006 00:37, Ingo Molnar wrote:
> * Darren Hart <darren@dvhart.com> wrote:
> > My last mail specifically addresses preempt-rt, but I'd like to know
> > people's thoughts regarding this issue in the mainline kernel.  Please
> > see my previous post "realtime-preempt scheduling - rt_overload
> > behavior" for a testcase that produces unpredictable scheduling
> > results.
>
> the rt_overload feature i intend to push upstream-wards too, i just
> didnt separate it out of -rt yet.
>
> "RT overload scheduling" is a totally orthogonal mechanism to the SMP
> load-balancer (and this includes smpnice too) that is more or less
> equivalent to having a 'global runqueue' for real-time tasks, without
> the SMP overhead associated with that. If there is no "RT overload" [the
> common case even on Linux systems that _do_ make use of RT tasks
> occasionally], the new mechanism is totally inactive and there's no
> overhead. But once there are more RT tasks than CPUs, the scheduler will
> do "global" decisions for what RT tasks to run on which CPU. To put even
> less overhead on the mainstream kernel, i plan to introduce a new
> SCHED_FIFO_GLOBAL scheduling policy to trigger this behavior. [it doesnt
> make much sense to extend SCHED_RR in that direction.]
>
> my gut feeling is that it would be wrong to integrate this feature into
> smpnice: SCHED_FIFO is about determinism, and smpnice is a fundamentally
> statistical approach. Also, smpnice doesnt have to try as hard to pick
> the right task as rt_overload does, so there would be constant
> 'friction' between "overhead" optimizations (dont be over-eager) and
> "latency" optimizations (dont be _under_-eager). So i'm quite sure we
> want this feature separate. [nevertheless i'd happy to be proven wrong
> via some good and working smpnice based solution]
>
> in any case, i'll check your -rt testcase to see why it fails.

Just as an example, here is the output a failing test case on a 4way machine 
running 2.6.16-rt13 (a successful run would have a final ball position of 0).

[root@box sched_football]# ./sched_football 4 10
Starting 4 offense threads at priority 15
Starting 4 defense threads at priority 30
Starting referee thread
Game On (10 seconds)!
Game Over!
Final ball position: 5
[root@box sched_football]#

--Darren

>
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

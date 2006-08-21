Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWHUHza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWHUHza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 03:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWHUHza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 03:55:30 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:2947 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030292AbWHUHz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 03:55:29 -0400
Date: Mon, 21 Aug 2006 13:28:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Tejun Heo <htejun@gmail.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] file: kill unnecessary timer in fdtable_defer
Message-ID: <20060821075818.GG5433@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060820131542.GN6371@htj.dyndns.org> <20060821043257.GD5433@in.ibm.com> <20060821051816.GP6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821051816.GP6371@htj.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 02:18:16PM +0900, Tejun Heo wrote:
> On Mon, Aug 21, 2006 at 10:02:57AM +0530, Dipankar Sarma wrote:
> > > regardless of its return value.  0 return simply means that the work
> > > was already pending and thus no further action was required.
> > 
> > Hmm.. Is this really true ? IIRC, schedule_work() checks pending
> > work based on bit ops on work->pending and clear_bit() is not
> > a memory barrier.
> 
> Those bitops are not memory barriers but they can define order between
> them alright.  Once the execution order is correct, the rest of

Huh ? If they are not memory barriers, they how can you guranttee
ordering on weakly ordered CPUs ?


> In workqueue, this is guaranteed by
> 
> 1. If pending bit is set, the work is guaranteed to be executed in
>    some future - it's on timer or queue.
> 
> 2. The queuer sets the pending bit *after* producing a job to be
>    done.
> 
> 3. The worker clears the pending *before* executing the job.
> 
> I sometimes find it easier to understand with a diagram which looks
> like the following.  Time flows from top to bottom.
> 
>           Queuer			  Worker
> 
>         -------------
>        | produce job |
>        |             |             <--- clr pending --->
>         -------------                        |
>               |                              v
>               v                       --------------
>     <--- set pending --->            | consume jobs |
> 				     |		    |
> 				      --------------
> 
> Now move the queuer and worker up and down in your mind.  If 'set
> pending' is higher than clr pending 'consume job' is guaranteed to see
> the job queuer has produced whether pending is set or clear
> beforehand.  If 'set pending' is lower than 'clr pending', it is
> guaranteed to set pending and schedule worker.  The workqueue is
> straight-forward expansion where there are N queuers and a repeating
> consumer.

Given that there is no smp_mb__after_clear_bit() after clearing
work->pending, what prevents the worker thread from seeing
the state of the deferred fd queue before setting the pending bit ?
IOW, the queuer sees pending = 1 and ignores waking the
worker thread, worker sees a stale state of the deferred fd queue
ignoring the newly queued work. That should be possible on
a cpu with weak memory ordering. Perhaps, we should fix
__queue_work() to add the smp_mb__after_clear_bit() and
make sure that we have a memory barrier after adding the
deferred fds.

Thanks
Dipankar



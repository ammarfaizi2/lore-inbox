Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWHUIZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWHUIZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 04:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWHUIZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 04:25:04 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:15249 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030338AbWHUIZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 04:25:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ohcAf7RK1tB3lktsvUbQhQM3vn1ZEqN6wv4fX4qQO3Vd4de/06RD6d6UmB+191O+ZFoi8KKEeKLRvBare1xGKPCHT1HS0bxy7kug5q1xLqGuwbwCi0VjtXLkdY5FyI8FJ+1gwTFlHh8zbgsV3rN9FGbyWbA2gd7ac9YUE/EOfYc=
Date: Mon, 21 Aug 2006 17:24:54 +0900
From: Tejun Heo <htejun@gmail.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] file: kill unnecessary timer in fdtable_defer
Message-ID: <20060821082454.GA19320@htj.dyndns.org>
References: <20060820131542.GN6371@htj.dyndns.org> <20060821043257.GD5433@in.ibm.com> <20060821051816.GP6371@htj.dyndns.org> <20060821075818.GG5433@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821075818.GG5433@in.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 01:28:18PM +0530, Dipankar Sarma wrote:
> On Mon, Aug 21, 2006 at 02:18:16PM +0900, Tejun Heo wrote:
> > On Mon, Aug 21, 2006 at 10:02:57AM +0530, Dipankar Sarma wrote:
> > > > regardless of its return value.  0 return simply means that the work
> > > > was already pending and thus no further action was required.
> > > 
> > > Hmm.. Is this really true ? IIRC, schedule_work() checks pending
> > > work based on bit ops on work->pending and clear_bit() is not
> > > a memory barrier.
> > 
> > Those bitops are not memory barriers but they can define order between
> > them alright.  Once the execution order is correct, the rest of
> 
> Huh ? If they are not memory barriers, they how can you guranttee
> ordering on weakly ordered CPUs ?

Atomic bitops define orders *between* them not *around* them.  ie. if
you have two atomic bitops on the same bit, they're ordered one way or
the other.  As the workqueue code currently stands, ordering around
the bitops is the caller's responsibility and fddef does it with a
spinlock.  As the producer and consumer usually access a common
resource, that kind of synchrnoization is inherent in most cases.

[--snip--]
> Given that there is no smp_mb__after_clear_bit() after clearing
> work->pending, what prevents the worker thread from seeing

Let me revise the diagram.

            Queuer                         Worker
 
             lock
         -------------             <--- clr pending --->
        | produce job |                       |
        |             |                       v
         -------------                  trying to lock
            unlock                            v
               |                        lock granted
               v                       --------------
     <--- set pending --->            | consume jobs |
                                      |              |
                                       --------------
                                           unlock

> the state of the deferred fd queue before setting the pending bit ?
> IOW, the queuer sees pending = 1 and ignores waking the
> worker thread, worker sees a stale state of the deferred fd queue
> ignoring the newly queued work. That should be possible on
> a cpu with weak memory ordering.

Queue being a shared resource, people usually synchronize around it.

> Perhaps, we should fix __queue_work() to add the
> smp_mb__after_clear_bit() and make sure that we have a memory
> barrier after adding the deferred fds.

That would help if the producer and consumer depend on memory ordering
for synchronization, which usually isn't the case.  I'm not sure
whether adding that is a good idea or not.  IMHO, it's better to use
explicit memory barriers with enough comments in such subtle cases to
make things clear.

Either way, fddef is just straight forward producer-consumer case with
no need for requeueing mechanism.  There is no need and no other user
does anything similar.

Thanks.

-- 
tejun

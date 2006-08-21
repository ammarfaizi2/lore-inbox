Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbWHUFSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWHUFSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 01:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWHUFSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 01:18:24 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:15645 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932600AbWHUFSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 01:18:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=owIUO3t4DU/IIcbX+eK+0hCT+5Na8oqZysVfy2pyn92iP8D7WW9O8PyJF1pm+eUHbKUJw+kFamkW0jg/LWCFXIJiuLA9ywTxTIWU0YvbBfSZ8sI27UZ2w4D+mPxvKFfvgGwTcUntgwQKrnjVe9mfK0XatuFyg2Eb2WfFtiZJYC8=
Date: Mon, 21 Aug 2006 14:18:16 +0900
From: Tejun Heo <htejun@gmail.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] file: kill unnecessary timer in fdtable_defer
Message-ID: <20060821051816.GP6371@htj.dyndns.org>
References: <20060820131542.GN6371@htj.dyndns.org> <20060821043257.GD5433@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821043257.GD5433@in.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 10:02:57AM +0530, Dipankar Sarma wrote:
> On Sun, Aug 20, 2006 at 10:15:42PM +0900, Tejun Heo wrote:
> > free_fdtable_rc() schedules timer to reschedule fddef->wq if
> > schedule_work() on it returns 0.  However, schedule_work() guarantees
> > that the target work is executed at least once after the scheduling
> > regardless of its return value.  0 return simply means that the work
> > was already pending and thus no further action was required.
> 
> Hmm.. Is this really true ? IIRC, schedule_work() checks pending
> work based on bit ops on work->pending and clear_bit() is not
> a memory barrier.

Those bitops are not memory barriers but they can define order between
them alright.  Once the execution order is correct, the rest of
synchronization is the caller's responsbility.  In fddef's case, it's
achieved via fddef->lock.

> So, if I see work->pending = 1 in free_fdtable_work(), how do I know
> that the work function is already executing and missed the new work
> that I had queued ?

This is classical edge-triggered event handling where each event
doesn't require separate handling.  The producer produces one or more
items at a time and the consumer consumes the whole queue on
invocation.

For example, when Pn indicates producing of item n and C indicates
consuming.  The seqeunce "P0 C P1 C P2 C" and "P0 P1 P2 C" are
effectively identical, so all that's required for correct operation
(that is, full queue consumption) is that the consumer is run at least
once after producing of the last item.

In workqueue, this is guaranteed by

1. If pending bit is set, the work is guaranteed to be executed in
   some future - it's on timer or queue.

2. The queuer sets the pending bit *after* producing a job to be
   done.

3. The worker clears the pending *before* executing the job.

I sometimes find it easier to understand with a diagram which looks
like the following.  Time flows from top to bottom.

          Queuer			  Worker

        -------------
       | produce job |
       |             |             <--- clr pending --->
        -------------                        |
              |                              v
              v                       --------------
    <--- set pending --->            | consume jobs |
				     |		    |
				      --------------

Now move the queuer and worker up and down in your mind.  If 'set
pending' is higher than clr pending 'consume job' is guaranteed to see
the job queuer has produced whether pending is set or clear
beforehand.  If 'set pending' is lower than 'clr pending', it is
guaranteed to set pending and schedule worker.  The workqueue is
straight-forward expansion where there are N queuers and a repeating
consumer.

-- 
tejun

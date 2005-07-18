Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVGRLdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVGRLdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 07:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVGRLdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 07:33:44 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:6364 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S261673AbVGRLdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 07:33:42 -0400
Date: Mon, 18 Jul 2005 13:33:07 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Chinner <dgc@sgi.com>,
       Nathan Scott <nathans@sgi.com>, Steve Lord <lord@xfs.org>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: RT and XFS
In-Reply-To: <1121444215.19554.18.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Message-Id: <Pine.OSF.4.05.10507171752410.14250-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Daniel Walker wrote:

> On Fri, 2005-07-15 at 12:23 +0200, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > PI is always good, cause it allows the tracking of what is high 
> > > priority , and what is not .
> > 
> > that's just plain wrong. PI might be good if one cares about priorities 
> > and worst-case latencies, but most of the time the kernel is plain good 
> > enough and we dont care. PI can also be pretty expensive. So in no way, 
> > shape or form can PI be "always good".
> 
> I don't agree with that. But of course I'm always speaking from a real
> time perspective . PI is expensive , but it won't always be. However, no
> one is forcing PI on anyone, even if I think it's good ..
> 

Is PI needed? If you use a mutex to protect a critical area you are
destroying the strict meaning of priorities if the mutex doesn't have PI:
Priority inversion can effectively make the high priority task low
priority in that situation and postpone it's execution indefinitely. 
For RT applications that is clearly unacceptable.

One can argue that for non-RT tasks priorities aren't supposed to be that 
rigid as for RT tasks, anyway. Therefore it doesn't matter so much.
But as I read the comments in sched.c a nice -20 task have to preempt any
nice 0 task no matter how much a cpu-hog it is. If it happens to share a
critical section with a nice +19 task, priority inversion will
occationally destroy that property. If we disregard the costs of PI, PI is
thus a good thing.

But how expensive is PI? Ofcourse there is an overhead in doing
the calculations. Ingo's implementation can be optimized quite a bit once
things are settled but it will always be many times more expensive than a
raw spin-lock. But is it much more expensive than a plain binary
semaphore?

If the is no congestion on a mutex the PI code will not be called at all.
On UP, the only occation where congestion can occur is when a low
priority task is preempted by a higher priority task while it has the
mutex. So let us look at the expensive part where the high priority task
tries to grab the mutex:

With PI: The owner have to be boosted, an immediate task switch have to
take place, the owner runs to the unlock operation and it set down in
priority, whereafter there is a task-switch again to the highpriority
task.

Without PI: The owner waits and there is a task switch to some thread
which might not be the owner but often is. When the owner eventually
unlocks the mutex it will be follow by a task-switch - because congestion
can only occur when the task trying to get the task preempts and thus have
higher priority than the owner.

The number of task switches are thus the same with and without PI!

And then there is the cache issue: When other tasks gets scheduled in the
priority inversion case the data being protected can be flushed from the
cache while they are running. With PI the CPU continues to work with the
same data - and most often in the same code module. I.e. there is a higher
chance that the instruction and data cache contains the right data.

Thus in the end it all depends on how cheaply the PI calculations can be
made.

Esben

> Daniel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 




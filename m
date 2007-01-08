Return-Path: <linux-kernel-owner+w=401wt.eu-S1161352AbXAHQb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161352AbXAHQb6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 11:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161345AbXAHQb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 11:31:58 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:50324 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161352AbXAHQb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 11:31:56 -0500
Date: Mon, 8 Jan 2007 22:01:40 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070108163140.GC31263@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org> <20070107215103.GA7960@tv-sign.ru> <20070108152211.GA31263@in.ibm.com> <20070108155638.GA156@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108155638.GA156@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 06:56:38PM +0300, Oleg Nesterov wrote:
> > Spotted atleast these problems:
> >
> > 1. run_workqueue()->work.func()->flush_work()->mutex_lock(workqueue_mutex)
> >    deadlocks if we are blocked in cleanup_workqueue_thread()->kthread_stop()
> >    for the same worker thread to exit.
> >
> >    Looks possible in practice to me.
> 
> Yes, this is the same (old) problem as we have/had with flush_workqueue().
> We can convert flush_work() to use preempt_disable (this is not straightforward,
> but easy), or forbid to call flush_work() from work.func().

I think I noticed other problems of avoiding workqueue_mutex() in
flush_work() ..don't recall the exact problem.

> > 2.
> >
> > CPU_DEAD->cleanup_workqueue_thread->(cwq->thread = NULL)->kthread_stop() ..
> > 				    ^^^^^^^^^^^^^^^^^^^^
> > 						|___ Problematic
> 
> Hmm... This should not be possible? cwq->thread != NULL on CPU_DEAD event.

sure, cwq->thread != NULL at CPU_DEAD event. However
cleanup_workqueue_thread() will set it to NULL and block in
kthread_stop(), waiting for the kthread to finish run_workqueue and
exit. If one of the work functions being run by run_workqueue() calls
flush_workqueue()->flush_cpu_workqueue() now, flush_cpu_workqueue() can fail to 
recognize that "keventd is trying to flush its own queue" which can
cause deadlocks.

> > Now while we are blocked here, if a work->func() calls
> > flush_workqueue->flush_cpu_workqueue, we clearly cant identify that event
> > thread is trying to flush its own queue (cwq->thread == current test
> > fails) and hence we will deadlock.
> 
> Could you clarify? I believe cwq->thread == current test always works, we never
> "substitute" cwq->thread.

The test fails in the window described above.

> > A lock_cpu_hotplug(), or any other ability to block concurrent hotplug
> > operations from happening, in run_workqueue would have avoided both the above
> > races.
> 
> I still don't think this is a good idea. We also need
> 	is_cpu_down_waits_for_lock_cpu_hotplug()
> 
> helper, otherwise we have a deadlock if work->func() sleeps and re-queues itself.

Can you elaborate this a bit?

> > Alternatively, for the second race, I guess we can avoid setting
> > cwq->thread = NULL in cleanup_workqueue_thread() till the thread has exited,
> 
> Yes, http://marc.theaimsgroup.com/?l=linux-kernel&m=116818097927685, I believe
> we can do this later. This way workqueue will have almost zero interaction
> with cpu-hotplug, and cpu UP/DOWN event won't be delayed by sleeping work.func().
> take_over_work() can go away, this also allows us to simplify things.

I agree it minimizes the interactions. Maybe worth attempting. However I
suspect it may not be as simple as it appears :)


-- 
Regards,
vatsa

Return-Path: <linux-kernel-owner+w=401wt.eu-S1751586AbXAHPWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbXAHPWY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbXAHPWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:22:24 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:60679 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbXAHPWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:22:23 -0500
Date: Mon, 8 Jan 2007 20:52:11 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070108152211.GA31263@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org> <20070107215103.GA7960@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107215103.GA7960@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 12:51:03AM +0300, Oleg Nesterov wrote:
> Change flush_workqueue() to use for_each_possible_cpu(). This means that
> flush_cpu_workqueue() may hit CPU which is already dead. However in that
> case
> 
> 	if (!list_empty(&cwq->worklist) || cwq->current_work != NULL)
> 
> means that CPU_DEAD in progress, it will do kthread_stop() + take_over_work()
> so we can proceed and insert a barrier. We hold cwq->lock, so we are safe.
> 
> This patch replaces fix-flush_workqueue-vs-cpu_dead-race.patch which was
> broken by switching to preempt_disable (now we don't need locking at all).
> Note that migrate_sequence (was hotplug_sequence) is incremented under
> cwq->lock. Since flush_workqueue does lock/unlock of cwq->lock on all CPUs,
> it must see the new value if take_over_work() happened before we checked
> this cwq, and this is the case we should worry about: otherwise we added
> a barrier.
> 
> Srivatsa?

This is head-spinning :)

Spotted atleast these problems:

1. run_workqueue()->work.func()->flush_work()->mutex_lock(workqueue_mutex)
   deadlocks if we are blocked in cleanup_workqueue_thread()->kthread_stop() 
   for the same worker thread to exit.

   Looks possible in practice to me.

2. 
     
CPU_DEAD->cleanup_workqueue_thread->(cwq->thread = NULL)->kthread_stop() ..
				    ^^^^^^^^^^^^^^^^^^^^
						|___ Problematic

Now while we are blocked here, if a work->func() calls
flush_workqueue->flush_cpu_workqueue, we clearly cant identify that event 
thread is trying to flush its own queue (cwq->thread == current test
fails) and hence we will deadlock.

A lock_cpu_hotplug(), or any other ability to block concurrent hotplug 
operations from happening, in run_workqueue would have avoided both the above
races.

Alternatively, for the second race, I guess we can avoid setting 
cwq->thread = NULL in cleanup_workqueue_thread() till the thread has exited, 
but I am not sure if that opens up any other race. The first race seems
harder to fix ..

I wonder if spin (spinroot.com) or some other formal model can make this job of
spotting-races easier for us ..

-- 
Regards,
vatsa

Return-Path: <linux-kernel-owner+w=401wt.eu-S932344AbXAPF0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbXAPF0L (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 00:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbXAPF0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 00:26:11 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:49316 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932344AbXAPF0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 00:26:10 -0500
Date: Tue, 16 Jan 2007 10:56:06 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070116052606.GA995@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070109150755.GB89@tv-sign.ru> <20070109155908.GD22080@in.ibm.com> <20070109163815.GA208@tv-sign.ru> <20070109164604.GA17915@in.ibm.com> <20070109165655.GA215@tv-sign.ru> <20070114235410.GA6165@tv-sign.ru> <20070115043304.GA16435@in.ibm.com> <20070115125401.GA134@tv-sign.ru> <20070115161810.GB16435@in.ibm.com> <20070115165516.GA254@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115165516.GA254@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 07:55:16PM +0300, Oleg Nesterov wrote:
> > What if 'singlethread_cpu' dies?
> 
> Still can't understand you. Probably you missed what singlethread_cpu is.

oops yes ..I had mistakenly thought that create_workqueue_thread() will
bind worker thread to singlethread_cpu for single_threaded workqueue.
So it isn't a problem.
 
> > What abt __create_workqueue/schedule_on_each_cpu?
> 
> As I said already __create_workqueue() needs a fix, schedule_on_each_cpu()
> is already broken, and should be fixed as well.

__create_workqueue() creates worker threads for all online CPUs
currently. Accessing the online_map could be racy unless we 
serialize the access with hotplug event (thr' a mutex like workqueue
mutex held between LOCK_ACQ/LOCK_RELEASE messages or process freezer)
OR take special measures as was done in flush_workqueue. How were
you considering to deal with that raciness?

> > > The whole purpose of this change to avoid this!
> >
> > I guess it depends on how __create_workqueue/schedule_on_each_cpu is
> > modified (whether we take/release lock upon LOCK_ACQ/LOCK_RELEASE)
> 
> Sorry, can't understand this...

I meant to say that depending on how we modify
__create_workqueue/schedule_on_each_cpu to avoid racy-access to
online_map, we can debate whether workqueue mutex needs to be held
between LOCK_ACQ/LOCK_RELEASE messages in the callback.

> > What abt stopping that thread in CPU_DOWN_PREPARE (before freezing
> > processes)? I understand that it may add to the latency, but compared to
> > the overall latency of process freezer, I suspect it may not be much.
> 
> Srivatsa, why do you think this would be better?
> 
> It add to the complexity! What do you mean by "stopping that thread" ?
> Kill it? - this is wrong. 

I meant issuing kthread_stop() in DOWN_PREPARE so that worker
thread exits itself (much before CPU is actually brought down).

Do you see any problems with that?

Even if there are problems with it, how abt something like below:

workqueue_cpu_callback()
{

	CPU_DEAD:
		/* threads are still frozen at this point */
		take_over_work();
		kthread_mark_stop(worker_thread);
		break;

	CPU_CLEAN_THREADS:
		/* all threads resumed by now */
		kthread_stop(worker_thread); /* task_struct ref required? */
		break;

}

kthread_mark_stop() will mark somewhere in task_struct that the thread
should exit when it comes out of refrigerator.

worker_thread()
{
	
        while (!kthread_should_stop()) {
                if (cwq->freezeable)
                        try_to_freeze();

		if (kthread_marked_stop(current))
			break;

		...

	}
}

The advantage I see above is that, when take_over_work() is running, we wont 
race with functions like flush_workqueue() (threads still frozen at that
point) and hence we avoid hacks like migrate_sequence. This will also
let functions like flush_workqueue() easily access cpu_online_map as
below -without- any special locking/hacks (which I consider a great
benefit for programmers).

flush_workqueue()
{
	for_each_online_cpu(i)
		flush_cpu_workqueue(i);
}

Do you see any problems with this later approach?
		
-- 
Regards,
vatsa

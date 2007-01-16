Return-Path: <linux-kernel-owner+w=401wt.eu-S1751068AbXAPN2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbXAPN2e (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 08:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXAPN2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 08:28:34 -0500
Received: from mail.screens.ru ([213.234.233.54]:49121 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbXAPN2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 08:28:33 -0500
Date: Tue, 16 Jan 2007 16:27:25 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070116132725.GA81@tv-sign.ru>
References: <20070109155908.GD22080@in.ibm.com> <20070109163815.GA208@tv-sign.ru> <20070109164604.GA17915@in.ibm.com> <20070109165655.GA215@tv-sign.ru> <20070114235410.GA6165@tv-sign.ru> <20070115043304.GA16435@in.ibm.com> <20070115125401.GA134@tv-sign.ru> <20070115161810.GB16435@in.ibm.com> <20070115165516.GA254@tv-sign.ru> <20070116052606.GA995@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070116052606.GA995@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16, Srivatsa Vaddagiri wrote:
>
> On Mon, Jan 15, 2007 at 07:55:16PM +0300, Oleg Nesterov wrote:
> >
> > As I said already __create_workqueue() needs a fix, schedule_on_each_cpu()
> > is already broken, and should be fixed as well.
> 
> __create_workqueue() creates worker threads for all online CPUs
> currently. Accessing the online_map could be racy unless we 
> serialize the access with hotplug event (thr' a mutex like workqueue
> mutex held between LOCK_ACQ/LOCK_RELEASE messages or process freezer)
> OR take special measures as was done in flush_workqueue. How were
> you considering to deal with that raciness?

This is easy to fix in multiple ways. For example (this is not the best
approach), we can make cpu_creation_map. Like cpu_populate_map, but CPU
is cleared on CPU_DEAD/CPU_UP_CANCELED.

I'll continue when I have a time.

> > > What abt stopping that thread in CPU_DOWN_PREPARE (before freezing
> > > processes)? I understand that it may add to the latency, but compared to
> > > the overall latency of process freezer, I suspect it may not be much.
> 
> I meant issuing kthread_stop() in DOWN_PREPARE so that worker
> thread exits itself (much before CPU is actually brought down).

Deadlock if work_struct re-queues itself.

> Even if there are problems with it, how abt something like below:
> 
> workqueue_cpu_callback()
> {
> 
> 	CPU_DEAD:
> 		/* threads are still frozen at this point */
> 		take_over_work();

No, we can't move a currently executing work. This will break flush_workxxx().

> 		kthread_mark_stop(worker_thread);
> 		break;
> 
> 	CPU_CLEAN_THREADS:
> 		/* all threads resumed by now */
> 		kthread_stop(worker_thread); /* task_struct ref required? */

yes, required,

> kthread_mark_stop() will mark somewhere in task_struct that the thread
> should exit when it comes out of refrigerator.
> 
> worker_thread()
> {
> 	
>         while (!kthread_should_stop()) {
>                 if (cwq->freezeable)
>                         try_to_freeze();
> 
> 		if (kthread_marked_stop(current))
> 			break;

Racy. Because of kthread_stop() above we should clear cwq->thread somehow.
But we can't do this: this workqueue may be already destroyed.

> The advantage I see above is that, when take_over_work() is running, we wont 
> race with functions like flush_workqueue() (threads still frozen at that
> point) and hence we avoid hacks like migrate_sequence.

See above.

Please note that the code I posted does something like kthread_mark_stop(), but
it operates on cwq, not on task_struct, this makes a big difference. And it doesn't
need take_over_work() at all. And it doesn't need additional complications. Instead,
it lessens both the source and compiled code.

Note that I am not against using freezer for cpu-hotplug. My point is that this
can't help much for the current workqueue.c, and it will completely transparent
with the change I suggest.

Oleg.


Return-Path: <linux-kernel-owner+w=401wt.eu-S1751588AbXAHRIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbXAHRIE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 12:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbXAHRIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 12:08:04 -0500
Received: from mail.screens.ru ([213.234.233.54]:45433 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbXAHRID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 12:08:03 -0500
Date: Mon, 8 Jan 2007 20:06:35 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070108170635.GA448@tv-sign.ru>
References: <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org> <20070107215103.GA7960@tv-sign.ru> <20070108152211.GA31263@in.ibm.com> <20070108155638.GA156@tv-sign.ru> <20070108163140.GC31263@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108163140.GC31263@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08, Srivatsa Vaddagiri wrote:
>
> On Mon, Jan 08, 2007 at 06:56:38PM +0300, Oleg Nesterov wrote:
> > > 2.
> > >
> > > CPU_DEAD->cleanup_workqueue_thread->(cwq->thread = NULL)->kthread_stop() ..
> > > 				    ^^^^^^^^^^^^^^^^^^^^
> > > 						|___ Problematic
> > 
> > Hmm... This should not be possible? cwq->thread != NULL on CPU_DEAD event.
> 
> sure, cwq->thread != NULL at CPU_DEAD event. However
> cleanup_workqueue_thread() will set it to NULL and block in
> kthread_stop(), waiting for the kthread to finish run_workqueue and
> exit.

Ah, missed you point, thanks. Yet another old problem which was not introduced
by recent changes. And yet another indication we should avoid kthread_stop()
on CPU_DEAD event :) I believe this is easy to fix, but need to think more.

> > > A lock_cpu_hotplug(), or any other ability to block concurrent hotplug
> > > operations from happening, in run_workqueue would have avoided both the above
> > > races.
> > 
> > I still don't think this is a good idea. We also need
> > 	is_cpu_down_waits_for_lock_cpu_hotplug()
> > 
> > helper, otherwise we have a deadlock if work->func() sleeps and re-queues itself.
> 
> Can you elaborate this a bit?

If work->func() re-queues itself, run_workqueue() never returns because
->worklist is never empty. This means we should somehow check and detect
that cpu-hotplug blocked because we hold lock_cpu_hotplug(). In that case
run_workqueue() should return, and drop the lock. This will complicate
worker_thread/run_workqueue further.

	run_workqueue:

		while (!list_empty(&cwq->worklist)) {
			...
			// We hold lock_cpu_hotplug(), cpu event can't make
			// progress. 
			...
		}

> > Yes, http://marc.theaimsgroup.com/?l=linux-kernel&m=116818097927685, I believe
> > we can do this later. This way workqueue will have almost zero interaction
> > with cpu-hotplug, and cpu UP/DOWN event won't be delayed by sleeping work.func().
> > take_over_work() can go away, this also allows us to simplify things.
> 
> I agree it minimizes the interactions. Maybe worth attempting. However I
> suspect it may not be as simple as it appears :)

Yes, that is why this patch only does the first step: flush_workqueue() checks
the dead CPUs as well, this change is minimal.

Do you see any problems this patch adds?

Oleg.


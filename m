Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266654AbSKLSJM>; Tue, 12 Nov 2002 13:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266675AbSKLSJM>; Tue, 12 Nov 2002 13:09:12 -0500
Received: from [195.223.140.107] ([195.223.140.107]:9103 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S266654AbSKLSJJ>;
	Tue, 12 Nov 2002 13:09:09 -0500
Date: Tue, 12 Nov 2002 19:15:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
Subject: Re: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Message-ID: <20021112181532.GA6133@dualathlon.random>
References: <20021112035723.GA17642@dualathlon.random> <3DD0C0E6.4A8035A4@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD0C0E6.4A8035A4@digeo.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 12:50:46AM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > the race looks like this:
> > 
> >         CPU0                    CPU1
> >         -----------------       ------------------------
> >         reiserfs_writepage
> >         lock_buffer()
> >                                 fsync_buffers_list() under lock_super()
> >                                 wait_on_buffer()
> >                                 run_task_queue(&tq_disk) -> noop
> >                                 schedule() <- hang with lock_super acquired
> >         submit_bh()
> >         /* don't unplug here */
> > 
> 
> Or, more simply:
> 
> 	lock_buffer()
> 				while (buffer_locked()) {
> 					blk_run_queues();	/* Nothing happens */
> 					if (buffer_locked(bh))
> 						schedule();
> 	submit_bh();	/* No unplug */
> 

yep that is the simple one, I mentioned the reiserfs more complicated
special case since it is the one that allowed this bug to see the light
of the day, the simple race is resolved by kupdate in mean after 2.5 sec
of hang time.

> 
> The fix seems reasonable to me.  It would perhaps be better to just do:
> 
> +       if (waitqueue_active(wqh))
> +               blk_run_queues();
> 
> in submit_bh().  To save the context switch.

the race triggers very rarely I doubt it could make any difference to
save the context switch and wake_up looked simpler conceptually, but
run_task_queue(&tq_disk)/blk_run_queues will fix it too indeed. It's up
to you, I find the wake_up cleaner.

something more important if you care about microoptimizations is
probably to add unlikely(waitqueue_active()).

> Moving the blk_run_queues() inside the TASK_UNINTERRUPTIBLE region
> is something which always worried me, because if something down
> there sets TASK_RUNNING, we end up in a busy wait.  But that's OK
> for 2.5 and may be OK for 2.4's run_task_queue() - I haven't checked...

even in the unlikely case some buggy request_fn sets the task to
runnable, the second invocation of run_task_queue will do nothing, so
there's no risk to hang in R state and that is the only safe place to
unplug, unplugging before setting the task state is totally broken and
racy, see the deadlock explanation in get_request_wait in 2.4/2.5.

> The multipage stuff in 2.5 does its own blk_run_queues() and looks to be
> OK, which I assume is why you didn't touch that.

yes, but also because I didn't looked much at the 2.5 code, so you
should double check there, at the moment I care most about 2.4 where
this is been a blocker for us until a few days ago.

> The little single-page reads like do_generic_mapping_read() look to be
> OK because the process whcih waits is the one which submitted the IO.

no, you forgot readahead, that's buggy and needs fixing in readpage too
(same in 2.4 and 2.5).

> wrt the get_request_wait changes: I never bothered about the barrier
> because we know that there are tons of requests outstanding, and if
> we don't do a wakeup the next guy will.  Plus *this* request has to
> be put back sometime too, which will deliver a wakeup.  But whatever;
> it's not exactly a fastpath.

I assume you're talking about the smp_mb() needed before reading the
waitqueue. I'm not claiming that the race is pratical, it may not
trigger in most hardware due the timings and hardware detail, but it can
definitely happen in theory.

It doesn't matter if we know there are tons of requests outstanding, if
we read the waitqueue before increasing count, we won't wakeup the other
cpu, and we could get a flood of I/O completion in all cpus all watching
at the waitqueue first, you simply need tot_requests-batch_requests ==
nr_cpus - 1 to be able to trigger it in practice. So algorithmically
speaking the smp_mb() (i.e. barrier() in UP) is needed.

> However the function is still not watertight:
> 
> static struct request *get_request_wait(request_queue_t *q, int rw)
> {
> 	DEFINE_WAIT(wait);
> 	struct request_list *rl = &q->rq[rw];
> 	struct request *rq;
> 
> 	spin_lock_prefetch(q->queue_lock);
> 
> 	generic_unplug_device(q);
> 	do {
> 		prepare_to_wait_exclusive(&rl->wait, &wait,
> 					TASK_UNINTERRUPTIBLE);
> 		if (!rl->count)
> 			io_schedule();
> 		finish_wait(&rl->wait, &wait);
> 		spin_lock_irq(q->queue_lock);
> 		rq = get_request(q, rw);
> 		spin_unlock_irq(q->queue_lock);
> 	} while (rq == NULL);
> 	return rq;
> }
> 
> If someone has taken *all* the requests and hasn't submitted any of them
> yet, there is nothing to unplug.   We go to sleep, all the requests are
> submitted (behind a plug) and it's game over.  Could happen if the device
> has a teeny queue...

I thought the queue spinlock would avoid that but I overlooked
get_request_wait itself against another get_request_wait, so yes that is
still an open problem, nevertheless my fix to get_request_queue to
unplug after being in the waitqueue and in uninterruptable mode is still
definitely needed and it fixes another bug that could deadlock
get_request_wait too (actually a more severe bug than this subtle one).

I will think more on how to fix get_request_wait against
get_request_wait. One simple fix of course is to never release the
spinlock between the get_request() and the add_request(). This is infact
what I thought would been always the case but I forgotten
get_request_wait against get_request_wait as said. In short to fix this
cleanly (without wakeups [or suprious unplugs if you prefer]) we should
never drop the q->queue_lock with the request not in the waitqueue and
not in the freelist.

> I dunno.  I bet there are still more holes, and I for one am heartily sick
> of unplug bugs.  Why not make the damn queue unplug itself after ten
> milliseconds or 16 requests?  I bet that would actually increase throughput,
> especially in the presence of kernel preemption and scheduling points.

This doesn't remove the need to avoid the mean 5 msec delay before the
queue unplug (I know the race triggers rarely though, but if we left all the
places broken the number of 5msec mean waits will increase bug by bug
over time). I'm not very excited by the idea (in particular for 2.4), if
it performs so much better I would say it's a broken length of the queue
that is way too oversized and that leads to other problems with fariness
of task against task etc... We need the big number of requests with
small requests only, with big requests we should allow only very few
requests to be returned.

In short I think my patch is correct and needed in both 2.4 and 2.5. I
will now think on how to fix best the get_request_wait against
get_request_wait that you noticed too and I will upload an incremental
fix for it. I would suggest to merge the current fixes in the meantime
(if the mainline maintainers prefers to change it and unplug instead of
waking up the waiter that's ok with me, conceptually I find cleaner to
wakeup the waiter but that's up to you)

Thanks for the help,

Andrea

PS. CC'ed Chris, he's certainly interested too given he found the
get_request_wait problem. Now that I think about it, I guess Chris
really meant the get_request_wait against get_request_wait that you
found too above, I probably just happened to notice the simpler more
severe bug  in such function and I thought Chris meant that simpler one
too, not exactly the same race as in lock_buffer/lock_page infact, and I
didn't imagine get_request_wait was really buggy in two different ways ;).

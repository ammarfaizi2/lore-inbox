Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbSKLIoH>; Tue, 12 Nov 2002 03:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266322AbSKLIoH>; Tue, 12 Nov 2002 03:44:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:9471 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265947AbSKLIoF>;
	Tue, 12 Nov 2002 03:44:05 -0500
Message-ID: <3DD0C0E6.4A8035A4@digeo.com>
Date: Tue, 12 Nov 2002 00:50:46 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.[45] fixes for design locking bug in 
 wait_on_page/wait_on_buffer/get_request_wait
References: <20021112035723.GA17642@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Nov 2002 08:50:46.0545 (UTC) FILETIME=[9788E010:01C28A28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> the race looks like this:
> 
>         CPU0                    CPU1
>         -----------------       ------------------------
>         reiserfs_writepage
>         lock_buffer()
>                                 fsync_buffers_list() under lock_super()
>                                 wait_on_buffer()
>                                 run_task_queue(&tq_disk) -> noop
>                                 schedule() <- hang with lock_super acquired
>         submit_bh()
>         /* don't unplug here */
> 

Or, more simply:

	lock_buffer()
				while (buffer_locked()) {
					blk_run_queues();	/* Nothing happens */
					if (buffer_locked(bh))
						schedule();
	submit_bh();	/* No unplug */


The fix seems reasonable to me.  It would perhaps be better to just do:

+       if (waitqueue_active(wqh))
+               blk_run_queues();

in submit_bh().  To save the context switch.


Moving the blk_run_queues() inside the TASK_UNINTERRUPTIBLE region
is something which always worried me, because if something down
there sets TASK_RUNNING, we end up in a busy wait.  But that's OK
for 2.5 and may be OK for 2.4's run_task_queue() - I haven't checked...

The multipage stuff in 2.5 does its own blk_run_queues() and looks to be
OK, which I assume is why you didn't touch that.

The little single-page reads like do_generic_mapping_read() look to be
OK because the process whcih waits is the one which submitted the IO.


wrt the get_request_wait changes: I never bothered about the barrier
because we know that there are tons of requests outstanding, and if
we don't do a wakeup the next guy will.  Plus *this* request has to
be put back sometime too, which will deliver a wakeup.  But whatever;
it's not exactly a fastpath.

However the function is still not watertight:

static struct request *get_request_wait(request_queue_t *q, int rw)
{
	DEFINE_WAIT(wait);
	struct request_list *rl = &q->rq[rw];
	struct request *rq;

	spin_lock_prefetch(q->queue_lock);

	generic_unplug_device(q);
	do {
		prepare_to_wait_exclusive(&rl->wait, &wait,
					TASK_UNINTERRUPTIBLE);
		if (!rl->count)
			io_schedule();
		finish_wait(&rl->wait, &wait);
		spin_lock_irq(q->queue_lock);
		rq = get_request(q, rw);
		spin_unlock_irq(q->queue_lock);
	} while (rq == NULL);
	return rq;
}

If someone has taken *all* the requests and hasn't submitted any of them
yet, there is nothing to unplug.   We go to sleep, all the requests are
submitted (behind a plug) and it's game over.  Could happen if the device
has a teeny queue...


I dunno.  I bet there are still more holes, and I for one am heartily sick
of unplug bugs.  Why not make the damn queue unplug itself after ten
milliseconds or 16 requests?  I bet that would actually increase throughput,
especially in the presence of kernel preemption and scheduling points.

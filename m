Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264989AbTFUGa0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 02:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbTFUGa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 02:30:26 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:46273 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264989AbTFUGaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 02:30:10 -0400
Date: Fri, 20 Jun 2003 23:44:22 -0700
From: Andrew Morton <akpm@digeo.com>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz, steve@chygwyn.com
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
Message-Id: <20030620234422.74533c65.akpm@digeo.com>
In-Reply-To: <3EF3F08B.5060305@aros.net>
References: <3EF3F08B.5060305@aros.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jun 2003 06:44:12.0357 (UTC) FILETIME=[86567F50:01C337C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lou Langholtz <ldl@aros.net> wrote:
>
> The following (attached) patch to the network block device driver (nbd)

is enormous.  It is a shame that the changes were not broken into separate
logical patches.


> - * 01-12-6 Fix deadlock condition by making queue locks independent of
> + * 01-12-6 Fix deadlock condition by making queue locks independant of

Actually "independent" is correct.

>   *   the transmit lock. <steve@chygwyn.com>
>   * 02-10-11 Allow hung xmit to be aborted via SIGKILL & various fixes.
>   *   <Paul.Clements@SteelEye.com> <James.Bottomley@SteelEye.com>
> + * 03-05-02 Ported thread patch by <steve@uk.sistina.com> which moves
> + *   network I/O into seperate kernel threads so request function no longer
> + *   blocks. <ldl@aros.net>
> + * 03-05-02 Switched to configurable debugging output. <ldl@aros.net>
> + * 03-05-19 Added connection establishment code and new IP:port managing ioctls
> + *   to support tool-less startup and simplified management. <ldl@aros.net>
> + * 03-05-19 Added module parameters to support insertion time configuration
> + *   of various aspects of this driver. <ldl@aros.net>
> + * 03-05-27 Added procfs support for greater runtime monitorability of driver.
> + *   <ldl@aros.net>
> + * 03-06-08 Added session management code to try reconnecting in case of
> + *   connection shutdown. <ldl@aros.net>
> + * 03-06-10 Fixed bug in network read logic that's been there from the
> + *   original 2.5 series nbd driver where data was being read into possibly
> + *   non-contiguous memory using bio_data() call (and caused kernel lockups).
> + * 03-06-12 Added a default BLOCKING stratedgy on network downtime with a
> + *   non-default NBD_NONBLOCKING flag. This has the net effect of blocking
> + *   I/O when there's only transient problems like a server reboot. If used
> + *   in conjunction now with RAID mirroring, transient errors (while they'll
> + *   pause the system) will not nessesitate a complete recopying of the
> + *   server's exported block device which could potentially take much longer
> + *   than a reboot.
> + * 03-06-13 Implemented NBD_WRITE_NOCHK. <ldl@aros.net>
> + * 03-06-15 Fixed code to report proper size even when using nbd-client.
> + *   <ldl@aros.net>
>   *

The above appears to be a good description of how you should have
structured the patch series.


> +#  define REQUEST_QUEUE(req) (&(req)->queuelist)
> +#  define REQUEST_QUEUE_NEXT_REQUEST(q) (elv_next_request(q))
> +#  define REQUEST_CMD(req) ((req)->cmd[0])
> +#  define DAEMONIZE(fmt...) daemonize(fmt)
> +#  define NBD_BYTESIZE(lo) ((lo)->bytesize)
> +#  define NBD_BLKSIZE(lo) ((lo)->blksize)
> +#  define INODE_TO_NBD(i) ((i)->i_bdev->bd_disk->private_data)

These guys should just be open-coded.  They do not add anything, and they
tend to obscure.

> +#  define request_queue_lock(q) spin_lock_irq((q)->queue_lock)
> +#  define request_queue_unlock(q) spin_unlock_irq((q)->queue_lock)
> +#  define request_queue_lock_save(q,flags) \
> +	spin_lock_irqsave((q)->queue_lock, (flags))
> +#  define request_queue_unlock_restore(q,flags) \
> +	spin_unlock_irqrestore((q)->queue_lock, (flags))

These should definitely be removed.

> +static nbd_device_t nbd_devs[MAX_NBD];
> +static struct request_queue nbd_queue[MAX_NBD];
> +static spinlock_t nbd_lock[MAX_NBD];
> +static uint32_t request_magic;
> +static uint32_t reply_magic;

u32 here?

> +static u64 requests_in;
> +static u64 requests_out;
> +static u64 qhandler_loops;
> +static u64 initial_bytesize = (u64)-512; /* formerly 0x7ffffc00<<10 (~2TB) */
>  


> -void nbd_send_req(struct nbd_device *lo, struct request *req)
> +static inline void wait_for_completion_interuptably(struct completion *x)

"interruptibly" is spelled better.  "interruptible" is more consistent with
other things.

Maybe this function should be in kernel/sched.c
	
> +static int wait_for_io_threads(nbd_device_t *lo)
> +{
> ...
> +	add_wait_queue(&lo->no_io_waiters, &wait);
> +	if (atomic_read(&lo->num_io_threads) > 0) {
> +		dprintk(NBD_DEBUG_SESSION, "nb%d: %s: going to sleep...\n",
> +			minor, __FUNCTION__);
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule();
> +		set_current_state(TASK_RUNNING);
> +		if (signal_pending(current))
> +			signaled = 1;
> +		dprintk(NBD_DEBUG_SESSION, "nb%d: %s: woken up (%s)\n",
> +			minor, __FUNCTION__, signaled? "signaled": "done");

This looks buggy.  If num_io_threads goes to zero before the
set_current_state() then the code will still sleep.  Making it

	if (atomic_read(&lo->num_io_threads) > 0)
		schedule();

will fix that.


> + * This function must be called with io_request_lock held & interupts disabled.

io_request_lock went away.

> + */
> +static void request_end_while_locked(struct request *req, int uptodate)
> +{
> +	if (!end_that_request_first(req, uptodate, req->nr_sectors)) {
> +		end_that_request_last(req);
> +	}
> +	requests_out++;
> +	if (current) {
> +		dprintk(NBD_DEBUG_BLKDEV, "%s[%d]: released request (%p).\n",
> +				current->comm, current->pid, req);
> +	}
> +	else {
> +		/* can current ever even be null??? */

No, it cannot.

> +	request_queue_lock_save(req->q, flags);
> +	request_end_while_locked(req, uptodate);
> +	request_queue_unlock_restore(req->q, flags);

See, this is hard to follow for a person who understand the block layer. 
If we see

	spin_lock_irqsave(&q->queue_lock, flags);

we say "ah-hah!".  As it is, we say "wtf?" :)


> -void nbd_clear_que(struct nbd_device *lo)
> +static int nbd_qsys_len(nbd_qsys_t *q)
>  {
> -	struct request *req;
> +	int len;
> +	spin_lock(&q->lock);
> +	len = q->len;
> +	spin_unlock(&q->lock);
> +	return len;
> +}

Locking like this is a sign that something is wrong.  The value of q->len
can change even before the caller of this function gets to use it.  So why
was the lock taken at all?  Apart from spinlock side-effects such as memory
barriers, the locking is a no-op.


> +	if (!req) {
> +		struct task_struct *tsk = current;
> +		DECLARE_WAITQUEUE(wait, tsk);
> +
> +		add_wait_queue(&q->waiters, &wait);
> +		for (;;) {
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			req = nbd_qsys_deq_head(q);
> +			if (req)
> +				break;
> +			if (signal_pending(current))
> +				break;
> +			schedule();
>  		}
> -	} while(req);
> +		set_current_state(TASK_RUNNING);
> +		remove_wait_queue(&q->waiters, &wait);
> +	}
> +	return req;

Yup, that's the way to do it.

> +#ifdef USE_ZEROCOPY

Can you tell us about this?  Why is it optional?  Does it work OK?  Any
restrictions or concerns about it?

> -static void __exit nbd_cleanup(void)
> +static void unblock_sigkill(void)
>  {
> -	int i;
> -	for (i = 0; i < MAX_NBD; i++) {
> -		del_gendisk(nbd_dev[i].disk);
> -		put_disk(nbd_dev[i].disk);
> +	int unblocked = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&current->sighand->siglock, flags);
> +	if (sigismember(&current->blocked, SIGKILL)) {
> +		sigdelsetmask(&current->blocked, sigmask(SIGKILL));
> +		recalc_sigpending();
> +		unblocked = 1;
>  	}
> -	devfs_remove("nbd");
> -	blk_cleanup_queue(&nbd_queue);
> -	unregister_blkdev(NBD_MAJOR, "nbd");
> +	spin_unlock_irqrestore(&current->sighand->siglock, flags);
> +	if (unblocked)
> +		dprintk(NBD_DEBUG_THREADS, "%s[%d]: SIGKILL unblocked.\n",
> +				current->comm, current->pid);
>  }

I believe it would be better to not attempt to control kernel threads with
signals in this manner.  This is not userspace - it is kernel, and we can
employ much simpler means of interprocess communications in-kernel.  See
how kjournald gets shut down, for instance.

Using signals is complex, bloaty and tends to go wrong.  It would be a nice
cleanup if you could get rid of all the signal stuff.

> -module_init(nbd_init);
> -module_exit(nbd_cleanup);
> +static int session_loop(void *data)
> +{
> +	nbd_device_t *lo = (nbd_device_t *)data;
> +	int rv = 0, seconds, ncleared;
> +#ifndef NDEBUG
> +	int minor = DEVICE_TO_MINOR(lo);
> +#endif /* NDEBUG */
> +
> +	__module_get(THIS_MODULE);
> +	DAEMONIZE("nb%d-sess", lo - nbd_devs);
> +	spin_lock(&lo->lock);
> +	lo->ss_thread.task = current;
> +	spin_unlock(&lo->lock);

This locking isn't needed is it?

> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(HZ * seconds);
> +		set_current_state(TASK_RUNNING);

schedule_timeout() will always return in state TASK_RUNNING.

> +static int rx_loop(void *data)
> +static int tx_loop(void *data)

What was the deadlock which necessitated the creation of these kernel
threads?


My eyes glazed over at this point.


It is good that you are caring for NBD.  It has always been a bit sick and
people seem to find it useful.  If you could have a think about the above
(especially the signal thing) and send me the result I shall beat on it a
bit.

Thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271790AbRH3VfR>; Thu, 30 Aug 2001 17:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271364AbRH3VfB>; Thu, 30 Aug 2001 17:35:01 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:39185 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S270165AbRH3Veu> convert rfc822-to-8bit; Thu, 30 Aug 2001 17:34:50 -0400
Date: Thu, 30 Aug 2001 23:32:15 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jonathan Lahr <lahr@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: io_request_lock/queue_lock patch
In-Reply-To: <20010830134930.F23680@us.ibm.com>
Message-ID: <20010830232228.C2120-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here are my welcome comments. :)

In my opinion, it would well be a miracle if your patch does not introduce
new race conditions, at least for drivers that still use the old scsi done
method.

  Gérard.

On Thu, 30 Aug 2001, Jonathan Lahr wrote:

> Included below is a snapshot of a patch I am developing to reduce
> io_request_lock contention in 2.4.
>
> This patch changes __make_request to take the device-specific queue_lock
> instead of io_request_lock and changes generic_unplug_device to take
> queue_lock in addition to io_request_lock to serialize access to the
> request queue.  Also, locking in various functions has been modified
> in accordance with this new scheme.
>
> I have done some testing of this with aic7xxx, qla2x00, and lpfc adapters.
>
> To apply it to 2.4.6 or 2.4.7, from linux/ "patch -p1 < iorlv0_247".
>
> Comments and suggestions are welcome and invited.
>
> Jonathan
>
> ----- patch -----
> diff -Naur linux.base/drivers/block/ll_rw_blk.c linux.mod/drivers/block/ll_rw_blk.c
> --- linux.base/drivers/block/ll_rw_blk.c	Thu Jul 19 20:51:23 2001
> +++ linux.mod/drivers/block/ll_rw_blk.c	Fri Aug 24 10:17:38 2001
> @@ -343,11 +343,13 @@
>  void generic_unplug_device(void *data)
>  {
>  	request_queue_t *q = (request_queue_t *) data;
> -	unsigned long flags;
> +	unsigned long flags[2];
>
> -	spin_lock_irqsave(&io_request_lock, flags);
> +	spin_lock_irqsave(&io_request_lock, flags[0]);
> +	spin_lock_irqsave(&q->queue_lock, flags[1]);
>  	__generic_unplug_device(q);
> -	spin_unlock_irqrestore(&io_request_lock, flags);
> +	spin_unlock_irqrestore(&q->queue_lock, flags[1]);
> +	spin_unlock_irqrestore(&io_request_lock, flags[0]);
>  }
>
>  static void blk_init_free_list(request_queue_t *q)
> @@ -470,9 +472,9 @@
>  	add_wait_queue_exclusive(&q->wait_for_request, &wait);
>  	for (;;) {
>  		__set_current_state(TASK_UNINTERRUPTIBLE);
> -		spin_lock_irq(&io_request_lock);
> +		spin_lock_irq(&q->queue_lock);
>  		rq = get_request(q, rw);
> -		spin_unlock_irq(&io_request_lock);
> +		spin_unlock_irq(&q->queue_lock);
>  		if (rq)
>  			break;
>  		generic_unplug_device(q);
> @@ -487,9 +489,9 @@
>  {
>  	register struct request *rq;
>
> -	spin_lock_irq(&io_request_lock);
> +	spin_lock_irq(&q->queue_lock);
>  	rq = get_request(q, rw);
> -	spin_unlock_irq(&io_request_lock);
> +	spin_unlock_irq(&q->queue_lock);
>  	if (rq)
>  		return rq;
>  	return __get_request_wait(q, rw);
> @@ -555,7 +557,7 @@
>  	drive_stat_acct(req->rq_dev, req->cmd, req->nr_sectors, 1);
>
>  	if (!q->plugged && q->head_active && insert_here == &q->queue_head) {
> -		spin_unlock_irq(&io_request_lock);
> +		spin_unlock_irq(&q->queue_lock);
>  		BUG();
>  	}
>
> @@ -727,7 +729,7 @@
>  	 * Now we acquire the request spinlock, we have to be mega careful
>  	 * not to schedule or do something nonatomic
>  	 */
> -	spin_lock_irq(&io_request_lock);
> +	spin_lock_irq(&q->queue_lock);
>
>  	insert_here = head->prev;
>  	if (list_empty(head)) {
> @@ -794,7 +796,7 @@
>  		req = freereq;
>  		freereq = NULL;
>  	} else if ((req = get_request(q, rw)) == NULL) {
> -		spin_unlock_irq(&io_request_lock);
> +		spin_unlock_irq(&q->queue_lock);
>  		if (rw_ahead)
>  			goto end_io;
>
> @@ -821,7 +823,7 @@
>  out:
>  	if (freereq)
>  		blkdev_release_request(freereq);
> -	spin_unlock_irq(&io_request_lock);
> +	spin_unlock_irq(&q->queue_lock);
>  	return 0;
>  end_io:
>  	bh->b_end_io(bh, test_bit(BH_Uptodate, &bh->b_state));
> diff -Naur linux.base/drivers/scsi/scsi.c linux.mod/drivers/scsi/scsi.c
> --- linux.base/drivers/scsi/scsi.c	Thu Jul 19 21:07:04 2001
> +++ linux.mod/drivers/scsi/scsi.c	Fri Aug 24 11:06:25 2001
> @@ -678,41 +678,33 @@
>  		 * passes a meaningful return value.
>  		 */
>  		if (host->hostt->use_new_eh_code) {
> -                        spin_lock_irqsave(&io_request_lock, flags);
>  			rtn = host->hostt->queuecommand(SCpnt, scsi_done);
> -                        spin_unlock_irqrestore(&io_request_lock, flags);
>  			if (rtn != 0) {
>  				scsi_delete_timer(SCpnt);
>  				scsi_mlqueue_insert(SCpnt, SCSI_MLQUEUE_HOST_BUSY);
>                                  SCSI_LOG_MLQUEUE(3, printk("queuecommand : request rejected\n"));
>  			}
>  		} else {
> -                        spin_lock_irqsave(&io_request_lock, flags);
>  			host->hostt->queuecommand(SCpnt, scsi_old_done);
> -                        spin_unlock_irqrestore(&io_request_lock, flags);
>  		}
>  	} else {
>  		int temp;
>
>  		SCSI_LOG_MLQUEUE(3, printk("command() :  routine at %p\n", host->hostt->command));
> -                spin_lock_irqsave(&io_request_lock, flags);
>  		temp = host->hostt->command(SCpnt);
>  		SCpnt->result = temp;
>  #ifdef DEBUG_DELAY
> -                spin_unlock_irqrestore(&io_request_lock, flags);
>  		clock = jiffies + 4 * HZ;
>  		while (time_before(jiffies, clock))
>  			barrier();
>  		printk("done(host = %d, result = %04x) : routine at %p\n",
>  		       host->host_no, temp, host->hostt->command);
> -                spin_lock_irqsave(&io_request_lock, flags);
>  #endif
>  		if (host->hostt->use_new_eh_code) {
>  			scsi_done(SCpnt);
>  		} else {
>  			scsi_old_done(SCpnt);
>  		}
> -                spin_unlock_irqrestore(&io_request_lock, flags);
>  	}
>  	SCSI_LOG_MLQUEUE(3, printk("leaving scsi_dispatch_cmnd()\n"));
>  	return rtn;
> diff -Naur linux.base/drivers/scsi/scsi_lib.c linux.mod/drivers/scsi/scsi_lib.c
> --- linux.base/drivers/scsi/scsi_lib.c	Thu Jul 19 20:48:04 2001
> +++ linux.mod/drivers/scsi/scsi_lib.c	Fri Aug 24 10:19:50 2001
> @@ -68,7 +68,7 @@
>  static void __scsi_insert_special(request_queue_t *q, struct request *rq,
>  				  void *data, int at_head)
>  {
> -	unsigned long flags;
> +	unsigned long flags[2];
>
>  	ASSERT_LOCK(&io_request_lock, 0);
>
> @@ -84,7 +84,8 @@
>  	 * head of the queue for things like a QUEUE_FULL message from a
>  	 * device, or a host that is unable to accept a particular command.
>  	 */
> -	spin_lock_irqsave(&io_request_lock, flags);
> +	spin_lock_irqsave(&io_request_lock, flags[0]);
> +	spin_lock_irqsave(&q->queue_lock, flags[1]);
>
>  	if (at_head)
>  		list_add(&rq->queue, &q->queue_head);
> @@ -92,7 +93,8 @@
>  		list_add_tail(&rq->queue, &q->queue_head);
>
>  	q->request_fn(q);
> -	spin_unlock_irqrestore(&io_request_lock, flags);
> +	spin_unlock_irqrestore(&q->queue_lock, flags[1]);
> +	spin_unlock_irqrestore(&io_request_lock, flags[0]);
>  }
>
>
> @@ -246,13 +248,14 @@
>  void scsi_queue_next_request(request_queue_t * q, Scsi_Cmnd * SCpnt)
>  {
>  	int all_clear;
> -	unsigned long flags;
> +	unsigned long flags[2];
>  	Scsi_Device *SDpnt;
>  	struct Scsi_Host *SHpnt;
>
>  	ASSERT_LOCK(&io_request_lock, 0);
>
> -	spin_lock_irqsave(&io_request_lock, flags);
> +	spin_lock_irqsave(&io_request_lock, flags[0]);
> +	spin_lock_irqsave(&q->queue_lock, flags[1]);
>  	if (SCpnt != NULL) {
>
>  		/*
> @@ -328,7 +331,8 @@
>  			SHpnt->some_device_starved = 0;
>  		}
>  	}
> -	spin_unlock_irqrestore(&io_request_lock, flags);
> +	spin_unlock_irqrestore(&q->queue_lock, flags[1]);
> +	spin_unlock_irqrestore(&io_request_lock, flags[0]);
>  }
>
>  /*
> @@ -821,6 +825,7 @@
>  	struct Scsi_Device_Template *STpnt;
>
>  	ASSERT_LOCK(&io_request_lock, 1);
> +	ASSERT_LOCK(&q->queue_lock, 1);
>
>  	SDpnt = (Scsi_Device *) q->queuedata;
>  	if (!SDpnt) {
> @@ -828,6 +833,7 @@
>  	}
>  	SHpnt = SDpnt->host;
>
> +
>  	/*
>  	 * To start with, we keep looping until the queue is empty, or until
>  	 * the host is no longer able to accept any more requests.
> @@ -839,7 +845,7 @@
>  		 * we need to check to see if the queue is plugged or not.
>  		 */
>  		if (SHpnt->in_recovery || q->plugged)
> -			return;
> +			break;
>
>  		/*
>  		 * If the device cannot accept another request, then quit.
> @@ -887,9 +893,11 @@
>  			 */
>  			SDpnt->was_reset = 0;
>  			if (SDpnt->removable && !in_interrupt()) {
> +				spin_unlock_irq(&q->queue_lock);
>  				spin_unlock_irq(&io_request_lock);
>  				scsi_ioctl(SDpnt, SCSI_IOCTL_DOORLOCK, 0);
>  				spin_lock_irq(&io_request_lock);
> +				spin_lock_irq(&q->queue_lock);
>  				continue;
>  			}
>  		}
> @@ -998,8 +1006,6 @@
>  		 * another.
>  		 */
>  		req = NULL;
> -		spin_unlock_irq(&io_request_lock);
> -
>  		if (SCpnt->request.cmd != SPECIAL) {
>  			/*
>  			 * This will do a couple of things:
> @@ -1028,7 +1034,6 @@
>  				{
>  					panic("Should not have leftover blocks\n");
>  				}
> -				spin_lock_irq(&io_request_lock);
>  				SHpnt->host_busy--;
>  				SDpnt->device_busy--;
>  				continue;
> @@ -1044,7 +1049,6 @@
>  				{
>  					panic("Should not have leftover blocks\n");
>  				}
> -				spin_lock_irq(&io_request_lock);
>  				SHpnt->host_busy--;
>  				SDpnt->device_busy--;
>  				continue;
> @@ -1065,7 +1069,6 @@
>  		 * Now we need to grab the lock again.  We are about to mess
>  		 * with the request queue and try to find another command.
>  		 */
> -		spin_lock_irq(&io_request_lock);
>  	}
>  }
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


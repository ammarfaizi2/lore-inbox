Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVCaLQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVCaLQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCaLQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:16:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18404 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261346AbVCaLOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:14:19 -0500
Date: Thu, 31 Mar 2005 12:14:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tejun Heo <htejun@gmail.com>
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 10/13] scsi: rewrite scsi_request_fn()
Message-ID: <20050331111416.GA14857@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <htejun@gmail.com>, James.Bottomley@steeleye.com,
	axboe@suse.de, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.ED6FDDE0@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331090647.ED6FDDE0@htj.dyndns.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the changes look good to me (although I haven't tested any of your patches
yet), but the code flow is rather confusing.  What do you think about
the not even compile version of scsi_request_fn() below that should be
functionally identical to yours:


static void scsi_request_fn(struct request_queue *q)
{
	struct scsi_device *sdev = q->queuedata;
	struct Scsi_Host *shost = sdev->host;
	struct scsi_cmnd *cmd;
	struct request *req;
	enum scsi_device_state state;
	int ret = 0;

	/*
	 * FIXME: Once fire & forgetters are fixed, this and the
	 * unlock_irq/put_device/lock_irq dance at the end of this
	 * function can go away.
	 */
	get_device(&sdev->sdev_gendev);

	while ((req = elv_next_request(q))) {
		int is_special = (req->flags & REQ_SPECIAL), kill = 0;

		cmd = req->special;
		state = cmd->device->sdev_state;

		if (state == SDEV_BLOCK ||
		    (state == SDEV_QUIESCE && !is_special))
			goto out;
		else if (state == SDEV_OFFLINE || state == SDEV_DEL ||
			 (state == SDEV_CANCLE && !is_special)) {
			printk(KERN_ERR "scsi%d (%d:%d): "
					"rejecting I/O to %s\n",
					(state == SDEV_OFFLINE) ?
						"offline device" :
					 ((state == SDEV_DEL) ?
					  	"dead device" :
						"device being removed"));
			kill = 1;
		} else if (!scsi_dev_queue_ready(q, sdev))
			goto out;

		/* Start tag / remove from the request queue. */
		if (blk_queue_tagged(q)) {
			if (unlikely(blk_queue_start_tag(q, req)))
				BUG();
			cmd->tag = req->tag;
		} else
			blkdev_dequeue_request(req);

		sdev->device_busy++;

		/* Switch to host_lock. */
		spin_unlock(q->queue_lock);
		scsi_wait_reset(shost);
		spin_lock(shost->host_lock);

		if (kill || test_bit(SHOST_CANCEL, &shost->shost_state)) {
			SCSI_LOG_MLQUEUE(3,
				printk("%s: rejecting request\n", __FUNCTION__));
			shost->host_busy++;
			atomic_inc(&sdev->iorequest_cnt);
			cmd->result = DID_NO_CONNECT << 16;
			__scsi_done(cmd);
			goto relock;
		}
	
		if (!scsi_host_queue_ready(q, shost, sdev))
			goto requeue_out;

		if (sdev->single_lun) {
			struct scsi_target *target = scsi_target(sdev);
			if (target->starget_sdev_user &&
			    target->starget_sdev_user != sdev)
				goto requeue_out;
			target->starget_sdev_user = sdev;
		}

		shost->host_busy++;

		scsi_log_send(cmd);
		scsi_cmd_get_serial(shost, cmd);
		scsi_add_timer(cmd, cmd->timeout_per_command, scsi_times_out);

		cmd->state = SCSI_STATE_QUEUED;
		cmd->owner = SCSI_OWNER_LOWLEVEL;

		ret = shost->hostt->queuecommand(cmd, scsi_done);
		if (ret) {
			SCSI_LOG_MLQUEUE(3,
			    printk("%s: queuecommand deferred request (%d)\n",
				    __FUNCTION__, ret));

			/*
			 * Timer should be deleted while holding
			 * the host_lock.  Once it gets released, we
			 * don't know if cmd is still there or not.
			 */
			if (scsi_delete_timer(cmd)) {
				shost->host_busy--;
				goto block_requeue_out;
			}

			spin_unlock_irq(shost->host_lock);
			goto out_locked;
		}

		atomic_inc(&sdev->iorequest_cnt);

 relock:
		/* Switch back to queue_lock. */
		spin_unlock(shost->host_lock);
		spin_lock(q->queue_lock);

		/* The queue could have been plugged underneath us. */
		if (blk_queue_plugged(q))
			goto out;
	}

	goto out;

 block_requeue_out:
	if (ret == SCSI_MLQUEUE_DEVICE_BUSY)
		sdev->device_blocked = sdev->max_device_blocked;
	else
		shost->host_blocked = shost->max_host_blocked;
 requeue_out:
	/* Switch back to queue_lock */
	spin_unlock(shost->host_lock);
	spin_lock(q->queue_lock);

	cmd->state = SCSI_STATE_MLQUEUE;
	cmd->owner = SCSI_OWNER_MIDLEVEL;

	SCSI_LOG_MLQUEUE(3,
		printk("%s: requeueing request\n", __FUNCTION__));

	req->flags |= REQ_SOFTBARRIER;  /* Don't pass this request. */
	blk_requeue_request(q, req);
	if (--sdev->device_busy == 0)
		blk_plug_device(q);
 out:
	/*
	 * Must be careful here.  If we trigger the ->remove() function
	 * we cannot be holding the q lock
	 */
	spin_unlock_irq(q->queue_lock);
 out_locked:
	put_device(&sdev->sdev_gendev);
	spin_lock_irq(q->queue_lock);
}

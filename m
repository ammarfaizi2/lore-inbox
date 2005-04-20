Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVDTXYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVDTXYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 19:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVDTXYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 19:24:24 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:63399 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261838AbVDTXYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 19:24:18 -0400
Subject: Re: [PATCH scsi-misc-2.6 03/05] scsi: make scsi_queue_insert() use
	blk_requeue_request()
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050419231435.329FA30B@htj.dyndns.org>
References: <20050419231435.D85F89C0@htj.dyndns.org>
	 <20050419231435.329FA30B@htj.dyndns.org>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 19:24:06 -0400
Message-Id: <1114039446.5933.17.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 08:15 +0900, Tejun Heo wrote:
> -	 * Insert this command at the head of the queue for it's device.
> -	 * It will go before all other commands that are already in the queue.
> -	 *
> -	 * NOTE: there is magic here about the way the queue is plugged if
> -	 * we have no outstanding commands.
> -	 * 
> -	 * Although this *doesn't* plug the queue, it does call the request
> -	 * function.  The SCSI request function detects the blocked condition
> -	 * and plugs the queue appropriately.

This comment still looks appropriate to me ... why do you want to remove
it?

> +	 * Requeue the command.
>  	 */
> -	blk_insert_request(device->request_queue, cmd->request, 1, cmd, 1);
> +	spin_lock_irqsave(q->queue_lock, flags);
> +	blk_requeue_request(q, cmd->request);
> +	spin_unlock_irqrestore(q->queue_lock, flags);
> +
> +	scsi_run_queue(q);

Really, wouldn't it be much more efficient simply to call blk_run_queue
()? since the blocked flags were set above, that's pretty much what
scsi_run_queue() collapses to.

James



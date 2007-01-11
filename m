Return-Path: <linux-kernel-owner+w=401wt.eu-S1030232AbXAKIdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbXAKIdv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbXAKIdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:33:50 -0500
Received: from brick.kernel.dk ([62.242.22.158]:20385 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030227AbXAKIdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:33:49 -0500
Date: Thu, 11 Jan 2007 09:34:31 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       dm-devel@redhat.com, j-nomura@ce.jp.nec.com
Subject: Re: [RFC PATCH 3/3] blk_end_request: caller change
Message-ID: <20070111083430.GD11203@kernel.dk>
References: <20070110.180859.78702215.k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070110.180859.78702215.k-ueda@ct.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10 2007, Kiyoshi Ueda wrote:
> +static int end_request_callback(void *arg)
> +{
> +	struct request *req = (struct request *)arg;
> +
> +	add_disk_randomness(req->rq_disk);
> +	blkdev_dequeue_request(req);
> +
> +	return 0;
> +}

This is bad, don't pass void * around.

> +static int cdrom_newpc_intr_dma_callback(void *arg)
> +{
> +	void **argv = (void **)arg;
> +	struct request *rq = (struct request *)*argv++;
> +	ide_drive_t *drive = (ide_drive_t *)argv++;
> +	spinlock_t *ide_lock = (spinlock_t *)argv;
> +
> +	rq->data_len = 0;
> +
> +	cdrom_newpc_intr_callback_common(rq, drive, ide_lock);
> +
> +	return 0;
> +}

And this is why, down right horrible. The callback should be correctly
typed, pass down a request pointer ALWAYS.

-- 
Jens Axboe


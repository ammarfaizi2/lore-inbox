Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269030AbUIQWSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbUIQWSm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269065AbUIQWPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:15:50 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:7092 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269034AbUIQWOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:14:46 -0400
Message-ID: <414AB8D2.2080905@us.ibm.com>
Date: Fri, 17 Sep 2004 03:13:38 -0700
From: Mike Christie <mikenc@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, wa@almesberger.net
Subject: Re: [PATCH] modular io schedulers with online switching, #2
References: <20040917094436.GB2911@suse.de>
In-Reply-To: <20040917094436.GB2911@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote
> +void blk_wait_queue_drained(request_queue_t *q)
> +{
> +	struct request_list *rl = &q->rq;
> +	DEFINE_WAIT(wait);
> +
> +	set_bit(QUEUE_FLAG_DRAIN, &q->queue_flags);
> +
> +	prepare_to_wait(&rl->drain, &wait, TASK_UNINTERRUPTIBLE);
> +	do {
> +		spin_lock_irq(q->queue_lock);
> +		if (!rl->count[READ] && !rl->count[WRITE]) {
> +			spin_unlock_irq(q->queue_lock);
> +			break;
> +		}
> +
> +		__generic_unplug_device(q);
> +		spin_unlock_irq(q->queue_lock);
> +		io_schedule();
> +	} while (1);
> +	finish_wait(&rl->drain, &wait);
> +}
> +

Jens,

If a driver does not allocate requests through blk_get_request, will the 
rl->count[] tests need to be changed or do those drivers need to be 
changed? For example, if SCSI insterts a special request into the queue, 
then someone swaps the io scheduler with no outstanding normal requests 
(so the rl->counts will be zero), could the special request still be in 
the queue since it allocated its request using kmalloc (the request is 
allocated as part of the scsi command).

Mike

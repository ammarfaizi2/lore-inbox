Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269162AbUIRIaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269162AbUIRIaD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 04:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269164AbUIRIaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 04:30:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29827 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269162AbUIRI36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 04:29:58 -0400
Date: Sat, 18 Sep 2004 10:29:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Mike Christie <mikenc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, wa@almesberger.net
Subject: Re: [PATCH] modular io schedulers with online switching, #2
Message-ID: <20040918082944.GA1195@suse.de>
References: <20040917094436.GB2911@suse.de> <414AB8D2.2080905@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414AB8D2.2080905@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17 2004, Mike Christie wrote:
> Jens Axboe wrote
> >+void blk_wait_queue_drained(request_queue_t *q)
> >+{
> >+	struct request_list *rl = &q->rq;
> >+	DEFINE_WAIT(wait);
> >+
> >+	set_bit(QUEUE_FLAG_DRAIN, &q->queue_flags);
> >+
> >+	prepare_to_wait(&rl->drain, &wait, TASK_UNINTERRUPTIBLE);
> >+	do {
> >+		spin_lock_irq(q->queue_lock);
> >+		if (!rl->count[READ] && !rl->count[WRITE]) {
> >+			spin_unlock_irq(q->queue_lock);
> >+			break;
> >+		}
> >+
> >+		__generic_unplug_device(q);
> >+		spin_unlock_irq(q->queue_lock);
> >+		io_schedule();
> >+	} while (1);
> >+	finish_wait(&rl->drain, &wait);
> >+}
> >+
> 
> Jens,
> 
> If a driver does not allocate requests through blk_get_request, will the 
> rl->count[] tests need to be changed or do those drivers need to be 
> changed? For example, if SCSI insterts a special request into the queue, 
> then someone swaps the io scheduler with no outstanding normal requests 
> (so the rl->counts will be zero), could the special request still be in 
> the queue since it allocated its request using kmalloc (the request is 
> allocated as part of the scsi command).

Yes, we need to eliminate stack and kmalloc'ed requests for this to be
completely solid. This is something we have been doing for some time
already, now would be a good time to fully complete it.

There's no way to block incoming request at ->add_request_fn() time, so
we have to do it on merge (first path) or request allocation.

-- 
Jens Axboe


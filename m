Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316843AbSFKFuk>; Tue, 11 Jun 2002 01:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316837AbSFKFuj>; Tue, 11 Jun 2002 01:50:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2199 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316838AbSFKFuh>;
	Tue, 11 Jun 2002 01:50:37 -0400
Date: Tue, 11 Jun 2002 07:50:14 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Proposed changes to generic blk tag for use in SCSI (1/3)
Message-ID: <20020611055014.GA1117@suse.de>
In-Reply-To: <200206110246.g5B2kia06902@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10 2002, James Bottomley wrote:
> The attached is what I needed in the generic block layer to get the SCSI 
> subsystem using it for Tag Command Queueing.
> 
> The changes are basically
> 
> 1) I need a function to find the tagged request given the queue and the tag, 
> which I've added as a function in the block layer

Ehm it's already there, one could argue that it's pretty core
functionality for this type of stuff :-). It's called
blk_queue_get_tag(q, tag), and it's in blkdev.h. However, I agree that
we should just move it into ll_rw_blk.c. That gets better documented as
well. Could you redo that part?

> 2) The SCSI queue will stall if it gets an untagged request in the stream, so 
> once tagged queueing is enabled, all commands (including SPECIALS) must be 
> tagged.  I altered the check in blk_queue_start_tag to permit this.

I completely agree with this, blk_queue_start_tag() should not need to
know about these things so just checking if the request is already
marked tagged is fine with me. But please make that a warning, like

	if (rq->flags & REQ_QUEUED) {
		printk("blk_queue_start_tag: rq already tagged\n");
		return 1;
	}

Also, you need to fix drivers/ide/tcq.c to make sure it doesn't call
blk_queue_start_tag() for non REQ_CMD requests. Ah wait, I'll just
change that. And also _please_ fix the comment about REQ_CMD and not
just the code, it's doesn't stand anymore.

> This is part of a set of three patches which provide a sample implementation 
> of a SCSI driver using the generic TCQ code.

Cool! Looking forward to reviewing it later today.

-- 
Jens Axboe


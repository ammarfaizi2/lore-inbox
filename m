Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291272AbSAaUaL>; Thu, 31 Jan 2002 15:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291275AbSAaU37>; Thu, 31 Jan 2002 15:29:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30222 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291272AbSAaU3f>;
	Thu, 31 Jan 2002 15:29:35 -0500
Date: Thu, 31 Jan 2002 21:29:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Roger Larsson <roger.larsson@norran.net>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: Errors in the VM - detailed
Message-ID: <20020131212909.T5301@suse.de>
In-Reply-To: <Pine.LNX.4.30.0201311604470.14025-100000@mustard.heime.net> <200201312024.g0VKORD19223@mailf.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201312024.g0VKORD19223@mailf.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31 2002, Roger Larsson wrote:
> Wait a minute - it might be readahead that gets killed.
> If I remember correctly READA requests are dropped when failing to allocate 
> space for it - yes I did...

s/allocate/retrieve

No allocation takes place.

> /usr/src/develop/linux/drivers/block/ll_rw_block.c:746 (earlier kernel)
> 
> 	/*
> 	 * Grab a free request from the freelist - if that is empty, check
> 	 * if we are doing read ahead and abort instead of blocking for
> 	 * a free slot.
> 	 */
> get_rq:
> 	if (freereq) {
> 		req = freereq;
> 		freereq = NULL;
> 	} else if ((req = get_request(q, rw)) == NULL) {
> 		spin_unlock_irq(&io_request_lock);
> 		if (rw_ahead)
> 			goto end_io;
> 
> 		freereq = __get_request_wait(q, rw);
> 		goto again;
> 	}
> 
> Suppose we fail with get_request, the request is a rw_ahead,
> it quits... => no read ahead.
> 
> Try to add a prink there...
> 		if (rw_ahead) {
> 			printk("Skipping readahead...\n");
> 			goto end_io;
> 		}

That will trigger _all the time_ even on a moderately busy machine.
Checking if tossing away read-ahead is the issue is probably better
tested with just increasing the request slots. Roy, please try and change
the queue_nr_requests assignment in ll_rw_blk:blk_dev_init() to
something like 2048.

-- 
Jens Axboe


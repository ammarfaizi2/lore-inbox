Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTLOTTP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 14:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTLOTTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 14:19:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59070 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263571AbTLOTTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 14:19:13 -0500
Date: Mon, 15 Dec 2003 20:13:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Toad <toad@amphibian.dyndns.org>, linux-kernel@vger.kernel.org
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11, reading an apparently duff DVD-R
Message-ID: <20031215191335.GG2267@suse.de>
References: <20031215135802.GA4332@amphibian.dyndns.org> <Pine.LNX.4.58.0312151043480.1631@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312151043480.1631@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15 2003, Linus Torvalds wrote:
> 
> 
> On Mon, 15 Dec 2003, Toad wrote:
> >
> > ide-scsi: reset called for 133
> 
> Ok, I can't trigger an IDE reset even with a bad CDROM, so I'm kind of out
> of luck on testing this. Can you try out the following silly patch, and
> report what it says?
> 
> The old ide-scsi reset function is just terminally broken, there's no way
> it can work. This patch _might_ make it work, but is more likely to just
> print out what it's trying to do.

abort doesn't work well either, and ide-scsi needs to be ported to do
proper new error handling. It's internal buffering stinks. In short, it
really needs to be almost rewritten if it is serve some useful purpose.
If it wasn't for the principle of it, it really should not be a big job.

> -	printk (KERN_ERR "ide-scsi: reset called for %lu\n", cmd->serial_number);
> -	/* first null the handler for the drive and let any process
> -	 * doing IO (on another CPU) run to (partial) completion
> -	 * the lock prevents processing new requests */
> -	spin_lock_irqsave(&ide_lock, flags);
> -	while (HWGROUP(drive)->handler) {
> -		HWGROUP(drive)->handler = NULL;
> -		schedule_timeout(1);
> -	}

It's incredible how anything like that ever got merged, looks like it
was introduced with scsi_sleep() change.

> -	/* now nuke the drive queue */
> -	while ((req = elv_next_request(drive->queue))) {
> -		blkdev_dequeue_request(req);
> -		end_that_request_last(req);

Broken, will introduced infinite stalls.

> -	}
> -	/* FIXME - this will probably leak memory */
> -	HWGROUP(drive)->rq = NULL;
> -	if (drive_to_idescsi(drive))
> -		drive_to_idescsi(drive)->pc = NULL;
> -	spin_unlock_irqrestore(&ide_lock, flags);
> -	/* finally, reset the drive (and its partner on the bus...) */
> -	ide_do_reset (drive);

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTEMSGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTEMSEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:04:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34214 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263396AbTEMSC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:02:58 -0400
Date: Tue, 13 May 2003 20:11:55 +0200
From: Jens Axboe <axboe@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: bharata@in.ibm.com, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: 2.5.69-mjb1: undefined reference to `blk_queue_empty'
Message-ID: <20030513181155.GL17033@suse.de>
References: <9380000.1052624649@[10.10.2.4]> <20030512205139.GT1107@fs.tum.de> <20570000.1052797864@[10.10.2.4]> <20030513124807.A31823@in.ibm.com> <25840000.1052834304@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25840000.1052834304@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13 2003, Martin J. Bligh wrote:
> > I have already sent you a fix for this. Anyway here it is again.
> 
> Oops, I must have dropped it - thanks, I'll stick it in the next release.
>  
> > --- linux-2.5.69/drivers/dump/dump_blockdev.c.orig	Tue May 13 12:30:49 2003
> > +++ linux-2.5.69/drivers/dump/dump_blockdev.c	Tue May 13 12:34:09 2003
> > @@ -261,7 +261,7 @@
> >  
> >  	/* For now we assume we have the device to ourselves */
> >  	/* Just a quick sanity check */
> > -	if (!blk_queue_empty(bdev_get_queue(dump_bdev->bdev))) {
> > +	if (elv_next_request(bdev_get_queue(dump_bdev->bdev))) {
> >  		/* i/o in flight - safer to quit */
> >  		return -EBUSY;
> >  	}

this looks horribly racy (of the io scheduler internals corrupting
kind), I don't see you holding the queue lock here. some io schedulers
do non-significant amount of work inside they next_request functions,
moving from back-end lists to dispatch queue.

-- 
Jens Axboe


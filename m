Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265985AbUGEK0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbUGEK0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 06:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265987AbUGEK0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 06:26:22 -0400
Received: from [213.146.154.40] ([213.146.154.40]:28378 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265985AbUGEK0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 06:26:20 -0400
Date: Mon, 5 Jul 2004 11:26:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Message-ID: <20040705102619.GA15033@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
References: <m2lli36ec9.fsf@telia.com> <20040704130544.GA3825@infradead.org> <m2llhz5o4o.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2llhz5o4o.fsf@telia.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 01:49:43AM +0200, Peter Osterlund wrote:
> For fsync_bdev(), which you say is not needed anyway. Also for the
> invalidate_bdev() call in pkt_remove_dev(). The loop driver is also
> calling invalidate_bdev() in its loop_clr_fd() function, so I guess
> that call is needed.

Only as long as it's reusing the same gendisk for different devices,
more on that below.

> > > +	for (i = 0; i < MAX_WRITERS; i++) {
> > > +		struct pktcdvd_device *pd = &pkt_devs[i];
> > > +		struct gendisk *disk = disks[i];
> > > +		disk->major = PACKET_MAJOR;
> > > +		disk->first_minor = i;
> > > +		disk->fops = &pktcdvd_ops;
> > > +		disk->flags = GENHD_FL_REMOVABLE;
> > > +		sprintf(disk->disk_name, "pktcdvd%d", i);
> > > +		sprintf(disk->devfs_name, "pktcdvd/%d", i);
> > > +		disk->private_data = pd;
> > > +		disk->queue = blk_alloc_queue(GFP_KERNEL);
> > > +		if (!disk->queue)
> > > +			goto out_mem3;
> > > +		add_disk(disk);
> > > +	}
> > 
> > Please allocate all these on demand only when you actually attach
> > a device.
> 
> But I need to open the device to be able to perform the ioctl to
> attach a device, and I can't open the device until add_disk() has been
> called. The loop device does the same thing.

And loops is broken the same way ;-)  This I need an blockdevice to actually
attach it scheme breaks in many ways, like the need to reset a gendisk
instead of allocating a new one, lots of warts in ->open and problems with
udev.  Just keep a single character device around for all administrative
work (like device mapper) - otoh if packet writing really moves to the
block layer all this is magically fixed..


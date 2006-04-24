Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWDXO4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWDXO4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWDXO4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:56:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24518 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750816AbWDXO4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:56:48 -0400
Date: Tue, 25 Apr 2006 00:56:35 +1000
From: David Chinner <dgc@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Direct I/O bio size regression
Message-ID: <20060424145635.GH611485@melbourne.sgi.com>
References: <20060424061403.GF611708@melbourne.sgi.com> <20060424070236.GD22614@suse.de> <20060424090508.GI22614@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424090508.GI22614@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 11:05:08AM +0200, Jens Axboe wrote:
> On Mon, Apr 24 2006, Jens Axboe wrote:
> > > Index: 2.6.x-xfs-new/fs/bio.c
> > > ===================================================================
> > > --- 2.6.x-xfs-new.orig/fs/bio.c	2006-02-06 11:57:50.000000000 +1100
> > > +++ 2.6.x-xfs-new/fs/bio.c	2006-04-24 15:46:16.849484424 +1000
> > > @@ -304,7 +304,7 @@ int bio_get_nr_vecs(struct block_device 
> > >  	request_queue_t *q = bdev_get_queue(bdev);
> > >  	int nr_pages;
> > >  
> > > -	nr_pages = ((q->max_sectors << 9) + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > > +	nr_pages = ((q->max_hw_sectors << 9) + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > >  	if (nr_pages > q->max_phys_segments)
> > >  		nr_pages = q->max_phys_segments;
> > >  	if (nr_pages > q->max_hw_segments)
> > > @@ -446,7 +446,7 @@ int bio_add_page(struct bio *bio, struct
> > >  		 unsigned int offset)
> > >  {
> > >  	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> > > -	return __bio_add_page(q, bio, page, len, offset, q->max_sectors);
> > > +	return __bio_add_page(q, bio, page, len, offset, q->max_hw_sectors);
> > >  }
> > >  
> > >  struct bio_map_data {
> > 
> > Clearly correct, I'll make sure this gets merged right away.
> 
> Spoke too soon... The last part is actually on purpose, to prevent
> really huge requests as part of normal file system IO.

I don't understand why this was considered necessary. It
doesn't appear to be explained in any of the code so can you
explain the problem that large filesystem I/Os pose to the block
layer? We _need_ to be able to drive really huge requests from the
filesystem down to the disks, especially for direct I/O.....

FWIW, we've just got XFS to the point where we could issue large
I/Os (up to 8MB on 16k pages) with a default configuration kernel
and filesystem using md+dm on an Altix. That makes an artificial
512KB filesystem I/O size limit a pretty major step backwards in
terms of performance for default configs.....

> That's why we
> have a bio_add_pc_page(). The first hunk may cause things to not work
> optimally then if we don't apply the last hunk.

bio_add_pc_page() requires a request queue to be passed to it.  It's
called only from scsi layers in the context of mapping pages into a
bio from sg_io(). The comment for bio_add_pc_page() says for use
with REQ_PC queues only, and that appears to only be used by ide-cd
cdroms. Is that comment correct?

Also, it seems to me that using bio_add_pc_page() in a filesystem
or in the generic direct i/o code seems like a gross layering
violation to me because they are supposed to know nothing about
request queues.

> The best approach is probably to tune max_sectors on the system itself.
> That's why it is exposed, after all.

You mean /sys/block/sd*/max_sector_kb?

Cheers,

Dave.

-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group

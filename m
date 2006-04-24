Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWDXSqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWDXSqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 14:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWDXSqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 14:46:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15370 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751124AbWDXSqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 14:46:52 -0400
Date: Mon, 24 Apr 2006 20:47:30 +0200
From: Jens Axboe <axboe@suse.de>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Direct I/O bio size regression
Message-ID: <20060424184730.GH29724@suse.de>
References: <20060424061403.GF611708@melbourne.sgi.com> <20060424070236.GD22614@suse.de> <20060424090508.GI22614@suse.de> <20060424145635.GH611485@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424145635.GH611485@melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25 2006, David Chinner wrote:
> On Mon, Apr 24, 2006 at 11:05:08AM +0200, Jens Axboe wrote:
> > On Mon, Apr 24 2006, Jens Axboe wrote:
> > > > Index: 2.6.x-xfs-new/fs/bio.c
> > > > ===================================================================
> > > > --- 2.6.x-xfs-new.orig/fs/bio.c	2006-02-06 11:57:50.000000000 +1100
> > > > +++ 2.6.x-xfs-new/fs/bio.c	2006-04-24 15:46:16.849484424 +1000
> > > > @@ -304,7 +304,7 @@ int bio_get_nr_vecs(struct block_device 
> > > >  	request_queue_t *q = bdev_get_queue(bdev);
> > > >  	int nr_pages;
> > > >  
> > > > -	nr_pages = ((q->max_sectors << 9) + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > > > +	nr_pages = ((q->max_hw_sectors << 9) + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > > >  	if (nr_pages > q->max_phys_segments)
> > > >  		nr_pages = q->max_phys_segments;
> > > >  	if (nr_pages > q->max_hw_segments)
> > > > @@ -446,7 +446,7 @@ int bio_add_page(struct bio *bio, struct
> > > >  		 unsigned int offset)
> > > >  {
> > > >  	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> > > > -	return __bio_add_page(q, bio, page, len, offset, q->max_sectors);
> > > > +	return __bio_add_page(q, bio, page, len, offset, q->max_hw_sectors);
> > > >  }
> > > >  
> > > >  struct bio_map_data {
> > > 
> > > Clearly correct, I'll make sure this gets merged right away.
> > 
> > Spoke too soon... The last part is actually on purpose, to prevent
> > really huge requests as part of normal file system IO.
> 
> I don't understand why this was considered necessary. It
> doesn't appear to be explained in any of the code so can you
> explain the problem that large filesystem I/Os pose to the block
> layer? We _need_ to be able to drive really huge requests from the
> filesystem down to the disks, especially for direct I/O.....
> 
> FWIW, we've just got XFS to the point where we could issue large
> I/Os (up to 8MB on 16k pages) with a default configuration kernel
> and filesystem using md+dm on an Altix. That makes an artificial
> 512KB filesystem I/O size limit a pretty major step backwards in
> terms of performance for default configs.....

The change was needed to safely split max_sectors into two sane parts:

- The soft value, ->max_sectors, that holds a sane default of maximum io
  size. The main issue we want to prevent is filling the queue with huge
  amounts of io, both from a pinning POV but also from user latency
  reasons.

- The hard value, ->max_hw_sectors. Previously, there was no real clear
  definition of what ->max_sectors was supposed to do. We couldn't
  increase it to fit the hardware limits of most hardware, because that
  would hurt us latency/memory wise.

> > That's why we
> > have a bio_add_pc_page(). The first hunk may cause things to not work
> > optimally then if we don't apply the last hunk.
> 
> bio_add_pc_page() requires a request queue to be passed to it.  It's
> called only from scsi layers in the context of mapping pages into a
> bio from sg_io(). The comment for bio_add_pc_page() says for use
> with REQ_PC queues only, and that appears to only be used by ide-cd
> cdroms. Is that comment correct?

It's used for any SG_IO path, so that is not at all restricted to
ide-cd. It covers all block devices.

> Also, it seems to me that using bio_add_pc_page() in a filesystem
> or in the generic direct i/o code seems like a gross layering
> violation to me because they are supposed to know nothing about
> request queues.

I'm not suggesting you do that at all. You should not have to change
your file system. See below.

> > The best approach is probably to tune max_sectors on the system itself.
> > That's why it is exposed, after all.
> 
> You mean /sys/block/sd*/max_sector_kb?

Exactly. Your max_hw_sectors_kb should already be correct, if not then
that is a driver issue that needs to be fixed. And that's not a new
issue, it was always so. You can then increase max_sectors_kb to any
value as long as it's less than max_hw_sectors_kb, and your filesystem
will happily build you ios as large as you need (equiv to what your
patch would have accomplished).

-- 
Jens Axboe


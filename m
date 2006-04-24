Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWDXJEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWDXJEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 05:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWDXJEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 05:04:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21592 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932094AbWDXJEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 05:04:30 -0400
Date: Mon, 24 Apr 2006 11:05:08 +0200
From: Jens Axboe <axboe@suse.de>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Direct I/O bio size regression
Message-ID: <20060424090508.GI22614@suse.de>
References: <20060424061403.GF611708@melbourne.sgi.com> <20060424070236.GD22614@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424070236.GD22614@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24 2006, Jens Axboe wrote:
> > Index: 2.6.x-xfs-new/fs/bio.c
> > ===================================================================
> > --- 2.6.x-xfs-new.orig/fs/bio.c	2006-02-06 11:57:50.000000000 +1100
> > +++ 2.6.x-xfs-new/fs/bio.c	2006-04-24 15:46:16.849484424 +1000
> > @@ -304,7 +304,7 @@ int bio_get_nr_vecs(struct block_device 
> >  	request_queue_t *q = bdev_get_queue(bdev);
> >  	int nr_pages;
> >  
> > -	nr_pages = ((q->max_sectors << 9) + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +	nr_pages = ((q->max_hw_sectors << 9) + PAGE_SIZE - 1) >> PAGE_SHIFT;
> >  	if (nr_pages > q->max_phys_segments)
> >  		nr_pages = q->max_phys_segments;
> >  	if (nr_pages > q->max_hw_segments)
> > @@ -446,7 +446,7 @@ int bio_add_page(struct bio *bio, struct
> >  		 unsigned int offset)
> >  {
> >  	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> > -	return __bio_add_page(q, bio, page, len, offset, q->max_sectors);
> > +	return __bio_add_page(q, bio, page, len, offset, q->max_hw_sectors);
> >  }
> >  
> >  struct bio_map_data {
> 
> Clearly correct, I'll make sure this gets merged right away.

Spoke too soon... The last part is actually on purpose, to prevent
really huge requests as part of normal file system IO. That's why we
have a bio_add_pc_page(). The first hunk may cause things to not work
optimally then if we don't apply the last hunk.

The best approach is probably to tune max_sectors on the system itself.
That's why it is exposed, after all.

-- 
Jens Axboe


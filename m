Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUCNUln (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 15:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUCNUln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 15:41:43 -0500
Received: from ns.suse.de ([195.135.220.2]:64444 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261567AbUCNUlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 15:41:40 -0500
Subject: Re: [PATCH] per-backing dev unplugging #2
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
In-Reply-To: <20040312205104.GE16880@suse.de>
References: <20040311083619.GH6955@suse.de>
	 <1079121113.4181.189.camel@watt.suse.com>
	 <20040312120322.0108a437.akpm@osdl.org> <20040312200253.GA16880@suse.de>
	 <1079123647.4186.211.camel@watt.suse.com> <20040312203452.GD16880@suse.de>
	 <1079124097.4187.216.camel@watt.suse.com>  <20040312205104.GE16880@suse.de>
Content-Type: text/plain
Message-Id: <1079297032.4185.277.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Mar 2004 15:43:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-12 at 15:51, Jens Axboe wrote:
> On Fri, Mar 12 2004, Chris Mason wrote:
> > On Fri, 2004-03-12 at 15:34, Jens Axboe wrote:
> > 
> > > 
> > > I don't see how this can make too much of a difference, aside of perhaps
> > > just moving the window a little. If page->mapping can disappear here,
> > > that's still a possibility.
> > 
> > As Andrew pointed out, the mapping struct won't disappear, but
> > page->mapping may go null.  So the idea is to use barriers to get a
> > trusted copy of page->mapping, and use the copy everywhere.
> 
> So trusting an atomic assignment of mapping = page->mapping, it should
> work. It feels a bit icky, though.

I reproduced on 2.6.4-mm1 + backing dev, but 2.6.4-mm1 alone ran fine. 
To make a long story short, the swap address space and backing dev don't
define an unplug_io_fn.  I was able to reproduce quickly with a swap
heavy workload.  The patch below should fix the oops, but probably isn't
correct solution since no queues will get unplugged while waiting on
swap pages.

It keeps the barriers for reading page->mapping, I still think we need
something there, maybe someone can suggest something better.

-chris

Index: linux.akpm/fs/buffer.c
===================================================================
--- linux.akpm.orig/fs/buffer.c	2004-03-14 15:15:37.409241104 -0500
+++ linux.akpm/fs/buffer.c	2004-03-14 15:15:51.137154144 -0500
@@ -2923,7 +2923,10 @@ EXPORT_SYMBOL(try_to_free_buffers);
 
 int block_sync_page(struct page *page)
 {
-	blk_run_address_space(page->mapping);
+	struct address_space *mapping;
+	smp_mb();
+	mapping = page->mapping;
+	blk_run_address_space(mapping);
 	return 0;
 }
 
Index: linux.akpm/mm/filemap.c
===================================================================
--- linux.akpm.orig/mm/filemap.c	2004-03-14 15:15:32.876930120 -0500
+++ linux.akpm/mm/filemap.c	2004-03-14 15:15:51.138153992 -0500
@@ -120,8 +120,10 @@ void remove_from_page_cache(struct page 
 
 static inline int sync_page(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
-
+	struct address_space *mapping;
+	
+	smp_mb();
+	mapping = page->mapping;
 	if (mapping && mapping->a_ops && mapping->a_ops->sync_page)
 		return mapping->a_ops->sync_page(page);
 	return 0;
Index: linux.akpm/include/linux/blkdev.h
===================================================================
--- linux.akpm.orig/include/linux/blkdev.h	2004-03-14 15:15:37.460233352 -0500
+++ linux.akpm/include/linux/blkdev.h	2004-03-14 15:17:24.035031520 -0500
@@ -527,7 +527,7 @@ static inline request_queue_t *bdev_get_
 
 static inline void blk_run_backing_dev(struct backing_dev_info *bdi)
 {
-	if (bdi)
+	if (bdi && bdi->unplug_io_fn)
 		bdi->unplug_io_fn(bdi);
 }
 






Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUKYHO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUKYHO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 02:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbUKYHO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 02:14:56 -0500
Received: from zeus.kernel.org ([204.152.189.113]:29846 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263003AbUKYHNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 02:13:37 -0500
Date: Wed, 24 Nov 2004 23:08:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: neilb@cse.unsw.edu.au, phil@dier.us, linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
Message-Id: <20041124230838.4d639c6d.akpm@osdl.org>
In-Reply-To: <20041125065728.GA10233@suse.de>
References: <20041122130622.27edf3e6.phil@dier.us>
	<20041122161725.21adb932.akpm@osdl.org>
	<16805.5470.892995.589150@cse.unsw.edu.au>
	<20041124155038.3716b8a5.akpm@osdl.org>
	<16805.9199.955186.236115@cse.unsw.edu.au>
	<20041125065728.GA10233@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Thu, Nov 25 2004, Neil Brown wrote:
> > On Wednesday November 24, akpm@osdl.org wrote:
> > > Neil Brown <neilb@cse.unsw.edu.au> wrote:
> > > >
> > > > Would the following (untested-but-seems-to-compile -
> > > > explanation-of-concept) patch be at all reasonable to avoid stack
> > > > depth problems with stacked block devices, or is adding stuff to
> > > > task_struct frowned upon? 
> > > 
> > > It's always a tradeoff - we've put things in task_struct before to get
> > > around sticky situations.  Certainly, removing potentially unbounded stack
> > > utilisation is a worthwhile thing to do.
> > > 
> > > The patch bends my brain a bit.
> > 
> > Recursion is like that (... like recursion, that is :-).
> 
> Pardon my ignorance, but where is the bug that called for something like
> this?

Well there was an xfs-on-raid-on-lvm stack overrun reported, but the
general problem we're addressing here is that stacking drivers can cause
arbitrary amounts of kernel stack windup.

> I can't say I love the idea of adding a bio list structure to the
> tasklist, it feels pretty hacky. generic_make_request() doesn't really
> use that much stack, if you just kill the BDEVNAME_SIZE struct.

Looks like a sensible thing to do, although it would be tidier to move the
whole thing into a separate function, no?


--- 25/drivers/block/ll_rw_blk.c~generic_make_request-stack-savings	2004-11-24 23:03:06.347778648 -0800
+++ 25-akpm/drivers/block/ll_rw_blk.c	2004-11-24 23:07:39.798207864 -0800
@@ -2584,6 +2584,20 @@ static inline void block_wait_queue_runn
 	}
 }
 
+static void handle_bad_sector(struct bio *bio)
+{
+	char b[BDEVNAME_SIZE];
+
+	printk(KERN_INFO "attempt to access beyond end of device\n");
+	printk(KERN_INFO "%s: rw=%ld, want=%Lu, limit=%Lu\n",
+			bdevname(bio->bi_bdev, b),
+			bio->bi_rw,
+			(unsigned long long)bio->bi_sector + bio_sectors(bio),
+			(long long)(bio->bi_bdev->bd_inode->i_size >> 9));
+
+	set_bit(BIO_EOF, &bio->bi_flags);
+}
+
 /**
  * generic_make_request: hand a buffer to its device driver for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -2620,21 +2634,13 @@ void generic_make_request(struct bio *bi
 	if (maxsector) {
 		sector_t sector = bio->bi_sector;
 
-		if (maxsector < nr_sectors ||
-		    maxsector - nr_sectors < sector) {
-			char b[BDEVNAME_SIZE];
-			/* This may well happen - the kernel calls
-			 * bread() without checking the size of the
-			 * device, e.g., when mounting a device. */
-			printk(KERN_INFO
-			       "attempt to access beyond end of device\n");
-			printk(KERN_INFO "%s: rw=%ld, want=%Lu, limit=%Lu\n",
-			       bdevname(bio->bi_bdev, b),
-			       bio->bi_rw,
-			       (unsigned long long) sector + nr_sectors,
-			       (long long) maxsector);
-
-			set_bit(BIO_EOF, &bio->bi_flags);
+		if (maxsector < nr_sectors || maxsector - nr_sectors < sector) {
+			/*
+			 * This may well happen - the kernel calls bread()
+			 * without checking the size of the device, e.g., when
+			 * mounting a device.
+			 */
+			handle_bad_sector(bio);
 			goto end_io;
 		}
 	}
_


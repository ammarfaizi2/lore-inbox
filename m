Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262993AbUKYG63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbUKYG63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 01:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUKYG63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 01:58:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8349 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262993AbUKYG6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 01:58:19 -0500
Date: Thu, 25 Nov 2004 07:57:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, phil@dier.us, linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm, and xfs
Message-ID: <20041125065728.GA10233@suse.de>
References: <20041122130622.27edf3e6.phil@dier.us> <20041122161725.21adb932.akpm@osdl.org> <16805.5470.892995.589150@cse.unsw.edu.au> <20041124155038.3716b8a5.akpm@osdl.org> <16805.9199.955186.236115@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16805.9199.955186.236115@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25 2004, Neil Brown wrote:
> On Wednesday November 24, akpm@osdl.org wrote:
> > Neil Brown <neilb@cse.unsw.edu.au> wrote:
> > >
> > > Would the following (untested-but-seems-to-compile -
> > > explanation-of-concept) patch be at all reasonable to avoid stack
> > > depth problems with stacked block devices, or is adding stuff to
> > > task_struct frowned upon? 
> > 
> > It's always a tradeoff - we've put things in task_struct before to get
> > around sticky situations.  Certainly, removing potentially unbounded stack
> > utilisation is a worthwhile thing to do.
> > 
> > The patch bends my brain a bit.
> 
> Recursion is like that (... like recursion, that is :-).

Pardon my ignorance, but where is the bug that called for something like
this? I can't say I love the idea of adding a bio list structure to the
tasklist, it feels pretty hacky. generic_make_request() doesn't really
use that much stack, if you just kill the BDEVNAME_SIZE struct.

===== drivers/block/ll_rw_blk.c 1.280 vs edited =====
--- 1.280/drivers/block/ll_rw_blk.c	2004-11-15 11:21:40 +01:00
+++ edited/drivers/block/ll_rw_blk.c	2004-11-25 07:56:10 +01:00
@@ -67,6 +67,11 @@
 EXPORT_SYMBOL(blk_max_low_pfn);
 EXPORT_SYMBOL(blk_max_pfn);
 
+struct b_name {
+	char b[BDEVNAME_SIZE];
+};
+static DEFINE_PER_CPU(struct b_name, b_cpu_name);
+
 /* Amount of time in which a process may batch requests */
 #define BLK_BATCH_TIME	(HZ/50UL)
 
@@ -2622,19 +2627,21 @@
 
 		if (maxsector < nr_sectors ||
 		    maxsector - nr_sectors < sector) {
-			char b[BDEVNAME_SIZE];
+			struct b_name *bn = &get_cpu_var(b_cpu_name);
+
 			/* This may well happen - the kernel calls
 			 * bread() without checking the size of the
 			 * device, e.g., when mounting a device. */
 			printk(KERN_INFO
 			       "attempt to access beyond end of device\n");
 			printk(KERN_INFO "%s: rw=%ld, want=%Lu, limit=%Lu\n",
-			       bdevname(bio->bi_bdev, b),
+			       bdevname(bio->bi_bdev, bn->b),
 			       bio->bi_rw,
 			       (unsigned long long) sector + nr_sectors,
 			       (long long) maxsector);
 
 			set_bit(BIO_EOF, &bio->bi_flags);
+			put_cpu_var(bn);
 			goto end_io;
 		}
 	}

> >                                   Shouldn't the queueing happen in
> > submit_bio()?
> 
> Both md and dm call generic_make_request rather than submit_bio to
> start IO on slaves, so it wouldn't work in submit_bio.  If dm and md
> were changes to use submit_bio, then the counts (page-in, page-out)
> would be quite different...

generic_make_request() has always been where the unstacking has
happened, so yeah submit_bio() would not work.

> > 
> > Is bi_next free in there?  If anyone tries to do synchronous I/O things
> > will get stuck.
> 
> It is my understanding the bi_next is free.  It is available for use
> by ->make_request_fn and below. __make_request uses it for chaining
> bio's together  into a request.  raid5 uses it for other things.

That's correct, bi_next is only used for request chaining. So it's
available for free use by the stacking drivers up until they call
make_request on a bio.

> If a ->make_request_fn did synchronous IO things would definitely get
> unstuck.   But I don't think they should and doubt if they do (md
> certainly doesn't).

There's nothing guaranteeing that a make_request would not do sync io.

-- 
Jens Axboe


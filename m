Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285166AbRLFRny>; Thu, 6 Dec 2001 12:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285190AbRLFRnq>; Thu, 6 Dec 2001 12:43:46 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:32516 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S285181AbRLFRng>; Thu, 6 Dec 2001 12:43:36 -0500
Date: Thu, 6 Dec 2001 20:43:30 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new bio: compile fix for alpha
Message-ID: <20011206204330.A608@jurassic.park.msu.ru>
In-Reply-To: <20011129165456.A13610@jurassic.park.msu.ru> <20011129152339.M10601@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011129152339.M10601@suse.de>; from axboe@suse.de on Thu, Nov 29, 2001 at 03:23:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 03:23:39PM +0100, Jens Axboe wrote:
> Please send whatever you find, thanks.

Well, I think this one is critical - in -pre4 BIO_CONTIG macro
has been changed:
-	(bio_to_phys((bio)) + bio_size((bio)) == bio_to_phys((nxt)))
+	(bvec_to_phys(__BVEC_END((bio)) + (bio)->bi_size) ==bio_to_phys((nxt)))
		      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This means that you add size in bytes to the `struct bio_vec' pointer,
which is obviously bogus. I wonder why this typo didn't expose itself
on x86 - on alpha I've got an oops on very first disk i/o in partition
check...

The rest is cleaning up some format vs. arg inconsistency on 64-bit
platforms.
Oh, and yet another [incorrect] BUG_ON macro on alpha killed.

Ivan.

--- 2.5.1p5/fs/bio.c	Thu Dec  6 19:25:13 2001
+++ linux/fs/bio.c	Thu Dec  6 19:25:26 2001
@@ -703,7 +703,7 @@ static int __init init_bio(void)
 		panic("bio: can't create bio_cachep slab cache\n");
 
 	nr = bio_init_pool();
-	printk("BIO: pool of %d setup, %uKb (%d bytes/bio)\n", nr, nr * sizeof(struct bio) >> 10, sizeof(struct bio));
+	printk("BIO: pool of %d setup, %luKb (%ld bytes/bio)\n", nr, nr * sizeof(struct bio) >> 10, sizeof(struct bio));
 
 	biovec_init_pool();
 
--- 2.5.1p5/include/linux/bio.h	Thu Dec  6 18:53:42 2001
+++ linux/include/linux/bio.h	Thu Dec  6 18:55:31 2001
@@ -120,7 +120,7 @@ struct bio {
  */
 #define __BVEC_END(bio) bio_iovec_idx((bio), (bio)->bi_idx - 1)
 #define BIO_CONTIG(bio, nxt) \
-	(bvec_to_phys(__BVEC_END((bio)) + (bio)->bi_size) == bio_to_phys((nxt)))
+	(bvec_to_phys(__BVEC_END((bio))) + (bio)->bi_size == bio_to_phys((nxt)))
 #define __BIO_SEG_BOUNDARY(addr1, addr2, mask) \
 	(((addr1) | (mask)) == (((addr2) - 1) | (mask)))
 #define BIO_SEG_BOUNDARY(q, b1, b2) \
--- 2.5.1p5/include/asm-alpha/page.h	Thu Dec  6 18:53:42 2001
+++ linux/include/asm-alpha/page.h	Thu Dec  6 19:02:04 2001
@@ -73,12 +73,6 @@ do {										\
 			BUG();			\
 	} while (0)
 
-#define BUG_ON(condition)			\
-	do {					\
-		if (unlikely((int)(condition)))	\
-			BUG();			\
-	} while (0)
-
 /* Pure 2^n version of get_order */
 extern __inline__ int get_order(unsigned long size)
 {
--- 2.5.1p5/drivers/block/ll_rw_blk.c	Thu Dec  6 18:53:37 2001
+++ linux/drivers/block/ll_rw_blk.c	Thu Dec  6 18:55:10 2001
@@ -177,7 +177,7 @@ void blk_queue_bounce_limit(request_queu
 		if (dma_addr == BLK_BOUNCE_ANY)
 			printk("no I/O memory limit\n");
 		else
-			printk("I/O limit %luMb (mask 0x%Lx)\n", mb, (u64) dma_addr);
+			printk("I/O limit %luMb (mask 0x%Lx)\n", mb, (long long) dma_addr);
 	}
 
 	q->bounce_pfn = bounce_pfn;
@@ -1056,7 +1056,7 @@ void generic_make_request(struct bio *bi
 				printk(KERN_INFO "%s: rw=%ld, want=%ld, limit=%Lu\n",
 				       kdevname(bio->bi_dev), bio->bi_rw,
 				       (sector + nr_sectors)>>1,
-				       (u64) blk_size[major][minor]);
+				       (long long) blk_size[major][minor]);
 			}
 			set_bit(BIO_EOF, &bio->bi_flags);
 			goto end_io;
@@ -1076,7 +1076,7 @@ void generic_make_request(struct bio *bi
 		if (!q) {
 			printk(KERN_ERR
 			       "generic_make_request: Trying to access nonexistent block-device %s (%Lu)\n",
-			       kdevname(bio->bi_dev), (u64) bio->bi_sector);
+			       kdevname(bio->bi_dev), (long long) bio->bi_sector);
 end_io:
 			bio->bi_end_io(bio, nr_sectors);
 			break;

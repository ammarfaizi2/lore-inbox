Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281739AbRLGOtF>; Fri, 7 Dec 2001 09:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281738AbRLGOsz>; Fri, 7 Dec 2001 09:48:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52741 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281735AbRLGOsp>;
	Fri, 7 Dec 2001 09:48:45 -0500
Date: Fri, 7 Dec 2001 15:48:36 +0100
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Oops on 2.5.1-pre6 doing mkreiserfs on loop device
Message-ID: <20011207144836.GF12017@suse.de>
In-Reply-To: <20011206233759.A173@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011206233759.A173@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06 2001, rwhron@earthlink.net wrote:
> 
> The three commands below are what executed just before the Oops.
> Output to console and ps show that mkreiserfs command was executing.
> The commands are a portion of a script I've run without Oops on
> other kernels.

This should fix it.

--- /opt/kernel/linux-2.5.1-pre6/mm/highmem.c	Fri Dec  7 09:16:24 2001
+++ mm/highmem.c	Fri Dec  7 09:44:27 2001
@@ -225,12 +225,11 @@
 
 		vfrom = page_address(fromvec->bv_page) + fromvec->bv_offset;
 
-		__save_flags(flags);
-		__cli();
+		local_irq_save(flags);
 		vto = kmap_atomic(tovec->bv_page, KM_BOUNCE_READ);
-		memcpy(vto + tovec->bv_offset, vfrom, to->bi_size);
+		memcpy(vto + tovec->bv_offset, vfrom, tovec->bv_len);
 		kunmap_atomic(vto, KM_BOUNCE_READ);
-		__restore_flags(flags);
+		local_irq_restore(flags);
 	}
 }
 
@@ -263,28 +262,36 @@
 static inline int bounce_end_io (struct bio *bio, int nr_sectors)
 {
 	struct bio *bio_orig = bio->bi_private;
-	struct page *page = bio_page(bio);
+	struct bio_vec *bvec, *org_vec;
 	unsigned long flags;
-	int ret;
+	int ret, i;
 
 	if (test_bit(BIO_UPTODATE, &bio->bi_flags))
 		set_bit(BIO_UPTODATE, &bio_orig->bi_flags);
 
 	ret = bio_orig->bi_end_io(bio_orig, nr_sectors);
 
+	/*
+	 * free up bounce indirect pages used
+	 */
 	spin_lock_irqsave(&emergency_lock, flags);
-	if (nr_emergency_pages >= POOL_SIZE) {
-		spin_unlock_irqrestore(&emergency_lock, flags);
-		__free_page(page);
-	} else {
-		/*
-		 * We are abusing page->list to manage
-		 * the highmem emergency pool:
-		 */
-		list_add(&page->list, &emergency_pages);
-		nr_emergency_pages++;
-		spin_unlock_irqrestore(&emergency_lock, flags);
+	bio_for_each_segment(bvec, bio, i) {
+		org_vec = &bio_orig->bi_io_vec[0];
+		if (bvec->bv_page == org_vec->bv_page)
+			continue;
+	
+		if (nr_emergency_pages >= POOL_SIZE)
+			__free_page(bvec->bv_page);
+		else {
+			/*
+			 * We are abusing page->list to manage
+			 * the highmem emergency pool:
+			 */
+			list_add(&bvec->bv_page->list, &emergency_pages);
+			nr_emergency_pages++;
+		}
 	}
+	spin_unlock_irqrestore(&emergency_lock, flags);
 
 	bio_put(bio);
 	return ret;

-- 
Jens Axboe


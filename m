Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281786AbRLGPBd>; Fri, 7 Dec 2001 10:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281780AbRLGPBZ>; Fri, 7 Dec 2001 10:01:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14598 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281735AbRLGPBH>;
	Fri, 7 Dec 2001 10:01:07 -0500
Date: Fri, 7 Dec 2001 16:00:58 +0100
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Oops on 2.5.1-pre6 doing mkreiserfs on loop device
Message-ID: <20011207150058.GJ12017@suse.de>
In-Reply-To: <20011206233759.A173@earthlink.net> <20011207144836.GF12017@suse.de> <20011207145431.GI12017@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011207145431.GI12017@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07 2001, Jens Axboe wrote:
> On Fri, Dec 07 2001, Jens Axboe wrote:
> > +	bio_for_each_segment(bvec, bio, i) {
> > +		org_vec = &bio_orig->bi_io_vec[0];
>                                                ^
> 
> argh, that should read 'i' and not '0' of course.

Updated patch follows.

--- /opt/kernel/linux-2.5.1-pre6/include/linux/bio.h	Fri Dec  7 02:09:31 2001
+++ include/linux/bio.h	Fri Dec  7 09:56:42 2001
@@ -100,7 +100,6 @@
 #define bio_iovec_idx(bio, idx)	(&((bio)->bi_io_vec[(idx)]))
 #define bio_iovec(bio)		bio_iovec_idx((bio), (bio)->bi_idx)
 #define bio_page(bio)		bio_iovec((bio))->bv_page
-#define __bio_offset(bio, idx)	bio_iovec_idx((bio), (idx))->bv_offset
 #define bio_offset(bio)		bio_iovec((bio))->bv_offset
 #define bio_sectors(bio)	((bio)->bi_size >> 9)
 #define bio_data(bio)		(page_address(bio_page((bio))) + bio_offset((bio)))
@@ -136,10 +135,17 @@
 
 #define bio_io_error(bio) bio_endio((bio), 0, bio_sectors((bio)))
 
-#define bio_for_each_segment(bvl, bio, i)				\
-	for (bvl = bio_iovec((bio)), i = (bio)->bi_idx;			\
+/*
+ * drivers should not use the __ version unless they _really_ want to
+ * run through the entire bio and not just pending pieces
+ */
+#define __bio_for_each_segment(bvl, bio, i, start_idx)			\
+	for (bvl = bio_iovec((bio)), i = (start_idx);			\
 	     i < (bio)->bi_vcnt;					\
 	     bvl++, i++)
+
+#define bio_for_each_segment(bvl, bio, i)				\
+	__bio_for_each_segment(bvl, bio, i, (bio)->bi_idx)
 
 /*
  * get a reference to a bio, so it won't disappear. the intended use is
--- /opt/kernel/linux-2.5.1-pre6/mm/highmem.c	Fri Dec  7 09:16:24 2001
+++ mm/highmem.c	Fri Dec  7 09:57:05 2001
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
+	__bio_for_each_segment(bvec, bio, i, 0) {
+		org_vec = &bio_orig->bi_io_vec[i];
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


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVBCCVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVBCCVB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 21:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVBCCVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 21:21:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:56208 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262481AbVBCCT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 21:19:29 -0500
Date: Wed, 2 Feb 2005 18:19:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Olien <dmo@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, agk@sourceware.org,
       dm-devel@redhat.com
Subject: Re: [PATCH] add local bio pool support and modify dm
Message-Id: <20050202181924.395165fe.akpm@osdl.org>
In-Reply-To: <20050202064720.GA7436@osdl.org>
References: <20050202064720.GA7436@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olien <dmo@osdl.org> wrote:
>
>  +extern inline void zero_fill_bio(struct bio *bio)
>  +{
>  +	unsigned long flags;
>  +	struct bio_vec *bv;
>  +	int i;
>  +
>  +	bio_for_each_segment(bv, bio, i) {
>  +		char *data = bvec_kmap_irq(bv, &flags);
>  +		memset(data, 0, bv->bv_len);
>  +		flush_dcache_page(bv->bv_page);
>  +		bvec_kunmap_irq(data, &flags);
>  +	}
>  +}

heavens.  Why was this made inline?  And extern inline?

It's too big for inlining (and is super-slow anyway) and will cause all
sorts of unpleasant header file dependencies for all architectures.  bio.h
now needs to see the implementation of everyone's flush_dcache_page(), for
example.


Something like this?

--- 25/include/linux/bio.h~add-local-bio-pool-support-and-modify-dm-uninline-zero_fill_bio	2005-02-02 18:17:18.225901376 -0800
+++ 25-akpm/include/linux/bio.h	2005-02-02 18:17:18.230900616 -0800
@@ -286,6 +286,7 @@ extern void bio_set_pages_dirty(struct b
 extern void bio_check_pages_dirty(struct bio *bio);
 extern struct bio *bio_copy_user(struct request_queue *, unsigned long, unsigned int, int);
 extern int bio_uncopy_user(struct bio *);
+void zero_fill_bio(struct bio *bio);
 
 #ifdef CONFIG_HIGHMEM
 /*
@@ -335,18 +336,4 @@ extern inline char *__bio_kmap_irq(struc
 	__bio_kmap_irq((bio), (bio)->bi_idx, (flags))
 #define bio_kunmap_irq(buf,flags)	__bio_kunmap_irq(buf, flags)
 
-extern inline void zero_fill_bio(struct bio *bio)
-{
-	unsigned long flags;
-	struct bio_vec *bv;
-	int i;
-
-	bio_for_each_segment(bv, bio, i) {
-		char *data = bvec_kmap_irq(bv, &flags);
-		memset(data, 0, bv->bv_len);
-		flush_dcache_page(bv->bv_page);
-		bvec_kunmap_irq(data, &flags);
-	}
-}
-
 #endif /* __LINUX_BIO_H */
diff -puN fs/bio.c~add-local-bio-pool-support-and-modify-dm-uninline-zero_fill_bio fs/bio.c
--- 25/fs/bio.c~add-local-bio-pool-support-and-modify-dm-uninline-zero_fill_bio	2005-02-02 18:17:18.227901072 -0800
+++ 25-akpm/fs/bio.c	2005-02-02 18:17:18.231900464 -0800
@@ -182,6 +182,21 @@ struct bio *bio_alloc(int gfp_mask, int 
 	return bio_alloc_bioset(gfp_mask, nr_iovecs, fs_bio_set);
 }
 
+void zero_fill_bio(struct bio *bio)
+{
+	unsigned long flags;
+	struct bio_vec *bv;
+	int i;
+
+	bio_for_each_segment(bv, bio, i) {
+		char *data = bvec_kmap_irq(bv, &flags);
+		memset(data, 0, bv->bv_len);
+		flush_dcache_page(bv->bv_page);
+		bvec_kunmap_irq(data, &flags);
+	}
+}
+EXPORT_SYMBOL(zero_fill_bio);
+
 /**
  * bio_put - release a reference to a bio
  * @bio:   bio to release reference to
_


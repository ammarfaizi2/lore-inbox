Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVA1WeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVA1WeV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 17:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVA1WeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 17:34:21 -0500
Received: from smtpout.mac.com ([17.250.248.97]:65229 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262800AbVA1WeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 17:34:10 -0500
In-Reply-To: <20050128212334.GA6576@turing.une.edu.au>
References: <20050128212334.GA6576@turing.une.edu.au>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B5832974-717C-11D9-B1C1-0003934F6348@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Mark Rustad <mrustad@mac.com>
Subject: Re: panic in raid1_end_write_request
Date: Fri, 28 Jan 2005 16:34:01 -0600
To: Norman Gaywood <norm@turing.une.edu.au>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman,

I used to get these running SuSE SLES 9 and also with a variety of 
kernel.org kernels. The crash was triggered by a media error on a 
RAID1. A patch that I got from SuSE fixed it for me. The patch is below 
your message excerpt.

On Jan 28, 2005, at 3:23 PM, Norman Gaywood wrote:

> I have a Dell PE2650, Dual Xeon, 1G memory and several software raid1
> partitions, ext3. Main duties include NFS, DHCP and samba. A Fedora
> kernel 2.6.10-1.747_FC3smp which includes 2.6.10-ac10.
>
> This system panics frequently, between several hours to several days. 
> It
> does not seem to be related to load. Hardware and memory tests indicate
> a good system.
>
> Panic messages are similar to:
>
> Unable to handle kernel NULL pointer dereference at virtual address 
> 00000038
>  printing eip:
> f882940f
> *pde = 379c9001
> Oops: 0000 [#1]

<snip>

Here is the patch:

--- linux-2.6.5/fs/bio.c~	2004-11-24 12:42:10.532343678 +0100
+++ linux-2.6.5/fs/bio.c	2004-11-24 12:46:49.308021403 +0100
@@ -98,12 +98,7 @@

  	BIO_BUG_ON(pool_idx >= BIOVEC_NR_POOLS);

-	/*
-	 * cloned bio doesn't own the veclist
-	 */
-	if (!bio_flagged(bio, BIO_CLONED))
-		mempool_free(bio->bi_io_vec, bp->pool);
-
+	mempool_free(bio->bi_io_vec, bp->pool);
  	mempool_free(bio, bio_pool);
  }

@@ -212,7 +207,9 @@
   */
  inline void __bio_clone(struct bio *bio, struct bio *bio_src)
  {
-	bio->bi_io_vec = bio_src->bi_io_vec;
+	request_queue_t *q = bdev_get_queue(bio_src->bi_bdev);
+
+	memcpy(bio->bi_io_vec, bio_src->bi_io_vec, bio_src->bi_max_vecs * 
sizeof(struct bio_vec));

  	bio->bi_sector = bio_src->bi_sector;
  	bio->bi_bdev = bio_src->bi_bdev;
@@ -224,21 +221,9 @@
  	 * for the clone
  	 */
  	bio->bi_vcnt = bio_src->bi_vcnt;
-	bio->bi_idx = bio_src->bi_idx;
-	if (bio_flagged(bio, BIO_SEG_VALID)) {
-		bio->bi_phys_segments = bio_src->bi_phys_segments;
-		bio->bi_hw_segments = bio_src->bi_hw_segments;
-		bio->bi_flags |= (1 << BIO_SEG_VALID);
-	}
  	bio->bi_size = bio_src->bi_size;
-
-	/*
-	 * cloned bio does not own the bio_vec, so users cannot fiddle with
-	 * it. clear bi_max_vecs and clear the BIO_POOL_BITS to make this
-	 * apparent
-	 */
-	bio->bi_max_vecs = 0;
-	bio->bi_flags &= (BIO_POOL_MASK - 1);
+	bio_phys_segments(q, bio);
+	bio_hw_segments(q, bio);
  }

  /**
@@ -250,7 +235,7 @@
   */
  struct bio *bio_clone(struct bio *bio, int gfp_mask)
  {
-	struct bio *b = bio_alloc(gfp_mask, 0);
+	struct bio *b = bio_alloc(gfp_mask, bio->bi_max_vecs);

  	if (b)
  		__bio_clone(b, bio);

-- 
Mark Rustad, MRustad@mac.com


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283529AbRK3HSx>; Fri, 30 Nov 2001 02:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283530AbRK3HSo>; Fri, 30 Nov 2001 02:18:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42001 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283529AbRK3HS3>;
	Fri, 30 Nov 2001 02:18:29 -0500
Date: Fri, 30 Nov 2001 08:18:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.1.4: fix rd.c build
Message-ID: <20011130081804.D16796@suse.de>
In-Reply-To: <3C06DE6F.746DA60A@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C06DE6F.746DA60A@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Jeff Garzik wrote:
> ...just a missed s/bio_size/foo->bi_size/ conversion. please apply.
> -- 
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
> Index: drivers/block/rd.c
> ===================================================================
> RCS file: /cvsroot/gkernel/linux_2_5/drivers/block/rd.c,v
> retrieving revision 1.3
> diff -u -r1.3 rd.c
> --- drivers/block/rd.c	2001/11/30 01:10:57	1.3
> +++ drivers/block/rd.c	2001/11/30 01:17:24
> @@ -239,7 +239,7 @@
>  
>  	index = sbh->bi_sector >> (PAGE_CACHE_SHIFT - 9);
>  	offset = (sbh->bi_sector << 9) & ~PAGE_CACHE_MASK;
> -	size = bio_size(sbh);
> +	size = sbh->bi_size;
>  
>  	do {
>  		int count;
> @@ -323,7 +323,7 @@
>  		goto fail;
>  
>  	offset = sbh->bi_sector << 9;
> -	len = bio_size(sbh);
> +	len = sbh->bi_size;
>  
>  	if ((offset + len) > rd_length[minor])
>  		goto fail;

Actually, this is not even enough if rd receives a multi page bio.
Something like this should work, untested.

--- /opt/kernel/linux-2.5.1-pre4/drivers/block/rd.c	Fri Nov 30 01:59:45 2001
+++ linux/drivers/block/rd.c	Fri Nov 30 02:14:06 2001
@@ -228,7 +228,8 @@
 	commit_write: ramdisk_commit_write,
 };
 
-static int rd_blkdev_pagecache_IO(int rw, struct bio *sbh, int minor)
+static int rd_blkdev_pagecache_IO(int rw, struct bio_vec *vec,
+				  sector_t sector, int minor)
 {
 	struct address_space * mapping;
 	unsigned long index;
@@ -237,9 +238,9 @@
 	err = -EIO;
 	mapping = rd_bdev[minor]->bd_inode->i_mapping;
 
-	index = sbh->bi_sector >> (PAGE_CACHE_SHIFT - 9);
-	offset = (sbh->bi_sector << 9) & ~PAGE_CACHE_MASK;
-	size = bio_size(sbh);
+	index = sector >> (PAGE_CACHE_SHIFT - 9);
+	offset = (sector << 9) & ~PAGE_CACHE_MASK;
+	size = vec->bv_len;
 
 	do {
 		int count;
@@ -276,18 +277,18 @@
 		if (rw == READ) {
 			src = kmap(page);
 			src += offset;
-			dst = bio_kmap(sbh);
+			dst = kmap(vec->bv_page) + vec->bv_offset;
 		} else {
 			dst = kmap(page);
 			dst += offset;
-			src = bio_kmap(sbh);
+			src = kmap(vec->bv_page) + vec->bv_offset;
 		}
 		offset = 0;
 
 		memcpy(dst, src, count);
 
 		kunmap(page);
-		bio_kunmap(sbh);
+		kunmap(vec->bv_page);
 
 		if (rw == READ) {
 			flush_dcache_page(page);
@@ -303,6 +304,22 @@
 	return err;
 }
 
+static int rd_blkdev_bio_IO(struct bio *bio, unsigned int minor)
+{
+	struct bio_vec *bvec;
+	sector_t sector;
+	int ret = 0, i, rw;
+
+	sector = bio->bi_sector;
+	rw = bio_data_dir(bio);
+	bio_for_each_segment(bvec, bio, i) {
+		ret |= rd_blkdev_pagecache_IO(rw, bvec, sector, minor);
+		sector += bvec->bv_len >> 9;
+	}
+
+	return ret;
+}
+
 /*
  *  Basically, my strategy here is to set up a buffer-head which can't be
  *  deleted, and make that my Ramdisk.  If the request is outside of the
@@ -323,7 +340,7 @@
 		goto fail;
 
 	offset = sbh->bi_sector << 9;
-	len = bio_size(sbh);
+	len = sbh->bi_size;
 
 	if ((offset + len) > rd_length[minor])
 		goto fail;
@@ -335,7 +352,7 @@
 		goto fail;
 	}
 
-	if (rd_blkdev_pagecache_IO(rw, sbh, minor))
+	if (rd_blkdev_bio_IO(sbh, minor))
 		goto fail;
 
 	set_bit(BIO_UPTODATE, &sbh->bi_flags);
@@ -437,10 +454,11 @@
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (unit == INITRD_MINOR) {
-		if (!initrd_start) return -ENODEV;
-		spin_lock( &initrd_users_lock );
+		spin_lock(&initrd_users_lock);
 		initrd_users++;
-		spin_unlock( &initrd_users_lock );
+		spin_unlock(&initrd_users_lock);
+		if (!initrd_start) 
+			return -ENODEV;
 		filp->f_op = &initrd_fops;
 		return 0;
 	}

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317423AbSFCRGg>; Mon, 3 Jun 2002 13:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317424AbSFCRGf>; Mon, 3 Jun 2002 13:06:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36874 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317423AbSFCRGd>; Mon, 3 Jun 2002 13:06:33 -0400
Date: Mon, 3 Jun 2002 18:06:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: PATCH/RFC: fix 2.5.20 ramdisk
Message-ID: <20020603180627.A23056@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.20 seems to be incapable of executing binaries in a ramdisk-based
root filesystem.  The ramdisk in question is an ext2fs, with a 1K
block size loaded via the compressed ramdisk loader in do_mounts().

It appears that, in the case of a 1K block sized filesystem, we attempt
to read two 512-byte sectors into a BIO vector.  The first one is copied
into the first 512 bytes.  The second sector, however, is copied over
the first 512 bytes.  Obviously not what we really want.

Here is _a_ patch which solves this for me, which may not be correct.
Jens?

--- orig/drivers/block/rd.c	Wed May 29 21:40:26 2002
+++ linux/drivers/block/rd.c	Mon Jun  3 17:59:08 2002
@@ -144,7 +144,7 @@
 {
 	struct address_space * mapping;
 	unsigned long index;
-	int offset, size, err;
+	int offset, vec_offset, size, err;
 
 	err = 0;
 	mapping = rd_bdev[minor]->bd_inode->i_mapping;
@@ -152,6 +152,7 @@
 	index = sector >> (PAGE_CACHE_SHIFT - 9);
 	offset = (sector << 9) & ~PAGE_CACHE_MASK;
 	size = vec->bv_len;
+	vec_offset = 0;
 
 	do {
 		int count;
@@ -186,13 +187,14 @@
 		if (rw == READ) {
 			src = kmap(page);
 			src += offset;
-			dst = kmap(vec->bv_page) + vec->bv_offset;
+			dst = kmap(vec->bv_page) + vec->bv_offset + vec_offset;
 		} else {
 			dst = kmap(page);
 			dst += offset;
-			src = kmap(vec->bv_page) + vec->bv_offset;
+			src = kmap(vec->bv_page) + vec->bv_offset + vec_offset;
 		}
 		offset = 0;
+		vec_offset += count;
 
 		memcpy(dst, src, count);
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


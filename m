Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSFDIps>; Tue, 4 Jun 2002 04:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316577AbSFDIpq>; Tue, 4 Jun 2002 04:45:46 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:47376 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316573AbSFDIpj>; Tue, 4 Jun 2002 04:45:39 -0400
Date: Tue, 4 Jun 2002 09:45:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH/RFC: fix 2.5.20 ramdisk
Message-ID: <20020604094532.A30552@flint.arm.linux.org.uk>
In-Reply-To: <20020603180627.A23056@flint.arm.linux.org.uk> <20020604083525.GA2512@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 10:35:25AM +0200, Jens Axboe wrote:
> On Mon, Jun 03 2002, Russell King wrote:
> > 2.5.20 seems to be incapable of executing binaries in a ramdisk-based
> > root filesystem.  The ramdisk in question is an ext2fs, with a 1K
> > block size loaded via the compressed ramdisk loader in do_mounts().
> > 
> > It appears that, in the case of a 1K block sized filesystem, we attempt
> > to read two 512-byte sectors into a BIO vector.  The first one is copied
> > into the first 512 bytes.  The second sector, however, is copied over
> > the first 512 bytes.  Obviously not what we really want.
> 
> Looks good.

Ok, rev. 2, slightly cleaned up:

--- orig/drivers/block/rd.c	Wed May 29 21:40:26 2002
+++ linux/drivers/block/rd.c	Tue Jun  4 09:44:21 2002
@@ -144,6 +144,7 @@
 {
 	struct address_space * mapping;
 	unsigned long index;
+	unsigned int vec_offset;
 	int offset, size, err;
 
 	err = 0;
@@ -152,6 +153,7 @@
 	index = sector >> (PAGE_CACHE_SHIFT - 9);
 	offset = (sector << 9) & ~PAGE_CACHE_MASK;
 	size = vec->bv_len;
+	vec_offset = vec->bv_offset;
 
 	do {
 		int count;
@@ -186,13 +188,14 @@
 		if (rw == READ) {
 			src = kmap(page);
 			src += offset;
-			dst = kmap(vec->bv_page) + vec->bv_offset;
+			dst = kmap(vec->bv_page) + vec_offset;
 		} else {
 			dst = kmap(page);
 			dst += offset;
-			src = kmap(vec->bv_page) + vec->bv_offset;
+			src = kmap(vec->bv_page) + vec_offset;
 		}
 		offset = 0;
+		vec_offset += count;
 
 		memcpy(dst, src, count);
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


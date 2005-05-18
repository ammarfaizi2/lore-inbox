Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVEROB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVEROB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVEROAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:00:00 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:15489 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262205AbVERNyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:54:06 -0400
Subject: [RFC/PATCH 4/5] loop: execute in place (V2)
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
In-Reply-To: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com>
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com>
Content-Type: text/plain
Organization: IBM Deutschland Entwicklung
Date: Wed, 18 May 2005 15:53:52 +0200
Message-Id: <1116424432.2202.19.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC/PATCH 4/5] loop: execute in place (V2)
The old loop driver in 2.6.11. used the readpage/writepage aops to
transfer data. Now loop can also use read/write and direct_IO on the
file if readpage/writepage are not available. Unlike the old 2.6.11.
version, today's loop driver does work with files that do not have
readpage/writepage. Threrefore, this patch is optional.
This patch adds one more transport method to loop that uses the new
address space operation get_xip_page if available.

This patch is unchanged from previous version.

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
--- 
diff -ruN linux-git/drivers/block/loop.c linux-git-xip/drivers/block/loop.c
--- linux-git/drivers/block/loop.c	2005-05-17 14:23:16.000000000 +0200
+++ linux-git-xip/drivers/block/loop.c	2005-05-17 19:12:50.707794472 +0200
@@ -275,6 +275,83 @@
 	goto out;
 }
 
+ 
+static int
+do_lo_send_xip(struct loop_device *lo, struct bio_vec *bvec, int bsize, loff_t pos,
+		struct page* ignored)
+{
+	struct file *file = lo->lo_backing_file; /* kudos to NFsckingS */
+	struct address_space *mapping = file->f_mapping;
+	struct address_space_operations *aops = mapping->a_ops;
+	struct page *page;
+	pgoff_t index;
+	unsigned size, offset, bv_offs;
+	int len;
+	int ret = 0;
+
+	down(&mapping->host->i_sem);
+	index = pos >> PAGE_CACHE_SHIFT;
+	offset = pos & ((pgoff_t)PAGE_CACHE_SIZE - 1);
+	bv_offs = bvec->bv_offset;
+	len = bvec->bv_len;
+	while (len > 0) {
+		sector_t IV;
+		int transfer_result;
+
+		IV = ((sector_t)index << (PAGE_CACHE_SHIFT - 9))+(offset >> 9);
+
+		size = PAGE_CACHE_SIZE - offset;
+		if (size > len)
+			size = len;
+
+		page = aops->get_xip_page(mapping,
+			index*(PAGE_SIZE/512), 0);
+		if (!page)
+			goto fail;
+		if (unlikely(IS_ERR(page))) {
+			if (PTR_ERR(page) == -ENODATA) {
+				/* sparse */
+				page = virt_to_page(empty_zero_page);
+			} else
+				goto fail;
+		} else
+			BUG_ON(!PageUptodate(page));
+
+		transfer_result = lo_do_transfer(lo, WRITE, page, offset,
+						 bvec->bv_page, bv_offs,
+						 size, IV);
+		if (transfer_result) {
+			char *kaddr;
+
+			/*
+			 * The transfer failed, but we still write the data to
+			 * keep prepare/commit calls balanced.
+			 */
+			printk(KERN_ERR "loop: transfer error block %llu\n",
+			       (unsigned long long)index);
+			kaddr = kmap_atomic(page, KM_USER0);
+			memset(kaddr + offset, 0, size);
+			kunmap_atomic(kaddr, KM_USER0);
+		}
+		flush_dcache_page(page);
+		if (transfer_result)
+			goto fail;
+		bv_offs += size;
+		len -= size;
+		offset = 0;
+		index++;
+		pos += size;
+	}
+	up(&mapping->host->i_sem);
+out:
+	return ret;
+
+fail:
+	up(&mapping->host->i_sem);
+	ret = -1;
+	goto out;
+}
+
 /**
  * __do_lo_send_write - helper for writing data to a loop device
  *
@@ -356,8 +433,11 @@
 	struct page *page = NULL;
 	int i, ret = 0;
 
-	do_lo_send = do_lo_send_aops;
-	if (!(lo->lo_flags & LO_FLAGS_USE_AOPS)) {
+	if (lo->lo_flags & LO_FLAGS_USE_AOPS)
+		do_lo_send = do_lo_send_aops;
+	else if (lo->lo_flags & LO_FLAGS_USE_XIP)
+		do_lo_send = do_lo_send_xip;
+	else {
 		do_lo_send = do_lo_send_direct_write;
 		if (lo->transfer != transfer_none) {
 			page = alloc_page(GFP_NOIO | __GFP_HIGHMEM);
@@ -787,11 +867,13 @@
 		 */
 		if (!file->f_op->sendfile)
 			goto out_putf;
-		if (aops->prepare_write && aops->commit_write)
+		if (aops->get_xip_page)
+			lo_flags |= LO_FLAGS_USE_XIP;
+		else if (aops->prepare_write && aops->commit_write)
 			lo_flags |= LO_FLAGS_USE_AOPS;
-		if (!(lo_flags & LO_FLAGS_USE_AOPS) && !file->f_op->write)
+		if (!(lo_flags & (LO_FLAGS_USE_AOPS | LO_FLAGS_USE_XIP)) 
+		    && !file->f_op->write)
 			lo_flags |= LO_FLAGS_READ_ONLY;
-
 		lo_blocksize = inode->i_blksize;
 		error = 0;
 	} else {
diff -ruN linux-git/include/linux/loop.h linux-git-xip/include/linux/loop.h
--- linux-git/include/linux/loop.h	2005-05-17 14:23:35.000000000 +0200
+++ linux-git-xip/include/linux/loop.h	2005-05-17 19:12:50.717792952 +0200
@@ -74,6 +74,7 @@
 enum {
 	LO_FLAGS_READ_ONLY	= 1,
 	LO_FLAGS_USE_AOPS	= 2,
+	LO_FLAGS_USE_XIP        = 4,
 };
 
 #include <asm/posix_types.h>	/* for __kernel_old_dev_t */



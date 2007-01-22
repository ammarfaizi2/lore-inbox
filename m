Return-Path: <linux-kernel-owner+w=401wt.eu-S1751263AbXAVIDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbXAVIDy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 03:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbXAVIDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 03:03:53 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:54662 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbXAVIDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 03:03:52 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XAZMDQMwO/EdIDFqW3pJuJ89M6rqouHB73vecd85srg2r6TBwDY/9POTObrdK5s/7wEhCmIDCDL/TTJ+LWVTlYfWQY2ND7JRgxMsVDCPgVN44MvVEtqZuwtPS0kIkabLVwdapI2icprfoLHvS2xwb7Ctk7n20XyZSgkDTOSYCyA=
Message-ID: <34781ae60701220003v76bd43c8h79c59b2b474b3c57@mail.gmail.com>
Date: Mon, 22 Jan 2007 16:03:51 +0800
From: "yang yin" <yinyang801120@gmail.com>
To: linux-raid@vger.kernel.org
Subject: [patch] md: bitmap read_page error
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the bitmap size is less than one page including super_block and
bitmap and the inode's i_blkbits is also small, when doing the
read_page function call to read the sb_page, it may return a error.
For example, if the device is 12800 chunks, its bitmap file size is
about 1.6KB include the bitmap super block. But the inode i_blkbits
value of the bitmap file is 10,  the read_page will submit 4 bh to
load the sb_page. Because the size of bitmap is only 1.6KB, in the
while loop, the error will ocurr when do bmap operation for the block
2, which will  return 0. Then the bitmap can't be initated because of
ther read sb page fail.

Another error is in the bitmap_init_from_disk function.  Before doing
read_page,. calculating the count value misses the size of super
block. When the bitmap just needs one page, It will read two pages
adding the super block. But at the second read, the count value will
be set to 0, and not all the bitmap will be read from the disk and
some bitmap will missed at the second page.

I give a patch as following:

---------
diff -Nur linux-2.6.19.2.orig/drivers/md/bitmap.c
linux-2.6.19.2/drivers/md/bitmap.c
--- linux-2.6.19.2.orig/drivers/md/bitmap.c     2007-01-11
03:10:37.000000000 +0800
+++ linux-2.6.19.2/drivers/md/bitmap.c  2007-01-20 20:45:32.000000000 +0800
@@ -352,6 +352,7 @@
        struct inode *inode = file->f_dentry->d_inode;
        struct buffer_head *bh;
        sector_t block;
+       loff_t read_size = 0;

        PRINTK("read bitmap file (%dB @ %Lu)\n", (int)PAGE_SIZE,
                        (unsigned long long)index << PAGE_SHIFT);
@@ -371,7 +372,7 @@
        attach_page_buffers(page, bh);
        block = index << (PAGE_SHIFT - inode->i_blkbits);
        while (bh) {
-               if (count == 0)
+               if (count == 0 || (read_size >= (inode->i_size -
(index << PAGE_SHIFT))))
                        bh->b_blocknr = 0;
                else {
                        bh->b_blocknr = bmap(inode, block);
@@ -394,6 +395,7 @@
                        set_buffer_mapped(bh);
                        submit_bh(READ, bh);
                }
+               read_size += (1 << inode->i_blkbits);
                block++;
                bh = bh->b_this_page;
        }
@@ -877,7 +879,7 @@
                        int count;
                        /* unmap the old page, we're done with it */
                        if (index == num_pages-1)
-                               count = bytes - index * PAGE_SIZE;
+                               count = bytes + sizeof(bitmap_super_t)
- index * PAGE_SIZE;
                        else
                                count = PAGE_SIZE;
                        if (index == 0) {


yinyang

________________________________
Tel: (86)10-62600547
Fax: (86)10-6265-7255
Mailing: P. O. Box 2704# Beijing
Postcode: 100080
National Research Centre for High Performance Computer
Institute of Computing Technology,Chinese Academy of Sciences
6,South Kexueyuan Road,
Haidian District, Beijing, China

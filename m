Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUBDVjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266618AbUBDVij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:38:39 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:10368 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266595AbUBDVew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:34:52 -0500
Subject: [PATCH] use cramfs as an initrd
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 04 Feb 2004 16:34:46 -0500
Message-Id: <1075930487.2028.123.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that Al Viro fixed cramfs, it works beautifully as an initrd
filesystem, so could we finally plumb it in?

Thanks,

James

===== init/do_mounts_rd.c 1.8 vs edited =====
--- 1.8/init/do_mounts_rd.c	Sat Oct 18 10:27:22 2003
+++ edited/init/do_mounts_rd.c	Mon Nov  3 15:09:51 2003
@@ -4,6 +4,7 @@
 #include <linux/minix_fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/romfs_fs.h>
+#include <linux/cramfs_fs.h>
 #include <linux/initrd.h>
 #include <linux/string.h>
 
@@ -41,6 +42,7 @@
  * 	minix
  * 	ext2
  *	romfs
+ *	cramfs
  * 	gzip
  */
 static int __init 
@@ -50,6 +52,7 @@
 	struct minix_super_block *minixsb;
 	struct ext2_super_block *ext2sb;
 	struct romfs_super_block *romfsb;
+	struct cramfs_super *cramfsb;
 	int nblocks = -1;
 	unsigned char *buf;
 
@@ -60,6 +63,7 @@
 	minixsb = (struct minix_super_block *) buf;
 	ext2sb = (struct ext2_super_block *) buf;
 	romfsb = (struct romfs_super_block *) buf;
+	cramfsb = (struct cramfs_super *) buf;
 	memset(buf, 0xe5, size);
 
 	/*
@@ -86,6 +90,14 @@
 		       "RAMDISK: romfs filesystem found at block %d\n",
 		       start_block);
 		nblocks = (ntohl(romfsb->size)+BLOCK_SIZE-1)>>BLOCK_SIZE_BITS;
+		goto done;
+	}
+
+	if (cramfsb->magic == CRAMFS_MAGIC) {
+		printk(KERN_NOTICE
+		       "RAMDISK: cramfs filesystem found at block %d\n",
+		       start_block);
+		nblocks = (cramfsb->size + BLOCK_SIZE - 1) >> BLOCK_SIZE_BITS;
 		goto done;
 	}
 


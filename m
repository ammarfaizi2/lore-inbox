Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbTGIHQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 03:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbTGIHQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 03:16:08 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:56629 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S265406AbTGIHQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 03:16:04 -0400
To: <torvalds@transmeta.com>
Subject: [PATCH] 2.5.74 do_mounts_rd fixes
From: <ffrederick@prov-liege.be>
Cc: <linux-kernel@vger.kernel.org>
Date: Wed, 9 Jul 2003 09:58:25 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S265406AbTGIHQE/20030709071604Z+22050@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabian Frederick:
	-<rd mount> Try ext2 before Minix
	-<rd mount> Comment fixes

--- do_mounts_rd.orig	2003-07-02 22:51:14.000000000 +0200
+++ do_mounts_rd.c	2003-07-09 08:49:52.000000000 +0200
@@ -68,7 +68,7 @@ identify_ramdisk_image(int fd, int start
 	read(fd, buf, size);
 
 	/*
-	 * If it matches the gzip magic numbers, return -1
+	 * If it matches the gzip magic numbers, return 0
 	 */
 	if (buf[0] == 037 && ((buf[1] == 0213) || (buf[1] == 0236))) {
 		printk(KERN_NOTICE
@@ -89,27 +89,27 @@ identify_ramdisk_image(int fd, int start
 	}
 
 	/*
-	 * Read block 1 to test for minix and ext2 superblock
+	 * Reading 2nd block to test for minix or ext2 superblock
 	 */
 	lseek(fd, (start_block+1) * BLOCK_SIZE, 0);
 	read(fd, buf, size);
 
-	/* Try minix */
-	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
-	    minixsb->s_magic == MINIX_SUPER_MAGIC2) {
+	/* Try ext2 */
+	if (ext2sb->s_magic == cpu_to_le16(EXT2_SUPER_MAGIC)) {
 		printk(KERN_NOTICE
-		       "RAMDISK: Minix filesystem found at block %d\n",
+		       "RAMDISK: ext2 filesystem found at block %d\n",
 		       start_block);
-		nblocks = minixsb->s_nzones << minixsb->s_log_zone_size;
+		nblocks = le32_to_cpu(ext2sb->s_blocks_count);
 		goto done;
 	}
 
-	/* Try ext2 */
-	if (ext2sb->s_magic == cpu_to_le16(EXT2_SUPER_MAGIC)) {
+	/* Try minix */
+	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
+	    minixsb->s_magic == MINIX_SUPER_MAGIC2) {
 		printk(KERN_NOTICE
-		       "RAMDISK: ext2 filesystem found at block %d\n",
+		       "RAMDISK: Minix filesystem found at block %d\n",
 		       start_block);
-		nblocks = le32_to_cpu(ext2sb->s_blocks_count);
+		nblocks = minixsb->s_nzones << minixsb->s_log_zone_size;
 		goto done;
 	}
 
@@ -377,9 +377,9 @@ static int __init crd_load(int in_fd, in
 {
 	int result;
 
-	insize = 0;		/* valid bytes in inbuf */
-	inptr = 0;		/* index of next byte to be processed in inbuf */
-	outcnt = 0;		/* bytes in output buffer */
+	insize = 0;	/* valid bytes in inbuf */
+	inptr = 0;	/* index of next byte to be processed in inbuf */
+	outcnt = 0;	/* bytes in output buffer */
 	exit_code = 0;
 	bytes_out = 0;
 	crc = (ulg)0xffffffffL; /* shift register contents */


___________________________________




Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313314AbSEDDPY>; Fri, 3 May 2002 23:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313896AbSEDDPX>; Fri, 3 May 2002 23:15:23 -0400
Received: from dsl092-144-112.wdc1.dsl.speakeasy.net ([66.92.144.112]:42373
	"EHLO roz.db2adm.com") by vger.kernel.org with ESMTP
	id <S313314AbSEDDPW>; Fri, 3 May 2002 23:15:22 -0400
Date: Fri, 3 May 2002 23:15:10 -0400 (EDT)
From: Ward Fenton <ward@db2adm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre8 syntax errors in fs/ufs/super.c
Message-ID: <Pine.LNX.4.44.0205032310200.21194-100000@roz.db2adm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a portion of the 2.4.19-pre8 patch with a correction
for a few syntax errors.

from patch-2.4.19-pre8
missing commas in several added printk statements...

@@ -653,14 +657,34 @@
 	uspi->s_fmask = fs32_to_cpu(sb, usb1->fs_fmask);
 	uspi->s_fshift = fs32_to_cpu(sb, usb1->fs_fshift);
 
-	if (uspi->s_bsize != 4096 && uspi->s_bsize != 8192 
-	  && uspi->s_bsize != 32768) {
-		printk("ufs_read_super: fs_bsize %u != {4096, 8192, 
32768}\n", uspi->s_bsize);
+	if (uspi->s_fsize & (uspi->s_fsize - 1)) {
+		printk("ufs_read_super: fragment size %u is not a power of 
2\n",
+			uspi->s_fsize);
+		goto failed;
+	}
+	if (uspi->s_bsize < 512) {
+		printk("ufs_read_super: fragment size %u is too small\n"
+			uspi->s_fsize);
+		goto failed;
+	}
+	if (uspi->s_bsize > 4096) {
+		printk("ufs_read_super: fragment size %u is too large\n"
+			uspi->s_fsize);
+		goto failed;
+	}
+	if (uspi->s_bsize & (uspi->s_bsize - 1)) {
+		printk("ufs_read_super: block size %u is not a power of 
2\n",
+			uspi->s_bsize);
+		goto failed;
+	}
+	if (uspi->s_bsize < 4096) {
+		printk("ufs_read_super: block size %u is too small\n"
+			uspi->s_fsize);
 		goto failed;
 	}
-	if (uspi->s_fsize != 512 && uspi->s_fsize != 1024 
-	  && uspi->s_fsize != 2048 && uspi->s_fsize != 4096) {
-		printk("ufs_read_super: fs_fsize %u != {512, 1024, 2048. 
4096}\n", uspi->s_fsize);
+	if (uspi->s_bsize / uspi->s_fsize > 8) {
+		printk("ufs_read_super: too many fragments per block 
(%u)\n"
+			uspi->s_bsize / uspi->s_fsize);
 		goto failed;
 	}
 	if (uspi->s_fsize != block_size || uspi->s_sbsize != 
super_block_size) {


Correction for missing commas...

@@ -653,14 +657,34 @@
 	uspi->s_fmask = fs32_to_cpu(sb, usb1->fs_fmask);
 	uspi->s_fshift = fs32_to_cpu(sb, usb1->fs_fshift);
 
-	if (uspi->s_bsize != 4096 && uspi->s_bsize != 8192 
-	  && uspi->s_bsize != 32768) {
-		printk("ufs_read_super: fs_bsize %u != {4096, 8192, 
32768}\n", uspi->s_bsize);
+	if (uspi->s_fsize & (uspi->s_fsize - 1)) {
+		printk("ufs_read_super: fragment size %u is not a power of 
2\n",
+			uspi->s_fsize);
+		goto failed;
+	}
+	if (uspi->s_bsize < 512) {
+		printk("ufs_read_super: fragment size %u is too small\n",
+			uspi->s_fsize);
+		goto failed;
+	}
+	if (uspi->s_bsize > 4096) {
+		printk("ufs_read_super: fragment size %u is too large\n",
+			uspi->s_fsize);
+		goto failed;
+	}
+	if (uspi->s_bsize & (uspi->s_bsize - 1)) {
+		printk("ufs_read_super: block size %u is not a power of 
2\n",
+			uspi->s_bsize);
+		goto failed;
+	}
+	if (uspi->s_bsize < 4096) {
+		printk("ufs_read_super: block size %u is too small\n",
+			uspi->s_fsize);
 		goto failed;
 	}
-	if (uspi->s_fsize != 512 && uspi->s_fsize != 1024 
-	  && uspi->s_fsize != 2048 && uspi->s_fsize != 4096) {
-		printk("ufs_read_super: fs_fsize %u != {512, 1024, 2048. 
4096}\n", uspi->s_fsize);
+	if (uspi->s_bsize / uspi->s_fsize > 8) {
+		printk("ufs_read_super: too many fragments per block 
(%u)\n",
+			uspi->s_bsize / uspi->s_fsize);
 		goto failed;
 	}
 	if (uspi->s_fsize != block_size || uspi->s_sbsize != 
super_block_size) {



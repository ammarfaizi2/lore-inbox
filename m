Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWJDQPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWJDQPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWJDQPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:15:11 -0400
Received: from turak.kspei.com ([64.240.156.220]:65254 "EHLO mail.kspei.com")
	by vger.kernel.org with ESMTP id S964887AbWJDQPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:15:05 -0400
Date: Wed, 4 Oct 2006 11:15:02 -0500
From: Steven Pritchard <steve@silug.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] TiVo partition support
Message-ID: <20061004161502.GA14714@osiris.silug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to work out a problem with my Series 2 TiVo, I noticed
that recent kernels still don't have support for the modified Mac
partition table the TiVos use.  Below is a lightly tested patch for
2.6.17 (which applies cleanly to 2.6.18 also) that adds the support.

This isn't even remotely original work.  I adapted this from the patch
I found here:

  http://homepage.ntlworld.com/maxwells.daemon/tivo/downloads/tivo-partition-support-1.patch

Pete Zaitcev has an equivalent patch here (which I found after I had
already rebased the above patch):

  http://people.redhat.com/zaitcev/linux/linux-2.6.16-rc5-tivo1.diff

diff -ur linux-2.6.17.orig/fs/partitions/Kconfig linux-2.6.17/fs/partitions/Kconfig
--- linux-2.6.17.orig/fs/partitions/Kconfig	2006-06-17 20:49:35.000000000 -0500
+++ linux-2.6.17/fs/partitions/Kconfig	2006-09-27 13:23:42.000000000 -0500
@@ -104,6 +104,11 @@
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned on a Macintosh.
 
+config TIVO_PARTITION
+	bool "TiVo partition map support" if MAC_PARTITION
+	help
+	  Say Y here if you would like to include support for TiVo partitions.
+
 config MSDOS_PARTITION
 	bool "PC BIOS (MSDOS partition tables) support" if PARTITION_ADVANCED
 	default y
diff -ur linux-2.6.17.orig/fs/partitions/mac.c linux-2.6.17/fs/partitions/mac.c
--- linux-2.6.17.orig/fs/partitions/mac.c	2006-06-17 20:49:35.000000000 -0500
+++ linux-2.6.17/fs/partitions/mac.c	2006-09-27 13:25:21.000000000 -0500
@@ -46,11 +46,26 @@
 	md = (struct mac_driver_desc *) read_dev_sector(bdev, 0, &sect);
 	if (!md)
 		return -1;
-	if (be16_to_cpu(md->signature) != MAC_DRIVER_MAGIC) {
-		put_dev_sector(sect);
-		return 0;
+
+	switch(be16_to_cpu(md->signature)) {
+		case MAC_DRIVER_MAGIC:
+			secsize = be16_to_cpu(md->block_size);
+			break;
+
+#ifdef CONFIG_TIVO_PARTITION
+		case TIVO_DRIVER_MAGIC:
+			/* The TiVo map does not have a valid Mac block 0
+			 * fill in the block size.
+			 */
+			secsize = 512;
+			break;
+#endif
+
+		default:
+			put_dev_sector(sect);
+			return 0;
 	}
-	secsize = be16_to_cpu(md->block_size);
+
 	put_dev_sector(sect);
 	data = read_dev_sector(bdev, secsize/512, &sect);
 	if (!data)
diff -ur linux-2.6.17.orig/fs/partitions/mac.h linux-2.6.17/fs/partitions/mac.h
--- linux-2.6.17.orig/fs/partitions/mac.h	2006-06-17 20:49:35.000000000 -0500
+++ linux-2.6.17/fs/partitions/mac.h	2006-09-27 13:26:30.000000000 -0500
@@ -32,6 +32,7 @@
 #define MAC_STATUS_BOOTABLE	8	/* partition is bootable */
 
 #define MAC_DRIVER_MAGIC	0x4552
+#define TIVO_DRIVER_MAGIC	0x1492
 
 /* Driver descriptor structure, in block 0 */
 struct mac_driver_desc {

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUBWCLO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 21:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbUBWCLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 21:11:14 -0500
Received: from eth13.com-link.com ([208.242.241.164]:31372 "EHLO
	real.realitydiluted.com") by vger.kernel.org with ESMTP
	id S261777AbUBWCLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 21:11:02 -0500
Message-ID: <40396134.6030906@realitydiluted.com>
Date: Sun, 22 Feb 2004 21:11:00 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 2.6.2, Partition support for SCSI CDROM...
Content-Type: multipart/mixed;
 boundary="------------070808010309090904050803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070808010309090904050803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings.

This patch enables support for CDROMs that have partitions on
them, like say SGI and SUN media. It was sent to me by Christoph
Hellwig and then I cleaned it up a bit. I am posting it more
for flamebait^Wcomments to see if people are comfortable with it.
Thanks.

-Steve

--------------070808010309090904050803
Content-Type: text/x-patch;
 name="scsi-sr-partitions-2.6.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi-sr-partitions-2.6.2.patch"

diff -urN linux-2.6.2/drivers/scsi/Kconfig linux-2.6.2-patched/drivers/scsi/Kconfig
--- linux-2.6.2/drivers/scsi/Kconfig	2004-02-22 20:15:07.000000000 -0500
+++ linux-2.6.2-patched/drivers/scsi/Kconfig	2004-02-08 20:29:04.000000000 -0500
@@ -112,6 +112,48 @@
 	  drives (and HP Writers). If you have such a drive and get the first
 	  session only, try saying Y here; everybody else says N.
 
+config BLK_DEV_SR_PARTITIONS
+	bool "Enable partitions (for SCSI CDROM)"
+	depends on BLK_DEV_SR
+	help
+	  This enables the utilisation of partitions on CDs, usually
+	  media from SGI or Sun. You must enable "SGI partition support"
+	  and/or "Sun partition tables support" to be able to see their
+	  respective CD partitions. Also make sure to say Y or M to
+	  "EFS file system support" and "UFS file system support" to
+	  support reading of SGI and Sun filesystems.
+	  
+	  If you want to this feature, say Y here; everybody else will
+	  most likely say N.
+
+config BLK_DEV_SR_PARTITIONS_PER_DEVICE
+	int "Number of paritions supported per SCSI CDROM device"
+	depends on BLK_DEV_SR_PARTITIONS
+	default "0"
+	help
+	  The number of partitions supported per SCSI CDROM device. If
+	  the value chosen was 7, you will have the following device
+	  node mappings:
+
+	     sr0 - first CDROM, whole disk
+	     sr1 - first CDROM, first partition
+	     
+	     [...]
+	     
+	     sr7 - first CDROM, seventh partition
+	     sr8 - second CDROM, whole disk
+	     sr9 - second CDROM, first partition
+
+	     [...]
+
+	  You made need to create additional device nodes depending on
+	  the number of partitions and SCSI CDROM devices you have in
+	  your system.
+	  
+	  If SCSI CDROM support is compiled as a module, you can specify
+	  how many partitions you want when you insert the module which
+	  will override this default value.
+	  
 config CHR_DEV_SG
 	tristate "SCSI generic support"
 	depends on SCSI
diff -urN linux-2.6.2/drivers/scsi/sr.c linux-2.6.2-patched/drivers/scsi/sr.c
--- linux-2.6.2/drivers/scsi/sr.c	2004-02-22 20:15:08.000000000 -0500
+++ linux-2.6.2-patched/drivers/scsi/sr.c	2004-02-08 20:31:52.000000000 -0500
@@ -55,6 +55,13 @@
 #include "scsi_logging.h"
 #include "sr.h"
 
+#ifdef CONFIG_BLK_DEV_SR_PARTITIONS
+static int partitions = CONFIG_BLK_DEV_SR_PARTITIONS_PER_DEVICE;
+MODULE_PARM(partitions, "i");
+MODULE_PARM_DESC(partitions, "number of SCSI CDROM partitions to support");
+#else
+static int partitions = 0;
+#endif
 
 MODULE_PARM(xa_test, "i");	/* see sr_ioctl.c */
 
@@ -518,7 +525,7 @@
 		goto fail;
 	memset(cd, 0, sizeof(*cd));
 
-	disk = alloc_disk(1);
+	disk = alloc_disk(partitions + 1);
 	if (!disk)
 		goto fail_free;
 
@@ -533,7 +540,7 @@
 	spin_unlock(&sr_index_lock);
 
 	disk->major = SCSI_CDROM_MAJOR;
-	disk->first_minor = minor;
+	disk->first_minor = minor * (partitions + 1);
 	sprintf(disk->disk_name, "sr%d", minor);
 	disk->fops = &sr_bdops;
 	disk->flags = GENHD_FL_CD;
@@ -868,6 +875,12 @@
 {
 	int rc;
 
+#ifdef MODULE
+	/* Check number of partitions specified. */
+	if (partitions < 0)
+		partitions = 0;
+#endif
+
 	rc = register_blkdev(SCSI_CDROM_MAJOR, "sr");
 	if (rc)
 		return rc;

--------------070808010309090904050803--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVBXOsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVBXOsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 09:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVBXOsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:48:36 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:51105 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262359AbVBXOsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:48:02 -0500
Date: Thu, 24 Feb 2005 15:38:14 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
cc: Tejun Heo <htejun@gmail.com>
Subject: [patch ide-dev 2/9] add ide_tf_get_address() helper
Message-ID: <Pine.GSO.4.58.0502241537330.13534@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* add ide_tf_get_address() helper
* use it in idedisk_read_native_max_address[_ext]()
  and idedisk_set_max_address[_ext]()

diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-02-19 17:22:32 +01:00
+++ b/drivers/ide/ide-disk.c	2005-02-19 17:22:32 +01:00
@@ -344,8 +344,7 @@

 	/* if OK, compute maximum address value */
 	if ((tf->command & 1) == 0) {
-		addr = ((tf->device & 0xf) << 24) |
-		       (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
+		addr = (u32)ide_tf_get_address(tf);
 		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
 	return addr;
@@ -373,9 +372,7 @@

 	/* if OK, compute maximum address value */
 	if ((tf->command & 1) == 0) {
-		u32 high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
-		u32 low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
-		addr = ((__u64)high << 24) | low;
+		addr = ide_tf_get_address(tf);
 		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
 	return addr;
@@ -407,8 +404,7 @@
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, read new maximum address value */
 	if ((tf->command & 1) == 0) {
-		addr_set = ((tf->device & 0xf) << 24) |
-			   (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
+		addr_set = (u32)ide_tf_get_address(tf);
 		addr_set++;
 	}
 	return addr_set;
@@ -442,9 +438,7 @@
 	ide_raw_taskfile(drive, &args, NULL);
 	/* if OK, compute maximum address value */
 	if ((tf->command & 1) == 0) {
-		u32 high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
-		u32 low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
-		addr_set = ((__u64)high << 24) | low;
+		addr_set = ide_tf_get_address(tf);
 		addr_set++;
 	}
 	return addr_set;
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-19 17:22:32 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-19 17:22:32 +01:00
@@ -317,6 +317,22 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 }

+u64 ide_tf_get_address(struct ata_taskfile *tf)
+{
+	u32 high, low;
+
+	if (tf->flags & ATA_TFLAG_LBA48)
+		high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
+	else
+		high = tf->device & 0xf;
+
+	low = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
+
+	return ((u64)high << 24) | low;
+}
+
+EXPORT_SYMBOL_GPL(ide_tf_get_address);
+
 /*
  * FIXME: probably move this somewhere else, name is bad too :)
  */
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-02-19 17:22:32 +01:00
+++ b/include/linux/ide.h	2005-02-19 17:22:32 +01:00
@@ -1189,6 +1189,8 @@
  */
 extern void ide_init_drive_cmd (struct request *rq);

+u64 ide_tf_get_address(struct ata_taskfile *);
+
 /*
  * this function returns error location sector offset in case of a write error
  */

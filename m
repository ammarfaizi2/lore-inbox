Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263297AbTC0Q6s>; Thu, 27 Mar 2003 11:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263298AbTC0Q6s>; Thu, 27 Mar 2003 11:58:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48517
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263297AbTC0Q6q>; Thu, 27 Mar 2003 11:58:46 -0500
Date: Thu, 27 Mar 2003 18:16:14 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271816.h2RIGEan019640@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One from Jens - fix up the problems with older Samsung disks that don't
abort unknown commands sometimes

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/drivers/ide/ide-disk.c linux-2.5.66-ac1/drivers/ide/ide-disk.c
--- linux-2.5.66-bk3/drivers/ide/ide-disk.c	2003-03-27 17:13:19.000000000 +0000
+++ linux-2.5.66-ac1/drivers/ide/ide-disk.c	2003-03-26 20:23:01.000000000 +0000
@@ -1098,6 +1098,7 @@
  * in above order (i.e., if value of higher priority is available,
  * reset will be ignored).
  */
+#define IDE_STROKE_LIMIT	(32000*1024*2)
 static void init_idedisk_capacity (ide_drive_t  *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -1118,7 +1119,7 @@
 		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
 		drive->select.b.lba	= 1;
 		set_max_ext = idedisk_read_native_max_address_ext(drive);
-		if (set_max_ext > capacity_2) {
+		if (set_max_ext > capacity_2 && capacity_2 > IDE_STROKE_LIMIT) {
 #ifdef CONFIG_IDEDISK_STROKE
 			set_max_ext = idedisk_read_native_max_address_ext(drive);
 			set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
@@ -1145,7 +1146,7 @@
 		drive->select.b.lba = 1;
 	}
 
-	if (set_max > capacity) {
+	if (set_max > capacity && capacity > IDE_STROKE_LIMIT) {
 #ifdef CONFIG_IDEDISK_STROKE
 		set_max = idedisk_read_native_max_address(drive);
 		set_max = idedisk_set_max_address(drive, set_max);

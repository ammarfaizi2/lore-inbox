Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVHBVbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVHBVbC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVHBV2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:28:53 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56060 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261863AbVHBV16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:27:58 -0400
Message-ID: <42EFE547.3010206@mvista.com>
Date: Tue, 02 Aug 2005 14:27:35 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH]  IDE disks show invalid geometries in /proc/ide/hd*/geometry
References: <42E97236.6080404@mvista.com> <42EA6580.9010204@mvista.com> <42EAA7C8.5010206@mvista.com>
In-Reply-To: <42EAA7C8.5010206@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------040408070003070501040601"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040408070003070501040601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The ATA specification tells large disk drives to return C/H/S data of 
16383/16/63 regardless of their actual size (other variations on this 
return include 15 heads and/or 4092 cylinders). Unfortunately these CHS 
data confuse the existing IDE code and cause it to report invalid 
geometries in /proc when the disk runs in LBA mode.

The invalid geometries can cause failures in the partitioning tools; 
partitioning may be impossible or illogical size limitations occur. This 
also leads to various forms of human confusion.

I attach a patch that fixes this problem while strongly attempting to 
not break any existing side effects and await any comments.

mark

Signed-off-by: Mark Bellon <mbellon@mvista.com>


--------------040408070003070501040601
Content-Type: text/plain;
 name="ide-geom-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-geom-patch"

diff -Naur linux-2.6.13-rc3-git9-orig/drivers/ide/ide-disk.c linux-2.6.13-rc3-git9/drivers/ide/ide-disk.c
--- linux-2.6.13-rc3-git9-orig/drivers/ide/ide-disk.c	2005-08-01 13:48:21.000000000 -0700
+++ linux-2.6.13-rc3-git9/drivers/ide/ide-disk.c	2005-08-02 12:14:43.000000000 -0700
@@ -884,10 +884,17 @@
  	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 }
 
+static uint32_t do_div64_32 (__u64 n, uint32_t d)
+{
+	do_div(n, d);
+
+	return n;
+}
+
 static void idedisk_setup (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
-	unsigned long long capacity;
+	__u64 capacity;
 	int barrier;
 
 	idedisk_add_settings(drive);
@@ -949,27 +956,32 @@
 	 */
 	capacity = idedisk_capacity (drive);
 	if (!drive->forced_geom) {
+		uint32_t cylsz, cyl;
 
-		if (idedisk_supports_lba48(drive->id)) {
-			/* compatibility */
-			drive->bios_sect = 63;
-			drive->bios_head = 255;
+		/*
+		 * In LBA mode the geometry isn't used to talk to the drive
+		 * so always create a "rational" geometry from the capacity.
+		 */
+		if (drive->select.b.lba) {
+			drive->bios_sect = drive->sect = 63;
+			drive->bios_head = drive->head = 255;
+
+			cylsz = drive->bios_sect * drive->bios_head;
+			cyl = do_div64_32(capacity, cylsz);
+
+			/* "fake out" works up to ~500 GB */
+			cyl = (cyl > 65535) ? 65535 : cyl;
+			drive->bios_cyl = drive->cyl = cyl;
 		}
 
 		if (drive->bios_sect && drive->bios_head) {
-			unsigned int cap0 = capacity; /* truncate to 32 bits */
-			unsigned int cylsz, cyl;
+			cylsz = drive->bios_sect * drive->bios_head;
+			cyl = do_div64_32(capacity, cylsz);
 
-			if (cap0 != capacity)
-				drive->bios_cyl = 65535;
-			else {
-				cylsz = drive->bios_sect * drive->bios_head;
-				cyl = cap0 / cylsz;
-				if (cyl > 65535)
-					cyl = 65535;
-				if (cyl > drive->bios_cyl)
-					drive->bios_cyl = cyl;
-			}
+			if (cyl > 65535)
+				cyl = 65535;
+			if (cyl > drive->bios_cyl)
+				drive->bios_cyl = cyl;
 		}
 	}
 	printk(KERN_INFO "%s: %llu sectors (%llu MB)",

--------------040408070003070501040601--

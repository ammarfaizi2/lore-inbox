Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270626AbTHESSw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270644AbTHESS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:18:28 -0400
Received: from hera.cwi.nl ([192.16.191.8]:52961 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S270640AbTHESSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:18:15 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 5 Aug 2003 20:18:11 +0200 (MEST)
Message-Id: <UTC200308051818.h75IIB517382.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] fix error return get/set_native_max functions
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ide-disk.c we have functions
  idedisk_read_native_max_address
  idedisk_read_native_max_address_ext
  idedisk_set_max_address
  idedisk_set_max_address_ext
that are documented as

 /*
  * Sets maximum virtual LBA address of the drive.
  * Returns new maximum virtual LBA address (> 0) or 0 on failure.
  */

The IDE command they execute returns the largest address,
and 1 is added to get the capacity.
Unfortunately, the code does

	addr = 0;
	if (ide_command_succeeds) {
		addr = ...
	}
	addr++;

so that the return value on error is 1 instead of 0.
The patch below moves the addr++.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Mon Jul 28 05:39:23 2003
+++ b/drivers/ide/ide-disk.c	Tue Aug  5 21:00:34 2003
@@ -964,12 +964,13 @@
 		     | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
 		     | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
 		     | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
-	addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	return addr;
 }
 
-static unsigned long long idedisk_read_native_max_address_ext(ide_drive_t *drive)
+static unsigned long long
+idedisk_read_native_max_address_ext(ide_drive_t *drive)
 {
 	ide_task_t args;
 	unsigned long long addr = 0;
@@ -992,8 +993,8 @@
 			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
 			    (args.tfRegister[IDE_SECTOR_OFFSET]);
 		addr = ((__u64)high << 24) | low;
+		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
-	addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	return addr;
 }
 
@@ -1002,7 +1003,8 @@
  * Sets maximum virtual LBA address of the drive.
  * Returns new maximum virtual LBA address (> 0) or 0 on failure.
  */
-static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
+static unsigned long
+idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
 {
 	ide_task_t args;
 	unsigned long addr_set = 0;
@@ -1024,12 +1026,13 @@
 			 | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
 			 | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
 			 | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+		addr_set++;
 	}
-	addr_set++;
 	return addr_set;
 }
 
-static unsigned long long idedisk_set_max_address_ext(ide_drive_t *drive, unsigned long long addr_req)
+static unsigned long long
+idedisk_set_max_address_ext(ide_drive_t *drive, unsigned long long addr_req)
 {
 	ide_task_t args;
 	unsigned long long addr_set = 0;
@@ -1059,6 +1062,7 @@
 			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
 			    (args.tfRegister[IDE_SECTOR_OFFSET]);
 		addr_set = ((__u64)high << 24) | low;
+		addr_set++;
 	}
 	return addr_set;
 }

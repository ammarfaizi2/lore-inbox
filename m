Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287969AbSAMCzo>; Sat, 12 Jan 2002 21:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287984AbSAMCy3>; Sat, 12 Jan 2002 21:54:29 -0500
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:54659
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S287965AbSAMCyX>; Sat, 12 Jan 2002 21:54:23 -0500
Message-ID: <005701c19bdd$a035c280$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Paul Bristow" <paul@paulbristow.net>
Subject: [CFT][PATCH] ide-floppy cleanups/media change detection (1/5)
Date: Sat, 12 Jan 2002 19:54:32 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I am posting this to the list because my recent attempts to contact the
maintainer of this module have been unsuccessful...)

This message (and the next 4) contain five patches for the ide-floppy.c
module (against 2.4.18-pre3). The patches do the following:

1 - (cosmetic fix) make ide-floppy only emit its "ide-floppy 0.xx" banner
once per module load
2 - remove duplicate code for the Clik! drive
3 - modify ide-floppy functions to use kmalloc for a large structure instead
of the stack
4 - move common lock/unlock code into a function (instead of 4+ repetitions)
5 - implement media change detection

Patches 1-3 can stand alone, but patch 4 assumes patch 3 has been applied
(although it could be rediffed and work without patch 3). Patch 5 would
probably apply without patch 4, but with some fuzz.

Patch 1 follows:

diff -X dontdiff -urN linux/drivers/ide/ide-floppy.c
linux-1/drivers/ide/ide-floppy.c
--- linux/drivers/ide/ide-floppy.c Sat Jan 12 16:23:16 2002
+++ linux-1/drivers/ide/ide-floppy.c Sat Jan 12 16:33:08 2002
@@ -2087,8 +2087,12 @@
  ide_drive_t *drive;
  idefloppy_floppy_t *floppy;
  int failed = 0;
+ static int first_init = 1;

- printk("ide-floppy driver " IDEFLOPPY_VERSION "\n");
+ if (first_init) {
+  printk ("ide-floppy driver " IDEFLOPPY_VERSION "\n");
+  first_init = 0;
+ }
  MOD_INC_USE_COUNT;
  while ((drive = ide_scan_devices (ide_floppy, idefloppy_driver.name, NULL,
failed++)) != NULL) {
   if (!idefloppy_identify_device (drive, drive->id)) {





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbSJ2OYg>; Tue, 29 Oct 2002 09:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbSJ2OYg>; Tue, 29 Oct 2002 09:24:36 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:990 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S261875AbSJ2OYe>;
	Tue, 29 Oct 2002 09:24:34 -0500
To: axboe@suse.de
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] Fix: BK-Current doesn't compile w/o SCSI enabled
From: tytso@mit.edu
Message-Id: <E186XOP-0006Z7-00@snap.thunk.org>
Date: Tue, 29 Oct 2002 09:30:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BK current doesn't compile without SCSI being enabled, since
sg_scsi_ioctl() in drivers/block/scsi_ioctl.c is always being compiled,
regardless of whether or not SCSI is present (since some non-SCSI
devices now use this infrastructure).  Unfortunately, it makes reference
to the COMMAND_SIZE() macro, which is defined in drivers/scsi/scsi.c,
and that is NOT defined on non-SCSI build kernels.

The simplest solution to this problem seems to be move scsi_command_size
from drivers/scsi/scsi.c to drivers/block/scsi_ioctl.c, where it is used
(and since it is always compiled in, this shouldn't break anything on
SCSI systems).

I'm a bit uneasy about the abstraction violation of moving the
scsi_command_size array outside of the drivers/scsi tree, but that
problem was introduced when the code in drivers/block/scsi_ioctl.c was
moved out of the drivers/scsi tree, since drivers/block/scsi_ioctl.c
already #includes ../scsi/scsi.h, so I haven't introduced a new layering
violation.

Jens, do you agree this is the best way of fixing this issue?  If so,
please push this change to Linus.  Thanks!!

					- Ted


diff -Nru a/drivers/block/scsi_ioctl.c b/drivers/block/scsi_ioctl.c
--- a/drivers/block/scsi_ioctl.c	Tue Oct 29 09:25:36 2002
+++ b/drivers/block/scsi_ioctl.c	Tue Oct 29 09:25:36 2002
@@ -39,6 +39,14 @@
 
 #define BLK_DEFAULT_TIMEOUT	(60 * HZ)
 
+/* Command group 3 is reserved and should never be used.  */
+const unsigned char scsi_command_size[8] =
+{
+	6, 10, 10, 12,
+	16, 12, 10, 10
+};
+EXPORT_SYMBOL(scsi_command_size);
+
 int blk_do_rq(request_queue_t *q, struct block_device *bdev, struct request *rq)
 {
 	DECLARE_COMPLETION(wait);
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Tue Oct 29 09:25:36 2002
+++ b/drivers/scsi/scsi.c	Tue Oct 29 09:25:36 2002
@@ -123,12 +123,6 @@
  */
 unsigned long scsi_pid;
 Scsi_Cmnd *last_cmnd;
-/* Command group 3 is reserved and should never be used.  */
-const unsigned char scsi_command_size[8] =
-{
-	6, 10, 10, 12,
-	16, 12, 10, 10
-};
 static unsigned long serial_number;
 
 struct softscsi_data {
diff -Nru a/drivers/scsi/scsi_syms.c b/drivers/scsi/scsi_syms.c
--- a/drivers/scsi/scsi_syms.c	Tue Oct 29 09:25:36 2002
+++ b/drivers/scsi/scsi_syms.c	Tue Oct 29 09:25:36 2002
@@ -39,7 +39,6 @@
 EXPORT_SYMBOL(scsi_bios_ptable);
 EXPORT_SYMBOL(scsi_allocate_device);
 EXPORT_SYMBOL(scsi_do_cmd);
-EXPORT_SYMBOL(scsi_command_size);
 EXPORT_SYMBOL(scsi_ioctl);
 EXPORT_SYMBOL(print_command);
 EXPORT_SYMBOL(print_sense);

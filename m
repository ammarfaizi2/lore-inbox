Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVBXOsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVBXOsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 09:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVBXOsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:48:11 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:51105 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262358AbVBXOsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:48:02 -0500
Date: Thu, 24 Feb 2005 15:41:58 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
cc: Tejun Heo <htejun@gmail.com>
Subject: [patch ide-dev 5/9] fix setting LBA bit in Device register for
 REQ_DRIVE_TASKFILE
Message-ID: <Pine.GSO.4.58.0502241541240.13534@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't set LBA bit in Device register for the following cases:

* Power Management requests
  (WIN_FLUSH_CACHE[_EXT], WIN_STANDBYNOW1, WIN_IDLEIMMEDIATE commands)
* special commands (WIN_SPECIFY, WIN_RESTORE, WIN_SETMULT)
* /proc/ide/ SMART support (WIN_SMART with SMART_ENABLE,
  SMART_READ_VALUES and SMART_READ_THRESHOLDS subcommands)
* write cache enabling/disabling in ide-disk
  (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_WCACHE)
* write cache flushing in ide-disk (WIN_FLUSH_CACHE[_EXT])
* acoustic management in ide-disk
  (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_AAM)
* door (un)locking in ide-disk (WIN_DOORLOCK, WIN_DOORUNLOCK)
* /proc/ide/hd?/identify support (WIN_IDENTIFY)

diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2005-02-20 01:27:04 +01:00
+++ b/drivers/ide/ide-taskfile.c	2005-02-20 01:27:04 +01:00
@@ -127,7 +127,7 @@
 	hwif->OUTB(tf->lbam, IDE_LCYL_REG);
 	hwif->OUTB(tf->lbah, IDE_HCYL_REG);

-	hwif->OUTB((tf->device & HIHI) | drive->select.all, IDE_SELECT_REG);
+	hwif->OUTB((tf->device & HIHI) | (drive->select.all & 0xBF), IDE_SELECT_REG);

 	if (task->handler != NULL) {
 		if (task->prehandler != NULL) {
@@ -605,6 +605,9 @@
 	if (drive->addressing == 1)
 		tf->flags |= ATA_TFLAG_LBA48;

+	if (drive->select.b.lba)
+		tf->device |= ATA_LBA;
+
 	switch(req_task->data_phase) {
 		case TASKFILE_OUT_DMAQ:
 		case TASKFILE_OUT_DMA:
@@ -892,7 +895,7 @@
 	 * select bit (master/slave) in the drive_head register. We must make
 	 * sure that the desired drive is selected.
 	 */
-	hwif->OUTB(tf->device | drive->select.all, IDE_SELECT_REG);
+	hwif->OUTB(tf->device | (drive->select.all & 0xBF), IDE_SELECT_REG);
 	switch(task->data_phase) {

    	        case TASKFILE_OUT_DMAQ:

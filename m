Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUFSQRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUFSQRj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbUFSQRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:17:37 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5028 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264153AbUFSQPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:15:44 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups [4/11]
Date: Sat, 19 Jun 2004 18:10:08 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191810.08584.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: check drive->mult_count in flagged_taskfile()

Check drive->mult_count in flagged_taskfile() and fail request early
if necessary so there is no need to do it later in the PIO handlers.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_multi_check drivers/ide/ide-taskfile.c
--- linux-2.6.7/drivers/ide/ide-taskfile.c~ide_tf_multi_check	2004-06-19 02:56:06.001922504 +0200
+++ linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c	2004-06-19 02:56:06.006921744 +0200
@@ -1188,6 +1188,14 @@ ide_startstop_t flagged_taskfile (ide_dr
 	void debug_taskfile(drive, task);
 #endif /* CONFIG_IDE_TASK_IOCTL_DEBUG */
 
+	if (task->data_phase == TASKFILE_MULTI_IN ||
+	    task->data_phase == TASKFILE_MULTI_OUT) {
+		if (!drive->mult_count) {
+			printk(KERN_ERR "%s: multimode not set!\n", drive->name);
+			return ide_stopped;
+		}
+	}
+
 	/*
 	 * (ks) Check taskfile in/out flags.
 	 * If set, then execute as it is defined.
@@ -1370,8 +1378,6 @@ ide_startstop_t flagged_task_mulin_intr 
 	unsigned int msect, nsect;
 
 	msect = drive->mult_count;
-	if (msect == 0) 
-		return DRIVER(drive)->error(drive, "flagged_task_mulin_intr (multimode not set)", stat); 
 
 	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
 		if (stat & ERR_STAT) {
@@ -1477,15 +1483,11 @@ ide_startstop_t flagged_task_out_intr (i
 
 ide_startstop_t flagged_pre_task_mulout_intr (ide_drive_t *drive, struct request *rq)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 stat			= hwif->INB(IDE_STATUS_REG);
 	char *pBuf		= NULL;
 	ide_startstop_t startstop;
 	unsigned int msect, nsect;
 
 	msect = drive->mult_count;
-	if (msect == 0)
-		return DRIVER(drive)->error(drive, "flagged_pre_task_mulout_intr (multimode not set)", stat);
 
 	if (ide_wait_stat(&startstop, drive, DATA_READY,
 			BAD_W_STAT, WAIT_DRQ)) {
@@ -1514,8 +1516,6 @@ ide_startstop_t flagged_task_mulout_intr
 	unsigned int msect, nsect;
 
 	msect = drive->mult_count;
-	if (msect == 0)
-		return DRIVER(drive)->error(drive, "flagged_task_mulout_intr (multimode not set)", stat);
 
 	if (!OK_STAT(stat, DRIVE_READY, BAD_W_STAT)) 
 		return DRIVER(drive)->error(drive, "flagged_task_mulout_intr", stat);

_


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268276AbTBNVQ0>; Fri, 14 Feb 2003 16:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268210AbTBNVQB>; Fri, 14 Feb 2003 16:16:01 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:6444 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S268046AbTBNVOe>; Fri, 14 Feb 2003 16:14:34 -0500
Date: Fri, 14 Feb 2003 16:24:06 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60-bk4] fix compile breakage on drivers/scsi/fd_mcs.c
Message-ID: <Pine.LNX.4.53.0302141622300.21601@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes compile breakage due to recent changes to scsi.h

John Kim


--- linux-2.5.60-bk4/drivers/scsi/fd_mcs.c	2003-02-10 13:38:20.000000000 -0500
+++ linux-2.5.60-bk4-new/drivers/scsi/fd_mcs.c	2003-02-14 15:32:46.000000000 -0500
@@ -732,7 +732,7 @@
 		outb(0x40 | FIFO_COUNT, Interrupt_Cntl_port);
 
 		outb(0x82, SCSI_Cntl_port);	/* Bus Enable + Select */
-		outb(adapter_mask | (1 << current_SC->target), SCSI_Data_NoACK_port);
+		outb(adapter_mask | (1 << current_SC->device->id), SCSI_Data_NoACK_port);
 
 		/* Stop arbitration and enable parity */
 		outb(0x10 | PARITY_MASK, TMC_Cntl_port);
@@ -744,7 +744,7 @@
 		status = inb(SCSI_Status_port);
 		if (!(status & 0x01)) {
 			/* Try again, for slow devices */
-			if (fd_mcs_select(shpnt, current_SC->target)) {
+			if (fd_mcs_select(shpnt, current_SC->device->id)) {
 #if EVERY_ACCESS
 				printk(" SFAIL ");
 #endif
@@ -1150,7 +1150,7 @@
 
 static int fd_mcs_queue(Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
 {
-	struct Scsi_Host *shpnt = SCpnt->host;
+	struct Scsi_Host *shpnt = SCpnt->device->host;
 
 	if (in_command) {
 		panic("fd_mcs: fd_mcs_queue() NOT REENTRANT!\n");
@@ -1286,7 +1286,7 @@
 
 static int fd_mcs_abort(Scsi_Cmnd * SCpnt)
 {
-	struct Scsi_Host *shpnt = SCpnt->host;
+	struct Scsi_Host *shpnt = SCpnt->device->host;
 
 	unsigned long flags;
 #if EVERY_ACCESS || ERRORS_ONLY || DEBUG_ABORT
@@ -1331,7 +1331,7 @@
 }
 
 static int fd_mcs_bus_reset(Scsi_Cmnd * SCpnt) {
-	struct Scsi_Host *shpnt = SCpnt->host;
+	struct Scsi_Host *shpnt = SCpnt->device->host;
 
 #if DEBUG_RESET
 	static int called_once = 0;

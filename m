Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbTBNVlR>; Fri, 14 Feb 2003 16:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267467AbTBNVk4>; Fri, 14 Feb 2003 16:40:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21514 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267432AbTBNUyV>; Fri, 14 Feb 2003 15:54:21 -0500
Subject: PATCH: fix fd_mcs build for scsi changes, mca compt
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:04:18 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jn0M-0005fv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/scsi/fd_mcs.c linux-2.5.60-ac1/drivers/scsi/fd_mcs.c
--- linux-2.5.60-ref/drivers/scsi/fd_mcs.c	2003-02-14 21:21:36.000000000 +0000
+++ linux-2.5.60-ac1/drivers/scsi/fd_mcs.c	2003-02-14 20:17:01.000000000 +0000
@@ -87,6 +87,7 @@
 #include <linux/delay.h>
 #include <linux/mca.h>
 #include <linux/spinlock.h>
+#include <linux/mca-legacy.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -732,7 +733,7 @@
 		outb(0x40 | FIFO_COUNT, Interrupt_Cntl_port);
 
 		outb(0x82, SCSI_Cntl_port);	/* Bus Enable + Select */
-		outb(adapter_mask | (1 << current_SC->target), SCSI_Data_NoACK_port);
+		outb(adapter_mask | (1 << current_SC->device->id), SCSI_Data_NoACK_port);
 
 		/* Stop arbitration and enable parity */
 		outb(0x10 | PARITY_MASK, TMC_Cntl_port);
@@ -744,7 +745,7 @@
 		status = inb(SCSI_Status_port);
 		if (!(status & 0x01)) {
 			/* Try again, for slow devices */
-			if (fd_mcs_select(shpnt, current_SC->target)) {
+			if (fd_mcs_select(shpnt, current_SC->device->id)) {
 #if EVERY_ACCESS
 				printk(" SFAIL ");
 #endif
@@ -802,7 +803,7 @@
 #endif
 #if ERRORS_ONLY
 			if (current_SC->SCp.Status && current_SC->SCp.Status != 2 && current_SC->SCp.Status != 8) {
-				printk("ERROR fd_mcs: target = %d, command = %x, status = %x\n", current_SC->target, current_SC->cmnd[0], current_SC->SCp.Status);
+				printk("ERROR fd_mcs: target = %d, command = %x, status = %x\n", current_SC->device->id, current_SC->cmnd[0], current_SC->SCp.Status);
 			}
 #endif
 			break;
@@ -1150,7 +1151,7 @@
 
 static int fd_mcs_queue(Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
 {
-	struct Scsi_Host *shpnt = SCpnt->host;
+	struct Scsi_Host *shpnt = SCpnt->device->host;
 
 	if (in_command) {
 		panic("fd_mcs: fd_mcs_queue() NOT REENTRANT!\n");
@@ -1243,7 +1244,7 @@
 		break;
 	}
 
-	printk("(%d), target = %d cmnd = 0x%02x pieces = %d size = %u\n", SCpnt->SCp.phase, SCpnt->target, *(unsigned char *) SCpnt->cmnd, SCpnt->use_sg, SCpnt->request_bufflen);
+	printk("(%d), target = %d cmnd = 0x%02x pieces = %d size = %u\n", SCpnt->SCp.phase, SCpnt->device->id, *(unsigned char *) SCpnt->cmnd, SCpnt->use_sg, SCpnt->request_bufflen);
 	printk("sent_command = %d, have_data_in = %d, timeout = %d\n", SCpnt->SCp.sent_command, SCpnt->SCp.have_data_in, SCpnt->timeout);
 #if DEBUG_RACE
 	printk("in_interrupt_flag = %d\n", in_interrupt_flag);
@@ -1286,7 +1287,7 @@
 
 static int fd_mcs_abort(Scsi_Cmnd * SCpnt)
 {
-	struct Scsi_Host *shpnt = SCpnt->host;
+	struct Scsi_Host *shpnt = SCpnt->device->host;
 
 	unsigned long flags;
 #if EVERY_ACCESS || ERRORS_ONLY || DEBUG_ABORT
@@ -1331,7 +1332,7 @@
 }
 
 static int fd_mcs_bus_reset(Scsi_Cmnd * SCpnt) {
-	struct Scsi_Host *shpnt = SCpnt->host;
+	struct Scsi_Host *shpnt = SCpnt->device->host;
 
 #if DEBUG_RESET
 	static int called_once = 0;

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268478AbTBNVV3>; Fri, 14 Feb 2003 16:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268473AbTBNVUz>; Fri, 14 Feb 2003 16:20:55 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:10029 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S268352AbTBNVTJ>; Fri, 14 Feb 2003 16:19:09 -0500
Date: Fri, 14 Feb 2003 16:28:42 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60-bk4] fix compile breakage on drivers/scsi/wd7000.c
Message-ID: <Pine.LNX.4.53.0302141627220.21601@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes compile breakage due to recent changes to scsi.h

John Kim


--- linux-2.5.60-bk4/drivers/scsi/wd7000.c	2003-02-10 13:38:59.000000000 -0500
+++ linux-2.5.60-bk4-new/drivers/scsi/wd7000.c	2003-02-14 15:50:01.000000000 -0500
@@ -1122,13 +1122,13 @@
 	register unchar *cdb = (unchar *) SCpnt->cmnd;
 	register unchar idlun;
 	register short cdblen;
-	Adapter *host = (Adapter *) SCpnt->host->hostdata;
+	Adapter *host = (Adapter *) SCpnt->device->host->hostdata;
 
 	cdblen = SCpnt->cmd_len;
-	idlun = ((SCpnt->target << 5) & 0xe0) | (SCpnt->lun & 7);
+	idlun = ((SCpnt->device->id << 5) & 0xe0) | (SCpnt->device->lun & 7);
 	SCpnt->scsi_done = done;
 	SCpnt->SCp.phase = 1;
-	scb = alloc_scbs(SCpnt->host, 1);
+	scb = alloc_scbs(SCpnt->device->host, 1);
 	scb->idlun = idlun;
 	memcpy(scb->cdb, cdb, cdblen);
 	scb->direc = 0x40;	/* Disable direction check */
@@ -1141,7 +1141,7 @@
 		struct scatterlist *sg = (struct scatterlist *) SCpnt->request_buffer;
 		unsigned i;
 
-		if (SCpnt->host->sg_tablesize == SG_NONE) {
+		if (SCpnt->device->host->sg_tablesize == SG_NONE) {
 			panic("wd7000_queuecommand: scatter/gather not supported.\n");
 		}
 		dprintk("Using scatter/gather with %d elements.\n", SCpnt->use_sg);
@@ -1646,7 +1646,7 @@
  */
 static int wd7000_abort(Scsi_Cmnd * SCpnt)
 {
-	Adapter *host = (Adapter *) SCpnt->host->hostdata;
+	Adapter *host = (Adapter *) SCpnt->device->host->hostdata;
 
 	if (inb(host->iobase + ASC_STAT) & INT_IM) {
 		printk("wd7000_abort: lost interrupt\n");
@@ -1677,7 +1677,7 @@
 
 static int wd7000_host_reset(Scsi_Cmnd * SCpnt)
 {
-	Adapter *host = (Adapter *) SCpnt->host->hostdata;
+	Adapter *host = (Adapter *) SCpnt->device->host->hostdata;
 
 	if (wd7000_adapter_reset(host) < 0)
 		return FAILED;

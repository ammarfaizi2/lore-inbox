Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267726AbTBNU6s>; Fri, 14 Feb 2003 15:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbTBNU5O>; Fri, 14 Feb 2003 15:57:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27402 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267726AbTBNU4M>; Fri, 14 Feb 2003 15:56:12 -0500
Subject: PATCH: fix wd7000 for new scsi
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:06:09 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jn29-0005h3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/scsi/wd7000.c linux-2.5.60-ac1/drivers/scsi/wd7000.c
--- linux-2.5.60-ref/drivers/scsi/wd7000.c	2003-02-14 21:21:36.000000000 +0000
+++ linux-2.5.60-ac1/drivers/scsi/wd7000.c	2003-02-14 20:30:31.000000000 +0000
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

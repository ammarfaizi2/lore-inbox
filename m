Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267616AbTBNVf4>; Fri, 14 Feb 2003 16:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267736AbTBNU4V>; Fri, 14 Feb 2003 15:56:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26890 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267616AbTBNU4E>; Fri, 14 Feb 2003 15:56:04 -0500
Subject: PATCH: fix ultrastor for new scsi
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:05:56 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jn1w-0005gq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/scsi/ultrastor.c linux-2.5.60-ac1/drivers/scsi/ultrastor.c
--- linux-2.5.60-ref/drivers/scsi/ultrastor.c	2003-02-14 21:21:36.000000000 +0000
+++ linux-2.5.60-ac1/drivers/scsi/ultrastor.c	2003-02-14 19:57:43.000000000 +0000
@@ -504,7 +504,7 @@
      * Brrr, &config.mscp[0].SCint->host) it is something magical....
      * XXX and FIXME
      */
-    if (request_irq(config.interrupt, do_ultrastor_interrupt, 0, "Ultrastor", &config.mscp[0].SCint->host)) {
+    if (request_irq(config.interrupt, do_ultrastor_interrupt, 0, "Ultrastor", &config.mscp[0].SCint->device->host)) {
 	printk("Unable to allocate IRQ%u for UltraStor controller.\n",
 	       config.interrupt);
 	goto out_release_port;
@@ -714,9 +714,9 @@
 
        ???  Which other device types should never use the cache?   */
     my_mscp->ca = SCpnt->device->type != TYPE_TAPE;
-    my_mscp->target_id = SCpnt->target;
+    my_mscp->target_id = SCpnt->device->id;
     my_mscp->ch_no = 0;
-    my_mscp->lun = SCpnt->lun;
+    my_mscp->lun = SCpnt->device->lun;
     if (SCpnt->use_sg) {
 	/* Set scatter/gather flag in SCSI command packet */
 	my_mscp->sg = TRUE;
@@ -832,7 +832,7 @@
     unsigned char old_aborted;
     unsigned long flags;
     void (*done)(Scsi_Cmnd *);
-    struct Scsi_Host *host = SCpnt->host;
+    struct Scsi_Host *host = SCpnt->device->host;
 
     if(config.slot) 
       return FAILED;  /* Do not attempt an abort for the 24f */
@@ -954,7 +954,7 @@
 {
     unsigned long flags;
     int i;
-    struct Scsi_Host *host = SCpnt->host;
+    struct Scsi_Host *host = SCpnt->device->host;
     
 #if (ULTRASTOR_DEBUG & UD_RESET)
     printk("US14F: reset: called\n");

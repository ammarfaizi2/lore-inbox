Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267539AbTBNU4K>; Fri, 14 Feb 2003 15:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTBNUyf>; Fri, 14 Feb 2003 15:54:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21002 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267448AbTBNUyB>; Fri, 14 Feb 2003 15:54:01 -0500
Subject: PATCH: fix aha1740
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:03:59 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jn04-0005fo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/scsi/aha1740.c linux-2.5.60-ac1/drivers/scsi/aha1740.c
--- linux-2.5.60-ref/drivers/scsi/aha1740.c	2003-02-14 21:21:35.000000000 +0000
+++ linux-2.5.60-ac1/drivers/scsi/aha1740.c	2003-02-14 20:14:18.000000000 +0000
@@ -315,8 +315,8 @@
 {
     unchar direction;
     unchar *cmd = (unchar *) SCpnt->cmnd;
-    unchar target = SCpnt->target;
-    struct aha1740_hostdata *host = HOSTDATA(SCpnt->host);
+    unchar target = SCpnt->device->id;
+    struct aha1740_hostdata *host = HOSTDATA(SCpnt->device->host);
     unsigned long flags;
     void *buff = SCpnt->request_buffer;
     int bufflen = SCpnt->request_bufflen;
@@ -416,7 +416,7 @@
 	host->ecb[ecbno].datalen = bufflen;
 	host->ecb[ecbno].dataptr = isa_virt_to_bus(buff);
     }
-    host->ecb[ecbno].lun = SCpnt->lun;
+    host->ecb[ecbno].lun = SCpnt->device->lun;
     host->ecb[ecbno].ses = 1;	/* Suppress underrun errors */
     host->ecb[ecbno].dir = direction;
     host->ecb[ecbno].ars = 1;  /* Yes, get the sense on an error */
@@ -449,7 +449,7 @@
 #define LOOPCNT_WARN 10		/* excessive mbxout wait -> syslog-msg */
 #define LOOPCNT_MAX 1000000	/* mbxout deadlock -> panic() after ~ 2 sec. */
 	int loopcnt;
-	unsigned int base = SCpnt->host->io_port;
+	unsigned int base = SCpnt->device->host->io_port;
 	DEB(printk("aha1740[%d] critical section\n",ecbno));
 
 	spin_lock_irqsave(&aha1740_lock, flags);

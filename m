Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315300AbSEGEKO>; Tue, 7 May 2002 00:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315297AbSEGEKN>; Tue, 7 May 2002 00:10:13 -0400
Received: from gear.torque.net ([204.138.244.1]:37128 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S315296AbSEGEKL>;
	Tue, 7 May 2002 00:10:11 -0400
Message-ID: <3CD74E41.D39C1F23@torque.net>
Date: Mon, 06 May 2002 23:47:13 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: angus <angus@mcm.net>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.5.14 error: ini9100u.c
In-Reply-To: <1020675649.20692.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

angus wrote:
> 
> Just a bug report of compilation which perdure since several 2.5 release
> concerning the driver of initio scsi card and which prevents me from
> testing any 2.5.x :(

Angus,
The following patch makes that driver compile ok. Can you
report back whether it works or not (as I don't have
that adapter to test).

Doug Gilbert


--- linux/drivers/scsi/ini9100u.h	Thu Dec 20 17:38:10 2001
+++ linux/drivers/scsi/ini9100u.h2514hak	Mon May  6 23:38:10 2002
@@ -82,8 +82,11 @@
 extern int i91u_release(struct Scsi_Host *);
 extern int i91u_command(Scsi_Cmnd *);
 extern int i91u_queue(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
+#if 0
 extern int i91u_abort(Scsi_Cmnd *);
 extern int i91u_reset(Scsi_Cmnd *, unsigned int);
+#endif
+static int i91u_eh_bus_reset(Scsi_Cmnd * SCpnt);
 extern int i91u_biosparam(Scsi_Disk *, kdev_t, int *);	/*for linux v2.0 */
 
 #define i91u_REVID "Initio INI-9X00U/UW SCSI device driver; Revision: 1.03g"
@@ -102,10 +105,8 @@
  	eh_strategy_handler: NULL, \
  	eh_abort_handler: NULL, \
  	eh_device_reset_handler: NULL, \
- 	eh_bus_reset_handler: NULL, \
+ 	eh_bus_reset_handler: i91u_eh_bus_reset, \
  	eh_host_reset_handler: NULL, \
-	abort:		i91u_abort, \
-	reset:		i91u_reset, \
 	slave_attach:	NULL, \
 	bios_param:	i91u_biosparam, \
 	can_queue:	1, \
--- linux/drivers/scsi/ini9100u.c	Sun Feb 10 23:51:42 2002
+++ linux/drivers/scsi/ini9100u.c2514hak	Mon May  6 23:39:28 2002
@@ -108,7 +108,7 @@
 
 #define CVT_LINUX_VERSION(V,P,S)        (V * 65536 + P * 256 + S)
 
-#error Please convert me to Documentation/DMA-mapping.txt
+/* #error Please convert me to Documentation/DMA-mapping.txt */
 
 #ifndef LINUX_VERSION_CODE
 #include <linux/version.h>
@@ -491,7 +491,9 @@
 	if (SCpnt->use_sg) {
 		pSrbSG = (struct scatterlist *) SCpnt->request_buffer;
 		if (SCpnt->use_sg == 1) {	/* If only one entry in the list *//*      treat it as regular I/O */
-			pSCB->SCB_BufPtr = (U32) VIRT_TO_BUS(pSrbSG->address);
+			pSCB->SCB_BufPtr = (U32) VIRT_TO_BUS(
+				(unsigned char *)page_address(pSrbSG->page) + 
+				pSrbSG->offset);
 			TotalLen = pSrbSG->length;
 			pSCB->SCB_SGLen = 0;
 		} else {	/* Assign SG physical address   */
@@ -500,7 +502,9 @@
 			for (i = 0, TotalLen = 0, pSG = &pSCB->SCB_SGList[0];	/* 1.01g */
 			     i < SCpnt->use_sg;
 			     i++, pSG++, pSrbSG++) {
-				pSG->SG_Ptr = (U32) VIRT_TO_BUS(pSrbSG->address);
+				pSG->SG_Ptr = (U32) VIRT_TO_BUS(
+				  (unsigned char *)page_address(pSrbSG->page) + 
+				  pSrbSG->offset);
 				TotalLen += pSG->SG_Len = pSrbSG->length;
 			}
 			pSCB->SCB_SGLen = i;
@@ -552,6 +556,7 @@
 	return -1;
 }
 
+#if 0
 /*
  *  Abort a queued command
  *  (commands that are on the bus can't be aborted easily)
@@ -579,6 +584,16 @@
 	else
 		return tul_device_reset(pHCB, (ULONG) SCpnt, SCpnt->target, reset_flags);
 }
+#endif
+
+static int i91u_eh_bus_reset(Scsi_Cmnd * SCpnt)
+{
+	HCS *pHCB;
+
+        pHCB = (HCS *) SCpnt->host->base;
+	tul_reset_scsi_bus(pHCB);
+	return SUCCESS;
+}
 
 /*
  * Return the "logical geometry"


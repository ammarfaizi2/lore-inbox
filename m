Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbUKOCrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUKOCrT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbUKOCnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:43:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:521 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261487AbUKOCmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:42:00 -0500
Date: Mon, 15 Nov 2004 03:29:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI qlogicfc.c: some cleanups
Message-ID: <20041115022953.GY2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups:
- make some needlessly global functions static
- remove qlogicfc.h since it doesn't contain much
- remove the unused function isp2x00_reset

Please review especially the latter two points.


diffstat output:
 drivers/scsi/qlogicfc.c |   62 ++++++++++++-------------------
 drivers/scsi/qlogicfc.h |   80 ----------------------------------------
 2 files changed, 25 insertions(+), 117 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/qlogicfc.h	2004-11-13 23:01:28.000000000 +0100
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,80 +0,0 @@
-/*
- * QLogic ISP2x00 SCSI-FCP
- * 
- * Written by Erik H. Moe, ehm@cris.com
- * Copyright 1995, Erik H. Moe
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2, or (at your option) any
- * later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
-
-/* Renamed and updated to 1.3.x by Michael Griffith <grif@cs.ucr.edu> */
-
-/* This is a version of the isp1020 driver which was modified by
- * Chris Loveland <cwl@iol.unh.edu> to support the isp2x00
- */
-
-
-/*
- * $Date: 1995/09/22 02:32:56 $
- * $Revision: 0.5 $
- *
- * $Log: isp1020.h,v $
- * Revision 0.5  1995/09/22  02:32:56  root
- * do auto request sense
- *
- * Revision 0.4  1995/08/07  04:48:28  root
- * supply firmware with driver.
- * numerous bug fixes/general cleanup of code.
- *
- * Revision 0.3  1995/07/16  16:17:16  root
- * added reset/abort code.
- *
- * Revision 0.2  1995/06/29  03:19:43  root
- * fixed biosparam.
- * added queue protocol.
- *
- * Revision 0.1  1995/06/25  01:56:13  root
- * Initial release.
- *
- */
-
-#ifndef _QLOGICFC_H
-#define _QLOGICFC_H
-
-/*
- * With the qlogic interface, every queue slot can hold a SCSI
- * command with up to 2 scatter/gather entries.  If we need more
- * than 2 entries, continuation entries can be used that hold
- * another 5 entries each.  Unlike for other drivers, this means
- * that the maximum number of scatter/gather entries we can
- * support at any given time is a function of the number of queue
- * slots available.  That is, host->can_queue and host->sg_tablesize
- * are dynamic and _not_ independent.  This all works fine because
- * requests are queued serially and the scatter/gather limit is
- * determined for each queue request anew.
- */
-
-#define DATASEGS_PER_COMMAND 2
-#define DATASEGS_PER_CONT 5
-
-#define QLOGICFC_REQ_QUEUE_LEN 255     /* must be power of two - 1 */
-#define QLOGICFC_MAX_SG(ql)	(DATASEGS_PER_COMMAND + (((ql) > 0) ? DATASEGS_PER_CONT*((ql) - 1) : 0))
-#define QLOGICFC_CMD_PER_LUN    8
-
-int isp2x00_detect(Scsi_Host_Template *);
-int isp2x00_release(struct Scsi_Host *);
-const char * isp2x00_info(struct Scsi_Host *);
-int isp2x00_queuecommand(Scsi_Cmnd *, void (* done)(Scsi_Cmnd *));
-int isp2x00_abort(Scsi_Cmnd *);
-int isp2x00_reset(Scsi_Cmnd *, unsigned int);
-int isp2x00_biosparam(struct scsi_device *, struct block_device *,
-		sector_t, int[]);
-#endif /* _QLOGICFC_H */
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/qlogicfc.c.old	2004-11-13 22:57:07.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/qlogicfc.c	2004-11-13 23:14:30.000000000 +0100
@@ -71,7 +71,25 @@
 #define pci64_dma_build(hi,lo) \
 	((dma_addr_t)(((u64)(lo))|(((u64)(hi))<<32)))
 
-#include "qlogicfc.h"
+/*
+ * With the qlogic interface, every queue slot can hold a SCSI
+ * command with up to 2 scatter/gather entries.  If we need more
+ * than 2 entries, continuation entries can be used that hold
+ * another 5 entries each.  Unlike for other drivers, this means
+ * that the maximum number of scatter/gather entries we can
+ * support at any given time is a function of the number of queue
+ * slots available.  That is, host->can_queue and host->sg_tablesize
+ * are dynamic and _not_ independent.  This all works fine because
+ * requests are queued serially and the scatter/gather limit is
+ * determined for each queue request anew.
+ */
+
+#define DATASEGS_PER_COMMAND 2
+#define DATASEGS_PER_CONT 5
+
+#define QLOGICFC_REQ_QUEUE_LEN 255     /* must be power of two - 1 */
+#define QLOGICFC_MAX_SG(ql)	(DATASEGS_PER_COMMAND + (((ql) > 0) ? DATASEGS_PER_CONT*((ql) - 1) : 0))
+#define QLOGICFC_CMD_PER_LUN    8
 
 /* Configuration section **************************************************** */
 
@@ -693,7 +711,7 @@
 }
 
 
-int isp2x00_detect(Scsi_Host_Template * tmpt)
+static int isp2x00_detect(Scsi_Host_Template * tmpt)
 {
 	int hosts = 0;
 	unsigned long wait_time;
@@ -1083,7 +1101,7 @@
 #endif				/* ISP2x00_FABRIC */
 
 
-int isp2x00_release(struct Scsi_Host *host)
+static int isp2x00_release(struct Scsi_Host *host)
 {
 	struct isp2x00_hostdata *hostdata;
 	dma_addr_t busaddr;
@@ -1107,7 +1125,7 @@
 }
 
 
-const char *isp2x00_info(struct Scsi_Host *host)
+static const char *isp2x00_info(struct Scsi_Host *host)
 {
 	static char buf[80];
 	struct isp2x00_hostdata *hostdata;
@@ -1132,7 +1150,7 @@
  * interrupt handler may call this routine as part of
  * request-completion handling).
  */
-int isp2x00_queuecommand(Scsi_Cmnd * Cmnd, void (*done) (Scsi_Cmnd *))
+static int isp2x00_queuecommand(Scsi_Cmnd * Cmnd, void (*done) (Scsi_Cmnd *))
 {
 	int i, sg_count, n, num_free;
 	u_int in_ptr, out_ptr;
@@ -1697,7 +1715,7 @@
 }
 
 
-int isp2x00_abort(Scsi_Cmnd * Cmnd)
+static int isp2x00_abort(Scsi_Cmnd * Cmnd)
 {
 	u_short param[8];
 	int i;
@@ -1755,37 +1773,7 @@
 }
 
 
-int isp2x00_reset(Scsi_Cmnd * Cmnd, unsigned int reset_flags)
-{
-	u_short param[8];
-	struct Scsi_Host *host;
-	struct isp2x00_hostdata *hostdata;
-	int return_status = SCSI_RESET_SUCCESS;
-
-	ENTER("isp2x00_reset");
-
-	host = Cmnd->device->host;
-	hostdata = (struct isp2x00_hostdata *) host->hostdata;
-	param[0] = MBOX_BUS_RESET;
-	param[1] = 3;
-
-	isp2x00_disable_irqs(host);
-
-	isp2x00_mbox_command(host, param);
-
-	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		printk("qlogicfc%d : scsi bus reset failure: %x\n", hostdata->host_id, param[0]);
-		return_status = SCSI_RESET_ERROR;
-	}
-	isp2x00_enable_irqs(host);
-
-	LEAVE("isp2x00_reset");
-
-	return return_status;
-}
-
-
-int isp2x00_biosparam(struct scsi_device *sdev, struct block_device *n,
+static int isp2x00_biosparam(struct scsi_device *sdev, struct block_device *n,
 		sector_t capacity, int ip[])
 {
 	int size = capacity;


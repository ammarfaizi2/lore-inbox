Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbUKODKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbUKODKR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbUKODFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:05:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29449 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261481AbUKOCnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:43:06 -0500
Date: Mon, 15 Nov 2004 03:32:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI qlogicisp.c: some cleanups
Message-ID: <20041115023217.GZ2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups:
- make some needlessly global functions static
- remove qlogicisp.h since it doesn't contain much
- remove the unused functions isp1020_abort and isp1020_reset

Please review especially the latter two points.


diffstat output:
 drivers/scsi/qlogicisp.c |   99 +++++++--------------------------------
 drivers/scsi/qlogicisp.h |   69 ---------------------------
 2 files changed, 20 insertions(+), 148 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/qlogicisp.h	2004-11-13 23:03:31.000000000 +0100
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,69 +0,0 @@
-/*
- * QLogic ISP1020 Intelligent SCSI Processor Driver (PCI)
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
-#ifndef _QLOGICISP_H
-#define _QLOGICISP_H
-
-/*
- * With the qlogic interface, every queue slot can hold a SCSI
- * command with up to 4 scatter/gather entries.  If we need more
- * than 4 entries, continuation entries can be used that hold
- * another 7 entries each.  Unlike for other drivers, this means
- * that the maximum number of scatter/gather entries we can
- * support at any given time is a function of the number of queue
- * slots available.  That is, host->can_queue and host->sg_tablesize
- * are dynamic and _not_ independent.  This all works fine because
- * requests are queued serially and the scatter/gather limit is
- * determined for each queue request anew.
- */
-#define QLOGICISP_REQ_QUEUE_LEN	63	/* must be power of two - 1 */
-#define QLOGICISP_MAX_SG(ql)	(4 + ((ql) > 0) ? 7*((ql) - 1) : 0)
-
-int isp1020_detect(Scsi_Host_Template *);
-int isp1020_release(struct Scsi_Host *);
-const char * isp1020_info(struct Scsi_Host *);
-int isp1020_queuecommand(Scsi_Cmnd *, void (* done)(Scsi_Cmnd *));
-int isp1020_abort(Scsi_Cmnd *);
-int isp1020_reset(Scsi_Cmnd *, unsigned int);
-int isp1020_biosparam(struct scsi_device *, struct block_device *,
-		sector_t, int[]);
-#endif /* _QLOGICISP_H */
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/qlogicisp.c.old	2004-11-13 23:00:09.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/qlogicisp.c	2004-11-13 23:14:07.000000000 +0100
@@ -37,7 +37,21 @@
 #include <asm/byteorder.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
-#include "qlogicisp.h"
+
+/*
+ * With the qlogic interface, every queue slot can hold a SCSI
+ * command with up to 4 scatter/gather entries.  If we need more
+ * than 4 entries, continuation entries can be used that hold
+ * another 7 entries each.  Unlike for other drivers, this means
+ * that the maximum number of scatter/gather entries we can
+ * support at any given time is a function of the number of queue
+ * slots available.  That is, host->can_queue and host->sg_tablesize
+ * are dynamic and _not_ independent.  This all works fine because
+ * requests are queued serially and the scatter/gather limit is
+ * determined for each queue request anew.
+ */
+#define QLOGICISP_REQ_QUEUE_LEN	63	/* must be power of two - 1 */
+#define QLOGICISP_MAX_SG(ql)	(4 + ((ql) > 0) ? 7*((ql) - 1) : 0)
 
 /* Configuration section *****************************************************/
 
@@ -655,7 +669,7 @@
 }
 
 
-int isp1020_detect(Scsi_Host_Template *tmpt)
+static int isp1020_detect(Scsi_Host_Template *tmpt)
 {
 	int hosts = 0;
 	struct Scsi_Host *host;
@@ -736,7 +750,7 @@
 }
 
 
-int isp1020_release(struct Scsi_Host *host)
+static int isp1020_release(struct Scsi_Host *host)
 {
 	struct isp1020_hostdata *hostdata;
 
@@ -757,7 +771,7 @@
 }
 
 
-const char *isp1020_info(struct Scsi_Host *host)
+static const char *isp1020_info(struct Scsi_Host *host)
 {
 	static char buf[80];
 	struct isp1020_hostdata *hostdata;
@@ -783,7 +797,7 @@
  * interrupt handler may call this routine as part of
  * request-completion handling).
  */
-int isp1020_queuecommand(Scsi_Cmnd *Cmnd, void (*done)(Scsi_Cmnd *))
+static int isp1020_queuecommand(Scsi_Cmnd *Cmnd, void (*done)(Scsi_Cmnd *))
 {
 	int i, n, num_free;
 	u_int in_ptr, out_ptr;
@@ -1161,80 +1175,7 @@
 }
 
 
-int isp1020_abort(Scsi_Cmnd *Cmnd)
-{
-	u_short param[6];
-	struct Scsi_Host *host;
-	struct isp1020_hostdata *hostdata;
-	int return_status = SCSI_ABORT_SUCCESS;
-	u_int cmd_cookie;
-	int i;
-
-	ENTER("isp1020_abort");
-
-	host = Cmnd->device->host;
-	hostdata = (struct isp1020_hostdata *) host->hostdata;
-
-	for (i = 0; i < QLOGICISP_REQ_QUEUE_LEN + 1; i++)
-		if (hostdata->cmd_slots[i] == Cmnd)
-			break;
-	cmd_cookie = i;
-
-	isp1020_disable_irqs(host);
-
-	param[0] = MBOX_ABORT;
-	param[1] = (((u_short) Cmnd->device->id) << 8) | Cmnd->device->lun;
-	param[2] = cmd_cookie >> 16;
-	param[3] = cmd_cookie & 0xffff;
-
-	isp1020_mbox_command(host, param);
-
-	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		printk("qlogicisp : scsi abort failure: %x\n", param[0]);
-		return_status = SCSI_ABORT_ERROR;
-	}
-
-	isp1020_enable_irqs(host);
-
-	LEAVE("isp1020_abort");
-
-	return return_status;
-}
-
-
-int isp1020_reset(Scsi_Cmnd *Cmnd, unsigned int reset_flags)
-{
-	u_short param[6];
-	struct Scsi_Host *host;
-	struct isp1020_hostdata *hostdata;
-	int return_status = SCSI_RESET_SUCCESS;
-
-	ENTER("isp1020_reset");
-
-	host = Cmnd->device->host;
-	hostdata = (struct isp1020_hostdata *) host->hostdata;
-
-	param[0] = MBOX_BUS_RESET;
-	param[1] = hostdata->host_param.bus_reset_delay;
-
-	isp1020_disable_irqs(host);
-
-	isp1020_mbox_command(host, param);
-
-	if (param[0] != MBOX_COMMAND_COMPLETE) {
-		printk("qlogicisp : scsi bus reset failure: %x\n", param[0]);
-		return_status = SCSI_RESET_ERROR;
-	}
-
-	isp1020_enable_irqs(host);
-
-	LEAVE("isp1020_reset");
-
-	return return_status;
-}
-
-
-int isp1020_biosparam(struct scsi_device *sdev, struct block_device *n,
+static int isp1020_biosparam(struct scsi_device *sdev, struct block_device *n,
 		sector_t capacity, int ip[])
 {
 	int size = capacity;



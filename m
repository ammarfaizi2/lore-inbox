Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWIFItI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWIFItI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 04:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWIFItH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 04:49:07 -0400
Received: from server6.greatnet.de ([83.133.96.26]:51914 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750700AbWIFItD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 04:49:03 -0400
Message-ID: <44FE8BAC.1030004@nachtwindheim.de>
Date: Wed, 06 Sep 2006 10:49:48 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi-driver ultrastore replace Scsi_Cmnd with struct scsi_cmnd
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Replaces the typedef'd Scsi_Cmnd with struct scsi_cmnd.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc5-mm1/drivers/scsi/ultrastor.c	2006-09-03 16:36:04.468628760 +0200
+++ linux/drivers/scsi/ultrastor.c	2006-09-01 19:18:29.000000000 +0200
@@ -196,8 +196,8 @@
   u32 sense_data PACKED;
   /* The following fields are for software only.  They are included in
      the MSCP structure because they are associated with SCSI requests.  */
-  void (*done)(Scsi_Cmnd *);
-  Scsi_Cmnd *SCint;
+  void (*done) (struct scsi_cmnd *);
+  struct scsi_cmnd *SCint;
   ultrastor_sg_list sglist[ULTRASTOR_24F_MAX_SG]; /* use larger size for 24F */
 };
 
@@ -289,7 +289,7 @@
 
 static void ultrastor_interrupt(int, void *, struct pt_regs *);
 static irqreturn_t do_ultrastor_interrupt(int, void *, struct pt_regs *);
-static inline void build_sg_list(struct mscp *, Scsi_Cmnd *SCpnt);
+static inline void build_sg_list(struct mscp *, struct scsi_cmnd *SCpnt);
 
 
 /* Always called with host lock held */
@@ -673,7 +673,7 @@
     return buf;
 }
 
-static inline void build_sg_list(struct mscp *mscp, Scsi_Cmnd *SCpnt)
+static inline void build_sg_list(struct mscp *mscp, struct scsi_cmnd *SCpnt)
 {
 	struct scatterlist *sl;
 	long transfer_length = 0;
@@ -694,7 +694,8 @@
 	mscp->transfer_data_length = transfer_length;
 }
 
-static int ultrastor_queuecommand(Scsi_Cmnd *SCpnt, void (*done)(Scsi_Cmnd *))
+static int ultrastor_queuecommand(struct scsi_cmnd *SCpnt,
+				void (*done) (struct scsi_cmnd *))
 {
     struct mscp *my_mscp;
 #if ULTRASTOR_MAX_CMDS > 1
@@ -833,7 +834,7 @@
 
  */
 
-static int ultrastor_abort(Scsi_Cmnd *SCpnt)
+static int ultrastor_abort(struct scsi_cmnd *SCpnt)
 {
 #if ULTRASTOR_DEBUG & UD_ABORT
     char out[108];
@@ -843,7 +844,7 @@
     unsigned int mscp_index;
     unsigned char old_aborted;
     unsigned long flags;
-    void (*done)(Scsi_Cmnd *);
+    void (*done)(struct scsi_cmnd *);
     struct Scsi_Host *host = SCpnt->device->host;
 
     if(config.slot) 
@@ -960,7 +961,7 @@
     return SUCCESS;
 }
 
-static int ultrastor_host_reset(Scsi_Cmnd * SCpnt)
+static int ultrastor_host_reset(struct scsi_cmnd * SCpnt)
 {
     unsigned long flags;
     int i;
@@ -1045,8 +1046,8 @@
     unsigned int mscp_index;
 #endif
     struct mscp *mscp;
-    void (*done)(Scsi_Cmnd *);
-    Scsi_Cmnd *SCtmp;
+    void (*done) (struct scsi_cmnd *);
+    struct scsi_cmnd *SCtmp;
 
 #if ULTRASTOR_MAX_CMDS == 1
     mscp = &config.mscp[0];
@@ -1079,7 +1080,7 @@
 	    return;
 	}
 	if (icm_status == 3) {
-	    void (*done)(Scsi_Cmnd *) = mscp->done;
+	    void (*done)(struct scsi_cmnd *) = mscp->done;
 	    if (done) {
 		mscp->done = NULL;
 		mscp->SCint->result = DID_ABORT << 16;
--- linux-2.6.18-rc5-mm1/drivers/scsi/ultrastor.h	2006-06-18 03:49:35.000000000 +0200
+++ linux/drivers/scsi/ultrastor.h	2006-09-01 19:13:50.366267680 +0200
@@ -14,11 +14,13 @@
 #define _ULTRASTOR_H
 
 static int ultrastor_detect(struct scsi_host_template *);
-static const char *ultrastor_info(struct Scsi_Host * shpnt);
-static int ultrastor_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-static int ultrastor_abort(Scsi_Cmnd *);
-static int ultrastor_host_reset(Scsi_Cmnd *);
-static int ultrastor_biosparam(struct scsi_device *, struct block_device *, sector_t, int *);
+static const char *ultrastor_info(struct Scsi_Host *shpnt);
+static int ultrastor_queuecommand(struct scsi_cmnd *,
+				void (*done)(struct scsi_cmnd *));
+static int ultrastor_abort(struct scsi_cmnd *);
+static int ultrastor_host_reset(struct scsi_cmnd *);
+static int ultrastor_biosparam(struct scsi_device *, struct block_device *,
+				sector_t, int *);
 
 
 #define ULTRASTOR_14F_MAX_SG 16



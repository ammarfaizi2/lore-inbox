Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSJQHBG>; Thu, 17 Oct 2002 03:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261838AbSJQHBG>; Thu, 17 Oct 2002 03:01:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:40637 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261836AbSJQHBB>; Thu, 17 Oct 2002 03:01:01 -0400
Date: Thu, 17 Oct 2002 00:08:14 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi_debug new scan fix
Message-ID: <20021017070814.GA2410@beaverton.ibm.com>
Mail-Followup-To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you use scsi_debug the patch below fixes a problem that has existed
since the updated scan code was merged in. scsi_debug previously assumed
that the scsi_device used to probe and the device permanently added to the
host_queue would be the same. This caused scsi_debug to allocate some
internal data and key it off the scsi_device pointer for later use.  This
resulted in scsi_debug failing all IO post scanning. This patch corrects
this problem.

Note:
	Douglas Gilbert is the maintainer of this driver.
	dougg@gear.torque.net
	http://www.torque.net/sg/

	During Douglas Gilbert's time-off he connects when he can so it
	maybe a bit until he can address this.

	In the interim this patch makes scsi_debug functional.


The full patch is available at:
http://www-124.ibm.com/storageio/patches/2.5/scsi-debug
-andmike
--
Michael Anderson
andmike@us.ibm.com

 scsi_debug.c |   59 +++++++++++++++++++++++++++++++----------------------------
 1 files changed, 31 insertions(+), 28 deletions(-)
------

diff -Nru a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
--- a/drivers/scsi/scsi_debug.c	Thu Oct 17 00:00:50 2002
+++ b/drivers/scsi/scsi_debug.c	Thu Oct 17 00:00:50 2002
@@ -108,9 +108,13 @@
 #define SDEBUG_SENSE_LEN 32
 
 struct sdebug_dev_info {
-	Scsi_Device * sdp;
 	unsigned char sense_buff[SDEBUG_SENSE_LEN];	/* weak nexus */
+	unsigned int channel;
+	unsigned int target;
+	unsigned int lun;
+	struct Scsi_Host *host;
 	char reset;
+	char used;
 };
 static struct sdebug_dev_info * devInfop;
 
@@ -154,7 +158,7 @@
 static int resp_report_luns(unsigned char * cmd, unsigned char * buff,
 			    int bufflen, struct sdebug_dev_info * devip);
 static void timer_intr_handler(unsigned long);
-static struct sdebug_dev_info * devInfoReg(Scsi_Device * sdp);
+static struct sdebug_dev_info * devInfoReg(Scsi_Cmnd *scmd);
 static void mk_sense_buffer(struct sdebug_dev_info * devip, int key, 
 			    int asc, int asq, int inbandLen);
 static int check_reset(Scsi_Cmnd * SCpnt, struct sdebug_dev_info * devip);
@@ -222,7 +226,7 @@
 		return schedule_resp(SCpnt, NULL, done, 0, 0);
         }
 
-	if ((target > driver_template.this_id) || (SCpnt->lun != 0))
+	if (SCpnt->lun != 0)
 		return schedule_resp(SCpnt, NULL, done, 
 				     DID_NO_CONNECT << 16, 0);
 #if 0
@@ -230,14 +234,10 @@
 	       (int)SCpnt->device->host->host_no, (int)SCpnt->device->id,
 	       SCpnt->device, (int)*cmd);
 #endif
-	if (NULL == SCpnt->device->hostdata) {
-		devip = devInfoReg(SCpnt->device);
-		if (NULL == devip)
-			return schedule_resp(SCpnt, NULL, done, 
-					     DID_NO_CONNECT << 16, 0);
-		SCpnt->device->hostdata = devip;
-	}
-	devip = SCpnt->device->hostdata;
+	devip = devInfoReg(SCpnt);
+	if (NULL == devip)
+		return schedule_resp(SCpnt, NULL, done, 
+				     DID_NO_CONNECT << 16, 0);
 
         if ((SCSI_DEBUG_OPT_EVERY_NTH & scsi_debug_opts) &&
             (scsi_debug_every_nth > 0) &&
@@ -474,8 +474,8 @@
 		int dev_id_num, len;
 		char dev_id_str[6];
 		
-		dev_id_num = ((devip->sdp->host->host_no + 1) * 1000) + 
-			      devip->sdp->id;
+		dev_id_num = ((devip->host->host_no + 1) * 1000) + 
+			      devip->target;
 		len = snprintf(dev_id_str, 6, "%d", dev_id_num);
 		len = (len > 6) ? 6 : len;
 		if (0 == cmd[2]) { /* supported vital product data pages */
@@ -870,21 +870,28 @@
 	return 0;
 }
 
-static struct sdebug_dev_info * devInfoReg(Scsi_Device * sdp)
+static struct sdebug_dev_info * devInfoReg(Scsi_Cmnd *scmd)
 {
 	int k;
 	struct sdebug_dev_info * devip;
 
 	for (k = 0; k < scsi_debug_num_devs; ++k) {
 		devip = &devInfop[k];
-		if (devip->sdp == sdp)
+		if ((devip->channel == scmd->channel) &&
+		    (devip->target == scmd->target) &&
+		    (devip->lun == scmd->lun) &&
+		    (devip->host == scmd->host))
 			return devip;
 	}
 	for (k = 0; k < scsi_debug_num_devs; ++k) {
 		devip = &devInfop[k];
-		if (NULL == devip->sdp) {
-			devip->sdp = sdp;
+		if (!devip->used) {
+			devip->channel = scmd->channel;
+			devip->target = scmd->target;
+			devip->lun = scmd->lun;
+			devip->host = scmd->host;
 			devip->reset = 1;
+			devip->used = 1;
 			memset(devip->sense_buff, 0, SDEBUG_SENSE_LEN);
 			devip->sense_buff[0] = 0x70;
 			return devip;
@@ -934,19 +941,15 @@
 
 static int scsi_debug_device_reset(Scsi_Cmnd * SCpnt)
 {
-	Scsi_Device * sdp;
-	int k;
+	struct sdebug_dev_info * devip;
 
 	if (SCSI_DEBUG_OPT_NOISE & scsi_debug_opts)
 		printk(KERN_INFO "scsi_debug: device_reset\n");
 	++num_dev_resets;
-	if (SCpnt && ((sdp = SCpnt->device))) {
-		for (k = 0; k < scsi_debug_num_devs; ++k) {
-			if (sdp->hostdata == (devInfop + k))
-				break;
-		}
-		if (k < scsi_debug_num_devs)
-			devInfop[k].reset = 1;
+	if (SCpnt) {
+		devip = devInfoReg(SCpnt);
+		if (devip)
+			devip->reset = 1;
 	}
 	return SUCCESS;
 }
@@ -960,9 +963,9 @@
 	if (SCSI_DEBUG_OPT_NOISE & scsi_debug_opts)
 		printk(KERN_INFO "scsi_debug: bus_reset\n");
 	++num_bus_resets;
-	if (SCpnt && ((sdp = SCpnt->device)) && ((hp = sdp->host))) {
+	if (SCpnt && ((sdp = SCpnt->device)) && ((hp = SCpnt->host))) {
 		for (k = 0; k < scsi_debug_num_devs; ++k) {
-			if (hp == devInfop[k].sdp->host)
+			if (hp == devInfop[k].host)
 				devInfop[k].reset = 1;
 		}
 	}

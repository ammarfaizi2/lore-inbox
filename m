Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267372AbUHYDvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267372AbUHYDvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 23:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUHYDvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 23:51:33 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:38604 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267310AbUHYDvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 23:51:06 -0400
Subject: Re: 2.6.8.1-mm3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Patrick Mansfield <patmans@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040821214733.GE9660@parcelfarce.linux.theplanet.co.uk>
References: <200408211838.i7LIcUdl025108@harpo.it.uu.se>
	<20040821191417.GA3402@beaverton.ibm.com>
	<1093116298.2092.388.camel@mulgrave> 
	<20040821214733.GE9660@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Aug 2004 23:50:33 -0400
Message-Id: <1093405836.2206.447.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 17:47, Matthew Wilcox wrote:
> I prefer the former, something like
> 
> int scsi_test_unit_ready(struct scsi_device *sdev);

OK, how about the attached.  It seems to work for me, but then I don't
have any of the problem devices ...

James

===== drivers/scsi/scsi_ioctl.c 1.29 vs edited =====
--- 1.29/drivers/scsi/scsi_ioctl.c	2004-08-19 16:11:54 -05:00
+++ edited/drivers/scsi/scsi_ioctl.c	2004-08-24 22:34:39 -05:00
@@ -432,12 +432,8 @@
 	case SCSI_IOCTL_DOORUNLOCK:
 		return scsi_set_medium_removal(sdev, SCSI_REMOVAL_ALLOW);
 	case SCSI_IOCTL_TEST_UNIT_READY:
-		scsi_cmd[0] = TEST_UNIT_READY;
-		scsi_cmd[1] = 0;
-		scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
-		scsi_cmd[4] = 0;
-		return ioctl_internal_command(sdev, scsi_cmd,
-				   IOCTL_NORMAL_TIMEOUT, NORMAL_RETRIES);
+		return scsi_test_unit_ready(sdev, IOCTL_NORMAL_TIMEOUT,
+					    NORMAL_RETRIES);
 	case SCSI_IOCTL_START_UNIT:
 		scsi_cmd[0] = START_STOP;
 		scsi_cmd[1] = 0;
===== drivers/scsi/scsi_lib.c 1.130 vs edited =====
--- 1.130/drivers/scsi/scsi_lib.c	2004-08-23 03:14:46 -05:00
+++ edited/drivers/scsi/scsi_lib.c	2004-08-24 22:08:51 -05:00
@@ -1572,6 +1572,34 @@
 	return ret;
 }
 
+int
+scsi_test_unit_ready(struct scsi_device *sdev, int timeout, int retries)
+{
+	struct scsi_request *sreq;
+	char cmd[] = {
+		TEST_UNIT_READY, 0, 0, 0, 0, 0,
+	};
+	int result;
+	
+	sreq = scsi_allocate_request(sdev, GFP_KERNEL);
+	if (!sreq)
+		return -ENOMEM;
+
+		sreq->sr_data_direction = DMA_NONE;
+        scsi_wait_req(sreq, cmd, NULL, 0, timeout, retries);
+
+	if ((driver_byte(sreq->sr_result) & DRIVER_SENSE)
+	    && (sreq->sr_sense_buffer[2] & 0x0f) == UNIT_ATTENTION
+	    && sdev->removable) {
+		sdev->changed = 1;
+		sreq->sr_result = 0;
+	}
+	result = sreq->sr_result;
+	scsi_release_request(sreq);
+	return result;
+}
+EXPORT_SYMBOL(scsi_test_unit_ready);
+
 /**
  *	scsi_device_set_state - Take the given device through the device
  *		state model.
===== drivers/scsi/sd.c 1.157 vs edited =====
--- 1.157/drivers/scsi/sd.c	2004-08-24 18:09:03 -05:00
+++ edited/drivers/scsi/sd.c	2004-08-24 22:36:10 -05:00
@@ -648,7 +648,7 @@
 	 */
 	retval = -ENODEV;
 	if (scsi_block_when_processing_errors(sdp))
-		retval = scsi_ioctl(sdp, SCSI_IOCTL_TEST_UNIT_READY, NULL);
+		retval = scsi_test_unit_ready(sdp, SD_TIMEOUT, SD_MAX_RETRIES);
 
 	/*
 	 * Unable to test, unit probably not ready.   This usually
===== drivers/scsi/sr.c 1.114 vs edited =====
--- 1.114/drivers/scsi/sr.c	2004-08-12 19:03:53 -05:00
+++ edited/drivers/scsi/sr.c	2004-08-24 22:39:41 -05:00
@@ -183,7 +183,7 @@
 		return -EINVAL;
 	}
 
-	retval = scsi_ioctl(cd->device, SCSI_IOCTL_TEST_UNIT_READY, NULL);
+	retval = scsi_test_unit_ready(cd->device, SR_TIMEOUT, MAX_RETRIES);
 	if (retval) {
 		/* Unable to test, unit probably not ready.  This usually
 		 * means there is no disc in the drive.  Mark as changed,
===== include/scsi/scsi_device.h 1.21 vs edited =====
--- 1.21/include/scsi/scsi_device.h	2004-08-22 20:06:22 -05:00
+++ edited/include/scsi/scsi_device.h	2004-08-24 22:11:48 -05:00
@@ -185,6 +185,8 @@
 extern int scsi_mode_sense(struct scsi_device *sdev, int dbd, int modepage,
 			   unsigned char *buffer, int len, int timeout,
 			   int retries, struct scsi_mode_data *data);
+extern int scsi_test_unit_ready(struct scsi_device *sdev, int timeout,
+				int retries);
 extern int scsi_device_set_state(struct scsi_device *sdev,
 				 enum scsi_device_state state);
 extern int scsi_device_quiesce(struct scsi_device *sdev);


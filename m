Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTEWHKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 03:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTEWHKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 03:10:04 -0400
Received: from hera.cwi.nl ([192.16.191.8]:24769 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263855AbTEWHJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 03:09:42 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 23 May 2003 09:22:44 +0200 (MEST)
Message-Id: <UTC200305230722.h4N7Mid25812.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [patch] scsi: ten -> use_10_for_rw / use_10_for_ms
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the old days, ancient scsi devices understood 6-byte commands
and more recent ones also understood 10-byte commands.
Thus, we had a "ten" flag indicating that 10-byte commands worked.

These days, especially for usb-storage devices, the opposite
sometimes holds - 10-byte commands are supported, but 6-byte commands
are not.

The patch below changes the field ten into the pair of fields
use_10_for_rw, use_10_for_ms set initially when the driver
thinks these are supported. Ifthe device returns ILLEGAL_REQUEST
they are cleared.

This patch obsoletes a large amount of code in usb-storage,
and not only that, once the subsequent patch removes all this
usb-storage code many devices will work that hang today.


Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/scsi.h b/drivers/scsi/scsi.h
--- a/drivers/scsi/scsi.h	Thu May 22 13:17:01 2003
+++ b/drivers/scsi/scsi.h	Fri May 23 10:02:30 2003
@@ -383,9 +383,10 @@
 				 * time. */
 	unsigned was_reset:1;	/* There was a bus reset on the bus for 
 				 * this device */
-	unsigned expecting_cc_ua:1;	/* Expecting a CHECK_CONDITION/UNIT_ATTN
-					 * because we did a bus reset. */
-	unsigned ten:1;		/* support ten byte read / write */
+	unsigned expecting_cc_ua:1; /* Expecting a CHECK_CONDITION/UNIT_ATTN
+				     * because we did a bus reset. */
+	unsigned use_10_for_rw:1; /* first try 10-byte read / write */
+	unsigned use_10_for_ms:1; /* first try 10-byte mode sense/select */
 	unsigned remap:1;	/* support remapping  */
 //	unsigned sync:1;	/* Sync transfer state, managed by host */
 //	unsigned wide:1;	/* WIDE transfer state, managed by host */
@@ -402,10 +403,6 @@
 	container_of(d, struct scsi_device, sdev_driverfs_dev)
 
 
-/*
- * The Scsi_Cmnd structure is used by scsi.c internally, and for communication
- * with low level drivers that support multiple outstanding commands.
- */
 typedef struct scsi_pointer {
 	char *ptr;		/* data pointer */
 	int this_residual;	/* left in this buffer */
@@ -458,12 +455,13 @@
 };
 
 /*
- * FIXME(eric) - one of the great regrets that I have is that I failed to define
- * these structure elements as something like sc_foo instead of foo.  This would
- * make it so much easier to grep through sources and so forth.  I propose that
- * all new elements that get added to these structures follow this convention.
- * As time goes on and as people have the stomach for it, it should be possible to 
- * go back and retrofit at least some of the elements here with with the prefix.
+ * FIXME(eric) - one of the great regrets that I have is that I failed to
+ * define these structure elements as something like sc_foo instead of foo.
+ * This would make it so much easier to grep through sources and so forth.
+ * I propose that all new elements that get added to these structures follow
+ * this convention.  As time goes on and as people have the stomach for it,
+ * it should be possible to go back and retrofit at least some of the elements
+ * here with with the prefix.
  */
 struct scsi_cmnd {
 	int     sc_magic;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	Thu May 22 13:17:01 2003
+++ b/drivers/scsi/scsi_lib.c	Fri May 23 10:02:30 2003
@@ -662,7 +662,6 @@
  *
  *		b) We can just use scsi_requeue_command() here.  This would
  *		   be used if we just wanted to retry, for example.
- *
  */
 void scsi_io_completion(struct scsi_cmnd *cmd, int good_sectors,
 			int block_sectors)
@@ -796,17 +795,20 @@
 				}
 			}
 		}
-		/* If we had an ILLEGAL REQUEST returned, then we may have
-		 * performed an unsupported command.  The only thing this should be
-		 * would be a ten byte read where only a six byte read was supported.
-		 * Also, on a system where READ CAPACITY failed, we have have read
-		 * past the end of the disk.
+		/*
+		 * If we had an ILLEGAL REQUEST returned, then we may have
+		 * performed an unsupported command.  The only thing this
+		 * should be would be a ten byte read where only a six byte
+		 * read was supported.  Also, on a system where READ CAPACITY
+		 * failed, we may have read past the end of the disk.
 		 */
 
 		switch (cmd->sense_buffer[2]) {
 		case ILLEGAL_REQUEST:
-			if (cmd->device->ten) {
-				cmd->device->ten = 0;
+			if (cmd->device->use_10_for_rw &&
+			    (cmd->cmnd[0] == READ_10 ||
+			     cmd->cmnd[0] == WRITE_10)) {
+				cmd->device->use_10_for_rw = 0;
 				/*
 				 * This will cause a retry with a 6-byte
 				 * command.
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Thu May 22 13:17:01 2003
+++ b/drivers/scsi/sd.c	Fri May 23 10:02:30 2003
@@ -320,7 +320,8 @@
 		SCpnt->cmnd[12] = (unsigned char) (this_count >> 8) & 0xff;
 		SCpnt->cmnd[13] = (unsigned char) this_count & 0xff;
 		SCpnt->cmnd[14] = SCpnt->cmnd[15] = 0;
-	} else if (((this_count > 0xff) || (block > 0x1fffff)) || SCpnt->device->ten) {
+	} else if ((this_count > 0xff) || (block > 0x1fffff) ||
+		   SCpnt->device->use_10_for_rw) {
 		if (this_count > 0xffff)
 			this_count = 0xffff;
 
@@ -768,11 +769,14 @@
 			break;
 
 		case ILLEGAL_REQUEST:
-			if (SCpnt->device->ten == 1) {
-				if (SCpnt->cmnd[0] == READ_10 ||
-				    SCpnt->cmnd[0] == WRITE_10)
-					SCpnt->device->ten = 0;
-			}
+			if (SCpnt->device->use_10_for_rw &&
+			    (SCpnt->cmnd[0] == READ_10 ||
+			     SCpnt->cmnd[0] == WRITE_10))
+				SCpnt->device->use_10_for_rw = 0;
+			if (SCpnt->device->use_10_for_ms &&
+			    (SCpnt->cmnd[0] == MODE_SENSE_10 ||
+			     SCpnt->cmnd[0] == MODE_SELECT_10))
+				SCpnt->device->use_10_for_ms = 0;
 			break;
 
 		default:
@@ -1093,16 +1097,29 @@
 	sdkp->device->sector_size = sector_size;
 }
 
+/* called with buffer of length 512 */
 static int
-sd_do_mode_sense6(struct scsi_device *sdp, struct scsi_request *SRpnt,
-		  int dbd, int modepage, unsigned char *buffer, int len) {
-	unsigned char cmd[8];
+sd_do_mode_sense(struct scsi_request *SRpnt, int dbd, int modepage,
+		 unsigned char *buffer, int len) {
+	unsigned char cmd[12];
 
-	memset((void *) &cmd[0], 0, 8);
-	cmd[0] = MODE_SENSE;
+	memset((void *) &cmd[0], 0, 12);
 	cmd[1] = dbd;
 	cmd[2] = modepage;
-	cmd[4] = len;
+
+	if (SRpnt->sr_device->use_10_for_ms) {
+		if (len < 8)
+			len = 8;
+
+		cmd[0] = MODE_SENSE_10;
+		cmd[8] = len;
+	} else {
+		if (len < 4)
+			len = 4;
+
+		cmd[0] = MODE_SENSE;
+		cmd[4] = len;
+	}
 
 	SRpnt->sr_cmd_len = 0;
 	SRpnt->sr_sense_buffer[0] = 0;
@@ -1119,11 +1136,11 @@
 
 /*
  * read write protect setting, if possible - called only in sd_init_onedisk()
+ * called with buffer of length 512
  */
 static void
 sd_read_write_protect_flag(struct scsi_disk *sdkp, char *diskname,
 		   struct scsi_request *SRpnt, unsigned char *buffer) {
-	struct scsi_device *sdp = sdkp->device;
 	int res;
 
 	/*
@@ -1131,7 +1148,7 @@
 	 * We have to start carefully: some devices hang if we ask
 	 * for more than is available.
 	 */
-	res = sd_do_mode_sense6(sdp, SRpnt, 0, 0x3F, buffer, 4);
+	res = sd_do_mode_sense(SRpnt, 0, 0x3F, buffer, 4);
 
 	/*
 	 * Second attempt: ask for page 0
@@ -1139,13 +1156,13 @@
 	 * Sense Key 5: Illegal Request, Sense Code 24: Invalid field in CDB.
 	 */
 	if (res)
-		res = sd_do_mode_sense6(sdp, SRpnt, 0, 0, buffer, 4);
+		res = sd_do_mode_sense(SRpnt, 0, 0, buffer, 4);
 
 	/*
 	 * Third attempt: ask 255 bytes, as we did earlier.
 	 */
 	if (res)
-		res = sd_do_mode_sense6(sdp, SRpnt, 0, 0x3F, buffer, 255);
+		res = sd_do_mode_sense(SRpnt, 0, 0x3F, buffer, 255);
 
 	if (res) {
 		printk(KERN_WARNING
@@ -1161,25 +1178,25 @@
 
 /*
  * sd_read_cache_type - called only from sd_init_onedisk()
+ * called with buffer of length 512
  */
 static void
 sd_read_cache_type(struct scsi_disk *sdkp, char *diskname,
 		   struct scsi_request *SRpnt, unsigned char *buffer) {
-	struct scsi_device *sdp = sdkp->device;
 	int len = 0, res;
 
 	const int dbd = 0x08;	   /* DBD */
 	const int modepage = 0x08; /* current values, cache page */
 
 	/* cautiously ask */
-	res = sd_do_mode_sense6(sdp, SRpnt, dbd, modepage, buffer, 4);
+	res = sd_do_mode_sense(SRpnt, dbd, modepage, buffer, 4);
 
 	if (res == 0) {
 		/* that went OK, now ask for the proper length */
 		len = buffer[0] + 1;
 		if (len > 128)
 			len = 128;
-		res = sd_do_mode_sense6(sdp, SRpnt, dbd, modepage, buffer, len);
+		res = sd_do_mode_sense(SRpnt, dbd, modepage, buffer, len);
 	}
 
 	if (res == 0 && buffer[3] + 6 < len) {
@@ -1278,7 +1295,8 @@
 	if (sdkp->media_present)
 		sd_read_cache_type(sdkp, disk->disk_name, SRpnt, buffer);
 		
-	SRpnt->sr_device->ten = 1;
+	SRpnt->sr_device->use_10_for_rw = 1;
+	SRpnt->sr_device->use_10_for_ms = 0;
 	SRpnt->sr_device->remap = 1;
 
  leave:
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c	Thu May 22 13:17:01 2003
+++ b/drivers/scsi/sr.c	Fri May 23 10:02:30 2003
@@ -559,7 +559,8 @@
 	sprintf(cd->cdi.name, "sr%d", minor);
 
 	sdev->sector_size = 2048;	/* A guess, just in case */
-	sdev->ten = 1;
+	sdev->use_10_for_rw = 1;
+	sdev->use_10_for_ms = 0;
 	sdev->remap = 1;
 
 	/* FIXME: need to handle a get_capabilities failure properly ?? */

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268199AbTALB6d>; Sat, 11 Jan 2003 20:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268197AbTALB6d>; Sat, 11 Jan 2003 20:58:33 -0500
Received: from hera.cwi.nl ([192.16.191.8]:53689 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268196AbTALB6Z>;
	Sat, 11 Jan 2003 20:58:25 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 12 Jan 2003 03:07:09 +0100 (MET)
Message-Id: <UTC200301120207.h0C279Q18364.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] sd.c
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below does two things:
(i) do not try to spin up a CF reader without media
(ii) be careful when asking for the cache parameters mode page

[do not ask for this page when no media are present:
it is meaningless, and some devices react badly if we do;
check the reply so that we do not read past the end of the reply;
first give a small transport length - some USB devices are unhappy
if we ask for more than they provide]

Andries


--- /linux/2.5/linux-2.5.56/linux/drivers/scsi/sd.c	Thu Jan  2 14:32:08 2003
+++ sd.c	Sun Jan 12 01:50:53 2003
@@ -79,7 +79,7 @@
 	u8		media_present;
 	u8		write_prot;
 	unsigned	WCE : 1;	/* state of disk WCE bit */
-	unsigned	RCD : 1;	/* state of disk RCD bit */
+	unsigned	RCD : 1;	/* state of disk RCD bit, unused */
 };
 
 static LIST_HEAD(sd_devlist);
@@ -217,7 +217,7 @@
 	block = SCpnt->request->sector;
 	this_count = SCpnt->request_bufflen >> 9;
 
-	SCSI_LOG_HLQUEUE(1, printk("sd_command_init: disk=%s, block=%llu, "
+	SCSI_LOG_HLQUEUE(1, printk("sd_init_command: disk=%s, block=%llu, "
 			    "count=%d\n", disk->disk_name, (unsigned long long)block, this_count));
 
 	if (!sdp || !sdp->online ||
@@ -809,9 +809,22 @@
 		if (media_not_present(sdkp, SRpnt))
 			return;
 
-		/* Look for devices that return NOT_READY.
-		 * Issue command to spin up drive for these cases. */
-		if (the_result && SRpnt->sr_sense_buffer[2] == NOT_READY) {
+		if (the_result == 0)
+			break;		/* all is well now */
+
+		/*
+		 * If manual intervention is required, or this is an
+		 * absent USB storage device, a spinup is meaningless.
+		 */
+		if (SRpnt->sr_sense_buffer[2] == NOT_READY &&
+		    SRpnt->sr_sense_buffer[12] == 4 /* not ready */ &&
+		    SRpnt->sr_sense_buffer[13] == 3)
+			break;		/* manual intervention required */
+
+		/*
+		 * Issue command to spin up drive when not ready
+		 */
+		if (SRpnt->sr_sense_buffer[2] == NOT_READY) {
 			unsigned long time1;
 			if (!spintime) {
 				printk(KERN_NOTICE "%s: Spinning up disk...",
@@ -839,7 +852,7 @@
 			} while(time1);
 			printk(".");
 		}
-	} while (the_result && spintime &&
+	} while (spintime &&
 		 time_after(spintime_value + 100 * HZ, jiffies));
 
 	if (spintime) {
@@ -851,80 +864,6 @@
 }
 
 /*
- * sd_read_cache_type - called only from sd_init_onedisk()
- */
-static void
-sd_read_cache_type(struct scsi_disk *sdkp, char *diskname,
-		   struct scsi_request *SRpnt, unsigned char *buffer) {
-
-	unsigned char cmd[10];
-	int the_result, retries;
-
-	retries = 3;
-	do {
-
-		memset((void *) &cmd[0], 0, 10);
-		cmd[0] = MODE_SENSE;
-		cmd[1] = 0x08;	/* DBD */
-		cmd[2] = 0x08;	/* current values, cache page */
-		cmd[4] = 128;	/* allocation length */
-
-
-		memset((void *) buffer, 0, 24);
-		SRpnt->sr_cmd_len = 0;
-		SRpnt->sr_sense_buffer[0] = 0;
-		SRpnt->sr_sense_buffer[2] = 0;
-
-		SRpnt->sr_data_direction = SCSI_DATA_READ;
-		scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
-			    128, SD_TIMEOUT, SD_MAX_RETRIES);
-
-		the_result = SRpnt->sr_result;
-		retries--;
-
-	} while (the_result && retries);
-
-	if (the_result) {
-		if(status_byte(the_result) == CHECK_CONDITION
-		   && (SRpnt->sr_sense_buffer[0] & 0x70) == 0x70
-		   && (SRpnt->sr_sense_buffer[2] & 0x0f) == ILLEGAL_REQUEST
-		   /* The next are ASC 0x24 ASCQ 0x00: Invalid field in CDB */
-		   && SRpnt->sr_sense_buffer[12] == 0x24
-		   && SRpnt->sr_sense_buffer[13] == 0x00) {
-			printk(KERN_NOTICE "SCSI device %s: cache data unavailable\n", diskname);
-		} else {
-			printk(KERN_ERR "%s : MODE SENSE failed.\n"
-			       "%s : status = %x, message = %02x, host = %d, driver = %02x \n",
-			       diskname, diskname,
-			       status_byte(the_result),
-			       msg_byte(the_result),
-			       host_byte(the_result),
-			       driver_byte(the_result)
-			       );
-			if (driver_byte(the_result) & DRIVER_SENSE)
-				print_req_sense("sd", SRpnt);
-			else
-				printk(KERN_ERR "%s : sense not available. \n", diskname);
-			
-			printk(KERN_ERR "%s : assuming drive cache: write through\n", diskname);
-		}
-		sdkp->WCE = 0;
-		sdkp->RCD = 0;
-	} else {
-		const char *types[] = { "write through", "none", "write back", "write back, no read (daft)" };
-		int ct = 0;
-		int offset = buffer[3] + 4; /* offset to start of mode page */
-
-		sdkp->WCE = (buffer[offset + 2] & 0x04) == 0x04;
-		sdkp->RCD = (buffer[offset + 2] & 0x01) == 0x01;
-
-		ct =  sdkp->RCD + 2*sdkp->WCE;
-
-		printk(KERN_NOTICE "SCSI device %s: drive cache: %s\n", diskname, types[ct]);
-	}
-}
-
-/*
  * read disk capacity - called only in sd_init_onedisk()
  */
 static void
@@ -1102,11 +1041,12 @@
 
 static int
 sd_do_mode_sense6(struct scsi_device *sdp, struct scsi_request *SRpnt,
-		  int modepage, unsigned char *buffer, int len) {
+		  int dbd, int modepage, unsigned char *buffer, int len) {
 	unsigned char cmd[8];
 
 	memset((void *) &cmd[0], 0, 8);
 	cmd[0] = MODE_SENSE;
+	cmd[1] = dbd;
 	cmd[2] = modepage;
 	cmd[4] = len;
 
@@ -1115,6 +1055,8 @@
 	SRpnt->sr_sense_buffer[2] = 0;
 	SRpnt->sr_data_direction = SCSI_DATA_READ;
 
+	memset((void *) buffer, 0, len);
+
 	scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
 		      len, SD_TIMEOUT, SD_MAX_RETRIES);
 
@@ -1135,7 +1077,7 @@
 	 * We have to start carefully: some devices hang if we ask
 	 * for more than is available.
 	 */
-	res = sd_do_mode_sense6(sdp, SRpnt, 0x3F, buffer, 4);
+	res = sd_do_mode_sense6(sdp, SRpnt, 0, 0x3F, buffer, 4);
 
 	/*
 	 * Second attempt: ask for page 0
@@ -1143,13 +1085,13 @@
 	 * Sense Key 5: Illegal Request, Sense Code 24: Invalid field in CDB.
 	 */
 	if (res)
-		res = sd_do_mode_sense6(sdp, SRpnt, 0, buffer, 4);
+		res = sd_do_mode_sense6(sdp, SRpnt, 0, 0, buffer, 4);
 
 	/*
 	 * Third attempt: ask 255 bytes, as we did earlier.
 	 */
 	if (res)
-		res = sd_do_mode_sense6(sdp, SRpnt, 0x3F, buffer, 255);
+		res = sd_do_mode_sense6(sdp, SRpnt, 0, 0x3F, buffer, 255);
 
 	if (res) {
 		printk(KERN_WARNING
@@ -1163,6 +1105,65 @@
 	}
 }
 
+/*
+ * sd_read_cache_type - called only from sd_init_onedisk()
+ */
+static void
+sd_read_cache_type(struct scsi_disk *sdkp, char *diskname,
+		   struct scsi_request *SRpnt, unsigned char *buffer) {
+	struct scsi_device *sdp = sdkp->device;
+	int len = 0, res;
+
+	const int dbd = 0x08;	   /* DBD */
+	const int modepage = 0x08; /* current values, cache page */
+
+	/* cautiously ask */
+	res = sd_do_mode_sense6(sdp, SRpnt, dbd, modepage, buffer, 4);
+
+	if (res == 0) {
+		/* that went OK, now ask for the proper length */
+		len = buffer[0] + 1;
+		if (len > 128)
+			len = 128;
+		res = sd_do_mode_sense6(sdp, SRpnt, dbd, modepage, buffer, len);
+	}
+
+	if (res == 0 && buffer[3] + 6 < len) {
+		const char *types[] = {
+			"write through", "none", "write back",
+			"write back, no read (daft)"
+		};
+		int ct = 0;
+		int offset = buffer[3] + 4; /* start of mode page */
+
+		sdkp->WCE = ((buffer[offset + 2] & 0x04) != 0);
+		sdkp->RCD = ((buffer[offset + 2] & 0x01) != 0);
+
+		ct =  sdkp->RCD + 2*sdkp->WCE;
+
+		printk(KERN_NOTICE "SCSI device %s: drive cache: %s\n",
+		       diskname, types[ct]);
+	} else {
+		if (res == 0 ||
+		    (status_byte(res) == CHECK_CONDITION
+		     && (SRpnt->sr_sense_buffer[0] & 0x70) == 0x70
+		     && (SRpnt->sr_sense_buffer[2] & 0x0f) == ILLEGAL_REQUEST
+		     /* ASC 0x24 ASCQ 0x00: Invalid field in CDB */
+		     && SRpnt->sr_sense_buffer[12] == 0x24
+		     && SRpnt->sr_sense_buffer[13] == 0x00)) {
+			printk(KERN_NOTICE "%s: cache data unavailable\n",
+			       diskname);
+		} else {
+			printk(KERN_ERR "%s: asking for cache data failed\n",
+			       diskname);
+		}
+		printk(KERN_ERR "%s: assuming drive cache: write through\n",
+		       diskname);
+		sdkp->WCE = 0;
+		sdkp->RCD = 0;
+	}
+}
+
 /**
  *	sd_init_onedisk - called the first time a new disk is seen,
  *	performs disk spin up, read_capacity, etc.
@@ -1208,15 +1209,20 @@
 	sdkp->device->sector_size = 512;
 	sdkp->media_present = 1;
 	sdkp->write_prot = 0;
+	sdkp->WCE = 0;
+	sdkp->RCD = 0;
 
 	sd_spinup_disk(sdkp, disk->disk_name, SRpnt, buffer);
-	sd_read_cache_type(sdkp, disk->disk_name, SRpnt, buffer);
 
 	if (sdkp->media_present)
 		sd_read_capacity(sdkp, disk->disk_name, SRpnt, buffer);
 	
 	if (sdp->removable && sdkp->media_present)
 		sd_read_write_protect_flag(sdkp, disk->disk_name, SRpnt, buffer);
+	/* without media there is no reason to ask;
+	   moreover, some devices react badly if we do */
+	if (sdkp->media_present)
+		sd_read_cache_type(sdkp, disk->disk_name, SRpnt, buffer);
 		
 	SRpnt->sr_device->ten = 1;
 	SRpnt->sr_device->remap = 1;

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291268AbSBMAZ0>; Tue, 12 Feb 2002 19:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291272AbSBMAZQ>; Tue, 12 Feb 2002 19:25:16 -0500
Received: from jalon.able.es ([212.97.163.2]:678 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S291268AbSBMAYr>;
	Tue, 12 Feb 2002 19:24:47 -0500
Date: Wed, 13 Feb 2002 01:24:37 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: new aic7xxx 6.2.5 extra hunks
Message-ID: <20020213012437.A20786@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was trying the new 6.2.5 version of AIC driver from Justin Gibss, and
as always it includes changes to the generic SCSI layer.
Are this really needed ????? (some look just cosmetic if -> switch...)

Hunks follow:

--- linux/drivers/scsi/scsi_error.c.orig
+++ linux/drivers/scsi/scsi_error.c
@@ -1009,13 +1009,7 @@
 			SCpnt->flags &= ~IS_RESETTING;
 			goto maybe_retry;
 		}
-		/*
-		 * Examine the sense data to figure out how to proceed from here.
-		 * If there is no sense data, we will be forced into the error
-		 * handler thread, where we get to examine the thing in a lot more
-		 * detail.
-		 */
-		return scsi_check_sense(SCpnt);
+		return SUCCESS;
 	default:
 		return FAILED;
 	}
--- linux/drivers/scsi/sd.c.orig
+++ linux/drivers/scsi/sd.c
@@ -595,6 +595,7 @@
 	int this_count = SCpnt->bufflen >> 9;
 	int good_sectors = (result == 0 ? this_count : 0);
 	int block_sectors = 1;
+	long error_sector;
 
 	SCSI_LOG_HLCOMPLETE(1, sd_devname(DEVICE_NR(SCpnt->request.rq_dev), nbuff));
 
@@ -611,10 +612,11 @@
 	 */
 
 	/* An error occurred */
-	if (driver_byte(result) != 0) {
-		/* Sense data is valid */
-		if (SCpnt->sense_buffer[0] == 0xF0 && SCpnt->sense_buffer[2] == MEDIUM_ERROR) {
-			long error_sector = (SCpnt->sense_buffer[3] << 24) |
+	if (driver_byte(result) != 0 && 	/* An error occured */
+	    SCpnt->sense_buffer[0] == 0xF0) {	/* Sense data is valid */
+		switch (SCpnt->sense_buffer[2]) {
+		case MEDIUM_ERROR:
+			error_sector = (SCpnt->sense_buffer[3] << 24) |
 			(SCpnt->sense_buffer[4] << 16) |
 			(SCpnt->sense_buffer[5] << 8) |
 			SCpnt->sense_buffer[6];
@@ -647,13 +649,30 @@
 			good_sectors = error_sector - SCpnt->request.sector;
 			if (good_sectors < 0 || good_sectors >= this_count)
 				good_sectors = 0;
-		}
-		if (SCpnt->sense_buffer[2] == ILLEGAL_REQUEST) {
+			break;
+
+		case RECOVERED_ERROR:
+			/*
+			 * An error occured, but it recovered.  Inform the
+			 * user, but make sure that it's not treated as a
+			 * hard error.
+			 */
+			print_sense("sd", SCpnt);
+			result = 0;
+			SCpnt->sense_buffer[0] = 0x0;
+			good_sectors = this_count;
+			break;
+
+		case ILLEGAL_REQUEST:
 			if (SCpnt->device->ten == 1) {
 				if (SCpnt->cmnd[0] == READ_10 ||
 				    SCpnt->cmnd[0] == WRITE_10)
 					SCpnt->device->ten = 0;
 			}
+			break;
+
+		default:
+			break;
 		}
 	}
 	/*
--- linux/drivers/scsi/sr.c.orig
+++ linux/drivers/scsi/sr.c
@@ -198,6 +198,7 @@
 	int good_sectors = (result == 0 ? this_count : 0);
 	int block_sectors = 0;
 	int device_nr = DEVICE_NR(SCpnt->request.rq_dev);
+	long error_sector;
 
 #ifdef DEBUG
 	printk("sr.c done: %x %p\n", result, SCpnt->request.bh->b_data);
@@ -210,33 +211,52 @@
 
 
 	if (driver_byte(result) != 0 &&		/* An error occurred */
-	    SCpnt->sense_buffer[0] == 0xF0 &&	/* Sense data is valid */
-	    (SCpnt->sense_buffer[2] == MEDIUM_ERROR ||
-	     SCpnt->sense_buffer[2] == VOLUME_OVERFLOW ||
-	     SCpnt->sense_buffer[2] == ILLEGAL_REQUEST)) {
-		long error_sector = (SCpnt->sense_buffer[3] << 24) |
-		(SCpnt->sense_buffer[4] << 16) |
-		(SCpnt->sense_buffer[5] << 8) |
-		SCpnt->sense_buffer[6];
-		if (SCpnt->request.bh != NULL)
-			block_sectors = SCpnt->request.bh->b_size >> 9;
-		if (block_sectors < 4)
-			block_sectors = 4;
-		if (scsi_CDs[device_nr].device->sector_size == 2048)
-			error_sector <<= 2;
-		error_sector &= ~(block_sectors - 1);
-		good_sectors = error_sector - SCpnt->request.sector;
-		if (good_sectors < 0 || good_sectors >= this_count)
-			good_sectors = 0;
-		/*
-		 * The SCSI specification allows for the value returned by READ
-		 * CAPACITY to be up to 75 2K sectors past the last readable
-		 * block.  Therefore, if we hit a medium error within the last
-		 * 75 2K sectors, we decrease the saved size value.
-		 */
-		if ((error_sector >> 1) < sr_sizes[device_nr] &&
-		    scsi_CDs[device_nr].capacity - error_sector < 4 * 75)
-			sr_sizes[device_nr] = error_sector >> 1;
+	    SCpnt->sense_buffer[0] == 0xF0) {	/* Sense data is valid */
+		switch (SCpnt->sense_buffer[2]) {
+		case MEDIUM_ERROR:
+		case VOLUME_OVERFLOW:
+		case ILLEGAL_REQUEST:
+			error_sector = (SCpnt->sense_buffer[3] << 24) |
+			(SCpnt->sense_buffer[4] << 16) |
+			(SCpnt->sense_buffer[5] << 8) |
+			SCpnt->sense_buffer[6];
+			if (SCpnt->request.bh != NULL)
+				block_sectors = SCpnt->request.bh->b_size >> 9;
+			if (block_sectors < 4)
+				block_sectors = 4;
+			if (scsi_CDs[device_nr].device->sector_size == 2048)
+				error_sector <<= 2;
+			error_sector &= ~(block_sectors - 1);
+			good_sectors = error_sector - SCpnt->request.sector;
+			if (good_sectors < 0 || good_sectors >= this_count)
+				good_sectors = 0;
+			/*
+			 * The SCSI specification allows for the value returned
+			 * by READ CAPACITY to be up to 75 2K sectors past the
+			 * last readable block.  Therefore, if we hit a medium
+			 * error within the last 75 2K sectors, we decrease the
+			 * saved size value.
+			 */
+			if ((error_sector >> 1) < sr_sizes[device_nr] &&
+			    scsi_CDs[device_nr].capacity - error_sector < 4 *75)
+				sr_sizes[device_nr] = error_sector >> 1;
+			break;
+
+		case RECOVERED_ERROR:
+			/*
+			 * An error occured, but it recovered.  Inform the
+			 * user, but make sure that it's not treated as a
+			 * hard error.
+			 */
+			print_sense("sr", SCpnt);
+			result = 0;
+			SCpnt->sense_buffer[0] = 0x0;
+			good_sectors = this_count;
+			break;
+
+		default:
+			break;
+		}
 	}
 
 	/*

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre9-slb2 #1 SMP Tue Feb 12 20:16:13 CET 2002 i686

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264246AbRFFXSf>; Wed, 6 Jun 2001 19:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264241AbRFFXS0>; Wed, 6 Jun 2001 19:18:26 -0400
Received: from hera.cwi.nl ([192.16.191.8]:20358 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264240AbRFFXSQ>;
	Wed, 6 Jun 2001 19:18:16 -0400
Date: Thu, 7 Jun 2001 01:18:08 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106062318.BAA216606.aeb@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, mdharm-usb@one-eyed-alien.net,
        torvalds@transmeta.com
Subject: [PATCH] scsi_scan fix (for usb)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I reported for 2.4.3 and 2.4.5 a failure to detect
a USB CF card reader caused by the occurrence of a Unit Attention
at boot time. An ugly solution is to remove this "error" in
usb/storage/transport.c, but since this is perfectly normal
SCSI behaviour, and can in principle occur with all kinds of
hosts and drivers, it is probably better to test for Unit Attention
is scan_scsis. (In the good old days we did TEST UNIT READY there,
but not anymore.)
No doubt the actual test will have to become more complicated,
but I just wrote the minimum required to make my hardware work.

The things other than in scsi_scan.c are just minor polishing.
For example, sd.c printed an "extended sense code" that was in
reality the sense key. I started adding ASC and ASCQ, but we
already have a function for that in constants.c.

Andries

diff -u --recursive --new-file ../linux-2.4.5/linux/drivers/scsi/constants.c ./linux/drivers/scsi/constants.c
--- ../linux-2.4.5/linux/drivers/scsi/constants.c	Mon Jan 15 22:08:15 2001
+++ ./linux/drivers/scsi/constants.c	Thu Jun  7 00:36:41 2001
@@ -689,7 +689,7 @@
 			  kdev_t dev)
 {
     int i, s;
-    int sense_class, valid, code;
+    int sense_class, valid, code, info;
     const char * error = NULL;
     
     sense_class = (sense_buffer[0] >> 4) & 0x07;
@@ -701,11 +701,14 @@
 	if(s > SCSI_SENSE_BUFFERSIZE)
 	   s = SCSI_SENSE_BUFFERSIZE;
 	
-	if (!valid)
-	    printk("[valid=0] ");
-	printk("Info fld=0x%x, ", (int)((sense_buffer[3] << 24) |
-	       (sense_buffer[4] << 16) | (sense_buffer[5] << 8) |
-	       sense_buffer[6]));
+	info = ((sense_buffer[3] << 24) | (sense_buffer[4] << 16) |
+		(sense_buffer[5] << 8) | sense_buffer[6]);
+	if (info || !valid) {
+		printk("Info fld=0x%x", info);
+		if (!valid)	/* info data not according to standard */
+			printk(" (nonstd)");
+		printk(", ");
+	}
 	if (sense_buffer[2] & 0x80)
            printk( "FMK ");	/* current command has read a filemark */
 	if (sense_buffer[2] & 0x40)
diff -u --recursive --new-file ../linux-2.4.5/linux/drivers/scsi/scsi_scan.c ./linux/drivers/scsi/scsi_scan.c
--- ../linux-2.4.5/linux/drivers/scsi/scsi_scan.c	Sun Apr  8 19:10:01 2001
+++ ./linux/drivers/scsi/scsi_scan.c	Thu Jun  7 00:10:27 2001
@@ -328,8 +328,8 @@
 	}
 
 	/*
-	 * We need to increment the counter for this one device so we can track when
-	 * things are quiet.
+	 * We need to increment the counter for this one device so we can track
+	 * when things are quiet.
 	 */
 	if (hardcoded == 1) {
 		Scsi_Device *oldSDpnt = SDpnt;
@@ -485,8 +485,8 @@
 	SDpnt->type = -1;
 
 	/*
-	 * Assume that the device will have handshaking problems, and then fix this
-	 * field later if it turns out it doesn't
+	 * Assume that the device will have handshaking problems, and then fix
+	 * this field later if it turns out it doesn't
 	 */
 	SDpnt->borken = 1;
 	SDpnt->was_reset = 0;
@@ -524,9 +524,21 @@
 	SCSI_LOG_SCAN_BUS(3, printk("scsi: INQUIRY %s with code 0x%x\n",
 		SRpnt->sr_result ? "failed" : "successful", SRpnt->sr_result));
 
+	/*
+	 * Now that we don't do TEST_UNIT_READY anymore, we must be prepared
+	 * for media change conditions here, so cannot require zero result.
+	 */
 	if (SRpnt->sr_result) {
-		scsi_release_request(SRpnt);
-		return 0;	/* assume no peripheral if any sort of error */
+		if ((driver_byte(SRpnt->sr_result) & DRIVER_SENSE) != 0 &&
+		    (SRpnt->sr_sense_buffer[2] & 0xf) == UNIT_ATTENTION &&
+		    SRpnt->sr_sense_buffer[12] == 0x28 &&
+		    SRpnt->sr_sense_buffer[13] == 0) {
+			/* not-ready to ready transition - good */
+		} else {
+			/* assume no peripheral if any other sort of error */
+			scsi_release_request(SRpnt);
+			return 0;
+		}
 	}
 
 	/*
diff -u --recursive --new-file ../linux-2.4.5/linux/drivers/scsi/sd.c ./linux/drivers/scsi/sd.c
--- ../linux-2.4.5/linux/drivers/scsi/sd.c	Fri May 25 18:54:50 2001
+++ ./linux/drivers/scsi/sd.c	Wed Jun  6 23:58:46 2001
@@ -861,8 +861,7 @@
 		       driver_byte(the_result)
 		    );
 		if (driver_byte(the_result) & DRIVER_SENSE)
-			printk("%s : extended sense code = %1x \n",
-			       nbuff, SRpnt->sr_sense_buffer[2] & 0xf);
+			print_req_sense("sd", SRpnt);
 		else
 			printk("%s : sense not available. \n", nbuff);
 
diff -u --recursive --new-file ../linux-2.4.5/linux/drivers/usb/storage/debug.c ./linux/drivers/usb/storage/debug.c
--- ../linux-2.4.5/linux/drivers/usb/storage/debug.c	Sat Sep  9 01:39:12 2000
+++ ./linux/drivers/usb/storage/debug.c	Wed Jun  6 22:39:31 2001
@@ -302,6 +302,8 @@
 	case 0x1C00: what="defect list not found"; break;
 	case 0x2400: what="invalid field in CDB"; break;
 	case 0x2703: what="associated write protect"; break;
+	case 0x2800: what="not ready to ready transition (media change?)";
+		break;
 	case 0x2903: what="bus device reset function occurred"; break;
 	case 0x2904: what="device internal reset"; break;
 	case 0x2B00: what="copy can't execute since host can't disconnect"; 


PS - It is funny, I had added one more case to debug.c,
and compiled, and booted, and the newly booted kernel
has this additional code, but debug.c doesnt have it anymore,
so probably it never reached disk before the reboot.

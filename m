Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318191AbSIBAhD>; Sun, 1 Sep 2002 20:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318188AbSIBAhD>; Sun, 1 Sep 2002 20:37:03 -0400
Received: from hera.cwi.nl ([192.16.191.8]:33502 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S318184AbSIBAg6>;
	Sun, 1 Sep 2002 20:36:58 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 2 Sep 2002 02:41:16 +0200 (MEST)
Message-Id: <UTC200209020041.g820fGS22828.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: [PATCH] MODE SENSE in sd.c; sddr09.c
Cc: mdharm-usb@one-eyed-alien.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In sd.c we call MODE SENSE (6) in order to find out whether the
device is write protected. The info we need is in byte 2, the
header of the MODE SENSE answer, but in the request we have to
specify (i) what page(s) we want, and (ii) how many bytes we want.

Long ago we asked for 12 bytes from page 1 (Daniel Roche, 1.3.35).
Matthew Dharm made this 8 bytes from page 3F (all pages), patch-2.4.0-test8.
In patch-2.4.10 the 8 was increased to 255.

I found on the one hand devices that only react to page 0
(the vendor page), and return an error for page 3F.
And on the other hand devices that are unable to handle requests
for more bytes than they actually have.

So, it seems that the cautious way to ask for MODE SENSE data is
to first ask for the header only, see how much is available,
and then ask for everything.

The patch below first separates out the MODE SENSE call,
and then tries it three times: on all pages (3F), only the first
four bytes; on the vendor page (0), only the first four bytes;
on all pages (3F), 255 bytes.

This should be at least as robust as our current code.
I tried it on 8 SCSI devices (of which 2 fail under 2.5.33)
and found no problems.

Below - maybe I should have sent it in a separate mail -
a diff of usb/storage/sddr09.c teaching the code there
how to return less than a full page.

Andries


--- linux-2.5.33/linux/drivers/scsi/sd.c	Sun Sep  1 09:47:13 2002
+++ linux-2.5.33a/linux/drivers/scsi/sd.c	Mon Sep  2 01:49:28 2002
@@ -1007,6 +1007,28 @@
 	sdkp->device->sector_size = sector_size;
 }
 
+static int
+sd_do_mode_sense6(Scsi_Device *sdp, Scsi_Request *SRpnt,
+		  int modepage, unsigned char *buffer, int len) {
+	unsigned char cmd[8];
+
+	memset((void *) &cmd[0], 0, 8);
+	cmd[0] = MODE_SENSE;
+	cmd[1] = (sdp->scsi_level <= SCSI_2) ? ((sdp->lun << 5) & 0xe0) : 0;
+	cmd[2] = modepage;
+	cmd[4] = len;
+
+	SRpnt->sr_cmd_len = 0;
+	SRpnt->sr_sense_buffer[0] = 0;
+	SRpnt->sr_sense_buffer[2] = 0;
+	SRpnt->sr_data_direction = SCSI_DATA_READ;
+
+	scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
+		      len, SD_TIMEOUT, MAX_RETRIES);
+
+	return SRpnt->sr_result;
+}
+
 /*
  * read write protect setting, if possible - called only in sd_init_onedisk()
  */
@@ -1014,50 +1036,38 @@
 sd_read_write_protect_flag(Scsi_Disk *sdkp, char *diskname,
 			   Scsi_Request *SRpnt, unsigned char *buffer) {
 	Scsi_Device *sdp = sdkp->device;
-	unsigned char cmd[8];
-	int the_result;
+	int res;
 
 	/*
-	 * For removable scsi disks we have to recognise the
-	 * Write Protect Flag. This flag is kept in the Scsi_Disk
-	 * struct and tested at open !
-	 * Daniel Roche ( dan@lectra.fr )
-	 *
-	 * Changed to get all pages (0x3f) rather than page 1 to
-	 * get around devices which do not have a page 1.  Since
-	 * we're only interested in the header anyway, this should
-	 * be fine.
-	 *   -- Matthew Dharm (mdharm-scsi@one-eyed-alien.net)
-	 *
-	 * As it turns out, some devices return an error for
-	 * every MODE_SENSE request except one for page 0.
-	 * So, we should also try that. --aeb
+	 * First attempt: ask for all pages (0x3F), but only 4 bytes.
+	 * We have to start carefully: some devices hang if we ask
+	 * for more than is available.
 	 */
+	res = sd_do_mode_sense6(sdp, SRpnt, 0x3F, buffer, 4);
 
-	memset((void *) &cmd[0], 0, 8);
-	cmd[0] = MODE_SENSE;
-	cmd[1] = (sdp->scsi_level <= SCSI_2) ?
-		((sdp->lun << 5) & 0xe0) : 0;
-	cmd[2] = 0x3f;	/* Get all pages */
-	cmd[4] = 255;   /* Ask for 255 bytes, even tho we want just the first 8 */
-	SRpnt->sr_cmd_len = 0;
-	SRpnt->sr_sense_buffer[0] = 0;
-	SRpnt->sr_sense_buffer[2] = 0;
-	SRpnt->sr_data_direction = SCSI_DATA_READ;
-
-	scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
-		      255, SD_TIMEOUT, MAX_RETRIES);
+	/*
+	 * Second attempt: ask for page 0
+	 * When only page 0 is implemented, a request for page 3F may return
+	 * Sense Key 5: Illegal Request, Sense Code 24: Invalid field in CDB.
+	 */
+	if (res)
+		res = sd_do_mode_sense6(sdp, SRpnt, 0, buffer, 4);
 
-	the_result = SRpnt->sr_result;
+	/*
+	 * Third attempt: ask 255 bytes, as we did earlier.
+	 */
+	if (res)
+		res = sd_do_mode_sense6(sdp, SRpnt, 0x3F, buffer, 255);
 
-	if (the_result) {
-		printk("%s: test WP failed, assume Write Enabled\n",
-		       diskname);
-		/* alternatively, try page 0 */
+	if (res) {
+		printk(KERN_WARNING
+		       "%s: test WP failed, assume Write Enabled\n", diskname);
 	} else {
 		sdkp->write_prot = ((buffer[2] & 0x80) != 0);
 		printk(KERN_NOTICE "%s: Write Protect is %s\n", diskname,
 		       sdkp->write_prot ? "on" : "off");
+		printk(KERN_DEBUG "%s: Mode Sense: %02x %02x %02x %02x\n",
+		       diskname, buffer[0], buffer[1], buffer[2], buffer[3]);
 	}
 }
 

--- linux-2.5.33/linux/drivers/usb/storage/sddr09.c	Sun Jun  9 07:31:18 2002
+++ linux-2.5.33a/linux/drivers/usb/storage/sddr09.c	Mon Sep  2 01:33:40 2002
@@ -1443,36 +1443,27 @@
 	}
 
 	if (srb->cmnd[0] == MODE_SENSE) {
+		int modepage = (srb->cmnd[2] & 0x3F);
+		int len;
 
-		// Read-write error recovery page: there needs to
-		// be a check for write-protect here
+		/* They ask for the Read/Write error recovery page,
+		   or for all pages. Give as much as they have room for. */
+		if (modepage == 0x01 || modepage == 0x3F) {
 
-		if ( (srb->cmnd[2] & 0x3F) == 0x01 ) {
-
-			US_DEBUGP(
-				"SDDR09: Dummy up request for mode page 1\n");
+			US_DEBUGP("SDDR09: Dummy up request for "
+				  "mode page 0x%x\n", modepage);
 
-			if (ptr == NULL || 
-			    srb->request_bufflen<sizeof(mode_page_01))
+			if (ptr == NULL)
 				return USB_STOR_TRANSPORT_ERROR;
 
+			len = srb->request_bufflen;
+			if (len > sizeof(mode_page_01))
+				len = sizeof(mode_page_01);
+
 			mode_page_01[0] = sizeof(mode_page_01) - 1;
 			mode_page_01[2] = (info->flags & SDDR09_WP) ? 0x80 : 0;
-			memcpy(ptr, mode_page_01, sizeof(mode_page_01));
+			memcpy(ptr, mode_page_01, len);
 			return USB_STOR_TRANSPORT_GOOD;
-
-		} else if ( (srb->cmnd[2] & 0x3F) == 0x3F ) {
-
-			US_DEBUGP("SDDR09: Dummy up request for "
-				  "all mode pages\n");
-
-			if (ptr == NULL || 
-			    srb->request_bufflen<sizeof(mode_page_01))
-				return USB_STOR_TRANSPORT_ERROR;
-
-			memcpy(ptr, mode_page_01, sizeof(mode_page_01));
-			return USB_STOR_TRANSPORT_GOOD;
-
 		}
 
 		return USB_STOR_TRANSPORT_ERROR;

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbSLMV5I>; Fri, 13 Dec 2002 16:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSLMV5I>; Fri, 13 Dec 2002 16:57:08 -0500
Received: from comtv.ru ([217.10.32.4]:37040 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S265470AbSLMV5H>;
	Fri, 13 Dec 2002 16:57:07 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC] 2tb limit in sd.c
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 14 Dec 2002 00:58:23 +0300
Message-ID: <m3wumdy41s.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good day!

modern storage boxes support >2TB arrays, but READ CAPACITY
may return 2TB only (with 512 bytes blocksize). According to
SBC, target may return 0xffffffff as device size in order to
notify initiator that device size can't fit into 32 bits and
that initiator should use Long READ CAPACITY with 64bits LBA
field. Following patch implements this logic. Is it possible
to include patch into 2.5 ?

diff -uNr linux-2.5.47/drivers/scsi/sd.c linux-2.5.51/drivers/scsi/sd.c
--- linux-2.5.47/drivers/scsi/sd.c	Sat Dec 14 00:30:14 2002
+++ linux-2.5.51/drivers/scsi/sd.c	Fri Dec 13 23:58:59 2002
@@ -908,11 +908,15 @@
 	struct scsi_device *sdp = sdkp->device;
 	int the_result, retries;
 	int sector_size;
+	int longrc = 0;
 
+repeat:
 	retries = 3;
 	do {
 		cmd[0] = READ_CAPACITY;
 		memset((void *) &cmd[1], 0, 9);
+		if (longrc)
+			cmd[1] = 0x02;	/* Long LBA */
 		memset((void *) buffer, 0, 8);
 
 		SRpnt->sr_cmd_len = 0;
@@ -921,7 +925,7 @@
 		SRpnt->sr_data_direction = SCSI_DATA_READ;
 
 		scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
-			      8, SD_TIMEOUT, SD_MAX_RETRIES);
+			      longrc ? 12 : 8, SD_TIMEOUT, SD_MAX_RETRIES);
 
 		if (media_not_present(sdkp, SRpnt))
 			return;
@@ -958,14 +962,34 @@
 
 		return;
 	}
-
-	sdkp->capacity = 1 + (((sector_t)buffer[0] << 24) |
-			      (buffer[1] << 16) |
-			      (buffer[2] << 8) |
-			      buffer[3]);
-
-	sector_size = (buffer[4] << 24) |
-		(buffer[5] << 16) | (buffer[6] << 8) | buffer[7];
+	
+	if (!longrc) {
+		if (buffer[0] == 0xff && buffer[1] == 0xff &&
+			buffer[2] == 0xff && buffer[3] == 0xff) {
+			printk ("very big device. try to send long\n");
+			longrc = 1;
+			goto repeat;
+		}
+		sdkp->capacity = 1 + (((sector_t)buffer[0] << 24) |
+			(buffer[1] << 16) |
+			(buffer[2] << 8) |
+			buffer[3]);
+			
+		sector_size = (buffer[4] << 24) |
+			(buffer[5] << 16) | (buffer[6] << 8) | buffer[7];
+	} else {
+		sdkp->capacity = 1 + (((sector_t)buffer[0] << 56) |
+			((sector_t)buffer[1] << 48) |
+			((sector_t)buffer[2] << 40) |
+			((sector_t)buffer[3] << 32) |
+			((sector_t)buffer[4] << 24) |
+			((sector_t)buffer[5] << 16) |
+			((sector_t)buffer[6] << 8)  |
+			(sector_t)buffer[7]);
+			
+		sector_size = (buffer[8] << 24) |
+			(buffer[9] << 16) | (buffer[10] << 8) | buffer[11];
+	}	
 
 	if (sector_size == 0) {
 		sector_size = 512;


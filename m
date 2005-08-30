Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVH3G4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVH3G4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 02:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVH3G4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 02:56:41 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:29191 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751061AbVH3G4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 02:56:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=s1wzW1w+v3FT5HZUEwmcNAN+/I5lGVZmoWenN4yBaWzNNBIsYp6mEKbjUuawpJtamnTUlCpGpyKq4qZlWO91Emfy+GVbIlynvrdcFaJbyVF0MYM6iFbKikWPwqoQG3u1OffpJcMtun8OurfxXuDI5QRSKQayxGhz+PQsEMGQEYI=
Date: Tue, 30 Aug 2005 12:56:33 +0600
From: Samartsev Ilja <samartsev@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Changing of dvd speed via CDROM_SELECT_SPEED ioctl() call
 again :)
Message-Id: <20050830125633.466db563.samartsev@gmail.com>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jens Axboe!

This patch implements changing of DVD speed via CDROM_SELECT_SPEED 
ioctl() call. 
Now it checks for the type of media in drive. If drive is dvdrom or
media type is DVD, it change speed via SET_STREAMING command or it
changes speed of CDs via SET_SPEED command. 
What you think about this?

Signed-off-by: Ilja Samartsev <samartsev@gmail.com>

===========================
--- linux/drivers/ide/ide-cd.c	2005-08-21 21:18:05.000000000 +0600
+++ my_linux/drivers/ide/ide-cd.c	2005-08-28 14:10:51.000000000 +0600
@@ -2390,10 +2390,77 @@ static int cdrom_select_speed(ide_drive_
 			      struct request_sense *sense)
 {
 	struct request req;
+
+	if (CDROM_CONFIG_FLAGS(drive)->dvd) {
+		struct request_sense tmp_sense;
+		unsigned char buf[8];
+
+		/* Detecting type of media */
+		cdrom_prepare_request(drive, &req);
+	
+		req.sense = &tmp_sense;
+		req.data = buf;
+		req.data_len = sizeof(buf);
+
+		req.cmd[0] = GPCMD_GET_CONFIGURATION;
+		req.cmd[8] = sizeof(buf); /* Allocation Length */
+
+		cdrom_queue_packet_command(drive, &req);
+
+		if (((buf[6] << 8) | buf[7]) & 0x30) { /* Media is dvd */
+			struct request_sense cap_sense;
+			unsigned char pd[28];
+			unsigned long cap, spf;
+
+			cdrom_prepare_request(drive, &req);
+
+			req.sense = sense;
+			req.data = pd;
+			req.data_len = sizeof(pd);
+
+			memset(pd, 0, sizeof(pd));
+
+			req.cmd[0] = GPCMD_SET_STREAMING;
+			req.cmd[10] = sizeof(pd); /* parameter list length */
+
+			if (speed <= 0) {
+				pd[0] = 4;	/* restore drive defaults */
+			} else {
+				speed *= 1385;	/* Nx to kbytes/s (FIXME: maybe not right value) */
+
+				if (!cdrom_read_capacity(drive, &cap, &spf, &cap_sense) && cap) {
+					/* good End LBA detected */
+					cap++;
+					pd[8] = (cap >> 24) & 0xff;
+					pd[9] = (cap >> 16) & 0xff;
+					pd[10] = (cap >> 8) & 0xff;
+					pd[11] = cap & 0xff; 
+				} else {
+					/* no good End LBA detected, using max */
+					pd[8] = 0xff;
+					pd[9] = 0xff;
+					pd[10] = 0xff;
+					pd[11] = 0xff; 
+				}
+
+				/* read and write size */
+				pd[12] = pd[20] = (speed >> 24) & 0xff;
+				pd[13] = pd[21] = (speed >> 16) & 0xff;
+				pd[14] = pd[22] = (speed >> 8) & 0xff;
+				pd[15] = pd[23] = speed & 0xff;
+
+				/* read and write time */
+				pd[18] = pd[26] = 1000 >> 8;
+				pd[19] = pd[27] = 1000 & 0xff;
+			}
+			return cdrom_queue_packet_command(drive, &req);
+		}
+	}
+
 	cdrom_prepare_request(drive, &req);
 
 	req.sense = sense;
-	if (speed == 0)
+	if (speed <= 0)
 		speed = 0xffff; /* set to max */
 	else
 		speed *= 177;   /* Nx to kbytes/s */
========== EOF ============

-- 
Samartsev Ilja

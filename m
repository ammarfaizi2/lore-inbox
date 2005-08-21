Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVHUPzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVHUPzf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 11:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVHUPze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 11:55:34 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:61807 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751054AbVHUPze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 11:55:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=CSyncrd4yJpceniYrOVdXSh2rAuBdp3u4MTiPc5sfAU9xI4CtN2ReHsFEBzYStSFl0LmOucooNgUdzi+D4Ei9vr4bPtO25MaTeNmTe5+puBvHo5PyQACmo1WM/JGmjPsFIo8ePz79tfkCaT4OQA5jQfypUX0xXN4NnWa8c9CQTE=
Date: Sun, 21 Aug 2005 21:55:27 +0600
From: cHitman <samartsev@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH for changing of DVD speed via ioctl() call
Message-Id: <20050821215527.17df869b.samartsev@gmail.com>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, folks!

This patch implements changing of DVD speed via ioctl() call, like
CDROM_SELECT_SPEED do. In CDROM_SELECT_SPEED its implementation isn't
so good (diffirent values of 1x in KB/s, troubles with return value of
cdrom_select_speed() and other). I defined CDROM_SELECT_DVDSPEED ioctl
() call with value 0x5324. But some dvdroms (like Plexter) do not
support this feature.. :(

I've successfully tested this patch on:s
NEC ND-3500AG (fw 2.19)
BENQ DVD-ROM 16X 1650T (fw: A.DD)
HL-DT-ST DVD-RW GCA-4080N (fw: 0A31)

I've mailed this message to Jens Axboe but have not answer :(
Please try it and say what you think about this..

patch for kernel 2.6.12

Signed-off-by: Ilja Samartsev <samartsev@gmail.com>

PS: I'm not subscribed to LKML please CC me if you can.

=================== PATCH ====================
--- linux/include/linux/cdrom.h	2005-08-13 12:54:06.000000000 +0600
+++ my_linux/include/linux/cdrom.h	2005-08-14 15:06:06.000000000 +0600
@@ -120,6 +120,7 @@
 #define CDROM_CLEAR_OPTIONS	0x5321  /* Clear behavior options */
 #define CDROM_SELECT_SPEED	0x5322  /* Set the CD-ROM speed */
 #define CDROM_SELECT_DISC	0x5323  /* Select disc (for juke-boxes) */
+#define CDROM_SELECT_DVDSPEED	0x5324  /* Set the DVD-ROM speed */
 #define CDROM_MEDIA_CHANGED	0x5325  /* Check is media changed  */
 #define CDROM_DRIVE_STATUS	0x5326  /* Get tray position, etc. */
 #define CDROM_DISC_STATUS	0x5327  /* Get disc type, etc. */
@@ -965,6 +966,7 @@ struct cdrom_device_ops {
 	int (*tray_move) (struct cdrom_device_info *, int);
 	int (*lock_door) (struct cdrom_device_info *, int);
 	int (*select_speed) (struct cdrom_device_info *, int);
+	int (*select_dvd_speed) (struct cdrom_device_info *, int);
 	int (*select_disc) (struct cdrom_device_info *, int);
 	int (*get_last_session) (struct cdrom_device_info *,
 				 struct cdrom_multisession *);
--- linux/drivers/cdrom/cdrom.c	2005-08-13 12:54:06.000000000 +0600
+++ my_linux/drivers/cdrom/cdrom.c	2005-08-12 17:11:20.000000000 +0600
@@ -2327,6 +2327,11 @@ int cdrom_ioctl(struct file * file, stru
 		return cdo->select_speed(cdi, arg);
 		}
 
+	case CDROM_SELECT_DVDSPEED: {
+		cdinfo(CD_DO_IOCTL, "entering CDROM_SELECT_DVDSPEED\n"); 
+		return cdo->select_dvd_speed(cdi, arg);
+		}
+
 	case CDROM_SELECT_DISC: {
 		cdinfo(CD_DO_IOCTL, "entering CDROM_SELECT_DISC\n"); 
 		if (!CDROM_CAN(CDC_SELECT_DISC))
--- linux/drivers/ide/ide-cd.c	2005-08-13 12:54:06.000000000 +0600
+++ my_linux/drivers/ide/ide-cd.c	2005-08-16 01:00:09.000000000 +0600
@@ -2393,7 +2393,7 @@ static int cdrom_select_speed(ide_drive_
 	cdrom_prepare_request(drive, &req);
 
 	req.sense = sense;
-	if (speed == 0)
+	if (speed <= 0)
 		speed = 0xffff; /* set to max */
 	else
 		speed *= 177;   /* Nx to kbytes/s */
@@ -2415,6 +2415,63 @@ static int cdrom_select_speed(ide_drive_
 	return cdrom_queue_packet_command(drive, &req);
 }
 
+static int cdrom_select_dvd_speed(ide_drive_t *drive, int speed,
+		struct request_sense *sense)
+{
+	struct request req;
+	struct request_sense cap_sense;
+	unsigned char pd[28];
+	unsigned long cap, spf;
+
+	if (!CDROM_CONFIG_FLAGS(drive)->dvd)
+		return -ENOSYS; 
+ 
+	cdrom_prepare_request(drive, &req);
+
+	req.sense = sense;
+	req.data = pd;
+	req.data_len = sizeof(pd);
+
+	memset(pd, 0, sizeof(pd));
+
+	req.cmd[0] = GPCMD_SET_STREAMING;
+	req.cmd[10] = sizeof(pd); /* parameter list length */
+
+	if (speed <= 0) {
+		pd[0] = 4;	/* restore drive defaults */
+	} else {
+
+		speed *= 1385;	/* Nx to kbytes/s (FIXME: maybe not right value) */
+
+		if (!cdrom_read_capacity(drive, &cap, &spf, &cap_sense) && cap) {
+			/* good End LBA detected */
+			cap++;
+			pd[8] = (cap >> 24) & 0xff;
+			pd[9] = (cap >> 16) & 0xff;
+			pd[10] = (cap >> 8) & 0xff;
+			pd[11] = cap & 0xff; 
+		} else {
+			/* no good End LBA detected, using max */
+			pd[8] = 0xff;
+			pd[9] = 0xff;
+			pd[10] = 0xff;
+			pd[11] = 0xff; 
+		}
+			
+		/* read and write size */
+		pd[12] = pd[20] = (speed >> 24) & 0xff;
+		pd[13] = pd[21] = (speed >> 16) & 0xff;
+		pd[14] = pd[22] = (speed >> 8) & 0xff;
+		pd[15] = pd[23] = speed & 0xff;
+
+		/* read and write time */
+		pd[18] = pd[26] = 1000 >> 8;
+		pd[19] = pd[27] = 1000 & 0xff;
+	}
+
+	return cdrom_queue_packet_command(drive, &req);
+}
+
 static int cdrom_play_audio(ide_drive_t *drive, int lba_start, int lba_end)
 {
 	struct request_sense sense;
@@ -2670,6 +2727,19 @@ int ide_cdrom_select_speed (struct cdrom
         return 0;
 }
 
+static
+int ide_cdrom_select_dvd_speed (struct cdrom_device_info *cdi, int speed)
+{
+	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	struct request_sense sense;
+	int stat;
+
+	if ((stat = cdrom_select_dvd_speed(drive, speed, &sense)) < 0)
+		return stat;
+
+	return 0;
+}
+
 /*
  * add logic to try GET_EVENT command first to check for media and tray
  * status. this should be supported by newer cd-r/w and all DVD etc
@@ -2816,6 +2886,7 @@ static struct cdrom_device_ops ide_cdrom
 	.tray_move		= ide_cdrom_tray_move,
 	.lock_door		= ide_cdrom_lock_door,
 	.select_speed		= ide_cdrom_select_speed,
+	.select_dvd_speed	= ide_cdrom_select_dvd_speed,
 	.get_last_session	= ide_cdrom_get_last_session,
 	.get_mcn		= ide_cdrom_get_mcn,
 	.reset			= ide_cdrom_reset,

====================== EOF ========================

=================== dvdspeed.c ====================
/*  
 *  dvdspeed - small program for selecting speed of DVD drive
 *    Copyright (C) 2005 Ilja Samartsev <samartsev@gmail.com>
 * 
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <linux/cdrom.h>

int main (int argc, char **argv)
{
	int fd, speed;
	char *device;
	
	if (argc < 3) {
		printf("usage: %s device speed\n", argv[0]);
		return -1;		
	}

	device = argv[1];
	speed = atoi(argv[2]);

	if ((fd = open(device, O_RDONLY|O_NONBLOCK)) >= 0) {
		if (ioctl(fd, CDROM_SELECT_DVDSPEED, speed) < 0) {
			perror("ioctl()");
			exit(-1);
		}
	}

	return 0;
}
====================== EOF ========================

-- 
Samartsev Ilja

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbRFTXUw>; Wed, 20 Jun 2001 19:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264679AbRFTXUg>; Wed, 20 Jun 2001 19:20:36 -0400
Received: from mout1.freenet.de ([194.97.50.132]:48297 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S264673AbRFTXUO>;
	Wed, 20 Jun 2001 19:20:14 -0400
Date: Thu, 21 Jun 2001 01:21:08 +0200 (CEST)
From: Martin Wilck <mwilck@freenet.de>
To: <linux-kernel@vger.kernel.org>
Cc: <mwilck@freenet.de>
Subject: [PATCH] disk_index weirdness
Message-ID: <Pine.LNX.4.30.0106210114120.4131-100000@odysseus.riemann-30.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I suggest the follwoing patch to make /proc/stat work as expected in 2.4.
I noted that "gkrellm" erroneously reported my disk hdc as hde. the reason
is that (a relict from the 2.2 series, I suppose) disk_index adds 2 to
the disk number for IDE controller 1. This is IMO wrong, because in 2.4
the disks are indexed by major and minor number.

I also added more major numbers to the routine and tried to order the
majors such that the "right" results are found quickly.

Regards,
Martin

PS: I'm not subscribed to this list, but I read the archives regularly.

--- include/linux/genhd.h.orig	Tue Mar 27 01:48:11 2001
+++ include/linux/genhd.h	Wed Jun 20 19:17:09 2001
@@ -248,21 +248,30 @@
 	unsigned int index;

 	switch (major) {
-		case DAC960_MAJOR+0:
-			index = (minor & 0x00f8) >> 3;
-			break;
 		case SCSI_DISK0_MAJOR:
 			index = (minor & 0x00f0) >> 4;
 			break;
 		case IDE0_MAJOR:	/* same as HD_MAJOR */
 		case XT_DISK_MAJOR:
+		case IDE1_MAJOR:
+		case IDE2_MAJOR:
+		case IDE3_MAJOR:
+		case IDE4_MAJOR:
+		case IDE5_MAJOR:
 			index = (minor & 0x0040) >> 6;
 			break;
-		case IDE1_MAJOR:
-			index = ((minor & 0x0040) >> 6) + 2;
+	        case SCSI_CDROM_MAJOR:
+			index = minor & 0x000f;
 			break;
 		default:
-			return 0;
+			if (major >= SCSI_DISK1_MAJOR && major <= SCSI_DISK7_MAJOR)
+				index = (minor & 0x00f0) >> 4;
+			else if (major >= DAC960_MAJOR && major <= DAC960_MAJOR + 7)
+				index = (minor & 0x00f8) >> 3;
+			else if (major >= IDE6_MAJOR && major <= IDE9_MAJOR)
+				index = (minor & 0x0040) >> 6;
+			else
+				return 0;
 	}
 	return index;
 }

--
Martin Wilck <mwilck@freenet.de>
Inst. for Tropospheric Research, Permoserstr. 15, 04303 Leipzig, Germany


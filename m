Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264183AbRFYTiH>; Mon, 25 Jun 2001 15:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265837AbRFYTh6>; Mon, 25 Jun 2001 15:37:58 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:7951 "EHLO energy.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S264183AbRFYTht>;
	Mon, 25 Jun 2001 15:37:49 -0400
Date: Mon, 25 Jun 2001 21:40:56 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] wrong disk index in /proc/stat
Message-ID: <Pine.LNX.4.30.0106252133180.13052-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I posted this patch already from my home mail account on June 20 (subject:
disk_index weirdness), but no one seems to have noticed - therefore I
try again. Those who _have_ noticed the other mail - sorry for bothering).

The disk_index routine erroneously adds 2 to the index of disks on the
first IDE controller which is wriong in 2.4, because disks are indexed
by major number now. The patch fixes this and adds support for some more
major numbers. (To fully benefit, DK_MAX_MAJOR in
include/linux/kernel_stat.h must be increased).

The patch is against plain 2.4.5.

Regards,
Martin

-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113

diff -ru linux-2.4.5/include/linux/genhd.h linux-2.4.5mw/include/linux/genhd.h
--- linux-2.4.5/include/linux/genhd.h	Tue Mar 27 01:48:11 2001
+++ linux-2.4.5mw/include/linux/genhd.h	Mon Jun 25 14:23:57 2001
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
+		case SCSI_CDROM_MAJOR:
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



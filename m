Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVBPWne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVBPWne (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 17:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVBPWnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 17:43:33 -0500
Received: from amdext4.amd.com ([163.181.251.6]:14990 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S262105AbVBPWnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 17:43:12 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Message-ID: <15FF3C77E196EA4888E281B9E0FF37150646B8@SBOSEXMB1.amd.com>
From: soohoon.lee@amd.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix units/partition count in sd.c (2.4.x)
Date: Wed, 16 Feb 2005 17:42:55 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-MMS-Spam-Filter-ID: A2005021606_IBF_2.0.0
X-WSS-ID: 6E0D13F80R8657031-01-01
Content-Type: multipart/mixed;
 boundary="----_=_NextPart_000_01C51478.A268D866"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C51478.A268D866
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit


Conincidentally I've found the same problem but fixed it differently.
Because nr_real is not real # of devices but max # of devices of a major #,
it doesn't need to be changed on disk add/remove.

1223c1223
< 		sd_gendisks[i].nr_real = 0;
---
> 		sd_gendisks[i].nr_real = SCSI_DISKS_PER_MAJOR;
1336d1335
< 	SD_GENDISK(i).nr_real++;
1450d1448
< 			SD_GENDISK(i).nr_real--;


2.6 has little different structure but it does like this

sd.c:sd_probe()
	gd->minors = 16;

Soohoon.


------_=_NextPart_000_01C51478.A268D866
Content-Type: application/octet-stream;
 name=diff.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=diff.patch

--- drivers/scsi/sd.c.org	2005-02-16 09:45:20.000000000 -0500=0A=
+++ drivers/scsi/sd.c	2005-02-16 09:45:38.000000000 -0500=0A=
@@ -1220,7 +1220,7 @@=0A=
 			goto cleanup_gendisks_part;=0A=
 		memset(sd_gendisks[i].part, 0, (SCSI_DISKS_PER_MAJOR << 4) * =
sizeof(struct hd_struct));=0A=
 		sd_gendisks[i].sizes =3D sd_sizes + (i * SCSI_DISKS_PER_MAJOR << =
4);=0A=
-		sd_gendisks[i].nr_real =3D 0;=0A=
+		sd_gendisks[i].nr_real =3D SCSI_DISKS_PER_MAJOR;=0A=
 		sd_gendisks[i].real_devices =3D=0A=
 		    (void *) (rscsi_disks + i * SCSI_DISKS_PER_MAJOR);=0A=
 	}=0A=
@@ -1333,7 +1333,6 @@=0A=
 	rscsi_disks[i].device =3D SDp;=0A=
 	rscsi_disks[i].has_part_table =3D 0;=0A=
 	sd_template.nr_dev++;=0A=
-	SD_GENDISK(i).nr_real++;=0A=
         devnum =3D i % SCSI_DISKS_PER_MAJOR;=0A=
         SD_GENDISK(i).de_arr[devnum] =3D SDp->de;=0A=
         if (SDp->removable)=0A=
@@ -1447,7 +1446,6 @@=0A=
 			SDp->attached--;=0A=
 			sd_template.dev_noticed--;=0A=
 			sd_template.nr_dev--;=0A=
-			SD_GENDISK(i).nr_real--;=0A=
 			return;=0A=
 		}=0A=
 	return;=0A=

------_=_NextPart_000_01C51478.A268D866--


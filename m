Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267646AbTA3V4A>; Thu, 30 Jan 2003 16:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267647AbTA3Vz7>; Thu, 30 Jan 2003 16:55:59 -0500
Received: from hera.cwi.nl ([192.16.191.8]:19865 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267646AbTA3Vz6>;
	Thu, 30 Jan 2003 16:55:58 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 30 Jan 2003 23:05:16 +0100 (MET)
Message-Id: <UTC200301302205.h0UM5GW22958.aeb@smtp.cwi.nl>
To: james@fsm.com.au, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: drivers/scsi/sd.c - Incorrect Reporting of Blocks and Capacity of Large SCSI Disk Arrays
Cc: marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: "James Bourne" <james@fsm.com.au>
|
| drivers/scsi/sd.c - Incorrect Reporting of Blocks and Capacity of Large 
| SCSI Disk Arrays
|
| This problem exists on both a custom 2.4.20 kernel and on a stock RedHat 
| 2.4.18-19.8.0smp kernel. This problem report pertains to the latter kernel.
|
| For example:
|
| SCSI device sdb: -562247552 512-byte hdwr sectors (4294679426 MB)
|  sdb: sdb1
| SCSI device sdc: -1997908992 512-byte hdwr sectors (76582 MB)
|  sdc: sdc1
|
| Array Capacity
|    Total unformatted capacity for Array 1: 1962814MB (1916.81GB, 1.87TB)
|    Total unformatted capacity for Array 2: 1261809MB (1232.23GB, 1.20TB)
-----

Please try the patch below.
Andries

----------------------------------------------------------------
>From aeb  Fri Dec 13 00:15:47 2002
To: anders.henke@sysiphus.de, linux-kernel@vger.kernel.org
Subject: Re: using 2 TB  in real life
Cc: marcelo@conectiva.com.br
Content-Length: 974

> SCSI device sdb: -320126976 512-byte hdwr sectors (-163904 MB)

Yes, the code in 2.4.20 works up to 30 bits.
A slight modification works up to 31 bits.
[This is cosmetic only.]

Andries

--- /linux/2.4/linux-2.4.20/linux/drivers/scsi/sd.c	Sat Aug  3 02:39:44 2002
+++ ./sd.c	Fri Dec 13 00:12:00 2002
@@ -1001,7 +1001,7 @@
 			 */
 			int m;
 			int hard_sector = sector_size;
-			int sz = rscsi_disks[i].capacity * (hard_sector/256);
+			unsigned int sz = (rscsi_disks[i].capacity/2) * (hard_sector/256);
 
 			/* There are 16 minors allocated for each major device */
 			for (m = i << 4; m < ((i + 1) << 4); m++) {
@@ -1009,9 +1009,9 @@
 			}
 
 			printk("SCSI device %s: "
-			       "%d %d-byte hdwr sectors (%d MB)\n",
+			       "%u %d-byte hdwr sectors (%u MB)\n",
 			       nbuff, rscsi_disks[i].capacity,
-			       hard_sector, (sz/2 - sz/1250 + 974)/1950);
+			       hard_sector, (sz - sz/625 + 974)/1950);
 		}
 
 		/* Rescale capacity to 512-byte units */


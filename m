Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268008AbUHPXDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268008AbUHPXDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUHPXCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:02:20 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:51860 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S268008AbUHPW7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:59:51 -0400
From: Andreas Messer <andreas.messer@gmx.de>
Reply-To: andreas.messer@gmx.de
To: linux-kernel@vger.kernel.org
Subject: [PATCH] change scsi_ioctl to allow cd-recording 2.6.8.1
Date: Tue, 17 Aug 2004 00:59:37 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZxTIBZZQGtc4KNR"
Message-Id: <200408170059.37152.satura@proton>
X-ID: VrxG+6ZDQe5NxWYh7v6G3EcrmwQwh8mqd3NsnvRMJrrNx0WRsSv5cM@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ZxTIBZZQGtc4KNR
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

this is my first Email to the kernel-mailing list. I hope i have understand 
the howto-post-a-patch the right way. 
As burning cd's as user is not possible with 2.6.8.1 without setting cdrecord 
setuid root and burning with k3b wont work at all, i decided to change 
driver/block/scsi_ioctl.c to allow it again. I allowed the commands listended 
in MMC-2 paper. Burning cds with k3b works now fine again, burning dvds 
should also work again. 

regards
Andreas
-- 
gnuPG keyid: 0xE94F63B7 fingerprint: D189 D5E3 FF4B 7E24 E49D 7638 07C5 924C 
E94F 63B7

--Boundary-00=_ZxTIBZZQGtc4KNR
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="patch-scsi_ioctl-cdrecord"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-scsi_ioctl-cdrecord"

--- linux-2.6.8.1/drivers/block/scsi_ioctl.c	2004-08-16 21:44:53.000000000 +0200
+++ linux/drivers/block/scsi_ioctl.c	2004-08-17 00:53:12.000000000 +0200
@@ -156,6 +156,35 @@
 		safe_for_write(WRITE_16),
 		safe_for_write(WRITE_BUFFER),
 		safe_for_write(WRITE_LONG),
+
+                /* Some defs for recording CDs */
+
+                /* obsolete: 0x01 REZERO_UNIT, 0x5c READ_BUFFER */
+		/*           used by k3b, but also work without */
+
+
+                safe_for_read(GPCMD_GET_CONFIGURATION),
+                safe_for_read(GPCMD_MODE_SELECT_10), /* read needed by k3b */
+                safe_for_read(GPCMD_SET_SPEED), /* obsolete but often used */
+                safe_for_read(GPCMD_LOAD_UNLOAD),
+
+                safe_for_write(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL),
+                safe_for_write(GPCMD_FLUSH_CACHE),
+                safe_for_write(GPCMD_CLOSE_TRACK),
+                safe_for_write(GPCMD_FORMAT_UNIT),
+                safe_for_write(GPCMD_BLANK),
+                safe_for_write(GPCMD_READ_FORMAT_CAPACITIES),
+                safe_for_write(GPCMD_RESERVE_RZONE_TRACK),
+                safe_for_write(GPCMD_SEND_KEY),
+                safe_for_write(GPCMD_SEND_OPC),
+                safe_for_write(GPCMD_SET_STREAMING),
+
+                /* possibly needed: 0x5d SEND_CUE_SHEET/SEND_EVENT*/
+                /*                  0xbf SEND_DVD_STRUCTURE */
+                /* but not defined yet in linux/cdrom.h */
+
+                safe_for_write(0x5d),
+                safe_for_write(0xbf),
 	};
 	unsigned char type = cmd_type[cmd[0]];
 
@@ -173,6 +202,14 @@
 	if (capable(CAP_SYS_RAWIO))
 		return 0;
 
+        /* Added for debugging*/
+       
+	if(file->f_mode & FMODE_WRITE)
+	  printk(KERN_WARNING "SCSI-CMD Filter: 0x%x not allowed with write-mode\n",cmd[0]);
+        else
+          printk(KERN_WARNING "SCSI-CMD Filter: 0x%x not allowed with read-mode\n",cmd[0]);
+
+
 	/* Otherwise fail it with an "Operation not permitted" */
 	return -EPERM;
 }

--Boundary-00=_ZxTIBZZQGtc4KNR
Content-Type: text/plain;
  charset="iso-8859-15";
  name="readme"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="readme"

andreas.messer@gmx.de  allows users to record cd's
--Boundary-00=_ZxTIBZZQGtc4KNR--

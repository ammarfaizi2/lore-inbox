Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVAVCaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVAVCaZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 21:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbVAVCaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 21:30:25 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:41976 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262507AbVAVCaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 21:30:11 -0500
From: Elias da Silva <silva@aurigatec.de>
Organization: aurigatec Informationssysteme GmbH
To: Jens Axboe <axboe@suse.de>
Subject: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
Date: Sat, 22 Jan 2005 03:27:38 +0100
User-Agent: KMail/1.7.2
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aob8BjVjx/IcJDW"
Message-Id: <200501220327.38236.silva@aurigatec.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:71cf304d62c8802a383a5ddf42c5bd08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_aob8BjVjx/IcJDW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Moin.

Attached patch fixes a problem of reading Video DVDs
through the cdrom_ioctl interface. VMware is among
the prominent victims.

The bug was introduced in kernel version 2.6.8 in the
function verify_command().

Regards,

Elias da Silva

--Boundary-00=_aob8BjVjx/IcJDW
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="linux-2.6.10-dvd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.10-dvd.patch"

--- linux-2.6.10/drivers/block/scsi_ioctl.c	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.10-dvd/drivers/block/scsi_ioctl.c	2005-01-22 02:31:28.223951296 +0100
@@ -159,6 +159,11 @@
 		safe_for_read(GPCMD_SEEK),
 		safe_for_read(GPCMD_STOP_PLAY_SCAN),
 
+                /* Video DVD playback support */
+		safe_for_read(GPCMD_SET_STREAMING),
+		safe_for_read(GPCMD_SEND_KEY),
+                /* safe_for_read(0xe9), missing this opcode definition */
+
 		/* Basic writing commands */
 		safe_for_write(WRITE_6),
 		safe_for_write(WRITE_10),
@@ -179,13 +184,11 @@
 		safe_for_write(GPCMD_RESERVE_RZONE_TRACK),
 		safe_for_write(GPCMD_SEND_DVD_STRUCTURE),
 		safe_for_write(GPCMD_SEND_EVENT),
-		safe_for_write(GPCMD_SEND_KEY),
 		safe_for_write(GPCMD_SEND_OPC),
 		safe_for_write(GPCMD_SEND_CUE_SHEET),
 		safe_for_write(GPCMD_SET_SPEED),
 		safe_for_write(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL),
 		safe_for_write(GPCMD_LOAD_UNLOAD),
-		safe_for_write(GPCMD_SET_STREAMING),
 	};
 	unsigned char type = cmd_type[cmd[0]];
 
@@ -194,13 +197,11 @@
 		return 0;
 
 	/* Write-safe commands just require a writable open.. */
-	if (type & CMD_WRITE_SAFE) {
-		if (file->f_mode & FMODE_WRITE)
-			return 0;
-	}
+	if ((type & CMD_WRITE_SAFE) && (file->f_mode & FMODE_WRITE))
+		return 0;
 
-	if (!(type & CMD_WARNED)) {
-		cmd_type[cmd[0]] = CMD_WARNED;
+	if (!type) {
+		type = cmd_type[cmd[0]] = CMD_WARNED;
 		printk(KERN_WARNING "scsi: unknown opcode 0x%02x\n", cmd[0]);
 	}
 
@@ -208,7 +209,14 @@
 	if (capable(CAP_SYS_RAWIO))
 		return 0;
 
-	/* Otherwise fail it with an "Operation not permitted" */
+        if (!(type & CMD_WARNED))
+        {
+          cmd_type[cmd[0]] |= CMD_WARNED;
+          printk(KERN_WARNING "scsi: opcode 0x%02x write/rawio"
+                 " permission denied\n", cmd[0]);
+        }
+
+        /* Otherwise fail it with an "Operation not permitted" */
 	return -EPERM;
 }
 

--Boundary-00=_aob8BjVjx/IcJDW--

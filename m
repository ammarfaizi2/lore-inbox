Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268335AbUHQQBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268335AbUHQQBa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268272AbUHQQAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:00:46 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:11169 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S268322AbUHQP7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:59:36 -0400
Date: Tue, 17 Aug 2004 17:59:27 +0200
To: linux-kernel@vger.kernel.org
Cc: Ballarin.Marc@gmx.de, fsteiner-mail@bio.ifi.lmu.de, christer@weinigel.se
Subject: [PATCH] 2.6.8.1 Mis-detect CRDW as CDROM
Message-ID: <20040817155927.GA19546@proton-satura-home>
References: <411FD919.9030702@comcast.net> <20040816231211.76360eaa.Ballarin.Marc@gmx.de> <4121A689.8030708@bio.ifi.lmu.de> <200408171311.06222.satura@proton>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200408171311.06222.satura@proton>
User-Agent: Mutt/1.5.6+20040722i
From: Andreas Messer <andreas.messer@gmx.de>
X-ID: GEHzPaZDZe1SAlYf2r3tfjj328zFewB0zsLRt1w-j5eUe2ssTf8XZA@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

as i get informed, that the kmail emailclient has not made
what i want, i decided to use mutt for next time. I will
include the patch again to make it readable. I have also
changed the thing with MODE_SELECT_10 to write mode 
because Christer Weinig figured out, that this CMD may
be insecure in connection with harddisks.
The changes to cdrom.h made by Marc Ballarin have not yet 
been included.
But i think, that the security model should made more 
precise - deciding only upon the commands does not give
the effekt of much improved security.

Here ist the patch.

--- linux-2.6.8.1/drivers/block/scsi_ioctl.c	2004-08-16 21:44:53.000000000 +0200
+++ linux/drivers/block/scsi_ioctl.c	2004-08-17 17:41:54.000000000 +0200
@@ -156,6 +156,54 @@
 		safe_for_write(WRITE_16),
 		safe_for_write(WRITE_BUFFER),
 		safe_for_write(WRITE_LONG),
+
+
+		/* Some additional defs for recording/reading CDs */
+
+		/* 0x01 REZERO_UNIT used by k3b, but also work without */
+               
+		/* read-mode */
+		safe_for_read(GPCMD_GET_CONFIGURATION),
+		safe_for_read(GPCMD_GET_EVENT_STATUS_NOTIFICATION),
+		safe_for_read(GPCMD_GET_PERFORMANCE),
+		safe_for_read(GPCMD_MECHANISM_STATUS),
+
+		/* should this allowed for read ? */
+		safe_for_read(GPCMD_LOAD_UNLOAD),
+		safe_for_read(GPCMD_SET_SPEED),
+		safe_for_read(GPCMD_PAUSE_RESUME),   /* playing audio cd */
+		safe_for_read(SEEK_10),              /* playing audio cd */
+		safe_for_read(GPCMD_SET_READ_AHEAD),
+		safe_for_read(GPCMD_SET_STREAMING),
+		safe_for_read(GPCMD_STOP_PLAY_SCAN), /* playing audio cd */
+
+		/* k3b wont work without read - maybe bug in k3b, but 
+		   MODE_SELECT_10 seems to destroy data in conjunction
+                   with harddisk */
+		safe_for_write(GPCMD_MODE_SELECT_10), 
+
+		/* write-mode */
+		safe_for_write(GPCMD_BLANK), 
+		safe_for_write(GPCMD_CLOSE_TRACK),
+		safe_for_write(0x2c),        /* ERASE_10 */ 
+		safe_for_write(GPCMD_FORMAT_UNIT),
+		safe_for_write(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL),
+		safe_for_write(0x5c),        /* READ_BUFFER_CAPACITY */
+		safe_for_write(GPCMD_READ_FORMAT_CAPACITIES),
+		safe_for_write(GPCMD_REPAIR_RZONE_TRACK),
+		safe_for_write(GPCMD_RESERVE_RZONE_TRACK),
+		safe_for_write(0x5d),        /* SEND_CUE_SHEET */
+		safe_for_write(0xbf),        /* SEND_DVD_STRUCTURE */
+		safe_for_write(GPCMD_SEND_KEY),
+		safe_for_write(GPCMD_SEND_OPC),
+		safe_for_write(SYNCHRONIZE_CACHE),
+		safe_for_write(VERIFY),
+
+		/* Disabled, may change firmware 
+		   safe_for_write(0x3b),  WRITE_BUFFER */
+		/* Disabled due useless without WRITE_BUFFER 
+		   safe_for_write(0x3c),  READ_BUFFER */
+
 	};
 	unsigned char type = cmd_type[cmd[0]];
 
@@ -173,6 +221,14 @@
 	if (capable(CAP_SYS_RAWIO))
 		return 0;
 
+        /* Added for debugging*/
+       
+	if(file->f_mode & FMODE_WRITE)
+	  printk(KERN_WARNING "SCSI-CMD Filter: 0x%x not allowed with write-mode\n",cmd[0]);
+	else
+	  printk(KERN_WARNING "SCSI-CMD Filter: 0x%x not allowed with read-mode\n",cmd[0]);
+
+
 	/* Otherwise fail it with an "Operation not permitted" */
 	return -EPERM;
 }

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVAEV7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVAEV7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVAEV7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:59:31 -0500
Received: from mail.aknet.ru ([217.67.122.194]:9231 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262608AbVAEV5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:57:44 -0500
Message-ID: <41DC62DE.6000907@aknet.ru>
Date: Thu, 06 Jan 2005 00:57:50 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Alexander Kern <alex.kern@gmx.de>
Subject: [patch] fix cdrom autoclose
Content-Type: multipart/mixed;
 boundary="------------070501070403030900060201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070501070403030900060201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

The attached patch fixes the CD-ROM
autoclose. It is broken in recent
kernels for CD-ROMs that do not properly
report that the tray is opened.
Now on such a drives the kernel will do
one close attempt and check for the disc
again. This is how it used to work in the
past.

Can this please be applied?

Acked-by: Alexander Kern <alex.kern@gmx.de>
Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------070501070403030900060201
Content-Type: text/x-patch;
 name="cd_clo1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cd_clo1.diff"

--- linux/drivers/cdrom/cdrom.c	2004-12-28 14:49:56.000000000 +0300
+++ linux/drivers/cdrom/cdrom.c	2004-12-28 14:55:09.228038640 +0300
@@ -1076,6 +1076,8 @@
 			}
 			cdinfo(CD_OPEN, "the tray is now closed.\n"); 
 		}
+		/* the door should be closed now, check for the disc */
+		ret = cdo->drive_status(cdi, CDSL_CURRENT);
 		if (ret!=CDS_DISC_OK) {
 			ret = -ENOMEDIUM;
 			goto clean_up_and_return;
--- linux/drivers/ide/ide-cd.c	2004-12-28 09:15:40.000000000 +0300
+++ linux/drivers/ide/ide-cd.c	2004-12-28 14:46:44.119826760 +0300
@@ -2744,9 +2744,9 @@
 	 */
 	if (sense.sense_key == NOT_READY) {
 		if (sense.asc == 0x3a) {
-			if (sense.ascq == 0 || sense.ascq == 1)
+			if (sense.ascq == 1)
 				return CDS_NO_DISC;
-			else if (sense.ascq == 2)
+			else if (sense.ascq == 0 || sense.ascq == 2)
 				return CDS_TRAY_OPEN;
 		}
 	}

--------------070501070403030900060201--

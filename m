Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUL2SMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUL2SMb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 13:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUL2SMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 13:12:31 -0500
Received: from mail.aknet.ru ([217.67.122.194]:27922 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261389AbUL2SMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 13:12:24 -0500
Message-ID: <41D2F386.8060507@aknet.ru>
Date: Wed, 29 Dec 2004 21:12:22 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>
Subject: bug: cd-rom autoclose no longer works (fix attempt)
Content-Type: multipart/mixed;
 boundary="------------040809070707040009030107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040809070707040009030107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

CD-ROM autoclose stopped working in
2.6 kernels quite some time ago.
Attached is the patch that fixes it
for me.
The ide-cd.c change is as per 2.4.20
which works. For some reasons
sense.ascq == 0 for me when the tray
is opened.
The cdrom.c change is here because
rigth after the tray closed,
drive_status() returns CDS_DISK_OK
even when there is no disk, which
probably only means that the tray
was successfully closed. Calling
drive_status() again gets the right
status.
With this patch autoclose works again.
Can someone please make any sense
out of it?

--------------040809070707040009030107
Content-Type: text/x-patch;
 name="cd_clo.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cd_clo.diff"

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
@@ -2743,12 +2743,10 @@
 	 * any other way to detect this...
 	 */
 	if (sense.sense_key == NOT_READY) {
-		if (sense.asc == 0x3a) {
-			if (sense.ascq == 0 || sense.ascq == 1)
-				return CDS_NO_DISC;
-			else if (sense.ascq == 2)
-				return CDS_TRAY_OPEN;
-		}
+		if (sense.asc == 0x3a && sense.ascq == 1)
+			return CDS_NO_DISC;
+		else
+			return CDS_TRAY_OPEN;
 	}
 
 	return CDS_DRIVE_NOT_READY;

--------------040809070707040009030107--

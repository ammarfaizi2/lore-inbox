Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUH0QiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUH0QiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266550AbUH0QiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:38:22 -0400
Received: from tantale.fifi.org ([216.27.190.146]:42885 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S266547AbUH0QiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:38:19 -0400
To: <Ganesh_Borse@Dell.com>
Cc: <linux-kernel-owner@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: CDROMPLAYTRKIND ioctl causing server hang
References: <BBE1167D4F12C74681106630ADE282B964A025@blrx2kmbgl303.blr.amer.dell.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 27 Aug 2004 09:38:17 -0700
In-Reply-To: <BBE1167D4F12C74681106630ADE282B964A025@blrx2kmbgl303.blr.amer.dell.com>
Message-ID: <87llg0tu2u.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

<Ganesh_Borse@Dell.com> writes:

> (4) Is there a known issue in 2.4.21-4 kernel related to
> CDROMPLAYTRKIND ioctl or usb driver? If yes, what is Bugzilla id for
> it?

This patch does it for me, but of course it's a ugly hack...

Phil.

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.4.27-2-scsicdrom.patch

diff -ruN linux-2.4.27.orig/drivers/scsi/sr.c linux-2.4.27/drivers/scsi/sr.c
--- linux-2.4.27.orig/drivers/scsi/sr.c	Fri Jun 13 07:51:36 2003
+++ linux-2.4.27/drivers/scsi/sr.c	Mon Aug  9 15:34:08 2004
@@ -59,7 +59,7 @@
 MODULE_PARM(xa_test, "i");	/* see sr_ioctl.c */
 
 #define MAX_RETRIES	3
-#define SR_TIMEOUT	(30 * HZ)
+#define SR_TIMEOUT	(180 * HZ)
 
 static int sr_init(void);
 static void sr_finish(void);
diff -ruN linux-2.4.27.orig/drivers/scsi/sr_ioctl.c linux-2.4.27/drivers/scsi/sr_ioctl.c
--- linux-2.4.27.orig/drivers/scsi/sr_ioctl.c	Thu Nov 28 15:53:14 2002
+++ linux-2.4.27/drivers/scsi/sr_ioctl.c	Mon Aug  9 15:34:08 2004
@@ -392,9 +392,9 @@
 		sr_cmd[4] = ti->cdti_trk0;
 		sr_cmd[5] = ti->cdti_ind0;
 		sr_cmd[7] = ti->cdti_trk1;
-		sr_cmd[8] = ti->cdti_ind1;
+		sr_cmd[8] = (ti->cdti_ind1 == 99 ? 0 : ti->cdti_ind1);
 
-		result = sr_do_ioctl(target, sr_cmd, NULL, 0, 0, SCSI_DATA_NONE, NULL);
+		result = sr_do_ioctl(target, sr_cmd, NULL, 0, 1, SCSI_DATA_NONE, NULL);
 		if (result == -EDRIVE_CANT_DO_THIS)
 			result = sr_fake_playtrkind(cdi, ti);
 

--=-=-=--

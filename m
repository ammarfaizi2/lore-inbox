Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbUL0F0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbUL0F0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 00:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbUL0F0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 00:26:47 -0500
Received: from 181.Red-80-24-145.pooles.rima-tde.net ([80.24.145.181]:31616
	"EHLO minibar") by vger.kernel.org with ESMTP id S261749AbUL0F0p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 00:26:45 -0500
From: David Martin <tasio@tasio.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SCSI not showing tray status correctly
Date: Mon, 27 Dec 2004 06:26:32 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412270626.32643.tasio@tasio.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to get the drive status via ioctl CDROM_DRIVE_STATUS, with no disk 
it gives CDS_TRAY_OPEN even if the tray is closed.

ioctl works as expected with ide-cd driver. Here is the patch to get the same 
behaviour on SCSI drives for kernel 2.6.10. 2.4 branch have same problem.



--- linux-2.6.10-orig/drivers/scsi/sr_ioctl.c        2004-12-27 
04:47:22.000000000 +0100
+++ linux-2.6.10/drivers/scsi/sr_ioctl.c     2004-12-27 05:54:08.000000000 
+0100
@@ -216,14 +216,20 @@

 int sr_drive_status(struct cdrom_device_info *cdi, int slot)
 {
+       struct media_event_desc med;
+
        if (CDSL_CURRENT != slot) {
                /* we have no changer support */
                return -EINVAL;
        }
+
        if (0 == test_unit_ready(cdi->handle))
                return CDS_DISC_OK;

-       return CDS_TRAY_OPEN;
+       if (!cdrom_get_media_event(cdi, &med) && med.door_open)
+               return CDS_TRAY_OPEN;
+
+       return CDS_NO_DISC;
 }

 int sr_disk_status(struct cdrom_device_info *cdi)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUARTMU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 14:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbUARTMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 14:12:20 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:13835 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263228AbUARTMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 14:12:16 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: 2.6.1: media change check fails for busy unplugged device
Date: Sun, 18 Jan 2004 21:41:12 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401182141.12468.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we unplug busy device (consider mounted USB stick) media change check 
always returns true (no media change happened). It happens because

- device state is set to SDEV_DEL and scsi_prep_fn silently kills any request 
including TEST_UNIT_READY sent by sd_media_changed without propagating any 
information back to caller

- sdev->online still remains TRUE

so nothing ever tells sd_media_changed that device is gone.

this effectively prevents supermount from noticing that it needs remount 
subfs.

What is the right place to catch those deleted device? For now I add this as 
part of supermount patch, but it looks too ugly (and in the wrong place):

--- linux-2.6.1/drivers/scsi/sd.c       29 Dec 2003 17:20:12 -0000
+++ linux-2.6.1/drivers/scsi/sd.c       18 Jan 2004 18:20:54 -0000
@@ -620,6 +622,16 @@ static int sd_media_changed(struct gendi
                 goto not_present;

        /*
+        * FIXME HACK
+        * busy device that is unplugged is SDEV_DEL but online and ioctl
+        * does not return any error. Oh well, it is likely layering
+        * violation but for now it enables media checks for supermount
+        */
+
+       if (sdp->sdev_state == SDEV_DEL)
+               goto not_present;
+
+       /*
         * For removable scsi disk we have to recognise the presence
         * of a disk in the drive. This is kept in the struct scsi_disk
         * struct and tested at open !  Daniel Roche (dan@lectra.fr)
 
TIA

-andrey


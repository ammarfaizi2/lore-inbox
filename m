Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUFGNF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUFGNF2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUFGNFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 09:05:22 -0400
Received: from p10068181.pureserver.de ([217.160.75.209]:19 "EHLO www.kuix.de")
	by vger.kernel.org with ESMTP id S264686AbUFGNBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 09:01:00 -0400
Message-ID: <40C466FB.1040309@kuix.de>
Date: Mon, 07 Jun 2004 15:00:43 +0200
From: Kai Engert <kaie@kuix.de>
Reply-To: kai.engert@gmx.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040322 wamcom.org
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, webcam@smcc.demon.nl
Subject: small patch: enable pwc usb camera driver
Content-Type: multipart/mixed;
 boundary="------------070303080403090804050701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070303080403090804050701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch enables the pwc driver included with kernel 2.6.7-rc2

It also removes the warnings during compilation.
However, note that I blindly duplicated the release approach used by 
other usb camera drivers, replacing the current no-op.

The driver works for me with a Logitech QuickCam Notebook Pro and 
GnomeMeeting.

Regards,
Kai

--------------070303080403090804050701
Content-Type: text/plain;
 name="pwcdiff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pwcdiff"

diff -ruw org/linux-2.6.7-rc2/drivers/usb/media/Kconfig linux-2.6.7-rc2/drivers/usb/media/Kconfig
--- org/linux-2.6.7-rc2/drivers/usb/media/Kconfig	2004-05-30 08:25:41.000000000 +0200
+++ linux-2.6.7-rc2/drivers/usb/media/Kconfig	2004-06-07 11:27:03.000000000 +0200
@@ -108,7 +108,7 @@
 
 config USB_PWC
 	tristate "USB Philips Cameras"
-	depends on USB && VIDEO_DEV && BROKEN
+	depends on USB && VIDEO_DEV
 	---help---
 	  Say Y or M here if you want to use one of these Philips & OEM
           webcams:
diff -ruw org/linux-2.6.7-rc2/drivers/usb/media/pwc-if.c linux-2.6.7-rc2/drivers/usb/media/pwc-if.c
--- org/linux-2.6.7-rc2/drivers/usb/media/pwc-if.c	2004-05-30 08:26:27.000000000 +0200
+++ linux-2.6.7-rc2/drivers/usb/media/pwc-if.c	2004-06-07 11:42:50.000000000 +0200
@@ -129,7 +129,6 @@
 
 static int pwc_video_open(struct inode *inode, struct file *file);
 static int pwc_video_close(struct inode *inode, struct file *file);
-static int pwc_video_release(struct video_device *);			  
 static ssize_t pwc_video_read(struct file *file, char *buf,
 			  size_t count, loff_t *ppos);
 static unsigned int pwc_video_poll(struct file *file, poll_table *wait);
@@ -1121,12 +1120,6 @@
 	return 0;
 }
 
-static int pwc_video_release(struct video_device *vfd)
-{
-	Trace(TRACE_OPEN, "pwc_video_release() called. Now what?\n");
-}
-		
-
 /*
  *	FIXME: what about two parallel reads ????
  *      ANSWER: Not supported. You can't open the device more than once,
@@ -1855,7 +1848,7 @@
 		}
 	}
 
-	pdev->vdev.release = pwc_video_release;
+	pdev->vdev.release = video_device_release;
 	i = video_register_device(&pdev->vdev, VFL_TYPE_GRABBER, video_nr);
 	if (i < 0) {
 		Err("Failed to register as video device (%d).\n", i);

--------------070303080403090804050701--


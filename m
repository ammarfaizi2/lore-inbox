Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRCWEWc>; Thu, 22 Mar 2001 23:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129466AbRCWEWX>; Thu, 22 Mar 2001 23:22:23 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:44202 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129464AbRCWEWK>; Thu, 22 Mar 2001 23:22:10 -0500
Date: Thu, 22 Mar 2001 23:21:14 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pete Zaitcev <zaitcev@redhat.com>
Subject: Please review patchlet for ov511 (2.4.2-ac19)
Message-ID: <20010322232114.B14771@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the deal:

we have a guy here with a webcam and the following scenario:
1. ov511 disconnects, everything dies/releases/closes fine,
2. webcam soft starts polling open/sleep/open/sleep/...
3. ov511_probe works and reaches ov511_configure,
   calls video_register_device().
4. Webcam software opens and oopses on the semafore
   that was not initialized yet.

I think video_register_device needs to be done last, when
everything else is ready to accept appliction requests.

Someone please review. The error handling style
of ov511 spins my head. I may be missing a code path somewhere.

Thanks in advance,
-- Pete

--- linux-2.4.2-ac19/drivers/usb/ov511.c	Thu Jan  4 13:15:32 2001
+++ linux-2.4.2-ac19-p3/drivers/usb/ov511.c	Thu Mar 22 19:55:59 2001
@@ -3141,11 +3141,6 @@
 
 	init_waitqueue_head(&ov511->wq);
 
-	if (video_register_device(&ov511->vdev, VFL_TYPE_GRABBER) < 0) {
-		err("video_register_device failed");
-		return -EBUSY;
-	}
-
 	if (ov511_write_regvals(dev, aRegvalsInit)) goto error;
 	if (ov511_write_regvals(dev, aRegvalsNorm511)) goto error;
 
@@ -3214,7 +3209,6 @@
 	return 0;
 	
 error:
-	video_unregister_device(&ov511->vdev);
 	usb_driver_release_interface(&ov511_driver,
 		&dev->actconfig->interface[ov511->iface]);
 
@@ -3323,6 +3317,11 @@
 		ov511->buf_state = BUF_NOT_ALLOCATED;
 	} else {
 		err("Failed to configure camera");
+		goto error;
+	}
+
+	if (video_register_device(&ov511->vdev, VFL_TYPE_GRABBER) < 0) {
+		err("video_register_device failed");
 		goto error;
 	}
 

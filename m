Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265383AbUG2O0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUG2O0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUG2OJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:09:42 -0400
Received: from styx.suse.cz ([82.119.242.94]:30870 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265048AbUG2OIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:14 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 44/47] This patch fixes another disconnect oops in hiddev.
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101962274@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101962613@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1757.50.5, 2004-07-05 13:38:52+02:00, akropel1@rochester.rr.com
  This patch fixes another disconnect oops in hiddev.
  
  hid-core calls hiddev_disconnect() when the underlying device goes away
  (hot unplug or system shutdown). Normally, hiddev_disconnect() will
  clean up nicely and return to hid-core who then frees the hid structure.
  However, if the corresponding hiddev node is open at disconnect time,
  hiddev delays the majority of disconnect work until the device is closed
  via hiddev_release(). hiddev_release() calls hiddev_cleanup() which
  proceeds to dereference the hid struct which hid-core freed back when   
  the hardware was disconnected. Oops.
  
  To solve this, we change hiddev_disconnect() to deregister the hiddev
  minor and invalidate its table entry immediately and delay only the
  freeing of the hiddev structure itself. We're protected against future
  operations on the fd since the major fops check hiddev->exists.
  
  There may still be an ordering of events that causes a problem but I can
  no longer reproduce any manually. There are enough different subsystems
  and object lifetimes interacting here that I may have screwed something
  else up; review is certainly welcome.
  
  Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hiddev.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Thu Jul 29 14:38:38 2004
+++ b/drivers/usb/input/hiddev.c	Thu Jul 29 14:38:38 2004
@@ -226,16 +226,6 @@
 	return retval < 0 ? retval : 0;
 }
 
-/*
- * De-allocate a hiddev structure
- */
-static struct usb_class_driver hiddev_class;
-static void hiddev_cleanup(struct hiddev *hiddev)
-{
-	hiddev_table[hiddev->hid->minor - HIDDEV_MINOR_BASE] = NULL;
-	usb_deregister_dev(hiddev->hid->intf, &hiddev_class);
-	kfree(hiddev);
-}
 
 /*
  * release file op
@@ -256,7 +246,7 @@
 		if (list->hiddev->exist) 
 			hid_close(list->hiddev->hid);
 		else
-			hiddev_cleanup(list->hiddev);
+			kfree(list->hiddev);
 	}
 
 	kfree(list);
@@ -804,17 +794,21 @@
  * This is where hid.c calls us to disconnect a hiddev device from the
  * corresponding hid device (usually because the usb device has disconnected)
  */
+static struct usb_class_driver hiddev_class;
 void hiddev_disconnect(struct hid_device *hid)
 {
 	struct hiddev *hiddev = hid->hiddev;
 
 	hiddev->exist = 0;
 
+	hiddev_table[hiddev->hid->minor - HIDDEV_MINOR_BASE] = NULL;
+	usb_deregister_dev(hiddev->hid->intf, &hiddev_class);
+
 	if (hiddev->open) {
 		hid_close(hiddev->hid);
 		wake_up_interruptible(&hiddev->wait);
 	} else {
-		hiddev_cleanup(hiddev);
+		kfree(hiddev);
 	}
 }
 


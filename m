Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbUKPVta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbUKPVta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbUKPVsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:48:22 -0500
Received: from sd291.sivit.org ([194.146.225.122]:26065 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261847AbUKPVqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:46:50 -0500
Date: Tue, 16 Nov 2004 22:47:11 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] sonypi: return an error from sonypi_camera_command() if the camera isn't enabled
Message-ID: <20041116214709.GA3313@crusoe.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sonypi_camera_command() used to fail without returning an error
code if the user fergot to enable the camera in the sonypi module
(using the camera=1 module parameter). This caused the meye driver
to apparently load correctly but miserably fail later, when trying
to access the camera for getting some data out of it.
  
This patch adds an error code to sonypi_camera_command() and makes
the meye driver check for it in the PCI probe routine. If the function
fails, a message is printed in the kernel logs reminding the user it
should better RTFM.
  
The patch also removes some sonypi_camera_command() commands (those
supposed to return the current camera settings) which are unreliable.
The meye driver does not use them anyway.

Please apply.

Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 drivers/char/sonypi.c      |   47 ++++++++-------------------------------------
 drivers/char/sonypi.h      |    2 -
 drivers/media/video/meye.c |    8 ++++++-
 drivers/media/video/meye.h |    2 -
 include/linux/sonypi.h     |   24 +++++++++++-----------
 5 files changed, 30 insertions(+), 53 deletions(-)

===================================================================

diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	2004-11-16 20:41:10 +01:00
+++ b/drivers/char/sonypi.c	2004-11-16 20:41:10 +01:00
@@ -232,6 +232,8 @@
 	return v1;
 }
 
+#if 0
+/* Get brightness, hue etc. Unreliable... */
 static u8 sonypi_read(u8 fn)
 {
 	u8 v1, v2;
@@ -245,6 +247,7 @@
 	}
 	return 0xff;
 }
+#endif
 
 /* Set brightness, hue etc */
 static void sonypi_set(u8 fn, u8 v)
@@ -435,80 +438,48 @@
 }
 
 /* External camera command (exported to the motion eye v4l driver) */
-u8 sonypi_camera_command(int command, u8 value)
+int sonypi_camera_command(int command, u8 value)
 {
-	u8 ret = 0;
-
 	if (!camera)
-		return 0;
+		return -EIO;
 
 	down(&sonypi_device.lock);
 
 	switch (command) {
-	case SONYPI_COMMAND_GETCAMERA:
-		ret = sonypi_camera_ready();
-		break;
 	case SONYPI_COMMAND_SETCAMERA:
 		if (value)
 			sonypi_camera_on();
 		else
 			sonypi_camera_off();
 		break;
-	case SONYPI_COMMAND_GETCAMERABRIGHTNESS:
-		ret = sonypi_read(SONYPI_CAMERA_BRIGHTNESS);
-		break;
 	case SONYPI_COMMAND_SETCAMERABRIGHTNESS:
 		sonypi_set(SONYPI_CAMERA_BRIGHTNESS, value);
 		break;
-	case SONYPI_COMMAND_GETCAMERACONTRAST:
-		ret = sonypi_read(SONYPI_CAMERA_CONTRAST);
-		break;
 	case SONYPI_COMMAND_SETCAMERACONTRAST:
 		sonypi_set(SONYPI_CAMERA_CONTRAST, value);
 		break;
-	case SONYPI_COMMAND_GETCAMERAHUE:
-		ret = sonypi_read(SONYPI_CAMERA_HUE);
-		break;
 	case SONYPI_COMMAND_SETCAMERAHUE:
 		sonypi_set(SONYPI_CAMERA_HUE, value);
 		break;
-	case SONYPI_COMMAND_GETCAMERACOLOR:
-		ret = sonypi_read(SONYPI_CAMERA_COLOR);
-		break;
 	case SONYPI_COMMAND_SETCAMERACOLOR:
 		sonypi_set(SONYPI_CAMERA_COLOR, value);
 		break;
-	case SONYPI_COMMAND_GETCAMERASHARPNESS:
-		ret = sonypi_read(SONYPI_CAMERA_SHARPNESS);
-		break;
 	case SONYPI_COMMAND_SETCAMERASHARPNESS:
 		sonypi_set(SONYPI_CAMERA_SHARPNESS, value);
 		break;
-	case SONYPI_COMMAND_GETCAMERAPICTURE:
-		ret = sonypi_read(SONYPI_CAMERA_PICTURE);
-		break;
 	case SONYPI_COMMAND_SETCAMERAPICTURE:
 		sonypi_set(SONYPI_CAMERA_PICTURE, value);
 		break;
-	case SONYPI_COMMAND_GETCAMERAAGC:
-		ret = sonypi_read(SONYPI_CAMERA_AGC);
-		break;
 	case SONYPI_COMMAND_SETCAMERAAGC:
 		sonypi_set(SONYPI_CAMERA_AGC, value);
 		break;
-	case SONYPI_COMMAND_GETCAMERADIRECTION:
-		ret = sonypi_read(SONYPI_CAMERA_STATUS);
-		ret &= SONYPI_DIRECTION_BACKWARDS;
-		break;
-	case SONYPI_COMMAND_GETCAMERAROMVERSION:
-		ret = sonypi_read(SONYPI_CAMERA_ROMVERSION);
-		break;
-	case SONYPI_COMMAND_GETCAMERAREVISION:
-		ret = sonypi_read(SONYPI_CAMERA_REVISION);
+	default:
+		printk(KERN_ERR "sonypi: sonypi_camera_command invalid: %d\n",
+		       command);
 		break;
 	}
 	up(&sonypi_device.lock);
-	return ret;
+	return 0;
 }
 
 EXPORT_SYMBOL(sonypi_camera_command);
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	2004-11-16 20:41:10 +01:00
+++ b/drivers/char/sonypi.h	2004-11-16 20:41:10 +01:00
@@ -36,7 +36,7 @@
 
 #ifdef __KERNEL__
 
-#define SONYPI_DRIVER_VERSION	 "1.24"
+#define SONYPI_DRIVER_VERSION	 "1.25"
 
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	2004-11-16 20:41:10 +01:00
+++ b/drivers/media/video/meye.c	2004-11-16 20:41:10 +01:00
@@ -1842,7 +1842,12 @@
 	memcpy(meye.video_dev, &meye_template, sizeof(meye_template));
 	meye.video_dev->dev = &meye.mchip_dev->dev;
 
-	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 1);
+	if ((ret = sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 1))) {
+		printk(KERN_ERR "meye: unable to power on the camera\n");
+		printk(KERN_ERR "meye: did you enable the camera in "
+				"sonypi using the module options ?\n");
+		goto outsonypienable;
+	}
 
 	ret = -EIO;
 	if ((ret = pci_enable_device(meye.mchip_dev))) {
@@ -1943,6 +1948,7 @@
 	pci_disable_device(meye.mchip_dev);
 outenabledev:
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 0);
+outsonypienable:
 	kfifo_free(meye.doneq);
 outkfifoalloc2:
 	kfifo_free(meye.grabq);
diff -Nru a/drivers/media/video/meye.h b/drivers/media/video/meye.h
--- a/drivers/media/video/meye.h	2004-11-16 20:41:10 +01:00
+++ b/drivers/media/video/meye.h	2004-11-16 20:41:10 +01:00
@@ -31,7 +31,7 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	 1
-#define MEYE_DRIVER_MINORVERSION	11
+#define MEYE_DRIVER_MINORVERSION	12
 
 #define MEYE_DRIVER_VERSION __stringify(MEYE_DRIVER_MAJORVERSION) "." \
 			    __stringify(MEYE_DRIVER_MINORVERSION)
diff -Nru a/include/linux/sonypi.h b/include/linux/sonypi.h
--- a/include/linux/sonypi.h	2004-11-16 20:41:10 +01:00
+++ b/include/linux/sonypi.h	2004-11-16 20:41:10 +01:00
@@ -122,27 +122,27 @@
 
 /* used only for communication between v4l and sonypi */
 
-#define SONYPI_COMMAND_GETCAMERA		 1
+#define SONYPI_COMMAND_GETCAMERA		 1	/* obsolete */
 #define SONYPI_COMMAND_SETCAMERA		 2
-#define SONYPI_COMMAND_GETCAMERABRIGHTNESS	 3
+#define SONYPI_COMMAND_GETCAMERABRIGHTNESS	 3	/* obsolete */
 #define SONYPI_COMMAND_SETCAMERABRIGHTNESS	 4
-#define SONYPI_COMMAND_GETCAMERACONTRAST	 5
+#define SONYPI_COMMAND_GETCAMERACONTRAST	 5	/* obsolete */
 #define SONYPI_COMMAND_SETCAMERACONTRAST	 6
-#define SONYPI_COMMAND_GETCAMERAHUE		 7
+#define SONYPI_COMMAND_GETCAMERAHUE		 7	/* obsolete */
 #define SONYPI_COMMAND_SETCAMERAHUE		 8
-#define SONYPI_COMMAND_GETCAMERACOLOR		 9
+#define SONYPI_COMMAND_GETCAMERACOLOR		 9	/* obsolete */
 #define SONYPI_COMMAND_SETCAMERACOLOR		10
-#define SONYPI_COMMAND_GETCAMERASHARPNESS	11
+#define SONYPI_COMMAND_GETCAMERASHARPNESS	11	/* obsolete */
 #define SONYPI_COMMAND_SETCAMERASHARPNESS	12
-#define SONYPI_COMMAND_GETCAMERAPICTURE		13
+#define SONYPI_COMMAND_GETCAMERAPICTURE		13	/* obsolete */
 #define SONYPI_COMMAND_SETCAMERAPICTURE		14
-#define SONYPI_COMMAND_GETCAMERAAGC		15
+#define SONYPI_COMMAND_GETCAMERAAGC		15	/* obsolete */
 #define SONYPI_COMMAND_SETCAMERAAGC		16
-#define SONYPI_COMMAND_GETCAMERADIRECTION	17
-#define SONYPI_COMMAND_GETCAMERAROMVERSION	18
-#define SONYPI_COMMAND_GETCAMERAREVISION	19
+#define SONYPI_COMMAND_GETCAMERADIRECTION	17	/* obsolete */
+#define SONYPI_COMMAND_GETCAMERAROMVERSION	18	/* obsolete */
+#define SONYPI_COMMAND_GETCAMERAREVISION	19	/* obsolete */
 
-u8 sonypi_camera_command(int command, u8 value);
+int sonypi_camera_command(int command, u8 value);
 
 #endif				/* __KERNEL__ */
 
-- 
Stelian Pop <stelian@popies.net>    

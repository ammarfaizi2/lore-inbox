Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268306AbUHQPkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268306AbUHQPkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268302AbUHQPiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:38:12 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:10205 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S268283AbUHQPSS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:18:18 -0400
Message-ID: <4122216F.4080101@ttnet.net.tr>
Date: Tue, 17 Aug 2004 18:17:03 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [8/10]
Content-Type: multipart/mixed;
	boundary="------------030301090601040209010904"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030301090601040209010904
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: 7bit


--------------030301090601040209010904
Content-Type: text/plain;
	name="gcc34_inline_08.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_08.diff"

--- 28p1/drivers/usb/ov511.c~	2003-06-13 17:51:36.000000000 +0300
+++ 28p1/drivers/usb/ov511.c	2004-08-17 02:20:02.000000000 +0300
@@ -334,8 +334,8 @@
  **********************************************************************/
 
 static void ov51x_clear_snapshot(struct usb_ov511 *);
-static inline int sensor_get_picture(struct usb_ov511 *,
-				     struct video_picture *);
+static int sensor_get_picture(struct usb_ov511 *,
+			      struct video_picture *);
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 static int sensor_get_exposure(struct usb_ov511 *, unsigned char *);
 static int ov51x_control_ioctl(struct inode *, struct file *, unsigned int,
@@ -2014,7 +2014,7 @@
 	return 0;
 }
 
-static inline int
+static int
 sensor_get_picture(struct usb_ov511 *ov, struct video_picture *p)
 {
 	int rc;
--- 28p1/drivers/usb/w9968cf.c~	2004-08-16 20:13:41.000000000 +0300
+++ 28p1/drivers/usb/w9968cf.c	2004-08-17 02:44:58.000000000 +0300
@@ -444,8 +444,8 @@
 /* High-level CMOS sensor control functions */
 static int w9968cf_sensor_set_control(struct w9968cf_device*,int cid,int val);
 static int w9968cf_sensor_get_control(struct w9968cf_device*,int cid,int *val);
-static inline int w9968cf_sensor_cmd(struct w9968cf_device*, 
-                                     unsigned int cmd, void *arg);
+static int w9968cf_sensor_cmd(struct w9968cf_device*, 
+                              unsigned int cmd, void *arg);
 static int w9968cf_sensor_init(struct w9968cf_device*);
 static int w9968cf_sensor_update_settings(struct w9968cf_device*);
 static int w9968cf_sensor_get_picture(struct w9968cf_device*);
@@ -461,7 +461,7 @@
 static int w9968cf_set_picture(struct w9968cf_device*, struct video_picture);
 static int w9968cf_set_window(struct w9968cf_device*, struct video_window);
 static inline u16 w9968cf_valid_palette(u16 palette);
-static inline u16 w9968cf_valid_depth(u16 palette);
+static u16 w9968cf_valid_depth(u16 palette);
 static inline u8 w9968cf_need_decompression(u16 palette);
 static int w9968cf_postprocess_frame(struct w9968cf_device*, 
                                      struct w9968cf_frame_t*);
@@ -2199,7 +2199,7 @@
   Return the depth corresponding to the given palette.
   Palette _must_ be supported !
   --------------------------------------------------------------------------*/
-static inline u16 w9968cf_valid_depth(u16 palette)
+static u16 w9968cf_valid_depth(u16 palette)
 {
 	u8 i=0;
 	while (w9968cf_formatlist[i].palette != palette)
@@ -2418,7 +2418,7 @@
 }
 
 
-static inline int
+static int
 w9968cf_sensor_cmd(struct w9968cf_device* cam, unsigned int cmd, void* arg)
 {
 	struct i2c_client* c = cam->sensor_client;
--- 28p1/drivers/usb/se401.c~	2002-11-29 01:53:14.000000000 +0200
+++ 28p1/drivers/usb/se401.c	2004-08-17 02:56:42.000000000 +0300
@@ -986,6 +986,44 @@
 	return 0;
 }
 
+static inline void usb_se401_remove_disconnected (struct usb_se401 *se401)
+{
+	int i;
+
+        se401->dev = NULL;
+        se401->frame[0].grabstate = FRAME_ERROR;
+        se401->frame[1].grabstate = FRAME_ERROR;
+
+	se401->streaming = 0;
+
+	wake_up_interruptible(&se401->wq);
+
+	for (i=0; i<SE401_NUMSBUF; i++) if (se401->urb[i]) {
+		se401->urb[i]->next = NULL;
+		usb_unlink_urb(se401->urb[i]);
+		usb_free_urb(se401->urb[i]);
+		se401->urb[i] = NULL;
+		kfree(se401->sbuf[i].data);
+	}
+	for (i=0; i<SE401_NUMSCRATCH; i++) if (se401->scratch[i].data) {
+		kfree(se401->scratch[i].data);
+	}
+	if (se401->inturb) {
+		usb_unlink_urb(se401->inturb);
+		usb_free_urb(se401->inturb);
+	}
+        info("%s disconnected", se401->camera_name);
+
+#if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
+	destroy_proc_se401_cam(se401);
+#endif
+
+        /* Free the memory */
+	kfree(se401->width);
+	kfree(se401->height);
+	kfree(se401);
+}
+
 
 /****************************************************************************
  *
@@ -1531,44 +1569,6 @@
 	unlock_kernel();
 }
 
-static inline void usb_se401_remove_disconnected (struct usb_se401 *se401)
-{
-	int i;
-
-        se401->dev = NULL;
-        se401->frame[0].grabstate = FRAME_ERROR;
-        se401->frame[1].grabstate = FRAME_ERROR;
-
-	se401->streaming = 0;
-
-	wake_up_interruptible(&se401->wq);
-
-	for (i=0; i<SE401_NUMSBUF; i++) if (se401->urb[i]) {
-		se401->urb[i]->next = NULL;
-		usb_unlink_urb(se401->urb[i]);
-		usb_free_urb(se401->urb[i]);
-		se401->urb[i] = NULL;
-		kfree(se401->sbuf[i].data);
-	}
-	for (i=0; i<SE401_NUMSCRATCH; i++) if (se401->scratch[i].data) {
-		kfree(se401->scratch[i].data);
-	}
-	if (se401->inturb) {
-		usb_unlink_urb(se401->inturb);
-		usb_free_urb(se401->inturb);
-	}
-        info("%s disconnected", se401->camera_name);
-
-#if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
-	destroy_proc_se401_cam(se401);
-#endif
-
-        /* Free the memory */
-	kfree(se401->width);
-	kfree(se401->height);
-	kfree(se401);
-}
-
 static struct usb_driver se401_driver = {
         name:		"se401",
         id_table:	device_table,
--- 28p1/drivers/usb/host/hc_sl811.c~	2003-11-28 20:26:20.000000000 +0200
+++ 28p1/drivers/usb/host/hc_sl811.c	2004-08-17 03:12:01.000000000 +0300
@@ -117,9 +117,6 @@
 
 static int urb_debug = 0;
 
-#include "hc_simple.c"
-#include "hc_sl811_rh.c"
-
 /* Include hardware and board depens */
 #include <asm/hc_sl811-hw.h>
 
@@ -601,6 +598,9 @@
 	return 0;
 }
 
+#include "hc_simple.c"
+#include "hc_sl811_rh.c"
+
 /************************************************************************
  * Function Name : hc_start_int
  *  
--- 28p1/drivers/video/riva/fbdev.c~	2004-08-16 20:12:43.000000000 +0300
+++ 28p1/drivers/video/riva/fbdev.c	2004-08-17 03:19:14.000000000 +0300
@@ -117,7 +117,7 @@
 static void rivafb_blank(int blank, struct fb_info *info);
 
 extern void riva_setup_accel(struct rivafb_info *rinfo);
-extern inline void wait_for_idle(struct rivafb_info *rinfo);
+extern void wait_for_idle(struct rivafb_info *rinfo);
 
 
 

--------------030301090601040209010904--

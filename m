Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVJ1Gkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVJ1Gkq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVJ1Gia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:38:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:36586 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965133AbVJ1GbT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:19 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] Input: convert konicawc to dynamic input_dev allocation
In-Reply-To: <11304810252231@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:25 -0700
Message-Id: <1130481025986@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Input: convert konicawc to dynamic input_dev allocation

Input: convert konicawc to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 1f204b896615770bd80caff2570deec2fd1c0221
tree b102440fa6844542b0986c4c4e23a83965700512
parent 46aefdd22b2862771431be7e90a0b2c7d5d0524b
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 15 Sep 2005 02:01:42 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:05 -0700

 drivers/usb/media/konicawc.c |   89 +++++++++++++++++++++++++++++-------------
 1 files changed, 61 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/media/konicawc.c b/drivers/usb/media/konicawc.c
index 20ac9e1..9fe2c27 100644
--- a/drivers/usb/media/konicawc.c
+++ b/drivers/usb/media/konicawc.c
@@ -119,7 +119,7 @@ struct konicawc {
 	int yplanesz;		/* Number of bytes in the Y plane */
 	unsigned int buttonsts:1;
 #ifdef CONFIG_INPUT
-	struct input_dev input;
+	struct input_dev *input;
 	char input_physname[64];
 #endif
 };
@@ -218,6 +218,57 @@ static void konicawc_adjust_picture(stru
 	konicawc_camera_on(uvd);
 }
 
+#ifdef CONFIG_INPUT
+
+static void konicawc_register_input(struct konicawc *cam, struct usb_device *dev)
+{
+	struct input_dev *input_dev;
+
+	usb_make_path(dev, cam->input_physname, sizeof(cam->input_physname));
+	strncat(cam->input_physname, "/input0", sizeof(cam->input_physname));
+
+	cam->input = input_dev = input_allocate_device();
+	if (!input_dev) {
+		warn("Not enough memory for camera's input device\n");
+		return;
+	}
+
+	input_dev->name = "Konicawc snapshot button";
+	input_dev->phys = cam->input_physname;
+	usb_to_input_id(dev, &input_dev->id);
+	input_dev->cdev.dev = &dev->dev;
+
+	input_dev->evbit[0] = BIT(EV_KEY);
+	input_dev->keybit[LONG(BTN_0)] = BIT(BTN_0);
+
+	input_dev->private = cam;
+
+	input_register_device(cam->input);
+}
+
+static void konicawc_unregister_input(struct konicawc *cam)
+{
+	if (cam->input) {
+		input_unregister_device(cam->input);
+		cam->input = NULL;
+	}
+}
+
+static void konicawc_report_buttonstat(struct konicawc *cam)
+{
+	if (cam->input) {
+		input_report_key(cam->input, BTN_0, cam->buttonsts);
+		input_sync(cam->input);
+	}
+}
+
+#else
+
+static inline void konicawc_register_input(struct konicawc *cam, struct usb_device *dev) { }
+static inline void konicawc_unregister_input(struct konicawc *cam) { }
+static inline void konicawc_report_buttonstat(struct konicawc *cam) { }
+
+#endif /* CONFIG_INPUT */
 
 static int konicawc_compress_iso(struct uvd *uvd, struct urb *dataurb, struct urb *stsurb)
 {
@@ -273,10 +324,7 @@ static int konicawc_compress_iso(struct 
 		if(button != cam->buttonsts) {
 			DEBUG(2, "button: %sclicked", button ? "" : "un");
 			cam->buttonsts = button;
-#ifdef CONFIG_INPUT
-			input_report_key(&cam->input, BTN_0, cam->buttonsts);
-			input_sync(&cam->input);
-#endif
+			konicawc_report_buttonstat(cam);
 		}
 
 		if(sts == 0x01) { /* drop frame */
@@ -645,9 +693,9 @@ static int konicawc_set_video_mode(struc
 	RingQueue_Flush(&uvd->dp);
 	cam->lastframe = -2;
 	if(uvd->curframe != -1) {
-	  uvd->frame[uvd->curframe].curline = 0;
-	  uvd->frame[uvd->curframe].seqRead_Length = 0;
-	  uvd->frame[uvd->curframe].seqRead_Index = 0;
+		uvd->frame[uvd->curframe].curline = 0;
+		uvd->frame[uvd->curframe].seqRead_Length = 0;
+		uvd->frame[uvd->curframe].seqRead_Index = 0;
 	}
 
 	konicawc_start_data(uvd);
@@ -718,7 +766,6 @@ static void konicawc_configure_video(str
 	DEBUG(1, "setting initial values");
 }
 
-
 static int konicawc_probe(struct usb_interface *intf, const struct usb_device_id *devid)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
@@ -839,21 +886,8 @@ static int konicawc_probe(struct usb_int
 			err("usbvideo_RegisterVideoDevice() failed.");
 			uvd = NULL;
 		}
-#ifdef CONFIG_INPUT
-		/* Register input device for button */
-		memset(&cam->input, 0, sizeof(struct input_dev));
-		cam->input.name = "Konicawc snapshot button";
-		cam->input.private = cam;
-		cam->input.evbit[0] = BIT(EV_KEY);
-		cam->input.keybit[LONG(BTN_0)] = BIT(BTN_0);
-		usb_to_input_id(dev, &cam->input.id);
-		input_register_device(&cam->input);
-		
-		usb_make_path(dev, cam->input_physname, 56);
-		strcat(cam->input_physname, "/input0");
-		cam->input.phys = cam->input_physname;
-		info("konicawc: %s on %s\n", cam->input.name, cam->input.phys);
-#endif
+
+		konicawc_register_input(cam, dev);
 	}
 
 	if (uvd) {
@@ -869,10 +903,9 @@ static void konicawc_free_uvd(struct uvd
 	int i;
 	struct konicawc *cam = (struct konicawc *)uvd->user_data;
 
-#ifdef CONFIG_INPUT
-	input_unregister_device(&cam->input);
-#endif
-	for (i=0; i < USBVIDEO_NUMSBUF; i++) {
+	konicawc_unregister_input(cam);
+
+	for (i = 0; i < USBVIDEO_NUMSBUF; i++) {
 		usb_free_urb(cam->sts_urb[i]);
 		cam->sts_urb[i] = NULL;
 	}


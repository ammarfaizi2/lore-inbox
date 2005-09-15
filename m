Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVIOGvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVIOGvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbVIOGvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:51:38 -0400
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:58715 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932527AbVIOGvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:51:37 -0400
Message-Id: <20050915064944.139725000.dtor_core@ameritech.net>
References: <20050915064552.836273000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 01:46:03 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de>,
Kay Sievers <kay.sievers@vrfy.org>,
Vojtech Pavlik <vojtech@suse.cz>,
Hannes Reinecke <hare@suse.de>
Subject: [patch 11/28] Input: convert konicawc to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-konicawc.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Input: convert konicawc to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/media/konicawc.c |   89 +++++++++++++++++++++++++++++--------------
 1 files changed, 61 insertions(+), 28 deletions(-)

Index: work/drivers/usb/media/konicawc.c
===================================================================
--- work.orig/drivers/usb/media/konicawc.c
+++ work/drivers/usb/media/konicawc.c
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


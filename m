Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWEQEZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWEQEZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 00:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWEQEZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 00:25:43 -0400
Received: from [202.75.186.170] ([202.75.186.170]:19977 "EHLO
	ns1.clipsalportal.com") by vger.kernel.org with ESMTP
	id S1751228AbWEQEZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 00:25:42 -0400
Date: Wed, 17 May 2006 12:13:54 +0800
Message-Id: <200605170413.k4H4DsEw025104@localhost.localdomain>
From: jayakumar.video@gmail.com
Subject: [PATCH 2.6.17-rc4 1/1] usbvideo misc cleanup
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg KH, USB folk, kernel folk,

I've appended a small patch to cleanup some of the usbvideo drivers 
as per Oliver Neukum's feedback and the response in the following 
threads:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114770240416519&w=2
[ unneccessary urb initialization of .status ]
http://marc.theaimsgroup.com/?l=linux-kernel&m=114767440903341&w=2 
[ shouldn't build the cbTbl structs on the stack ]

I hope it's okay with the respective authors.

Thanks,
Jaya Kumar

Signed-off-by: Jaya Kumar <jayakumar.video@gmail.com>

---

 ibmcam.c   |   25 ++++++++++++++-----------
 konicawc.c |   30 +++++++++++++-----------------
 usbvideo.c |    5 -----
 3 files changed, 27 insertions(+), 33 deletions(-)

---

diff -X linux-2.6.17-rc4-vidcleanup/Documentation/dontdiff -uprN linux-2.6.17-rc4-vanilla/drivers/media/video/usbvideo/ibmcam.c linux-2.6.17-rc4-vidcleanup/drivers/media/video/usbvideo/ibmcam.c
--- linux-2.6.17-rc4-vanilla/drivers/media/video/usbvideo/ibmcam.c	2006-05-17 08:11:36.000000000 +0800
+++ linux-2.6.17-rc4-vidcleanup/drivers/media/video/usbvideo/ibmcam.c	2006-05-17 11:19:14.000000000 +0800
@@ -3899,24 +3899,27 @@ static struct usb_device_id id_table[] =
  * 1/27/00  Reworked to use statically allocated ibmcam structures.
  * 21/10/00 Completely redesigned to use usbvideo services.
  */
+
+static struct usbvideo_cb ibmcam_driver = {
+	.probe = 		ibmcam_probe,
+	.setupOnOpen = 		ibmcam_setup_on_open,
+	.videoStart = 		ibmcam_video_start,
+	.videoStop = 		ibmcam_video_stop,
+	.processData = 		ibmcam_ProcessIsocData,
+	.postProcess = 		usbvideo_DeinterlaceFrame,
+	.adjustPicture = 	ibmcam_adjust_picture,
+	.getFPS = 		ibmcam_calculate_fps
+};
+
+
 static int __init ibmcam_init(void)
 {
-	struct usbvideo_cb cbTbl;
-	memset(&cbTbl, 0, sizeof(cbTbl));
-	cbTbl.probe = ibmcam_probe;
-	cbTbl.setupOnOpen = ibmcam_setup_on_open;
-	cbTbl.videoStart = ibmcam_video_start;
-	cbTbl.videoStop = ibmcam_video_stop;
-	cbTbl.processData = ibmcam_ProcessIsocData;
-	cbTbl.postProcess = usbvideo_DeinterlaceFrame;
-	cbTbl.adjustPicture = ibmcam_adjust_picture;
-	cbTbl.getFPS = ibmcam_calculate_fps;
 	return usbvideo_register(
 		&cams,
 		MAX_IBMCAM,
 		sizeof(ibmcam_t),
 		"ibmcam",
-		&cbTbl,
+		&ibmcam_driver,
 		THIS_MODULE,
 		id_table);
 }
diff -X linux-2.6.17-rc4-vidcleanup/Documentation/dontdiff -uprN linux-2.6.17-rc4-vanilla/drivers/media/video/usbvideo/konicawc.c linux-2.6.17-rc4-vidcleanup/drivers/media/video/usbvideo/konicawc.c
--- linux-2.6.17-rc4-vanilla/drivers/media/video/usbvideo/konicawc.c	2006-05-17 08:11:36.000000000 +0800
+++ linux-2.6.17-rc4-vidcleanup/drivers/media/video/usbvideo/konicawc.c	2006-05-17 11:22:41.000000000 +0800
@@ -53,6 +53,7 @@ enum frame_sizes {
 #define MAX_FRAME_SIZE	SIZE_320X240
 
 static struct usbvideo *cams;
+static unsigned char marker[] = { 0, 0xff, 0, 0x00 };
 
 #ifdef CONFIG_USB_DEBUG
 static int debug;
@@ -344,7 +345,6 @@ static int konicawc_compress_iso(struct 
 
 		keep++;
 		if(sts & 0x80) { /* frame start */
-			unsigned char marker[] = { 0, 0xff, 0, 0x00 };
 
 			if(cam->lastframe == -2) {
 				DEBUG(2, "found initial image");
@@ -368,11 +368,7 @@ static int konicawc_compress_iso(struct 
 static void resubmit_urb(struct uvd *uvd, struct urb *urb)
 {
 	int i, ret;
-	for (i = 0; i < FRAMES_PER_DESC; i++) {
-		urb->iso_frame_desc[i].status = 0;
-	}
 	urb->dev = uvd->dev;
-	urb->status = 0;
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
 	DEBUG(3, "submitting urb of length %d", urb->transfer_buffer_length);
 	if(ret)
@@ -917,27 +913,27 @@ static struct usb_device_id id_table[] =
 	{ }  /* Terminating entry */
 };
 
+static struct usbvideo_cb konicawc_driver = {
+	.probe = 		konicawc_probe,
+	.setupOnOpen = 		konicawc_setup_on_open,
+	.processData = 		konicawc_process_isoc,
+	.getFPS = 		konicawc_calculate_fps,
+	.setVideoMode = 	konicawc_set_video_mode,
+	.startDataPump = 	konicawc_start_data,
+	.stopDataPump = 	konicawc_stop_data,
+	.adjustPicture = 	konicawc_adjust_picture,
+	.userFree = 		konicawc_free_uvd
+};
 
 static int __init konicawc_init(void)
 {
-	struct usbvideo_cb cbTbl;
 	info(DRIVER_DESC " " DRIVER_VERSION);
-	memset(&cbTbl, 0, sizeof(cbTbl));
-	cbTbl.probe = konicawc_probe;
-	cbTbl.setupOnOpen = konicawc_setup_on_open;
-	cbTbl.processData = konicawc_process_isoc;
-	cbTbl.getFPS = konicawc_calculate_fps;
-	cbTbl.setVideoMode = konicawc_set_video_mode;
-	cbTbl.startDataPump = konicawc_start_data;
-	cbTbl.stopDataPump = konicawc_stop_data;
-	cbTbl.adjustPicture = konicawc_adjust_picture;
-	cbTbl.userFree = konicawc_free_uvd;
 	return usbvideo_register(
 		&cams,
 		MAX_CAMERAS,
 		sizeof(struct konicawc),
 		"konicawc",
-		&cbTbl,
+		&konicawc_driver,
 		THIS_MODULE,
 		id_table);
 }
diff -X linux-2.6.17-rc4-vidcleanup/Documentation/dontdiff -uprN linux-2.6.17-rc4-vanilla/drivers/media/video/usbvideo/usbvideo.c linux-2.6.17-rc4-vidcleanup/drivers/media/video/usbvideo/usbvideo.c
--- linux-2.6.17-rc4-vanilla/drivers/media/video/usbvideo/usbvideo.c	2006-05-17 08:11:36.000000000 +0800
+++ linux-2.6.17-rc4-vidcleanup/drivers/media/video/usbvideo/usbvideo.c	2006-05-17 10:46:21.000000000 +0800
@@ -1720,11 +1720,6 @@ static void usbvideo_IsocIrq(struct urb 
 	RingQueue_WakeUpInterruptible(&uvd->dp);
 
 urb_done_with:
-	for (i = 0; i < FRAMES_PER_DESC; i++) {
-		urb->iso_frame_desc[i].status = 0;
-		urb->iso_frame_desc[i].actual_length = 0;
-	}
-	urb->status = 0;
 	urb->dev = uvd->dev;
 	ret = usb_submit_urb (urb, GFP_KERNEL);
 	if(ret)

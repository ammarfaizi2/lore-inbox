Return-Path: <linux-kernel-owner+w=401wt.eu-S933014AbWL0RM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbWL0RM5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932983AbWL0RMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:12:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41493 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933018AbWL0RMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:12:40 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Dwaine Garden <DwaineGarden@rogers.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 12/28] V4L/DVB (4979): Fixes compilation when
	CONFIG_V4L1_COMPAT is not selected
Date: Wed, 27 Dec 2006 14:57:29 -0200
Message-id: <20061227165729.PS38948500012@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dwaine Garden <DwaineGarden@rogers.com>

- SYSFS: Replaced all to_video_device(cd), video_device_create_file,
  video_device_remove_file and add the proper checks at create_file
- Converted old norm values to V4L2 ones.
- Robustness on sysfs hue/contrast/saturation queries.
  Additional check in order to return 0 if the driver is not opened.
- Whitespace cleanups in usbvision-cards.c

This patch merges two fixes by Thierry MERLE and Mauro Chehab, and adds
additional checks.

Signed-off-by: Dwaine Garden<DwaineGarden@rogers.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/usbvision/usbvision-cards.c |   11 +-
 drivers/media/video/usbvision/usbvision-video.c |  134 +++++++++++++++--------
 2 files changed, 94 insertions(+), 51 deletions(-)

diff --git a/drivers/media/video/usbvision/usbvision-cards.c b/drivers/media/video/usbvision/usbvision-cards.c
index 134eb98..a40e583 100644
--- a/drivers/media/video/usbvision/usbvision-cards.c
+++ b/drivers/media/video/usbvision/usbvision-cards.c
@@ -39,8 +39,8 @@ struct usbvision_device_data_st  usbvisi
 	{0x0573, 0x0400, -1, CODEC_SAA7113, 4, V4L2_STD_NTSC,  0, 0, 1, 0, 0,                          -1, -1,  0,  3,  7, "D-Link V100"},
 	{0x0573, 0x2000, -1, CODEC_SAA7111, 2, V4L2_STD_NTSC,  1, 0, 1, 0, 0,                          -1, -1, -1, -1, -1, "X10 USB Camera"},
 	{0x0573, 0x2d00, -1, CODEC_SAA7111, 2, V4L2_STD_PAL,   1, 0, 1, 0, 0,                          -1, -1, -1,  3,  7, "Osprey 50"},
-	{0x0573, 0x2d01, -1, CODEC_SAA7113, 2, V4L2_STD_NTSC,	 0, 0, 1, 0, 0,				 -1, -1,  0,  3,  7, "Hauppauge USB-Live Model 600"},
-	{0x0573, 0x2101, -1, CODEC_SAA7113, 2, V4L2_STD_PAL, 	 2, 0, 1, 0, 0,                          -1, -1,  0,  3,  7, "Zoran Co. PMD (Nogatech) AV-grabber Manhattan"},
+	{0x0573, 0x2d01, -1, CODEC_SAA7113, 2, V4L2_STD_NTSC,  0, 0, 1, 0, 0,			       -1, -1,  0,  3,  7, "Hauppauge USB-Live Model 600"},
+	{0x0573, 0x2101, -1, CODEC_SAA7113, 2, V4L2_STD_PAL,   2, 0, 1, 0, 0,                          -1, -1,  0,  3,  7, "Zoran Co. PMD (Nogatech) AV-grabber Manhattan"},
 	{0x0573, 0x4100, -1, CODEC_SAA7111, 3, V4L2_STD_NTSC,  1, 1, 1, 1, TUNER_PHILIPS_NTSC_M,       -1, -1, -1, 20, -1, "Nogatech USB-TV (NTSC) FM"},
 	{0x0573, 0x4110, -1, CODEC_SAA7111, 3, V4L2_STD_NTSC,  1, 1, 1, 1, TUNER_PHILIPS_NTSC_M,       -1, -1, -1, 20, -1, "PNY USB-TV (NTSC) FM"},
 	{0x0573, 0x4450,  0, CODEC_SAA7113, 3, V4L2_STD_PAL,   1, 1, 1, 1, TUNER_PHILIPS_PAL,          -1, -1,  0,  3,  7, "PixelView PlayTv-USB PRO (PAL) FM"},
@@ -71,10 +71,10 @@ struct usbvision_device_data_st  usbvisi
 	{0x0573, 0x4d37,  0, CODEC_SAA7113, 3, V4L2_STD_PAL,   1, 1, 1, 1, TUNER_PHILIPS_FM1216ME_MK3, -1, -1,  0,  3,  7, "Hauppauge WinTV USB device Model 40219 Rev E189"},
 	{0x0768, 0x0006, -1, CODEC_SAA7113, 3, V4L2_STD_NTSC,  1, 1, 1, 1, TUNER_PHILIPS_NTSC_M,       -1, -1,  5,  5, -1, "Camtel Technology USB TV Genie Pro FM Model TVB330"},
 	{0x07d0, 0x0001, -1, CODEC_SAA7113, 2, V4L2_STD_PAL,   0, 0, 1, 0, 0,                          -1, -1,  0,  3,  7, "Digital Video Creator I"},
-	{0x07d0, 0x0002, -1, CODEC_SAA7111, 2, V4L2_STD_NTSC,  0, 0, 1, 0, 0,   			 -1, -1, 82, 20,  7, "Global Village GV-007 (NTSC)"},
+	{0x07d0, 0x0002, -1, CODEC_SAA7111, 2, V4L2_STD_NTSC,  0, 0, 1, 0, 0,   		       -1, -1, 82, 20,  7, "Global Village GV-007 (NTSC)"},
 	{0x07d0, 0x0003,  0, CODEC_SAA7113, 2, V4L2_STD_NTSC,  0, 0, 1, 0, 0,                          -1, -1,  0,  3,  7, "Dazzle Fusion Model DVC-50 Rev 1 (NTSC)"},
 	{0x07d0, 0x0004,  0, CODEC_SAA7113, 2, V4L2_STD_PAL,   0, 0, 1, 0, 0,                          -1, -1,  0,  3,  7, "Dazzle Fusion Model DVC-80 Rev 1 (PAL)"},
-	{0x07d0, 0x0005,  0, CODEC_SAA7113, 2, V4L2_STD_SECAM, 0, 0, 1, 0, 0,				 -1, -1,  0,  3,  7, "Dazzle Fusion Model DVC-90 Rev 1 (SECAM)"},
+	{0x07d0, 0x0005,  0, CODEC_SAA7113, 2, V4L2_STD_SECAM, 0, 0, 1, 0, 0,			       -1, -1,  0,  3,  7, "Dazzle Fusion Model DVC-90 Rev 1 (SECAM)"},
 	{0x2304, 0x010d, -1, CODEC_SAA7111, 3, V4L2_STD_PAL,   1, 0, 0, 1, TUNER_TEMIC_4066FY5_PAL_I,  -1, -1, -1, -1, -1, "Pinnacle Studio PCTV USB (PAL)"},
 	{0x2304, 0x0109, -1, CODEC_SAA7111, 3, V4L2_STD_SECAM, 1, 0, 1, 1, TUNER_PHILIPS_SECAM,        -1, -1, -1, -1, -1, "Pinnacle Studio PCTV USB (SECAM)"},
 	{0x2304, 0x0110, -1, CODEC_SAA7111, 3, V4L2_STD_PAL,   1, 1, 1, 1, TUNER_PHILIPS_PAL,          -1, -1,128, 23, -1, "Pinnacle Studio PCTV USB (PAL) FM"},
@@ -86,7 +86,7 @@ struct usbvision_device_data_st  usbvisi
 	{0x2304, 0x0300, -1, CODEC_SAA7113, 2, V4L2_STD_NTSC,  1, 0, 1, 0, 0,                          -1, -1,  0,  3,  7, "Pinnacle Studio Linx Video input cable (NTSC)"},
 	{0x2304, 0x0301, -1, CODEC_SAA7113, 2, V4L2_STD_PAL,   1, 0, 1, 0, 0,                          -1, -1,  0,  3,  7, "Pinnacle Studio Linx Video input cable (PAL)"},
 	{0x2304, 0x0419, -1, CODEC_SAA7113, 3, V4L2_STD_PAL,   1, 1, 1, 1, TUNER_TEMIC_4009FR5_PAL,    -1, -1,  0,  3,  7, "Pinnacle PCTV Bungee USB (PAL) FM"},
-	{0x2400, 0x4200, -1, CODEC_SAA7111, 3, VIDEO_MODE_NTSC,  1, 0, 1, 1, TUNER_PHILIPS_NTSC_M,       -1, -1, -1, -1, -1, "Hauppauge WinTv-USB"},
+	{0x2400, 0x4200, -1, CODEC_SAA7111, 3, V4L2_STD_NTSC,  1, 0, 1, 1, TUNER_PHILIPS_NTSC_M,       -1, -1, -1, -1, -1, "Hauppauge WinTv-USB"},
 	{}  /* Terminating entry */
 };
 
@@ -148,7 +148,6 @@ struct usb_device_id usbvision_table [] 
 	{ USB_DEVICE(0x2304, 0x0300) },  /* Pinnacle Studio Linx Video input cable (NTSC) */
 	{ USB_DEVICE(0x2304, 0x0301) },  /* Pinnacle Studio Linx Video input cable (PAL) */
 	{ USB_DEVICE(0x2304, 0x0419) },  /* Pinnacle PCTV Bungee USB (PAL) FM */
-
 	{ USB_DEVICE(0x2400, 0x4200) },  /* Hauppauge WinTv-USB2 Model 42012 */
 
 	{ }  /* Terminating entry */
diff --git a/drivers/media/video/usbvision/usbvision-video.c b/drivers/media/video/usbvision/usbvision-video.c
index 31b133e..8c7eba2 100644
--- a/drivers/media/video/usbvision/usbvision-video.c
+++ b/drivers/media/video/usbvision/usbvision-video.c
@@ -204,7 +204,7 @@ #define YES_NO(x) ((x) ? "Yes" : "No")
 
 static inline struct usb_usbvision *cd_to_usbvision(struct class_device *cd)
 {
-	struct video_device *vdev = to_video_device(cd);
+	struct video_device *vdev = container_of(cd, struct video_device, class_dev);
 	return video_get_drvdata(vdev);
 }
 
@@ -214,81 +214,85 @@ static ssize_t show_version(struct class
 }
 static CLASS_DEVICE_ATTR(version, S_IRUGO, show_version, NULL);
 
-static ssize_t show_model(struct class_device *class_dev, char *buf)
+static ssize_t show_model(struct class_device *cd, char *buf)
 {
-	struct video_device *vdev = to_video_device(class_dev);
+	struct video_device *vdev = container_of(cd, struct video_device, class_dev);
 	struct usb_usbvision *usbvision = video_get_drvdata(vdev);
 	return sprintf(buf, "%s\n", usbvision_device_data[usbvision->DevModel].ModelString);
 }
 static CLASS_DEVICE_ATTR(model, S_IRUGO, show_model, NULL);
 
-static ssize_t show_hue(struct class_device *class_dev, char *buf)
+static ssize_t show_hue(struct class_device *cd, char *buf)
 {
-	struct video_device *vdev = to_video_device(class_dev);
+	struct video_device *vdev = container_of(cd, struct video_device, class_dev);
 	struct usb_usbvision *usbvision = video_get_drvdata(vdev);
 	struct v4l2_control ctrl;
 	ctrl.id = V4L2_CID_HUE;
 	ctrl.value = 0;
-	call_i2c_clients(usbvision, VIDIOC_G_CTRL, &ctrl);
+	if(usbvision->user)
+		call_i2c_clients(usbvision, VIDIOC_G_CTRL, &ctrl);
 	return sprintf(buf, "%d\n", ctrl.value >> 8);
 }
 static CLASS_DEVICE_ATTR(hue, S_IRUGO, show_hue, NULL);
 
-static ssize_t show_contrast(struct class_device *class_dev, char *buf)
+static ssize_t show_contrast(struct class_device *cd, char *buf)
 {
-	struct video_device *vdev = to_video_device(class_dev);
+	struct video_device *vdev = container_of(cd, struct video_device, class_dev);
 	struct usb_usbvision *usbvision = video_get_drvdata(vdev);
 	struct v4l2_control ctrl;
 	ctrl.id = V4L2_CID_CONTRAST;
 	ctrl.value = 0;
-	call_i2c_clients(usbvision, VIDIOC_G_CTRL, &ctrl);
+	if(usbvision->user)
+		call_i2c_clients(usbvision, VIDIOC_G_CTRL, &ctrl);
 	return sprintf(buf, "%d\n", ctrl.value >> 8);
 }
 static CLASS_DEVICE_ATTR(contrast, S_IRUGO, show_contrast, NULL);
 
-static ssize_t show_brightness(struct class_device *class_dev, char *buf)
+static ssize_t show_brightness(struct class_device *cd, char *buf)
 {
-	struct video_device *vdev = to_video_device(class_dev);
+	struct video_device *vdev = container_of(cd, struct video_device, class_dev);
 	struct usb_usbvision *usbvision = video_get_drvdata(vdev);
 	struct v4l2_control ctrl;
 	ctrl.id = V4L2_CID_BRIGHTNESS;
 	ctrl.value = 0;
-	call_i2c_clients(usbvision, VIDIOC_G_CTRL, &ctrl);
+	if(usbvision->user)
+		call_i2c_clients(usbvision, VIDIOC_G_CTRL, &ctrl);
 	return sprintf(buf, "%d\n", ctrl.value >> 8);
 }
 static CLASS_DEVICE_ATTR(brightness, S_IRUGO, show_brightness, NULL);
 
-static ssize_t show_saturation(struct class_device *class_dev, char *buf)
+static ssize_t show_saturation(struct class_device *cd, char *buf)
 {
-	struct video_device *vdev = to_video_device(class_dev);
+	struct video_device *vdev = container_of(cd, struct video_device, class_dev);
 	struct usb_usbvision *usbvision = video_get_drvdata(vdev);
 	struct v4l2_control ctrl;
 	ctrl.id = V4L2_CID_SATURATION;
 	ctrl.value = 0;
-	call_i2c_clients(usbvision, VIDIOC_G_CTRL, &ctrl);
+	if(usbvision->user)
+		call_i2c_clients(usbvision, VIDIOC_G_CTRL, &ctrl);
 	return sprintf(buf, "%d\n", ctrl.value >> 8);
 }
 static CLASS_DEVICE_ATTR(saturation, S_IRUGO, show_saturation, NULL);
 
-static ssize_t show_streaming(struct class_device *class_dev, char *buf)
+static ssize_t show_streaming(struct class_device *cd, char *buf)
 {
-	struct video_device *vdev = to_video_device(class_dev);
+	struct video_device *vdev = container_of(cd, struct video_device, class_dev);
 	struct usb_usbvision *usbvision = video_get_drvdata(vdev);
 	return sprintf(buf, "%s\n", YES_NO(usbvision->streaming==Stream_On?1:0));
 }
 static CLASS_DEVICE_ATTR(streaming, S_IRUGO, show_streaming, NULL);
 
-static ssize_t show_compression(struct class_device *class_dev, char *buf)
+static ssize_t show_compression(struct class_device *cd, char *buf)
 {
-	struct video_device *vdev = to_video_device(class_dev);
+	struct video_device *vdev = container_of(cd, struct video_device, class_dev);
 	struct usb_usbvision *usbvision = video_get_drvdata(vdev);
 	return sprintf(buf, "%s\n", YES_NO(usbvision->isocMode==ISOC_MODE_COMPRESS));
 }
 static CLASS_DEVICE_ATTR(compression, S_IRUGO, show_compression, NULL);
 
-static ssize_t show_device_bridge(struct class_device *class_dev, char *buf)
+static ssize_t show_device_bridge(struct class_device *cd, char *buf)
 {
-	struct video_device *vdev = to_video_device(class_dev);
+	struct video_device *vdev = container_of(cd, struct video_device, class_dev);
 	struct usb_usbvision *usbvision = video_get_drvdata(vdev);
 	return sprintf(buf, "%d\n", usbvision->bridgeType);
 }
@@ -297,31 +301,71 @@ static CLASS_DEVICE_ATTR(bridge, S_IRUGO
 static void usbvision_create_sysfs(struct video_device *vdev)
 {
 	int res;
-	if (vdev) {
-		res=video_device_create_file(vdev, &class_device_attr_version);
-		res=video_device_create_file(vdev, &class_device_attr_model);
-		res=video_device_create_file(vdev, &class_device_attr_hue);
-		res=video_device_create_file(vdev, &class_device_attr_contrast);
-		res=video_device_create_file(vdev, &class_device_attr_brightness);
-		res=video_device_create_file(vdev, &class_device_attr_saturation);
-		res=video_device_create_file(vdev, &class_device_attr_streaming);
-		res=video_device_create_file(vdev, &class_device_attr_compression);
-		res=video_device_create_file(vdev, &class_device_attr_bridge);
-	}
+	if (!vdev)
+		return;
+	do {
+		res=class_device_create_file(&vdev->class_dev,
+					     &class_device_attr_version);
+		if (res<0)
+			break;
+		res=class_device_create_file(&vdev->class_dev,
+					     &class_device_attr_model);
+		if (res<0)
+			break;
+		res=class_device_create_file(&vdev->class_dev,
+					     &class_device_attr_hue);
+		if (res<0)
+			break;
+		res=class_device_create_file(&vdev->class_dev,
+					     &class_device_attr_contrast);
+		if (res<0)
+			break;
+		res=class_device_create_file(&vdev->class_dev,
+					     &class_device_attr_brightness);
+		if (res<0)
+			break;
+		res=class_device_create_file(&vdev->class_dev,
+					     &class_device_attr_saturation);
+		if (res<0)
+			break;
+		res=class_device_create_file(&vdev->class_dev,
+					     &class_device_attr_streaming);
+		if (res<0)
+			break;
+		res=class_device_create_file(&vdev->class_dev,
+					     &class_device_attr_compression);
+		if (res<0)
+			break;
+		res=class_device_create_file(&vdev->class_dev,
+					     &class_device_attr_bridge);
+		if (res>=0)
+			return;
+	} while (0);
+
+	err("%s error: %d\n", __FUNCTION__, res);
 }
 
 static void usbvision_remove_sysfs(struct video_device *vdev)
 {
 	if (vdev) {
-		video_device_remove_file(vdev, &class_device_attr_version);
-		video_device_remove_file(vdev, &class_device_attr_model);
-		video_device_remove_file(vdev, &class_device_attr_hue);
-		video_device_remove_file(vdev, &class_device_attr_contrast);
-		video_device_remove_file(vdev, &class_device_attr_brightness);
-		video_device_remove_file(vdev, &class_device_attr_saturation);
-		video_device_remove_file(vdev, &class_device_attr_streaming);
-		video_device_remove_file(vdev, &class_device_attr_compression);
-		video_device_remove_file(vdev, &class_device_attr_bridge);
+		class_device_remove_file(&vdev->class_dev,
+					 &class_device_attr_version);
+		class_device_remove_file(&vdev->class_dev,
+					 &class_device_attr_model);
+		class_device_remove_file(&vdev->class_dev,
+					 &class_device_attr_hue);
+		class_device_remove_file(&vdev->class_dev,
+					 &class_device_attr_contrast);
+		class_device_remove_file(&vdev->class_dev,
+					 &class_device_attr_brightness);
+		class_device_remove_file(&vdev->class_dev,
+					 &class_device_attr_saturation);
+		class_device_remove_file(&vdev->class_dev,
+					 &class_device_attr_streaming);
+		class_device_remove_file(&vdev->class_dev,
+					 &class_device_attr_compression);
+		class_device_remove_file(&vdev->class_dev,
+					 &class_device_attr_bridge);
 	}
 }
 
@@ -1933,22 +1977,22 @@ static void customdevice_process(void)
 		{
 			case 'P':
 				PDEBUG(DBG_PROBE, "VideoNorm=PAL");
-				usbvision_device_data[0].VideoNorm=VIDEO_MODE_PAL;
+				usbvision_device_data[0].VideoNorm=V4L2_STD_PAL;
 				break;
 
 			case 'S':
 				PDEBUG(DBG_PROBE, "VideoNorm=SECAM");
-				usbvision_device_data[0].VideoNorm=VIDEO_MODE_SECAM;
+				usbvision_device_data[0].VideoNorm=V4L2_STD_SECAM;
 				break;
 
 			case 'N':
 				PDEBUG(DBG_PROBE, "VideoNorm=NTSC");
-				usbvision_device_data[0].VideoNorm=VIDEO_MODE_NTSC;
+				usbvision_device_data[0].VideoNorm=V4L2_STD_NTSC;
 				break;
 
 			default:
 				PDEBUG(DBG_PROBE, "VideoNorm=PAL (by default)");
-				usbvision_device_data[0].VideoNorm=VIDEO_MODE_PAL;
+				usbvision_device_data[0].VideoNorm=V4L2_STD_PAL;
 				break;
 		}
 		goto2next(parse);


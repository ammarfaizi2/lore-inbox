Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWJNMHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWJNMHy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWJNMHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:07:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5581 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932194AbWJNMHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:07:50 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Jeff Garzik <jeff@garzik.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 12/18] V4L/DVB (4741): {ov511,stv680}: handle sysfs errors
Date: Sat, 14 Oct 2006 09:00:51 -0300
Message-id: <20061014120051.PS20654600012@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Garzik <jeff@garzik.org>

Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/ov511.c  |   58 ++++++++++++++++++++++++++++++++++--------
 drivers/media/video/stv680.c |   53 +++++++++++++++++++++++++++++++-------
 2 files changed, 90 insertions(+), 21 deletions(-)

diff --git a/drivers/media/video/ov511.c b/drivers/media/video/ov511.c
index ce4886f..b4db2cb 100644
--- a/drivers/media/video/ov511.c
+++ b/drivers/media/video/ov511.c
@@ -5648,17 +5648,49 @@ static ssize_t show_exposure(struct clas
 }
 static CLASS_DEVICE_ATTR(exposure, S_IRUGO, show_exposure, NULL);
 
-static void ov_create_sysfs(struct video_device *vdev)
+static int ov_create_sysfs(struct video_device *vdev)
 {
-	video_device_create_file(vdev, &class_device_attr_custom_id);
-	video_device_create_file(vdev, &class_device_attr_model);
-	video_device_create_file(vdev, &class_device_attr_bridge);
-	video_device_create_file(vdev, &class_device_attr_sensor);
-	video_device_create_file(vdev, &class_device_attr_brightness);
-	video_device_create_file(vdev, &class_device_attr_saturation);
-	video_device_create_file(vdev, &class_device_attr_contrast);
-	video_device_create_file(vdev, &class_device_attr_hue);
-	video_device_create_file(vdev, &class_device_attr_exposure);
+	int rc;
+
+	rc = video_device_create_file(vdev, &class_device_attr_custom_id);
+	if (rc) goto err;
+	rc = video_device_create_file(vdev, &class_device_attr_model);
+	if (rc) goto err_id;
+	rc = video_device_create_file(vdev, &class_device_attr_bridge);
+	if (rc) goto err_model;
+	rc = video_device_create_file(vdev, &class_device_attr_sensor);
+	if (rc) goto err_bridge;
+	rc = video_device_create_file(vdev, &class_device_attr_brightness);
+	if (rc) goto err_sensor;
+	rc = video_device_create_file(vdev, &class_device_attr_saturation);
+	if (rc) goto err_bright;
+	rc = video_device_create_file(vdev, &class_device_attr_contrast);
+	if (rc) goto err_sat;
+	rc = video_device_create_file(vdev, &class_device_attr_hue);
+	if (rc) goto err_contrast;
+	rc = video_device_create_file(vdev, &class_device_attr_exposure);
+	if (rc) goto err_hue;
+
+	return 0;
+
+err_hue:
+	video_device_remove_file(vdev, &class_device_attr_hue);
+err_contrast:
+	video_device_remove_file(vdev, &class_device_attr_contrast);
+err_sat:
+	video_device_remove_file(vdev, &class_device_attr_saturation);
+err_bright:
+	video_device_remove_file(vdev, &class_device_attr_brightness);
+err_sensor:
+	video_device_remove_file(vdev, &class_device_attr_sensor);
+err_bridge:
+	video_device_remove_file(vdev, &class_device_attr_bridge);
+err_model:
+	video_device_remove_file(vdev, &class_device_attr_model);
+err_id:
+	video_device_remove_file(vdev, &class_device_attr_custom_id);
+err:
+	return rc;
 }
 
 /****************************************************************************
@@ -5817,7 +5849,11 @@ #endif
 	     ov->vdev->minor);
 
 	usb_set_intfdata(intf, ov);
-	ov_create_sysfs(ov->vdev);
+	if (ov_create_sysfs(ov->vdev)) {
+		err("ov_create_sysfs failed");
+		goto error;
+	}
+
 	return 0;
 
 error:
diff --git a/drivers/media/video/stv680.c b/drivers/media/video/stv680.c
index 87e1130..6d1ef1e 100644
--- a/drivers/media/video/stv680.c
+++ b/drivers/media/video/stv680.c
@@ -516,16 +516,45 @@ stv680_file(frames_read, framecount, "%d
 stv680_file(packets_dropped, dropped, "%d\n");
 stv680_file(decoding_errors, error, "%d\n");
 
-static void stv680_create_sysfs_files(struct video_device *vdev)
+static int stv680_create_sysfs_files(struct video_device *vdev)
 {
-	video_device_create_file(vdev, &class_device_attr_model);
-	video_device_create_file(vdev, &class_device_attr_in_use);
-	video_device_create_file(vdev, &class_device_attr_streaming);
-	video_device_create_file(vdev, &class_device_attr_palette);
-	video_device_create_file(vdev, &class_device_attr_frames_total);
-	video_device_create_file(vdev, &class_device_attr_frames_read);
-	video_device_create_file(vdev, &class_device_attr_packets_dropped);
-	video_device_create_file(vdev, &class_device_attr_decoding_errors);
+	int rc;
+
+	rc = video_device_create_file(vdev, &class_device_attr_model);
+	if (rc) goto err;
+	rc = video_device_create_file(vdev, &class_device_attr_in_use);
+	if (rc) goto err_model;
+	rc = video_device_create_file(vdev, &class_device_attr_streaming);
+	if (rc) goto err_inuse;
+	rc = video_device_create_file(vdev, &class_device_attr_palette);
+	if (rc) goto err_stream;
+	rc = video_device_create_file(vdev, &class_device_attr_frames_total);
+	if (rc) goto err_pal;
+	rc = video_device_create_file(vdev, &class_device_attr_frames_read);
+	if (rc) goto err_framtot;
+	rc = video_device_create_file(vdev, &class_device_attr_packets_dropped);
+	if (rc) goto err_framread;
+	rc = video_device_create_file(vdev, &class_device_attr_decoding_errors);
+	if (rc) goto err_dropped;
+
+	return 0;
+
+err_dropped:
+	video_device_remove_file(vdev, &class_device_attr_packets_dropped);
+err_framread:
+	video_device_remove_file(vdev, &class_device_attr_frames_read);
+err_framtot:
+	video_device_remove_file(vdev, &class_device_attr_frames_total);
+err_pal:
+	video_device_remove_file(vdev, &class_device_attr_palette);
+err_stream:
+	video_device_remove_file(vdev, &class_device_attr_streaming);
+err_inuse:
+	video_device_remove_file(vdev, &class_device_attr_in_use);
+err_model:
+	video_device_remove_file(vdev, &class_device_attr_model);
+err:
+	return rc;
 }
 
 static void stv680_remove_sysfs_files(struct video_device *vdev)
@@ -1418,9 +1447,13 @@ static int stv680_probe (struct usb_inte
 
 	usb_set_intfdata (intf, stv680);
-	stv680_create_sysfs_files(stv680->vdev);
+	retval = stv680_create_sysfs_files(stv680->vdev);
+	if (retval)
+		goto error_unreg;
 	return 0;
 
+error_unreg:
+	video_unregister_device(stv680->vdev);
 error_vdev:
 	video_device_release(stv680->vdev);
 error:


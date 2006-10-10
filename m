Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWJJQCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWJJQCh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWJJQCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:02:37 -0400
Received: from havoc.gtf.org ([69.61.125.42]:18077 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932152AbWJJQCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:02:36 -0400
Date: Tue, 10 Oct 2006 12:02:28 -0400
From: Jeff Garzik <jeff@garzik.org>
To: mmcclell@bigfoot.com, kjsisson@bellsouth.net, mchehab@infradead.org,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] video/{ov511,stv680}: handle sysfs errors
Message-ID: <20061010160228.GA21460@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/media/video/ov511.c    |   58 +++++++++++++++++++++++++++++++++--------
 drivers/media/video/stv680.c   |   53 ++++++++++++++++++++++++++++++-------

diff --git a/drivers/media/video/ov511.c b/drivers/media/video/ov511.c
index ce4886f..13ad4a1 100644
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
 	PDEBUG (0, "STV(i): registered new video device: video%d", stv680->vdev->minor);
 
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

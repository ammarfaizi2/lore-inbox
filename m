Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWJNMKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWJNMKX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWJNMII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:08:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64204 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932181AbWJNMHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:07:15 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 13/18] V4L/DVB (4742): Drivers/media/video: handle sysfs
	errors
Date: Sat, 14 Oct 2006 09:00:51 -0300
Message-id: <20061014120051.PS31009800013@infradead.org>
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
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/et61x251/et61x251_core.c |   37 +++++++++++---
 drivers/media/video/pwc/pwc-if.c             |   41 ++++++++++++---
 drivers/media/video/sn9c102/sn9c102_core.c   |   71 ++++++++++++++++++++------
 3 files changed, 117 insertions(+), 32 deletions(-)

diff --git a/drivers/media/video/et61x251/et61x251_core.c b/drivers/media/video/et61x251/et61x251_core.c
index bc544cc..f786ab1 100644
--- a/drivers/media/video/et61x251/et61x251_core.c
+++ b/drivers/media/video/et61x251/et61x251_core.c
@@ -973,16 +973,32 @@ static CLASS_DEVICE_ATTR(i2c_val, S_IRUG
 			 et61x251_show_i2c_val, et61x251_store_i2c_val);
 
 
-static void et61x251_create_sysfs(struct et61x251_device* cam)
+static int et61x251_create_sysfs(struct et61x251_device* cam)
 {
 	struct video_device *v4ldev = cam->v4ldev;
+	int rc;
 
-	video_device_create_file(v4ldev, &class_device_attr_reg);
-	video_device_create_file(v4ldev, &class_device_attr_val);
+	rc = video_device_create_file(v4ldev, &class_device_attr_reg);
+	if (rc) goto err;
+	rc = video_device_create_file(v4ldev, &class_device_attr_val);
+	if (rc) goto err_reg;
 	if (cam->sensor.sysfs_ops) {
-		video_device_create_file(v4ldev, &class_device_attr_i2c_reg);
-		video_device_create_file(v4ldev, &class_device_attr_i2c_val);
+		rc = video_device_create_file(v4ldev, &class_device_attr_i2c_reg);
+		if (rc) goto err_val;
+		rc = video_device_create_file(v4ldev, &class_device_attr_i2c_val);
+		if (rc) goto err_i2c_reg;
 	}
+
+	return 0;
+
+err_i2c_reg:
+	video_device_remove_file(v4ldev, &class_device_attr_i2c_reg);
+err_val:
+	video_device_remove_file(v4ldev, &class_device_attr_val);
+err_reg:
+	video_device_remove_file(v4ldev, &class_device_attr_reg);
+err:
+	return rc;
 }
 #endif /* CONFIG_VIDEO_ADV_DEBUG */
 
@@ -2534,7 +2550,9 @@ et61x251_usb_probe(struct usb_interface*
 	dev_nr = (dev_nr < ET61X251_MAX_DEVICES-1) ? dev_nr+1 : 0;
 
 #ifdef CONFIG_VIDEO_ADV_DEBUG
-	et61x251_create_sysfs(cam);
+	err = et61x251_create_sysfs(cam);
+	if (err)
+		goto fail2;
 	DBG(2, "Optional device control through 'sysfs' interface ready");
 #endif
 
@@ -2544,6 +2562,13 @@ #endif
 
 	return 0;
 
+#ifdef CONFIG_VIDEO_ADV_DEBUG
+fail2:
+	video_nr[dev_nr] = -1;
+	dev_nr = (dev_nr < ET61X251_MAX_DEVICES-1) ? dev_nr+1 : 0;
+	mutex_unlock(&cam->dev_mutex);
+	video_unregister_device(cam->v4ldev);
+#endif
 fail:
 	if (cam) {
 		kfree(cam->control_buffer);
diff --git a/drivers/media/video/pwc/pwc-if.c b/drivers/media/video/pwc/pwc-if.c
index c77b85c..46c1148 100644
--- a/drivers/media/video/pwc/pwc-if.c
+++ b/drivers/media/video/pwc/pwc-if.c
@@ -1024,12 +1024,25 @@ static ssize_t show_snapshot_button_stat
 static CLASS_DEVICE_ATTR(button, S_IRUGO | S_IWUSR, show_snapshot_button_status,
 			 NULL);
 
-static void pwc_create_sysfs_files(struct video_device *vdev)
+static int pwc_create_sysfs_files(struct video_device *vdev)
 {
 	struct pwc_device *pdev = video_get_drvdata(vdev);
-	if (pdev->features & FEATURE_MOTOR_PANTILT)
-		video_device_create_file(vdev, &class_device_attr_pan_tilt);
-	video_device_create_file(vdev, &class_device_attr_button);
+	int rc;
+
+	rc = video_device_create_file(vdev, &class_device_attr_button);
+	if (rc)
+		goto err;
+	if (pdev->features & FEATURE_MOTOR_PANTILT) {
+		rc = video_device_create_file(vdev,&class_device_attr_pan_tilt);
+		if (rc) goto err_button;
+	}
+
+	return 0;
+
+err_button:
+	video_device_remove_file(vdev, &class_device_attr_button);
+err:
+	return rc;
 }
 
 static void pwc_remove_sysfs_files(struct video_device *vdev)
@@ -1408,7 +1421,7 @@ static int usb_pwc_probe(struct usb_inte
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct pwc_device *pdev = NULL;
 	int vendor_id, product_id, type_id;
-	int i, hint;
+	int i, hint, rc;
 	int features = 0;
 	int video_nr = -1; /* default: use next available device */
 	char serial_number[30], *name;
@@ -1709,9 +1722,8 @@ static int usb_pwc_probe(struct usb_inte
 	i = video_register_device(pdev->vdev, VFL_TYPE_GRABBER, video_nr);
 	if (i < 0) {
 		PWC_ERROR("Failed to register as video device (%d).\n", i);
-		video_device_release(pdev->vdev); /* Drip... drip... drip... */
-		kfree(pdev); /* Oops, no memory leaks please */
-		return -EIO;
+		rc = i;
+		goto err;
 	}
 	else {
 		PWC_INFO("Registered as /dev/video%d.\n", pdev->vdev->minor & 0x3F);
@@ -1723,13 +1735,24 @@ static int usb_pwc_probe(struct usb_inte
 
 	PWC_DEBUG_PROBE("probe() function returning struct at 0x%p.\n", pdev);
 	usb_set_intfdata (intf, pdev);
-	pwc_create_sysfs_files(pdev->vdev);
+	rc = pwc_create_sysfs_files(pdev->vdev);
+	if (rc)
+		goto err_unreg;
 
 	/* Set the leds off */
 	pwc_set_leds(pdev, 0, 0);
 	pwc_camera_power(pdev, 0);
 
 	return 0;
+
+err_unreg:
+	if (hint < MAX_DEV_HINTS)
+		device_hint[hint].pdev = NULL;
+	video_unregister_device(pdev->vdev);
+err:
+	video_device_release(pdev->vdev); /* Drip... drip... drip... */
+	kfree(pdev); /* Oops, no memory leaks please */
+	return rc;
 }
 
 /* The user janked out the cable... */
diff --git a/drivers/media/video/sn9c102/sn9c102_core.c b/drivers/media/video/sn9c102/sn9c102_core.c
index 3e0ff8a..a4702d3 100644
--- a/drivers/media/video/sn9c102/sn9c102_core.c
+++ b/drivers/media/video/sn9c102/sn9c102_core.c
@@ -1240,23 +1240,53 @@ static CLASS_DEVICE_ATTR(frame_header, S
 			 sn9c102_show_frame_header, NULL);
 
 
-static void sn9c102_create_sysfs(struct sn9c102_device* cam)
+static int sn9c102_create_sysfs(struct sn9c102_device* cam)
 {
 	struct video_device *v4ldev = cam->v4ldev;
+	int rc;
+
+	rc = video_device_create_file(v4ldev, &class_device_attr_reg);
+	if (rc) goto err;
+	rc = video_device_create_file(v4ldev, &class_device_attr_val);
+	if (rc) goto err_reg;
+	rc = video_device_create_file(v4ldev, &class_device_attr_frame_header);
+	if (rc) goto err_val;
 
-	video_device_create_file(v4ldev, &class_device_attr_reg);
-	video_device_create_file(v4ldev, &class_device_attr_val);
-	video_device_create_file(v4ldev, &class_device_attr_frame_header);
-	if (cam->bridge == BRIDGE_SN9C101 || cam->bridge == BRIDGE_SN9C102)
-		video_device_create_file(v4ldev, &class_device_attr_green);
-	else if (cam->bridge == BRIDGE_SN9C103) {
-		video_device_create_file(v4ldev, &class_device_attr_blue);
-		video_device_create_file(v4ldev, &class_device_attr_red);
-	}
 	if (cam->sensor.sysfs_ops) {
-		video_device_create_file(v4ldev, &class_device_attr_i2c_reg);
-		video_device_create_file(v4ldev, &class_device_attr_i2c_val);
+		rc = video_device_create_file(v4ldev, &class_device_attr_i2c_reg);
+		if (rc) goto err_frhead;
+		rc = video_device_create_file(v4ldev, &class_device_attr_i2c_val);
+		if (rc) goto err_i2c_reg;
+	}
+
+	if (cam->bridge == BRIDGE_SN9C101 || cam->bridge == BRIDGE_SN9C102) {
+		rc = video_device_create_file(v4ldev, &class_device_attr_green);
+		if (rc) goto err_i2c_val;
+	} else if (cam->bridge == BRIDGE_SN9C103) {
+		rc = video_device_create_file(v4ldev, &class_device_attr_blue);
+		if (rc) goto err_i2c_val;
+		rc = video_device_create_file(v4ldev, &class_device_attr_red);
+		if (rc) goto err_blue;
 	}
+
+	return 0;
+
+err_blue:
+	video_device_remove_file(v4ldev, &class_device_attr_blue);
+err_i2c_val:
+	if (cam->sensor.sysfs_ops)
+		video_device_remove_file(v4ldev, &class_device_attr_i2c_val);
+err_i2c_reg:
+	if (cam->sensor.sysfs_ops)
+		video_device_remove_file(v4ldev, &class_device_attr_i2c_reg);
+err_frhead:
+	video_device_remove_file(v4ldev, &class_device_attr_frame_header);
+err_val:
+	video_device_remove_file(v4ldev, &class_device_attr_val);
+err_reg:
+	video_device_remove_file(v4ldev, &class_device_attr_reg);
+err:
+	return rc;
 }
 #endif /* CONFIG_VIDEO_ADV_DEBUG */
 
@@ -2809,10 +2839,7 @@ sn9c102_usb_probe(struct usb_interface* 
 		DBG(1, "V4L2 device registration failed");
 		if (err == -ENFILE && video_nr[dev_nr] == -1)
 			DBG(1, "Free /dev/videoX node not found");
-		video_nr[dev_nr] = -1;
-		dev_nr = (dev_nr < SN9C102_MAX_DEVICES-1) ? dev_nr+1 : 0;
-		mutex_unlock(&cam->dev_mutex);
-		goto fail;
+		goto fail2;
 	}
 
 	DBG(2, "V4L2 device registered as /dev/video%d", cam->v4ldev->minor);
@@ -2823,7 +2850,9 @@ sn9c102_usb_probe(struct usb_interface* 
 	dev_nr = (dev_nr < SN9C102_MAX_DEVICES-1) ? dev_nr+1 : 0;
 
 #ifdef CONFIG_VIDEO_ADV_DEBUG
-	sn9c102_create_sysfs(cam);
+	err = sn9c102_create_sysfs(cam);
+	if (err)
+		goto fail3;
 	DBG(2, "Optional device control through 'sysfs' interface ready");
 #endif
 
@@ -2833,6 +2862,14 @@ #endif
 
 	return 0;
 
+#ifdef CONFIG_VIDEO_ADV_DEBUG
+fail3:
+	video_unregister_device(cam->v4ldev);
+#endif
+fail2:
+	video_nr[dev_nr] = -1;
+	dev_nr = (dev_nr < SN9C102_MAX_DEVICES-1) ? dev_nr+1 : 0;
+	mutex_unlock(&cam->dev_mutex);
 fail:
 	if (cam) {
 		kfree(cam->control_buffer);


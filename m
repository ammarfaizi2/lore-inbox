Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264934AbUGHWDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUGHWDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUGHWDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:03:20 -0400
Received: from mail.gmx.de ([213.165.64.20]:17061 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264934AbUGHWC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:02:58 -0400
X-Authenticated: #1045983
From: Helge Deller <deller@gmx.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] add missing sysfs support to CPiA webcam video driver
Date: Fri, 9 Jul 2004 00:01:15 +0200
User-Agent: KMail/1.6.82
Cc: Johannes Erdfelt <johannes@erdfelt.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sQc7AUHxHfQHxGV"
Message-Id: <200407090001.16201.deller@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_sQc7AUHxHfQHxGV
Content-Type: text/plain;
  charset="us-ascii";
  boundary=""
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch (vs. 2.6.7) adds the missing sysfs support to the CPiA driver by adding the needed remove() function.
This avoids the current kernel warnings:
videodev: "CPiA Camera" has no release callback. Please fix your driver for proper sysfs support, see http://lwn.net/Articles/36850/

Tested with a CPiA USB webcam. 
Please apply.

Helge

--Boundary-00=_sQc7AUHxHfQHxGV
Content-Type: text/plain;
  charset="us-ascii";
  name="cpia_diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpia_diff"

--- ./drivers/media/video/cpia.c.org	2004-05-10 04:32:54.000000000 +0200
+++ ./drivers/media/video/cpia.c	2004-07-08 23:57:20.061174852 +0200
@@ -1368,7 +1368,7 @@
 	if (!cpia_proc_root || !cam)
 		return;
 
-	sprintf(name, "video%d", cam->vdev.minor);
+	sprintf(name, "video%d", cam->vdev->minor);
 	
 	ent = create_proc_entry(name, S_IFREG|S_IRUGO|S_IWUSR, cpia_proc_root);
 	if (!ent)
@@ -1393,7 +1393,7 @@
 	if (!cam || !cam->proc_entry)
 		return;
 	
-	sprintf(name, "video%d", cam->vdev.minor);
+	sprintf(name, "video%d", cam->vdev->minor);
 	remove_proc_entry(name, cpia_proc_root);
 	cam->proc_entry = NULL;
 }
@@ -3710,7 +3710,7 @@
 
 		DBG("VIDIOCGUNIT\n");
 
-		vu->video    = cam->vdev.minor;
+		vu->video    = cam->vdev->minor;
 		vu->vbi      = VIDEO_NO_UNIT;
 		vu->radio    = VIDEO_NO_UNIT;
 		vu->audio    = VIDEO_NO_UNIT;
@@ -3804,6 +3804,14 @@
 	return 0;
 }
 
+
+void cpia_video_release(struct video_device *vfd)
+{
+	struct cam_data *cam = vfd->priv;
+	down(&cam->busy_lock);
+	video_device_release(vfd);
+}
+
 static struct file_operations cpia_fops = {
 	.owner		= THIS_MODULE,
 	.open		= cpia_open,
@@ -3820,6 +3828,8 @@
 	.type		= VID_TYPE_CAPTURE,
 	.hardware	= VID_HARDWARE_CPIA,
 	.fops           = &cpia_fops,
+	.release	= cpia_video_release,
+	.minor		= -1,
 };
 
 /* initialise cam_data structure  */
@@ -3930,7 +3940,7 @@
 }
 
 /* initialize cam_data structure  */
-static void init_camera_struct(struct cam_data *cam,
+static int init_camera_struct(struct cam_data *cam,
                                struct cpia_camera_ops *ops )
 {
 	int i;
@@ -3946,8 +3956,13 @@
 
 	cam->proc_entry = NULL;
 
-	memcpy(&cam->vdev, &cpia_template, sizeof(cpia_template));
-	cam->vdev.priv = cam;
+	cam->vdev = video_device_alloc();
+	if (!cam->vdev) {
+		printk(KERN_ERR "cpia: video_device_alloc() failed!\n");
+		return -ENOMEM;
+	}
+	memcpy(cam->vdev, &cpia_template, sizeof(cpia_template));
+	cam->vdev->priv = cam;
 	
 	cam->curframe = 0;
 	for (i = 0; i < FRAME_NUM; i++) {
@@ -3960,6 +3975,7 @@
 	cam->decompressed_frame.height = 0;
 	cam->decompressed_frame.state = FRAME_UNUSED;
 	cam->decompressed_frame.data = NULL;
+	return 0;
 }
 
 struct cam_data *cpia_register_camera(struct cpia_camera_ops *ops, void *lowlevel)
@@ -3970,11 +3986,14 @@
 		return NULL;
 
 	
-	init_camera_struct( camera, ops );
+	if (init_camera_struct( camera, ops )) {
+		kfree(camera);
+		return NULL;
+	}
 	camera->lowlevel_data = lowlevel;
 	
 	/* register v4l device */
-	if (video_register_device(&camera->vdev, VFL_TYPE_GRABBER, video_nr) == -1) {
+	if (video_register_device(camera->vdev, VFL_TYPE_GRABBER, video_nr) == -1) {
 		kfree(camera);
 		printk(KERN_DEBUG "video_register_device failed\n");
 		return NULL;
@@ -4019,7 +4038,7 @@
 void cpia_unregister_camera(struct cam_data *cam)
 {
 	DBG("unregistering video\n");
-	video_unregister_device(&cam->vdev);
+	video_unregister_device(cam->vdev);
 	if (cam->open_count) {
 		put_cam(cam->ops);
 		DBG("camera open -- setting ops to NULL\n");
@@ -4027,7 +4046,7 @@
 	}
 	
 #ifdef CONFIG_PROC_FS
-	DBG("destroying /proc/cpia/video%d\n", cam->vdev.minor);
+	DBG("destroying /proc/cpia/video%d\n", cam->vdev->minor);
 	destroy_proc_cpia_cam(cam);
 #endif	
 	if (!cam->open_count) {
--- ./drivers/media/video/cpia.h.org	2004-05-10 04:33:19.000000000 +0200
+++ ./drivers/media/video/cpia.h	2004-07-08 23:47:39.295359761 +0200
@@ -268,7 +268,7 @@
 					/* v4l */
 	int video_size;			/* VIDEO_SIZE_ */
 	volatile enum v4l_camstates camstate;	/* v4l layer status */
-	struct video_device vdev;	/* v4l videodev */
+	struct video_device *vdev;	/* v4l videodev */
 	struct video_picture vp;	/* v4l camera settings */
 	struct video_window vw;		/* v4l capture area */
 	struct video_capture vc;       	/* v4l subcapture area */

--Boundary-00=_sQc7AUHxHfQHxGV--

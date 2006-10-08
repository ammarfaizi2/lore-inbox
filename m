Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWJHSmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWJHSmO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWJHSmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:42:13 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:57517 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751320AbWJHSmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:42:11 -0400
Message-ID: <45294680.5010205@linuxtv.org>
Date: Sun, 08 Oct 2006 14:42:08 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: stable@kernel.org
CC: linux-kernel@vger.kernel.org,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mike Isely <isely@pobox.com>
Subject: [2.6.18.y PATCH 3/6] pvrusb2: Solve mutex deadlock
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From a3a8acc64f0007ff4d561ac1111078f2da374009 Mon Sep 17 00:00:00 2001
From: Mike Isely <isely@pobox.com>
Date: Sat, 23 Sep 2006 17:09:22 -0400
Subject: [PATCH] pvrusb2: Solve mutex deadlock

There is a mutex ordering problem between the pvrusb2 driver and the
v4l core.  Two different pathways take mutexes in opposing orders and
this (under rare circumstances) can cause a deadlock.  The two mutexes
in question are videodev_lock in the v4l core and device_lock inside
the pvrusb2 driver.  The device_lock instance in the driver protects a
private global array of context pointers which had been implemented in
advance of v4l core changes which eliminate the video_set_drvdata()
and video_get_drvdata() functions.

This patch restores the use of video_get_drvdata() and
video_set_drvdata(), eliminating the need for the array and the mutex.
(This is actually a patch to restore the previous implementation.)  We
can do this for 2.6.18 since those functions are in fact still
present.  A better (and larger) solution will be done for later
kernels.

Signed-off-by: Mike Isely <isely@pobox.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
---
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c |   53 ++--------------------------
 1 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/drivers/media/video/pvrusb2/pvrusb2-v4l2.c b/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
index 0caf70b..128e6b5 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-v4l2.c
@@ -22,6 +22,7 @@
 
 #include <linux/kernel.h>
 #include <linux/version.h>
+#include <linux/videodev.h>
 #include "pvrusb2-context.h"
 #include "pvrusb2-hdw.h"
 #include "pvrusb2.h"
@@ -35,21 +36,11 @@ struct pvr2_v4l2_dev;
 struct pvr2_v4l2_fh;
 struct pvr2_v4l2;
 
-/* V4L no longer provide the ability to set / get a private context pointer
-   (i.e. video_get_drvdata / video_set_drvdata), which means we have to
-   concoct our own context locating mechanism.  Supposedly this is intended
-   to simplify driver implementation.  It's not clear to me how that can
-   possibly be true.  Our solution here is to maintain a lookup table of
-   our context instances, indexed by the minor device number of the V4L
-   device.  See pvr2_v4l2_open() for some implications of this approach. */
-static struct pvr2_v4l2_dev *devices[256];
-static DEFINE_MUTEX(device_lock);
 
 struct pvr2_v4l2_dev {
 	struct pvr2_v4l2 *v4lp;
 	struct video_device *vdev;
 	struct pvr2_context_stream *stream;
-	int ctxt_idx;
 	enum pvr2_config config;
 };
 
@@ -703,12 +694,6 @@ static void pvr2_v4l2_dev_destroy(struct
 {
 	printk(KERN_INFO "pvrusb2: unregistering device video%d [%s]\n",
 	       dip->vdev->minor,pvr2_config_get_name(dip->config));
-	if (dip->ctxt_idx >= 0) {
-		mutex_lock(&device_lock);
-		devices[dip->ctxt_idx] = NULL;
-		dip->ctxt_idx = -1;
-		mutex_unlock(&device_lock);
-	}
 	video_unregister_device(dip->vdev);
 }
 
@@ -800,33 +785,10 @@ static int pvr2_v4l2_open(struct inode *
 	struct pvr2_v4l2 *vp;
 	struct pvr2_hdw *hdw;
 
-	mutex_lock(&device_lock);
-	/* MCI 7-Jun-2006 Even though we're just doing what amounts to an
-	   atomic read of the device mapping array here, we still need the
-	   mutex.  The problem is that there is a tiny race possible when
-	   we register the device.  We can't update the device mapping
-	   array until after the device has been registered, owing to the
-	   fact that we can't know the minor device number until after the
-	   registration succeeds.  And if another thread tries to open the
-	   device in the window of time after registration but before the
-	   map is updated, then it will get back an erroneous null pointer
-	   and the open will result in a spurious failure.  The only way to
-	   prevent that is to (a) be inside the mutex here before we access
-	   the array, and (b) cover the entire registration process later
-	   on with this same mutex.  Thus if we get inside the mutex here,
-	   then we can be assured that the registration process actually
-	   completed correctly.  This is an unhappy complication from the
-	   use of global data in a driver that lives in a preemptible
-	   environment.  It sure would be nice if the video device itself
-	   had a means for storing and retrieving a local context pointer.
-	   Oh wait.  It did.  But now it's gone.  Silly me. */
 	{
-		unsigned int midx = iminor(file->f_dentry->d_inode);
-		if (midx < sizeof(devices)/sizeof(devices[0])) {
-			dip = devices[midx];
-		}
+		struct video_device *vdev = video_devdata(file);
+		dip = (struct pvr2_v4l2_dev *)video_get_drvdata(vdev);
 	}
-	mutex_unlock(&device_lock);
 
 	if (!dip) return -ENODEV; /* Should be impossible but I'm paranoid */
 
@@ -1066,7 +1028,7 @@ static void pvr2_v4l2_dev_init(struct pv
 
 	memcpy(dip->vdev,&vdev_template,sizeof(vdev_template));
 	dip->vdev->release = video_device_release;
-	mutex_lock(&device_lock);
+	video_set_drvdata(dip->vdev,dip);
 
 	mindevnum = -1;
 	unit_number = pvr2_hdw_get_unit_number(vp->channel.mc_head->hdw);
@@ -1081,12 +1043,6 @@ static void pvr2_v4l2_dev_init(struct pv
 		       dip->vdev->minor,pvr2_config_get_name(dip->config));
 	}
 
-	if ((dip->vdev->minor < sizeof(devices)/sizeof(devices[0])) &&
-	    (devices[dip->vdev->minor] == NULL)) {
-		dip->ctxt_idx = dip->vdev->minor;
-		devices[dip->ctxt_idx] = dip;
-	}
-	mutex_unlock(&device_lock);
 
 	pvr2_hdw_v4l_store_minor_number(vp->channel.mc_head->hdw,
 					dip->vdev->minor);
@@ -1100,7 +1056,6 @@ struct pvr2_v4l2 *pvr2_v4l2_create(struc
 	vp = kmalloc(sizeof(*vp),GFP_KERNEL);
 	if (!vp) return vp;
 	memset(vp,0,sizeof(*vp));
-	vp->video_dev.ctxt_idx = -1;
 	pvr2_channel_init(&vp->channel,mnp);
 	pvr2_trace(PVR2_TRACE_STRUCT,"Creating pvr2_v4l2 id=%p",vp);
 

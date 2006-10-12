Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWJLRSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWJLRSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWJLRSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:18:47 -0400
Received: from vena.lwn.net ([206.168.112.25]:220 "HELO lwn.net")
	by vger.kernel.org with SMTP id S1750970AbWJLRSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:18:46 -0400
To: video4linux-list@redhat.com
Subject: [PATCH] Fix oops in VIDIOC_G_PARM
cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-kernel@vger.kernel.org
From: Jonathan Corbet <corbet-v4l@lwn.net>
Date: Thu, 12 Oct 2006 11:18:46 -0600
Message-ID: <9879.1160673526@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The call to v4l2_std_construct() in the VIDIOC_G_PARM handler treats
vfd->current_norm as if it were an index - but it's not.  The result is
an oops if the driver has no vidioc_g_parm() method defined.  Here's the
fix.

jon

Signed-off-by: Jonathan Corbet <corbet@lwn.net>

--- /k/t/2.6.19-rc1/drivers/media/video/videodev.c	2006-10-05 16:05:24.000000000 -0600
+++ 19-jc/drivers/media/video/videodev.c	2006-10-12 11:11:07.000000000 -0600
@@ -1287,6 +1288,7 @@ static int __video_do_ioctl(struct inode
 			ret=vfd->vidioc_g_parm(file, fh, p);
 		} else {
 			struct v4l2_standard s;
+			int i;
 
 			if (!vfd->tvnormsize) {
 				printk (KERN_WARNING "%s: no TV norms defined!\n",
@@ -1297,8 +1299,14 @@ static int __video_do_ioctl(struct inode
 			if (p->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 				return -EINVAL;
 
-			v4l2_video_std_construct(&s, vfd->tvnorms[vfd->current_norm].id,
-						 vfd->tvnorms[vfd->current_norm].name);
+			for (i = 0; i < vfd->tvnormsize; i++)
+				if (vfd->tvnorms[i].id == vfd->current_norm)
+					break;
+			if (i >= vfd->tvnormsize)
+				return -EINVAL;
+
+			v4l2_video_std_construct(&s, vfd->current_norm,
+						 vfd->tvnorms[i].name);
 
 			memset(p,0,sizeof(*p));
 

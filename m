Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTJHNc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbTJHNbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:31:48 -0400
Received: from mail.convergence.de ([212.84.236.4]:9697 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261566AbTJHN3B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:29:01 -0400
Subject: [PATCH 13/14] fix v4l1 backward compatibility in saa7146 driver
In-Reply-To: <1065619739957@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 8 Oct 2003 15:29:00 +0200
Message-Id: <1065619740659@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] fix VIDIOC_S_FBUF for v4l1 backward compatility with xfree86 / v4l_drv
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/common/saa7146_video.c linux-2.6.0-test6-cvs/drivers/media/common/saa7146_video.c
--- linux-2.6.0-test6/drivers/media/common/saa7146_video.c	2003-10-01 12:25:26.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/common/saa7146_video.c	2003-09-30 19:15:11.000000000 +0200
@@ -904,6 +904,8 @@
 	{
 		struct v4l2_framebuffer *fb = arg;
 		struct saa7146_format *fmt;
+		struct saa7146_fh *ov_fh = NULL;
+		int restart_overlay = 0;
 
 		DEB_EE(("VIDIOC_S_FBUF\n"));
 
@@ -913,10 +915,6 @@
 			return -EPERM;
 		}
 */
-		if( 0 != vv->ov_data ) {
-			DEB_D(("VIDIOC_S_FBUF: overlay is active.\n"));
-			return -EPERM;
-		}
 
 		/* check args */
 		fmt = format_by_fourcc(dev,fb->fmt.pixelformat);
@@ -924,12 +922,27 @@
 			return -EINVAL;
 		}
 		
+		down(&dev->lock);
+
+		if( vv->ov_data != NULL ) {
+			ov_fh = vv->ov_data->fh;
+			saa7146_stop_preview(ov_fh);
+			restart_overlay = 1;
+		}
+
 		/* ok, accept it */
 		vv->ov_fb = *fb;
 		vv->ov_fmt = fmt;
 		if (0 == vv->ov_fb.fmt.bytesperline)
 			vv->ov_fb.fmt.bytesperline =
 				vv->ov_fb.fmt.width*fmt->depth/8;
+
+		if( 0 != restart_overlay ) {
+			saa7146_start_preview(ov_fh);
+		}
+
+		up(&dev->lock);
+
 		return 0;
 	}
 	case VIDIOC_ENUM_FMT:


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTFKKbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 06:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264336AbTFKKbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 06:31:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:3215 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264328AbTFKKbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 06:31:49 -0400
Date: Wed, 11 Jun 2003 16:18:23 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Misc 2.5 Fixes: cp-user-vicam
Message-ID: <20030611104823.GB3718@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100643.GB2194@in.ibm.com> <20030610100746.GC2194@in.ibm.com> <20030610100905.GD2194@in.ibm.com> <20030610100950.GE2194@in.ibm.com> <20030610101035.GF2194@in.ibm.com> <20030610101121.GG2194@in.ibm.com> <20030610101318.GH2194@in.ibm.com> <20030610101503.GI2194@in.ibm.com> <20030610101801.GJ2194@in.ibm.com> <20030610102024.GK2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610102024.GK2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch I sent yesterday is bad, turns out I didn't enable vicam
config option while compiling. Here is a replacement patch that
actually compiles.


Fix handling of user bufs (arg), use copy_from_user.


 drivers/usb/media/vicam.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff -puN drivers/usb/media/vicam.c~cp-user-vicam drivers/usb/media/vicam.c
--- linux-2.5.70-ds/drivers/usb/media/vicam.c~cp-user-vicam	2003-06-11 16:00:42.000000000 +0530
+++ linux-2.5.70-ds-dipankar/drivers/usb/media/vicam.c	2003-06-11 16:14:06.000000000 +0530
@@ -611,15 +611,20 @@ vicam_ioctl(struct inode *inode, struct 
 
 	case VIDIOCSPICT:
 		{
-			struct video_picture *vp = (struct video_picture *) arg;
+			struct video_picture vp;
 
-			DBG("VIDIOCSPICT depth = %d, pal = %d\n", vp->depth,
-			    vp->palette);
+			if (copy_from_user(&vp, arg, sizeof (vp))) {
+				retval = -EFAULT;
+				break;
+			}
 
-			cam->gain = vp->brightness >> 8;
+			DBG("VIDIOCSPICT depth = %d, pal = %d\n", vp.depth,
+			    vp.palette);
 
-			if (vp->depth != 24
-			    || vp->palette != VIDEO_PALETTE_RGB24)
+			cam->gain = vp.brightness >> 8;
+
+			if (vp.depth != 24
+			    || vp.palette != VIDEO_PALETTE_RGB24)
 				retval = -EINVAL;
 
 			break;
@@ -652,10 +657,15 @@ vicam_ioctl(struct inode *inode, struct 
 	case VIDIOCSWIN:
 		{
 
-			struct video_window *vw = (struct video_window *) arg;
-			DBG("VIDIOCSWIN %d x %d\n", vw->width, vw->height);
+			struct video_window vw;
+
+			if (copy_from_user(&vw, arg, sizeof (vw))) {
+				retval = -EFAULT;
+				break;
+			}
+			DBG("VIDIOCSWIN %d x %d\n", vw.width, vw.height);
 
-			if ( vw->width != 320 || vw->height != 240 )
+			if ( vw.width != 320 || vw.height != 240 )
 				retval = -EFAULT;
 			
 			break;

_

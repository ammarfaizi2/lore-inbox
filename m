Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUAGVri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUAGVri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:47:38 -0500
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:7846 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S266216AbUAGVrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:47:35 -0500
Subject: 2.4.23: user/kernel pointer bugs (vicam.c, w9968cf.c)
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: luca_ing@libero.it
Cc: jburks@wavicle.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Jan 2004 13:47:32 -0800
Message-Id: <1073512053.20237.89.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there are exploitable user/kernel pointer bugs in vicam.c and
w9968cf.c.  The bugs are very simple, so I think the patches speak for
themselves.  Thanks for looking at this, and my apologies if I've made
any mistakes.  Let me know if you have any questions.

Best,
Rob

P.S. Both of these bugs were found using the source code verification
tool, CQual, developed by Jeff Foster, myself, and others, and available
from http://www.cs.umd.edu/~jfoster/cqual/.


--- drivers/usb/vicam.c.orig	Wed Jan  7 13:26:01 2004
+++ drivers/usb/vicam.c	Mon Jan  5 17:23:11 2004
@@ -601,12 +601,19 @@
 	case VIDIOCSWIN:
 		{
 
-			struct video_window *vw = (struct video_window *) arg;
-			DBG("VIDIOCSWIN %d x %d\n", vw->width, vw->height);
+			struct video_window vw;
 
-			if ( vw->width != 320 || vw->height != 240 )
+			if (copy_from_user(&vw, arg, sizeof(vw)))
+			{
 				retval = -EFAULT;
+				break;
+			}
+
+			DBG("VIDIOCSWIN %d x %d\n", vw->width, vw->height);
 			
+			if ( vw.width != 320 || vw.height != 240 )
+				retval = -EFAULT;
+
 			break;
 		}
 


--- drivers/usb/w9968cf.c.orig	Wed Jan  7 13:32:28 2004
+++ drivers/usb/w9968cf.c	Wed Jan  7 13:44:44 2004
@@ -3552,10 +3552,13 @@
 
 	case VIDIOCSYNC: /* wait until the capture of a frame is finished */
 	{
-		unsigned int f_num = *((unsigned int *) arg);
+		unsigned int f_num;
 		struct w9968cf_frame_t* fr;
 		int err = 0;
 
+		if (copy_from_user(&f_num, arg, sizeof(f_num)))
+			return -EFAULT;
+
 		if (f_num >= cam->nbuffers) {
 			DBG(4, "Invalid frame number (%d). "
 			       "VIDIOCMCAPTURE failed.", f_num)
@@ -3620,7 +3623,8 @@
 	{
 		struct video_buffer* buffer = (struct video_buffer*)arg;
 
-		memset(buffer, 0, sizeof(struct video_buffer));
+		if (clear_user(buffer, sizeof(struct video_buffer)))
+			return -EFAULT;
 
 		DBG(5, "VIDIOCGFBUF successfully called.")
 		return 0;


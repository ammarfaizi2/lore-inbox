Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUIWXx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUIWXx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUIWUo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:44:56 -0400
Received: from baikonur.stro.at ([213.239.196.228]:2990 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267205AbUIWUcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:15 -0400
Subject: [patch 10/21]  media/cpia: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:16 +0200
Message-ID: <E1CAaGG-0001FN-G9@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/cpia.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff -puN drivers/media/video/cpia.c~msleep_interruptible-drivers_media_video_cpia drivers/media/video/cpia.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/cpia.c~msleep_interruptible-drivers_media_video_cpia	2004-09-21 21:16:55.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/cpia.c	2004-09-21 21:16:55.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/proc_fs.h>
 #include <linux/ctype.h>
 #include <linux/pagemap.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
 
@@ -2886,9 +2887,7 @@ static int fetch_frame(void *data)
 				cond_resched();
 
 				/* sleep for 10 ms, hopefully ;) */
-				current->state = TASK_INTERRUPTIBLE;
-
-				schedule_timeout(10*HZ/1000);
+				msleep_interruptible(10);
 				if (signal_pending(current))
 					return -EINTR;
 
@@ -2951,8 +2950,7 @@ static int fetch_frame(void *data)
 		        		   CPIA_GRAB_SINGLE, 0, 0, 0);
 				/* FIXME: Trial & error - need up to 70ms for
 				   the grab mode change to complete ? */
-				current->state = TASK_INTERRUPTIBLE;
-				schedule_timeout(70*HZ / 1000);
+				msleep_interruptible(70);
 				if (signal_pending(current))
 					return -EINTR;
 			}
@@ -3003,8 +3001,7 @@ static int goto_high_power(struct cam_da
 {
 	if (do_command(cam, CPIA_COMMAND_GotoHiPower, 0, 0, 0, 0))
 		return -EIO;
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(40*HZ/1000);	/* windows driver does it too */
+	msleep_interruptible(40);	/* windows driver does it too */
 	if(signal_pending(current))
 		return -EINTR;
 	if (do_command(cam, CPIA_COMMAND_GetCameraStatus, 0, 0, 0, 0))
@@ -3074,10 +3071,8 @@ static int set_camera_state(struct cam_d
 	
 	/* Wait 6 frames for the sensor to get all settings and
 	   AEC/ACB to settle */
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout((6*(cam->params.sensorFps.baserate ? 33 : 40) *
-	                    (1 << cam->params.sensorFps.divisor) + 10) *
-			 HZ / 1000);
+	msleep_interruptible(6*(cam->params.sensorFps.baserate ? 33 : 40) *
+			       (1 << cam->params.sensorFps.divisor) + 10);
 
 	if(signal_pending(current))
 		return -EINTR;
_

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbUKDLjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbUKDLjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbUKDLgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:36:37 -0500
Received: from sd291.sivit.org ([194.146.225.122]:29401 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262176AbUKDLSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:18:41 -0500
Date: Thu, 4 Nov 2004 12:18:57 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 12/12] meye: cache the camera settings in the driver
Message-ID: <20041104111856.GR3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104111231.GF3472@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2352, 2004-11-04 11:50:37+01:00, stelian@popies.net
  meye: retrieving the current settings from the camera does not work
        very well, we need to cache the values in the driver
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 meye.c |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

===================================================================

diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	2004-11-04 11:52:38 +01:00
+++ b/drivers/media/video/meye.c	2004-11-04 11:52:38 +01:00
@@ -1281,34 +1281,40 @@
 
 		down(&meye.lock);
 		switch (c->id) {
-
 		case V4L2_CID_BRIGHTNESS:
 			sonypi_camera_command(
 				SONYPI_COMMAND_SETCAMERABRIGHTNESS, c->value);
+			meye.picture.brightness = c->value << 10;
 			break;
 		case V4L2_CID_HUE:
 			sonypi_camera_command(
 				SONYPI_COMMAND_SETCAMERAHUE, c->value);
+			meye.picture.hue = c->value << 10;
 			break;
 		case V4L2_CID_CONTRAST:
 			sonypi_camera_command(
-				SONYPI_COMMAND_SETCAMERACOLOR, c->value);
+				SONYPI_COMMAND_SETCAMERACONTRAST, c->value);
+			meye.picture.contrast = c->value << 10;
 			break;
 		case V4L2_CID_SATURATION:
 			sonypi_camera_command(
 				SONYPI_COMMAND_SETCAMERACOLOR, c->value);
+			meye.picture.colour = c->value << 10;
 			break;
 		case V4L2_CID_AGC:
 			sonypi_camera_command(
 				SONYPI_COMMAND_SETCAMERAAGC, c->value);
+			meye.params.agc = c->value;
 			break;
 		case V4L2_CID_SHARPNESS:
 			sonypi_camera_command(
 				SONYPI_COMMAND_SETCAMERASHARPNESS, c->value);
+			meye.params.sharpness = c->value;
 			break;
 		case V4L2_CID_PICTURE:
 			sonypi_camera_command(
 				SONYPI_COMMAND_SETCAMERAPICTURE, c->value);
+			meye.params.picture = c->value;
 			break;
 		case V4L2_CID_JPEGQUAL:
 			meye.params.quality = c->value;
@@ -1330,32 +1336,25 @@
 		down(&meye.lock);
 		switch (c->id) {
 		case V4L2_CID_BRIGHTNESS:
-			c->value = sonypi_camera_command(
-				SONYPI_COMMAND_GETCAMERABRIGHTNESS, 0);
+			c->value = meye.picture.brightness >> 10;
 			break;
 		case V4L2_CID_HUE:
-			c->value = sonypi_camera_command(
-				SONYPI_COMMAND_GETCAMERAHUE, 0);
+			c->value = meye.picture.hue >> 10;
 			break;
 		case V4L2_CID_CONTRAST:
-			c->value = sonypi_camera_command(
-				SONYPI_COMMAND_GETCAMERACOLOR, 0);
+			c->value = meye.picture.contrast >> 10;
 			break;
 		case V4L2_CID_SATURATION:
-			c->value = sonypi_camera_command(
-				SONYPI_COMMAND_GETCAMERACOLOR, 0);
+			c->value = meye.picture.colour >> 10;
 			break;
 		case V4L2_CID_AGC:
-			c->value = sonypi_camera_command(
-				SONYPI_COMMAND_GETCAMERAAGC, 0);
+			c->value = meye.params.agc;
 			break;
 		case V4L2_CID_SHARPNESS:
-			c->value = sonypi_camera_command(
-				SONYPI_COMMAND_GETCAMERASHARPNESS, 0);
+			c->value = meye.params.sharpness;
 			break;
 		case V4L2_CID_PICTURE:
-			c->value = sonypi_camera_command(
-				SONYPI_COMMAND_GETCAMERAPICTURE, 0);
+			c->value = meye.params.picture;
 			break;
 		case V4L2_CID_JPEGQUAL:
 			c->value = meye.params.quality;

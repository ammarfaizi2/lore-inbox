Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVCCA6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVCCA6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVCCAye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:54:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34255 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261360AbVCCAwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:52:53 -0500
Date: Wed, 2 Mar 2005 16:52:46 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11: touchpad unresponsive
Message-ID: <20050302165246.787270f7@localhost.localdomain>
In-Reply-To: <mailman.1109784242.17244.linux-kernel2news@redhat.com>
References: <3d668208.82083d66@teleline.es>
	<mailman.1109784242.17244.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005 12:12:53 -0500, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> > Booting X in new kernel makes my touchpad very unresponsive. I can't
> > click any longer in the touchpad area, and the touchpad doesn't response
> > when moving in small increments, so the whole experience is quite bad.

> If it is identified as an ALPS touchpad you can try installing Peter
> Osterlund's Synaptics X driver:
> 
>            http://web.telia.com/~u89404340/touchpad/

Not a bad idea but I suspect it may be simpler to use the attached patch
instead (written by Peter, actually).

-- Pete

diff -urp -X dontdiff linux-2.6.11-rc4/drivers/input/mousedev.c linux-2.6.11-rc4-lem/drivers/input/mousedev.c
--- linux-2.6.11-rc4/drivers/input/mousedev.c	2005-02-15 22:38:39.000000000 -0800
+++ linux-2.6.11-rc4-lem/drivers/input/mousedev.c	2005-02-15 22:54:35.000000000 -0800
@@ -71,6 +71,7 @@ struct mousedev {
 	struct mousedev_hw_data packet;
 	unsigned int pkt_count;
 	int old_x[4], old_y[4];
+	int frac_dx, frac_dy;
 	unsigned long touch;
 };
 
@@ -117,24 +118,31 @@ static struct mousedev mousedev_mix;
 
 static void mousedev_touchpad_event(struct input_dev *dev, struct mousedev *mousedev, unsigned int code, int value)
 {
-	int size;
+	int size, tmp;
+	enum {  FRACTION_DENOM = 100 };
 
 	if (mousedev->touch) {
+		size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
+		if (size == 0) size = xres;
 		switch (code) {
 			case ABS_X:
-				size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
-				if (size == 0) size = xres;
 				fx(0) = value;
-				if (mousedev->pkt_count >= 2)
-					mousedev->packet.dx = ((fx(0) - fx(1)) / 2 + (fx(1) - fx(2)) / 2) * xres / (size * 2);
+				if (mousedev->pkt_count >= 2) {
+					tmp = ((value - fx(2)) * (250 * FRACTION_DENOM)) / size;
+					tmp += mousedev->frac_dx;
+					mousedev->packet.dx = tmp / FRACTION_DENOM;
+					mousedev->frac_dx = tmp - mousedev->packet.dx * FRACTION_DENOM;
+				}
 				break;
 
 			case ABS_Y:
-				size = dev->absmax[ABS_Y] - dev->absmin[ABS_Y];
-				if (size == 0) size = yres;
 				fy(0) = value;
-				if (mousedev->pkt_count >= 2)
-					mousedev->packet.dy = -((fy(0) - fy(1)) / 2 + (fy(1) - fy(2)) / 2) * yres / (size * 2);
+				if (mousedev->pkt_count >= 2) {
+					tmp = ((fy(2) - value) * (250 * FRACTION_DENOM)) / size;
+					tmp += mousedev->frac_dy;
+					mousedev->packet.dy = tmp / FRACTION_DENOM;
+					mousedev->frac_dy = tmp - mousedev->packet.dy * FRACTION_DENOM;
+				}
 				break;
 		}
 	}
@@ -268,6 +276,8 @@ static void mousedev_touchpad_touch(stru
 			clear_bit(0, &mousedev_mix.packet.buttons);
 		}
 		mousedev->touch = mousedev->pkt_count = 0;
+		mousedev->frac_dx = 0;
+		mousedev->frac_dy = 0;
 	}
 	else
 		if (!mousedev->touch)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVBBWRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVBBWRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbVBBWM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:12:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36229 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262554AbVBBWMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 17:12:12 -0500
Date: Wed, 2 Feb 2005 14:11:17 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Peter Osterlund <petero2@telia.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org, <dtor_core@ameritech.net>,
       zaitcev@redhat.com
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050202141117.688c8dd3@localhost.localdomain>
In-Reply-To: <m3lla64r3w.fsf@telia.com>
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
	<20050201234148.4d5eac55@localhost.localdomain>
	<m3lla64r3w.fsf@telia.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Feb 2005 21:57:39 +0100, Peter Osterlund <petero2@telia.com> wrote:

> Please try this patch instead. It works well with my alps touchpad. (I
> don't have a synaptics touchpad.) It does the following:
> 
> * Compensates for the lack of floating point arithmetic by keeping
>   track of remainders from the integer divisions.
> * Removes the xres/yres scaling so that you get the same speed in the
>   X and Y directions even if your screen is not square.
> * Sets scale factors so that the speed for synaptics and alps should
>   be equal to each other and equal to the synaptics speed from 2.6.10.

Thanks a lot, Peter. I think I like the result even better than the one
after the simple-minded removal that I posted. It's possible that when
I accepted the case of (pktcount == 1) it hurt smoothness.

Do you think it makes sense to zero fractions when pktcount is dropped?
Also, I think the extra unary minus is uncoth.

-- Pete

--- linux-2.6.11-rc2/drivers/input/mousedev.c	2005-01-22 14:54:14.000000000 -0800
+++ linux-2.6.11-rc2-lem/drivers/input/mousedev.c	2005-02-02 14:03:07.000000000 -0800
@@ -71,6 +71,7 @@
 	struct mousedev_hw_data packet;
 	unsigned int pkt_count;
 	int old_x[4], old_y[4];
+	int frac_dx, frac_dy;
 	unsigned long touch;
 };
 
@@ -117,24 +118,31 @@
 
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
@@ -268,6 +276,8 @@
 			clear_bit(0, &mousedev_mix.packet.buttons);
 		}
 		mousedev->touch = mousedev->pkt_count = 0;
+		mousedev->frac_dx = 0;
+		mousedev->frac_dy = 0;
 	}
 	else
 		if (!mousedev->touch)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVBBVB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVBBVB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVBBVBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:01:50 -0500
Received: from av7-2-sn4.m-sp.skanova.net ([81.228.10.109]:40894 "EHLO
	av7-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S262833AbVBBU5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 15:57:46 -0500
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org, <dtor_core@ameritech.net>
Subject: Re: Touchpad problems with 2.6.11-rc2
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
	<20050201234148.4d5eac55@localhost.localdomain>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Feb 2005 21:57:39 +0100
In-Reply-To: <20050201234148.4d5eac55@localhost.localdomain>
Message-ID: <m3lla64r3w.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> writes:

> On 30 Jan 2005 12:10:34 +0100, Peter Osterlund <petero2@telia.com> wrote:
> 
> > > - Slow motion of finger produces no motion, then a jump. So, it's very hard to
> > >   target smaller UI elements and some web links.
> > 
> > I see this too when I don't use the X touchpad driver. With the X
> > driver there is no problem. I think the problem is that mousedev.c in
> > the kernel has to use integer arithmetic, so probably small movements
> > are rounded off to 0. I'll try to come up with a fix for this.
> 
> Thanks for the hint. I tried various schemes and mathematical transformations
> and found one which gives unquestionably the best result, with smoothest, most
> precise and comfortable pointer movement:

Please try this patch instead. It works well with my alps touchpad. (I
don't have a synaptics touchpad.) It does the following:

* Compensates for the lack of floating point arithmetic by keeping
  track of remainders from the integer divisions.
* Removes the xres/yres scaling so that you get the same speed in the
  X and Y directions even if your screen is not square.
* Sets scale factors so that the speed for synaptics and alps should
  be equal to each other and equal to the synaptics speed from 2.6.10.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/input/mousedev.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff -puN drivers/input/mousedev.c~mousedev-roundoff drivers/input/mousedev.c
--- linux/drivers/input/mousedev.c~mousedev-roundoff	2005-02-02 20:54:23.000000000 +0100
+++ linux-petero/drivers/input/mousedev.c	2005-02-02 21:42:39.000000000 +0100
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
+#define FRACTION_DENOM 100
 
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
+					tmp = ((fx(0) - fx(2)) * (250 * FRACTION_DENOM)) / size;
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
+					tmp = -((fy(0) - fy(2)) * (250 * FRACTION_DENOM)) / size;
+					tmp += mousedev->frac_dy;
+					mousedev->packet.dy = tmp / FRACTION_DENOM;
+					mousedev->frac_dy = tmp - mousedev->packet.dy * FRACTION_DENOM;
+				}
 				break;
 		}
 	}
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340

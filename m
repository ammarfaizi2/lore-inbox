Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVBCV4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVBCV4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVBCV4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:56:19 -0500
Received: from av7-2-sn4.m-sp.skanova.net ([81.228.10.109]:65243 "EHLO
	av7-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S262450AbVBCVzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:55:10 -0500
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: Re: Touchpad problems with 2.6.11-rc2
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
	<20050201234148.4d5eac55@localhost.localdomain>
	<m3lla64r3w.fsf@telia.com>
	<20050202141117.688c8dd3@localhost.localdomain>
	<Pine.LNX.4.58.0502022345320.18555@telia.com>
	<20050203064645.GA2342@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Feb 2005 22:54:51 +0100
In-Reply-To: <20050203064645.GA2342@ucw.cz>
Message-ID: <m31xbxxqac.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Wed, Feb 02, 2005 at 11:58:05PM +0100, Peter Osterlund wrote:
> 
> > In practice I don't think it will make any significant difference. What
> > the code should do depends on what you want to happen if you move the
> > mouse pointer 1/2 pixel with one finger stroke, then move it another 1/2
> > pixel with a second stroke. The patch I posted will move the pointer one
> > pixel in this case and your code will move it 0 pixels. (The X driver does
> > not reset the fractions, but that doesn't of course mean that it's the
> > only right thing to do.)
> > 
> > > Also, I think the extra unary minus is uncoth.
> > 
> > The code was written like that to emphasize the fact that X and Y use the
> > same formula, with the only difference that the kernel Y axis is mirrored
> > compared to the touchpad Y axis.
> > 
> > It didn't make any difference for the generated assembly code though,
> > using gcc 3.4.2 from Fedora Core 3.
> > 
> > > +	enum {  FRACTION_DENOM = 100 };
> > 
> > The enum is much nicer than my #define.
> 
> OK. I like this patch, too. Can you guys send me a final version
> incorporating the changes of you both for inclusion in the input tree?

Here it is, with the suggestions from Pete and Dmitry included. The
patch does the following:

* Compensates for the lack of floating point arithmetic by keeping
  track of remainders from the integer divisions.
* Removes the xres/yres scaling so that you get the same speed in the
  X and Y directions even if your screen is not square.
* Sets scale factors to make the speed for synaptics and alps equal to
  each other and equal to the synaptics speed from 2.6.10.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/input/mousedev.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff -puN drivers/input/mousedev.c~mousedev-roundoff drivers/input/mousedev.c
--- linux/drivers/input/mousedev.c~mousedev-roundoff	2005-02-02 20:54:23.000000000 +0100
+++ linux-petero/drivers/input/mousedev.c	2005-02-03 22:41:41.000000000 +0100
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
+	enum { FRACTION_DENOM = 128 };
 
 	if (mousedev->touch) {
+		size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
+		if (size == 0) size = 256 * 2;
 		switch (code) {
 			case ABS_X:
-				size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
-				if (size == 0) size = xres;
 				fx(0) = value;
-				if (mousedev->pkt_count >= 2)
-					mousedev->packet.dx = ((fx(0) - fx(1)) / 2 + (fx(1) - fx(2)) / 2) * xres / (size * 2);
+				if (mousedev->pkt_count >= 2) {
+					tmp = ((value - fx(2)) * (256 * FRACTION_DENOM)) / size;
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
+					tmp = -((value - fy(2)) * (256 * FRACTION_DENOM)) / size;
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
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340

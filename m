Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVBBVvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVBBVvK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVBBVuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:50:55 -0500
Received: from av1-1-sn1.fre.skanova.net ([81.228.11.107]:147 "EHLO
	av1-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262559AbVBBVro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:47:44 -0500
To: dtor_core@ameritech.net
Cc: Pete Zaitcev <zaitcev@redhat.com>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Touchpad problems with 2.6.11-rc2
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
	<20050201234148.4d5eac55@localhost.localdomain>
	<m3lla64r3w.fsf@telia.com> <d120d50005020213176eab546a@mail.gmail.com>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Feb 2005 22:47:42 +0100
In-Reply-To: <d120d50005020213176eab546a@mail.gmail.com>
Message-ID: <m31xby3a81.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Wed, 02 Feb 2005 13:07:21 -0800 (PST), Peter Osterlund
> <petero2@telia.com> wrote:
> > +                               if (mousedev->pkt_count >= 2) {
> > +                                       tmp = ((fx(0) - fx(2)) * (250 * FRACTION_DENOM)) / size;
> > +                                       tmp += mousedev->frac_dx;
> > +                                       mousedev->packet.dx = tmp / FRACTION_DENOM;
> > +                                       mousedev->frac_dx = tmp - mousedev->packet.dx * FRACTION_DENOM;
> > +                               }
> 
> What about setting scale to 256 and fractions to 128 - that should
> save some cycles? Or it will be too much?

It at least saves 32 bytes of object code. The mouse pointer speed
increase will only be 256/250, or 2.4%, so shouldn't be a problem.
Setting FRACTION_DENOM to a larger value is actually a good thing as
long as it doesn't cause arithmetic overflow.

Here is an updated patch:

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/input/mousedev.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff -puN drivers/input/mousedev.c~mousedev-roundoff drivers/input/mousedev.c
--- linux/drivers/input/mousedev.c~mousedev-roundoff	2005-02-02 20:54:23.000000000 +0100
+++ linux-petero/drivers/input/mousedev.c	2005-02-02 22:20:15.000000000 +0100
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
+#define FRACTION_DENOM 128
 
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
+					tmp = ((fx(0) - fx(2)) * (256 * FRACTION_DENOM)) / size;
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
+					tmp = -((fy(0) - fy(2)) * (256 * FRACTION_DENOM)) / size;
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

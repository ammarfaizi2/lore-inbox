Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266044AbTGLP1n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbTGLP1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:27:43 -0400
Received: from sun13.bham.ac.uk ([147.188.128.145]:50431 "EHLO
	sun13.bham.ac.uk") by vger.kernel.org with ESMTP id S266044AbTGLP1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:27:40 -0400
Subject: 2.4.22pre3 / pwc / emi disconnect == oops, workaround
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Jhqx7d8LY68rSPuaJT2H"
Organization: 
Message-Id: <1058024543.8030.3.camel@sage.kitchen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Jul 2003 16:42:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jhqx7d8LY68rSPuaJT2H
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Alan, all,

I added an extra check to the videodev.c's video_ioctl, to check vfl is
valid before dereferencing. (See attached patch).

The sequence to trigger the oops appears to be:

1. Open philips usb webcam device (any usb video device with ioctls ?).
2. Wait for (fairly rare) USB EMI issue to be flagged by hub.c.
3. usb.c appears to force a disconnect immediately after #2.
4. pwc module warns about a disconnect while open.
5. Next call to video_ioctl with handle from #1 causes oops.

I added a check to video_icotl to ensure video_device[] isn't NULL
before trying to call the ioctl method, and it returns EINVAL in that
case.

I'm not very familiar with the locking of usb/usb-uhci in this EMI case,
but both host drivers oops in the same way.  It would seem the open file
handle needs to be disassociated too somehow - or at least 'defered'
until the video camera is re-enabled after the EMI event.

Best regards,

Mark

PS. I've recently changed the physical layout of the machine, and it
seems the new cabling layout causes these occasional EMI issues.

-- 
Mark Cooke <mpc@star.sr.bham.ac.uk>

--=-Jhqx7d8LY68rSPuaJT2H
Content-Disposition: attachment; filename=patch-2.4.22-pre3-ac1-videodev
Content-Type: text/plain; name=patch-2.4.22-pre3-ac1-videodev; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.4.21/drivers/media/video/videodev.c.orig	2003-06-13 15:51:34.000000000 +0100
+++ linux-2.4.21/drivers/media/video/videodev.c	2003-07-10 23:00:49.000000000 +0100
@@ -209,7 +209,12 @@
 	unsigned int cmd, unsigned long arg)
 {
 	struct video_device *vfl = video_devdata(file);
-	int err=vfl->ioctl(vfl, cmd, (void *)arg);
+	int err;
+
+	if (!vfl)
+		return -EINVAL;
+	
+	err = vfl->ioctl(vfl, cmd, (void *)arg);
 
 	if(err!=-ENOIOCTLCMD)
 		return err;

--=-Jhqx7d8LY68rSPuaJT2H--


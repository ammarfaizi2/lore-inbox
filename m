Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVBBHmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVBBHmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 02:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVBBHl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 02:41:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53893 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261372AbVBBHl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 02:41:56 -0500
Date: Tue, 1 Feb 2005 23:41:48 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Peter Osterlund <petero2@telia.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org, zaitcev@redhat.com,
       <dtor_core@ameritech.net>
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050201234148.4d5eac55@localhost.localdomain>
In-Reply-To: <m3acqr895h.fsf@telia.com>
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jan 2005 12:10:34 +0100, Peter Osterlund <petero2@telia.com> wrote:

> > - Slow motion of finger produces no motion, then a jump. So, it's very hard to
> >   target smaller UI elements and some web links.
> 
> I see this too when I don't use the X touchpad driver. With the X
> driver there is no problem. I think the problem is that mousedev.c in
> the kernel has to use integer arithmetic, so probably small movements
> are rounded off to 0. I'll try to come up with a fix for this.

Thanks for the hint. I tried various schemes and mathematical transformations
and found one which gives unquestionably the best result, with smoothest, most
precise and comfortable pointer movement:

--- linux-2.6.11-rc2/drivers/input/mousedev.c	2005-01-22 14:54:14.000000000 -0800
+++ linux-2.6.11-rc2-lem/drivers/input/mousedev.c	2005-02-01 23:20:19.000000000 -0800
@@ -122,19 +122,19 @@ static void mousedev_touchpad_event(stru
 	if (mousedev->touch) {
 		switch (code) {
 			case ABS_X:
-				size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
-				if (size == 0) size = xres;
 				fx(0) = value;
 				if (mousedev->pkt_count >= 2)
-					mousedev->packet.dx = ((fx(0) - fx(1)) / 2 + (fx(1) - fx(2)) / 2) * xres / (size * 2);
+					mousedev->packet.dx = (value - fx(2)) / 2;
+				else if (mousedev->pkt_count == 1)
+					mousedev->packet.dx = value - fx(1);
 				break;
 
 			case ABS_Y:
-				size = dev->absmax[ABS_Y] - dev->absmin[ABS_Y];
-				if (size == 0) size = yres;
 				fy(0) = value;
 				if (mousedev->pkt_count >= 2)
-					mousedev->packet.dy = -((fy(0) - fy(1)) / 2 + (fy(1) - fy(2)) / 2) * yres / (size * 2);
+					mousedev->packet.dy = (fy(2) - value) / 2;
+				else if (mousedev->pkt_count == 1)
+					mousedev->packet.dy = fy(1) - value;
 				break;
 		}
 	}

I'm not kidding. Someone obviously outsmarted himself when programming this.

-- Pete

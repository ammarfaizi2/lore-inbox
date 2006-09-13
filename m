Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWIMSij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWIMSij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWIMSij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:38:39 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41490 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750761AbWIMSii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:38:38 -0400
Date: Wed, 13 Sep 2006 14:38:35 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-Reply-To: <200609131442.26784.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0609131407390.6684-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006, Rafael J. Wysocki wrote:

> Well, I have reproduced it with gregkh-usb-usbcore-remove-usb_suspend_root_hub.patch
> reverted too.
> 
> Attached is the output of dmesg from the failing case with USB_DEBUG set.
> It covers two attempts to suspend to disk, the second one being unsuccessful,
> with reloading the ohci_hcd module in between.  [This kernel also has your
> other patch to prevent the second suspend from failing applied, but it doesn't
> help.]

Okay.  Your problem, and probably Mattia's too, is something other than
what that recent patch addressed.  I can't tell from the dmesg log exactly
what went wrong, but I can tell you where to look.

In drivers/usb/core/driver.c, resume_device() is not succeeding.  That is, 
the lines near the end which do

	if (status == 0)
		udev->dev.power.power_state.event = PM_EVENT_ON;

aren't running during the first resume.  You can see this in the dmesg 
log; lines 1173-1175 say

	usb usb1: resuming
	 usbdev1.1_ep00: PM: resume from 0, parent usb1 still 1
	hub 1-0:1.0: PM: resume from 0, parent usb1 still 1

If power_state.event had gotten set to PM_EVENT_ON then the parent state 
would be 0, not 1.  This is the source of your problem.  During your 
second suspend attempt, usb1 didn't get handled correctly because its 
state was set wrong.  (I suspect the mishandling took place in usbcore 
rather than the PM core, but it doesn't matter.  The state should not have 
been wrong to begin with.)  Consequently its parent device 0000:00:13.2 
refused to freeze, which aborted the suspend attempt.

For the usb1 device, udriver->resume should point to the generic_resume() 
routine in drivers/usb/core/generic.c.  In fact, this should be true for 
every device that driver.c:resume_device() sees.  But generic_resume() 
simply calls usb_port_resume() in hub.c, and the log doesn't contain any 
of the USB debugging messages that usb_port_resume() would produce.  So I 
can't tell what happened.

The patch below will add some extra debugging information.  We need to
find out why the resume didn't succeed.  Oh -- and of course, you should
reinstate all those autosuspend patches.  Otherwise this patch won't 
apply!

Alan Stern



Index: mm/drivers/usb/core/driver.c
===================================================================
--- mm.orig/drivers/usb/core/driver.c
+++ mm/drivers/usb/core/driver.c
@@ -825,6 +825,7 @@ static int resume_device(struct usb_devi
 	struct usb_device_driver	*udriver;
 	int				status = 0;
 
+	dev_dbg(&udev->dev, "%s: state %d\n", __FUNCTION__, udev->state);
 	if (udev->state == USB_STATE_NOTATTACHED ||
 			udev->state != USB_STATE_SUSPENDED)
 		goto done;
@@ -839,7 +840,7 @@ static int resume_device(struct usb_devi
 	status = udriver->resume(udev);
 
 done:
-	// dev_dbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
+	dev_dbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
 	if (status == 0)
 		udev->dev.power.power_state.event = PM_EVENT_ON;
 	return status;


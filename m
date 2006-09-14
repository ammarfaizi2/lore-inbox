Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWINQRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWINQRY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 12:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWINQRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 12:17:24 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:24588 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750960AbWINQRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 12:17:24 -0400
Date: Thu, 14 Sep 2006 12:17:23 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       Robert Hancock <hancockr@shaw.ca>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-Reply-To: <Pine.LNX.4.44L0.0609141100580.8471-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.44L0.0609141202300.5715-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Alan Stern wrote:

> Now of course, the autosuspend stuff has to work properly no matter what 
> the kernel configuration is.  I'll go back and rebuild the drivers with 
> USB_SUSPEND turned off and see what happens.  With any luck I'll have a 
> fix ready in the near future.

This should start fixing things, but I'm not certain it will solve the 
entire problem.  If it doesn't work, send another dmesg log.

Alan Stern



Index: mm/drivers/usb/core/driver.c
===================================================================
--- mm.orig/drivers/usb/core/driver.c
+++ mm/drivers/usb/core/driver.c
@@ -813,7 +813,7 @@ static int suspend_device(struct usb_dev
 	status = udriver->suspend(udev, msg);
 
 done:
-	// dev_dbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
+	dev_dbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
 	if (status == 0)
 		udev->dev.power.power_state.event = msg.event;
 	return status;
@@ -839,7 +839,7 @@ static int resume_device(struct usb_devi
 	status = udriver->resume(udev);
 
 done:
-	// dev_dbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
+	dev_dbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
 	if (status == 0)
 		udev->dev.power.power_state.event = PM_EVENT_ON;
 	return status;
@@ -876,7 +876,7 @@ static int suspend_interface(struct usb_
 	}
 
 done:
-	// dev_dbg(&intf->dev, "%s: status %d\n", __FUNCTION__, status);
+	dev_dbg(&intf->dev, "%s: status %d\n", __FUNCTION__, status);
 	if (status == 0)
 		intf->dev.power.power_state.event = msg.event;
 	return status;
@@ -917,7 +917,7 @@ static int resume_interface(struct usb_i
 	}
 
 done:
-	// dev_dbg(&intf->dev, "%s: status %d\n", __FUNCTION__, status);
+	dev_dbg(&intf->dev, "%s: status %d\n", __FUNCTION__, status);
 	if (status == 0)
 		intf->dev.power.power_state.event = PM_EVENT_ON;
 	return status;
@@ -1021,7 +1021,7 @@ int usb_suspend_both(struct usb_device *
 	} else if (parent)
 		usb_autosuspend_device(parent, 0);
 
-	// dev_dbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
+	dev_dbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
 	return status;
 }
 
@@ -1079,11 +1079,12 @@ int usb_resume_both(struct usb_device *u
 					PM_EVENT_ON)
 				status = -EHOSTUNREACH;
 		}
-		if (status == 0 && udev->state == USB_STATE_SUSPENDED)
+		if (status == 0)
 			status = resume_device(udev);
 		if (parent)
 			mutex_unlock(&parent->pm_mutex);
-	}
+	} else
+		status = resume_device(udev);
 
 	/* Now the parent won't suspend until we are finished */
 
@@ -1094,7 +1095,7 @@ int usb_resume_both(struct usb_device *u
 		}
 	}
 
-	// dev_dbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
+	dev_dbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
 	return status;
 }
 
Index: mm/drivers/usb/core/hub.c
===================================================================
--- mm.orig/drivers/usb/core/hub.c
+++ mm/drivers/usb/core/hub.c
@@ -1898,6 +1898,8 @@ static int hub_suspend(struct usb_interf
 		if (bus) {
 			int	status = hcd_bus_suspend (bus);
 
+	dev_dbg(&hdev->dev, "bus_suspend %d\n", status);
+
 			if (status != 0) {
 				dev_dbg(&hdev->dev, "'global' suspend %d\n",
 					status);
@@ -1923,6 +1925,9 @@ static int hub_resume(struct usb_interfa
 		struct usb_bus	*bus = hdev->bus;
 		if (bus) {
 			status = hcd_bus_resume (bus);
+
+	dev_dbg(&hdev->dev, "bus_resume %d\n", status);
+
 			if (status) {
 				dev_dbg(&intf->dev, "'global' resume %d\n",
 					status);


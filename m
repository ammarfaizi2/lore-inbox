Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751987AbWISOIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbWISOIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 10:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbWISOIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 10:08:45 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:19730 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751987AbWISOIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 10:08:44 -0400
Date: Tue, 19 Sep 2006 10:08:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] USB: fix root-hub resume when CONFIG_USB_SUSPEND is not set
Message-ID: <Pine.LNX.4.44L0.0609191007590.6555-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as786) removes a redundant test and fixes a problem
involving repeated system sleeps when CONFIG_USB_SUSPEND is not set.
During the first wakeup, the root hub's dev.power.power_state.event
field doesn't get updated, causing it not to be suspended during the
second sleep transition.

This takes care of the issue raised by Rafael J. Wysocki and Mattia
Dongili.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/usb/core/driver.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/driver.c
+++ usb-2.6/drivers/usb/core/driver.c
@@ -1075,10 +1075,15 @@ int usb_resume_both(struct usb_device *u
 					PM_EVENT_ON)
 				status = -EHOSTUNREACH;
 		}
-		if (status == 0 && udev->state == USB_STATE_SUSPENDED)
+		if (status == 0)
 			status = resume_device(udev);
 		if (parent)
 			mutex_unlock(&parent->pm_mutex);
+	} else {
+
+		/* Needed only for setting udev->dev.power.power_state.event
+		 * and for possible debugging message. */
+		status = resume_device(udev);
 	}
 
 	/* Now the parent won't suspend until we are finished */


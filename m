Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWIMVBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWIMVBN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 17:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWIMVBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 17:01:13 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:3596 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751100AbWIMVBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 17:01:13 -0400
Date: Wed, 13 Sep 2006 17:01:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-Reply-To: <200609132200.51190.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0609131654190.5758-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006, Rafael J. Wysocki wrote:

> > The patch below will add some extra debugging information.  We need to
> > find out why the resume didn't succeed.  Oh -- and of course, you should
> > reinstate all those autosuspend patches.  Otherwise this patch won't 
> > apply!
> 
> OK
> 
> Attached is a dmesg output from 2.6.18-rc6-mm2 with the patch applied.
> It covers two consecutive attempts to suspend (the second one obviously
> failed).

Hmm... The patch didn't yield any output.  Unlike Mattia's log, yours
doesn't include any lines saying "usb usb1: wakeup_rh" so I can't be sure
whether the patch code should have run or not.

Try this patch instead.  It looks for problems occurring a little earlier 
in the call chain.

Alan Stern


Index: mm/drivers/usb/core/hcd-pci.c
===================================================================
--- mm.orig/drivers/usb/core/hcd-pci.c
+++ mm/drivers/usb/core/hcd-pci.c
@@ -406,6 +406,8 @@ int usb_hcd_pci_resume (struct pci_dev *
 			usb_hc_died (hcd);
 		}
 	}
+	dev_dbg(&dev->dev, "Controller %p state after resume %d\n",
+			&dev->dev, dev->dev.power.power_state.event);
 
 	return retval;
 }
Index: mm/drivers/usb/core/driver.c
===================================================================
--- mm.orig/drivers/usb/core/driver.c
+++ mm/drivers/usb/core/driver.c
@@ -1060,6 +1060,8 @@ int usb_resume_both(struct usb_device *u
 	struct usb_interface	*intf;
 	struct usb_device	*parent = udev->parent;
 
+	dev_dbg(&udev->dev, "Device state before resume %d\n", udev->state);
+
 	cancel_delayed_work(&udev->autosuspend);
 	if (udev->state == USB_STATE_NOTATTACHED)
 		return -ENODEV;
@@ -1072,6 +1074,9 @@ int usb_resume_both(struct usb_device *u
 			status = usb_resume_both(parent);
 		} else {
 
+	dev_dbg(&udev->dev, "Parent %p PM state %d\n",
+	udev->dev.parent, udev->dev.parent->power.power_state.event);
+
 			/* We can't progagate beyond the USB subsystem,
 			 * so if a root hub's controller is suspended
 			 * then we're stuck. */
@@ -1094,7 +1099,7 @@ int usb_resume_both(struct usb_device *u
 		}
 	}
 
-	// dev_dbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
+	dev_dbg(&udev->dev, "%s: status %d\n", __FUNCTION__, status);
 	return status;
 }
 


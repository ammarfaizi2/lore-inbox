Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWINUzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWINUzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWINUzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:55:50 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46096 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750958AbWINUzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:55:49 -0400
Date: Thu, 14 Sep 2006 16:55:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, David Brownell <david-b@pacbell.net>
cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       Robert Hancock <hancockr@shaw.ca>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-Reply-To: <200609142137.52066.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0609141618450.6982-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Rafael J. Wysocki wrote:

> Well, sorry.  This test has been passed, but after a reboot it refused to
> suspend just once giving the same messages that I've got from the kernel
> with USB_SUSPEND set (the relevant dmesg output is attached).
> 
> > Then for the next stage, repeat the same tests but with  
> > USB_SUSPEND set.

Okay, hang on, let's try to solve this first.

This actually is a completely different problem from what I've been
attacking up to now, and we definitely should resolve it.  It's purely a
question of the ohci-hcd driver, nothing (or very little) to do with
usbcore or ehci-hcd or uhci-hcd.

I'm asking David to chime in, because this is his code and his driver.

Here's an explanation of the problem.  Basically it boils down to the way 
ohci-hcd rolls its own root-hub autosuspend.  I'm referring to the call to 
ohci_bus_suspend() near the end of ohci-hub.c:ohci_hub_status_data().
Things go wrong because that call totally bypasses usbcore.  It's a 
layering violation.

The corresponding root-hub autoresume code, i.e., the call to
usb_hcd_resume_root_hub() in ohci-hcd.c:ohci_irq(), _does_ go through
usbcore.  It fails for two reasons.  First, resume_root_hub does its job
by queuing a call to usb_autoresume_device(), and when CONFIG_USB_SUSPEND
isn't set that routine is a no-op.  Second, since usbcore was never
notified when the root hub was suspended, the root hub's device state
isn't USB_STATE_SUSPENED and the interface is still marked as active -- so
even if usb_autoresume_device() did get called it wouldn't do anything.

As I see it, there are two ways to resolve the problem.  The easiest is to
rip out the autosuspend stuff from ohci-hcd entirely.  When my generic
autosuspend patches are accepted, the HCD-specific stuff won't be needed
so much.  This has the disadvantage that the root hub will never get
suspended if CONFIG_USB_SUSPEND isn't set.  On the other hand, this is how 
ehci_hcd works already.

The second way is to copy what I did in uhci-hcd.  There is a special
"root hub is stopped" mode which kicks in only when no ports are
connected.  It isn't a full-fledged suspend, in the sense that usbcore
isn't notified -- just like what happens in ohci-hcd.  The difference is,
since we know no devices are attached, the driver can go back to normal
operation while in interrupt context.  It doesn't have to sleep because no
attached devices means no TRSMRCY delay is needed and the controller's
hardware can be reset directly.  As a result, the corresponding
"auto-restart" code doesn't need to go through usbcore either and so
usb_autoresume_device() never enters the picture.

I don't know if this is feasible with OHCI.  For now, I'll include a patch 
that takes the first approach and disables the ohci-hcd autosuspend 
entirely.  I think it will solve your problem above.

Alan Stern


Index: mm/drivers/usb/host/ohci-hub.c
===================================================================
--- mm.orig/drivers/usb/host/ohci-hub.c
+++ mm/drivers/usb/host/ohci-hub.c
@@ -391,17 +391,6 @@ ohci_hub_status_data (struct usb_hcd *hc
 done:
 	spin_unlock_irqrestore (&ohci->lock, flags);
 
-#ifdef	CONFIG_PM
-	/* save power by autosuspending idle root hubs;
-	 * INTR_RD wakes us when there's work
-	 */
-	if (can_suspend && usb_trylock_device (hcd->self.root_hub) == 0) {
-		ohci_vdbg (ohci, "autosuspend\n");
-		(void) ohci_bus_suspend (hcd);
-		usb_unlock_device (hcd->self.root_hub);
-	}
-#endif
-
 	return changed ? length : 0;
 }
 


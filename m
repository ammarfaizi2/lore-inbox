Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271718AbTG2NPv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271719AbTG2NPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:15:51 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:31213 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S271718AbTG2NPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:15:35 -0400
Message-ID: <3F2673C4.9010302@pacbell.net>
Date: Tue, 29 Jul 2003 06:16:52 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: weissg@vienna.at, kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] OHCI problems with suspend/resume
References: <20030723220805.GA278@elf.ucw.cz>
In-Reply-To: <20030723220805.GA278@elf.ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------080601030404080107000309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080601030404080107000309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> Hi!
> 
> In 2.6.0-test1, OHCI is non-functional after first suspend/resume, and
> kills machine during secon suspend/resume cycle.

OK, I can see that in 2.6.0-test2 iff there's a device connected;
that's on OHCI hardware that doesn't retain power during suspend,
which means it uses the restart() path.  Hardware that retains
power depends on slightly different logic.


> What happens is that ohci_irq gets ohci->hcca == NULL, and kills
> machine. Why is ohci->hcca == NULL? ohci_stop was called from
> hcd_panic() and freed ohci->hcca.

Of course, the HC shouldn't have died and gone down those paths;
but the "HC died" paths need to work right too.


> I believe that we should
> 
> 1) not free ohci->hcca so that system has better chance surviving
> hcd_panic()

More like not calling stop() from hcd_panic.  Instead, all the
devices should be disconnected, and their urbs cleaned up.  That
way the controller will sit in a known and "safe" state (reset)
until the driver is shut down and gets stop()ped.  I think that
logic just "seemed to work" before, with subtle misbehaviors.

We're still working to make sure that we do all the right stuff
to shut down devices, no longer relying on USB device drivers to
shut themselves down properly in their disconnect() methods.
Many haven't, which can easily lead to oopsing on the shutdown
paths that don't get used very regularly.

Eventually I suspect that the HCD glue should grow logic to
try restarting drivers after the hardware dies/resets, but first
it's important to be sure they shut down properly.



> 2) inform user when hcd panics.

With a better diagnostic though.


Here's a patch that makes things slightly better.  It's still
not fully functional yet -- I forgot how many FIXMEs are in
those PM code paths! -- and shouldn't be merged as-is, but it
works slightly better:

  - Has a more informative diagnostic message (which HC died);

  - When HC dies, mark the whole tree as unavailable so that
    new URB submissions using that HC will just fail;

  - Then hcd_panic() just disconnects all the devices, still
    keeping the root hub around.

  - OHCI-specific (should be generic, hcd-pci.c):  don't
    try resuming a halted controller.

Where "better" means that it seems functional after the
first suspend/resume cycle, and re-enumerates the device
that's connected ... but there's still strangeness.  And
I can see how some of it would be generic.

- Dave



--------------080601030404080107000309
Content-Type: text/plain;
 name="die.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="die.patch"

--- 1.68/drivers/usb/core/hcd.c	Tue Jul 15 09:47:16 2003
+++ edited/drivers/usb/core/hcd.c	Sun Jul 27 19:42:46 2003
@@ -1487,8 +1488,26 @@
 
 static void hcd_panic (void *_hcd)
 {
-	struct usb_hcd *hcd = _hcd;
-	hcd->driver->stop (hcd);
+	struct usb_hcd		*hcd = _hcd;
+	struct usb_device	*hub = hcd->self.root_hub;
+
+	hub = usb_get_dev (hub);
+	usb_disconnect (&hub);
+
+	/* FIXME either try to restart, or arrange to clean up the 
+	 * hc-internal state, like usb_hcd_pci_remove() does
+	 */
+}
+
+void mark_gone (struct usb_device *dev)
+{
+	unsigned	i;
+
+	dev->state = USB_STATE_NOTATTACHED;
+	for (i = 0; i < dev->maxchild; i++) {
+		if (dev->children [i])
+			mark_gone (dev->children [i]);
+	}
 }
 
 /**
@@ -1501,29 +1520,12 @@
  */
 void usb_hc_died (struct usb_hcd *hcd)
 {
-	struct list_head	*devlist, *urblist;
-	struct hcd_dev		*dev;
-	struct urb		*urb;
-	unsigned long		flags;
-	
-	/* flag every pending urb as done */
-	spin_lock_irqsave (&hcd_data_lock, flags);
-	list_for_each (devlist, &hcd->dev_list) {
-		dev = list_entry (devlist, struct hcd_dev, dev_list);
-		list_for_each (urblist, &dev->urb_list) {
-			urb = list_entry (urblist, struct urb, urb_list);
-			dev_dbg (hcd->controller, "shutdown %s urb %p pipe %x, current status %d\n",
-				hcd->self.bus_name, urb, urb->pipe, urb->status);
-			if (urb->status == -EINPROGRESS)
-				urb->status = -ESHUTDOWN;
-		}
-	}
-	urb = (struct urb *) hcd->rh_timer.data;
-	if (urb)
-		urb->status = -ESHUTDOWN;
-	spin_unlock_irqrestore (&hcd_data_lock, flags);
+	dev_err (hcd->controller, "HC died; pending I/O will be aborted.\n");
 
-	/* hcd->stop() needs a task context */
+	/* prevent new submissions to devices in this tree */
+	mark_gone (hcd->self.root_hub);
+	
+	/* then usb_disconnect() them all, in a task context */
 	INIT_WORK (&hcd->work, hcd_panic, hcd);
 	(void) schedule_work (&hcd->work);
 }
--- 1.12/drivers/usb/host/ohci-pci.c	Mon Apr 14 02:51:40 2003
+++ edited/drivers/usb/host/ohci-pci.c	Sun Jul 27 18:51:21 2003
@@ -199,6 +199,11 @@
 	int			retval = 0;
 	unsigned long		flags;
 
+	if (hcd->state == USB_STATE_HALT) {
+		ohci_dbg (ohci, "USB restart of halted device\n");
+		return -EL3HLT;
+	}
+
 #ifdef CONFIG_PMAC_PBOOK
 	{
 		struct device_node *of_node;

--------------080601030404080107000309--



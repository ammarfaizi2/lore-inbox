Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTIVPJT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 11:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTIVPJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 11:09:19 -0400
Received: from ida.rowland.org ([192.131.102.52]:1028 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263179AbTIVPJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:09:17 -0400
Date: Mon, 22 Sep 2003 11:09:16 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Greg KH <greg@kroah.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: PATCH (as112) Re: USB APM suspend
In-Reply-To: <3F6E493B.7070901@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0309221034230.1884-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Sep 2003, David Brownell wrote:

> Alan Stern wrote:
> > Here's a piece from my system log, when I did "apm --suspend".  The 
> > usb_device_suspend/resume messages are things I added for debugging.
> 
> > Why was this routine called twice?  (Don't be fooled by the timestamps; I 
> > think the "suspend D4 --> D3" message was created during the suspend but 
> > not read by syslogd until after the resume.)
> 
> That's happened for as long as I remember (2.4 also).
> Still seems buglike to me, maybe 2.6 will finally squish it...

Well, the code path is easy enough to find.  If you look at suspend() in
arch/i386/kernel/apm.c, you'll see calls to pm_send_all() and
device_suspend().  They both end up filtering down to the USB HC drivers.  
The bad one is pm_send_all(); it comes too soon.

By the way, David, apparently core/hcd-pci.c wants the HC drivers to set 
the hcd state to USB_STATE_SUSPENDED, but a simple grep shows that neither 
the EHCI nor the OHCI driver does so.  That certainly looks like an 
oversight, though I'm not sure in which source file.

Meanwhile, here's a simple patch to improve logging during suspend and
resume.  Greg, if David approves please apply it.

Alan Stern


===== hcd-pci.c 1.35 vs edited =====
--- 1.35/drivers/usb/core/hcd-pci.c	Wed Sep  3 11:47:17 2003
+++ edited/drivers/usb/core/hcd-pci.c	Mon Sep 22 11:02:37 2003
@@ -273,17 +273,17 @@
 	int			retval = 0;
 
 	hcd = pci_get_drvdata(dev);
+	dev_dbg (hcd->controller, "suspend D%d --> D%d\n",
+			dev->current_state, state);
+
 	switch (hcd->state) {
 	case USB_STATE_HALT:
 		dev_dbg (hcd->controller, "halted; hcd not suspended\n");
 		break;
 	case USB_STATE_SUSPENDED:
-		dev_dbg (hcd->controller, "suspend D%d --> D%d\n",
-				dev->current_state, state);
+		dev_dbg (hcd->controller, "hcd already suspended\n");
 		break;
 	default:
-		dev_dbg (hcd->controller, "suspend to state %d\n", state);
-
 		/* remote wakeup needs hub->suspend() cooperation */
 		// pci_enable_wake (dev, 3, 1);
 
@@ -292,6 +292,9 @@
 		/* driver may want to disable DMA etc */
 		hcd->state = USB_STATE_QUIESCING;
 		retval = hcd->driver->suspend (hcd, state);
+		if (retval)
+			dev_dbg (hcd->controller, "suspend fail, retval %d\n",
+					retval);
 	}
 
  	pci_set_power_state (dev, state);
@@ -311,6 +314,9 @@
 	int			retval;
 
 	hcd = pci_get_drvdata(dev);
+	dev_dbg (hcd->controller, "resume from state D%d\n",
+			dev->current_state);
+
 	if (hcd->state != USB_STATE_SUSPENDED) {
 		dev_dbg (hcd->controller, "can't resume, not suspended!\n");
 		return -EL3HLT;


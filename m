Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVK1Qkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVK1Qkt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 11:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVK1Qkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 11:40:49 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:31084 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751285AbVK1Qks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 11:40:48 -0500
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Latest GIT: USB ehci_hcd broken (spinlock corruption)
Date: Mon, 28 Nov 2005 08:40:38 -0800
User-Agent: KMail/1.7.1
Cc: Michael Buesch <mbuesch@freenet.de>,
       Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
References: <200511271234.27708.mbuesch@freenet.de> <1133126726.7768.127.camel@gaston>
In-Reply-To: <1133126726.7768.127.camel@gaston>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GMziDOuEEi55aQy"
Message-Id: <200511280840.39002.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GMziDOuEEi55aQy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> Looks bad. I went through the code, and I discovered that indeed,
> usb_add_hcd() calls driver->reset() before anything else, that is,
> before giving the low level driver a chance to initialize it's local
> data structure, including the spinlock. On EHCI, at least, reset will
> dive deep into the guts of the driver tying among others to acquire the
> lock.

The last step of the misnamed ehci "reset" routine calls ehci_init()
to set up the HCD data structures ... which is well after the comment
saying "below this point it's all PCI-specific", and in particular it's
after the call to ehci_pci_reinit() which implicitly requires that init
to have been done already.  I'll be testing the attached patch, which
moves that data structure init up above that relevant line.

I think I see why I've not been seeing this problem though.  The
machines I can use for testing lately don't have per-port power
switching with EHCI ... so this particular codepath doesn't trigger.

 
> That is very bad. It's yet another example of broken "mid-layer" design.
> I can't say enough how bad this whole mid-layer hcd stuff is but you
> guys don't beleive it.

You _could_ get down off that hobby-horse, Ben.  In this case the issue
has nothing to do with how the hcd glue works, or doesn't.  :)

We've been slowly refactoring things to make them better.  Given that
it needs to be done while not breaking *lots of stuff* it goes slowly.
And the fact that we've been having to fill in some significant missing
pieces while we do that has also made it go slowly.


> So what you should do to fix the immediate problem is to have a separate
> "init" callback to the low level driver to initialize it's private data
> structure before anything else is called. A kind of "constructor". Call
> that from usb_add_hcd() before you call reset().

As of 2.6.15 I think the "reset" semantics have been entirely re-whacked;
we may well change the "reset" method name to match.  Not all the code
or comments have caught up to those changes yet.  The PCI devices are now
always using the "early usb handoff" logic, but the non-PCI devices need
some updates...

But there's a related point, that usb_add_hcd() sequences things in a
pretty strange order.  For one thing, the root hub isn't created at
the time that misnamed reset/init/setup routine is called ... which
means that one-time root hub customization must be done elsewhere, in
some routine that's not for one-time setup.  Of course I have a patch
for that; but that calls for a bit more testing.

- Dave



--Boundary-00=_GMziDOuEEi55aQy
Content-Type: text/x-diff;
  charset="us-ascii";
  name="e.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="e.patch"

Rename the EHCI "reset" routine so it better matches what it does (setup);
and move the one-time data structure setup earlier, before doing anything
that implicitly relies on it having been completed already.

--- g26.orig/drivers/usb/host/ehci-pci.c	2005-11-12 10:38:26.000000000 -0800
+++ g26/drivers/usb/host/ehci-pci.c	2005-11-28 08:22:59.000000000 -0800
@@ -121,8 +121,8 @@
 	return 0;
 }
 
-/* called by khubd or root hub (re)init threads; leaves HC in halt state */
-static int ehci_pci_reset(struct usb_hcd *hcd)
+/* called during probe() after chip reset completes */
+static int ehci_pci_setup(struct usb_hcd *hcd)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
 	struct pci_dev		*pdev = to_pci_dev(hcd->self.controller);
@@ -141,6 +141,11 @@
 	if (retval)
 		return retval;
 
+	/* data structure init */
+	retval = ehci_init(hcd);
+	if (retval)
+		return retval;
+
 	/* NOTE:  only the parts below this line are PCI-specific */
 
 	switch (pdev->vendor) {
@@ -154,7 +159,8 @@
 		/* AMD8111 EHCI doesn't work, according to AMD errata */
 		if (pdev->device == 0x7463) {
 			ehci_info(ehci, "ignoring AMD8111 (errata)\n");
-			return -EIO;
+			retval = -EIO;
+			goto done;
 		}
 		break;
 	case PCI_VENDOR_ID_NVIDIA:
@@ -216,9 +222,8 @@
 	}
 
 	retval = ehci_pci_reinit(ehci, pdev);
-
-	/* finish init */
-	return ehci_init(hcd);
+done:
+	return retval;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -328,7 +333,7 @@
 	/*
 	 * basic lifecycle operations
 	 */
-	.reset =		ehci_pci_reset,
+	.reset =		ehci_pci_setup,
 	.start =		ehci_run,
 #ifdef	CONFIG_PM
 	.suspend =		ehci_pci_suspend,

--Boundary-00=_GMziDOuEEi55aQy--

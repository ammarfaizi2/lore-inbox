Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269449AbUIYXvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269449AbUIYXvv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 19:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269447AbUIYXvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 19:51:22 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:6605 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S269449AbUIYXsN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 19:48:13 -0400
From: David Brownell <david-b@pacbell.net>
To: "Rui Nuno Capela" <rncbc@rncbc.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: OHCI_QUIRK_INITRESET (was: 2.6.9-rc2-mm2 ohci_hcd doesn't work)
Date: Sat, 25 Sep 2004 16:37:29 -0700
User-Agent: KMail/1.6.2
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Roman Weissgaerber" <weissg@vienna.at>,
       linux-usb-devel@lists.sourceforge.net, "K.R. Foley" <kr@cybsft.com>
References: <414F8CFB.3030901@cybsft.com> <25766.195.245.190.94.1096034422.squirrel@195.245.190.94> <200409241016.46201.bjorn.helgaas@hp.com>
In-Reply-To: <200409241016.46201.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5EgVBLAdFKd6kB+"
Message-Id: <200409251637.29401.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_5EgVBLAdFKd6kB+
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 24 September 2004 9:16 am, Bjorn Helgaas wrote:
> 
> The attached patch (which applies on top of Rui's patch for
> ALI M5237) fixes the problem for my DL360.  

Hmm, I'd rather avoid needing a quirk table ... especially
when I've always suspected this is some subtle bug in the
way Linux initializes!  Does this patch behave too?

- Dave

--Boundary-00=_5EgVBLAdFKd6kB+
Content-Type: text/x-diff;
  charset="utf-8";
  name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Diff"

Cope differently with hardware that doesn't act like we expect:
kick in the "initreset" quirk automatically, so we won't need
to maintain a quirk table.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- 1.82/drivers/usb/host/ohci-hcd.c	Mon Sep 20 10:31:27 2004
+++ edited/drivers/usb/host/ohci-hcd.c	Sat Sep 25 15:53:19 2004
@@ -545,6 +545,7 @@
 	/* 2msec timelimit here means no irqs/preempt */
 	spin_lock_irq (&ohci->lock);
 
+retry:
 	/* HC Reset requires max 10 us delay */
 	writel (OHCI_HCR,  &ohci->regs->cmdstatus);
 	temp = 30;	/* ... allow extra time */
@@ -563,6 +564,8 @@
 	 * ... but some hardware won't init fmInterval "by the book"
 	 * (SiS, OPTi ...), so reset again instead.  SiS doesn't need
 	 * this if we write fmInterval after we're OPERATIONAL.
+	 * Unclear about ALi, ServerWorks, and others ... this could
+	 * easily be a longstanding bug in chip init on Linux.
 	 */
 	if (ohci->flags & OHCI_QUIRK_INITRESET) {
 		writel (ohci->hc_control, &ohci->regs->control);
@@ -586,6 +589,11 @@
 	 */
 	if ((ohci_readl (&ohci->regs->fminterval) & 0x3fff0000) == 0
 			|| !ohci_readl (&ohci->regs->periodicstart)) {
+		if (!(ohci->flags & OHCI_QUIRK_INITRESET)) {
+			ohci->flags |= OHCI_QUIRK_INITRESET;
+			ohci_dbg (ohci, "enabling initreset quirk\n");
+			goto retry;
+		}
 		spin_unlock_irq (&ohci->lock);
 		ohci_err (ohci, "init err (%08x %04x)\n",
 			ohci_readl (&ohci->regs->fminterval),
--- 1.38/drivers/usb/host/ohci-pci.c	Fri Sep 10 17:57:52 2004
+++ edited/drivers/usb/host/ohci-pci.c	Sat Sep 25 15:51:41 2004
@@ -69,8 +69,6 @@
 				&& pdev->device == 0xc861) {
 			ohci_info (ohci,
 				"WARNING: OPTi workarounds unavailable\n");
-			/* OPTi sometimes acts wierd during init */
-			ohci->flags = OHCI_QUIRK_INITRESET;
 		}
 
 		/* Check for NSC87560. We have to look at the bridge (fn1) to
@@ -88,13 +86,6 @@
 				ohci_info (ohci, "Using NSC SuperIO setup\n");
 			}
 		}
-
-		/* SiS sometimes acts wierd during init */
-		else if (pdev->vendor == PCI_VENDOR_ID_SI) {
-			ohci->flags = OHCI_QUIRK_INITRESET;
-			ohci_info(ohci, "SiS init quirk\n");
-		}
-	
 	}
 
 	/* NOTE: there may have already been a first reset, to

--Boundary-00=_5EgVBLAdFKd6kB+--

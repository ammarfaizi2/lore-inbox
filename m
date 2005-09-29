Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbVI2Tjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbVI2Tjb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbVI2Tjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:39:31 -0400
Received: from pop.gmx.net ([213.165.64.20]:23202 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030184AbVI2Tj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:39:29 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Date: Thu, 29 Sep 2005 21:39:32 +0200
User-Agent: KMail/1.7.2
Cc: David Brownell <david-b@pacbell.net>, rjw@sisk.pl,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       hugh@veritas.com, akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org> <20050929000929.2CEACE372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <Pine.LNX.4.58.0509290832190.3308@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509290832190.3308@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509292139.33225.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 September 2005 17.36, Linus Torvalds wrote:
> 
> On Wed, 28 Sep 2005, David Brownell wrote:
> > 
> > You could try adding
> > 
> > 	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
> > 
> > near the end of ohci_pci_suspend().  

that's what i meant with "i think ohci-hcd does not fully disable
interrupts in it's suspend callback"...

> 
> Give it up.

i'd say: yes put that line there to shut up the controller during suspend
and nuke the free_irq() in suspend to avoid problems during restore (attached).

> 
> The right thing is to not free and re-aquire the damn interrupt in the 
> first place. It was a MISTAKE. We undid the ACPI braindamage that made it 
> be required a month ago, because sane people REALIZED it was a mistake.
> 
> It's not just "random luck" that not releasing the interrupt over suspend 
> fixes the problem. The problem is _due_ to drivers releasing the 
> interrupt in the first place.
> 
> IT DOESN'T MATTER what we do before the suspend, because we don't control 
> the wakeup sequence. If the BIOS wakeup enables the devices again, the 
> fact that we disabled them on suspend makes zero difference.
> 
> And yes, we can always "fix" things by selecting the right order to 
> re-aquire the interrupts, but the thing is, the "right order" will be 
> machine-dependent and in general depend on the phase of the moon and BIOS 
> version, and ACPI quirks.
> 
> The _only_ sane thing to do is to not drop the interrupts in the first 
> place. So that if you start getting interrupts before you expect them, you 
> can still handle them.
> 

fully agreed.

> 		Linus
> 

attached the patch that kills the free_irq()/request_irq() pair in USB.
one round in -mm?

rgds
-daniel

----

[PATCH] usb/core/hcd-pci.c: don't free_irq() on suspend

the free_irq() in USB suspend breaks resume on some setups where USB
(ohci/ehci) shares the interrupt with an other device.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -242,7 +242,6 @@ int usb_hcd_pci_suspend (struct pci_dev 
 	case HC_STATE_SUSPENDED:
 		/* no DMA or IRQs except when HC is active */
 		if (dev->current_state == PCI_D0) {
-			free_irq (hcd->irq, hcd);
 			pci_save_state (dev);
 			pci_disable_device (dev);
 		}
@@ -374,14 +373,6 @@ int usb_hcd_pci_resume (struct pci_dev *
 
 	hcd->state = HC_STATE_RESUMING;
 	hcd->saw_irq = 0;
-	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
-				hcd->irq_descr, hcd);
-	if (retval < 0) {
-		dev_err (hcd->self.controller,
-			"can't restore IRQ after resume!\n");
-		usb_hc_died (hcd);
-		return retval;
-	}
 
 	retval = hcd->driver->resume (hcd);
 	if (!HC_IS_RUNNING (hcd->state)) {


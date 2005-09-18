Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVIRVtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVIRVtT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 17:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVIRVtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 17:49:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:65437 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932216AbVIRVtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 17:49:19 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.13-mm2
Date: Sun, 18 Sep 2005 23:49:16 +0200
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
References: <20050908053042.6e05882f.akpm@osdl.org> <200509121206.05450.rjw@sisk.pl> <200509121209.47736.rjw@sisk.pl>
In-Reply-To: <200509121209.47736.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509182349.17632.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 12.09, Rafael J. Wysocki wrote:
> On Monday, 12 of September 2005 12:06, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > (continuing the unfinished message)
> > 
> > On Sunday, 11 of September 2005 22:08, Daniel Ritz wrote:
> > > On Sunday 11 September 2005 21.36, Andrew Morton wrote:
> > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > >
> > > > > > 
> > > > >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> > > > >  > 
> > > > >  > (kernel.org propagation is slow.  There's a temp copy at
> > > > >  > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm2.bz2)
> > > > > 
> > > > >  Could you please reintroduce the yenta-free_irq-on-suspend.patch (attached)
> > > > >  into -mm?  My box does not resume from disk without it.
> > > > 
> > > > No probs.
> > > > 
> > > > Daniel, do you remember why we decided to drop it?  What should we do about
> > > > this?  Thanks.
> > > > 
> > > 
> > > yeah, there was a long discussion about it. see:
> > > 	http://marc.theaimsgroup.com/?t=112275164900002&r=1&w=4
> > > the reason being that it breaks APM suspend on Hugh Dickins' (added to cc:) laptop.
> > > Linus was quite clear about why reverting...
> > > 	http://marc.theaimsgroup.com/?l=linux-kernel&m=112278810115252&w=4
> > > 
> > > we should look at both problems in detail:
> > > - with APM it seems to break because the bridge gives interrupt before the
> > >   handler is installed.
> > > - with ACPI i think some _other_ device gives the interrupts too early. but
> > >   when all devices on the interrupt unregister the irq is disabled and the
> > >   problem is hidden.
> > > 
> > > i don't think we can do mutch about the APM case...
> > > 
> > > so Rafael, your /proc/interrupts, lspci -vvv and dmesg, please.
> > 
> > rafael@albercik:~> cat /proc/interrupts
> ]-- snip --[
> 
> BTW, please have a look at:
> http://bugzilla.kernel.org/show_bug.cgi?id=4416#c36
> and
> http://bugzilla.kernel.org/show_bug.cgi?id=4416#c37
> 

interesting. i'd say we get interrupt storms from usb which then hurt when
yenta has it's handler installed but usb has not. usb/hcd-pci.c frees the
irq on suspend...so it may be enough not to do that (survives suspend-to-ram
and suspend-to-disk here. yes, restore too :)

could you give that a tree w/o any free_irq-patches for yenta and co?

rgds
-daniel

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -242,7 +242,9 @@ int usb_hcd_pci_suspend (struct pci_dev 
 	case HC_STATE_SUSPENDED:
 		/* no DMA or IRQs except when HC is active */
 		if (dev->current_state == PCI_D0) {
+#if 0
 			free_irq (hcd->irq, hcd);
+#endif
 			pci_save_state (dev);
 			pci_disable_device (dev);
 		}
@@ -374,6 +376,7 @@ int usb_hcd_pci_resume (struct pci_dev *
 
 	hcd->state = HC_STATE_RESUMING;
 	hcd->saw_irq = 0;
+#if 0
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->irq_descr, hcd);
 	if (retval < 0) {
@@ -382,6 +385,7 @@ int usb_hcd_pci_resume (struct pci_dev *
 		usb_hc_died (hcd);
 		return retval;
 	}
+#endif
 
 	retval = hcd->driver->resume (hcd);
 	if (!HC_IS_RUNNING (hcd->state)) {

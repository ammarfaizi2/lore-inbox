Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVI1UFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVI1UFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVI1UFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:05:47 -0400
Received: from pop.gmx.de ([213.165.64.20]:57520 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750757AbVI1UFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:05:46 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.13-mm2
Date: Wed, 28 Sep 2005 22:05:47 +0200
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>,
       "linux-usb" <linux-usb-devel@lists.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>
References: <20050908053042.6e05882f.akpm@osdl.org> <200509182349.17632.daniel.ritz@gmx.ch> <200509231852.15950.rjw@sisk.pl>
In-Reply-To: <200509231852.15950.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509282205.49316.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 September 2005 18.52, Rafael J. Wysocki wrote:
> Hi,
> 
> [sorry for the delay]

[same :]

> 
> On Sunday, 18 of September 2005 23:49, Daniel Ritz wrote:
> ]--snip--[
> > > 
> > > BTW, please have a look at:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=4416#c36
> > > and
> > > http://bugzilla.kernel.org/show_bug.cgi?id=4416#c37
> > > 
> > 
> > interesting. i'd say we get interrupt storms from usb which then hurt when
> > yenta has it's handler installed but usb has not. usb/hcd-pci.c frees the
> > irq on suspend...so it may be enough not to do that (survives suspend-to-ram
> > and suspend-to-disk here. yes, restore too :)
> > 
> > could you give that a tree w/o any free_irq-patches for yenta and co?
> 
> I've tried and it apparently works provided that _none_ of the IRQ-sharing
> devices drops the IRQ on suspend.

ok. i didn't look too close, but i think ohci-hcd does not fully disable interrupts
in it's suspend callback...needs a closer look. cc:ing linux-usb-devel...

> 
> I think that's the whole point: Either all of the devices should drop/request
> IRQs on suspend/resume, or none of them should do this.  IMHO we need to
> chose one of these options and call it "the right way" or there always
> will be problems with this.
> 

cc:ing linus since he seems to have a strong opinion about that free_irq-in-suspend
thing...not doing it for USB fixes the problem for both cases: APM suspend and ACPI
suspend...

> Greetings,
> Rafael

rgds
-daniel

> 
> 
> > diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> > --- a/drivers/usb/core/hcd-pci.c
> > +++ b/drivers/usb/core/hcd-pci.c
> > @@ -242,7 +242,9 @@ int usb_hcd_pci_suspend (struct pci_dev 
> >  	case HC_STATE_SUSPENDED:
> >  		/* no DMA or IRQs except when HC is active */
> >  		if (dev->current_state == PCI_D0) {
> > +#if 0
> >  			free_irq (hcd->irq, hcd);
> > +#endif
> >  			pci_save_state (dev);
> >  			pci_disable_device (dev);
> >  		}
> > @@ -374,6 +376,7 @@ int usb_hcd_pci_resume (struct pci_dev *
> >  
> >  	hcd->state = HC_STATE_RESUMING;
> >  	hcd->saw_irq = 0;
> > +#if 0
> >  	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
> >  				hcd->irq_descr, hcd);
> >  	if (retval < 0) {
> > @@ -382,6 +385,7 @@ int usb_hcd_pci_resume (struct pci_dev *
> >  		usb_hc_died (hcd);
> >  		return retval;
> >  	}
> > +#endif
> >  
> >  	retval = hcd->driver->resume (hcd);
> >  	if (!HC_IS_RUNNING (hcd->state)) {
> > 
> > 
> 

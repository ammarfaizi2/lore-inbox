Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268484AbUIQGwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268484AbUIQGwj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 02:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268472AbUIQGwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 02:52:36 -0400
Received: from fmr05.intel.com ([134.134.136.6]:417 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S268484AbUIQGue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 02:50:34 -0400
Subject: RE: 2.6.9-rc2-mm1
From: Len Brown <len.brown@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <452548B29F0CCE48B8ABB094307EBA1C0651E9A9@USRV-EXCH2.na.uis.unisys.com>
References: <452548B29F0CCE48B8ABB094307EBA1C0651E9A9@USRV-EXCH2.na.uis.unisys.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095403811.2046.51.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Sep 2004 02:50:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-17 at 01:18, Protasevich, Natalie wrote:
> > On Thursday 16 September 2004 11:14 am, Jesse Barnes wrote:
> > > On Thursday, September 16, 2004 2:40 am, Andrew Morton wrote:
> > >  bk-acpi.patch
> > >
> > > Looks like some changes in this patch break sn2.  In particular,
> this
> > > hunk in
> > > acpi_pci_irq_enable():
> > >
> > > -               if (dev->irq && (dev->irq <= 0xF)) {
> > > +               if (dev->irq >= 0 && (dev->irq <= 0xF)) {
> > >                        printk(" - using IRQ %d\n", dev->irq);
> > >                        return_VALUE(dev->irq);
> > >                }
> > >                else {
> > >                        printk("\n");
> > > -                       return_VALUE(0);
> > > +                       return_VALUE(-EINVAL);
> > >                }
> > >
> > > Now instead of returning 0, we'll get -EINVAL when a driver calls
> > > pci_enable_device.  This is arguably correct since there's no _PRT
> > > entry (and in fact no ACPI namespace on sn2), but shouldn't the
> code
> 
> > > above be looking at the 'pin' value instead of dev->irq?  The sn2
> > > specific PCI code sets up each
> > > dev->irq long before this with the correct values...

No, in this context, the variable "pin" is to select PCI INTA/B/C/D, not
a interrupt controller pin.

If SN2 is using its pre-determied interrupt configuration, then is is
probably a bug that it calls down into this code at all, since SN2 wants
this code to be a NOP, yes?

> > I think the change above is actually from
> >    incorrect-pci-interrupt-assignment-on-es7000-for-pin-zero.patch
> 
> > of which I am officially ignorant :-)

yeah, probably these IRQ patches should come through me, but haven't b/c
my patch throughput has been very low the last couple of weeks.  At
least if I ship no new patches I don't get blamed for breaking stuff;-)

> I realize now that this is very involved piece of code and a lot was
> built around the assumption that IRQ0 is a timer interrupt (pin 0 is
> for
> PCI on ES7000), and assumption that everyone honors this assumption :)
> However, it seems wrong that we are not able to read literally what
> ACPI
> says, such as irq 0 for INTA. Maybe, it would be better if the code
> above was returing an error code, not an irq, which is returned in dev
> anyway. It should be some creative way to resolve this issue... I
> think
> the idea in the comment above by Jesse Barnes has good potential. 

Yes, there are lots of places where IRQ0 is an error condition.  I
expect that this was lazyness based on the fact that the timer code is
hard-wired to use IRQ0, so it is always taken on IA32.  My suggestion
to un-hard-wire the timer code was not greeted with enthusiasm, so this
is how things sit.

But IRQ0 should not be a problem on the ES7000, as there is an override
to supply IRQ0 from pin 0:20.  pin 0:0, on the other hand is a PCI
interrupt on the ES7000, completely valid to be assigned from the _PRT
and to be assigned by the es7000-specific code to any arbitrary IRQ#.

I'm not sure exactly that the patch above was trying to fix.  Looks like
it is time to examine the latest ew7000 changes in detail.  But I think
the patch has pointed out that this routine really should be returning 0
for success and non zero for failure; and returning dev->irq was
probably a latent bug all along.

-Len




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268239AbUHKVdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268239AbUHKVdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268241AbUHKVdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:33:43 -0400
Received: from fmr99.intel.com ([192.55.52.32]:29630 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S268239AbUHKVdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:33:20 -0400
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
From: Len Brown <len.brown@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com>
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092259920.5021.117.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Aug 2004 17:32:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've never understood this floppy IRQ6 business.
Apparently it requests IRQ6, but doesn't show up in /proc/interrupts

In any case, dropping a PCI interrupt on IRQ6 would surely break it
b/c that would set that IRQ6 to level trigger.

Before this change, did LNKD get set to something other than IRQ6?

-Len

On Wed, 2004-08-11 at 16:33, Bjorn Helgaas wrote:
> On Tuesday 10 August 2004 5:56 pm, Adrian Bunk wrote:
> > On Tue, Aug 10, 2004 at 04:46:57PM -0600, Bjorn Helgaas wrote:
> > > On Tuesday 10 August 2004 11:32 am, Adrian Bunk wrote:
> > > > On Tue, Aug 10, 2004 at 09:59:18AM -0600, Bjorn Helgaas wrote:
> > > > > On Tuesday 10 August 2004 9:09 am, Adrian Bunk wrote:
> > > > > > 2.6.8-rc3-mm1 boots fine on my computer.
> > > > > > 2.6.8-rc4-mm1 doesn't boot.
> > > > > > 2.6.8-rc4-mm1 with pci=routeirq boots.
> > > 
> > It happens before the
> >   floppy0: no floppy controllers found
> > line.
> > 
> > Could there be a problem because the floppy driver doesn't find 
> > anything (there's currently no floppy drive in my computer)?
> 
> Not only is your machine floppy drive-less, but the driver thinks you
> don't even have a floppy *controller*, which I assume is separate
> from the actual drive.
> 
> What mainboard do you have?  Does it boot without "pci=routeirq"
> if you turn CONFIG_BLK_DEV_FD off?
> 
> The code in the floppy_init() -> user_reset_fdc() -> WAIT() ->
> wait_til_done() -> reset_fdc() path looks pretty scary if there
> really is no controller out there.  I'd feel much better if
> we at least tried to use ACPI to figure out whether we have
> a controller before we try to talk to it.
> 
> All that aside, I still don't see how the pci=routeirq change
> would affect the floppy driver.  It does request_irq(6, ...),
> and it is interesting that you have this:
> 
>     ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
>     ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 6 (level, low) -> IRQ 6
> 
> which is for your NIC.  But the floppy controller isn't a PCI
> device, so the LNKD enable shouldn't matter to it.
> 
> Let's see... you're using the PIC model.  Maybe the floppy driver
> depends on the ACPI_IRQ_MODEL_PIC stuff in acpi_register_gsi()?
> Can you post the contents of /proc/interrupts with the floppy
> driver and "pci=routeirq"?  It seems weird to have the floppy
> and the NIC share an IRQ, but it looks like that's what should
> be happening.
> 
> Bjorn
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


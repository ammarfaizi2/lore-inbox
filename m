Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbULVA3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbULVA3X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbULVA3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:29:22 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:43927 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261921AbULVA2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:28:30 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200412220028.iBM0SB3d299993@fsgi900.americas.sgi.com>
Subject: Re: [PATCH] 2.6.10 Altix : ioc4 serial driver support
To: linux-kernel@vger.kernel.org
Date: Tue, 21 Dec 2004 18:28:11 -0600 (CST)
Cc: matthew@wil.cx, hch@infradead.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK I have a new version.

The code is at:
ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support

There is still a bit more testing I need to do but it can still be reviewed.

Thanks,
-- Pat


Here are the review comments:

Matthew Wilcox wrote:
 > 
 > Don't define your own names for standard PCI config space -- use the
 > ones in linux/pci.h instead.  This whole section should be deleted:
 > 
 > +/*
 > + * PCI Configuration Space Register Address Map, use offset from IOC4 PCI
 > + * configuration base such that this can be used for multiple IOC4s
 > + */
 > +#define IOC4_PCI_SCR      0x4  /* Status/Command */
 > +#define IOC4_PCI_REV      0x8  /* Revision */
 > +#define IOC4_PCI_LAT      0xC  /* Latency Timer */
 > +#define IOC4_PCI_BAR0     0x10 /* IOC4 base address 0 */
 > +#define IOC4_PCI_SIDV     0x2c /* Subsys ID and vendor */
 > +#define IOC4_PCI_CAP      0x34 /* Capability pointer */
 > +#define IOC4_PCI_LATGNTINT 0x3c        /* Max_lat, min_gnt, int_pin, int_line */
 > 

OK took this out.


 > 
 > Calling a pci_dev a "pci_handle" is confusing; most code uses "pdev".
 > 
 > +       pci_read_config_dword(pci_handle, IOC4_PCI_SCR, &tmp);
 > +       pci_write_config_dword(pci_handle, IOC4_PCI_SCR,
 > +                              tmp | PCI_COMMAND_MASTER |
 > +                              PCI_COMMAND_MEMORY |
 > +                              PCI_COMMAND_PARITY | PCI_COMMAND_SERR);

OK. Done.


 > 
 > You call pci_set_master() before this which takes care of PCI_COMMAND_MASTER.
 > You also call pci_enable_device() which calls pcibios_enable_device()
 > which ensures PCI_COMMAND_MEMORY is set if it needs to be.
 > 
 > So the code above should be:
 > 
 >         pci_read_config_dword(pdev, PCI_COMMAND, &cmd);
 >         pci_write_config_dword(pdev, PCI_COMMAND, cmd | \
 >                         PCI_COMMAND_PARITY | PCI_COMMAND_SERR);

OK. Done.


 > 
 > Personally, I believe we should be setting PCI_COMMAND_PARITY and
 > PCI_COMMAND_SERR on all devices by default in pcibios_enable_device,
 > if not in pci_enable_device().  But we don't, so it's fine to do it
 > in your driver for the moment.
 > 
 > 
 > You don't need the:
 > 
 > +       if (!ia64_platform_is("sn2"))

OK. Gone.

 > 
 > 
 > since this code will only ever be called if someone has an ioc4 in
 > their system.  If it's not an sn2, something's very strange ;-)
 > 
 > 
 > +struct pci_driver ioc4_s_driver = {
 > +      name     :"IOC4 Serial",
 > +      id_table :ioc4_s_id_table,
 > +      probe    :ioc4_attach,
 > +};
 > 
 > please use C99 initialisers instead

Sure. Sorry. Done.


 > 
 > 
 > +    {PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC4, PCI_ANY_ID, PCI_ANY_ID, 0,0,0},
 > you don't need the trailing zeroes

OK. Done.

 > I don't see why you need valid_icount_path().  Everywhere it's called,
 > you seem to have been handed an ioc4_port back by the kernel core.
 > Are you just checking for data corruption elsewhere, or is this masking
 > a bug elsewhere in the driver?

I fixed this up - it was code that hadn't been completely cleaned up.

> Why put it in arch/ia64/sn/io/sn2/driver/ioc4_serial.c ?!
> drivers/serial/ioc4.c would be the right place for it.  You put the
> Kconfig there -- that should be a clue.

OK. Moved.

> 
> It seems like you're directly dereferencing pointers to io memory instead
> of calling readb and friends.  I know, this driver doesn't need to be
> portable, but it helps any casual reader of this driver figure out what's
> going on.  And you can get rid of the 'volatile' that way ;-)

OK. Fixed.

> 
> Linux Device Drivers, Second edition says you shouldn't use SA_INTERRUPT
> without good reason (http://www.xml.com/ldd/chapter/book/ch09.html#t3)

OK. Removed.



Christoph Hellwig wrote:

> I took a very short look and what spring to mind first is that the
> device probing/remoal is rather bogus.  The ->probe/->remove callbacks
> of a PCI driver can be called at any time, and any initialization /
> teardown actions must happen from those.  A logical consequence of that
> is that a proper PCI driver should have no global state.
> 
> I'd also like to second Matthews commens, please move the driver to
> drivers/serial and use proper readX/writeX accessors.  Please run the
> driver through sparse to find the iomem derferences and possibly other
> issues.

I cleaned this up a bit.  There still are a couple of issues. One is
that the sgiioc4 driver also "uses" the ioc4 card for ide. So the probe
needs to "fail" so that both driver's probes will be called (is there a
better way?). Because of that the ->remove function isn't called
directly.

I still save off the pci_dev ptrs for all cards found, so I can
register with the serial core after probe (is there a better way?).
Should I register the driver separately for each card ? That seems a
bit overkill.


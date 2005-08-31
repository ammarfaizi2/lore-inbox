Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbVHaVUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbVHaVUi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVHaVUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:20:37 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:12728 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S964970AbVHaVUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:20:36 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [patch 04/16] I/O driver for 8250-compatible UARTs
Date: Wed, 31 Aug 2005 15:19:37 -0600
User-Agent: KMail/1.8.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
References: <resend.3.2982005.trini@kernel.crashing.org> <200508311338.52225.bjorn.helgaas@hp.com> <20050831201039.GM3966@smtp.west.cox.net>
In-Reply-To: <20050831201039.GM3966@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508311519.37523.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 August 2005 2:10 pm, Tom Rini wrote:
> On Wed, Aug 31, 2005 at 01:38:52PM -0600, Bjorn Helgaas wrote:
> > On Monday 29 August 2005 10:09 am, Tom Rini wrote:
> I've tried intentionally to not mention 'ttyS' anywhere (exposed to the
> user) because it's really not 'ttySN' but it is the port registered to
> us.

So kgdb's port N is different from ttySN?  That sounds really
confusing.  And KGDB_SIMPLE_SERIAL does mention "ttyS".

> There's really two cases we have to deal with.  The first case is a
> known at compile time or can be registered at boot-time easily port (ie
> dumb old PC or ARM boards).  The second case is "serial port over
> there".  Perhaps we should change the kgdb8250 arg to be an override of
> the default port, so:
> kgdb8250={io,mmio},<irq>,<token>,<baud rate>

That makes sense.  But I'd make it {io,mmio},<token>,<baud>,<irq>
so it's more like the existing "console=uart" argument.

> > > +	switch (CURRENTPORT.iotype) {
> > > +	case UPIO_MEM:
> > > +		if (CURRENTPORT.mapbase)
> > > +			kgdb8250_needs_request_mem_region = 1;
> > > +		if (CURRENTPORT.flags & UPF_IOREMAP) {
> > > +			CURRENTPORT.membase = ioport_map(CURRENTPORT.mapbase,
> > > +						      8 << KGDB8250_REG_SHIFT);
> > 
> > Shouldn't this be ioremap instead of ioport_map?
> 
> If I remember right from the testing, no.  Or if my memory is wrong and
> that's retorihcal, sure.

ioport_map() certainly isn't going to do anything good with an MMIO
address.

> > > +		printk(KERN_ERR "kgdb8250: argument error, usage: "
> > > +		       "kgdb8250=<port number>,<baud rate>");
> > > +#ifdef CONFIG_IA64
> > > +		printk(",<irq>,<iomem base>");
> > > +#endif
> > 
> > This isn't ia64-specific.
> 
> It is and it isn't.  Since no one's tried a PCI card uart for KGDB nor
> had a case where we have to pass in the mmio addr except on ia64, it is
> ia64-specific.

Maybe it's only been *tested* on ia64, but I don't think that's a
reason to make it compiled only on ia64.

> > > + * Syntax for this cmdline option is "kgdb8250=ttyno,baudrate"
> > > + * with ",irq,iomembase" tacked on the end on IA64.
> > 
> > This syntax doesn't really make sense on ia64, because there are
> > no fixed "ttyno/iomembase" mappings.  It would be unambiguous to
> > specify either ttyno OR iomembase, but there's no good way to use
> > both.
> 
> It's true that ttyno isn't really useful on ia64.

Then I think it would be a mistake to have syntax that requires both
ttyno and iomembase in the same command-line option.  I'm visualizing
something like this:

	kgdb8250=ttyS0,115200
	kgdb8250=io,0x3f8,115200,49
	kgdb8250=mmio,0xff5e0000,115200,49

where you can easily decide which type of device specification
you've got.

> > > +config KGDB_SIMPLE_SERIAL
> > > +	bool "Simple selection of KGDB serial port"
> > > +	depends on KGDB_8250
> > > +	default y
> > > +	help
> > > +	  If you say Y here, you will only have to pick the baud rate
> > > +	  and serial port (ttyS) that you wish to use for KGDB.  If you
> > > +	  say N, you will have provide the I/O port and IRQ number.  Note
> > > +	  that if your serial ports are iomapped, such as on ia64, then
> > > +	  you must say Y here.  If in doubt, say Y.
> > 
> > How about: "... you will have to provide the address (I/O port or MMIO
> > address) and IRQ ..."
> 
> I'd really rather not force everyone to pass in the address token and
> IRQ#.

My point was merely that you should support explicit MMIO addresses
as well as explicit I/O ports.  I guess it makes sense to accept
ttyS names as well, and accept the limitation that before the 8250
driver initializes, ttyS names only work for devices defined at
compile-time in SERIAL_PORT_DFNS.

> > I don't understand the "iomapped" bit -- does that mean MMIO?  And why
> > would it make any difference whether they're in I/O port or MMIO space?
> 
> It's the special "boot once, figure out your I/O address and IRQ, reboot
> and pass it in" case of IA64.  I'm under the impression that it's
> because of the more dynamic than other arches that we couldn't just
> register the ports as we find them to KGDB and let the user pick from a
> pre-registered port that we play that game.

Yup, ia64 doesn't require serial ports at fixed addresses.  They're all
discovered via ACPI and PCI enumeration.

But "iomapped" doesn't suggest that to me.  And I would expect the
text to say that if you don't have any compiled-in UART names, you'd
have to say "N".  But it says use "Y" for ia64.

Actually, I think KGDB_SIMPLE_SERIAL, KGDB_*BAUD, KGDB_PORT_*,
KGDB_PORT, and KGDB_IRQ are overkill.  Could they all be nuked
in favor of a KGDB_8250_DEVICE that could be set to things like
"ttyS0,115200" or "io,0x3f8,115200,49"?

> > > +config KGDB_PORT
> > > +	hex "hex I/O port address of the debug serial port"
> > > +	depends on !KGDB_SIMPLE_SERIAL && KGDB_8250 && !IA64
> > > +	default 3f8
> > > +	help
> > > +	  This is the unmapped (and on platforms with 1:1 mapping
> > > +	  this is typically, but not always the same as the mapped)
> > > +	  address of the serial port.  The stanards on your architecture
> > > +	  may be found in include/asm-$(ARCH)/serial.h.
> > 
> > Not ia64-specific.  The description sounds like it applies to MMIO,
> > not to I/O port space.    And s/stanards/standards/.
> 
> Having !mmio uarts on ia64 is news to me (but I've never used an ia64
> box), hence the depends line.

Intel-based boxes have only I/O port UARTs.  But regardless, the
MMIO-ness or I/O port-ness of a UART is completely arch-independent.

The description point is that "unmapped" and "1:1 mapping" sound like
things related to MMIO addresses, not to I/O port addresses.

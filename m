Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbUKVTNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbUKVTNd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbUKVTMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:12:05 -0500
Received: from fmr13.intel.com ([192.55.52.67]:51652 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S262359AbUKVTJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:09:05 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411200831560.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe>
	 <Pine.LNX.4.58.0411200831560.20993@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1101150469.20006.46.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Nov 2004 14:07:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 11:41, Linus Torvalds wrote:
> 
> On Sat, 20 Nov 2004, Len Brown wrote:
> >
> > It clears the ELCR on Linux boot.
> 
> I think this is _really_ wrong.
> 
> Basically, you're screwing up more and more PIC state.
> 
> Len, the PIC was _correct_ before ACPI touched it. We don't want to
> touch it MORE, we want to touch it LESS.
> 
> I'll try this for debugging, but what I want to figure out is where
> ACPI is doing something it shouldn't be doing, and _removing_ that.
> 
> We already had one patch where people tried to hide this problem by
> adding more code. Clearly, that patch was bogus. Yes, it hid the
> problem for floppies, but as shown by my other case (and as I was
> trying to say from the beginning), it's not about floppies. It's about
> _any_ non-PCI interrupt that apparently ACPI has done something
> _wrong_ for.

I agree that the system should work properly even if the legacy device
drivers are broken.  Please understand, however, that the legacy device
drivers _are_ broken.  The BIOS via ACPI clearly tells them if the
devices are present or not, and Linux isn't yet listening.

> So ACPI seems to assume that all interrupts are PCI interrupts, and
> that's just totally wrong. Clearing ELCR is more of this total
> wrongness. ELCR exists for a reason, namely that not all interrupts
> are PCI.

ACPI-compliant systems have three types of interrupts:
1. legacy
2. PCI
3. the ACPI SCI

The first two are described in the DSDT legacy devices and _PRT,
respectively.  The third is described in the FADT.  The MADT overrides
are available to handle any special cases, though that applies only to
IOAPIC mode.

If there are other interrupts, then it isn't an ACPI-compliant system
and it the BIOS should not enable ACPI.  If the BIOS erroneously enables
ACPI on such a system, the workaround is to boot with acpi=off.  I'd be
extremly interested to know of such a system, as I've not yet
encountered one.

> Also, you seem to still totally concentrate on PIRQ routing etc.
> Totally ignoring the fact that the problematic cases are about
> interrupts that have _nothing_ to do with PCI. Not the floppy, not the
> PS/2 mouse. NOT PCI! They're both on the southbridge behind a very
> special interface that may or may not look like a PCI bus internally,
> but might quite as well be something totally special-case (ie a
> perfectly normal case is that somebody literally just bolted an old
> 8042 controller core into the system and set up special case magic irq
> routing).

If somebody bolts motherboard hardware on and doesn't tell ACPI about
it, then they need to disable ACPI, which _owns_ configuration of
motherboard devices when it is enabled.

The problem at hand has everything to do with PCI interrupts, and how
they can conflict with legacy interrupts.

PIC hardware is level-HIGH sensitive, it cannot be programmed like
APIC INTIN's can.  The only way to effectively use it as level-LOW
sensitive such as that supplied by PCI devices, it so attach those
interrupts sources through inverters.  This is what the PIRQ routers
do.  I printed out the underlying PIRQ routers for the ICH in
the debug patch because all of the failures at hand seemed
to be in ICH systems and these registers tell us the state
not of the abstract PCI Interrupt link, but of the actual hardware that
can be driving that (legacy) interrupt input.

> > ps. what I think is happening...
> >
> > To its credit, he BIOS correctly recognizes that there is
> > no floppy, and it routes a PIRQ to IRQ6.  It correctly sets the
> > ELCR bit for this IRQ.
> >
> > Linux boots and disables all the PCI Interrupt Links,
> > which un-programs the PIRQ directed to IRQ6.
> 
> And this is what I think is the bug. There is no reason to disable the
> PCI interrupt link unless you have a damn good reason to do so.

The damn good reason is that doing otherwise breaks systems.
This is the cset comment for the line of code disabling the links:

ChangeSet 1.1608.11.11 2004/06/17 23:21:03 len.brown@intel.com
  [ACPI] avoid spurious interrupts on VIA
  http://bugzilla.kernel.org/show_bug.cgi?id=2243
drivers/acpi/pci_link.c 1.28.1.1 2004/06/11 10:38:46 len.brown@intel.com
  disable all PCI Interrupt Links to be enabled by _SRS

It would sure make my life easier if we didn't support
these VIA/Phoenix systems, but I don't think that breaking
them is what the community wants.

> > However, Linux doesn't clear the ELCR first,
> > and for some reason that causes an interrupt
> > to latch in IRQ6 -- though it is masked.
> >
> > Along comes the broken floppy driver before
> > the PCI devices probe.  floppy
> > doesn't realize there is no hardware and
> > unwittingly does a request_irq(6).
> 
> You are totally ignoring my other bug report which was for a
> (existing) PSAUX mouse driver on irq12.
> 
> If I had had a mouse on that port, it would not have worked.
> 
> So the fact is, ACPI does something WRONG.

The PS2 IRQ12 situation is exactly the same as the IRQ6 floppy
situation.  If the mouse or floppy were present, the BIOS would not have
given that interrupt to PCI.

-Len



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266965AbUBGQZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 11:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266970AbUBGQZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 11:25:25 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:48016 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266965AbUBGQZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 11:25:07 -0500
Date: Sat, 7 Feb 2004 17:24:45 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Len Brown <len.brown@intel.com>
Cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com, kernel@kolivas.org, Ian Kumlien <pomac@vapor.com>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
In-Reply-To: <1076166820.2613.47.camel@dhcppc4>
Message-ID: <Pine.LNX.4.55.0402071617240.12260@jurand.ds.pg.gda.pl>
References: <BF1FE1855350A0479097B3A0D2A80EE0023ED17F@hdsmsx402.hd.intel.com>
  <1076154378.8686.165.camel@dhcppc4>  <Pine.LNX.4.55.0402071307110.12260@jurand.ds.pg.gda.pl>
 <1076166820.2613.47.camel@dhcppc4>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004, Len Brown wrote:

> > > Int: type 3, pol 0, trig 0, bus 0, irq 0, 2-0
> > > should be:
> > > Int: type 0, pol 0, trig 0, bus 0, irq 0, 2-2
> > > 
> > > type should be mp_INT, not mp_ExtINT, and dstirq should be 2, not 0;
> > > yes?
> > 
> >  Nope -- it should be:
> > 
> > Int: type 0, pol 0, trig 0, bus 0, irq 0, 2-0
> > 
> > as the ACPI spec explicitly defines a 1:1 map -- see section 5.2.10.7 (I
> > have rev.2.0c): "This means that I/O APIC interrupt inputs 0-15 must be
> > mapped to global system interrupts 0-15 and have identical sources as the
> > 8259 IRQs 0-15 unless overrides are used."
> 
> ah, here is the one i was looking for -- the one from the over-ride, and
> it looks correct.
> 
> > > ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
> > trigger[0x0])
> > > Int: type 0, pol 0, trig 0, bus 0, irq 0, 2-2
> 
> I'm not sure what is going on with pin0 above -- (and below), i think
> there is a workaround in this system that isn't in the base kernel? 

 The system reports the timer IRQ to be routed to pin 2, even though it is
connected to pin 0.  There's no workaround in the kernel as working it
around cannot be handled in a generic way.

> Indeed, I've lost track of the original failure on this thread, was it
> simply that the timer came out as XT-PIC mode instead of IOAPIC-edge?

 The ACPI table had no entry for the timer IRQ, so Linux reverted to 
the ExtINT (XT-PIC) mode for the IRQ as a last resort.  It's only thanks 
to ancient EISA systems the fallback is there at all and ACPI-based 
systems happened to work.

> > > > > IRQ to pin mappings:
> > > > > IRQ0 -> 0:2-> 0:0
> > > > [...]
> > > > > IRQ9 -> 0:9-> 0:9
> > > > 
> > > >  These two entries are wrong -- the interrupts are set up as if they
> > > > were
> > > > connected to multiple I/O APIC inputs.  The first entry is a result of
> > > > your hack, but the second one suggests a bug somewhere.
> > > 
> > > Right, this means that there are multiple irq_2_pin entries, which isn't
> > > what we want.  Indeed, I've not seen a system were we _do_ want them --
> > > do system actually exist where the same interrupt wires simultaneously
> > > go to multiple interrupt input pins?
> > 
> >  I'm told such systems exist(ed), at least in the MP-table era so code
> > has been added to handle them.  Technically, there's nothing wrong with
> > that, except that the interrupt has to be level-triggered at the APIC
> > level, of course.
> > 
> Hmm, i wonder if any bad things go wrong for IRQ9 -> 0:9-> 0:9 -- I
> guess we do all the APIC tickling twice because we thing there are two
> pins associated with the IRQ.

 That entry appears due to conditions making the following entry being 
reported in the log:

IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)

I don't know why the SCI interrupt is set up the second time here.  That's 
the reason the interrupt is routed twice.

 As a side note, I wonder why entries for PCI interrupts are processed so
late...

> I suspect that we have some failing systems due to this bug for when the
> interrupt is _not_ identity mapped like this example -- b/c we'd ack the
> wrong pin as a side-effect of an interrupt...

 As you can see there's only one pin recorded twice.

> BTW. I've always disliked the IRQ -> pin mapping, it should really be
> IRQ <- pin mapping -- or maybe more accurately the vector should be in
> there...

 Well, using vectors wouldn't be that bad -- I've already discovered this
once. :-)  It would require a clean-up of ISA drivers, but actually that
is desireable regardless, as there are non-i386 systems supporting the ISA
bus out there that want to use numbers outside the 0-15 range for ISA
interrupts.

> > > This is a check for a bad BIOS that sets the timer to level triggered. 
> > > I don't see this as the case for the nforce2 system on hand.  Indeed,
> > > I've _never_ see this case, and I wonder if this clause can be deleted
> > > altogether...  Did I miss something?
> > 
> >  Note that in principle the timer can be set up for a level-triggered 
> > operation -- this used to be the case for MCA systems that had additional 
> > circuitry to ack the interrupt at the source.  I'm not sure if ACPI 
> > supports such a configuration -- the MPS certainly did.
> 
> >  Anyway, this workaround, if left in place, should be triggered for the
> > timer source (bus_irq == 0) regardless of the I/O APIC pin it's routed to
> > (global_irq).
> 
> this is an ACPI specific routine, (and IMHO it is thus mis-named --
> along with all the acpi-specific stuff in mpparse.c;-)  I'd be inclined
> to squak about a bogus entry rather than using a silent workaround for a
> system that may not actually exist.

 Someone has introduced it for a reason, I suppose -- can't the originator 
be tracked down?

> >  It's still correct -- we are still replacing an [IOAPIC.PIN -> IRQ] entry
> > (perhaps the arrow should be reversed), except we disregard old IOAPIC.PIN
> > information without examining it.
> 
> yes, not looking at the IOAPIC.PIN -- that is what i meant by obsolete
> comment. (and the fact that the arrow points from pin to IRQ is the only
> part of the comment i like;-)

 If interpreted as a vector as opposed to a physical IRQ line, then I 
agree -- I'd leave that as is, then.

> >  While being able to track an ExtINT source could be useful for the NMI
> > watchdog under certain circumstances, the ACPI spec does not recognize
> > this kind of interrupt and does not provide a means of expressing it in 
> > the tables.  So we cannot set any entry to ExtINT and the timer IRQ is an 
> > ordinary interrupt.  We assume LINT0 interrupts are ExtINT ones 
> > implicitly.
> 
> ACPI has an additional MADT entry type for specifying the NMI.

 That's for LINT1 that's (almost?) universally configured for NMI
interrupts, indeed.  OTOH, LINT0 of the BSP is typically configured as
ExtINT for the virtual wire mode, although I've met a system using a
through-I/O-APIC variation of the mode as well as one using the PIC
compatibility mode (we used to support both variations; I hope it hasn't
got broken) -- both of them had LINT0 inputs simply masked out.  The
MP-table provides a way to report any sensible interrupt configurations
for LINT inputs (including ExtINT, Fixed, SMI, etc.), not only the NMI.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

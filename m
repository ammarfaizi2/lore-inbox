Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266908AbUBGMl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 07:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266919AbUBGMl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 07:41:26 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:40892 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266908AbUBGMlV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 07:41:21 -0500
Date: Sat, 7 Feb 2004 13:41:19 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Len Brown <len.brown@intel.com>
Cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com, kernel@kolivas.org, Ian Kumlien <pomac@vapor.com>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
In-Reply-To: <1076154378.8686.165.camel@dhcppc4>
Message-ID: <Pine.LNX.4.55.0402071307110.12260@jurand.ds.pg.gda.pl>
References: <BF1FE1855350A0479097B3A0D2A80EE0023ED17F@hdsmsx402.hd.intel.com>
 <1076154378.8686.165.camel@dhcppc4>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004, Len Brown wrote:

> Maciej -- Sorry for the delayed response.  December was pretty busy and
> there was  a window where I didn't catch up on e-mail unless [PATCH] was
> in the subject.

 Sorry about that -- I could have added it to the subject, indeed.

> > > ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
> > > IOAPIC[0]: Assigned apic_id 2
> > > IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
> > > Bus #0 is ISA
> > > Int: type 3, pol 0, trig 0, bus 0, irq 0, 2-0
> > 
> >  I've browsed the relevant part of the ACPI spec and the above entry
> > is 
> > incorrect.  It looks like INTIN0 is now the preferred line for the
> > 8254 
> > timer; at least it is the default one when using ACPI tables.  This is
> > a 
> > bug in Linux.
> 
> Int: type 3, pol 0, trig 0, bus 0, irq 0, 2-0
> should be:
> Int: type 0, pol 0, trig 0, bus 0, irq 0, 2-2
> 
> type should be mp_INT, not mp_ExtINT, and dstirq should be 2, not 0;
> yes?

 Nope -- it should be:

Int: type 0, pol 0, trig 0, bus 0, irq 0, 2-0

as the ACPI spec explicitly defines a 1:1 map -- see section 5.2.10.7 (I
have rev.2.0c): "This means that I/O APIC interrupt inputs 0-15 must be
mapped to global system interrupts 0-15 and have identical sources as the
8259 IRQs 0-15 unless overrides are used."

> > > ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1]
> > trigger[0x3])
> > > Int: type 0, pol 1, trig 3, bus 0, irq 9, 2-9
> > 
> >  And yet another explicit entry which has an effect on configuration
> > as
> > reported below.
> 
> This is the ACPI SCI.  Mapping IRQ9 ot INTIN9 is a no-op.  The effect of
> this entry is to explicitly setting the polarity/triger to high/level. 
> If this were not present it would still be in IRQ9, but would be set to
> the default, which is low/level.

 Yep, just explaining the bits to Ross...

> > > IRQ to pin mappings:
> > > IRQ0 -> 0:2-> 0:0
> > [...]
> > > IRQ9 -> 0:9-> 0:9
> > 
> >  These two entries are wrong -- the interrupts are set up as if they
> > were
> > connected to multiple I/O APIC inputs.  The first entry is a result of
> > your hack, but the second one suggests a bug somewhere.
> 
> Right, this means that there are multiple irq_2_pin entries, which isn't
> what we want.  Indeed, I've not seen a system were we _do_ want them --
> do system actually exist where the same interrupt wires simultaneously
> go to multiple interrupt input pins?

 I'm told such systems exist(ed), at least in the MP-table era so code
has been added to handle them.  Technically, there's nothing wrong with
that, except that the interrupt has to be level-triggered at the APIC
level, of course.

> > @@ -940,7 +940,7 @@ void __init mp_override_legacy_irq (
> >          *      erroneously sets the trigger to level, resulting in a
> > HUGE 
> >          *      increase of timer interrupts!
> >          */
> > -       if ((bus_irq == 0) && (global_irq == 2) && (trigger == 3))
> > +       if ((bus_irq == 0) && (trigger == 3))
> >                 trigger = 1;
> 
> This is a check for a bad BIOS that sets the timer to level triggered. 
> I don't see this as the case for the nforce2 system on hand.  Indeed,
> I've _never_ see this case, and I wonder if this clause can be deleted
> altogether...  Did I miss something?

 Note that in principle the timer can be set up for a level-triggered 
operation -- this used to be the case for MCA systems that had additional 
circuitry to ack the interrupt at the source.  I'm not sure if ACPI 
supports such a configuration -- the MPS certainly did.

 Anyway, this workaround, if left in place, should be triggered for the
timer source (bus_irq == 0) regardless of the I/O APIC pin it's routed to
(global_irq).

> >         intsrc.mpc_type = MP_INTSRC;
> > @@ -961,7 +961,7 @@ void __init mp_override_legacy_irq (
> >          * Otherwise create a new entry (e.g. global_irq == 2).
> >          */
> >         for (i = 0; i < mp_irq_entries; i++) {
> > -               if ((mp_irqs[i].mpc_dstapic == intsrc.mpc_dstapic) 
> > +               if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus) 
> >                         && (mp_irqs[i].mpc_srcbusirq ==
> > intsrc.mpc_srcbusirq)) {
> >                         mp_irqs[i] = intsrc;
> >                         found = 1;
> 
> This makes sense.  If we're over-riding the destination, we don't care
> what the destination was before, ya?

 Worse even -- we may replace a wrong entry.

> this used to check dstapic and dstirq.
> it was partially fixed last summer when checking srcbus replaced
> checking dstirq.  Unclear why dstapic wasn't changed to srcbus at the
> same time.
> 
> i think with this change the comment above the code is no longer
> correct, yes?

 It's still correct -- we are still replacing an [IOAPIC.PIN -> IRQ] entry
(perhaps the arrow should be reversed), except we disregard old IOAPIC.PIN
information without examining it.

> > -               intsrc.mpc_irqtype = i ? mp_INT : mp_ExtINT;   /*
> > 8259A to #0 */
> > +               intsrc.mpc_irqtype = mp_INT;
> 
> I believe this change is correct.  When this code runs, the system is in
> APIC mode and there is no concept of vectored external PIC interrupts.

 While being able to track an ExtINT source could be useful for the NMI
watchdog under certain circumstances, the ACPI spec does not recognize
this kind of interrupt and does not provide a means of expressing it in 
the tables.  So we cannot set any entry to ExtINT and the timer IRQ is an 
ordinary interrupt.  We assume LINT0 interrupts are ExtINT ones 
implicitly.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

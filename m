Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUBGLqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 06:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUBGLqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 06:46:43 -0500
Received: from fmr03.intel.com ([143.183.121.5]:43929 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266853AbUBGLqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 06:46:37 -0500
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
From: Len Brown <len.brown@intel.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com, kernel@kolivas.org, Ian Kumlien <pomac@vapor.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0023ED17F@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0023ED17F@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1076154378.8686.165.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Feb 2004 06:46:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej -- Sorry for the delayed response.  December was pretty busy and
there was  a window where I didn't catch up on e-mail unless [PATCH] was
in the subject.

On Thu, 2003-12-11 at 10:15, Maciej W. Rozycki wrote:
> On Thu, 11 Dec 2003, Ross Dickson wrote:
> 
> > ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
> > IOAPIC[0]: Assigned apic_id 2
> > IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
> > Bus #0 is ISA
> > Int: type 3, pol 0, trig 0, bus 0, irq 0, 2-0
> 
>  I've browsed the relevant part of the ACPI spec and the above entry
> is 
> incorrect.  It looks like INTIN0 is now the preferred line for the
> 8254 
> timer; at least it is the default one when using ACPI tables.  This is
> a 
> bug in Linux.

Int: type 3, pol 0, trig 0, bus 0, irq 0, 2-0
should be:
Int: type 0, pol 0, trig 0, bus 0, irq 0, 2-2

type should be mp_INT, not mp_ExtINT, and dstirq should be 2, not 0;
yes?

> > ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
> trigger[0x0])
> > Int: type 0, pol 0, trig 0, bus 0, irq 0, 2-2
> 
>  Now this is an explicit entry stating the 8254 timer is connected to
> INTIN2.  If this is not the case, the BIOS is buggy and the solution
> is to
> fix it.  I don't consider it possible to be worked around in Linux
> except
> maybe with a command line option added manually.

Agreed.

> > ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1]
> trigger[0x3])
> > Int: type 0, pol 1, trig 3, bus 0, irq 9, 2-9
> 
>  And yet another explicit entry which has an effect on configuration
> as
> reported below.

This is the ACPI SCI.  Mapping IRQ9 ot INTIN9 is a no-op.  The effect of
this entry is to explicitly setting the polarity/triger to high/level. 
If this were not present it would still be in IRQ9, but would be set to
the default, which is low/level.

> > IRQ to pin mappings:
> > IRQ0 -> 0:2-> 0:0
> [...]
> > IRQ9 -> 0:9-> 0:9
> 
>  These two entries are wrong -- the interrupts are set up as if they
> were
> connected to multiple I/O APIC inputs.  The first entry is a result of
> your hack, but the second one suggests a bug somewhere.

Right, this means that there are multiple irq_2_pin entries, which isn't
what we want.  Indeed, I've not seen a system were we _do_ want them --
do system actually exist where the same interrupt wires simultaneously
go to multiple interrupt input pins?

> patch-mips-2.6.0-test11-20031209-acpi-irq0-1
> diff -up --recursive --new-file
> linux-mips-2.6.0-test11-20031209.macro/arch/i386/kernel/mpparse.c
> linux-mips-2.6.0-test11-20031209/arch/i386/kernel/mpparse.c
> 
> ---
> linux-mips-2.6.0-test11-20031209.macro/arch/i386/kernel/mpparse.c  
> 2003-11-25 04:57:01.000000000 +0000
> +++ linux-mips-2.6.0-test11-20031209/arch/i386/kernel/mpparse.c
> 2003-12-11 09:43:26.000000000 +0000
> @@ -940,7 +940,7 @@ void __init mp_override_legacy_irq (
>          *      erroneously sets the trigger to level, resulting in a
> HUGE 
>          *      increase of timer interrupts!
>          */
> -       if ((bus_irq == 0) && (global_irq == 2) && (trigger == 3))
> +       if ((bus_irq == 0) && (trigger == 3))
>                 trigger = 1;
>  

This is a check for a bad BIOS that sets the timer to level triggered. 
I don't see this as the case for the nforce2 system on hand.  Indeed,
I've _never_ see this case, and I wonder if this clause can be deleted
altogether...  Did I miss something?

>         intsrc.mpc_type = MP_INTSRC;
> @@ -961,7 +961,7 @@ void __init mp_override_legacy_irq (
>          * Otherwise create a new entry (e.g. global_irq == 2).
>          */
>         for (i = 0; i < mp_irq_entries; i++) {
> -               if ((mp_irqs[i].mpc_dstapic == intsrc.mpc_dstapic) 
> +               if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus) 
>                         && (mp_irqs[i].mpc_srcbusirq ==
> intsrc.mpc_srcbusirq)) {
>                         mp_irqs[i] = intsrc;
>                         found = 1;

This makes sense.  If we're over-riding the destination, we don't care
what the destination was before, ya?

this used to check dstapic and dstirq.
it was partially fixed last summer when checking srcbus replaced
checking dstirq.  Unclear why dstapic wasn't changed to srcbus at the
same time.

i think with this change the comment above the code is no longer
correct, yes?


> @@ -1008,9 +1008,10 @@ void __init mp_config_acpi_legacy_irqs (
>          */
>         for (i = 0; i < 16; i++) {
>  
> -               if (i == 2) continue;                   /* Don't
> connect IRQ2 */
> +               if (i == 2)
> +                       continue;                       /* Don't
> connect IRQ2 */

white-space -- ok.

>  
> -               intsrc.mpc_irqtype = i ? mp_INT : mp_ExtINT;   /*
> 8259A to #0 */
> +               intsrc.mpc_irqtype = mp_INT;

I believe this change is correct.  When this code runs, the system is in
APIC mode and there is no concept of vectored external PIC interrupts.

>                 intsrc.mpc_srcbusirq = i;                  /* Identity
> mapped */
>                 intsrc.mpc_dstirq = i;
>  

thanks,
-Len



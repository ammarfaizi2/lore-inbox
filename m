Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTLTLkg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 06:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTLTLkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 06:40:36 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:23309 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263893AbTLTLkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 06:40:33 -0500
Message-ID: <3FE4357A.4040709@nishanet.com>
Date: Sat, 20 Dec 2003 06:41:46 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: nforce2 one card per irq only
References: <20031216035219.GA1658@earth.solarsys.private> <20031216225614.7824d575.khali@linux-fr.org>
In-Reply-To: <20031216225614.7824d575.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does dmesg and dmesg -s65536 and
CONFIG_LOG_BUF_SHIFT 14 or 16 have
my dmesg and kern.log truncate here?
I can't see Ross' delay patch printk

In case of odd devfs vc tty thing I
tried "console=vc/0 console=tty0"

dmesg begins--

been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc660
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc690, dseg 0xf0000
pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: match found with the PnP device '00:08' and the driver 'system'
PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
SCSI subsystem initialized
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xa9 -> IRQ 23 Mode:1 Active:0)

and if I use smp instead of uniprocessor kernel,
I get a few lines more showing so Ross' numbers
show but PIC timer is on so the numbers are
useless

________________________________________________

MSI K7N2 Delta MCP2-T amd xp3000+ 333mhz fsb 1:1

nforce2, Award bios update stopped crashing

kernel 2.6.0-test11

I need Ross' ioapic patch to get ioapic edge timer
working.

cpu disconnect defaults to on, and on or off makes
no diff except 50% more MIS count, ERR 0 either way,
no crashes.

Once I moved a tulip ethernet 10/100 nic off the
irq of a promise ide controller I got ERR 0 and
much less MIS count.

24 hours uptime

           CPU0       
  0:   84527308    IO-APIC-edge  timer
  1:      37635    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     532175    IO-APIC-edge  i8042
 14:        106    IO-APIC-edge  ide0
 15:        215    IO-APIC-edge  ide1
 16:     354495   IO-APIC-level  ide2, ide3
 17:          0   IO-APIC-level  yenta, yenta
 19:     151532   IO-APIC-level  ide4, ide5
 20:     309690   IO-APIC-level  eth0
 21:       1579   IO-APIC-level  NVidia nForce2
NMI:          0 
LOC:   84527227 
ERR:          0
MIS:        188

according to athcool, cpu disconnect on

So one irq per slot is still necessary with pci on
this system, and hdparm unmask off did not help.

This is a uniprocessor but the hd controller and
tulip card on one irq would produce a lot of APIC
errors when cp over nfs while bonnie++, and here
is something from Maciej nominally for smp--

/usr/src/linux-2.6.0-test11/arch/i386/kernel/apic.c
        /*
         * Some unknown Intel IO/APIC (or APIC) errata is biting us with
         * certain networking cards. If high frequency interrupts are
         * happening on a particular IOAPIC pin, plus the IOAPIC routing
         * entry is masked/unmasked at a high rate as well then sooner or
         * later IOAPIC line gets 'stuck', no more interrupts are received
         * from the device. If focus CPU is disabled then the hang goes
         * away, oh well :-(
         *
         * [ This bug can be reproduced easily with a level-triggered
         *   PCI Ne2000 networking cards and PII/PIII processors, dual
         *   BX chipset. ]
         */
        /*
         * Actually disabling the focus CPU check just makes the hang less
         * frequent as it makes the interrupt distributon model be more
         * like LRU than MRU (the short-term load is more even across CPUs).
         * See also the comment in end_level_ioapic_irq().  --macro
         */



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285558AbRLGVdT>; Fri, 7 Dec 2001 16:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285565AbRLGVdL>; Fri, 7 Dec 2001 16:33:11 -0500
Received: from mtiwmhc25.worldnet.att.net ([204.127.131.50]:32981 "EHLO
	mtiwmhc25.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S285561AbRLGVdG>; Fri, 7 Dec 2001 16:33:06 -0500
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Grover <andrew.grover@intel.com>,
        John Clemens <john@deater.net>
In-Reply-To: <Pine.LNX.4.33.0112070925280.851-100000@segfault.osdlab.org>
In-Reply-To: <Pine.LNX.4.33.0112070925280.851-100000@segfault.osdlab.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 13:23:53 -0800
Message-Id: <1007760235.10687.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-07 at 09:35, Patrick Mochel wrote:
> 
> Hey there.

Hey to you too - thanks for chiming in!

> How new is this system?

Brand spankin'. About 3 weeks old. It's definitely acronym compliant
(ACPI, DMI, etc).

> If it's new (3-6 months) PCI IRQ information is probably encoded in ACPI
> AML methods. OEMs are gradually changing from the old way (PIRQ and MP
> tables, APM) to new Grand Unified Way(tm) (ACPI).

I've already noticed that APM locks the machine when "console blanking
with APM" is turned on. The ACPI semantics seem a bit bizarre (the
executable code thing), but it's worked well on (recent) laptops I've
used. Besides, new stuff is cool!

> For a while now, BIOSes have shipped with both old tables and ACPI tables,
> and in a lot of cases, one or the other lies. So, you're almost lucky in a
> sense. Unfortunately, it doesn't solve your problem.

Bizarrely enough, it seems that BOTH the $PIR table and the ACPI table
are borken (at least HP's BIOS engineers are consistent). dump_pirq
reports that 00:02 (my usb controller) is on "link" 0x59 (all the other
links are 0x00-0x03).  The $PIR *mask* is correct, though (according to
it, IRQ ll is the only allowable for that slot. As you can see below,
the ACPI table seems to agree about irq 9.

ACPI: Core Subsystem version [20011205]
...
ACPI: PCI Routing Table (bus 00)
  device=02 pin=00 irq=9
  device=04 pin=00 irq=11
  device=04 pin=01 irq=11
  device=08 pin=00 irq=5
  device=10 pin=00 irq=11
ACPI: PCI Routing Table (bus 01)
  device=00 pin=00 irq=11

> For some reason, the people that wrote the spec encoded PCI IRQ
> information in AML (ACPI Machine Language), instead of putting them in a
> flat table. Which means you need the interpretor up and running and you
> need to execute those methods (don't ask, just nod and smile).

Nod. :>

> The Intel ACPI guys kinda have this working. They are able to extract and
> execute the methods. But, they still have yet to make devices request and
> use that information. Maybe Andy Grover can comment on this..
> 
> BTW, The latest ACPI patch is at: http://sourceforge.net/projects/acpi/.

Thanks! Just got it and tried it.

Could I get your comments on a patch against 2.4.16-stock? I'm trying to
figure out the best way to automagically work around the bug, and this
is the best I've come up with so far. I need more DMI data from other HP
5400 series AMD/ALi laptops with the problem to come up with the most
accurate matches - right now it's tied to my machine type and BIOS
version.

--- linux/arch/i386/kernel/dmi_scan.c	Mon Dec  3 22:11:36 2001
+++ linux/arch/i386/kernel/dmi_scan.c	Fri Dec  7 01:14:18 2001
@@ -414,6 +414,20 @@
 	return 0;
 }
 
+/*
+ * Work around broken HP Pavilion Notebooks which assign USB to
+ * IRQ 9 even though it is actually wired to IRQ 11
+ */
+static __init int fix_broken_hp_bios_irq9(struct dmi_blacklist *d)
+{
+	extern int broken_hp_bios_irq9;
+	if (broken_hp_bios_irq9 == 0)
+	{
+		broken_hp_bios_irq9 = 1;
+		printk(KERN_INFO "%s detected - fixing broken IRQ routing\n", d->ident);
+	}
+	return 0;
+}
 
 /*
  *	Simple "print if true" callback
@@ -603,7 +617,14 @@
 			NO_MATCH, NO_MATCH
 			} },
 	 
-			
+	{ fix_broken_hp_bios_irq9, "HP Pavilion N5400 Series Laptop", {
+			MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			MATCH(DMI_BIOS_VERSION, "GE.M1.03"),
+			MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook Model GE"),
+			MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736")
+			} },
+ 
+
 	/*
 	 *	Generic per vendor APM settings
 	 */
--- linux/arch/i386/kernel/pci-irq.c	Sun Nov  4 09:31:58 2001
+++ linux/arch/i386/kernel/pci-irq.c	Fri Dec  7 00:38:17 2001
@@ -22,6 +22,8 @@
 #define PIRQ_SIGNATURE	(('$' << 0) + ('P' << 8) + ('I' << 16) + ('R' << 24))
 #define PIRQ_VERSION 0x0100
 
+int broken_hp_bios_irq9;
+
 static struct irq_routing_table *pirq_table;
 
 /*
@@ -565,6 +567,15 @@
 	DBG(" -> PIRQ %02x, mask %04x, excl %04x", pirq, mask, pirq_table->exclusive_irqs);
 	mask &= pcibios_irq_mask;
 
+	/* Work around broken HP Pavilion Notebooks which assign USB to
+	   IRQ 9 even though it is actually wired to IRQ 11 */
+
+	if (broken_hp_bios_irq9 && pirq == 0x59 && dev->irq == 9) {
+		dev->irq = 11;
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
+		r->set(pirq_router_dev, dev, pirq, 11);
+	}
+
 	/*
 	 * Find the best IRQ to assign: use the one
 	 * reported by the device if possible.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWHJUYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWHJUYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWHJUOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:36 -0400
Received: from mx1.suse.de ([195.135.220.2]:42896 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932271AbWHJTgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:18 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [61/145] x86_64: Replace mp bus array with bitmap for bus not pci
Message-Id: <20060810193616.B418B13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:16 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Since we only support PCI and ISA legacy busses now there is no need to 
have an full array with checking.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/io_apic.c |   92 ++++++++++---------------------------------
 arch/x86_64/kernel/mpparse.c |    9 +---
 include/asm-x86_64/mpspec.h  |    8 ---
 3 files changed, 27 insertions(+), 82 deletions(-)

Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -308,7 +308,7 @@ static int __init find_isa_irq_pin(int i
 	for (i = 0; i < mp_irq_entries; i++) {
 		int lbus = mp_irqs[i].mpc_srcbus;
 
-		if (mp_bus_id_to_type[lbus] == MP_BUS_ISA &&
+		if (test_bit(lbus, mp_bus_not_pci) &&
 		    (mp_irqs[i].mpc_irqtype == type) &&
 		    (mp_irqs[i].mpc_srcbusirq == irq))
 
@@ -324,7 +324,7 @@ static int __init find_isa_irq_apic(int 
 	for (i = 0; i < mp_irq_entries; i++) {
 		int lbus = mp_irqs[i].mpc_srcbus;
 
-		if ((mp_bus_id_to_type[lbus] == MP_BUS_ISA) &&
+		if (test_bit(lbus, mp_bus_not_pci) &&
 		    (mp_irqs[i].mpc_irqtype == type) &&
 		    (mp_irqs[i].mpc_srcbusirq == irq))
 			break;
@@ -364,7 +364,7 @@ int IO_APIC_get_PCI_irq_vector(int bus, 
 			    mp_irqs[i].mpc_dstapic == MP_APIC_ALL)
 				break;
 
-		if ((mp_bus_id_to_type[lbus] == MP_BUS_PCI) &&
+		if (!test_bit(lbus, mp_bus_not_pci) &&
 		    !mp_irqs[i].mpc_irqtype &&
 		    (bus == lbus) &&
 		    (slot == ((mp_irqs[i].mpc_srcbusirq >> 2) & 0x1f))) {
@@ -410,28 +410,11 @@ static int __init MPBIOS_polarity(int id
 	switch (mp_irqs[idx].mpc_irqflag & 3)
 	{
 		case 0: /* conforms, ie. bus-type dependent polarity */
-		{
-			switch (mp_bus_id_to_type[bus])
-			{
-				case MP_BUS_ISA: /* ISA pin */
-				{
-					polarity = default_ISA_polarity(idx);
-					break;
-				}
-				case MP_BUS_PCI: /* PCI pin */
-				{
-					polarity = default_PCI_polarity(idx);
-					break;
-				}
-				default:
-				{
-					printk(KERN_WARNING "broken BIOS!!\n");
-					polarity = 1;
-					break;
-				}
-			}
+			if (test_bit(bus, mp_bus_not_pci))
+				polarity = default_ISA_polarity(idx);
+			else
+				polarity = default_PCI_polarity(idx);
 			break;
-		}
 		case 1: /* high active */
 		{
 			polarity = 0;
@@ -469,28 +452,11 @@ static int MPBIOS_trigger(int idx)
 	switch ((mp_irqs[idx].mpc_irqflag>>2) & 3)
 	{
 		case 0: /* conforms, ie. bus-type dependent */
-		{
-			switch (mp_bus_id_to_type[bus])
-			{
-				case MP_BUS_ISA: /* ISA pin */
-				{
-					trigger = default_ISA_trigger(idx);
-					break;
-				}
-				case MP_BUS_PCI: /* PCI pin */
-				{
-					trigger = default_PCI_trigger(idx);
-					break;
-				}
-				default:
-				{
-					printk(KERN_WARNING "broken BIOS!!\n");
-					trigger = 1;
-					break;
-				}
-			}
+			if (test_bit(bus, mp_bus_not_pci))
+				trigger = default_ISA_trigger(idx);
+			else
+				trigger = default_PCI_trigger(idx);
 			break;
-		}
 		case 1: /* edge */
 		{
 			trigger = 0;
@@ -596,31 +562,17 @@ static int pin_2_irq(int idx, int apic, 
 	if (mp_irqs[idx].mpc_dstirq != pin)
 		printk(KERN_ERR "broken BIOS or MPTABLE parser, ayiee!!\n");
 
-	switch (mp_bus_id_to_type[bus])
-	{
-		case MP_BUS_ISA: /* ISA pin */
-		{
-			irq = mp_irqs[idx].mpc_srcbusirq;
-			break;
-		}
-		case MP_BUS_PCI: /* PCI pin */
-		{
-			/*
-			 * PCI IRQs are mapped in order
-			 */
-			i = irq = 0;
-			while (i < apic)
-				irq += nr_ioapic_registers[i++];
-			irq += pin;
-			irq = gsi_irq_sharing(irq);
-			break;
-		}
-		default:
-		{
-			printk(KERN_ERR "unknown bus type %d.\n",bus); 
-			irq = 0;
-			break;
-		}
+	if (test_bit(bus, mp_bus_not_pci)) {
+		irq = mp_irqs[idx].mpc_srcbusirq;
+	} else {
+		/*
+		 * PCI IRQs are mapped in order
+		 */
+		i = irq = 0;
+		while (i < apic)
+			irq += nr_ioapic_registers[i++];
+		irq += pin;
+		irq = gsi_irq_sharing(irq);
 	}
 	BUG_ON(irq >= NR_IRQS);
 	return irq;
Index: linux/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mpparse.c
+++ linux/arch/x86_64/kernel/mpparse.c
@@ -42,7 +42,7 @@ int acpi_found_madt;
  * MP-table.
  */
 unsigned char apic_version [MAX_APICS];
-unsigned char mp_bus_id_to_type [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
+DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 
 static int mp_current_pci_id = 0;
@@ -173,9 +173,9 @@ static void __init MP_bus_info (struct m
 	Dprintk("Bus #%d is %s\n", m->mpc_busid, str);
 
 	if (strncmp(str, "ISA", 3) == 0) {
-		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_ISA;
+		set_bit(m->mpc_busid, mp_bus_not_pci);
 	} else if (strncmp(str, "PCI", 3) == 0) {
-		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_PCI;
+		clear_bit(m->mpc_busid, mp_bus_not_pci);
 		mp_bus_id_to_pci_bus[m->mpc_busid] = mp_current_pci_id;
 		mp_current_pci_id++;
 	} else {
@@ -808,8 +808,7 @@ void __init mp_config_acpi_legacy_irqs (
 	/* 
 	 * Fabricate the legacy ISA bus (bus #31).
 	 */
-	mp_bus_id_to_type[MP_ISA_BUS] = MP_BUS_ISA;
-	Dprintk("Bus #%d is ISA\n", MP_ISA_BUS);
+	set_bit(MP_ISA_BUS, mp_bus_not_pci);
 
 	/* 
 	 * Locate the IOAPIC that manages the ISA IRQs (0-15). 
Index: linux/include/asm-x86_64/mpspec.h
===================================================================
--- linux.orig/include/asm-x86_64/mpspec.h
+++ linux/include/asm-x86_64/mpspec.h
@@ -159,13 +159,7 @@ struct mpc_config_lintsrc
 #define MAX_MP_BUSSES 256
 /* Each PCI slot may be a combo card with its own bus.  4 IRQ pins per slot. */
 #define MAX_IRQ_SOURCES (MAX_MP_BUSSES * 4)
-enum mp_bustype {
-	MP_BUS_ISA = 1,
-	MP_BUS_EISA,
-	MP_BUS_PCI,
-	MP_BUS_MCA
-};
-extern unsigned char mp_bus_id_to_type [MAX_MP_BUSSES];
+extern DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 
 extern unsigned int boot_cpu_physical_apicid;

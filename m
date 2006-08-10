Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWHJUYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWHJUYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWHJUO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:56 -0400
Received: from ns1.suse.de ([195.135.220.2]:37008 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932329AbWHJTgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:12 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [53/145] x86_64: Remove leftover MCE/EISA support
Message-Id: <20060810193608.1B19E13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:08 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

No 64bit EISA or Microchannel systems ever. Remove the left over code
in the IO-APIC driver and the mptable parser

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/io_apic.c |   57 +------------------------------------------
 arch/x86_64/kernel/mpparse.c |   16 ------------
 2 files changed, 3 insertions(+), 70 deletions(-)

Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -389,9 +389,7 @@ static int __init find_isa_irq_pin(int i
 	for (i = 0; i < mp_irq_entries; i++) {
 		int lbus = mp_irqs[i].mpc_srcbus;
 
-		if ((mp_bus_id_to_type[lbus] == MP_BUS_ISA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_EISA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_MCA) &&
+		if (mp_bus_id_to_type[lbus] == MP_BUS_ISA &&
 		    (mp_irqs[i].mpc_irqtype == type) &&
 		    (mp_irqs[i].mpc_srcbusirq == irq))
 
@@ -407,9 +405,7 @@ static int __init find_isa_irq_apic(int 
 	for (i = 0; i < mp_irq_entries; i++) {
 		int lbus = mp_irqs[i].mpc_srcbus;
 
-		if ((mp_bus_id_to_type[lbus] == MP_BUS_ISA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_EISA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_MCA) &&
+		if ((mp_bus_id_to_type[lbus] == MP_BUS_ISA) &&
 		    (mp_irqs[i].mpc_irqtype == type) &&
 		    (mp_irqs[i].mpc_srcbusirq == irq))
 			break;
@@ -472,27 +468,6 @@ int IO_APIC_get_PCI_irq_vector(int bus, 
 	return best_guess;
 }
 
-/*
- * EISA Edge/Level control register, ELCR
- */
-static int EISA_ELCR(unsigned int irq)
-{
-	if (irq < 16) {
-		unsigned int port = 0x4d0 + (irq >> 3);
-		return (inb(port) >> (irq & 7)) & 1;
-	}
-	apic_printk(APIC_VERBOSE, "Broken MPtable reports ISA irq %d\n", irq);
-	return 0;
-}
-
-/* EISA interrupts are always polarity zero and can be edge or level
- * trigger depending on the ELCR value.  If an interrupt is listed as
- * EISA conforming in the MP table, that means its trigger type must
- * be read in from the ELCR */
-
-#define default_EISA_trigger(idx)	(EISA_ELCR(mp_irqs[idx].mpc_srcbusirq))
-#define default_EISA_polarity(idx)	(0)
-
 /* ISA interrupts are always polarity zero edge triggered,
  * when listed as conforming in the MP table. */
 
@@ -505,12 +480,6 @@ static int EISA_ELCR(unsigned int irq)
 #define default_PCI_trigger(idx)	(1)
 #define default_PCI_polarity(idx)	(1)
 
-/* MCA interrupts are always polarity zero level triggered,
- * when listed as conforming in the MP table. */
-
-#define default_MCA_trigger(idx)	(1)
-#define default_MCA_polarity(idx)	(0)
-
 static int __init MPBIOS_polarity(int idx)
 {
 	int bus = mp_irqs[idx].mpc_srcbus;
@@ -530,21 +499,11 @@ static int __init MPBIOS_polarity(int id
 					polarity = default_ISA_polarity(idx);
 					break;
 				}
-				case MP_BUS_EISA: /* EISA pin */
-				{
-					polarity = default_EISA_polarity(idx);
-					break;
-				}
 				case MP_BUS_PCI: /* PCI pin */
 				{
 					polarity = default_PCI_polarity(idx);
 					break;
 				}
-				case MP_BUS_MCA: /* MCA pin */
-				{
-					polarity = default_MCA_polarity(idx);
-					break;
-				}
 				default:
 				{
 					printk(KERN_WARNING "broken BIOS!!\n");
@@ -599,21 +558,11 @@ static int MPBIOS_trigger(int idx)
 					trigger = default_ISA_trigger(idx);
 					break;
 				}
-				case MP_BUS_EISA: /* EISA pin */
-				{
-					trigger = default_EISA_trigger(idx);
-					break;
-				}
 				case MP_BUS_PCI: /* PCI pin */
 				{
 					trigger = default_PCI_trigger(idx);
 					break;
 				}
-				case MP_BUS_MCA: /* MCA pin */
-				{
-					trigger = default_MCA_trigger(idx);
-					break;
-				}
 				default:
 				{
 					printk(KERN_WARNING "broken BIOS!!\n");
@@ -731,8 +680,6 @@ static int pin_2_irq(int idx, int apic, 
 	switch (mp_bus_id_to_type[bus])
 	{
 		case MP_BUS_ISA: /* ISA pin */
-		case MP_BUS_EISA:
-		case MP_BUS_MCA:
 		{
 			irq = mp_irqs[idx].mpc_srcbusirq;
 			break;
Index: linux/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mpparse.c
+++ linux/arch/x86_64/kernel/mpparse.c
@@ -175,14 +175,10 @@ static void __init MP_bus_info (struct m
 
 	if (strncmp(str, "ISA", 3) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_ISA;
-	} else if (strncmp(str, "EISA", 4) == 0) {
-		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_EISA;
 	} else if (strncmp(str, "PCI", 3) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_PCI;
 		mp_bus_id_to_pci_bus[m->mpc_busid] = mp_current_pci_id;
 		mp_current_pci_id++;
-	} else if (strncmp(str, "MCA", 3) == 0) {
-		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_MCA;
 	} else {
 		printk(KERN_ERR "Unknown bustype %s\n", str);
 	}
@@ -465,14 +461,6 @@ static inline void __init construct_defa
 		case 5:
 			memcpy(bus.mpc_bustype, "ISA   ", 6);
 			break;
-		case 2:
-		case 6:
-		case 3:
-			memcpy(bus.mpc_bustype, "EISA  ", 6);
-			break;
-		case 4:
-		case 7:
-			memcpy(bus.mpc_bustype, "MCA   ", 6);
 	}
 	MP_bus_info(&bus);
 	if (mpc_default_type > 4) {
@@ -629,9 +617,7 @@ void __init find_intel_smp (void)
 			smp_scan_config(0xF0000,0x10000))
 		return;
 	/*
-	 * If it is an SMP machine we should know now, unless the
-	 * configuration is in an EISA/MCA bus machine with an
-	 * extended bios data area.
+	 * If it is an SMP machine we should know now.
 	 *
 	 * there is a real-mode segmented pointer pointing to the
 	 * 4K EBDA area at 0x40E, calculate and scan it here.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVC1OUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVC1OUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 09:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVC1OUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 09:20:42 -0500
Received: from unknown.xeex.net ([216.152.252.175]:34820 "EHLO
	mail.intworks.biz") by vger.kernel.org with ESMTP id S261790AbVC1OT6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 09:19:58 -0500
Date: Mon, 28 Mar 2005 06:19:55 -0800
From: jayalk@intworks.biz
Message-Id: <200503281419.j2SEJtTq014132@intworks.biz>
To: gregkh@suse.de
Subject: [RESEND PATCH 2.6.11.2 1/1] PCI Allow OutOfRange PIRQ table address
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, PCI folk,

Resending this patch. Is it okay now?

---

I updated this to remove unnecessary variable initialization, make 
check_routing be inline only and not __init, switch to strtoul, and 
formatting fixes as per Randy Dunlap's recommendations.

I updated this to change pirq_table_addr to a long, and to add a warning
msg if the PIRQ table wasn't found at the specified address, as per thread
with Matthew Wilcox. 

In our hardware situation, the BIOS is unable to store or generate it's PIRQ
table in the F0000h-100000h standard range. This patch adds a pci kernel
parameter, pirqaddr to allow the bootloader (or BIOS based loader) to inform
the kernel where the PIRQ table got stored. A beneficial side-effect is that,
if one's BIOS uses a static address each time for it's PIRQ table, then
pirqaddr can be used to avoid the $pirq search through that address block each
time at boot for normal PIRQ BIOSes.

---

Signed-off-by:	Jaya Kumar	<jayalk@intworks.biz>

diff -uprN -X dontdiff linux-2.6.11.2-vanilla/arch/i386/pci/common.c linux-2.6.11.2/arch/i386/pci/common.c
--- linux-2.6.11.2-vanilla/arch/i386/pci/common.c	2005-03-10 16:31:25.000000000 +0800
+++ linux-2.6.11.2/arch/i386/pci/common.c	2005-03-17 14:25:54.111123816 +0800
@@ -25,7 +25,8 @@ unsigned int pci_probe = PCI_PROBE_BIOS 
 
 int pci_routeirq;
 int pcibios_last_bus = -1;
-struct pci_bus *pci_root_bus = NULL;
+unsigned long pirq_table_addr;
+struct pci_bus *pci_root_bus;
 struct pci_raw_ops *raw_pci_ops;
 
 static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
@@ -188,6 +189,9 @@ char * __devinit  pcibios_setup(char *st
 	} else if (!strcmp(str, "biosirq")) {
 		pci_probe |= PCI_BIOS_IRQ_SCAN;
 		return NULL;
+	} else if (!strncmp(str, "pirqaddr=", 9)) {
+		pirq_table_addr = simple_strtoul(str+9, NULL, 0);
+		return NULL;
 	}
 #endif
 #ifdef CONFIG_PCI_DIRECT
diff -uprN -X dontdiff linux-2.6.11.2-vanilla/arch/i386/pci/irq.c linux-2.6.11.2/arch/i386/pci/irq.c
--- linux-2.6.11.2-vanilla/arch/i386/pci/irq.c	2005-03-10 16:31:25.000000000 +0800
+++ linux-2.6.11.2/arch/i386/pci/irq.c	2005-03-17 14:04:22.000000000 +0800
@@ -58,6 +58,35 @@ struct irq_router_handler {
 int (*pcibios_enable_irq)(struct pci_dev *dev) = NULL;
 
 /*
+ *  Check passed address for the PCI IRQ Routing Table signature 
+ *  and perform checksum verification.
+ */
+
+static inline struct irq_routing_table * pirq_check_routing_table(u8 *addr)
+{
+	struct irq_routing_table *rt;
+	int i;
+	u8 sum;
+
+	rt = (struct irq_routing_table *) addr;
+	if (rt->signature != PIRQ_SIGNATURE ||
+	    rt->version != PIRQ_VERSION ||
+	    rt->size % 16 ||
+	    rt->size < sizeof(struct irq_routing_table))
+		return NULL;
+	sum = 0;
+	for (i=0; i < rt->size; i++)
+		sum += addr[i];
+	if (!sum) {
+		DBG("PCI: Interrupt Routing Table found at 0x%p\n", rt);
+		return rt;
+	}
+	return NULL;
+}
+
+
+
+/*
  *  Search 0xf0000 -- 0xfffff for the PCI IRQ Routing Table.
  */
 
@@ -65,23 +94,17 @@ static struct irq_routing_table * __init
 {
 	u8 *addr;
 	struct irq_routing_table *rt;
-	int i;
-	u8 sum;
 
+	if (pirq_table_addr) {
+		rt = pirq_check_routing_table((u8 *) __va(pirq_table_addr));
+		if (rt)
+			return rt;
+		printk(KERN_WARNING "PCI: PIRQ table NOT found at pirqaddr\n"); 
+	}
 	for(addr = (u8 *) __va(0xf0000); addr < (u8 *) __va(0x100000); addr += 16) {
-		rt = (struct irq_routing_table *) addr;
-		if (rt->signature != PIRQ_SIGNATURE ||
-		    rt->version != PIRQ_VERSION ||
-		    rt->size % 16 ||
-		    rt->size < sizeof(struct irq_routing_table))
-			continue;
-		sum = 0;
-		for(i=0; i<rt->size; i++)
-			sum += addr[i];
-		if (!sum) {
-			DBG("PCI: Interrupt Routing Table found at 0x%p\n", rt);
+		rt = pirq_check_routing_table(addr);
+		if (rt) 
 			return rt;
-		}
 	}
 	return NULL;
 }
diff -uprN -X dontdiff linux-2.6.11.2-vanilla/arch/i386/pci/pci.h linux-2.6.11.2/arch/i386/pci/pci.h
--- linux-2.6.11.2-vanilla/arch/i386/pci/pci.h	2005-03-10 16:31:25.000000000 +0800
+++ linux-2.6.11.2/arch/i386/pci/pci.h	2005-03-17 08:54:36.000000000 +0800
@@ -27,6 +27,7 @@
 #define PCI_ASSIGN_ALL_BUSSES	0x4000
 
 extern unsigned int pci_probe;
+extern unsigned long pirq_table_addr;
 
 /* pci-i386.c */
 
diff -uprN -X dontdiff linux-2.6.11.2-vanilla/Documentation/kernel-parameters.txt linux-2.6.11.2/Documentation/kernel-parameters.txt
--- linux-2.6.11.2-vanilla/Documentation/kernel-parameters.txt	2005-03-10 16:31:44.000000000 +0800
+++ linux-2.6.11.2/Documentation/kernel-parameters.txt	2005-03-17 13:01:20.000000000 +0800
@@ -967,6 +967,10 @@ running once the system is up.
 		irqmask=0xMMMM		[IA-32] Set a bit mask of IRQs allowed to be assigned
 					automatically to PCI devices. You can make the kernel
 					exclude IRQs of your ISA cards this way.
+		pirqaddr=0xAAAAA	[IA-32] Specify the physical address
+					of the PIRQ table (normally generated
+					by the BIOS) if it is outside the
+					F0000h-100000h range.
 		lastbus=N		[IA-32] Scan all buses till bus #N. Can be useful
 					if the kernel is unable to find your secondary buses
 					and you want to tell it explicitly which ones they are.

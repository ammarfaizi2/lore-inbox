Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVCJNa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVCJNa4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 08:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVCJNa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 08:30:56 -0500
Received: from v-1635.easyco.net ([69.26.169.185]:9988 "EHLO mail.intworks.biz")
	by vger.kernel.org with ESMTP id S262596AbVCJN3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 08:29:54 -0500
Date: Thu, 10 Mar 2005 05:29:35 -0800
From: jayalk@intworks.biz
Message-Id: <200503101329.j2ADTZU0030146@intworks.biz>
To: gregkh@suse.de
Subject: [PATCH 2.6.11.2 1/1] PCI Allow OutOfRange PIRQ table address
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, PCI folk,

In our hardware situation, the BIOS is unable to store or generate it's PIRQ
table in the F0000h-100000h standard range. This patch adds a pci kernel
parameter, pirqaddr to allow the bootloader (or BIOS based loader) to inform
the kernel where the PIRQ table got stored. A beneficial side-effect is that,
if one's BIOS uses a static address each time for it's PIRQ table, then
pirqaddr can be used to avoid the $pirq search through that address block each
time at boot for normal PIRQ BIOSes.

Signed-off-by:	Jaya Kumar	<jayalk@intworks.biz>

diff -uprN -X dontdiff linux-2.6.11.2-vanilla/arch/i386/pci/common.c linux-2.6.11.2/arch/i386/pci/common.c
--- linux-2.6.11.2-vanilla/arch/i386/pci/common.c	2005-03-10 16:31:25.000000000 +0800
+++ linux-2.6.11.2/arch/i386/pci/common.c	2005-03-10 16:56:09.000000000 +0800
@@ -25,6 +25,7 @@ unsigned int pci_probe = PCI_PROBE_BIOS 
 
 int pci_routeirq;
 int pcibios_last_bus = -1;
+unsigned int pirq_table_addr = 0;
 struct pci_bus *pci_root_bus = NULL;
 struct pci_raw_ops *raw_pci_ops;
 
@@ -188,6 +189,9 @@ char * __devinit  pcibios_setup(char *st
 	} else if (!strcmp(str, "biosirq")) {
 		pci_probe |= PCI_BIOS_IRQ_SCAN;
 		return NULL;
+	} else if (!strncmp(str, "pirqaddr=", 9)) {
+		pirq_table_addr = simple_strtol(str+9, NULL, 0);
+		return NULL;
 	}
 #endif
 #ifdef CONFIG_PCI_DIRECT
diff -uprN -X dontdiff linux-2.6.11.2-vanilla/arch/i386/pci/irq.c linux-2.6.11.2/arch/i386/pci/irq.c
--- linux-2.6.11.2-vanilla/arch/i386/pci/irq.c	2005-03-10 16:31:25.000000000 +0800
+++ linux-2.6.11.2/arch/i386/pci/irq.c	2005-03-10 20:43:02.479487640 +0800
@@ -58,6 +58,35 @@ struct irq_router_handler {
 int (*pcibios_enable_irq)(struct pci_dev *dev) = NULL;
 
 /*
+ *  Check passed address for the PCI IRQ Routing Table signature 
+ *  and perform checksum verification.
+ */
+
+static inline struct irq_routing_table * __init pirq_check_routing_table(u8 *addr)
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
+	for(i=0; i<rt->size; i++)
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
 
@@ -65,21 +94,16 @@ static struct irq_routing_table * __init
 {
 	u8 *addr;
 	struct irq_routing_table *rt;
-	int i;
-	u8 sum;
 
+	if (pirq_table_addr) {
+		rt = pirq_check_routing_table((u8 *) __va(pirq_table_addr));
+		if (rt) {
+			return rt;
+		}
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
+		if (rt) {
 			return rt;
 		}
 	}
diff -uprN -X dontdiff linux-2.6.11.2-vanilla/arch/i386/pci/pci.h linux-2.6.11.2/arch/i386/pci/pci.h
--- linux-2.6.11.2-vanilla/arch/i386/pci/pci.h	2005-03-10 16:31:25.000000000 +0800
+++ linux-2.6.11.2/arch/i386/pci/pci.h	2005-03-10 16:52:09.000000000 +0800
@@ -27,6 +27,7 @@
 #define PCI_ASSIGN_ALL_BUSSES	0x4000
 
 extern unsigned int pci_probe;
+extern unsigned int pirq_table_addr;
 
 /* pci-i386.c */
 
diff -uprN -X dontdiff linux-2.6.11.2-vanilla/Documentation/kernel-parameters.txt linux-2.6.11.2/Documentation/kernel-parameters.txt
--- linux-2.6.11.2-vanilla/Documentation/kernel-parameters.txt	2005-03-10 16:31:44.000000000 +0800
+++ linux-2.6.11.2/Documentation/kernel-parameters.txt	2005-03-10 16:45:48.000000000 +0800
@@ -967,6 +967,10 @@ running once the system is up.
 		irqmask=0xMMMM		[IA-32] Set a bit mask of IRQs allowed to be assigned
 					automatically to PCI devices. You can make the kernel
 					exclude IRQs of your ISA cards this way.
+		pirqaddr=0xAAAAA	[IA-32] Specify the physical address
+					of the PIRQ table (normally generated
+					by the BIOS) if it is outside the .  
+					F0000h-100000h range.
 		lastbus=N		[IA-32] Scan all buses till bus #N. Can be useful
 					if the kernel is unable to find your secondary buses
 					and you want to tell it explicitly which ones they are.

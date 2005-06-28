Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVF1GZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVF1GZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVF1GYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:24:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:40172 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261944AbVF1Fd4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:56 -0400
Cc: jayalk@intworks.biz
Subject: [PATCH] PCI Allow OutOfRange PIRQ table address
In-Reply-To: <20050628053022.GA1588@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:51 -0700
Message-Id: <11199367711777@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Allow OutOfRange PIRQ table address

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

Signed-off-by: Jaya Kumar <jayalk@intworks.biz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 120bb4246a99cc6e9cc976573fcbcd0ee9d544ef
tree d447957833d89dbd049259f813530fa8cc81d206
parent 020f46a39eb7b99a575b9f4d105fce2b142acdf1
author jayalk@intworks.biz <jayalk@intworks.biz> Mon, 21 Mar 2005 20:20:42 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:38 -0700

 Documentation/kernel-parameters.txt |    4 +++
 arch/i386/pci/common.c              |    6 +++-
 arch/i386/pci/irq.c                 |   51 +++++++++++++++++++++++++----------
 arch/i386/pci/pci.h                 |    1 +
 4 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1030,6 +1030,10 @@ running once the system is up.
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
diff --git a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c
+++ b/arch/i386/pci/common.c
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
diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c
+++ b/arch/i386/pci/irq.c
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
diff --git a/arch/i386/pci/pci.h b/arch/i386/pci/pci.h
--- a/arch/i386/pci/pci.h
+++ b/arch/i386/pci/pci.h
@@ -27,6 +27,7 @@
 #define PCI_ASSIGN_ALL_BUSSES	0x4000
 
 extern unsigned int pci_probe;
+extern unsigned long pirq_table_addr;
 
 /* pci-i386.c */
 


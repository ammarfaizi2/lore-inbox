Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVDTAwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVDTAwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 20:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVDTAwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 20:52:24 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:57566 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261202AbVDTAre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 20:47:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 2/4] ppc64: Split out pSeries specific code from rtas_pci.c
Date: Wed, 20 Apr 2005 02:15:24 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200504200149.22063.arnd@arndb.de>
In-Reply-To: <200504200149.22063.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504200215.25740.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BPA is using rtas for PCI but should not be confused by
pSeries code. This also avoids some #ifdefs. Other
platforms that want to use rtas_pci.c should also create
their own platform_pci.c with platform specific fixups.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--- linux-2.6-ppc.orig/arch/ppc64/kernel/mpic.h	2005-04-01 13:29:21.078978944 -0500
+++ linux-2.6-ppc/arch/ppc64/kernel/mpic.h	2005-04-01 13:30:10.431932216 -0500
@@ -265,3 +265,6 @@ extern void mpic_send_ipi(unsigned int i
 extern int mpic_get_one_irq(struct mpic *mpic, struct pt_regs *regs);
 /* This one gets to the primary mpic */
 extern int mpic_get_irq(struct pt_regs *regs);
+
+/* global mpic for pSeries */
+extern struct mpic *pSeries_mpic;
--- linux-2.6-ppc.orig/arch/ppc64/kernel/pSeries_pci.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-ppc/arch/ppc64/kernel/pSeries_pci.c	2005-04-01 13:29:25.018912520 -0500
@@ -0,0 +1,138 @@
+/*
+ * arch/ppc64/kernel/pSeries_pci.c
+ *
+ * Copyright (C) 2001 Dave Engebretsen, IBM Corporation
+ * Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * pSeries specific routines for PCI.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *    
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+
+#include "pci.h"
+
+static int __initdata s7a_workaround;
+
+#if 0
+void pcibios_name_device(struct pci_dev *dev)
+{
+	struct device_node *dn;
+
+	/*
+	 * Add IBM loc code (slot) as a prefix to the device names for service
+	 */
+	dn = pci_device_to_OF_node(dev);
+	if (dn) {
+		char *loc_code = get_property(dn, "ibm,loc-code", 0);
+		if (loc_code) {
+			int loc_len = strlen(loc_code);
+			if (loc_len < sizeof(dev->dev.name)) {
+				memmove(dev->dev.name+loc_len+1, dev->dev.name,
+					sizeof(dev->dev.name)-loc_len-1);
+				memcpy(dev->dev.name, loc_code, loc_len);
+				dev->dev.name[loc_len] = ' ';
+				dev->dev.name[sizeof(dev->dev.name)-1] = '\0';
+			}
+		}
+	}
+}   
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_name_device);
+#endif
+
+static void __init check_s7a(void)
+{
+	struct device_node *root;
+	char *model;
+
+	root = of_find_node_by_path("/");
+	if (root) {
+		model = get_property(root, "model", NULL);
+		if (model && !strcmp(model, "IBM,7013-S7A"))
+			s7a_workaround = 1;
+		of_node_put(root);
+	}
+}
+
+static void __init pSeries_request_regions(void)
+{
+	if (!isa_io_base)
+		return;
+
+	request_region(0x20,0x20,"pic1");
+	request_region(0xa0,0x20,"pic2");
+	request_region(0x00,0x20,"dma1");
+	request_region(0x40,0x20,"timer");
+	request_region(0x80,0x10,"dma page reg");
+	request_region(0xc0,0x20,"dma2");
+}
+
+void __init pSeries_final_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+
+	check_s7a();
+
+	for_each_pci_dev(dev) {
+		pci_read_irq_line(dev);
+		if (s7a_workaround) {
+			if (dev->irq > 16) {
+				dev->irq -= 3;
+				pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+			}
+		}
+	}
+
+	phbs_remap_io();
+	pSeries_request_regions();
+
+	pci_addr_cache_build();
+}
+
+/*
+ * Assume the winbond 82c105 is the IDE controller on a
+ * p610.  We should probably be more careful in case
+ * someone tries to plug in a similar adapter.
+ */
+static void fixup_winbond_82c105(struct pci_dev* dev)
+{
+	int i;
+	unsigned int reg;
+
+	if (!(systemcfg->platform & PLATFORM_PSERIES))
+		return;
+
+	printk("Using INTC for W82c105 IDE controller.\n");
+	pci_read_config_dword(dev, 0x40, &reg);
+	/* Enable LEGIRQ to use INTC instead of ISA interrupts */
+	pci_write_config_dword(dev, 0x40, reg | (1<<11));
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; ++i) {
+		/* zap the 2nd function of the winbond chip */
+		if (dev->resource[i].flags & IORESOURCE_IO
+		    && dev->bus->number == 0 && dev->devfn == 0x81)
+			dev->resource[i].flags &= ~IORESOURCE_IO;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
+			 fixup_winbond_82c105);
--- linux-2.6-ppc.orig/arch/ppc64/kernel/rtas_pci.c	2005-04-01 13:28:56.169905768 -0500
+++ linux-2.6-ppc/arch/ppc64/kernel/rtas_pci.c	2005-04-01 13:29:25.019912368 -0500
@@ -1,12 +1,12 @@
 /*
- * pSeries_pci.c
+ * arch/ppc64/kernel/rtas_pci.c
  *
  * Copyright (C) 2001 Dave Engebretsen, IBM Corporation
  * Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
  *
- * pSeries specific routines for PCI.
+ * RTAS specific routines for PCI.
  * 
- * Based on code from pci.c and chrp_pci.c
+ * Based on code from pci.c, chrp_pci.c and pSeries_pci.c
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -48,10 +48,6 @@ static int write_pci_config;
 static int ibm_read_pci_config;
 static int ibm_write_pci_config;
 
-static int s7a_workaround;
-
-extern struct mpic *pSeries_mpic;
-
 static int config_access_valid(struct device_node *dn, int where)
 {
 	if (where < 256)
@@ -385,12 +381,12 @@ unsigned long __init find_and_init_phbs(
 
 		pci_process_bridge_OF_ranges(phb, node);
 		pci_setup_phb_io(phb, index == 0);
-
+#ifdef CONFIG_PPC_PSERIES
 		if (ppc64_interrupt_controller == IC_OPEN_PIC && pSeries_mpic) {
 			int addr = root_size_cells * (index + 2) - 1;
 			mpic_assign_isu(pSeries_mpic, index, opprop[addr]);
 		}
-
+#endif
 		index++;
 	}
 
@@ -448,46 +444,6 @@ struct pci_controller * __devinit init_p
 }
 EXPORT_SYMBOL(init_phb_dynamic);
 
-#if 0
-void pcibios_name_device(struct pci_dev *dev)
-{
-	struct device_node *dn;
-
-	/*
-	 * Add IBM loc code (slot) as a prefix to the device names for service
-	 */
-	dn = pci_device_to_OF_node(dev);
-	if (dn) {
-		char *loc_code = get_property(dn, "ibm,loc-code", 0);
-		if (loc_code) {
-			int loc_len = strlen(loc_code);
-			if (loc_len < sizeof(dev->dev.name)) {
-				memmove(dev->dev.name+loc_len+1, dev->dev.name,
-					sizeof(dev->dev.name)-loc_len-1);
-				memcpy(dev->dev.name, loc_code, loc_len);
-				dev->dev.name[loc_len] = ' ';
-				dev->dev.name[sizeof(dev->dev.name)-1] = '\0';
-			}
-		}
-	}
-}   
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_name_device);
-#endif
-
-static void check_s7a(void)
-{
-	struct device_node *root;
-	char *model;
-
-	root = of_find_node_by_path("/");
-	if (root) {
-		model = get_property(root, "model", NULL);
-		if (model && !strcmp(model, "IBM,7013-S7A"))
-			s7a_workaround = 1;
-		of_node_put(root);
-	}
-}
-
 /* RPA-specific bits for removing PHBs */
 int pcibios_remove_root_bus(struct pci_controller *phb)
 {
@@ -537,66 +493,3 @@ int pcibios_remove_root_bus(struct pci_c
 	return 0;
 }
 EXPORT_SYMBOL(pcibios_remove_root_bus);
-
-static void __init pSeries_request_regions(void)
-{
-	if (!isa_io_base)
-		return;
-
-	request_region(0x20,0x20,"pic1");
-	request_region(0xa0,0x20,"pic2");
-	request_region(0x00,0x20,"dma1");
-	request_region(0x40,0x20,"timer");
-	request_region(0x80,0x10,"dma page reg");
-	request_region(0xc0,0x20,"dma2");
-}
-
-void __init pSeries_final_fixup(void)
-{
-	struct pci_dev *dev = NULL;
-
-	check_s7a();
-
-	for_each_pci_dev(dev) {
-		pci_read_irq_line(dev);
-		if (s7a_workaround) {
-			if (dev->irq > 16) {
-				dev->irq -= 3;
-				pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
-			}
-		}
-	}
-
-	phbs_remap_io();
-	pSeries_request_regions();
-
-	pci_addr_cache_build();
-}
-
-/*
- * Assume the winbond 82c105 is the IDE controller on a
- * p610.  We should probably be more careful in case
- * someone tries to plug in a similar adapter.
- */
-static void fixup_winbond_82c105(struct pci_dev* dev)
-{
-	int i;
-	unsigned int reg;
-
-	if (!(systemcfg->platform & PLATFORM_PSERIES))
-		return;
-
-	printk("Using INTC for W82c105 IDE controller.\n");
-	pci_read_config_dword(dev, 0x40, &reg);
-	/* Enable LEGIRQ to use INTC instead of ISA interrupts */
-	pci_write_config_dword(dev, 0x40, reg | (1<<11));
-
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; ++i) {
-		/* zap the 2nd function of the winbond chip */
-		if (dev->resource[i].flags & IORESOURCE_IO
-		    && dev->bus->number == 0 && dev->devfn == 0x81)
-			dev->resource[i].flags &= ~IORESOURCE_IO;
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
-			 fixup_winbond_82c105);


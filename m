Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275357AbSIUA5L>; Fri, 20 Sep 2002 20:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275381AbSIUA5L>; Fri, 20 Sep 2002 20:57:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:2538 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S275357AbSIUA5C>;
	Fri, 20 Sep 2002 20:57:02 -0400
Message-ID: <3D8BC463.9000707@us.ibm.com>
Date: Fri, 20 Sep 2002 17:59:15 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: [patch] rename arch/i386/pci/numa.c
Content-Type: multipart/mixed;
 boundary="------------050307040105050104030801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050307040105050104030801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	This file is NUMA-Q specific...  This patch renames the file to a more 
appropriate numaq.c, and also fixes the filenames one occurence 
(arch/i386/pci/Makefile).

Please apply.

Cheers!

-Matt

--------------050307040105050104030801
Content-Type: text/plain;
 name="pci_numa_rename-2.5.37.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_numa_rename-2.5.37.patch"

diff -Nur linux-2.5.37-vanilla/arch/i386/pci/Makefile linux-2.5.37-multiquad/arch/i386/pci/Makefile
--- linux-2.5.37-vanilla/arch/i386/pci/Makefile	Fri Sep 20 08:20:30 2002
+++ linux-2.5.37-multiquad/arch/i386/pci/Makefile	Fri Sep 20 13:50:22 2002
@@ -3,8 +3,8 @@
 obj-$(CONFIG_PCI_BIOS)		+= pcbios.o
 obj-$(CONFIG_PCI_DIRECT)	+= direct.o
 
-ifdef	CONFIG_MULTIQUAD
-obj-y		+= numa.o
+ifdef	CONFIG_X86_NUMAQ
+obj-y		+= numaq.o
 else
 obj-y		+= fixup.o
 
@@ -14,7 +14,7 @@
 obj-y		+= legacy.o
 
 
-endif		# CONFIG_MULTIQUAD
+endif		# CONFIG_X86_NUMAQ
 obj-y		+= irq.o common.o
 
 include $(TOPDIR)/Rules.make
diff -Nur linux-2.5.37-vanilla/arch/i386/pci/numa.c linux-2.5.37-multiquad/arch/i386/pci/numa.c
--- linux-2.5.37-vanilla/arch/i386/pci/numa.c	Fri Sep 20 08:20:19 2002
+++ linux-2.5.37-multiquad/arch/i386/pci/numa.c	Wed Dec 31 16:00:00 1969
@@ -1,141 +0,0 @@
-/*
- * numa.c - Low-level PCI access for NUMA-Q machines
- */
-
-#include <linux/pci.h>
-#include <linux/init.h>
-#include "pci.h"
-
-#define BUS2QUAD(global) (mp_bus_id_to_node[global])
-#define BUS2LOCAL(global) (mp_bus_id_to_local[global])
-#define QUADLOCAL2BUS(quad,local) (quad_local_to_mp_bus_id[quad][local])
-
-#define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
-	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
-
-static int __pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
-{
-	unsigned long flags;
-
-	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
-		return -EINVAL;
-
-	spin_lock_irqsave(&pci_config_lock, flags);
-
-	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
-
-	switch (len) {
-	case 1:
-		*value = inb_quad(0xCFC + (reg & 3), BUS2QUAD(bus));
-		break;
-	case 2:
-		*value = inw_quad(0xCFC + (reg & 2), BUS2QUAD(bus));
-		break;
-	case 4:
-		*value = inl_quad(0xCFC, BUS2QUAD(bus));
-		break;
-	}
-
-	spin_unlock_irqrestore(&pci_config_lock, flags);
-
-	return 0;
-}
-
-static int __pci_conf1_mq_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
-{
-	unsigned long flags;
-
-	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
-		return -EINVAL;
-
-	spin_lock_irqsave(&pci_config_lock, flags);
-
-	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
-
-	switch (len) {
-	case 1:
-		outb_quad((u8)value, 0xCFC + (reg & 3), BUS2QUAD(bus));
-		break;
-	case 2:
-		outw_quad((u16)value, 0xCFC + (reg & 2), BUS2QUAD(bus));
-		break;
-	case 4:
-		outl_quad((u32)value, 0xCFC, BUS2QUAD(bus));
-		break;
-	}
-
-	spin_unlock_irqrestore(&pci_config_lock, flags);
-
-	return 0;
-}
-
-#undef PCI_CONF1_MQ_ADDRESS
-
-static int pci_conf1_mq_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
-{
-	return __pci_conf1_mq_read(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
-}
-
-static int pci_conf1_mq_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
-{
-	return __pci_conf1_mq_write(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
-}
-
-static struct pci_ops pci_direct_conf1_mq = {
-	read:	pci_conf1_mq_read,
-	write:	pci_conf1_mq_write
-};
-
-
-static void __devinit pci_fixup_i450nx(struct pci_dev *d)
-{
-	/*
-	 * i450NX -- Find and scan all secondary buses on all PXB's.
-	 */
-	int pxb, reg;
-	u8 busno, suba, subb;
-	int quad = BUS2QUAD(d->bus->number);
-
-	printk("PCI: Searching for i450NX host bridges on %s\n", d->slot_name);
-	reg = 0xd0;
-	for(pxb=0; pxb<2; pxb++) {
-		pci_read_config_byte(d, reg++, &busno);
-		pci_read_config_byte(d, reg++, &suba);
-		pci_read_config_byte(d, reg++, &subb);
-		DBG("i450NX PXB %d: %02x/%02x/%02x\n", pxb, busno, suba, subb);
-		if (busno)
-			pci_scan_bus(QUADLOCAL2BUS(quad,busno), pci_root_ops, NULL);	/* Bus A */
-		if (suba < subb)
-			pci_scan_bus(QUADLOCAL2BUS(quad,suba+1), pci_root_ops, NULL);	/* Bus B */
-	}
-	pcibios_last_bus = -1;
-}
-
-struct pci_fixup pcibios_fixups[] = {
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci_fixup_i450nx },
-};
-
-static int __init pci_numa_init(void)
-{
-	int quad;
-
-	pci_root_ops = &pci_direct_conf1_mq;
-
-	if (pcibios_scanned++)
-		return 0;
-
-	pci_root_bus = pcibios_scan_root(0);
-	if (clustered_apic_mode && (numnodes > 1)) {
-		for (quad = 1; quad < numnodes; ++quad) {
-			printk("Scanning PCI bus %d for quad %d\n", 
-				QUADLOCAL2BUS(quad,0), quad);
-			pci_scan_bus(QUADLOCAL2BUS(quad,0), 
-				pci_root_ops, NULL);
-		}
-	}
-	return 0;
-}
-
-subsys_initcall(pci_numa_init);
diff -Nur linux-2.5.37-vanilla/arch/i386/pci/numaq.c linux-2.5.37-multiquad/arch/i386/pci/numaq.c
--- linux-2.5.37-vanilla/arch/i386/pci/numaq.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.37-multiquad/arch/i386/pci/numaq.c	Fri Sep 20 13:28:30 2002
@@ -0,0 +1,141 @@
+/*
+ * numa.c - Low-level PCI access for NUMA-Q machines
+ */
+
+#include <linux/pci.h>
+#include <linux/init.h>
+#include "pci.h"
+
+#define BUS2QUAD(global) (mp_bus_id_to_node[global])
+#define BUS2LOCAL(global) (mp_bus_id_to_local[global])
+#define QUADLOCAL2BUS(quad,local) (quad_local_to_mp_bus_id[quad][local])
+
+#define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
+	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
+
+static int __pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+{
+	unsigned long flags;
+
+	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+		return -EINVAL;
+
+	spin_lock_irqsave(&pci_config_lock, flags);
+
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+
+	switch (len) {
+	case 1:
+		*value = inb_quad(0xCFC + (reg & 3), BUS2QUAD(bus));
+		break;
+	case 2:
+		*value = inw_quad(0xCFC + (reg & 2), BUS2QUAD(bus));
+		break;
+	case 4:
+		*value = inl_quad(0xCFC, BUS2QUAD(bus));
+		break;
+	}
+
+	spin_unlock_irqrestore(&pci_config_lock, flags);
+
+	return 0;
+}
+
+static int __pci_conf1_mq_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+{
+	unsigned long flags;
+
+	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
+		return -EINVAL;
+
+	spin_lock_irqsave(&pci_config_lock, flags);
+
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+
+	switch (len) {
+	case 1:
+		outb_quad((u8)value, 0xCFC + (reg & 3), BUS2QUAD(bus));
+		break;
+	case 2:
+		outw_quad((u16)value, 0xCFC + (reg & 2), BUS2QUAD(bus));
+		break;
+	case 4:
+		outl_quad((u32)value, 0xCFC, BUS2QUAD(bus));
+		break;
+	}
+
+	spin_unlock_irqrestore(&pci_config_lock, flags);
+
+	return 0;
+}
+
+#undef PCI_CONF1_MQ_ADDRESS
+
+static int pci_conf1_mq_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
+{
+	return __pci_conf1_mq_read(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
+}
+
+static int pci_conf1_mq_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
+{
+	return __pci_conf1_mq_write(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
+}
+
+static struct pci_ops pci_direct_conf1_mq = {
+	read:	pci_conf1_mq_read,
+	write:	pci_conf1_mq_write
+};
+
+
+static void __devinit pci_fixup_i450nx(struct pci_dev *d)
+{
+	/*
+	 * i450NX -- Find and scan all secondary buses on all PXB's.
+	 */
+	int pxb, reg;
+	u8 busno, suba, subb;
+	int quad = BUS2QUAD(d->bus->number);
+
+	printk("PCI: Searching for i450NX host bridges on %s\n", d->slot_name);
+	reg = 0xd0;
+	for(pxb=0; pxb<2; pxb++) {
+		pci_read_config_byte(d, reg++, &busno);
+		pci_read_config_byte(d, reg++, &suba);
+		pci_read_config_byte(d, reg++, &subb);
+		DBG("i450NX PXB %d: %02x/%02x/%02x\n", pxb, busno, suba, subb);
+		if (busno)
+			pci_scan_bus(QUADLOCAL2BUS(quad,busno), pci_root_ops, NULL);	/* Bus A */
+		if (suba < subb)
+			pci_scan_bus(QUADLOCAL2BUS(quad,suba+1), pci_root_ops, NULL);	/* Bus B */
+	}
+	pcibios_last_bus = -1;
+}
+
+struct pci_fixup pcibios_fixups[] = {
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci_fixup_i450nx },
+};
+
+static int __init pci_numa_init(void)
+{
+	int quad;
+
+	pci_root_ops = &pci_direct_conf1_mq;
+
+	if (pcibios_scanned++)
+		return 0;
+
+	pci_root_bus = pcibios_scan_root(0);
+	if (clustered_apic_mode && (numnodes > 1)) {
+		for (quad = 1; quad < numnodes; ++quad) {
+			printk("Scanning PCI bus %d for quad %d\n", 
+				QUADLOCAL2BUS(quad,0), quad);
+			pci_scan_bus(QUADLOCAL2BUS(quad,0), 
+				pci_root_ops, NULL);
+		}
+	}
+	return 0;
+}
+
+subsys_initcall(pci_numa_init);

--------------050307040105050104030801--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268416AbTBNNF1>; Fri, 14 Feb 2003 08:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268409AbTBNNFC>; Fri, 14 Feb 2003 08:05:02 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:25358 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268416AbTBNMxL>;
	Fri, 14 Feb 2003 07:53:11 -0500
Date: Fri, 14 Feb 2003 15:58:24 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: pci support (8/13)
Message-ID: <20030214125824.GH8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FUFe+yI/t+r3nyH4"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FUFe+yI/t+r3nyH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

This patch contains update of pci support for visws.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--FUFe+yI/t+r3nyH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-pci

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/include/linux/pci_ids.h linux-2.5.60/include/linux/pci_ids.h
--- linux-2.5.60.vanilla/include/linux/pci_ids.h	Thu Feb 13 20:31:18 2003
+++ linux-2.5.60/include/linux/pci_ids.h	Thu Feb 13 20:42:02 2003
@@ -848,6 +848,7 @@
 
 #define PCI_VENDOR_ID_SGI		0x10a9
 #define PCI_DEVICE_ID_SGI_IOC3		0x0003
+#define PCI_VENDOR_ID_SGI_LITHIUM	0x1002
 
 #define PCI_VENDOR_ID_ACC		0x10aa
 #define PCI_DEVICE_ID_ACC_2056		0x0000
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/mach-visws/pci-visws.c linux-2.5.60/arch/i386/mach-visws/pci-visws.c
--- linux-2.5.60.vanilla/arch/i386/mach-visws/pci-visws.c	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/mach-visws/pci-visws.c	Thu Jan  1 03:00:00 1970
@@ -1,141 +0,0 @@
-/*
- *	Low-Level PCI Support for SGI Visual Workstation
- *
- *	(c) 1999--2000 Martin Mares <mj@ucw.cz>
- */
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-
-#include <asm/smp.h>
-#include <asm/lithium.h>
-#include <asm/io.h>
-
-#include "pci-i386.h"
-
-unsigned int pci_probe = 0;
-
-/*
- *  The VISWS uses configuration access type 1 only.
- */
-
-#define CONFIG_CMD(dev, where)   (0x80000000 | (dev->bus->number << 16) | (dev->devfn << 8) | (where & ~3))
-
-static int pci_conf1_read_config_byte(struct pci_dev *dev, int where, u8 *value)
-{
-	outl(CONFIG_CMD(dev,where), 0xCF8);
-	*value = inb(0xCFC + (where&3));
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int pci_conf1_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	outl(CONFIG_CMD(dev,where), 0xCF8);    
-	*value = inw(0xCFC + (where&2));
-	return PCIBIOS_SUCCESSFUL;    
-}
-
-static int pci_conf1_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	outl(CONFIG_CMD(dev,where), 0xCF8);
-	*value = inl(0xCFC);
-	return PCIBIOS_SUCCESSFUL;    
-}
-
-static int pci_conf1_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	outl(CONFIG_CMD(dev,where), 0xCF8);    
-	outb(value, 0xCFC + (where&3));
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int pci_conf1_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	outl(CONFIG_CMD(dev,where), 0xCF8);
-	outw(value, 0xCFC + (where&2));
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int pci_conf1_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	outl(CONFIG_CMD(dev,where), 0xCF8);
-	outl(value, 0xCFC);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-#undef CONFIG_CMD
-
-static struct pci_ops visws_pci_ops = {
-	pci_conf1_read_config_byte,
-	pci_conf1_read_config_word,
-	pci_conf1_read_config_dword,
-	pci_conf1_write_config_byte,
-	pci_conf1_write_config_word,
-	pci_conf1_write_config_dword
-};
-
-static void __init pcibios_fixup_irqs(void)
-{
-	struct pci_dev *dev, *p;
-	u8 pin;
-	int irq;
-
-	pci_for_each_dev(dev) {
-		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-		dev->irq = 0;
-		if (!pin)
-			continue;
-		pin--;
-		if (dev->bus->parent) {
-			p = dev->bus->parent->self;
-			pin = (pin + PCI_SLOT(dev->devfn)) % 4;
-		} else
-			p = dev;
-		irq = visws_get_PCI_irq_vector(p->bus->number, PCI_SLOT(p->devfn), pin+1);
-		if (irq >= 0)
-			dev->irq = irq;
-		DBG("PCI IRQ: %s pin %d -> %d\n", dev->slot_name, pin, irq);
-	}
-}
-
-void __init pcibios_fixup_bus(struct pci_bus *b)
-{
-	pci_read_bridge_bases(b);
-}
-
-#if 0
-static struct resource visws_pci_bus_resources[2] = {
-	{ "Host bus 1", 0xf4000000, 0xf7ffffff, 0 },
-	{ "Host bus 2", 0xf0000000, 0xf3ffffff, 0 }
-};
-#endif
-
-void __init pcibios_init(void)
-{
-	unsigned int sec_bus = li_pcib_read16(LI_PCI_BUSNUM) & 0xff;
-
-	printk("PCI: Probing PCI hardware on host buses 00 and %02x\n", sec_bus);
-	pci_scan_bus(0, &visws_pci_ops, NULL);
-	pci_scan_bus(sec_bus, &visws_pci_ops, NULL);
-	pcibios_fixup_irqs();
-	pcibios_resource_survey();
-}
-
-char * __init pcibios_setup(char *str)
-{
-	return str;
-}
-
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	return pcibios_enable_resources(dev, mask);
-}
-
-void __init pcibios_penalize_isa_irq(irq)
-{
-}
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/pci/Makefile linux-2.5.60/arch/i386/pci/Makefile
--- linux-2.5.60.vanilla/arch/i386/pci/Makefile	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/pci/Makefile	Thu Feb 13 20:42:02 2003
@@ -3,6 +3,8 @@
 obj-$(CONFIG_PCI_BIOS)		+= pcbios.o
 obj-$(CONFIG_PCI_DIRECT)	+= direct.o
 
+obj-$(CONFIG_X86_VISWS)		+= visws.o
+
 ifdef	CONFIG_X86_NUMAQ
 obj-y		+= numa.o
 else
@@ -11,8 +13,15 @@
 ifdef	CONFIG_ACPI_PCI
 obj-y		+= acpi.o
 endif
-obj-y		+= legacy.o
 
+ifndef	CONFIG_X86_VISWS
+obj-y		+= legacy.o
+endif
 
 endif		# CONFIG_X86_NUMAQ
-obj-y		+= irq.o common.o
+
+ifndef	CONFIG_X86_VISWS
+obj-y		+= irq.o
+endif
+
+obj-y		+= common.o
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/pci/common.c linux-2.5.60/arch/i386/pci/common.c
--- linux-2.5.60.vanilla/arch/i386/pci/common.c	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/pci/common.c	Thu Feb 13 20:42:02 2003
@@ -180,13 +180,8 @@
 		return NULL;
 	}
 #endif
-	else if (!strcmp(str, "rom")) {
-		pci_probe |= PCI_ASSIGN_ROMS;
-		return NULL;
-	} else if (!strcmp(str, "assign-busses")) {
-		pci_probe |= PCI_ASSIGN_ALL_BUSSES;
-		return NULL;
-	} else if (!strcmp(str, "usepirqmask")) {
+#ifndef CONFIG_X86_VISWS
+	else if (!strcmp(str, "usepirqmask")) {
 		pci_probe |= PCI_USE_PIRQ_MASK;
 		return NULL;
 	} else if (!strncmp(str, "irqmask=", 8)) {
@@ -194,6 +189,14 @@
 		return NULL;
 	} else if (!strncmp(str, "lastbus=", 8)) {
 		pcibios_last_bus = simple_strtol(str+8, NULL, 0);
+		return NULL;
+	}
+#endif
+	else if (!strcmp(str, "rom")) {
+		pci_probe |= PCI_ASSIGN_ROMS;
+		return NULL;
+	} else if (!strcmp(str, "assign-busses")) {
+		pci_probe |= PCI_ASSIGN_ALL_BUSSES;
 		return NULL;
 	}
 	return str;
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/pci/direct.c linux-2.5.60/arch/i386/pci/direct.c
--- linux-2.5.60.vanilla/arch/i386/pci/direct.c	Thu Feb 13 20:29:07 2003
+++ linux-2.5.60/arch/i386/pci/direct.c	Thu Feb 13 20:42:02 2003
@@ -83,7 +83,7 @@
 		PCI_FUNC(devfn), where, size, value);
 }
 
-static struct pci_ops pci_direct_conf1 = {
+struct pci_ops pci_direct_conf1 = {
 	.read =		pci_conf1_read,
 	.write =	pci_conf1_write,
 };
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/arch/i386/pci/visws.c linux-2.5.60/arch/i386/pci/visws.c
--- linux-2.5.60.vanilla/arch/i386/pci/visws.c	Thu Jan  1 03:00:00 1970
+++ linux-2.5.60/arch/i386/pci/visws.c	Thu Feb 13 20:42:02 2003
@@ -0,0 +1,110 @@
+/*
+ *	Low-Level PCI Support for SGI Visual Workstation
+ *
+ *	(c) 1999--2000 Martin Mares <mj@ucw.cz>
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
+#include "cobalt.h"
+#include "lithium.h"
+
+#include "pci.h"
+
+
+int broken_hp_bios_irq9;
+
+extern struct pci_ops pci_direct_conf1;
+
+static int pci_visws_enable_irq(struct pci_dev *dev) { return 0; }
+
+int (*pcibios_enable_irq)(struct pci_dev *dev) = &pci_visws_enable_irq;
+
+void __init pcibios_penalize_isa_irq(int irq) {}
+
+
+unsigned int pci_bus0, pci_bus1;
+
+static inline u8 bridge_swizzle(u8 pin, u8 slot) 
+{
+	return (((pin - 1) + slot) % 4) + 1;
+}
+
+static u8 __init visws_swizzle(struct pci_dev *dev, u8 *pinp)
+{
+	u8 pin = *pinp;
+
+	while (dev->bus->self) {	/* Move up the chain of bridges. */
+		pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn));
+		dev = dev->bus->self;
+	}
+	*pinp = pin;
+
+	return PCI_SLOT(dev->devfn);
+}
+
+static int __init visws_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int irq, bus = dev->bus->number;
+
+	pin--;
+
+	/* Nothing usefull at PIIX4 pin 1 */
+	if (bus == pci_bus0 && slot == 4 && pin == 0)
+		return -1;
+
+	/* PIIX4 USB is on Bus 0, Slot 4, Line 3 */
+	if (bus == pci_bus0 && slot == 4 && pin == 3) {
+		irq = CO_IRQ(CO_APIC_PIIX4_USB);
+		goto out;
+	}
+
+	/* First pin spread down 1 APIC entry per slot */
+	if (pin == 0) {
+		irq = CO_IRQ((bus == pci_bus0 ? CO_APIC_PCIB_BASE0 :
+						CO_APIC_PCIA_BASE0) + slot);
+		goto out;
+	}
+
+	/* lines 1,2,3 from any slot is shared in this twirly pattern */
+	if (bus == pci_bus1) {
+		/* lines 1-3 from devices 0 1 rotate over 2 apic entries */
+		irq = CO_IRQ(CO_APIC_PCIA_BASE123 + ((slot + (pin - 1)) % 2));
+	} else { /* bus == pci_bus0 */
+		/* lines 1-3 from devices 0-3 rotate over 3 apic entries */
+		if (slot == 0)
+			slot = 3; /* same pattern */
+		irq = CO_IRQ(CO_APIC_PCIA_BASE123 + ((3 - slot) + (pin - 1) % 3));
+	}
+out:
+	printk(KERN_DEBUG "PCI: Bus %d Slot %d Line %d -> IRQ %d\n", bus, slot, pin, irq);
+	return irq;
+}
+
+void __init pcibios_update_irq(struct pci_dev *dev, int irq)
+{
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
+}
+
+static int __init pcibios_init(void)
+{
+	/* The VISWS supports configuration access type 1 only */
+	pci_probe = (pci_probe | PCI_PROBE_CONF1) &
+		    ~(PCI_PROBE_BIOS | PCI_PROBE_CONF2);
+
+	pci_bus0 = li_pcib_read16(LI_PCI_BUSNUM) & 0xff;
+	pci_bus1 = li_pcia_read16(LI_PCI_BUSNUM) & 0xff;
+
+	printk(KERN_INFO "PCI: Lithium bridge A bus: %u, "
+		"bridge B (PIIX4) bus: %u\n", pci_bus1, pci_bus0);
+
+	pci_scan_bus(pci_bus0, &pci_direct_conf1, NULL);
+	pci_scan_bus(pci_bus1, &pci_direct_conf1, NULL);
+	pci_fixup_irqs(visws_swizzle, visws_map_irq);
+	pcibios_resource_survey();
+}
+
+subsys_initcall(pcibios_init);
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/drivers/pci/Makefile linux-2.5.60/drivers/pci/Makefile
--- linux-2.5.60.vanilla/drivers/pci/Makefile	Thu Feb 13 20:30:57 2003
+++ linux-2.5.60/drivers/pci/Makefile	Thu Feb 13 20:42:02 2003
@@ -22,6 +22,7 @@
 obj-$(CONFIG_PPC32) += setup-irq.o
 obj-$(CONFIG_DDB5476) += setup-bus.o
 obj-$(CONFIG_SGI_IP27) += setup-irq.o
+obj-$(CONFIG_X86_VISWS) += setup-irq.o
 
 # CompactPCI hotplug requires the pbus_* functions
 ifdef CONFIG_HOTPLUG_PCI_CPCI

--FUFe+yI/t+r3nyH4--

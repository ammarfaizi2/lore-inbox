Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261743AbTCLPtK>; Wed, 12 Mar 2003 10:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbTCLPtK>; Wed, 12 Mar 2003 10:49:10 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:37390 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261743AbTCLPtA>; Wed, 12 Mar 2003 10:49:00 -0500
Date: Wed, 12 Mar 2003 18:59:01 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5] PCI: remove redundant arg 2 to pcibios_update_resource()
Message-ID: <20030312185901.A31492@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of this function is pci_assign_resource():
		/* Update PCI config space.  */
		pcibios_update_resource(dev, res->parent, res, resno);

Most architectures do not use 2nd argument at all, as it's completely
useless. Exceptions are
ia64: pci/pci.c;
mips64: mips-boards/generic/pci.c, sgi-ip27/sgi-ip27.c;
mips: ite-boards/generic/it8172_pci.c, mips-boards/generic/pci.c.

All these use exactly the same code which obviously doesn't work
for bridged buses. Anyway, I preserved current [broken] behavior on
these platforms by replacing "root" with "res->parent" and added
FIXMEs there.

Also fixes debugging printk in pci_assign_resource().

Ivan.

diff -urpN 2.5/arch/alpha/kernel/pci.c linux/arch/alpha/kernel/pci.c
--- 2.5/arch/alpha/kernel/pci.c	Wed Mar 12 13:33:31 2003
+++ linux/arch/alpha/kernel/pci.c	Wed Mar 12 15:08:23 2003
@@ -265,8 +265,8 @@ pcibios_fixup_bus(struct pci_bus *bus)
 }
 
 void
-pcibios_update_resource(struct pci_dev *dev, struct resource *parent,
-			struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	struct pci_controller *hose = dev->sysdata;
 	struct resource *root;
diff -urpN 2.5/arch/arm/kernel/bios32.c linux/arch/arm/kernel/bios32.c
--- 2.5/arch/arm/kernel/bios32.c	Wed Mar 12 13:33:31 2003
+++ linux/arch/arm/kernel/bios32.c	Wed Mar 12 14:52:02 2003
@@ -260,8 +260,8 @@ struct pci_fixup pcibios_fixups[] = {
 };
 
 void __devinit
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-			struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	struct pci_sys_data *sys = dev->sysdata;
 	u32 val, check;
diff -urpN 2.5/arch/i386/pci/i386.c linux/arch/i386/pci/i386.c
--- 2.5/arch/i386/pci/i386.c	Wed Mar  5 06:29:03 2003
+++ linux/arch/i386/pci/i386.c	Wed Mar 12 15:09:07 2003
@@ -34,8 +34,8 @@
 #include "pci.h"
 
 void
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-			struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	u32 new, check;
 	int reg;
diff -urpN 2.5/arch/ia64/pci/pci.c linux/arch/ia64/pci/pci.c
--- 2.5/arch/ia64/pci/pci.c	Wed Mar 12 13:33:34 2003
+++ linux/arch/ia64/pci/pci.c	Wed Mar 12 14:54:15 2003
@@ -144,8 +144,8 @@ pcibios_fixup_bus (struct pci_bus *b)
 }
 
 void __devinit
-pcibios_update_resource (struct pci_dev *dev, struct resource *root,
-			 struct resource *res, int resource)
+pcibios_update_resource (struct pci_dev *dev, struct resource *res,
+			 int resource)
 {
 	unsigned long where, size;
 	u32 reg;
@@ -153,7 +153,8 @@ pcibios_update_resource (struct pci_dev 
 	where = PCI_BASE_ADDRESS_0 + (resource * 4);
 	size = res->end - res->start;
 	pci_read_config_dword(dev, where, &reg);
-	reg = (reg & size) | (((u32)(res->start - root->start)) & ~size);
+	/* FIXME - this doesn't work for PCI-PCI bridges. */
+	reg = (reg & size) | (((u32)(res->start - res->parent->start)) & ~size);
 	pci_write_config_dword(dev, where, reg);
 
 	/* ??? FIXME -- record old value for shutdown.  */
diff -urpN 2.5/arch/m68knommu/kernel/comempci.c linux/arch/m68knommu/kernel/comempci.c
--- 2.5/arch/m68knommu/kernel/comempci.c	Wed Mar 12 13:33:35 2003
+++ linux/arch/m68knommu/kernel/comempci.c	Wed Mar 12 15:09:33 2003
@@ -377,7 +377,7 @@ int pcibios_enable_device(struct pci_dev
 
 /*****************************************************************************/
 
-void pcibios_update_resource(struct pci_dev *dev, struct resource *root, struct resource *r, int resource)
+void pcibios_update_resource(struct pci_dev *dev, struct resource *r, int resource)
 {
 	printk("%s(%d): no support for changing PCI resources...\n",
 		__FILE__, __LINE__);
diff -urpN 2.5/arch/mips/ddb5074/pci.c linux/arch/mips/ddb5074/pci.c
--- 2.5/arch/mips/ddb5074/pci.c	Wed Mar  5 06:29:18 2003
+++ linux/arch/mips/ddb5074/pci.c	Wed Mar 12 15:00:43 2003
@@ -341,8 +341,8 @@ int pcibios_enable_device(struct pci_dev
 	return pcibios_enable_resources(dev);
 }
 
-void pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-			     struct resource *res, int resource)
+void pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			     int resource)
 {
 	u32 new, check;
 	int reg;
diff -urpN 2.5/arch/mips/ddb5476/pci.c linux/arch/mips/ddb5476/pci.c
--- 2.5/arch/mips/ddb5476/pci.c	Wed Mar  5 06:29:16 2003
+++ linux/arch/mips/ddb5476/pci.c	Wed Mar 12 14:58:19 2003
@@ -399,8 +399,8 @@ int pcibios_enable_device(struct pci_dev
 	return pcibios_enable_resources(dev);
 }
 
-void pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-			     struct resource *res, int resource)
+void pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			     int resource)
 {
 	u32 new, check;
 	int reg;
diff -urpN 2.5/arch/mips/ddb5xxx/common/pci.c linux/arch/mips/ddb5xxx/common/pci.c
--- 2.5/arch/mips/ddb5xxx/common/pci.c	Wed Mar  5 06:29:54 2003
+++ linux/arch/mips/ddb5xxx/common/pci.c	Wed Mar 12 14:59:58 2003
@@ -172,8 +172,8 @@ pcibios_align_resource(void *data, struc
 }
 
 void
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-                             struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	/* this should not be called */
 	MIPS_ASSERT(1 == 0);
diff -urpN 2.5/arch/mips/gt64120/common/pci.c linux/arch/mips/gt64120/common/pci.c
--- 2.5/arch/mips/gt64120/common/pci.c	Wed Mar  5 06:29:18 2003
+++ linux/arch/mips/gt64120/common/pci.c	Wed Mar 12 15:03:12 2003
@@ -785,8 +785,8 @@ int pcibios_enable_device(struct pci_dev
 	return pcibios_enable_resources(dev);
 }
 
-void pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-			     struct resource *res, int resource)
+void pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			     int resource)
 {
 	u32 new, check;
 	int reg;
diff -urpN 2.5/arch/mips/ite-boards/generic/it8172_pci.c linux/arch/mips/ite-boards/generic/it8172_pci.c
--- 2.5/arch/mips/ite-boards/generic/it8172_pci.c	Wed Mar  5 06:29:31 2003
+++ linux/arch/mips/ite-boards/generic/it8172_pci.c	Wed Mar 12 15:15:04 2003
@@ -197,8 +197,8 @@ pcibios_setup(char *str)
 }
 
 void __init
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-                        struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	unsigned long where, size;
 	u32 reg;
@@ -206,7 +206,8 @@ pcibios_update_resource(struct pci_dev *
 	where = PCI_BASE_ADDRESS_0 + (resource * 4);
 	size = res->end - res->start;
 	pci_read_config_dword(dev, where, &reg);
-	reg = (reg & size) | (((u32)(res->start - root->start)) & ~size);
+	/* FIXME - this doesn't work for PCI-PCI bridges. */
+	reg = (reg & size) | (((u32)(res->start - res->parent->start)) & ~size);
 	pci_write_config_dword(dev, where, reg);
 }
 
diff -urpN 2.5/arch/mips/kernel/pci.c linux/arch/mips/kernel/pci.c
--- 2.5/arch/mips/kernel/pci.c	Wed Mar  5 06:29:31 2003
+++ linux/arch/mips/kernel/pci.c	Wed Mar 12 15:02:39 2003
@@ -168,8 +168,8 @@ pcibios_align_resource(void *data, struc
 }
 
 void
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-			struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	/* this should not be called */
 }
diff -urpN 2.5/arch/mips/mips-boards/generic/pci.c linux/arch/mips/mips-boards/generic/pci.c
--- 2.5/arch/mips/mips-boards/generic/pci.c	Wed Mar  5 06:29:16 2003
+++ linux/arch/mips/mips-boards/generic/pci.c	Wed Mar 12 15:08:01 2003
@@ -249,8 +249,8 @@ struct pci_fixup pcibios_fixups[] = {
 };
 
 void __init
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-                        struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	unsigned long where, size;
 	u32 reg;
@@ -258,7 +258,8 @@ pcibios_update_resource(struct pci_dev *
 	where = PCI_BASE_ADDRESS_0 + (resource * 4);
 	size = res->end - res->start;
 	pci_read_config_dword(dev, where, &reg);
-	reg = (reg & size) | (((u32)(res->start - root->start)) & ~size);
+	/* FIXME - this doesn't work for PCI-PCI bridges. */
+	reg = (reg & size) | (((u32)(res->start - res->parent->start)) & ~size);
 	pci_write_config_dword(dev, where, reg);
 }
 
diff -urpN 2.5/arch/mips/sni/pci.c linux/arch/mips/sni/pci.c
--- 2.5/arch/mips/sni/pci.c	Wed Mar  5 06:29:58 2003
+++ linux/arch/mips/sni/pci.c	Wed Mar 12 14:59:24 2003
@@ -138,8 +138,8 @@ pcibios_fixup_bus(struct pci_bus *b)
 }
 
 void
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-			struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	u32 new, check;
 	int reg;
diff -urpN 2.5/arch/mips64/mips-boards/generic/pci.c linux/arch/mips64/mips-boards/generic/pci.c
--- 2.5/arch/mips64/mips-boards/generic/pci.c	Wed Mar  5 06:28:58 2003
+++ linux/arch/mips64/mips-boards/generic/pci.c	Wed Mar 12 15:12:36 2003
@@ -308,8 +308,8 @@ struct pci_fixup pcibios_fixups[] = {
 };
 
 void __init
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-                        struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	unsigned long where, size;
 	u32 reg;
@@ -317,7 +317,8 @@ pcibios_update_resource(struct pci_dev *
 	where = PCI_BASE_ADDRESS_0 + (resource * 4);
 	size = res->end - res->start;
 	pci_read_config_dword(dev, where, &reg);
-	reg = (reg & size) | (((u32)(res->start - root->start)) & ~size);
+	/* FIXME - this doesn't work for PCI-PCI bridges. */
+	reg = (reg & size) | (((u32)(res->start - res->parent->start)) & ~size);
 	pci_write_config_dword(dev, where, reg);
 }
 
diff -urpN 2.5/arch/mips64/sgi-ip27/ip27-pci.c linux/arch/mips64/sgi-ip27/ip27-pci.c
--- 2.5/arch/mips64/sgi-ip27/ip27-pci.c	Wed Mar  5 06:29:32 2003
+++ linux/arch/mips64/sgi-ip27/ip27-pci.c	Wed Mar 12 15:14:04 2003
@@ -215,8 +215,8 @@ pcibios_update_irq(struct pci_dev *dev, 
 }
 
 void __init
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-                        struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	unsigned long where, size;
 	u32 reg;
@@ -224,7 +224,8 @@ pcibios_update_resource(struct pci_dev *
 	where = PCI_BASE_ADDRESS_0 + (resource * 4);
 	size = res->end - res->start;
 	pci_read_config_dword(dev, where, &reg);
-	reg = (reg & size) | (((u32)(res->start - root->start)) & ~size);
+	/* FIXME - this doesn't work for PCI-PCI bridges. */
+	reg = (reg & size) | (((u32)(res->start - res->parent->start)) & ~size);
 	pci_write_config_dword(dev, where, reg);
 }
 
diff -urpN 2.5/arch/mips64/sgi-ip32/ip32-pci.c linux/arch/mips64/sgi-ip32/ip32-pci.c
--- 2.5/arch/mips64/sgi-ip32/ip32-pci.c	Wed Mar  5 06:29:55 2003
+++ linux/arch/mips64/sgi-ip32/ip32-pci.c	Wed Mar 12 14:54:38 2003
@@ -333,8 +333,8 @@ void __init pcibios_align_resource (void
 {
 }
 
-void __init pcibios_update_resource (struct pci_dev *dev, struct resource *root,
-				     struct resource *res, int resource)
+void __init pcibios_update_resource (struct pci_dev *dev, struct resource *res,
+				     int resource)
 {
 }
 
diff -urpN 2.5/arch/parisc/kernel/pci.c linux/arch/parisc/kernel/pci.c
--- 2.5/arch/parisc/kernel/pci.c	Wed Mar  5 06:28:53 2003
+++ linux/arch/parisc/kernel/pci.c	Wed Mar 12 14:50:33 2003
@@ -211,7 +211,6 @@ void __devinit pcibios_update_irq(struct
 void __devinit
 pcibios_update_resource(
 	struct pci_dev *dev,
-	struct resource *root,
 	struct resource *res,
 	int barnum
 	)
diff -urpN 2.5/arch/ppc/kernel/pci.c linux/arch/ppc/kernel/pci.c
--- 2.5/arch/ppc/kernel/pci.c	Wed Mar  5 06:29:18 2003
+++ linux/arch/ppc/kernel/pci.c	Wed Mar 12 15:09:57 2003
@@ -94,8 +94,8 @@ fixup_broken_pcnet32(struct pci_dev* dev
 }
 
 void
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-			struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	u32 new, check;
 	int reg;
diff -urpN 2.5/arch/ppc64/kernel/pci.c linux/arch/ppc64/kernel/pci.c
--- 2.5/arch/ppc64/kernel/pci.c	Wed Mar  5 06:29:34 2003
+++ linux/arch/ppc64/kernel/pci.c	Wed Mar 12 15:14:23 2003
@@ -134,8 +134,8 @@ void __devinit pcibios_fixup_pbus_ranges
 }
 
 void
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-			     struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	u32 new, check;
 	int reg;
diff -urpN 2.5/arch/sh/kernel/pcibios.c linux/arch/sh/kernel/pcibios.c
--- 2.5/arch/sh/kernel/pcibios.c	Wed Mar  5 06:29:05 2003
+++ linux/arch/sh/kernel/pcibios.c	Wed Mar 12 14:47:24 2003
@@ -27,8 +27,8 @@
 #include <linux/init.h>
 
 void
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-			struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	u32 new, check;
 	int reg;
diff -urpN 2.5/arch/sparc/kernel/pcic.c linux/arch/sparc/kernel/pcic.c
--- 2.5/arch/sparc/kernel/pcic.c	Wed Mar  5 06:29:20 2003
+++ linux/arch/sparc/kernel/pcic.c	Wed Mar 12 15:10:11 2003
@@ -856,8 +856,8 @@ char * __init pcibios_setup(char *str)
 
 /*
  */
-void pcibios_update_resource(struct pci_dev *pdev, struct resource *res1,
-			     struct resource *res2, int index)
+void pcibios_update_resource(struct pci_dev *pdev, struct resource *res,
+			     int index)
 {
 }
 
diff -urpN 2.5/arch/sparc64/kernel/pci.c linux/arch/sparc64/kernel/pci.c
--- 2.5/arch/sparc64/kernel/pci.c	Wed Mar  5 06:28:52 2003
+++ linux/arch/sparc64/kernel/pci.c	Wed Mar 12 15:08:43 2003
@@ -470,8 +470,8 @@ int pci_assign_resource(struct pci_dev *
 	return err;
 }
 
-void pcibios_update_resource(struct pci_dev *pdev, struct resource *res1,
-			     struct resource *res2, int index)
+void pcibios_update_resource(struct pci_dev *pdev, struct resource *res,
+			     int index)
 {
 }
 
diff -urpN 2.5/arch/v850/kernel/rte_mb_a_pci.c linux/arch/v850/kernel/rte_mb_a_pci.c
--- 2.5/arch/v850/kernel/rte_mb_a_pci.c	Wed Mar  5 06:29:03 2003
+++ linux/arch/v850/kernel/rte_mb_a_pci.c	Wed Mar 12 14:49:00 2003
@@ -288,8 +288,7 @@ void __devinit pcibios_update_irq (struc
 }
 
 void __nomods_init
-pcibios_update_resource (struct pci_dev *dev, struct resource *root,
-			 struct resource *r, int resource)
+pcibios_update_resource (struct pci_dev *dev, struct resource *r, int resource)
 {
 	u32 new, check;
 	int reg;
diff -urpN 2.5/arch/x86_64/pci/x86-64.c linux/arch/x86_64/pci/x86-64.c
--- 2.5/arch/x86_64/pci/x86-64.c	Wed Mar  5 06:29:52 2003
+++ linux/arch/x86_64/pci/x86-64.c	Wed Mar 12 14:49:34 2003
@@ -34,8 +34,8 @@
 #include "pci.h"
 
 void
-pcibios_update_resource(struct pci_dev *dev, struct resource *root,
-			struct resource *res, int resource)
+pcibios_update_resource(struct pci_dev *dev, struct resource *res,
+			int resource)
 {
 	u32 new, check;
 	int reg;
diff -urpN 2.5/drivers/pci/setup-res.c linux/drivers/pci/setup-res.c
--- 2.5/drivers/pci/setup-res.c	Wed Mar 12 13:33:45 2003
+++ linux/drivers/pci/setup-res.c	Wed Mar 12 16:35:36 2003
@@ -90,9 +90,9 @@ int pci_assign_resource(struct pci_dev *
 		       resno, res->start, res->end, dev->slot_name);
 	} else {
 		DBGC((KERN_ERR "  got res[%lx:%lx] for resource %d of %s\n",
-		      res->start, res->end, i, dev->dev.name));
+		      res->start, res->end, resno, dev->dev.name));
 		/* Update PCI config space.  */
-		pcibios_update_resource(dev, res->parent, res, resno);
+		pcibios_update_resource(dev, res, resno);
 	}
 
 	return ret;
diff -urpN 2.5/include/linux/pci.h linux/include/linux/pci.h
--- 2.5/include/linux/pci.h	Wed Mar 12 13:33:54 2003
+++ linux/include/linux/pci.h	Wed Mar 12 14:46:43 2003
@@ -531,8 +531,7 @@ char *pcibios_setup (char *str);
 /* Used only when drivers/pci/setup.c is used */
 void pcibios_align_resource(void *, struct resource *,
 			    unsigned long, unsigned long);
-void pcibios_update_resource(struct pci_dev *, struct resource *,
-			     struct resource *, int);
+void pcibios_update_resource(struct pci_dev *, struct resource *, int);
 void pcibios_update_irq(struct pci_dev *, int irq);
 void pcibios_fixup_pbus_ranges(struct pci_bus *, struct pbus_set_ranges_data *);
 

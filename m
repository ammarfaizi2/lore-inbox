Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTFJSm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTFJSmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:42:25 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:31389 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264067AbTFJShf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:35 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270970689@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709703278@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1385, 2003/06/09 16:56:37-07:00, willy@debian.org

[PATCH] PCI: domain support for sysfs


 arch/alpha/Kconfig              |    4 ++++
 arch/alpha/kernel/pci.c         |    8 --------
 arch/ia64/Kconfig               |    4 ++++
 arch/ia64/hp/common/sba_iommu.c |    2 +-
 arch/ia64/pci/pci.c             |    4 ++--
 arch/ppc/Kconfig                |    4 ++++
 arch/ppc/kernel/pci.c           |   10 ----------
 arch/ppc64/Kconfig              |    4 ++++
 arch/ppc64/kernel/pci.c         |    6 +++---
 arch/sparc64/Kconfig            |    4 ++++
 arch/sparc64/kernel/pci.c       |    6 +++---
 drivers/pci/probe.c             |    3 ++-
 drivers/pci/proc.c              |    2 +-
 include/asm-alpha/pci.h         |    5 ++---
 include/asm-arm/pci.h           |    8 --------
 include/asm-h8300/pci.h         |    3 ---
 include/asm-i386/pci.h          |    6 ------
 include/asm-ia64/pci.h          |    5 +----
 include/asm-m68k/pci.h          |    3 ---
 include/asm-mips/pci.h          |    3 ---
 include/asm-mips64/pci.h        |    5 -----
 include/asm-parisc/pci.h        |    3 ---
 include/asm-ppc/pci-bridge.h    |    2 +-
 include/asm-ppc/pci.h           |    2 +-
 include/asm-ppc64/pci.h         |    3 +--
 include/asm-sh/pci.h            |    3 ---
 include/asm-sparc/pci.h         |    3 ---
 include/asm-sparc64/pci.h       |    2 +-
 include/asm-v850/rte_cb.h       |    1 -
 include/asm-x86_64/pci.h        |    6 ------
 include/linux/pci.h             |   10 ++++++++++
 31 files changed, 49 insertions(+), 85 deletions(-)


diff -Nru a/arch/alpha/Kconfig b/arch/alpha/Kconfig
--- a/arch/alpha/Kconfig	Tue Jun 10 11:16:11 2003
+++ b/arch/alpha/Kconfig	Tue Jun 10 11:16:11 2003
@@ -295,6 +295,10 @@
 	  information about which PCI hardware does work under Linux and which
 	  doesn't.
 
+config PCI_DOMAINS
+	bool
+	default PCI
+
 config ALPHA_CORE_AGP
 	bool
 	depends on ALPHA_GENERIC || ALPHA_TITAN || ALPHA_MARVEL
diff -Nru a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
--- a/arch/alpha/kernel/pci.c	Tue Jun 10 11:16:11 2003
+++ b/arch/alpha/kernel/pci.c	Tue Jun 10 11:16:11 2003
@@ -484,11 +484,3 @@
 
 	return -EOPNOTSUPP;
 }
-
-/* Return the index of the PCI controller for device PDEV. */
-int
-pci_controller_num(struct pci_dev *pdev)
-{
-        struct pci_controller *hose = pdev->sysdata;
-	return (hose ? (int) hose->index : -ENXIO);
-}
diff -Nru a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	Tue Jun 10 11:16:11 2003
+++ b/arch/ia64/Kconfig	Tue Jun 10 11:16:11 2003
@@ -543,6 +543,10 @@
 	  information about which PCI hardware does work under Linux and which
 	  doesn't.
 
+config PCI_DOMAINS
+	bool
+	default PCI
+
 source "drivers/pci/Kconfig"
 
 config HOTPLUG
diff -Nru a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
--- a/arch/ia64/hp/common/sba_iommu.c	Tue Jun 10 11:16:11 2003
+++ b/arch/ia64/hp/common/sba_iommu.c	Tue Jun 10 11:16:11 2003
@@ -1889,7 +1889,7 @@
 		handle = parent;
 	} while (ACPI_SUCCESS(status));
 
-	printk(KERN_WARNING "No IOC for PCI Bus %02x:%02x in ACPI\n", PCI_SEGMENT(bus), bus->number);
+	printk(KERN_WARNING "No IOC for PCI Bus %04x:%02x in ACPI\n", pci_domain_nr(bus), bus->number);
 }
 
 static int __init
diff -Nru a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c	Tue Jun 10 11:16:11 2003
+++ b/arch/ia64/pci/pci.c	Tue Jun 10 11:16:11 2003
@@ -87,14 +87,14 @@
 static int
 pci_sal_read (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return __pci_sal_read(PCI_SEGMENT(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn),
+	return __pci_sal_read(pci_domain_nr(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn),
 			      where, size, value);
 }
 
 static int
 pci_sal_write (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return __pci_sal_write(PCI_SEGMENT(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn),
+	return __pci_sal_write(pci_domain_nr(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn),
 			       where, size, value);
 }
 
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Tue Jun 10 11:16:11 2003
+++ b/arch/ppc/Kconfig	Tue Jun 10 11:16:11 2003
@@ -773,6 +773,10 @@
 	  your box.  If you say Y here, the kernel will include drivers and
 	  infrastructure code to support PCI bus devices.
 
+config PCI_DOMAINS
+	bool
+	default PCI
+
 config PC_KEYBOARD
 	bool "PC PS/2 style Keyboard"
 	depends on 4xx || 8260
diff -Nru a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c	Tue Jun 10 11:16:11 2003
+++ b/arch/ppc/kernel/pci.c	Tue Jun 10 11:16:11 2003
@@ -1483,16 +1483,6 @@
 }
 
 /*
- * Return the index of the PCI controller for device pdev.
- */
-int pci_controller_num(struct pci_dev *dev)
-{
-	struct pci_controller *hose = (struct pci_controller *) dev->sysdata;
-
-	return hose->index;
-}
-
-/*
  * Platform support for /proc/bus/pci/X/Y mmap()s,
  * modelled on the sparc64 implementation by Dave Miller.
  *  -- paulus.
diff -Nru a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig	Tue Jun 10 11:16:11 2003
+++ b/arch/ppc64/Kconfig	Tue Jun 10 11:16:11 2003
@@ -171,6 +171,10 @@
 	  your box.  If you say Y here, the kernel will include drivers and
 	  infrastructure code to support PCI bus devices.
 
+config PCI_DOMAINS
+	bool
+	default PCI
+
 # only elf supported, a.out is not -- Cort
 config KCORE_ELF
 	bool
diff -Nru a/arch/ppc64/kernel/pci.c b/arch/ppc64/kernel/pci.c
--- a/arch/ppc64/kernel/pci.c	Tue Jun 10 11:16:11 2003
+++ b/arch/ppc64/kernel/pci.c	Tue Jun 10 11:16:11 2003
@@ -371,11 +371,11 @@
 }
 
 /*
- * Return the index of the PCI controller for device pdev.
+ * Return the domain number for this bus.
  */
-int pci_controller_num(struct pci_dev *dev)
+int pci_domain_nr(struct pci_bus *bus)
 {
-	struct pci_controller *hose = PCI_GET_PHB_PTR(dev);
+	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
 
 	return hose->global_number;
 }
diff -Nru a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig	Tue Jun 10 11:16:11 2003
+++ b/arch/sparc64/Kconfig	Tue Jun 10 11:16:11 2003
@@ -318,6 +318,10 @@
 	  information about which PCI hardware does work under Linux and which
 	  doesn't.
 
+config PCI_DOMAINS
+	bool
+	default PCI
+
 config RTC
 	tristate
 	depends on PCI
diff -Nru a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
--- a/arch/sparc64/kernel/pci.c	Tue Jun 10 11:16:11 2003
+++ b/arch/sparc64/kernel/pci.c	Tue Jun 10 11:16:11 2003
@@ -802,11 +802,11 @@
 	return 0;
 }
 
-/* Return the index of the PCI controller for device PDEV. */
+/* Return the domain nuber for this pci bus */
 
-int pci_controller_num(struct pci_dev *pdev)
+int pci_domain_nr(struct pci_bus *bus)
 {
-	struct pcidev_cookie *cookie = pdev->sysdata;
+	struct pcidev_cookie *cookie = bus->sysdata;
 	int ret;
 
 	if (cookie != NULL) {
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Tue Jun 10 11:16:11 2003
+++ b/drivers/pci/probe.c	Tue Jun 10 11:16:11 2003
@@ -529,7 +529,8 @@
 	pci_name_device(dev);
 
 	/* now put in global tree */
-	strcpy(dev->dev.bus_id,dev->slot_name);
+	sprintf(dev->dev.bus_id, "%04x:%s", pci_domain_nr(bus),
+			dev->slot_name);
 	dev->dev.dma_mask = &dev->dma_mask;
 
 	return dev;
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Tue Jun 10 11:16:11 2003
+++ b/drivers/pci/proc.c	Tue Jun 10 11:16:11 2003
@@ -210,7 +210,7 @@
 
 	switch (cmd) {
 	case PCIIOC_CONTROLLER:
-		ret = pci_controller_num(dev);
+		ret = pci_domain_nr(dev->bus);
 		break;
 
 #ifdef HAVE_PCI_MMAP
diff -Nru a/include/asm-alpha/pci.h b/include/asm-alpha/pci.h
--- a/include/asm-alpha/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-alpha/pci.h	Tue Jun 10 11:16:11 2003
@@ -188,12 +188,11 @@
 	/* Nothing to do. */
 }
 
-/* Return the index of the PCI controller for device PDEV. */
-extern int pci_controller_num(struct pci_dev *pdev);
-
 extern void
 pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			 struct resource *res);
+
+#define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 #endif /* __KERNEL__ */
 
diff -Nru a/include/asm-arm/pci.h b/include/asm-arm/pci.h
--- a/include/asm-arm/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-arm/pci.h	Tue Jun 10 11:16:11 2003
@@ -128,14 +128,6 @@
  */
 #define pci_dac_dma_supported(pci_dev, mask)	(0)
 
-/*
- * Return the index of the PCI controller for device PDEV.
- */
-static inline int pci_controller_num(struct pci_dev *dev)
-{
-	return 0;
-}
-
 
 #if defined(CONFIG_SA1111) && !defined(CONFIG_PCI)
 /*
diff -Nru a/include/asm-h8300/pci.h b/include/asm-h8300/pci.h
--- a/include/asm-h8300/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-h8300/pci.h	Tue Jun 10 11:16:11 2003
@@ -19,7 +19,4 @@
 	/* We don't do dynamic PCI IRQ allocation */
 }
 
-/* Return the index of the PCI controller for device PDEV. */
-#define pci_controller_num(PDEV)	(0)
-
 #endif /* _ASM_H8300_PCI_H */
diff -Nru a/include/asm-i386/pci.h b/include/asm-i386/pci.h
--- a/include/asm-i386/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-i386/pci.h	Tue Jun 10 11:16:11 2003
@@ -90,12 +90,6 @@
 #define sg_dma_address(sg)	((sg)->dma_address)
 #define sg_dma_len(sg)		((sg)->length)
 
-/* Return the index of the PCI controller for device. */
-static inline int pci_controller_num(struct pci_dev *dev)
-{
-	return 0;
-}
-
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			       enum pci_mmap_state mmap_state, int write_combine);
diff -Nru a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-ia64/pci.h	Tue Jun 10 11:16:11 2003
@@ -70,9 +70,6 @@
 #define pci_dac_dma_to_offset(dev,dma_addr)		((dma_addr) & ~PAGE_MASK)
 #define pci_dac_dma_sync_single(dev,dma_addr,len,dir)	do { mb(); } while (0)
 
-/* Return the index of the PCI controller for device PDEV. */
-#define pci_controller_num(PDEV)	(0)
-
 #define sg_dma_len(sg)		((sg)->dma_length)
 #define sg_dma_address(sg)	((sg)->dma_address)
 
@@ -95,7 +92,7 @@
 };
 
 #define PCI_CONTROLLER(busdev) ((struct pci_controller *) busdev->sysdata)
-#define PCI_SEGMENT(busdev)    (PCI_CONTROLLER(busdev)->segment)
+#define pci_domain_nr(busdev)    (PCI_CONTROLLER(busdev)->segment)
 
 /* generic pci stuff */
 #include <asm-generic/pci.h>
diff -Nru a/include/asm-m68k/pci.h b/include/asm-m68k/pci.h
--- a/include/asm-m68k/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-m68k/pci.h	Tue Jun 10 11:16:11 2003
@@ -45,9 +45,6 @@
 	/* We don't do dynamic PCI IRQ allocation */
 }
 
-/* Return the index of the PCI controller for device PDEV. */
-#define pci_controller_num(PDEV)	(0)
-
 /* The PCI address space does equal the physical memory
  * address space.  The networking and block device layers use
  * this boolean for bounce buffer decisions.
diff -Nru a/include/asm-mips/pci.h b/include/asm-mips/pci.h
--- a/include/asm-mips/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-mips/pci.h	Tue Jun 10 11:16:11 2003
@@ -237,9 +237,6 @@
 }
 
 
-/* Return the index of the PCI controller for device. */
-#define pci_controller_num(pdev)	(0)
-
 /*
  * These macros should be used after a pci_map_sg call has been done
  * to get bus addresses of each of the SG entries and their lengths.
diff -Nru a/include/asm-mips64/pci.h b/include/asm-mips64/pci.h
--- a/include/asm-mips64/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-mips64/pci.h	Tue Jun 10 11:16:11 2003
@@ -256,11 +256,6 @@
 }
 
 /*
- * Return the index of the PCI controller for device.
- */
-#define pci_controller_num(pdev)	(0)
-
-/*
  * These macros should be used after a pci_map_sg call has been done
  * to get bus addresses of each of the SG entries and their lengths.
  * You should only work with the number of sg entries pci_map_sg
diff -Nru a/include/asm-parisc/pci.h b/include/asm-parisc/pci.h
--- a/include/asm-parisc/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-parisc/pci.h	Tue Jun 10 11:16:11 2003
@@ -180,9 +180,6 @@
 /* Don't support DAC yet. */
 #define pci_dac_dma_supported(pci_dev, mask)   (0)
 
-/* Return the index of the PCI controller for device PDEV. */
-#define	pci_controller_num(PDEV)	(0)
-
 /* export the pci_ DMA API in terms of the dma_ one */
 #include <asm-generic/pci-dma-compat.h>
 
diff -Nru a/include/asm-ppc/pci-bridge.h b/include/asm-ppc/pci-bridge.h
--- a/include/asm-ppc/pci-bridge.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-ppc/pci-bridge.h	Tue Jun 10 11:16:11 2003
@@ -39,7 +39,7 @@
  * Structure of a PCI controller (host bridge)
  */
 struct pci_controller {
-	int index;			/* used for pci_controller_num */
+	int index;			/* PCI domain number */
 	struct pci_controller *next;
         struct pci_bus *bus;
 	void *arch_data;
diff -Nru a/include/asm-ppc/pci.h b/include/asm-ppc/pci.h
--- a/include/asm-ppc/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-ppc/pci.h	Tue Jun 10 11:16:11 2003
@@ -266,7 +266,7 @@
 }
 
 /* Return the index of the PCI controller for device PDEV. */
-extern int pci_controller_num(struct pci_dev *pdev);
+#define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 /* Map a range of PCI memory or I/O space for a device into user space */
 int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
diff -Nru a/include/asm-ppc64/pci.h b/include/asm-ppc64/pci.h
--- a/include/asm-ppc64/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-ppc64/pci.h	Tue Jun 10 11:16:11 2003
@@ -86,8 +86,7 @@
 	return 1;
 }
 
-/* Return the index of the PCI controller for device PDEV. */
-extern int pci_controller_num(struct pci_dev *pdev);
+extern int pci_domain_nr(struct pci_bus *bus);
 
 struct vm_area_struct;
 /* Map a range of PCI memory or I/O space for a device into user space */
diff -Nru a/include/asm-sh/pci.h b/include/asm-sh/pci.h
--- a/include/asm-sh/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-sh/pci.h	Tue Jun 10 11:16:11 2003
@@ -226,9 +226,6 @@
  */
 #define pci_dac_dma_supported(pci_dev, mask) (0)
 
-/* Return the index of the PCI controller for device PDEV. */
-#define pci_controller_num(PDEV)	(0)
-
 /* These macros should be used after a pci_map_sg call has been done
  * to get bus addresses of each of the SG entries and their lengths.
  * You should only work with the number of sg entries pci_map_sg
diff -Nru a/include/asm-sparc/pci.h b/include/asm-sparc/pci.h
--- a/include/asm-sparc/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-sparc/pci.h	Tue Jun 10 11:16:11 2003
@@ -132,9 +132,6 @@
 
 #define pci_dac_dma_supported(dev, mask)	(0)
 
-/* Return the index of the PCI controller for device PDEV. */
-#define pci_controller_num(PDEV)	(0)
-
 #endif /* __KERNEL__ */
 
 /* generic pci stuff */
diff -Nru a/include/asm-sparc64/pci.h b/include/asm-sparc64/pci.h
--- a/include/asm-sparc64/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-sparc64/pci.h	Tue Jun 10 11:16:11 2003
@@ -189,7 +189,7 @@
 
 /* Return the index of the PCI controller for device PDEV. */
 
-extern int pci_controller_num(struct pci_dev *pdev);
+extern int pci_domain_nr(struct pci_bus *bus);
 
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
 
diff -Nru a/include/asm-v850/rte_cb.h b/include/asm-v850/rte_cb.h
--- a/include/asm-v850/rte_cb.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-v850/rte_cb.h	Tue Jun 10 11:16:11 2003
@@ -54,7 +54,6 @@
    instead, perversely enough, this becomes always true! */
 #define pci_dma_supported(dev, mask)		1
 #define pci_dac_dma_supported(dev, mask)	0
-#define pci_controller_num(dev)			0
 #define pcibios_assign_all_busses()		1
 
 
diff -Nru a/include/asm-x86_64/pci.h b/include/asm-x86_64/pci.h
--- a/include/asm-x86_64/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/asm-x86_64/pci.h	Tue Jun 10 11:16:11 2003
@@ -270,12 +270,6 @@
 #define sg_dma_address(sg)	((sg)->dma_address)
 #define sg_dma_len(sg)		((sg)->length)
 
-/* Return the index of the PCI controller for device. */
-static inline int pci_controller_num(struct pci_dev *dev)
-{
-	return 0;
-}
-
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			       enum pci_mmap_state mmap_state, int write_combine);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Jun 10 11:16:11 2003
+++ b/include/linux/pci.h	Tue Jun 10 11:16:11 2003
@@ -805,5 +805,15 @@
 #define PCIPCI_VSFX		16
 #define PCIPCI_ALIMAGIK		32
 
+/*
+ * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
+ * a PCI domain is defined to be a set of PCI busses which share
+ * configuration space.
+ */
+
+#ifndef CONFIG_PCI_DOMAINS
+#define pci_domain_nr(bus)	0
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */


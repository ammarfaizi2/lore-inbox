Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268711AbUIQMIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268711AbUIQMIy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 08:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268714AbUIQMIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 08:08:54 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57562 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268711AbUIQMGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 08:06:25 -0400
Date: Fri, 17 Sep 2004 21:06:18 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [RFC&PATCH 1/2] PCI Error Recovery (readX_check)
In-reply-to: <412FDE7B.3070609@jp.fujitsu.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Cc: Grant Grundler <iod00d@hp.com>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-id: <414AD33A.80701@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja, en-us, en
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
References: <412FDE7B.3070609@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the latest patch for PCI recovery.
  (merge Grant's text, fix spellmisses)

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

diff -Nur linux-2.6.8.1/arch/i386/pci/common.c linux-2.6.8.1-pci/arch/i386/pci/common.c
--- linux-2.6.8.1/arch/i386/pci/common.c	2004-08-14 19:55:19.000000000 +0900
+++ linux-2.6.8.1-pci/arch/i386/pci/common.c	2004-09-13 10:44:53.000000000 +0900
@@ -118,6 +118,19 @@
  	pci_read_bridge_bases(b);
  }

+#ifdef CONFIG_PCI_ERROR_RECOVERY
+static void pci_i386_fixup_host_bridge_self(struct pci_bus *bus)
+{
+	struct pci_dev *pdev;
+
+	list_for_each_entry(pdev, &bus->devices, bus_list) {
+		if (pdev->class >> 8 == PCI_CLASS_BRIDGE_HOST) {
+			bus->self = pdev;
+			return;
+		}
+	}
+}
+#endif

  struct pci_bus * __devinit pcibios_scan_root(int busnum)
  {
@@ -132,7 +145,16 @@

  	printk("PCI: Probing PCI hardware (bus %02x)\n", busnum);

+#ifdef CONFIG_PCI_ERROR_RECOVERY
+{
+	struct pci_bus *bus = pci_scan_bus(busnum, &pci_root_ops, NULL);
+	if (bus)
+		pci_i386_fixup_host_bridge_self(bus);
+	return bus;
+}
+#else
  	return pci_scan_bus(busnum, &pci_root_ops, NULL);
+#endif
  }

  extern u8 pci_cache_line_size;
diff -Nur linux-2.6.8.1/drivers/pci/Kconfig linux-2.6.8.1-pci/drivers/pci/Kconfig
--- linux-2.6.8.1/drivers/pci/Kconfig	2004-08-14 19:55:09.000000000 +0900
+++ linux-2.6.8.1-pci/drivers/pci/Kconfig	2004-09-13 11:02:37.000000000 +0900
@@ -47,3 +47,11 @@

  	  When in doubt, say Y.

+config PCI_ERROR_RECOVERY
+	bool "PCI device error recovery"
+	depends on PCI && EXPERIMENTAL
+	---help---
+	Saying Y provides PCI infrastructure to recover from some PCI errors.
+	Currently, very few PCI drivers actually implement this.
+	See Documentation/pci-errors.txt for a description of the
+	infrastructure provided.
diff -Nur linux-2.6.8.1/drivers/pci/Makefile linux-2.6.8.1-pci/drivers/pci/Makefile
--- linux-2.6.8.1/drivers/pci/Makefile	2004-08-14 19:56:15.000000000 +0900
+++ linux-2.6.8.1-pci/drivers/pci/Makefile	2004-09-13 10:44:53.000000000 +0900
@@ -5,6 +5,7 @@
  obj-y		+= access.o bus.o probe.o remove.o pci.o quirks.o \
  			names.o pci-driver.o search.o pci-sysfs.o
  obj-$(CONFIG_PROC_FS) += proc.o
+obj-$(CONFIG_PCI_ERROR_RECOVERY) += pci-rec.o

  ifndef CONFIG_SPARC64
  obj-y += setup-res.o
diff -Nur linux-2.6.8.1/drivers/pci/pci.c linux-2.6.8.1-pci/drivers/pci/pci.c
--- linux-2.6.8.1/drivers/pci/pci.c	2004-08-14 19:55:09.000000000 +0900
+++ linux-2.6.8.1-pci/drivers/pci/pci.c	2004-09-13 10:44:53.000000000 +0900
@@ -750,6 +750,9 @@
  	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
  		pci_fixup_device(PCI_FIXUP_FINAL, dev);
  	}
+#ifdef CONFIG_PCI_ERROR_RECOVERY
+	pciwhole_lock_init();
+#endif
  	return 0;
  }

diff -Nur linux-2.6.8.1/drivers/pci/pci-rec.c linux-2.6.8.1-pci/drivers/pci/pci-rec.c
--- linux-2.6.8.1/drivers/pci/pci-rec.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.8.1-pci/drivers/pci/pci-rec.c	2004-09-13 11:11:22.000000000 +0900
@@ -0,0 +1,222 @@
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/spinlock.h>
+#include <asm/pci.h>
+#include <asm/page.h>
+#include <asm/dma.h>    /* isa_dma_bridge_buggy */
+#include <asm/semaphore.h>
+#include <linux/list.h>
+#include <linux/rwsem.h>
+
+static rwlock_t pci_whole_lock;
+
+void
+pcibus_lock_init(struct pci_bus *bus)
+{
+	init_rwsem(&bus->bus_lock);
+}
+
+void
+pcibus_lock(struct pci_bus *bus)
+{
+	down_read(&bus->bus_lock);
+}
+
+void
+pcibus_unlock(struct pci_bus *bus)
+{
+	up_read(&bus->bus_lock);
+}
+
+void
+pciwhole_lock_init(void)
+{
+	rwlock_init(&pci_whole_lock);
+}
+
+void
+pciwhole_read_lock(void)
+{
+	read_lock(&pci_whole_lock);
+}
+
+void
+pciwhole_read_unlock(void)
+{
+	read_unlock(&pci_whole_lock);
+}
+
+void
+pciwhole_write_lock(void)
+{
+	write_lock(&pci_whole_lock);
+}
+
+void
+pciwhole_write_unlock(void)
+{
+	write_unlock(&pci_whole_lock);
+}
+
+#define IF_IS_PCI_ERROR(status)                         \
+        if ((status & PCI_STATUS_REC_TARGET_ABORT)      \
+          ||(status & PCI_STATUS_REC_MASTER_ABORT)      \
+          ||(status & PCI_STATUS_DETECTED_PARITY))
+
+void
+clear_pci_errors(struct pci_dev *dev)
+{
+	u16 status;
+	struct pci_dev *prootdev, *pdev;
+	struct pci_bus *pbus;
+
+	/* find root bus bridge */
+	if (!dev->bus->self) return;
+	for (pbus = dev->bus; pbus->parent && pbus->parent->self; pbus = pbus->parent) ;
+	prootdev = pbus->self;
+	/* check status (host bus bridge or PCI to PCI bridge) */
+	switch (prootdev->hdr_type) {
+		case PCI_HEADER_TYPE_NORMAL: /* 0 */
+			pci_read_config_word(prootdev, PCI_STATUS, &status);
+			break;
+		case PCI_HEADER_TYPE_BRIDGE: /* 1 */
+			pci_read_config_word(prootdev, PCI_SEC_STATUS, &status);
+			break;
+		case PCI_HEADER_TYPE_CARDBUS: /* 2 */
+		default:
+			BUG();
+	}
+	/* "status" holds error status or not. */
+	IF_IS_PCI_ERROR(status) {
+		pciwhole_write_lock();
+		if (!list_empty(&prootdev->working_device)) {
+			/* apply for all devices under same root bus bridges */
+			list_for_each_entry(pdev, &prootdev->working_device, working_device) {
+				pdev->err_status |= status;
+			}
+		}
+		/* status clear */
+		switch (prootdev->hdr_type) {
+			case PCI_HEADER_TYPE_NORMAL: /* 0 */
+				pci_write_config_word(prootdev, PCI_STATUS, status);
+				break;
+			case PCI_HEADER_TYPE_BRIDGE: /* 1 */
+				pci_write_config_word(prootdev, PCI_SEC_STATUS, status);
+				break;
+			case PCI_HEADER_TYPE_CARDBUS: /* 2 */
+			default:
+				BUG();
+		}
+		pciwhole_write_unlock();
+	}
+	/* initialize error holding variables */
+	dev->err_status = 0;
+	/* register to root bus bridge for Multiple I/O */
+	pcibus_lock(pbus);
+	list_add(&dev->working_device, &prootdev->working_device);
+	pcibus_unlock(pbus);
+}
+
+int
+read_pci_errors(struct pci_dev *dev)
+{
+	u32	status = 0;
+	u16	raw_br_status;
+	struct pci_dev *prootdev;
+	struct pci_bus *pbus;
+
+	/* find root bus bridge */
+	if (!dev->bus->self)
+		return 0; /* pseudo-no error */
+	for (pbus = dev->bus; pbus->parent && pbus->parent->self;
+						pbus = pbus->parent) ;
+	prootdev = pbus->self;
+	/* unregister from root bus bridge */
+	pcibus_lock(pbus);
+	if (list_empty(&prootdev->working_device)) {
+		BUG();
+		return 0;
+	}
+	list_del(&dev->working_device);
+	pcibus_unlock(pbus);
+	/* check status (host bus bridge or PCI to PCI bridge) */
+	switch (prootdev->hdr_type) {
+		case PCI_HEADER_TYPE_NORMAL: /* 0 */
+			pci_read_config_word(prootdev, PCI_STATUS, &raw_br_status);
+			break;
+		case PCI_HEADER_TYPE_BRIDGE: /* 1 */
+			pci_read_config_word(prootdev, PCI_SEC_STATUS, &raw_br_status);
+			break;
+		case PCI_HEADER_TYPE_CARDBUS: /* 2 */
+		default:
+			BUG();
+	}
+	status |= raw_br_status;	/* current bridge status */
+	status |= dev->err_status;	/* saved bridge status+ */
+	IF_IS_PCI_ERROR(status) {	/* Target/Master Abort */
+		return 1;
+	}
+	return 0;
+}
+
+void pcidev_extra_init(struct pci_dev *dev)
+{
+	INIT_LIST_HEAD(&dev->working_device);
+	dev->err_status = 0;
+}
+
+u8
+readb_check(struct pci_dev *dev, u8 *addr)
+{
+	u8 val;
+
+	pciwhole_read_lock();
+	val = _readb_check(addr);
+	pciwhole_read_unlock();
+
+	return val;
+}
+
+u16
+readw_check(struct pci_dev *dev, u16 *addr)
+{
+	u16 val;
+
+	pciwhole_read_lock();
+	val = _readw_check(addr);
+	pciwhole_read_unlock();
+
+	return val;
+}
+
+u32
+readl_check(struct pci_dev *dev, u32 *addr)
+{
+	u32 val;
+
+	pciwhole_read_lock();
+	val = _readl_check(addr);
+	pciwhole_read_unlock();
+
+	return val;
+}
+
+EXPORT_SYMBOL (pcibus_lock_init);
+EXPORT_SYMBOL (pcibus_lock);
+EXPORT_SYMBOL (pcibus_unlock);
+EXPORT_SYMBOL (pciwhole_lock_init);
+EXPORT_SYMBOL (pciwhole_read_lock);
+EXPORT_SYMBOL (pciwhole_read_unlock);
+EXPORT_SYMBOL (pciwhole_write_lock);
+EXPORT_SYMBOL (pciwhole_write_unlock);
+EXPORT_SYMBOL (pcidev_extra_init);
+EXPORT_SYMBOL (clear_pci_errors);
+EXPORT_SYMBOL (read_pci_errors);
+EXPORT_SYMBOL (readb_check);
+EXPORT_SYMBOL (readw_check);
+EXPORT_SYMBOL (readl_check);
diff -Nur linux-2.6.8.1/drivers/pci/probe.c linux-2.6.8.1-pci/drivers/pci/probe.c
--- linux-2.6.8.1/drivers/pci/probe.c	2004-08-14 19:55:48.000000000 +0900
+++ linux-2.6.8.1-pci/drivers/pci/probe.c	2004-09-13 10:44:53.000000000 +0900
@@ -270,6 +270,9 @@
  		INIT_LIST_HEAD(&b->node);
  		INIT_LIST_HEAD(&b->children);
  		INIT_LIST_HEAD(&b->devices);
+#ifdef CONFIG_PCI_ERROR_RECOVERY
+		pcibus_lock_init(b);
+#endif
  	}
  	return b;
  }
@@ -624,6 +627,9 @@

  	dev->dev.dma_mask = &dev->dma_mask;
  	dev->dev.coherent_dma_mask = 0xffffffffull;
+#ifdef CONFIG_PCI_ERROR_RECOVERY
+	pcidev_extra_init(dev);
+#endif

  	return dev;
  }
diff -Nur linux-2.6.8.1/include/asm-i386/io.h linux-2.6.8.1-pci/include/asm-i386/io.h
--- linux-2.6.8.1/include/asm-i386/io.h	2004-08-14 19:56:23.000000000 +0900
+++ linux-2.6.8.1-pci/include/asm-i386/io.h	2004-09-13 10:44:53.000000000 +0900
@@ -364,4 +364,19 @@
  BUILDIO(w,w,short)
  BUILDIO(l,,int)

+static inline unsigned char _readb_check(unsigned char *addr)
+{
+	return readb(addr);
+}
+
+static inline unsigned short _readw_check(unsigned short *addr)
+{
+	return readw(addr);
+}
+
+static inline unsigned int _readl_check(unsigned int *addr)
+{
+	return readl(addr);
+}
+
  #endif
diff -Nur linux-2.6.8.1/include/asm-i386/pci.h linux-2.6.8.1-pci/include/asm-i386/pci.h
--- linux-2.6.8.1/include/asm-i386/pci.h	2004-08-14 19:55:19.000000000 +0900
+++ linux-2.6.8.1-pci/include/asm-i386/pci.h	2004-09-13 11:06:00.000000000 +0900
@@ -99,6 +99,11 @@
  {
  }

+#ifdef CONFIG_PCI_ERROR_RECOVERY
+u8  readb_check(struct pci_dev *, u8*);
+u16 readw_check(struct pci_dev *, u16*);
+u32 readl_check(struct pci_dev *, u32*);
+#endif
  #endif /* __KERNEL__ */

  /* implement the pci_ DMA API in terms of the generic device dma_ one */
diff -Nur linux-2.6.8.1/include/asm-ia64/io.h linux-2.6.8.1-pci/include/asm-ia64/io.h
--- linux-2.6.8.1/include/asm-ia64/io.h	2004-08-14 19:54:48.000000000 +0900
+++ linux-2.6.8.1-pci/include/asm-ia64/io.h	2004-09-17 20:52:45.000000000 +0900
@@ -457,4 +457,39 @@
  #define BIO_VMERGE_BOUNDARY	(ia64_max_iommu_merge_mask + 1)
  #endif

+static inline unsigned char
+_readb_check(unsigned char *addr)
+{
+	register unsigned long gr8 asm("r8");
+	unsigned char val;
+
+	val = readb(addr);
+	asm volatile ("add %0=%1,r0" : "=r"(gr8) : "r"(val));
+
+	return val;
+}
+
+static inline unsigned short
+_readw_check(unsigned short *addr)
+{
+	register unsigned long gr8 asm("r8");
+	unsigned short val;
+
+	val = readw(addr);
+	asm volatile ("add %0=%1,r0" : "=r"(gr8) : "r"(val));
+
+	return val;
+}
+
+static inline unsigned int
+_readl_check(unsigned int *addr)
+{
+	register unsigned long gr8 asm("r8");
+	unsigned int val;
+
+	val = readl(addr);
+	asm volatile ("add %0=%1,r0" : "=r"(gr8) : "r"(val));
+
+	return val;
+}
  #endif /* _ASM_IA64_IO_H */
diff -Nur linux-2.6.8.1/include/asm-ia64/pci.h linux-2.6.8.1-pci/include/asm-ia64/pci.h
--- linux-2.6.8.1/include/asm-ia64/pci.h	2004-08-14 19:56:22.000000000 +0900
+++ linux-2.6.8.1-pci/include/asm-ia64/pci.h	2004-09-13 10:44:53.000000000 +0900
@@ -119,6 +119,11 @@
  {
  }

+#ifdef CONFIG_PCI_ERROR_RECOVERY
+u8 readb_check(struct pci_dev *, u8*);
+u16 readw_check(struct pci_dev *, u16*);
+u32 readl_check(struct pci_dev *, u32*);
+#endif
  /* generic pci stuff */
  #include <asm-generic/pci.h>

diff -Nur linux-2.6.8.1/include/linux/pci.h linux-2.6.8.1-pci/include/linux/pci.h
--- linux-2.6.8.1/include/linux/pci.h	2004-08-14 19:55:32.000000000 +0900
+++ linux-2.6.8.1-pci/include/linux/pci.h	2004-09-13 10:44:53.000000000 +0900
@@ -486,6 +486,10 @@
  struct pci_dev {
  	struct list_head global_list;	/* node in list of all PCI devices */
  	struct list_head bus_list;	/* node in per-bus list */
+#ifdef CONFIG_PCI_ERROR_RECOVERY
+	struct list_head working_device;/* working device */
+	unsigned        err_status;     /* root bridge status and other error */
+#endif
  	struct pci_bus	*bus;		/* bus this device is on */
  	struct pci_bus	*subordinate;	/* bus this device bridges to */

@@ -568,6 +572,9 @@

  struct pci_bus {
  	struct list_head node;		/* node in list of buses */
+#ifdef CONFIG_PCI_ERROR_RECOVERY
+       struct rw_semaphore bus_lock;   /* for serialized operation under same root bridge */
+#endif
  	struct pci_bus	*parent;	/* parent bus this bridge is on */
  	struct list_head children;	/* list of child buses */
  	struct list_head devices;	/* list of devices on this bus */
@@ -1021,5 +1028,21 @@
  #define PCIPCI_VSFX		16
  #define PCIPCI_ALIMAGIK		32

+#ifdef CONFIG_PCI_ERROR_RECOVERY
+void pcidev_extra_init(struct pci_dev *);
+void pcibus_lock_init(struct pci_bus *);
+void pcibus_lock(struct pci_bus *);
+void pcibus_unlock(struct pci_bus *);
+void pciwhole_lock_init(void);
+void pciwhole_read_lock(void);
+void pciwhole_read_unlock(void);
+void pciwhole_write_lock(void);
+void pciwhole_write_unlock(void);
+void clear_pci_errors(struct pci_dev *);
+int read_pci_errors(struct pci_dev *);
+u8  readb_check(struct pci_dev *, u8 *);
+u16 readw_check(struct pci_dev *, u16 *);
+u32 readl_check(struct pci_dev *, u32 *);
+#endif
  #endif /* __KERNEL__ */
  #endif /* LINUX_PCI_H */


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVIAFm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVIAFm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 01:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVIAFm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 01:42:56 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:17886 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964830AbVIAFmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 01:42:55 -0400
Message-ID: <431694DB.90400@jp.fujitsu.com>
Date: Thu, 01 Sep 2005 14:42:51 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13] IOCHK interface for I/O error handling/detecting (for
 ia64)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements ia64-specific IOCHK interfaces that enable
PCI drivers to detect error and make their error handling easier.

Please refer archives if you need, e.g. http://lwn.net/Articles/139240/

Thanks,
H.Seto

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---
  arch/ia64/Kconfig           |   13 +++
  arch/ia64/kernel/mca.c      |   34 ++++++++
  arch/ia64/kernel/mca_asm.S  |   32 ++++++++
  arch/ia64/kernel/mca_drv.c  |   85 ++++++++++++++++++++++
  arch/ia64/lib/Makefile      |    1
  arch/ia64/lib/iomap_check.c |  168 ++++++++++++++++++++++++++++++++++++++++++++
  include/asm-ia64/io.h       |  139 ++++++++++++++++++++++++++++++++++++
  7 files changed, 472 insertions(+)

Index: linux-2.6.13/arch/ia64/lib/Makefile
===================================================================
--- linux-2.6.13.orig/arch/ia64/lib/Makefile
+++ linux-2.6.13/arch/ia64/lib/Makefile
@@ -16,6 +16,7 @@ lib-$(CONFIG_MCKINLEY)	+= copy_page_mck.
  lib-$(CONFIG_PERFMON)	+= carta_random.o
  lib-$(CONFIG_MD_RAID5)	+= xor.o
  lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
+lib-$(CONFIG_IOMAP_CHECK) += iomap_check.o

  AFLAGS___divdi3.o	=
  AFLAGS___udivdi3.o	= -DUNSIGNED
Index: linux-2.6.13/arch/ia64/Kconfig
===================================================================
--- linux-2.6.13.orig/arch/ia64/Kconfig
+++ linux-2.6.13/arch/ia64/Kconfig
@@ -399,6 +399,19 @@ config PCI_DOMAINS
  	bool
  	default PCI

+config IOMAP_CHECK
+	bool "Support iochk interfaces for IO error detection."
+	depends on PCI && EXPERIMENTAL
+	---help---
+	  Saying Y provides iochk infrastructure for "RAS-aware" drivers
+	  to detect and recover some IO errors, which strongly required by
+	  some of very-high-reliable systems.
+	  The implementation of this infrastructure is highly depend on arch,
+	  bus system, chipset and so on.
+	  Currently, very few drivers or architectures implement this support.
+
+	  If you don't know what to do here, say N.
+
  source "drivers/pci/Kconfig"

  source "drivers/pci/hotplug/Kconfig"
Index: linux-2.6.13/arch/ia64/lib/iomap_check.c
===================================================================
--- /dev/null
+++ linux-2.6.13/arch/ia64/lib/iomap_check.c
@@ -0,0 +1,168 @@
+/*
+ * File:    iomap_check.c
+ * Purpose: Implement the IA64 specific iomap recovery interfaces
+ */
+
+#include <linux/pci.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+void iochk_init(void);
+void iochk_clear(iocookie *cookie, struct pci_dev *dev);
+int  iochk_read(iocookie *cookie);
+
+struct list_head iochk_devices;
+DEFINE_RWLOCK(iochk_lock);	/* all works are excluded on this lock */
+
+static struct pci_dev *search_host_bridge(struct pci_dev *dev);
+static int have_error(struct pci_dev *dev);
+
+void notify_bridge_error(struct pci_dev *bridge);
+void clear_bridge_error(struct pci_dev *bridge);
+void save_bridge_error(void);
+
+void iochk_init(void)
+{
+	/* setup */
+	INIT_LIST_HEAD(&iochk_devices);
+}
+
+void iochk_clear(iocookie *cookie, struct pci_dev *dev)
+{
+	unsigned long flag;
+
+	INIT_LIST_HEAD(&(cookie->list));
+
+	cookie->dev = dev;
+	cookie->host = search_host_bridge(dev);
+
+	write_lock_irqsave(&iochk_lock, flag);
+	if (cookie->host && have_error(cookie->host)) {
+		/* someone under my bridge causes error... */
+		notify_bridge_error(cookie->host);
+		clear_bridge_error(cookie->host);
+	}
+	list_add(&cookie->list, &iochk_devices);
+	write_unlock_irqrestore(&iochk_lock, flag);
+
+	cookie->error = 0;
+}
+
+int iochk_read(iocookie *cookie)
+{
+	unsigned long flag;
+	int ret = 0;
+
+	write_lock_irqsave(&iochk_lock, flag);
+	if ( cookie->error || have_error(cookie->dev)
+		|| (cookie->host && have_error(cookie->host)) )
+		ret = 1;
+	list_del(&cookie->list);
+	write_unlock_irqrestore(&iochk_lock, flag);
+
+	return ret;
+}
+
+struct pci_dev *search_host_bridge(struct pci_dev *dev)
+{
+	struct pci_bus *pbus;
+
+	/* there is no bridge */
+	if (!dev->bus->self)
+		return NULL;
+
+	/* find root bus bridge */
+	for (pbus = dev->bus; pbus->parent && pbus->parent->self;
+		pbus = pbus->parent);
+
+	return pbus->self;
+}
+
+static int have_error(struct pci_dev *dev)
+{
+	u16 status;
+
+	/* check status */
+	switch (dev->hdr_type) {
+	case PCI_HEADER_TYPE_NORMAL: /* 0 */
+		pci_read_config_word(dev, PCI_STATUS, &status);
+		break;
+	case PCI_HEADER_TYPE_BRIDGE: /* 1 */
+		pci_read_config_word(dev, PCI_SEC_STATUS, &status);
+		break;
+	case PCI_HEADER_TYPE_CARDBUS: /* 2 */
+		return 0; /* FIX ME */
+	default:
+		BUG();
+	}
+
+	if ( (status & PCI_STATUS_REC_TARGET_ABORT)
+		|| (status & PCI_STATUS_REC_MASTER_ABORT)
+		|| (status & PCI_STATUS_DETECTED_PARITY) )
+		return 1;
+
+	return 0;
+}
+
+void notify_bridge_error(struct pci_dev *bridge)
+{
+	iocookie *cookie;
+
+	if (list_empty(&iochk_devices))
+		return;
+
+	/* notify error to all transactions using this host bridge */
+	if (!bridge) {
+		/* global notify, ex. MCA */
+		list_for_each_entry(cookie, &iochk_devices, list) {
+			cookie->error = 1;
+		}
+	} else {
+		/* local notify, ex. Parity, Abort etc. */
+		list_for_each_entry(cookie, &iochk_devices, list) {
+			if (cookie->host == bridge)
+				cookie->error = 1;
+		}
+	}
+}
+
+void clear_bridge_error(struct pci_dev *bridge)
+{
+	u16 status = ( PCI_STATUS_REC_TARGET_ABORT
+                     | PCI_STATUS_REC_MASTER_ABORT
+                     | PCI_STATUS_DETECTED_PARITY );
+
+	/* clear bridge status */
+	switch (bridge->hdr_type) {
+		case PCI_HEADER_TYPE_NORMAL: /* 0 */
+			pci_write_config_word(bridge, PCI_STATUS, status);
+			break;
+		case PCI_HEADER_TYPE_BRIDGE: /* 1 */
+			pci_write_config_word(bridge, PCI_SEC_STATUS, status);
+			break;
+		case PCI_HEADER_TYPE_CARDBUS: /* 2 */
+			default:
+			BUG();
+	}
+}
+
+void save_bridge_error(void)
+{
+	iocookie *cookie;
+
+	if (list_empty(&iochk_devices))
+		return;
+
+	/* mark devices if its root bus bridge have errors */
+	list_for_each_entry(cookie, &iochk_devices, list) {
+		if (cookie->error)
+			continue;
+		if (have_error(cookie->host))
+			notify_bridge_error(cookie->host);
+	}
+}
+
+EXPORT_SYMBOL(iochk_lock);
+EXPORT_SYMBOL(iochk_read);
+EXPORT_SYMBOL(iochk_clear);
+EXPORT_SYMBOL(iochk_devices);	/* for MCA driver */
Index: linux-2.6.13/include/asm-ia64/io.h
===================================================================
--- linux-2.6.13.orig/include/asm-ia64/io.h
+++ linux-2.6.13/include/asm-ia64/io.h
@@ -70,6 +70,26 @@ extern unsigned int num_io_spaces;
  #include <asm/machvec.h>
  #include <asm/page.h>
  #include <asm/system.h>
+
+#ifdef CONFIG_IOMAP_CHECK
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+/* ia64 iocookie */
+typedef struct {
+	struct list_head	list;
+	struct pci_dev		*dev;	/* target device */
+	struct pci_dev		*host;	/* hosting bridge */
+	unsigned long		error;	/* error flag */
+} iocookie;
+
+extern rwlock_t iochk_lock;  /* see arch/ia64/lib/iomap_check.c */
+
+/* Enable ia64 iochk - See arch/ia64/lib/iomap_check.c */
+#define HAVE_ARCH_IOMAP_CHECK
+
+#endif /* CONFIG_IOMAP_CHECK  */
+
  #include <asm-generic/iomap.h>

  /*
@@ -164,14 +184,23 @@ __ia64_mk_io_addr (unsigned long port)
   * during optimization, which is why we use "volatile" pointers.
   */

+#ifdef CONFIG_IOMAP_CHECK
+
+extern void ia64_mca_barrier(unsigned long value);
+
  static inline unsigned int
  ___ia64_inb (unsigned long port)
  {
  	volatile unsigned char *addr = __ia64_mk_io_addr(port);
  	unsigned char ret;
+	unsigned long flags;

+	read_lock_irqsave(&iochk_lock,flags);
  	ret = *addr;
  	__ia64_mf_a();
+	ia64_mca_barrier(ret);
+	read_unlock_irqrestore(&iochk_lock,flags);
+
  	return ret;
  }

@@ -180,9 +209,14 @@ ___ia64_inw (unsigned long port)
  {
  	volatile unsigned short *addr = __ia64_mk_io_addr(port);
  	unsigned short ret;
+	unsigned long flags;

+	read_lock_irqsave(&iochk_lock,flags);
  	ret = *addr;
  	__ia64_mf_a();
+	ia64_mca_barrier(ret);
+	read_unlock_irqrestore(&iochk_lock,flags);
+
  	return ret;
  }

@@ -191,12 +225,54 @@ ___ia64_inl (unsigned long port)
  {
  	volatile unsigned int *addr = __ia64_mk_io_addr(port);
  	unsigned int ret;
+	unsigned long flags;

+	read_lock_irqsave(&iochk_lock,flags);
  	ret = *addr;
  	__ia64_mf_a();
+	ia64_mca_barrier(ret);
+	read_unlock_irqrestore(&iochk_lock,flags);
+
  	return ret;
  }

+#else /* CONFIG_IOMAP_CHECK */
+
+static inline unsigned int
+___ia64_inb (unsigned long port)
+{
+	volatile unsigned char *addr = __ia64_mk_io_addr(port);
+	unsigned char ret;
+
+	ret = *addr;
+	__ia64_mf_a();
+	return ret;
+}
+
+static inline unsigned int
+___ia64_inw (unsigned long port)
+{
+	volatile unsigned short *addr = __ia64_mk_io_addr(port);
+	unsigned short ret;
+
+	ret = *addr;
+	__ia64_mf_a();
+	return ret;
+}
+
+static inline unsigned int
+___ia64_inl (unsigned long port)
+{
+	volatile unsigned int *addr = __ia64_mk_io_addr(port);
+	unsigned int ret;
+
+	ret = *addr;
+	__ia64_mf_a();
+	return ret;
+}
+
+#endif /* CONFIG_IOMAP_CHECK */
+
  static inline void
  ___ia64_outb (unsigned char val, unsigned long port)
  {
@@ -313,6 +389,67 @@ __outsl (unsigned long port, const void
   * a good idea).  Writes are ok though for all existing ia64 platforms (and
   * hopefully it'll stay that way).
   */
+
+#ifdef CONFIG_IOMAP_CHECK
+
+static inline unsigned char
+___ia64_readb (const volatile void __iomem *addr)
+{
+	unsigned char val;
+	unsigned long flags;
+
+	read_lock_irqsave(&iochk_lock,flags);
+	val = *(volatile unsigned char __force *)addr;
+	ia64_mca_barrier(val);
+	read_unlock_irqrestore(&iochk_lock,flags);
+
+	return val;
+}
+
+static inline unsigned short
+___ia64_readw (const volatile void __iomem *addr)
+{
+	unsigned short val;
+	unsigned long flags;
+
+	read_lock_irqsave(&iochk_lock,flags);
+	val = *(volatile unsigned short __force *)addr;
+	ia64_mca_barrier(val);
+	read_unlock_irqrestore(&iochk_lock,flags);
+
+	return val;
+}
+
+static inline unsigned int
+___ia64_readl (const volatile void __iomem *addr)
+{
+	unsigned int val;
+	unsigned long flags;
+
+	read_lock_irqsave(&iochk_lock,flags);
+	val = *(volatile unsigned int __force *) addr;
+	ia64_mca_barrier(val);
+	read_unlock_irqrestore(&iochk_lock,flags);
+
+	return val;
+}
+
+static inline unsigned long
+___ia64_readq (const volatile void __iomem *addr)
+{
+	unsigned long val;
+	unsigned long flags;
+
+	read_lock_irqsave(&iochk_lock,flags);
+	val = *(volatile unsigned long __force *) addr;
+	ia64_mca_barrier(val);
+	read_unlock_irqrestore(&iochk_lock,flags);
+
+	return val;
+}
+
+#else /* CONFIG_IOMAP_CHECK */
+
  static inline unsigned char
  ___ia64_readb (const volatile void __iomem *addr)
  {
@@ -337,6 +474,8 @@ ___ia64_readq (const volatile void __iom
  	return *(volatile unsigned long __force *) addr;
  }

+#endif /* CONFIG_IOMAP_CHECK */
+
  static inline void
  __writeb (unsigned char val, volatile void __iomem *addr)
  {
Index: linux-2.6.13/arch/ia64/kernel/mca.c
===================================================================
--- linux-2.6.13.orig/arch/ia64/kernel/mca.c
+++ linux-2.6.13/arch/ia64/kernel/mca.c
@@ -77,6 +77,13 @@
  #include <asm/irq.h>
  #include <asm/hw_irq.h>

+#ifdef CONFIG_IOMAP_CHECK
+#include <linux/pci.h>
+extern void notify_bridge_error(struct pci_dev *bridge);
+extern void save_bridge_error(void);
+extern rwlock_t iochk_lock;
+#endif
+
  #if defined(IA64_MCA_DEBUG_INFO)
  # define IA64_MCA_DEBUG(fmt...)	printk(fmt)
  #else
@@ -283,11 +290,30 @@ ia64_mca_cpe_int_handler (int cpe_irq, v
  	IA64_MCA_DEBUG("%s: received interrupt vector = %#x on CPU %d\n",
  		       __FUNCTION__, cpe_irq, smp_processor_id());

+#ifndef CONFIG_IOMAP_CHECK
+
  	/* SAL spec states this should run w/ interrupts enabled */
  	local_irq_enable();

  	/* Get the CPE error record and log it */
  	ia64_mca_log_sal_error_record(SAL_INFO_TYPE_CPE);
+#else
+	/*
+	 * Because SAL_GET_STATE_INFO for CPE might clear bridge states
+	 * in process of gathering error information from the system,
+	 * we should check the states before clearing it.
+	 * While OS and SAL are handling bridge status, we have to protect
+	 * the states from changing by any other I/Os running simultaneously,
+	 * so this should be handled w/ lock and interrupts disabled.
+	 */
+	write_lock(&iochk_lock);
+	save_bridge_error();
+	ia64_mca_log_sal_error_record(SAL_INFO_TYPE_CPE);
+	write_unlock(&iochk_lock);
+
+	/* Rests can go w/ interrupt enabled as usual */
+	local_irq_enable();
+#endif

  	spin_lock(&cpe_history_lock);
  	if (!cpe_poll_enabled && cpe_vector >= 0) {
@@ -893,6 +919,14 @@ ia64_mca_ucmc_handler(void)
  		sal_log_record_header_t *rh = IA64_LOG_CURR_BUFFER(SAL_INFO_TYPE_MCA);
  		rh->severity = sal_log_severity_corrected;
  		ia64_sal_clear_state_info(SAL_INFO_TYPE_MCA);
+
+#ifdef CONFIG_IOMAP_CHECK
+		/*
+		 * SAL already reads and clears error bits on bridge registers,
+		 * so we should have all running transactions to retry.
+		 */
+		notify_bridge_error(0);
+#endif
  	}
  	/*
  	 *  Wakeup all the processors which are spinning in the rendezvous
Index: linux-2.6.13/arch/ia64/kernel/mca_asm.S
===================================================================
--- linux-2.6.13.orig/arch/ia64/kernel/mca_asm.S
+++ linux-2.6.13/arch/ia64/kernel/mca_asm.S
@@ -16,6 +16,9 @@
  // 04/11/12 Russ Anderson <rja@sgi.com>
  //		   Added per cpu MCA/INIT stack save areas.
  //
+// 05/08/08 Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
+//		   Added ia64_mca_barrier.
+//
  #include <linux/config.h>
  #include <linux/threads.h>

@@ -944,3 +947,32 @@ END(ia64_monarch_init_handler)
  GLOBAL_ENTRY(ia64_slave_init_handler)
  1:	br.sptk 1b
  END(ia64_slave_init_handler)
+
+//EndInitHandlers//////////////////////////////////////////////////////////////
+
+#ifdef CONFIG_IOMAP_CHECK
+
+//
+// ia64_mca_barrier:
+//
+// Some I/O bridges may poison the data read, instead of signaling a BERR.
+// The consummation of poisoned data triggers a MCA, which tells us the
+// polluted address.
+// Note that the read operation by itself does not consume the bad data,
+// so we have to do something with it before it is too late.
+//
+// Calling this function forces a consumption of the passed value since
+// the compiler will have to copy it from whatever register it was in to
+// an "out" register to pass to the function.
+// To avoid possible optimization by compiler, and to make doubly sure,
+// this assenbly clearly consumes the value by moving it to r8.
+//
+// In this way, the value is guaranteed secure, not poisoned, and sanity.
+//
+
+GLOBAL_ENTRY(ia64_mca_barrier)
+	mov	r8=r32
+	br.ret.sptk.many rp
+END(ia64_mca_barrier)
+
+#endif
Index: linux-2.6.13/arch/ia64/kernel/mca_drv.c
===================================================================
--- linux-2.6.13.orig/arch/ia64/kernel/mca_drv.c
+++ linux-2.6.13/arch/ia64/kernel/mca_drv.c
@@ -35,6 +35,12 @@

  #include "mca_drv.h"

+#ifdef CONFIG_IOMAP_CHECK
+#include <linux/pci.h>
+#include <asm/io.h>
+extern struct list_head iochk_devices;
+#endif
+
  /* max size of SAL error record (default) */
  static int sal_rec_max = 10000;

@@ -377,6 +383,79 @@ is_mca_global(peidx_table_t *peidx, pal_
  	return MCA_IS_GLOBAL;
  }

+#ifdef CONFIG_IOMAP_CHECK
+
+/**
+ * get_target_identifier - get address of target_identifier
+ * @peidx:	pointer of index of processor error section
+ *
+ * Return value:
+ *	addr if valid / 0 if not valid
+ */
+static u64 get_target_identifier(peidx_table_t *peidx)
+{
+	sal_log_mod_error_info_t *smei;
+
+	smei = peidx_bus_check(peidx, 0);
+	if (smei->valid.target_identifier)
+		return (smei->target_identifier);
+	return 0;
+}
+
+/**
+ * offending_addr_in_check - Check if the addr is in checking resource.
+ * @addr:	address offending this MCA
+ *
+ * Return value:
+ *	1 if in / 0 if out
+ */
+static int offending_addr_in_check(u64 addr)
+{
+	int i;
+	struct pci_dev *tdev;
+	iocookie *cookie;
+
+	if (list_empty(&iochk_devices))
+		return 0;
+
+	list_for_each_entry(cookie, &iochk_devices, list) {
+		tdev = cookie->dev;
+		for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+		  if (tdev->resource[i].start <= addr
+		      && addr <= tdev->resource[i].end)
+			return 1;
+		  if ((tdev->resource[i].flags
+		      & (PCI_BASE_ADDRESS_SPACE|PCI_BASE_ADDRESS_MEM_TYPE_MASK))
+		      == (PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64))
+			i++;
+		}
+	}
+	return 0;
+}
+
+/**
+ * iochk_error_recovery - Check if MCA occur on transaction in iochk.
+ * @peidx:	pointer of index of processor error section
+ *
+ * Return value:
+ *	1 if error could be cought in driver / 0 if not
+ */
+static int iochk_error_recovery(peidx_table_t *peidx)
+{
+	u64 addr;
+
+	addr = get_target_identifier(peidx);
+	if (!addr)
+		return 0;
+
+	if (offending_addr_in_check(addr))
+		return 1;
+
+	return 0;
+}
+
+#endif /* CONFIG_IOMAP_CHECK */
+
  /**
   * recover_from_read_error - Try to recover the errors which type are "read"s.
   * @slidx:	pointer of index of SAL error record
@@ -445,6 +524,12 @@ recover_from_read_error(slidx_table_t *s

  	}

+#ifdef CONFIG_IOMAP_CHECK
+	/* Are there any RAS-aware drivers? */
+	if (iochk_error_recovery(peidx))
+		return 1;
+#endif
+
  	return 0;
  }



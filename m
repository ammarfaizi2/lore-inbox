Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263688AbVBCTPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbVBCTPL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 14:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVBCTNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 14:13:45 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:34489 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S263769AbVBCTIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:08:18 -0500
Subject: [PATCH] pci_raw_ops should use unsigned args
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, greg@kroah.com
Content-Type: text/plain
Date: Thu, 03 Feb 2005 12:08:05 -0700
Message-Id: <1107457685.12618.23.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert pci_raw_ops to use unsigned segment (aka domain),
bus, and devfn.  With the previous code, various ia64 config
accesses fail due to segment sign-extension problems.

ia64:
    - With a signed seg >= 0x8, unwanted sign-extension occurs when
      "seg << 28" is cast to u64 in PCI_SAL_EXT_ADDRESS()
    - PCI_SAL_EXT_ADDRESS(): cast to u64 *before* shifting; otherwise
      "seg << 28" is evaluated as unsigned int (32 bits) and gets
      truncated when seg > 0xf
    - pci_sal_read(): validate "value" ptr as other arches do
    - pci_sal_{read,write}(): return -EINVAL rather than SAL error status

 arch/i386/pci/direct.c     |   12 ++++++----
 arch/i386/pci/mmconfig.c   |    6 +++--
 arch/i386/pci/numa.c       |    6 +++--
 arch/i386/pci/pcbios.c     |    6 +++--
 arch/ia64/pci/pci.c        |   53 ++++++++++++++++++---------------------------
 arch/x86_64/pci/mmconfig.c |    8 ++++--
 include/linux/pci.h        |    6 +++--
 7 files changed, 51 insertions(+), 46 deletions(-)

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== arch/i386/pci/direct.c 1.19 vs edited =====
--- 1.19/arch/i386/pci/direct.c	2004-01-04 22:54:04 -07:00
+++ edited/arch/i386/pci/direct.c	2005-02-03 11:08:21 -07:00
@@ -13,7 +13,8 @@
 #define PCI_CONF1_ADDRESS(bus, devfn, reg) \
 	(0x80000000 | (bus << 16) | (devfn << 8) | (reg & ~3))
 
-static int pci_conf1_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
+static int pci_conf1_read(unsigned int seg, unsigned int bus,
+			  unsigned int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
@@ -41,7 +42,8 @@
 	return 0;
 }
 
-static int pci_conf1_write (int seg, int bus, int devfn, int reg, int len, u32 value)
+static int pci_conf1_write(unsigned int seg, unsigned int bus,
+			   unsigned int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
@@ -83,7 +85,8 @@
 
 #define PCI_CONF2_ADDRESS(dev, reg)	(u16)(0xC000 | (dev << 8) | reg)
 
-static int pci_conf2_read(int seg, int bus, int devfn, int reg, int len, u32 *value)
+static int pci_conf2_read(unsigned int seg, unsigned int bus,
+			  unsigned int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 	int dev, fn;
@@ -121,7 +124,8 @@
 	return 0;
 }
 
-static int pci_conf2_write (int seg, int bus, int devfn, int reg, int len, u32 value)
+static int pci_conf2_write(unsigned int seg, unsigned int bus,
+			   unsigned int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 	int dev, fn;
===== arch/i386/pci/mmconfig.c 1.5 vs edited =====
--- 1.5/arch/i386/pci/mmconfig.c	2004-11-29 12:13:05 -07:00
+++ edited/arch/i386/pci/mmconfig.c	2005-02-03 11:08:21 -07:00
@@ -34,7 +34,8 @@
 	}
 }
 
-static int pci_mmcfg_read(int seg, int bus, int devfn, int reg, int len, u32 *value)
+static int pci_mmcfg_read(unsigned int seg, unsigned int bus,
+			  unsigned int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
@@ -62,7 +63,8 @@
 	return 0;
 }
 
-static int pci_mmcfg_write(int seg, int bus, int devfn, int reg, int len, u32 value)
+static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+			   unsigned int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
===== arch/i386/pci/numa.c 1.18 vs edited =====
--- 1.18/arch/i386/pci/numa.c	2005-01-20 21:58:10 -07:00
+++ edited/arch/i386/pci/numa.c	2005-02-03 11:55:05 -07:00
@@ -14,7 +14,8 @@
 #define PCI_CONF1_MQ_ADDRESS(bus, devfn, reg) \
 	(0x80000000 | (BUS2LOCAL(bus) << 16) | (devfn << 8) | (reg & ~3))
 
-static int pci_conf1_mq_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
+static int pci_conf1_mq_read(unsigned int seg, unsigned int bus,
+			     unsigned int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
@@ -42,7 +43,8 @@
 	return 0;
 }
 
-static int pci_conf1_mq_write (int seg, int bus, int devfn, int reg, int len, u32 value)
+static int pci_conf1_mq_write(unsigned int seg, unsigned int bus,
+			      unsigned int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
===== arch/i386/pci/pcbios.c 1.18 vs edited =====
--- 1.18/arch/i386/pci/pcbios.c	2005-01-14 16:07:29 -07:00
+++ edited/arch/i386/pci/pcbios.c	2005-02-03 11:08:21 -07:00
@@ -172,7 +172,8 @@
 	return (int) (ret & 0xff00) >> 8;
 }
 
-static int pci_bios_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
+static int pci_bios_read(unsigned int seg, unsigned int bus,
+			 unsigned int devfn, int reg, int len, u32 *value)
 {
 	unsigned long result = 0;
 	unsigned long flags;
@@ -227,7 +228,8 @@
 	return (int)((result & 0xff00) >> 8);
 }
 
-static int pci_bios_write (int seg, int bus, int devfn, int reg, int len, u32 value)
+static int pci_bios_write(unsigned int seg, unsigned int bus,
+			  unsigned int devfn, int reg, int len, u32 value)
 {
 	unsigned long result = 0;
 	unsigned long flags;
===== arch/ia64/pci/pci.c 1.67 vs edited =====
--- 1.67/arch/ia64/pci/pci.c	2005-01-25 14:23:42 -07:00
+++ edited/arch/ia64/pci/pci.c	2005-02-03 11:08:22 -07:00
@@ -3,9 +3,9 @@
  *
  * Derived from bios32.c of i386 tree.
  *
- * Copyright (C) 2002 Hewlett-Packard Co
+ * (c) Copyright 2002, 2005 Hewlett-Packard Development Company, L.P.
  *	David Mosberger-Tang <davidm@hpl.hp.com>
- *	Bjorn Helgaas <bjorn_helgaas@hp.com>
+ *	Bjorn Helgaas <bjorn.helgaas@hp.com>
  * Copyright (C) 2004 Silicon Graphics, Inc.
  *
  * Note: Above list of copyright holders is incomplete...
@@ -27,26 +27,12 @@
 #include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/io.h>
-
 #include <asm/sal.h>
-
-
-#ifdef CONFIG_SMP
-# include <asm/smp.h>
-#endif
+#include <asm/smp.h>
 #include <asm/irq.h>
 #include <asm/hw_irq.h>
 
 
-#undef DEBUG
-#define DEBUG
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
-
 static int pci_routeirq;
 
 /*
@@ -55,23 +41,22 @@
  * synchronization mechanism here.
  */
 
-#define PCI_SAL_ADDRESS(seg, bus, devfn, reg)	\
-	((u64)(seg << 24) | (u64)(bus << 16) |	\
-	 (u64)(devfn << 8) | (u64)(reg))
+#define PCI_SAL_ADDRESS(seg, bus, devfn, reg)		\
+	(((u64) seg << 24) | (bus << 16) | (devfn << 8) | (reg))
 
 /* SAL 3.2 adds support for extended config space. */
 
 #define PCI_SAL_EXT_ADDRESS(seg, bus, devfn, reg)	\
-	((u64)(seg << 28) | (u64)(bus << 20) |		\
-	 (u64)(devfn << 12) | (u64)(reg))
+	(((u64) seg << 28) | (bus << 20) | (devfn << 12) | (reg))
 
 static int
-pci_sal_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
+pci_sal_read (unsigned int seg, unsigned int bus, unsigned int devfn,
+	      int reg, int len, u32 *value)
 {
-	u64 addr, mode, data = 0;
-	int result = 0;
+	u64 addr, data = 0;
+	int mode, result;
 
-	if ((seg > 65535) || (bus > 255) || (devfn > 255) || (reg > 4095))
+	if (!value || (seg > 65535) || (bus > 255) || (devfn > 255) || (reg > 4095))
 		return -EINVAL;
 
 	if ((seg | reg) <= 255) {
@@ -82,16 +67,19 @@
 		mode = 1;
 	}
 	result = ia64_sal_pci_config_read(addr, mode, len, &data);
+	if (result != 0)
+		return -EINVAL;
 
 	*value = (u32) data;
-
-	return result;
+	return 0;
 }
 
 static int
-pci_sal_write (int seg, int bus, int devfn, int reg, int len, u32 value)
+pci_sal_write (unsigned int seg, unsigned int bus, unsigned int devfn,
+	       int reg, int len, u32 value)
 {
-	u64 addr, mode;
+	u64 addr;
+	int mode, result;
 
 	if ((seg > 65535) || (bus > 255) || (devfn > 255) || (reg > 4095))
 		return -EINVAL;
@@ -103,7 +91,10 @@
 		addr = PCI_SAL_EXT_ADDRESS(seg, bus, devfn, reg);
 		mode = 1;
 	}
-	return ia64_sal_pci_config_write(addr, mode, len, value);
+	result = ia64_sal_pci_config_write(addr, mode, len, value);
+	if (result != 0)
+		return -EINVAL;
+	return 0;
 }
 
 static struct pci_raw_ops pci_sal_ops = {
===== arch/x86_64/pci/mmconfig.c 1.4 vs edited =====
--- 1.4/arch/x86_64/pci/mmconfig.c	2004-11-29 12:13:05 -07:00
+++ edited/arch/x86_64/pci/mmconfig.c	2005-02-03 11:08:22 -07:00
@@ -17,12 +17,13 @@
 /* Static virtual mapping of the MMCONFIG aperture */
 char *pci_mmcfg_virt;
 
-static inline char *pci_dev_base(int bus, int devfn)
+static inline char *pci_dev_base(unsigned int bus, unsigned int devfn)
 {
 	return pci_mmcfg_virt + ((bus << 20) | (devfn << 12));
 }
 
-static int pci_mmcfg_read(int seg, int bus, int devfn, int reg, int len, u32 *value)
+static int pci_mmcfg_read(unsigned int seg, unsigned int bus,
+			  unsigned int devfn, int reg, int len, u32 *value)
 {
 	char *addr = pci_dev_base(bus, devfn); 
 
@@ -44,7 +45,8 @@
 	return 0;
 }
 
-static int pci_mmcfg_write(int seg, int bus, int devfn, int reg, int len, u32 value)
+static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+			   unsigned int devfn, int reg, int len, u32 value)
 {
 	char *addr = pci_dev_base(bus,devfn);
 
===== include/linux/pci.h 1.148 vs edited =====
--- 1.148/include/linux/pci.h	2005-01-20 21:59:15 -07:00
+++ edited/include/linux/pci.h	2005-02-03 11:08:22 -07:00
@@ -642,8 +642,10 @@
 };
 
 struct pci_raw_ops {
-	int (*read)(int dom, int bus, int devfn, int reg, int len, u32 *val);
-	int (*write)(int dom, int bus, int devfn, int reg, int len, u32 val);
+	int (*read)(unsigned int domain, unsigned int bus, unsigned int devfn,
+		    int reg, int len, u32 *val);
+	int (*write)(unsigned int domain, unsigned int bus, unsigned int devfn,
+		     int reg, int len, u32 val);
 };
 
 extern struct pci_raw_ops *raw_pci_ops;



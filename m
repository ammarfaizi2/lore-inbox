Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVLUSnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVLUSnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVLUSnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:43:47 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:46534 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751165AbVLUSnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:43:45 -0500
Date: Wed, 21 Dec 2005 12:42:36 -0600 (CST)
From: Mark Maule <maule@sgi.com>
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, Mark Maule <maule@sgi.com>
Message-Id: <20051221184342.5003.74247.39285@attica.americas.sgi.com>
In-Reply-To: <20051221184337.5003.85653.32527@attica.americas.sgi.com>
References: <20051221184337.5003.85653.32527@attica.americas.sgi.com>
Subject: [PATCH 1/4] msi archetecture init hook
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an architecture-specific MSI setup hook (msi_arch_init()) called from 
msi_init().  For IA64, implement this as a machvec to call platform specific
code.

Signed-off-by: Mark Maule <maule@sgi.com>

Index: msi/drivers/pci/msi.c
===================================================================
--- msi.orig/drivers/pci/msi.c	2005-12-13 12:22:42.784269607 -0600
+++ msi/drivers/pci/msi.c	2005-12-19 15:34:28.427921393 -0600
@@ -367,6 +367,13 @@
 		return status;
 	}
 
+	if ((status = msi_arch_init()) < 0) {
+		pci_msi_enable = 0;
+		printk(KERN_WARNING
+		       "PCI: MSI arch init failed.  MSI disabled.\n");
+		return status;
+	}
+
 	if ((status = msi_cache_init()) < 0) {
 		pci_msi_enable = 0;
 		printk(KERN_WARNING "PCI: MSI cache init failed\n");
Index: msi/include/asm-i386/msi.h
===================================================================
--- msi.orig/include/asm-i386/msi.h	2005-12-13 12:22:42.785246074 -0600
+++ msi/include/asm-i386/msi.h	2005-12-13 16:09:49.152553259 -0600
@@ -12,4 +12,6 @@
 #define LAST_DEVICE_VECTOR		232
 #define MSI_TARGET_CPU_SHIFT	12
 
+static inline int msi_arch_init(void)	{ return 0; }
+
 #endif /* ASM_MSI_H */
Index: msi/include/asm-sparc/msi.h
===================================================================
--- msi.orig/include/asm-sparc/msi.h	2005-12-13 12:22:42.785246074 -0600
+++ msi/include/asm-sparc/msi.h	2005-12-13 16:09:49.194541334 -0600
@@ -28,4 +28,6 @@
 			      "i" (ASI_M_CTL), "r" (MSI_ASYNC_MODE) : "g3");
 }
 
+static inline int msi_arch_init(void)	{ return 0; }
+
 #endif /* !(_SPARC_MSI_H) */
Index: msi/include/asm-x86_64/msi.h
===================================================================
--- msi.orig/include/asm-x86_64/msi.h	2005-12-13 12:22:42.786222541 -0600
+++ msi/include/asm-x86_64/msi.h	2005-12-13 16:09:49.227741207 -0600
@@ -13,4 +13,6 @@
 #define LAST_DEVICE_VECTOR		232
 #define MSI_TARGET_CPU_SHIFT	12
 
+static inline int msi_arch_init(void)	{ return 0; }
+
 #endif /* ASM_MSI_H */
Index: msi/include/asm-ia64/machvec.h
===================================================================
--- msi.orig/include/asm-ia64/machvec.h	2005-12-13 12:22:42.786222541 -0600
+++ msi/include/asm-ia64/machvec.h	2005-12-13 16:09:49.247270544 -0600
@@ -74,6 +74,7 @@
 typedef unsigned short ia64_mv_readw_relaxed_t (const volatile void __iomem *);
 typedef unsigned int ia64_mv_readl_relaxed_t (const volatile void __iomem *);
 typedef unsigned long ia64_mv_readq_relaxed_t (const volatile void __iomem *);
+typedef int ia64_mv_msi_init_t (void);
 
 static inline void
 machvec_noop (void)
@@ -85,6 +86,12 @@
 {
 }
 
+static inline int
+machvec_noop_retzero (void)
+{
+	return 0;
+}
+
 extern void machvec_setup (char **);
 extern void machvec_timer_interrupt (int, void *, struct pt_regs *);
 extern void machvec_dma_sync_single (struct device *, dma_addr_t, size_t, int);
@@ -146,6 +153,7 @@
 #  define platform_readw_relaxed        ia64_mv.readw_relaxed
 #  define platform_readl_relaxed        ia64_mv.readl_relaxed
 #  define platform_readq_relaxed        ia64_mv.readq_relaxed
+#  define platform_msi_init	ia64_mv.msi_init
 # endif
 
 /* __attribute__((__aligned__(16))) is required to make size of the
@@ -194,6 +202,7 @@
 	ia64_mv_readw_relaxed_t *readw_relaxed;
 	ia64_mv_readl_relaxed_t *readl_relaxed;
 	ia64_mv_readq_relaxed_t *readq_relaxed;
+	ia64_mv_msi_init_t *msi_init;
 } __attribute__((__aligned__(16))); /* align attrib? see above comment */
 
 #define MACHVEC_INIT(name)			\
@@ -238,6 +247,7 @@
 	platform_readw_relaxed,			\
 	platform_readl_relaxed,			\
 	platform_readq_relaxed,			\
+	platform_msi_init,			\
 }
 
 extern struct ia64_machine_vector ia64_mv;
@@ -386,5 +396,8 @@
 #ifndef platform_readq_relaxed
 # define platform_readq_relaxed	__ia64_readq_relaxed
 #endif
+#ifndef platform_msi_init
+# define platform_msi_init	machvec_noop_retzero
+#endif
 
 #endif /* _ASM_IA64_MACHVEC_H */
Index: msi/include/asm-ia64/machvec_sn2.h
===================================================================
--- msi.orig/include/asm-ia64/machvec_sn2.h	2005-12-13 12:22:42.787199008 -0600
+++ msi/include/asm-ia64/machvec_sn2.h	2005-12-13 16:09:49.257035213 -0600
@@ -71,6 +71,7 @@
 extern ia64_mv_dma_sync_sg_for_device	sn_dma_sync_sg_for_device;
 extern ia64_mv_dma_mapping_error	sn_dma_mapping_error;
 extern ia64_mv_dma_supported		sn_dma_supported;
+extern ia64_mv_msi_init_t		sn_msi_init;
 
 /*
  * This stuff has dual use!
@@ -120,6 +121,7 @@
 #define platform_dma_sync_sg_for_device	sn_dma_sync_sg_for_device
 #define platform_dma_mapping_error		sn_dma_mapping_error
 #define platform_dma_supported		sn_dma_supported
+#define platform_msi_init		sn_msi_init
 
 #include <asm/sn/io.h>
 
Index: msi/include/asm-ia64/msi.h
===================================================================
--- msi.orig/include/asm-ia64/msi.h	2005-12-13 12:22:42.787199008 -0600
+++ msi/include/asm-ia64/msi.h	2005-12-13 16:09:49.268752815 -0600
@@ -14,4 +14,6 @@
 #define ack_APIC_irq		ia64_eoi
 #define MSI_TARGET_CPU_SHIFT	4
 
+static inline int msi_arch_init(void)	{ return platform_msi_init(); }
+
 #endif /* ASM_MSI_H */
Index: msi/arch/ia64/sn/pci/Makefile
===================================================================
--- msi.orig/arch/ia64/sn/pci/Makefile	2005-12-13 12:22:42.788175474 -0600
+++ msi/arch/ia64/sn/pci/Makefile	2005-12-13 16:09:49.296093887 -0600
@@ -3,8 +3,9 @@
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
 #
-# Copyright (C) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
+# Copyright (C) 2000-2005 Silicon Graphics, Inc.  All Rights Reserved.
 #
 # Makefile for the sn pci general routines.
 
 obj-y := pci_dma.o tioca_provider.o tioce_provider.o pcibr/
+obj-$(CONFIG_PCI_MSI) += msi.o
Index: msi/arch/ia64/sn/pci/msi.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ msi/arch/ia64/sn/pci/msi.c	2005-12-19 15:34:25.300296820 -0600
@@ -0,0 +1,18 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005 Silicon Graphics, Inc.  All Rights Reserved.
+ */
+
+#include <asm/errno.h>
+
+int
+sn_msi_init(void)
+{
+	/*
+	 * return error until MSI is supported on altix platforms
+	 */
+	return -EINVAL;
+}

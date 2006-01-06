Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752460AbWAFQdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbWAFQdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbWAFQaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:30:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17855 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752447AbWAFQ3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:29:49 -0500
Date: Fri, 6 Jan 2006 16:29:37 GMT
Message-Id: <200601061629.k06GTbJN011384@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 12/17] FRV: Miscellaneous changes
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes a number of miscellanous items:

 (1) Declare lock sections in the linker script.

 (2) Recurse in the correct manner in the arch makefile.

 (3) asm/bug.h requires asm/linkage.h to be included first. One C file puts
     asm/bug.h first.

 (4) Add an empty RTC header file to avoid missing header file errors.

 (5) sg_dma_address() should use the dma_address member of a scatter list.

 (6) Add trivial pci_unmap support.

 (7) Add pgprot_noncached()

 (8) Discard u_quad_t.

 (9) Use ~0UL rather than ULONG_MAX in unistd.h in case the latter isn't
     declared.

(10) Add an empty VGA header file to avoid missing header file errors.

(11) Add an XOR header file to use the generic XOR stuff.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-misc-2615.diff
 arch/frv/Makefile             |    6 +++---
 arch/frv/kernel/vmlinux.lds.S |    1 +
 include/asm-frv/bug.h         |    1 +
 include/asm-frv/dma-mapping.h |    2 +-
 include/asm-frv/mc146818rtc.h |   16 ++++++++++++++++
 include/asm-frv/pci.h         |    8 ++++++++
 include/asm-frv/pgtable.h     |    5 +++++
 include/asm-frv/types.h       |    1 -
 include/asm-frv/unistd.h      |    2 +-
 include/asm-frv/vga.h         |   17 +++++++++++++++++
 include/asm-frv/xor.h         |    1 +
 11 files changed, 54 insertions(+), 6 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/kernel/vmlinux.lds.S linux-2.6.15-frv/arch/frv/kernel/vmlinux.lds.S
--- /warthog/kernels/linux-2.6.15/arch/frv/kernel/vmlinux.lds.S	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/kernel/vmlinux.lds.S	2006-01-06 14:43:43.000000000 +0000
@@ -112,6 +112,7 @@ SECTIONS
 #endif
 	)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	*(.exitcall.exit)
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/Makefile linux-2.6.15-frv/arch/frv/Makefile
--- /warthog/kernels/linux-2.6.15/arch/frv/Makefile	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/Makefile	2006-01-06 14:43:43.000000000 +0000
@@ -109,10 +109,10 @@ bootstrap:
 	$(Q)$(MAKEBOOT) bootstrap
 
 archmrproper:
-	$(Q)$(MAKE) -C arch/frv/boot mrproper
+	$(Q)$(MAKE) $(build)=arch/frv/boot mrproper
 
 archclean:
-	$(Q)$(MAKE) -C arch/frv/boot clean
+	$(Q)$(MAKE) $(build)=arch/frv/boot clean
 
 archdep: scripts/mkdep symlinks
-	$(Q)$(MAKE) -C arch/frv/boot dep
+	$(Q)$(MAKE) $(build)=arch/frv/boot dep
diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/bug.h linux-2.6.15-frv/include/asm-frv/bug.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/bug.h	2005-06-22 13:52:26.000000000 +0100
+++ linux-2.6.15-frv/include/asm-frv/bug.h	2006-01-06 14:43:43.000000000 +0000
@@ -12,6 +12,7 @@
 #define _ASM_BUG_H
 
 #include <linux/config.h>
+#include <linux/linkage.h>
 
 #ifdef CONFIG_BUG
 /*
diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/mc146818rtc.h linux-2.6.15-frv/include/asm-frv/mc146818rtc.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/mc146818rtc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-frv/include/asm-frv/mc146818rtc.h	2006-01-06 14:43:43.000000000 +0000
@@ -0,0 +1,16 @@
+/* mc146818rtc.h: RTC defs
+ *
+ * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_MC146818RTC_H
+#define _ASM_MC146818RTC_H
+
+
+#endif /* _ASM_MC146818RTC_H */
diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/dma-mapping.h linux-2.6.15-frv/include/asm-frv/dma-mapping.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/dma-mapping.h	2006-01-04 12:39:38.000000000 +0000
+++ linux-2.6.15-frv/include/asm-frv/dma-mapping.h	2006-01-06 14:43:43.000000000 +0000
@@ -23,7 +23,7 @@ void dma_free_coherent(struct device *de
  * returns, or alternatively stop on the first sg_dma_len(sg) which
  * is 0.
  */
-#define sg_dma_address(sg)	((unsigned long) (page_to_phys((sg)->page) + (sg)->offset))
+#define sg_dma_address(sg)	((sg)->dma_address)
 #define sg_dma_len(sg)		((sg)->length)
 
 /*
diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/pci.h linux-2.6.15-frv/include/asm-frv/pci.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/pci.h	2006-01-04 12:39:38.000000000 +0000
+++ linux-2.6.15-frv/include/asm-frv/pci.h	2006-01-06 14:43:43.000000000 +0000
@@ -57,6 +57,14 @@ extern void pci_free_consistent(struct p
  */
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
+/* pci_unmap_{page,single} is a nop so... */
+#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
+#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)
+#define pci_unmap_addr(PTR, ADDR_NAME)		(0)
+#define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)	do { } while (0)
+#define pci_unmap_len(PTR, LEN_NAME)		(0)
+#define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
+
 #ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/pgtable.h linux-2.6.15-frv/include/asm-frv/pgtable.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/pgtable.h	2006-01-04 12:39:38.000000000 +0000
+++ linux-2.6.15-frv/include/asm-frv/pgtable.h	2006-01-06 14:43:43.000000000 +0000
@@ -421,6 +421,11 @@ static inline void ptep_set_wrprotect(st
 }
 
 /*
+ * Macro to mark a page protection value as "uncacheable"
+ */
+#define pgprot_noncached(prot) (__pgprot(pgprot_val(prot) | _PAGE_NOCACHE))
+
+/*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  */
diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/types.h linux-2.6.15-frv/include/asm-frv/types.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/types.h	2005-11-01 13:19:17.000000000 +0000
+++ linux-2.6.15-frv/include/asm-frv/types.h	2006-01-06 14:43:43.000000000 +0000
@@ -59,7 +59,6 @@ typedef unsigned int u32;
 
 typedef signed long long s64;
 typedef unsigned long long u64;
-typedef u64 u_quad_t;
 
 /* Dma addresses are 32-bits wide.  */
 
diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/unistd.h linux-2.6.15-frv/include/asm-frv/unistd.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/unistd.h	2005-06-22 13:52:26.000000000 +0100
+++ linux-2.6.15-frv/include/asm-frv/unistd.h	2006-01-06 14:43:43.000000000 +0000
@@ -313,7 +313,7 @@ do {									\
         unsigned long __sr2 = (res);					\
 	if (__builtin_expect(__sr2 >= (unsigned long)(-4095), 0)) {	\
 		errno = (-__sr2);					\
-		__sr2 = ULONG_MAX;					\
+		__sr2 = ~0UL;						\
 	}								\
 	return (type) __sr2;						\
 } while (0)
diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/vga.h linux-2.6.15-frv/include/asm-frv/vga.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/vga.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-frv/include/asm-frv/vga.h	2006-01-06 14:43:43.000000000 +0000
@@ -0,0 +1,17 @@
+/* vga.h: VGA register stuff
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_VGA_H
+#define _ASM_VGA_H
+
+
+
+#endif /* _ASM_VGA_H */
diff -uNrp /warthog/kernels/linux-2.6.15/include/asm-frv/xor.h linux-2.6.15-frv/include/asm-frv/xor.h
--- /warthog/kernels/linux-2.6.15/include/asm-frv/xor.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-frv/include/asm-frv/xor.h	2006-01-06 14:43:43.000000000 +0000
@@ -0,0 +1 @@
+#include <asm-generic/xor.h>

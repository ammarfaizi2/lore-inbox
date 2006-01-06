Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752451AbWAFQdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbWAFQdE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbWAFQaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:30:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41407 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752458AbWAFQaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:30:06 -0500
Date: Fri, 6 Jan 2006 16:29:35 GMT
Message-Id: <200601061629.k06GTZJO011367@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 4/17] FRV: Implement and export various things required by modules
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch exports a number of features required to build all the
modules. It also implements the following simple features:

 (*) csum_partial_copy_from_user() for MMU as well as no-MMU.

 (*) __ucmpdi2().

so that they can be exported too.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-exports-2615.diff
 arch/frv/kernel/frv_ksyms.c           |   25 +++++++++++++-----
 arch/frv/kernel/irq.c                 |   17 ++++++++++++
 arch/frv/kernel/pm.c                  |    2 +
 arch/frv/kernel/time.c                |    3 ++
 arch/frv/kernel/traps.c               |    3 ++
 arch/frv/kernel/uaccess.c             |    7 +++++
 arch/frv/lib/Makefile                 |    2 -
 arch/frv/lib/__ucmpdi2.S              |   45 ++++++++++++++++++++++++++++++++++
 arch/frv/lib/checksum.c               |   31 ++++++++++++++++++-----
 arch/frv/mb93090-mb00/pci-dma-nommu.c |    8 ++++++
 arch/frv/mb93090-mb00/pci-dma.c       |   10 +++++++
 arch/frv/mm/cache-page.c              |    5 +++
 arch/frv/mm/highmem.c                 |    8 ++++++
 lib/find_next_bit.c                   |    3 ++
 14 files changed, 155 insertions(+), 14 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/kernel/frv_ksyms.c linux-2.6.15-frv/arch/frv/kernel/frv_ksyms.c
--- /warthog/kernels/linux-2.6.15/arch/frv/kernel/frv_ksyms.c	2005-11-01 13:18:57.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/kernel/frv_ksyms.c	2006-01-06 14:43:43.000000000 +0000
@@ -16,10 +16,11 @@
 #include <asm/semaphore.h>
 #include <asm/checksum.h>
 #include <asm/hardirq.h>
-#include <asm/current.h>
+#include <asm/cacheflush.h>
 
 extern void dump_thread(struct pt_regs *, struct user *);
 extern long __memcpy_user(void *dst, const void *src, size_t count);
+extern long __memset_user(void *dst, const void *src, size_t count);
 
 /* platform dependent support */
 
@@ -50,7 +51,11 @@ EXPORT_SYMBOL(disable_irq);
 EXPORT_SYMBOL(__res_bus_clock_speed_HZ);
 EXPORT_SYMBOL(__page_offset);
 EXPORT_SYMBOL(__memcpy_user);
-EXPORT_SYMBOL(flush_dcache_page);
+EXPORT_SYMBOL(__memset_user);
+EXPORT_SYMBOL(frv_dcache_writeback);
+EXPORT_SYMBOL(frv_cache_invalidate);
+EXPORT_SYMBOL(frv_icache_invalidate);
+EXPORT_SYMBOL(frv_cache_wback_inv);
 
 #ifndef CONFIG_MMU
 EXPORT_SYMBOL(memory_start);
@@ -72,6 +77,9 @@ EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(memmove);
 
+EXPORT_SYMBOL(__outsl_ns);
+EXPORT_SYMBOL(__insl_ns);
+
 EXPORT_SYMBOL(get_wchan);
 
 #ifdef CONFIG_FRV_OUTOFLINE_ATOMIC_OPS
@@ -80,14 +88,13 @@ EXPORT_SYMBOL(atomic_test_and_OR_mask);
 EXPORT_SYMBOL(atomic_test_and_XOR_mask);
 EXPORT_SYMBOL(atomic_add_return);
 EXPORT_SYMBOL(atomic_sub_return);
-EXPORT_SYMBOL(__xchg_8);
-EXPORT_SYMBOL(__xchg_16);
 EXPORT_SYMBOL(__xchg_32);
-EXPORT_SYMBOL(__cmpxchg_8);
-EXPORT_SYMBOL(__cmpxchg_16);
 EXPORT_SYMBOL(__cmpxchg_32);
 #endif
 
+EXPORT_SYMBOL(__debug_bug_printk);
+EXPORT_SYMBOL(__delay_loops_MHz);
+
 /*
  * libgcc functions - functions that are used internally by the
  * compiler...  (prototypes are not correct though, but that
@@ -101,6 +108,8 @@ extern void __divdi3(void);
 extern void __lshrdi3(void);
 extern void __moddi3(void);
 extern void __muldi3(void);
+extern void __mulll(void);
+extern void __umulll(void);
 extern void __negdi2(void);
 extern void __ucmpdi2(void);
 extern void __udivdi3(void);
@@ -116,8 +125,10 @@ EXPORT_SYMBOL(__ashrdi3);
 EXPORT_SYMBOL(__lshrdi3);
 //EXPORT_SYMBOL(__moddi3);
 EXPORT_SYMBOL(__muldi3);
+EXPORT_SYMBOL(__mulll);
+EXPORT_SYMBOL(__umulll);
 EXPORT_SYMBOL(__negdi2);
-//EXPORT_SYMBOL(__ucmpdi2);
+EXPORT_SYMBOL(__ucmpdi2);
 //EXPORT_SYMBOL(__udivdi3);
 //EXPORT_SYMBOL(__udivmoddi4);
 //EXPORT_SYMBOL(__umoddi3);
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/kernel/irq.c linux-2.6.15-frv/arch/frv/kernel/irq.c
--- /warthog/kernels/linux-2.6.15/arch/frv/kernel/irq.c	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/kernel/irq.c	2006-01-06 14:43:43.000000000 +0000
@@ -32,6 +32,7 @@
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/module.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -178,6 +179,8 @@ void disable_irq_nosync(unsigned int irq
 	spin_unlock_irqrestore(&level->lock, flags);
 }
 
+EXPORT_SYMBOL(disable_irq_nosync);
+
 /**
  *	disable_irq - disable an irq and wait for completion
  *	@irq: Interrupt to disable
@@ -204,6 +207,8 @@ void disable_irq(unsigned int irq)
 #endif
 }
 
+EXPORT_SYMBOL(disable_irq);
+
 /**
  *	enable_irq - enable handling of an irq
  *	@irq: Interrupt to enable
@@ -268,6 +273,8 @@ void enable_irq(unsigned int irq)
 	spin_unlock_irqrestore(&level->lock, flags);
 }
 
+EXPORT_SYMBOL(enable_irq);
+
 /*****************************************************************************/
 /*
  * handles all normal device IRQ's
@@ -425,6 +432,8 @@ int request_irq(unsigned int irq,
 	return retval;
 }
 
+EXPORT_SYMBOL(request_irq);
+
 /**
  *	free_irq - free an interrupt
  *	@irq: Interrupt line to free
@@ -496,6 +505,8 @@ void free_irq(unsigned int irq, void *de
 	}
 }
 
+EXPORT_SYMBOL(free_irq);
+
 /*
  * IRQ autodetection code..
  *
@@ -519,6 +530,8 @@ unsigned long probe_irq_on(void)
 	return 0;
 }
 
+EXPORT_SYMBOL(probe_irq_on);
+
 /*
  * Return a mask of triggered interrupts (this
  * can handle only legacy ISA interrupts).
@@ -542,6 +555,8 @@ unsigned int probe_irq_mask(unsigned lon
 	return 0;
 }
 
+EXPORT_SYMBOL(probe_irq_mask);
+
 /*
  * Return the one interrupt that triggered (this can
  * handle any interrupt source).
@@ -571,6 +586,8 @@ int probe_irq_off(unsigned long xmask)
 	return -1;
 }
 
+EXPORT_SYMBOL(probe_irq_off);
+
 /* this was setup_x86_irq but it seems pretty generic */
 int setup_irq(unsigned int irq, struct irqaction *new)
 {
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/kernel/pm.c linux-2.6.15-frv/arch/frv/kernel/pm.c
--- /warthog/kernels/linux-2.6.15/arch/frv/kernel/pm.c	2006-01-04 12:39:18.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/kernel/pm.c	2006-01-06 14:43:43.000000000 +0000
@@ -13,6 +13,7 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/pm_legacy.h>
 #include <linux/sched.h>
@@ -27,6 +28,7 @@
 #include "local.h"
 
 void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
 
 extern void frv_change_cmode(int);
 
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/kernel/time.c linux-2.6.15-frv/arch/frv/kernel/time.c
--- /warthog/kernels/linux-2.6.15/arch/frv/kernel/time.c	2006-01-04 12:39:18.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/kernel/time.c	2006-01-06 14:43:43.000000000 +0000
@@ -189,6 +189,8 @@ void do_gettimeofday(struct timeval *tv)
 	tv->tv_usec = usec;
 }
 
+EXPORT_SYMBOL(do_gettimeofday);
+
 int do_settimeofday(struct timespec *tv)
 {
 	time_t wtm_sec, sec = tv->tv_sec;
@@ -218,6 +220,7 @@ int do_settimeofday(struct timespec *tv)
 	clock_was_set();
 	return 0;
 }
+
 EXPORT_SYMBOL(do_settimeofday);
 
 /*
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/kernel/traps.c linux-2.6.15-frv/arch/frv/kernel/traps.c
--- /warthog/kernels/linux-2.6.15/arch/frv/kernel/traps.c	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/kernel/traps.c	2006-01-06 14:43:43.000000000 +0000
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <linux/module.h>
 
 #include <asm/setup.h>
 #include <asm/fpu.h>
@@ -250,6 +251,8 @@ void dump_stack(void)
 	show_stack(NULL, NULL);
 }
 
+EXPORT_SYMBOL(dump_stack);
+
 void show_stack(struct task_struct *task, unsigned long *sp)
 {
 }
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/kernel/uaccess.c linux-2.6.15-frv/arch/frv/kernel/uaccess.c
--- /warthog/kernels/linux-2.6.15/arch/frv/kernel/uaccess.c	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/kernel/uaccess.c	2006-01-06 14:43:43.000000000 +0000
@@ -10,6 +10,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <asm/uaccess.h>
 
 /*****************************************************************************/
@@ -58,8 +59,11 @@ long strncpy_from_user(char *dst, const 
 		memset(p, 0, count); /* clear remainder of buffer [security] */
 
 	return err;
+
 } /* end strncpy_from_user() */
 
+EXPORT_SYMBOL(strncpy_from_user);
+
 /*****************************************************************************/
 /*
  * Return the size of a string (including the ending 0)
@@ -92,4 +96,7 @@ long strnlen_user(const char *src, long 
 	}
 
 	return p - src + 1; /* return length including NUL */
+
 } /* end strnlen_user() */
+
+EXPORT_SYMBOL(strnlen_user);
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/lib/checksum.c linux-2.6.15-frv/arch/frv/lib/checksum.c
--- /warthog/kernels/linux-2.6.15/arch/frv/lib/checksum.c	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/lib/checksum.c	2006-01-06 14:43:43.000000000 +0000
@@ -33,6 +33,7 @@
 
 #include <net/checksum.h>
 #include <asm/checksum.h>
+#include <linux/module.h>
 
 static inline unsigned short from32to16(unsigned long x)
 {
@@ -115,34 +116,52 @@ unsigned int csum_partial(const unsigned
 	return result;
 }
 
+EXPORT_SYMBOL(csum_partial);
+
 /*
  * this routine is used for miscellaneous IP-like checksums, mainly
  * in icmp.c
  */
 unsigned short ip_compute_csum(const unsigned char * buff, int len)
 {
-	return ~do_csum(buff,len);
+	return ~do_csum(buff, len);
 }
 
+EXPORT_SYMBOL(ip_compute_csum);
+
 /*
  * copy from fs while checksumming, otherwise like csum_partial
  */
-
 unsigned int
-csum_partial_copy_from_user(const char *src, char *dst, int len, int sum, int *csum_err)
+csum_partial_copy_from_user(const char __user *src, char *dst,
+			    int len, int sum, int *csum_err)
 {
-	if (csum_err) *csum_err = 0;
-	memcpy(dst, src, len);
+	int rem;
+
+	if (csum_err)
+		*csum_err = 0;
+
+	rem = copy_from_user(dst, src, len);
+	if (rem != 0) {
+		if (csum_err)
+			*csum_err = -EFAULT;
+		memset(dst + len - rem, 0, rem);
+		len = rem;
+	}
+
 	return csum_partial(dst, len, sum);
 }
 
+EXPORT_SYMBOL(csum_partial_copy_from_user);
+
 /*
  * copy from ds while checksumming, otherwise like csum_partial
  */
-
 unsigned int
 csum_partial_copy(const char *src, char *dst, int len, int sum)
 {
 	memcpy(dst, src, len);
 	return csum_partial(dst, len, sum);
 }
+
+EXPORT_SYMBOL(csum_partial_copy);
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/lib/Makefile linux-2.6.15-frv/arch/frv/lib/Makefile
--- /warthog/kernels/linux-2.6.15/arch/frv/lib/Makefile	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/lib/Makefile	2006-01-06 14:43:43.000000000 +0000
@@ -3,6 +3,6 @@
 #
 
 lib-y := \
-	__ashldi3.o __lshrdi3.o __muldi3.o __ashrdi3.o __negdi2.o \
+	__ashldi3.o __lshrdi3.o __muldi3.o __ashrdi3.o __negdi2.o __ucmpdi2.o \
 	checksum.o memcpy.o memset.o atomic-ops.o \
 	outsl_ns.o outsl_sw.o insl_ns.o insl_sw.o cache.o
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/lib/__ucmpdi2.S linux-2.6.15-frv/arch/frv/lib/__ucmpdi2.S
--- /warthog/kernels/linux-2.6.15/arch/frv/lib/__ucmpdi2.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-frv/arch/frv/lib/__ucmpdi2.S	2006-01-06 14:43:43.000000000 +0000
@@ -0,0 +1,45 @@
+/* __ucmpdi2.S: 64-bit unsigned compare
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
+
+        .text
+        .p2align	4
+
+###############################################################################
+#
+# int __ucmpdi2(unsigned long long a [GR8:GR9],
+#		unsigned long long b [GR10:GR11])
+#
+# - returns 0, 1, or 2 as a <, =, > b respectively.
+#
+###############################################################################
+        .globl		__ucmpdi2
+        .type		__ucmpdi2,@function
+__ucmpdi2:
+	or.p		gr8,gr0,gr4
+	subcc		gr8,gr10,gr0,icc0
+	setlos.p	#0,gr8
+	bclr		icc0,#2			; a.msw < b.msw
+
+	setlos.p	#2,gr8
+	bhilr		icc0,#0			; a.msw > b.msw
+
+	subcc.p		gr9,gr11,gr0,icc1
+	setlos		#0,gr8
+	setlos.p	#2,gr9
+	setlos		#1,gr7
+	cknc		icc1,cc6
+	cor.p		gr9,gr0,gr8,		cc6,#1
+	cckls		icc1,cc4,		cc6,#1
+	andcr		cc6,cc4,cc4
+	cor		gr7,gr0,gr8,		cc4,#1
+	bralr
+	.size		__ucmpdi2, .-__ucmpdi2
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/mb93090-mb00/pci-dma.c linux-2.6.15-frv/arch/frv/mb93090-mb00/pci-dma.c
--- /warthog/kernels/linux-2.6.15/arch/frv/mb93090-mb00/pci-dma.c	2006-01-04 12:39:18.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/mb93090-mb00/pci-dma.c	2006-01-06 14:43:43.000000000 +0000
@@ -28,11 +28,15 @@ void *dma_alloc_coherent(struct device *
 	return ret;
 }
 
+EXPORT_SYMBOL(dma_alloc_coherent);
+
 void dma_free_coherent(struct device *hwdev, size_t size, void *vaddr, dma_addr_t dma_handle)
 {
 	consistent_free(vaddr);
 }
 
+EXPORT_SYMBOL(dma_free_coherent);
+
 /*
  * Map a single buffer of the indicated size for DMA in streaming mode.
  * The 32-bit bus address to use is returned.
@@ -51,6 +55,8 @@ dma_addr_t dma_map_single(struct device 
 	return virt_to_bus(ptr);
 }
 
+EXPORT_SYMBOL(dma_map_single);
+
 /*
  * Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scather-gather version of the
@@ -96,6 +102,8 @@ int dma_map_sg(struct device *dev, struc
 	return nents;
 }
 
+EXPORT_SYMBOL(dma_map_sg);
+
 dma_addr_t dma_map_page(struct device *dev, struct page *page, unsigned long offset,
 			size_t size, enum dma_data_direction direction)
 {
@@ -103,3 +111,5 @@ dma_addr_t dma_map_page(struct device *d
 	flush_dcache_page(page);
 	return (dma_addr_t) page_to_phys(page) + offset;
 }
+
+EXPORT_SYMBOL(dma_map_page);
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/mb93090-mb00/pci-dma-nommu.c linux-2.6.15-frv/arch/frv/mb93090-mb00/pci-dma-nommu.c
--- /warthog/kernels/linux-2.6.15/arch/frv/mb93090-mb00/pci-dma-nommu.c	2006-01-04 12:39:18.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/mb93090-mb00/pci-dma-nommu.c	2006-01-06 14:43:43.000000000 +0000
@@ -83,6 +83,8 @@ void *dma_alloc_coherent(struct device *
 	return NULL;
 }
 
+EXPORT_SYMBOL(dma_alloc_coherent);
+
 void dma_free_coherent(struct device *hwdev, size_t size, void *vaddr, dma_addr_t dma_handle)
 {
 	struct dma_alloc_record *rec;
@@ -102,6 +104,8 @@ void dma_free_coherent(struct device *hw
 	BUG();
 }
 
+EXPORT_SYMBOL(dma_free_coherent);
+
 /*
  * Map a single buffer of the indicated size for DMA in streaming mode.
  * The 32-bit bus address to use is returned.
@@ -120,6 +124,8 @@ dma_addr_t dma_map_single(struct device 
 	return virt_to_bus(ptr);
 }
 
+EXPORT_SYMBOL(dma_map_single);
+
 /*
  * Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scather-gather version of the
@@ -150,3 +156,5 @@ int dma_map_sg(struct device *dev, struc
 
 	return nents;
 }
+
+EXPORT_SYMBOL(dma_map_sg);
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/mm/cache-page.c linux-2.6.15-frv/arch/frv/mm/cache-page.c
--- /warthog/kernels/linux-2.6.15/arch/frv/mm/cache-page.c	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/mm/cache-page.c	2006-01-06 14:43:43.000000000 +0000
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/module.h>
 #include <asm/pgalloc.h>
 
 /*****************************************************************************/
@@ -38,6 +39,8 @@ void flush_dcache_page(struct page *page
 
 } /* end flush_dcache_page() */
 
+EXPORT_SYMBOL(flush_dcache_page);
+
 /*****************************************************************************/
 /*
  * ICI takes a virtual address and the page may not currently have one
@@ -64,3 +67,5 @@ void flush_icache_user_range(struct vm_a
 	}
 
 } /* end flush_icache_user_range() */
+
+EXPORT_SYMBOL(flush_icache_user_range);
diff -uNrp /warthog/kernels/linux-2.6.15/arch/frv/mm/highmem.c linux-2.6.15-frv/arch/frv/mm/highmem.c
--- /warthog/kernels/linux-2.6.15/arch/frv/mm/highmem.c	2005-03-02 12:07:44.000000000 +0000
+++ linux-2.6.15-frv/arch/frv/mm/highmem.c	2006-01-06 14:43:43.000000000 +0000
@@ -9,6 +9,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 #include <linux/highmem.h>
+#include <linux/module.h>
 
 void *kmap(struct page *page)
 {
@@ -18,6 +19,8 @@ void *kmap(struct page *page)
 	return kmap_high(page);
 }
 
+EXPORT_SYMBOL(kmap);
+
 void kunmap(struct page *page)
 {
 	if (in_interrupt())
@@ -27,7 +30,12 @@ void kunmap(struct page *page)
 	kunmap_high(page);
 }
 
+EXPORT_SYMBOL(kunmap);
+
 struct page *kmap_atomic_to_page(void *ptr)
 {
 	return virt_to_page(ptr);
 }
+
+
+EXPORT_SYMBOL(kmap_atomic_to_page);
diff -uNrp /warthog/kernels/linux-2.6.15/lib/find_next_bit.c linux-2.6.15-frv/lib/find_next_bit.c
--- /warthog/kernels/linux-2.6.15/lib/find_next_bit.c	2005-03-02 12:09:02.000000000 +0000
+++ linux-2.6.15-frv/lib/find_next_bit.c	2006-01-06 14:43:43.000000000 +0000
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/module.h>
 
 int find_next_bit(const unsigned long *addr, int size, int offset)
 {
@@ -53,3 +54,5 @@ int find_next_bit(const unsigned long *a
 
 	return offset;
 }
+
+EXPORT_SYMBOL(find_next_bit);

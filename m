Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVELVoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVELVoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVELVoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:44:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46036 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262142AbVELVlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:41:24 -0400
Date: Thu, 12 May 2005 17:41:18 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, tripperda@nvidia.com
Subject: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86 MTRR handling
Message-ID: <20050512214118.GA25065@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, ak@suse.de, tripperda@nvidia.com
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512161825.GC17618@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 12:18:26PM -0400, Dave Jones wrote:

 > Whilst your changes may have merit, I'd much rather see effort spent
 > on getting PAT into shape than further massaging MTRR.  Its well past its
 > smell-by-date, and theres been no activity whatsoever afaik on getting
 > Terrence Ripperda's cachemap stuff beaten into shape.
 > 
 > I'll dust off the last version he sent and diff against latest-mm later
 > so it can get some more commentary. It seems everyone is in violent
 > agreement that we want PAT support, but nothing seems to happen.

I rediffed the last version of Terrence's patch that I could find
(from 2.6.4), and fixed up some API changes (PCI changes), and
some obvious codingstyle nits. (no doubt I've missed some, but
lets concentrate on the more important things first eh?)

It compiles on i386, but I've done no runtime testing yet.

Obvious things that jump out at me.

: x86-64 will need updating to also take advantage of this.
  It may be able to just copy the i386 includes as-is, I've
  not looked closely at the PAT related changes on x86-64 yet. Andi?

: The list manipulation macros in mm/cachemap.c are a little fugly.

Anything else ?

		Dave


diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/arch/i386/kernel/cpu/common.c 2.6-mm-cachemap/arch/i386/kernel/cpu/common.c
--- 2.6-mm/arch/i386/kernel/cpu/common.c	2005-05-12 16:15:30.000000000 -0400
+++ 2.6-mm-cachemap/arch/i386/kernel/cpu/common.c	2005-05-12 16:08:14.000000000 -0400
@@ -10,6 +10,9 @@
 #include <asm/msr.h>
 #include <asm/io.h>
 #include <asm/mmu_context.h>
+#include <asm/pat.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/mpspec.h>
 #include <asm/apic.h>
@@ -315,6 +318,48 @@ static int __init x86_serial_nr_setup(ch
 }
 __setup("serialnumber", x86_serial_nr_setup);
 
+static atomic_t pat_cpus_enabled = ATOMIC_INIT(0);
+
+static void __init setup_pat(void)
+{
+	unsigned long flags = 0, cr4val = 0, cr0val = 0;
+
+	if (!cpu_has_pat)
+		return;
+
+	local_save_flags(flags);
+	local_irq_disable();
+	if (cpu_has_pge) {
+		cr4val = read_cr4();
+		write_cr4(cr4val & (unsigned char) ~(1 << 7));
+	}
+	cr0val = read_cr0() | (1 << 30);
+	wbinvd();
+	write_cr0(cr0val);
+	wbinvd();
+	/* Okay everything is ready */
+
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		wrmsr(IA32_CR_PAT, AMD_PAT_31_0, AMD_PAT_63_32);
+		atomic_inc(&pat_cpus_enabled);
+		break;
+	case X86_VENDOR_INTEL:
+		wrmsr(IA32_CR_PAT, INTEL_PAT_31_0, INTEL_PAT_63_32);
+		atomic_inc(&pat_cpus_enabled);
+		break;
+	default:
+		printk("Unknown vendor in setup_pat()\n");
+	}
+
+	/* Reenable the caches */
+	wbinvd();
+	write_cr0(read_cr0() & ~(1 << 30));
+	if (cpu_has_pge)
+		write_cr4(cr4val);
+
+	local_irq_restore(flags);
+}
 
 
 /*
@@ -431,6 +476,8 @@ void __devinit identify_cpu(struct cpuin
 	if (c == &boot_cpu_data)
 		sysenter_setup();
 	enable_sep_cpu();
+
+	setup_pat();
 }
 
 #ifdef CONFIG_X86_HT
@@ -659,3 +706,36 @@ void __devinit cpu_uninit(void)
 	per_cpu(cpu_tlbstate, cpu).active_mm = &init_mm;
 }
 #endif
+
+int cpu_supports_wrcomb(void)
+{
+	struct pci_dev *dev;
+
+	/* checks copied from arch/i386/kernel/cpu/mtrr/main.c */
+	/* do these only apply to mtrrs or pat as well? */
+	dev = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
+					PCI_DEVICE_ID_SERVERWORKS_LE, NULL);
+	if (dev) {
+		printk(KERN_INFO
+			"mtrr: Serverworks LE detected. Write-combining disabled.\n");
+			return 0;
+	}
+	/* Intel 450NX errata # 23. Non ascending cachline evictions to
+	write combining memory may resulting in data corruption */
+	dev = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82451NX, NULL);
+	if (dev) {
+		printk(KERN_INFO
+			"mtrr: Intel 450NX MMC detected. Write-combining disabled.\n");
+		return 0;
+	}
+
+	if (cpu_has_pat) {
+		if (atomic_read(&pat_cpus_enabled) != num_online_cpus()) {
+			printk("not all cpus have pat enabled?\n");
+			BUG();
+		}
+		return 1;
+	}
+	return 0;
+}
+
diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/arch/i386/kernel/cpu/mtrr/generic.c 2.6-mm-cachemap/arch/i386/kernel/cpu/mtrr/generic.c
--- 2.6-mm/arch/i386/kernel/cpu/mtrr/generic.c	2005-05-12 16:15:31.000000000 -0400
+++ 2.6-mm-cachemap/arch/i386/kernel/cpu/mtrr/generic.c	2005-05-12 16:03:02.000000000 -0400
@@ -3,6 +3,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/cachemap.h>
 #include <asm/io.h>
 #include <asm/mtrr.h>
 #include <asm/msr.h>
@@ -27,6 +28,20 @@ get_mtrr_var_range(unsigned int index, s
 {
 	rdmsr(MTRRphysBase_MSR(index), vr->base_lo, vr->base_hi);
 	rdmsr(MTRRphysMask_MSR(index), vr->mask_lo, vr->mask_hi);
+
+	if (vr->mask_lo & 0x800) {
+		unsigned long start, size;
+
+		size =
+		    -(size_or_mask | vr->mask_hi << (32 - PAGE_SHIFT) | vr->
+		      mask_lo >> PAGE_SHIFT);
+		start =
+		    vr->base_hi << (32 -
+				    PAGE_SHIFT) | vr->base_lo >> PAGE_SHIFT;
+
+		cmap_report_range(start << PAGE_SHIFT, size << PAGE_SHIFT,
+			cmap_convert_mtrr_type(vr->base_lo & 0xff));
+	}
 }
 
 static void __init
diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/arch/i386/kernel/cpu/mtrr/main.c 2.6-mm-cachemap/arch/i386/kernel/cpu/mtrr/main.c
--- 2.6-mm/arch/i386/kernel/cpu/mtrr/main.c	2005-05-12 16:15:31.000000000 -0400
+++ 2.6-mm-cachemap/arch/i386/kernel/cpu/mtrr/main.c	2005-05-12 16:03:02.000000000 -0400
@@ -36,6 +36,7 @@
 #include <linux/pci.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
+#include <linux/cachemap.h>
 
 #include <asm/mtrr.h>
 
@@ -365,6 +366,8 @@ int mtrr_add_page(unsigned long base, un
 	/*  Search for an empty MTRR  */
 	i = mtrr_if->get_free_region(base, size);
 	if (i >= 0) {
+		cmap_report_range(base<<PAGE_SHIFT, size<<PAGE_SHIFT,
+			cmap_convert_mtrr_type(type));
 		set_mtrr(i, base, size, type);
 		usage_table[i] = 1;
 	} else
@@ -497,7 +500,10 @@ int mtrr_del_page(int reg, unsigned long
 		goto out;
 	}
 	if (--usage_table[reg] < 1)
+	{
+		cmap_release_range(lbase<<PAGE_SHIFT, lsize<<PAGE_SHIFT);
 		set_mtrr(reg, 0, 0, 0);
+	}
 	error = reg;
  out:
 	up(&main_lock);
diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/arch/i386/mm/ioremap.c 2.6-mm-cachemap/arch/i386/mm/ioremap.c
--- 2.6-mm/arch/i386/mm/ioremap.c	2005-05-12 16:15:31.000000000 -0400
+++ 2.6-mm-cachemap/arch/i386/mm/ioremap.c	2005-05-12 16:03:02.000000000 -0400
@@ -11,6 +11,7 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/cachemap.h>
 #include <asm/io.h>
 #include <asm/fixmap.h>
 #include <asm/cacheflush.h>
@@ -150,17 +151,23 @@ void __iomem * __ioremap(unsigned long p
 	phys_addr &= PAGE_MASK;
 	size = PAGE_ALIGN(last_addr+1) - phys_addr;
 
+	if (cmap_request_range(phys_addr, size, cmap_convert_flags(flags)))
+		return NULL;
+
 	/*
 	 * Ok, go for it..
 	 */
 	area = get_vm_area(size, VM_IOREMAP | (flags << 20));
-	if (!area)
+	if (!area) {
+		cmap_release_range(phys_addr, size);
 		return NULL;
+	}
 	area->phys_addr = phys_addr;
 	addr = (void __iomem *) area->addr;
 	if (ioremap_page_range((unsigned long) addr,
 			(unsigned long) addr + size, phys_addr, flags)) {
 		vunmap((void __force *) addr);
+		cmap_release_range(phys_addr, size);
 		return NULL;
 	}
 	return (void __iomem *) (offset + (char __iomem *)addr);
@@ -252,6 +259,11 @@ void iounmap(volatile void __iomem *addr
 				 PAGE_KERNEL);
 		global_flush_tlb();
 	} 
+
+	/* should this be if (p->flags) ?? */
+	/* vm_find_area pads by a page size */
+	cmap_release_range(p->phys_addr, p->size - PAGE_SIZE);
+
 	kfree(p); 
 }
 
diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/include/asm-i386/cachemap.h 2.6-mm-cachemap/include/asm-i386/cachemap.h
--- 2.6-mm/include/asm-i386/cachemap.h	1969-12-31 19:00:00.000000000 -0500
+++ 2.6-mm-cachemap/include/asm-i386/cachemap.h	2005-05-12 16:03:02.000000000 -0400
@@ -0,0 +1,76 @@
+
+#ifndef __ASM_CACHEMAP_H
+#define __ASM_CACHEMAP_H
+
+#include <asm/pgtable.h>
+#include <asm/mtrr.h>
+
+static inline cmap_prot_t cmap_convert_flags(int flags)
+{
+	switch (flags)
+	{
+		case 0:			/* ioremap passes this for cached, fallthru */
+		case _PAGE_RW:		return CMAP_PAGE_CACHED;
+		case _PAGE_PCD:		return CMAP_PAGE_NOCACHED;
+		case _PAGE_WRCOMB:	return CMAP_PAGE_WRCOMB;
+		/* case 0:			return CMAP_PAGE_RO; */
+	}
+	return __cmap_prot(0);
+}
+
+/* convert mtrr type to cmap_prot caching type */
+static inline cmap_prot_t cmap_convert_mtrr_type(int mtype)
+{
+	switch (mtype & 0xff) {
+		case MTRR_TYPE_UNCACHABLE:	return CMAP_PAGE_NOCACHED;
+		case MTRR_TYPE_WRCOMB:		return CMAP_PAGE_WRCOMB;
+		case MTRR_TYPE_WRBACK:		return CMAP_PAGE_CACHED;
+		case MTRR_TYPE_WRPROT:		return CMAP_PAGE_RO;
+
+		/* this is a perfectly valid mtrr, but we don't have a
+		 * matching pat at this point, so just ignore for now..
+		 * actually, mtrrs are set to this, default it to
+		 * uncached for now for testing. I think _PWT is write-
+		 * through, but we'll be overriding it for WC
+		 */
+		case MTRR_TYPE_WRTHROUGH:	return CMAP_PAGE_NOCACHED;
+	}
+	return __cmap_prot(0);
+}
+
+/* for now, just check if the caching matches. arguably, some cachings
+ * could be equivalent, which could be abstracted here
+ */
+static inline int cmap_compare_cachings(cmap_prot_t caching1, cmap_prot_t caching2)
+{
+	int ret = 0;
+
+	if (cmap_prot_val(caching1) == cmap_prot_val(caching2))
+		ret = 1;
+
+	if (cmap_prot_val(caching1) == _CMAP_PAGE_CACHED &&
+	    cmap_prot_val(caching2) == _CMAP_PAGE_NOCACHED)
+		ret = 1;
+
+#if 1
+	if (cmap_prot_val(caching1) == _CMAP_PAGE_NOCACHED &&
+	    cmap_prot_val(caching2) == _CMAP_PAGE_WRCOMB)
+		ret = 1;
+#endif
+
+	return ret;
+}
+
+static inline int cmap_arch_supported_caching(cmap_prot_t caching)
+{
+	if ( (cmap_prot_val(caching) == _CMAP_PAGE_CACHED) ||
+	     (cmap_prot_val(caching) == _CMAP_PAGE_NOCACHED) ||
+	     (cmap_prot_val(caching) == _CMAP_PAGE_WRCOMB) ||
+	     (cmap_prot_val(caching) == _CMAP_PAGE_RO) )
+	{
+		return 1;
+	}
+	return 0;
+}
+
+#endif				/* __ASM_CACHEMAP_H */
diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/include/asm-i386/cpufeature.h 2.6-mm-cachemap/include/asm-i386/cpufeature.h
--- 2.6-mm/include/asm-i386/cpufeature.h	2005-05-12 16:15:23.000000000 -0400
+++ 2.6-mm-cachemap/include/asm-i386/cpufeature.h	2005-05-12 16:03:02.000000000 -0400
@@ -100,6 +100,7 @@
 #define cpu_has_tsc		boot_cpu_has(X86_FEATURE_TSC)
 #define cpu_has_pae		boot_cpu_has(X86_FEATURE_PAE)
 #define cpu_has_pge		boot_cpu_has(X86_FEATURE_PGE)
+#define cpu_has_pat		boot_cpu_has(X86_FEATURE_PAT)
 #define cpu_has_apic		boot_cpu_has(X86_FEATURE_APIC)
 #define cpu_has_sep		boot_cpu_has(X86_FEATURE_SEP)
 #define cpu_has_mtrr		boot_cpu_has(X86_FEATURE_MTRR)
diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/include/asm-i386/pat.h 2.6-mm-cachemap/include/asm-i386/pat.h
--- 2.6-mm/include/asm-i386/pat.h	1969-12-31 19:00:00.000000000 -0500
+++ 2.6-mm-cachemap/include/asm-i386/pat.h	2005-05-12 16:03:02.000000000 -0400
@@ -0,0 +1,77 @@
+/*
+ * x86 PAT support.
+ * Copyright (C) 2003 Jeff Hartmann.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * JEFF HARTMANN, DAVE JONES, OR ANY OTHER CONTRIBUTORS BE LIABLE FOR ANY
+ * CLAIM,  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
+ * OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
+ * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Very losely based on code I wrote at VA Linux Systems in 2001.
+ *
+ * That code had the following copyright notice:
+ * Copyright (C) 2001 Jeff Hartmann
+ * Copyright (C) VA Linux Systems, Inc., Fremont, California.
+ */
+
+#ifndef _LINUX_PAT_H
+#define _LINUX_PAT_H
+
+#define PAT_UNCACHEABLE 	0
+#define PAT_WRITE_COMB		1
+#define PAT_WRITE_THRGH 	4
+#define PAT_WRITE_PROT		5
+#define PAT_WRITE_BACK		6
+#define PAT_UNCACHED		7
+
+/* Here is the PAT's default layout on ia32 cpus when we are done.
+ * PAT0: Write Back
+ * PAT1: Write Combine
+ * PAT2: Uncached
+ * PAT3: Uncacheable
+ * PAT4: Write Through
+ * PAT5: Write Protect
+ * PAT6: Uncached
+ * PAT7: Uncacheable
+ *
+ * Note: On Athlon cpus PAT2/PAT3 & PAT6/PAT7 are both Uncacheable since 
+ *	 there is no uncached type.
+ */
+#define AMD_PAT_31_0		((PAT_WRITE_BACK) | \
+				 (PAT_WRITE_COMB << 8) | \
+				 (PAT_UNCACHEABLE << 16) | \
+				 (PAT_UNCACHEABLE << 24))
+#define AMD_PAT_63_32		((PAT_WRITE_THRGH) | \
+				 (PAT_WRITE_PROT << 8) | \
+				 (PAT_UNCACHEABLE << 16) | \
+				 (PAT_UNCACHEABLE << 24))
+
+#define INTEL_PAT_31_0		((PAT_WRITE_BACK) | \
+				 (PAT_WRITE_COMB << 8) | \
+				 (PAT_UNCACHED << 16) | \
+				 (PAT_UNCACHEABLE << 24))
+
+#define INTEL_PAT_63_32		((PAT_WRITE_THRGH) | \
+				 (PAT_WRITE_PROT << 8) | \
+				 (PAT_UNCACHED << 16) | \
+				 (PAT_UNCACHEABLE << 24))
+
+#define IA32_CR_PAT		0x277
+
+/* This function is intended for PAT initialization only! */
+extern void pat_global_setup(void);
+
+#endif				/*  _LINUX_PAT_H  */
diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/include/asm-i386/pgtable.h 2.6-mm-cachemap/include/asm-i386/pgtable.h
--- 2.6-mm/include/asm-i386/pgtable.h	2005-05-12 16:15:38.000000000 -0400
+++ 2.6-mm-cachemap/include/asm-i386/pgtable.h	2005-05-12 16:03:02.000000000 -0400
@@ -119,6 +119,9 @@ void paging_init(void);
 #define _PAGE_UNUSED2	0x400
 #define _PAGE_UNUSED3	0x800
 
+/* Added define for write combining page, only valid if pat enabled. */
+#define _PAGE_WRCOMB   _PAGE_PWT
+
 #define _PAGE_FILE	0x040	/* set:pagecache unset:swap */
 #define _PAGE_PROTNONE	0x080	/* If not present */
 #ifdef CONFIG_X86_PAE
@@ -157,6 +160,7 @@ void paging_init(void);
 extern unsigned long long __PAGE_KERNEL, __PAGE_KERNEL_EXEC;
 #define __PAGE_KERNEL_RO		(__PAGE_KERNEL & ~_PAGE_RW)
 #define __PAGE_KERNEL_NOCACHE		(__PAGE_KERNEL | _PAGE_PCD)
+#define __PAGE_KERNEL_WRCOMB		(__PAGE_KERNEL | _PAGE_WRCOMB)
 #define __PAGE_KERNEL_LARGE		(__PAGE_KERNEL | _PAGE_PSE)
 #define __PAGE_KERNEL_LARGE_EXEC	(__PAGE_KERNEL_EXEC | _PAGE_PSE)
 
@@ -166,6 +170,8 @@ extern unsigned long long __PAGE_KERNEL,
 #define PAGE_KERNEL_NOCACHE	__pgprot(__PAGE_KERNEL_NOCACHE)
 #define PAGE_KERNEL_LARGE	__pgprot(__PAGE_KERNEL_LARGE)
 #define PAGE_KERNEL_LARGE_EXEC	__pgprot(__PAGE_KERNEL_LARGE_EXEC)
+#define PAGE_KERNEL_WRCOMB	__pgprot(__PAGE_KERNEL_WRCOMB)
+
 
 /*
  * The i386 can't do page protection for execute, and considers that
diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/include/asm-i386/processor.h 2.6-mm-cachemap/include/asm-i386/processor.h
--- 2.6-mm/include/asm-i386/processor.h	2005-05-12 16:15:38.000000000 -0400
+++ 2.6-mm-cachemap/include/asm-i386/processor.h	2005-05-12 16:03:02.000000000 -0400
@@ -696,4 +696,6 @@ extern unsigned long boot_option_idle_ov
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
+extern int cpu_supports_wrcomb(void);
+
 #endif /* __ASM_I386_PROCESSOR_H */
diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/include/linux/cachemap.h 2.6-mm-cachemap/include/linux/cachemap.h
--- 2.6-mm/include/linux/cachemap.h	1969-12-31 19:00:00.000000000 -0500
+++ 2.6-mm-cachemap/include/linux/cachemap.h	2005-05-12 16:03:02.000000000 -0400
@@ -0,0 +1,29 @@
+
+#ifndef __CACHEMAP_H
+#define __CACHEMAP_H
+
+typedef struct { unsigned long cmap_prot; } cmap_prot_t;
+
+#define __cmap_prot(x)       ((cmap_prot_t) { (x) } )
+#define cmap_prot_val(x)     ((x).cmap_prot)
+
+#define _CMAP_PAGE_CACHED    (1<<0)
+#define _CMAP_PAGE_NOCACHED  (1<<1)
+#define _CMAP_PAGE_WRCOMB    (1<<2)
+#define _CMAP_PAGE_RO        (1<<3)
+
+#define CMAP_PAGE_CACHED     __cmap_prot(_CMAP_PAGE_CACHED)
+#define CMAP_PAGE_NOCACHED   __cmap_prot(_CMAP_PAGE_NOCACHED)
+#define CMAP_PAGE_WRCOMB     __cmap_prot(_CMAP_PAGE_WRCOMB)
+#define CMAP_PAGE_RO         __cmap_prot(_CMAP_PAGE_RO)
+
+#include <asm/cachemap.h>
+
+int cmap_init(void);
+int cmap_request_range(unsigned long start, unsigned long size,
+		       cmap_prot_t caching);
+int cmap_report_range(unsigned long start, unsigned long size,
+		      cmap_prot_t caching);
+int cmap_release_range(unsigned long start, unsigned long size);
+
+#endif				/* __CACHEMAP_H */
diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/init/main.c 2.6-mm-cachemap/init/main.c
--- 2.6-mm/init/main.c	2005-05-12 16:15:40.000000000 -0400
+++ 2.6-mm-cachemap/init/main.c	2005-05-12 16:03:02.000000000 -0400
@@ -43,6 +43,7 @@
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/efi.h>
+#include <linux/cachemap.h>
 #include <linux/unistd.h>
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
@@ -523,6 +524,9 @@ asmlinkage void __init start_kernel(void
 
 	acpi_early_init(); /* before LAPIC and SMP init */
 
+	/* initializing here catches most of the early ioremaps */
+	cmap_init();
+
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
 }
diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/mm/cachemap.c 2.6-mm-cachemap/mm/cachemap.c
--- 2.6-mm/mm/cachemap.c	1969-12-31 19:00:00.000000000 -0500
+++ 2.6-mm-cachemap/mm/cachemap.c	2005-05-12 16:03:02.000000000 -0400
@@ -0,0 +1,867 @@
+/*
+  (C) 2004 Terence Ripperda <tripperda@nvidia.com>
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details. 
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+ */
+
+#include <linux/cachemap.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
+
+#include <asm/page.h>
+#include <asm/cacheflush.h>
+#include <asm/semaphore.h>
+
+struct cmap_entry {
+	unsigned long start;
+	unsigned long end;
+	cmap_prot_t caching;
+	unsigned int count;
+	struct cmap_entry *c_next;
+	struct rb_node rb_node;
+};
+
+/* used mainly for searches */
+struct cmap_temp {
+	unsigned long start;
+	unsigned long end;
+	struct cmap_temp *c_next;
+};
+
+static struct rb_root cmap_root = { NULL };
+static __DECLARE_SEMAPHORE_GENERIC(cmap_sema, 1);
+/* static atomic_t cmap_initialized = ATOMIC_INIT(0); */
+
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+static int cmap_proc_read(char *, char **, off_t, int, int *, void *);
+static struct proc_dir_entry *cmap_proc = NULL;
+#endif
+
+/*
+#define DEBUG_CMAP 1 
+#define DEBUG_PRINTOUTS 1 
+*/
+#define CMAP_ALLOW_OVERLAPPING 1
+
+#ifdef DEBUG_PRINTOUTS
+#define DPRINTF(x...) printk(x)
+#else
+#define DPRINTF(x...) do { } while (0)
+#endif
+
+#ifdef DEBUG_CMAP
+static void
+__dump_cmap_node(struct rb_node *p)
+{
+	struct cmap_entry *c_tmp;
+
+	if (p == NULL)
+		return;
+
+	__dump_cmap_node(p->rb_left);
+	c_tmp = rb_entry(p, struct cmap_entry, rb_node);
+	printk("CMAP:   0x%08lx - 0x%08lx: 0x%04lx %d", c_tmp->start,
+	       c_tmp->end, cmap_prot_val(c_tmp->caching), c_tmp->count);
+	printk("\n");
+	__dump_cmap_node(p->rb_right);
+}
+
+static void
+__dump_cmap(void)
+{
+	__dump_cmap_node(cmap_root.rb_node);
+}
+#endif
+
+
+static inline struct cmap_entry *
+__create_cmap_entry(unsigned long start, unsigned long size, cmap_prot_t caching)
+{
+	struct cmap_entry *tmp;
+
+	tmp = kmalloc(sizeof (struct cmap_entry), GFP_KERNEL);
+	if (!tmp)
+		return NULL;
+
+	memset(tmp, 0, sizeof (struct cmap_entry));
+	tmp->start = start;
+	tmp->end = start + size;
+	tmp->caching = caching;
+	tmp->count = 1;
+
+	return tmp;
+}
+
+static inline void
+__free_cmap_entry(struct cmap_entry *entry)
+{
+	if (entry)
+		kfree(entry);
+}
+
+static inline struct cmap_temp *
+__create_cmap_temp(unsigned long start, unsigned long size)
+{
+	struct cmap_temp *tmp;
+
+	tmp = kmalloc(sizeof (struct cmap_temp), GFP_KERNEL);
+	if (!tmp)
+		return NULL;
+
+	memset(tmp, 0, sizeof (struct cmap_temp));
+	tmp->start = start;
+	tmp->end = start + size;
+
+	return tmp;
+}
+
+static inline void
+__free_cmap_temp(struct cmap_temp *entry)
+{
+	if (entry)
+		kfree(entry);
+}
+
+int
+cmap_init(void)
+{
+	printk("CMAP: initializing\n");
+
+#ifdef CONFIG_PROC_FS
+	cmap_proc =
+	    create_proc_entry("cachemap", S_IFREG | S_IRUGO, &proc_root);
+	cmap_proc->read_proc = cmap_proc_read;
+#endif
+
+	return 0;
+}
+
+static inline int
+__find_entry(unsigned long start,
+	     unsigned long size, struct rb_node ***p, struct rb_node **parent)
+{
+	struct cmap_entry *c_tmp;
+
+	*parent = NULL;
+	*p = &cmap_root.rb_node;
+	while (**p) {
+		*parent = **p;
+		c_tmp = rb_entry(*parent, struct cmap_entry, rb_node);
+
+		if (c_tmp->start > start + size)
+			*p = &(**p)->rb_left;
+		else if (c_tmp->end < start)
+			*p = &(**p)->rb_right;
+		else if (c_tmp->start == start && c_tmp->end == start + size) {
+			return 1;
+		} else {
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static inline int
+__insert_entry(struct cmap_entry *c_tmp)
+{
+	struct rb_node **p, *parent;
+
+	/* all entries should be page-aligned!! */
+	if ((c_tmp->end + 1) & 0xfff)
+		BUG();
+
+	if (!__find_entry(c_tmp->start, c_tmp->end - c_tmp->start, &p, &parent)) {
+		rb_link_node(&c_tmp->rb_node, parent, p);
+		rb_insert_color(&c_tmp->rb_node, &cmap_root);
+		return 1;
+	}
+	return 0;
+}
+
+static inline int
+__remove_entry(struct cmap_entry *c_tmp)
+{
+	struct rb_node **p, *parent;
+
+	/* all entries should be page-aligned!! */
+	if ((c_tmp->end + 1) & 0xfff)
+		BUG();
+
+	if (__find_entry(c_tmp->start, c_tmp->end - c_tmp->start, &p, &parent)) {
+		rb_erase(&c_tmp->rb_node, &cmap_root);
+		return 1;
+	}
+	return 0;
+}
+
+#define __CMAP_ASSERT(x)	if (!(x)) BUG()
+
+#define __ADD_TO_LIST(c_this, c_list)		\
+	do {					\
+		__CMAP_ASSERT(!c_this->c_next);	\
+		c_this->c_next = c_list;	\
+		c_list = c_this;		\
+	} while (0)
+
+#define __REMOVE_FROM_LIST(c_this, c_list)	\
+	do {					\
+		c_this = c_list;		\
+		c_list = c_list->c_next;	\
+		c_this->c_next = NULL;		\
+	} while (0)
+
+/* c_old and c_new are identical. 
+ * we want to keep the cmap tree coherent during this search, so we can easily
+ * abort in the case of a failure. so we'll leave c_old in the tree, but mark
+ * it as ready for freeing. we'll update c_new with any new information and
+ * mark it as ready for insertion. if we fail, we just free c_new and leave
+ * c_old in the tree. if we succeed, we go ahead and replace c_old with c_new.
+ */
+#define __SETUP_REPLACEMENT(c_old, c_new)		\
+	do {						\
+		c_new->count = c_old->count + 1; 	\
+		__ADD_TO_LIST(c_new, c_done_list);	\
+		__ADD_TO_LIST(c_old, c_free_list);	\
+	} while (0)
+
+static struct cmap_entry *c_add_list, *c_done_list, *c_free_list;
+
+#if defined(CMAP_ALLOW_OVERLAPPING)
+static int __split_subregion(struct cmap_entry *c_this, struct cmap_entry *c_tmp)
+{
+	unsigned long tmp_start, tmp_limit;
+
+	if (c_this->start == c_tmp->start) {
+		struct cmap_entry *c_end;
+
+		/* split into 2 regions, with c_this at the beginning */
+
+		__SETUP_REPLACEMENT(c_tmp, c_this);
+		c_this->count = c_tmp->count + 1;
+
+		tmp_start = c_this->end + 1;
+		tmp_limit = c_tmp->end - c_this->end - 1;
+		c_end = __create_cmap_entry(tmp_start, tmp_limit, c_tmp->caching);
+		if (c_end == NULL) {
+			printk("CMAP:    failed to create c_new\n");
+			return 1;
+		}
+		c_end->count = c_tmp->count;
+
+		__ADD_TO_LIST(c_end, c_done_list);
+
+		DPRINTF("CMAP:        0x%lx - 0x%lx (%d)\n",
+			c_this->start, c_this->end, c_this->count);
+		DPRINTF("CMAP:        0x%lx - 0x%lx (%d)\n",
+			c_end->start, c_end->end, c_end->count);
+	} else if (c_this->end == c_tmp->end) {
+		struct cmap_entry *c_begin;
+
+		/* split into 2 regions, with c_this at the end */
+
+		__SETUP_REPLACEMENT(c_tmp, c_this);
+		c_this->count = c_tmp->count + 1;
+
+		tmp_start = c_tmp->start;
+		tmp_limit = c_this->start - c_tmp->start - 1;
+		c_begin = __create_cmap_entry(tmp_start, tmp_limit, c_tmp->caching);
+		if (c_begin == NULL) {
+			printk("CMAP:    failed to create c_new\n");
+			return 1;
+		}
+		c_begin->count = c_tmp->count;
+
+		__ADD_TO_LIST(c_begin, c_done_list);
+
+		DPRINTF("CMAP:        0x%lx - 0x%lx (%d)\n",
+			c_begin->start, c_begin->end, c_begin->count);
+		DPRINTF("CMAP:        0x%lx - 0x%lx (%d)\n",
+			c_this->start, c_this->end, c_this->count);
+	} else if ((c_this->start > c_tmp->start) && (c_this->end < c_tmp->end)) {
+		struct cmap_entry *c_begin, *c_end;
+
+		/* split into 3 regions, with c_this in the middle  */
+
+		__SETUP_REPLACEMENT(c_tmp, c_this);
+		c_this->count = c_tmp->count + 1;
+
+		tmp_start = c_tmp->start;
+		tmp_limit = c_this->start - c_tmp->start - 1;
+		c_begin = __create_cmap_entry(tmp_start, tmp_limit, c_tmp->caching);
+		if (c_begin == NULL) {
+			printk("CMAP:    failed to create c_begin\n");
+			return 1;
+		}
+		c_begin->count = c_tmp->count;
+		__ADD_TO_LIST(c_begin, c_done_list);
+
+		tmp_start = c_this->end + 1;
+		tmp_limit = c_tmp->end - c_this->end - 1;
+		c_end = __create_cmap_entry(tmp_start, tmp_limit, c_tmp->caching);
+		if (c_end == NULL) {
+			printk("CMAP:    failed to create c_end\n");
+			return 1;
+		}
+		c_end->count = c_tmp->count;
+		__ADD_TO_LIST(c_end, c_done_list);
+
+		DPRINTF("CMAP:        0x%lx - 0x%lx (%d)\n",
+			c_begin->start, c_begin->end, c_begin->count);
+		DPRINTF("CMAP:        0x%lx - 0x%lx (%d)\n",
+			c_this->start, c_this->end, c_this->count);
+		DPRINTF("CMAP:        0x%lx - 0x%lx (%d)\n",
+			c_end->start, c_end->end, c_end->count);
+	}
+	return 0;
+}
+#endif
+
+static int
+__handle_region(unsigned long start, unsigned long limit, cmap_prot_t caching)
+{
+	int success = 1;
+
+	DPRINTF("CMAP:   handle region: 0x%08lx 0x%08lx 0x%lx\n", start, limit,
+		cmap_prot_val(caching));
+
+	c_add_list = __create_cmap_entry(start, limit, caching);
+	if (c_add_list == NULL) {
+		printk("CMAP:     failed alloc!\n");
+		return 1;
+	}
+
+	c_done_list = c_free_list = NULL;
+	while (c_add_list)
+	{
+		struct rb_node **p, *parent;
+		struct cmap_entry *c_this, *c_tmp;
+		int found;
+
+		__REMOVE_FROM_LIST(c_this, c_add_list);
+
+		found = __find_entry(c_this->start, c_this->end - c_this->start, &p, &parent);
+
+		/* no overlaps, we're good */
+		if (!found) {
+			__ADD_TO_LIST(c_this, c_done_list);
+			continue;
+		}
+
+		/* we have an overlap. if caching doesn't match, fail */
+		c_tmp = rb_entry(*p, struct cmap_entry, rb_node);
+		if (!cmap_compare_cachings(c_tmp->caching, caching)) {
+			/* this is catastrophic, abort and free all new entries */
+			printk("CMAP:     cachings mismatch (%ld != %ld)\n",
+			       cmap_prot_val(c_tmp->caching), cmap_prot_val(caching));
+			success = 0;
+			break;
+		}
+
+		/* perfect fit, increment count and return */
+		if (found == 1) {
+			DPRINTF("CMAP:     perfect fit for 0x%lx 0x%lx (%d)\n", c_tmp->start, c_tmp->end, c_tmp->count);
+			__SETUP_REPLACEMENT(c_tmp, c_this);
+			continue;
+		}
+
+#if defined(CMAP_ALLOW_OVERLAPPING)
+		if (c_this->start >= c_tmp->start && c_this->end <= c_tmp->end) {
+			DPRINTF("CMAP:     sub-region overlap with 0x%08lx 0x%08lx\n",
+				c_tmp->start, c_tmp->end);
+			if (__split_subregion(c_this, c_tmp)) {
+				success = 0;
+				break;
+			}
+			continue;
+		}
+
+		/* non-perfect overlap. recurse on left-over. */
+		DPRINTF("CMAP:     non-perfect overlap with 0x%08lx 0x%08lx... recursing\n",
+			c_tmp->start, c_tmp->end);
+
+		/* pre-region overlap */
+		if (c_this->start < c_tmp->start) {
+			struct cmap_entry *c_new;
+			unsigned long tmp_start = c_this->start;
+			unsigned long tmp_limit = c_tmp->start - c_this->start - 1;
+
+			DPRINTF("CMAP:       recursing on pre-region: 0x%08lx 0x%08lx\n",
+				tmp_start, tmp_limit);
+
+			c_new = __create_cmap_entry(tmp_start, tmp_limit, caching);
+			if (c_new == NULL) {
+				printk("CMAP:    failed to create c_new\n");
+				success = 0;
+				break;
+			}
+
+			__ADD_TO_LIST(c_new, c_add_list);
+		}
+
+		/* post-region overlap */
+		if (c_this->end > c_tmp->end) {
+			struct cmap_entry *c_new;
+			unsigned long tmp_start = c_tmp->end + 1;
+			unsigned long tmp_limit = c_this->end - c_tmp->end - 1;
+
+			DPRINTF("CMAP:       recursing on post-region: 0x%08lx 0x%08lx\n",
+				tmp_start, tmp_limit);
+
+			c_new = __create_cmap_entry(tmp_start, tmp_limit, caching);
+			if (c_new == NULL) {
+				printk("CMAP:    failed to create c_new\n");
+				success = 0;
+				break;
+			}
+
+			__ADD_TO_LIST(c_new, c_add_list);
+		}
+
+		/* don't forget the original region! */
+		{
+			struct cmap_entry *c_new;
+			unsigned long tmp_start, tmp_limit;
+
+			if (c_this->start < c_tmp->start)
+				tmp_start = c_tmp->start;
+			else
+				tmp_start = c_this->start;
+
+			tmp_limit = c_this->end - tmp_start;
+
+			if (tmp_start + tmp_limit > c_tmp->end)
+				tmp_limit = c_tmp->end - tmp_start;
+
+			DPRINTF("CMAP:       recursing on original region: 0x%08lx 0x%08lx\n",
+				tmp_start, tmp_limit);
+
+			c_new = __create_cmap_entry(tmp_start, tmp_limit, caching);
+			if (c_new == NULL) {
+				printk("CMAP:    failed to create c_new\n");
+				success = 0;
+				break;
+			}
+
+			__ADD_TO_LIST(c_new, c_add_list);
+		}
+#endif
+	}
+
+	/* all done, handle success or failure */
+	if (!success) {
+		struct cmap_entry *c_tmp;
+
+		while (c_add_list) {
+			__REMOVE_FROM_LIST(c_tmp, c_add_list);
+			__free_cmap_entry(c_tmp);
+		}
+
+		while (c_done_list) {
+			__REMOVE_FROM_LIST(c_tmp, c_done_list);
+			__free_cmap_entry(c_tmp);
+		}
+
+		/* these should still be in the tree, don't free them */
+		while (c_free_list)
+			__REMOVE_FROM_LIST(c_tmp, c_free_list);
+
+		return 1;
+	}
+
+	if (c_add_list)
+		BUG();
+
+	while (c_free_list) {
+		struct cmap_entry *c_tmp;
+
+		__REMOVE_FROM_LIST(c_tmp, c_free_list);
+		if (!__remove_entry(c_tmp))
+			BUG();
+		__free_cmap_entry(c_tmp);
+	}
+
+	while (c_done_list) {
+		struct cmap_entry *c_tmp;
+
+		__REMOVE_FROM_LIST(c_tmp, c_done_list);
+		DPRINTF("CMAP:  inserting 0x%lx 0x%lx from done list\n", c_tmp->start, c_tmp->end);
+		if (!__insert_entry(c_tmp))
+			BUG();
+	}
+
+	return 0;
+}
+
+
+/* hmm, there's a difference between what caching we can set in the page tables and
+ * what could be set via the mtrrs (or perhaps other methods). for now, treat calls
+ * through cmap_request_ as asking for caching in the page tables, and calls through
+ * cmap_report_ below as reports from other methods (mainly mtrrs).
+ */
+int
+cmap_request_range(unsigned long start, unsigned long size, cmap_prot_t caching)
+{
+	int ret = -1;
+	unsigned int limit = size - 1;
+
+	printk("CMAP: cmap_request_range: 0x%lx - 0x%lx (%lx)\n",
+	       start, start + limit, cmap_prot_val(caching));
+
+	if (cmap_prot_val(caching) == _CMAP_PAGE_WRCOMB) {
+		if (!cpu_supports_wrcomb()) {
+			printk("CMAP:  failed to verify wrcomb support\n");
+			return -1;
+		}
+	} else {
+		if (!cmap_arch_supported_caching(caching)) {
+			printk("CMAP:  caching type not supported 0x%lx\n",
+				cmap_prot_val(caching));
+			return -1;
+		}
+	}
+
+	/* make sure we don't overflow */
+	if (start + size < start)
+		return -1;
+
+	/* handle physical ram here */
+	if (start < virt_to_phys(high_memory)) {
+		unsigned long npages = size >> PAGE_SHIFT;
+		int i, flag;
+
+		if (start + size >= virt_to_phys(high_memory)) {
+			printk("CMAP: request straddles physical memory and i/o!\n");
+			return -1;
+		}
+
+		/* XXX eventually add verification of system pages here,
+		 * for now, this is a hack to let us handle i/o regions for testing
+		 */
+		flag = 0;
+		for (i = 0; i < npages; i++) {
+			struct page *ppage =
+			    virt_to_page(__va(start + (i << PAGE_SHIFT)));
+			if (!PageReserved(ppage))
+				flag = 1;
+		}
+
+		if (flag) {
+			printk("CMAP: need to handle physical pages!\n");
+			/* just return success for now */
+			return 0;
+		}
+
+		/* we'll fall through here for i/o regions that overlap physical ram */
+		printk("CMAP: falling through for i/o region  0x%08lx:0x%08lx\n",
+		     start, start + limit);
+	}
+
+	down(&cmap_sema);
+
+#ifdef DEBUG_CMAP
+	printk("CMAP: initial map: \n");
+	__dump_cmap();
+#endif
+
+	ret = __handle_region(start, limit, caching);
+
+	if (ret == 0) {
+		printk("CMAP:    request_range successful!!\n");
+#ifdef DEBUG_CMAP
+		printk("CMAP:    new map:\n");
+		__dump_cmap();
+#endif
+	}
+
+	up(&cmap_sema);
+
+	return ret;
+}
+
+/* similar to request_range, but reports already existing settings. */
+int
+cmap_report_range(unsigned long start, unsigned long size, cmap_prot_t caching)
+{
+	int ret = -1;
+	unsigned int limit = size - 1;
+
+	printk("CMAP: cmap_report_range: 0x%lx - 0x%lx (%lx)\n",
+	       start, start + limit, cmap_prot_val(caching));
+
+	/* on some systems, the mtrr that marks physical memory write-back 
+	 * extends past physical memory over some i/o addresses. we're going 
+	 * to ignore the mtrr that covers system memory since we're using a
+	 * different mechanism (rmap?) for physical memory. but make sure we
+	 * take into account the i/o addresses covered by the mtrr
+	 */
+	if (start < virt_to_phys(high_memory)) {
+		/* only covers physical memory, we can ignore it */
+		if (start + limit < virt_to_phys(high_memory)) {
+			printk("CMAP: ignoring mtrr 0x%08lx:0x%08lx\n", start,
+			       start + limit);
+			return 1;
+		}
+		/* trim the region */
+		printk("CMAP: trimming mtrr from 0x%08lx:0x%08lx ",
+		       start, start + limit);
+		limit = (start + limit) - virt_to_phys(high_memory);
+		start = virt_to_phys(high_memory);
+		printk("0x%08lx:0x%08lx\n", start, start + limit);
+	}
+
+	down(&cmap_sema);
+
+	ret = __handle_region(start, limit, caching);
+
+	if (ret == 0)
+		printk("CMAP:    report_range successful!!\n");
+
+	up(&cmap_sema);
+
+	return ret;
+}
+
+static int
+__remove_region(unsigned long start, unsigned long limit)
+{
+	struct cmap_temp *c_remove_list, *c_temp_free;
+	int success = 1;
+
+	DPRINTF("CMAP:   remove region: 0x%08lx 0x%08lx\n", start, limit);
+
+	c_remove_list = __create_cmap_temp(start, limit);
+	if (c_remove_list == NULL) {
+		printk("CMAP:     failed alloc!\n");
+		return 1;
+	}
+
+	c_temp_free = NULL;
+	c_free_list = NULL;
+	while (c_remove_list) {
+		struct rb_node **p, *parent;
+		struct cmap_temp *c_this;
+		struct cmap_entry *c_tmp;
+		int found;
+
+		__REMOVE_FROM_LIST(c_this, c_remove_list);
+
+		found = __find_entry(c_this->start, c_this->end - c_this->start, &p, &parent);
+
+		if (!found) {
+			DPRINTF("CMAP:    couldn't find region 0x%lx 0x%lx\n", c_this->start, c_this->end);
+			__ADD_TO_LIST(c_this, c_temp_free);
+			success = 0;
+			break;
+		}
+
+		c_tmp = rb_entry(*p, struct cmap_entry, rb_node);
+		if (found == 1) {
+			DPRINTF("CMAP:    found region 0x%lx 0x%lx (%d)\n", c_tmp->start, c_tmp->end, c_tmp->count);
+			__ADD_TO_LIST(c_this, c_temp_free);
+			if (--c_tmp->count == 0) {
+				printk("CMAP:    last user, freeing\n");
+				__ADD_TO_LIST(c_tmp, c_free_list);
+			}
+			continue;
+		}
+
+#if defined(CMAP_ALLOW_OVERLAPPING)
+		/* this region overlaps another region. what we'd like to do is determine if
+		 * the desired region is a union of regions in the map (but not a superset
+		 * of regions in the map). we can try this recursively, but need to be careful
+		 * of the failing superset case (and decrementing the counter or freeing some
+		 * regions before we find a failure
+		 */
+		DPRINTF("CMAP:     non-perfect overlap with 0x%08lx 0x%08lx... recursing\n",
+			c_tmp->start, c_tmp->end);
+
+		if (c_this->start < c_tmp->start) {
+			struct cmap_temp *c_new;
+			unsigned long tmp_start = c_this->start;
+			unsigned long tmp_limit = c_tmp->start - c_this->start - 1;
+
+			DPRINTF("CMAP:       recursing on pre-region: 0x%08lx 0x%08lx\n",
+				tmp_start, tmp_limit);
+
+			c_new = __create_cmap_temp(tmp_start, tmp_limit);
+			if (c_new == NULL) {
+				__ADD_TO_LIST(c_this, c_temp_free);
+				printk("CMAP:    failed to create c_new\n");
+				success = 0;
+				break;
+			}
+
+			__ADD_TO_LIST(c_new, c_remove_list);
+		}
+
+		if (c_this->end > c_tmp->end) {
+			struct cmap_temp *c_new;
+			unsigned long tmp_start = c_tmp->end + 1;
+			unsigned long tmp_limit = c_this->end - c_tmp->end - 1;
+
+			DPRINTF("CMAP:       recursing on post-region: 0x%08lx 0x%08lx\n",
+				tmp_start, tmp_limit);
+
+			c_new = __create_cmap_temp(tmp_start, tmp_limit);
+			if (c_new == NULL) {
+				__ADD_TO_LIST(c_this, c_temp_free);
+				printk("CMAP:    failed to create c_new\n");
+				success = 0;
+				break;
+			}
+
+			__ADD_TO_LIST(c_new, c_remove_list);
+		}
+
+		/* don't forget the original region! */
+		{
+			struct cmap_temp *c_new;
+			unsigned long tmp_start = c_this->start;
+			unsigned long tmp_limit = c_this->end - c_this->start;
+
+			if (c_this->start < c_tmp->start)
+				tmp_start = c_tmp->start;
+			if (tmp_start + tmp_limit > c_tmp->end)
+				tmp_limit = c_tmp->end - tmp_start;
+
+			DPRINTF("CMAP:       recursing on original region: 0x%08lx 0x%08lx\n",
+				tmp_start, tmp_limit);
+
+			c_new = __create_cmap_temp(tmp_start, tmp_limit);
+			if (c_new == NULL) {
+				__ADD_TO_LIST(c_this, c_temp_free);
+				printk("CMAP:    failed to create c_new\n");
+				success = 0;
+				break;
+			}
+
+			__ADD_TO_LIST(c_new, c_remove_list);
+		}
+
+		__ADD_TO_LIST(c_this, c_temp_free);
+#endif				/* ALLOW_OVERLAPS */
+	}
+
+	/* all done, handle success or failure */
+	if (!success) {
+		struct cmap_entry *c_entry;
+		struct cmap_temp  *c_temp;
+
+		while (c_remove_list) {
+			__REMOVE_FROM_LIST(c_temp, c_remove_list);
+			__free_cmap_temp(c_temp);
+		}
+
+		while (c_temp_free) {
+			__REMOVE_FROM_LIST(c_temp, c_temp_free);
+			__free_cmap_temp(c_temp);
+		}
+
+		/* these should still be in the tree, don't free them */
+		while (c_free_list)
+			__REMOVE_FROM_LIST(c_entry, c_free_list);
+
+		return 1;
+	}
+
+	if (c_remove_list)
+		BUG();
+
+	while (c_temp_free) {
+		struct cmap_temp *c_temp;
+
+		__REMOVE_FROM_LIST(c_temp, c_temp_free);
+		__free_cmap_temp(c_temp);
+	}
+
+	while (c_free_list) {
+		struct cmap_entry *c_entry;
+
+		__REMOVE_FROM_LIST(c_entry, c_free_list);
+		DPRINTF("CMAP:    freeing 0x%lx 0x%lx from c_free_list\n", c_entry->start, c_entry->end);
+		if (!__remove_entry(c_entry))
+			BUG();
+		__free_cmap_entry(c_entry);
+	}
+
+	return 0;
+}
+
+/* cmap_request_range changes the attribute for the range, should we restore it here? */
+int
+cmap_release_range(unsigned long start, unsigned long size)
+{
+	int ret = -1;
+	unsigned int limit = size - 1;
+
+	printk("CMAP: cmap_release_range: 0x%lx - 0x%lx\n", start,
+	       start + limit);
+
+	down(&cmap_sema);
+
+	ret = __remove_region(start, limit);
+
+	if (ret)
+		printk("CMAP: failed to release region! 0x%lx - 0x%lx\n", start,
+		       start + limit);
+	else
+		printk("CMAP:    release_range successful!!\n");
+
+	up(&cmap_sema);
+
+	return ret;
+}
+
+#ifdef CONFIG_PROC_FS
+
+static void
+__cmap_proc_read_node(char *page, int *len, struct rb_node *p)
+{
+	struct cmap_entry *c_tmp;
+
+	if (p == NULL)
+		return;
+
+	__cmap_proc_read_node(page, len, p->rb_left);
+	c_tmp = rb_entry(p, struct cmap_entry, rb_node);
+	*len += sprintf(page + *len, " 0x%08lx - 0x%08lx: 0x%04lx %d\n",
+			c_tmp->start, c_tmp->end,
+			cmap_prot_val(c_tmp->caching), c_tmp->count);
+	__cmap_proc_read_node(page, len, p->rb_right);
+}
+
+static int
+cmap_proc_read(char *page, char **start, off_t off, int count,
+	       int *eof, void *data)
+{
+	int len = 0;
+
+	down(&cmap_sema);
+	len += sprintf(page + len, "cachemap entries:\n");
+
+	__cmap_proc_read_node(page, &len, cmap_root.rb_node);
+
+	up(&cmap_sema);
+
+	return len;
+}
+#endif
+
+EXPORT_SYMBOL(cmap_request_range);
+EXPORT_SYMBOL(cmap_release_range);
diff -urpN --exclude-from=/home/davej/.exclude 2.6-mm/mm/Makefile 2.6-mm-cachemap/mm/Makefile
--- 2.6-mm/mm/Makefile	2005-05-12 16:15:40.000000000 -0400
+++ 2.6-mm-cachemap/mm/Makefile	2005-05-12 16:03:02.000000000 -0400
@@ -10,7 +10,7 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o \
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
-			   prio_tree.o $(mmu-y)
+			   prio_tree.o cachemap.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o

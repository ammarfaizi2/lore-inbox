Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTETSl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTETSlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:41:25 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:39178 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S263295AbTETSlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:41:19 -0400
From: Terence Ripperda <tripperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Terence Ripperda <tripperda@nvidia.com>
Date: Tue, 20 May 2003 13:54:09 -0500
From: <tripperda@nvidia.com>
Subject: pat support in the kernel
Message-ID: <20030520185409.GB941@hygelac>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

I've discussed adding Page Attribute Table (PAT) support to the kernel w/ a few developers offline. They were very supportive and suggested I bring the discussion to lkml so others could get involved.

PAT support allows setting cache attributes via the virtual page table entries that are traditionally set via the MTRRs. The specific cache attribute graphics companies such as ourselves (nvidia), ATI, Matrox, and others are becoming interested in is Write-Combining (WC), both for the AGP and framebuffer apertures. Traditionally, these apertures are marked WC by setting the physical memory ranges to WC in the MTRRs. This has traditionally worked very well, but is becoming a problem with workstation systems with 1+ Gigs of memory. 

The problem here is that the system bios typically covers physical ram with Write-Back (WB) MTRRs. On systems with large amounts of physical ram, especially when physical memory ranges can intersperse with ram, the bioses are using multiple MTRRs with strange results. In some cases, enough MTRRs are used to cover physical ram, such that MTRRs are not left over for the AGP or framebuffer apertures. In other cases, 1 MTRR is used to mark non-physical ram as Uncached (which covers both apertures). When trying to mark the appropriate apertures as WC, the kernel refuses to overlap the MTRRs.

Windows works around this MTRR issue by using the PATs.

An example of such a report recently sent to lkml is here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0303.1/0606.html

I discussed this some with Jeff Hartmann, who had some initial development code that was integrated into agpgart, for marking agp pages WC as they were allocated. I think it would be preferable to have pat support seperate from agpgart. In that way, other drivers could make use of PAT support for other means (such as mapping the framebuffer). Jeff Hartmann sent us a pass at adding PAT support to agpgart. We've modified his code slightly to be more generic (standalone from agpgart) and usable via the traditional __pgprot() macros (and therefore with the change_page_attr() function).

Please cc me on any responses, as I'm not on the list.

Thanks,
Terence



--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.20-pat.diff"

diff -ruN linux-2.4.20/arch/i386/config.in linux-2.4.20-pat/arch/i386/config.in
--- linux-2.4.20/arch/i386/config.in	2002-11-28 15:53:09.000000000 -0800
+++ linux-2.4.20-pat/arch/i386/config.in	2003-03-24 11:16:28.000000000 -0800
@@ -103,6 +103,7 @@
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_WORKS_OK y
+   define_bool CONFIG_X86_PAT y
 fi
 if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -111,6 +112,7 @@
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_F00F_WORKS_OK y
+   define_bool CONFIG_X86_PAT y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
@@ -119,6 +121,7 @@
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_F00F_WORKS_OK y
+   define_bool CONFIG_X86_PAT y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -134,6 +137,7 @@
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_F00F_WORKS_OK y
+   define_bool CONFIG_X86_PAT y
 fi
 if [ "$CONFIG_MELAN" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
diff -ruN linux-2.4.20/arch/i386/kernel/Makefile linux-2.4.20-pat/arch/i386/kernel/Makefile
--- linux-2.4.20/arch/i386/kernel/Makefile	2002-11-28 15:53:09.000000000 -0800
+++ linux-2.4.20-pat/arch/i386/kernel/Makefile	2003-03-24 12:23:23.000000000 -0800
@@ -40,5 +40,6 @@
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o acpitable.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
+obj-$(CONFIG_X86_PAT)	+= pat.o
 
 include $(TOPDIR)/Rules.make
diff -ruN linux-2.4.20/arch/i386/kernel/pat.c linux-2.4.20-pat/arch/i386/kernel/pat.c
--- linux-2.4.20/arch/i386/kernel/pat.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.4.20-pat/arch/i386/kernel/pat.c	2003-03-24 13:42:20.000000000 -0800
@@ -0,0 +1,97 @@
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
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/pagemap.h>
+#include <linux/miscdevice.h>
+#include <linux/pm.h>
+#include <linux/vmalloc.h>
+#include <asm/bitops.h>
+#include <asm/io.h>
+#include <asm/msr.h>
+#include <asm/cpufeature.h>
+#include <asm/system.h>
+#include <asm/pat.h>
+
+static void set_pat(void)
+{
+	switch(boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		wrmsr(IA32_CR_PAT,
+		      AMD_PAT_31_0,
+		      AMD_PAT_63_32);
+		break;
+	case X86_VENDOR_INTEL:
+		wrmsr(IA32_CR_PAT,
+		      INTEL_PAT_31_0,
+		      INTEL_PAT_63_32);
+		break;
+	default:
+		printk("Unknown vendor in set_pat\n");
+		BUG();
+	}
+}
+
+/* Very similar behavior to mtrr setup */
+static void pat_ipi_handler(void *null)
+{
+	unsigned long flags = 0, cr4val = 0, cr0val = 0;
+
+    __save_flags(flags); __cli();
+    if (test_bit(X86_FEATURE_PGE, &boot_cpu_data.x86_capability)) {
+		cr4val = read_cr4();
+		write_cr4(cr4val & (unsigned char) ~(1<<7));
+	}
+	cr0val = read_cr0() | (1<<30);
+	wbinvd();
+	write_cr0(cr0val);
+	wbinvd();
+	/* Okay everything is ready */
+
+	set_pat();
+
+	/* Reenable the caches */
+	wbinvd();
+	write_cr0(read_cr0() & ~(1<<30));
+    if (test_bit(X86_FEATURE_PGE, &boot_cpu_data.x86_capability)) {
+		write_cr4(cr4val);
+    }
+    __restore_flags(flags);
+}
+
+void __init pat_global_setup(void)
+{
+#ifdef CONFIG_SMP
+	if (smp_call_function(pat_ipi_handler, NULL, 1, 1) != 0)
+		panic("pat: timed out waiting for the other CPUs!\n");
+#endif
+	pat_ipi_handler(NULL);
+}
+
Binary files linux-2.4.20/include/asm-i386/.pat.h.swp and linux-2.4.20-pat/include/asm-i386/.pat.h.swp differ
diff -ruN linux-2.4.20/include/asm-i386/pat.h linux-2.4.20-pat/include/asm-i386/pat.h
--- linux-2.4.20/include/asm-i386/pat.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.4.20-pat/include/asm-i386/pat.h	2003-03-24 13:44:20.000000000 -0800
@@ -0,0 +1,78 @@
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
+#endif /*  _LINUX_PAT_H  */
+
diff -ruN linux-2.4.20/include/asm-i386/pgtable.h linux-2.4.20-pat/include/asm-i386/pgtable.h
--- linux-2.4.20/include/asm-i386/pgtable.h	2002-11-28 15:53:15.000000000 -0800
+++ linux-2.4.20-pat/include/asm-i386/pgtable.h	2003-03-24 13:23:45.000000000 -0800
@@ -194,6 +194,9 @@
 #define _PAGE_PSE	0x080	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry PPro+ */
 
+/* Added define for write combining page, only valid if pat enabled. */
+#define _PAGE_WRTCOMB  _PAGE_PWT
+
 #define _PAGE_PROTNONE	0x080	/* If not present */
 
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
@@ -207,6 +210,8 @@
 
 #define __PAGE_KERNEL \
 	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
+#define __PAGE_KERNEL_WRTCOMB \
+	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_WRTCOMB | _PAGE_ACCESSED)
 #define __PAGE_KERNEL_NOCACHE \
 	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_PCD | _PAGE_ACCESSED)
 #define __PAGE_KERNEL_RO \
@@ -229,6 +234,7 @@
 
 #define PAGE_KERNEL MAKE_GLOBAL(__PAGE_KERNEL)
 #define PAGE_KERNEL_RO MAKE_GLOBAL(__PAGE_KERNEL_RO)
+#define PAGE_KERNEL_WRTCOMB MAKE_GLOBAL(__PAGE_KERNEL_WRTCOMB)
 #define PAGE_KERNEL_NOCACHE MAKE_GLOBAL(__PAGE_KERNEL_NOCACHE)
 
 /*
diff -ruN linux-2.4.20/init/main.c linux-2.4.20-pat/init/main.c
--- linux-2.4.20/init/main.c	2002-08-02 17:39:46.000000000 -0700
+++ linux-2.4.20-pat/init/main.c	2003-03-24 13:36:34.000000000 -0800
@@ -52,6 +52,10 @@
 #  include <asm/mtrr.h>
 #endif
 
+#ifdef CONFIG_X86_PAT
+#include <asm/pat.h>
+#endif
+
 #ifdef CONFIG_NUBUS
 #include <linux/nubus.h>
 #endif
@@ -480,6 +484,14 @@
 	mtrr_init();
 #endif
 
+#if defined(CONFIG_X86_PAT)
+    /*
+     * Initialize PAT support on all configured CPUs. This should be
+     * in an architecture specific file (x86, x86-64).
+     */
+    pat_global_setup();
+#endif
+
 #ifdef CONFIG_SYSCTL
 	sysctl_init();
 #endif

--BwCQnh7xodEAoBMC--

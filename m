Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWCWQZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWCWQZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWCWQZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:25:36 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:47537 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932466AbWCWQZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:25:35 -0500
Subject: [PATCH] unify PFN_* macros
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 23 Mar 2006 08:24:59 -0800
Message-Id: <20060323162459.6D45D1CE@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just about every architecture defines some macros to do operations on
pfns.  They're all virtually identical.  This patch consolidates all
of them.

One minor glitch is that at least i386 uses them in a very skeletal
header file.  To keep away from #include dependency hell, I stuck
the new definitions in a new, isolated header.

Of all of the implementations, sh64 is the only one that varied by a
bit.  It used some masks to ensure that any sign-extension got
ripped away before the arithmetic is done.  This has been posted to
that sh64 maintainers and the development list.

Compiles on x86, x86_64, ia64 and ppc64.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 work-dave/arch/alpha/kernel/setup.c               |    9 +--------
 work-dave/arch/alpha/mm/numa.c                    |    4 +---
 work-dave/arch/arm26/mm/init.c                    |    7 +------
 work-dave/arch/cris/kernel/setup.c                |    5 +----
 work-dave/arch/i386/kernel/setup.c                |    1 +
 work-dave/arch/i386/mm/discontig.c                |    1 +
 work-dave/arch/m32r/kernel/setup.c                |    1 +
 work-dave/arch/m32r/mm/discontig.c                |    1 +
 work-dave/arch/m32r/mm/init.c                     |    1 +
 work-dave/arch/mips/ite-boards/ivr/init.c         |    3 ---
 work-dave/arch/mips/ite-boards/qed-4n-s01b/init.c |    3 ---
 work-dave/arch/mips/kernel/setup.c                |    9 +--------
 work-dave/arch/mips/mips-boards/generic/memory.c  |    7 ++-----
 work-dave/arch/mips/mips-boards/sim/sim_mem.c     |    7 ++-----
 work-dave/arch/mips/mm/init.c                     |    4 +---
 work-dave/arch/mips/sgi-ip27/ip27-memory.c        |    3 +--
 work-dave/arch/sh/kernel/setup.c                  |    5 +----
 work-dave/arch/sh64/kernel/setup.c                |    1 +
 work-dave/arch/um/kernel/physmem.c                |    3 +--
 work-dave/include/asm-i386/setup.h                |    4 +---
 work-dave/include/asm-m32r/setup.h                |    4 ----
 work-dave/include/asm-sh64/platform.h             |    5 -----
 work-dave/include/linux/pfn.h                     |    9 +++++++++
 23 files changed, 29 insertions(+), 68 deletions(-)

diff -puN arch/alpha/kernel/setup.c~unify_PFN_macros arch/alpha/kernel/setup.c
--- work/arch/alpha/kernel/setup.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/alpha/kernel/setup.c	2006-03-23 08:23:35.000000000 -0800
@@ -35,6 +35,7 @@
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
 #include <linux/eisa.h>
+#include <linux/pfn.h>
 #ifdef CONFIG_MAGIC_SYSRQ
 #include <linux/sysrq.h>
 #include <linux/reboot.h>
@@ -242,9 +243,6 @@ reserve_std_resources(void)
 		request_resource(io, standard_io_resources+i);
 }
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
 #define PFN_MAX		PFN_DOWN(0x80000000)
 #define for_each_mem_cluster(memdesc, cluster, i)		\
 	for ((cluster) = (memdesc)->cluster, (i) = 0;		\
@@ -473,11 +471,6 @@ page_is_ram(unsigned long pfn)
 	return 0;
 }
 
-#undef PFN_UP
-#undef PFN_DOWN
-#undef PFN_PHYS
-#undef PFN_MAX
-
 void __init
 setup_arch(char **cmdline_p)
 {
diff -puN arch/alpha/mm/numa.c~unify_PFN_macros arch/alpha/mm/numa.c
--- work/arch/alpha/mm/numa.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/alpha/mm/numa.c	2006-03-23 08:23:35.000000000 -0800
@@ -13,6 +13,7 @@
 #include <linux/bootmem.h>
 #include <linux/swap.h>
 #include <linux/initrd.h>
+#include <linux/pfn.h>
 
 #include <asm/hwrpb.h>
 #include <asm/pgalloc.h>
@@ -27,9 +28,6 @@ bootmem_data_t node_bdata[MAX_NUMNODES];
 #define DBGDCONT(args...)
 #endif
 
-#define PFN_UP(x)       (((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)     ((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)     ((x) << PAGE_SHIFT)
 #define for_each_mem_cluster(memdesc, cluster, i)		\
 	for ((cluster) = (memdesc)->cluster, (i) = 0;		\
 	     (i) < (memdesc)->numclusters; (i)++, (cluster)++)
diff -puN arch/arm26/mm/init.c~unify_PFN_macros arch/arm26/mm/init.c
--- work/arch/arm26/mm/init.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/arm26/mm/init.c	2006-03-23 08:23:35.000000000 -0800
@@ -23,6 +23,7 @@
 #include <linux/initrd.h>
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
+#include <linux/pfn.h>
 
 #include <asm/segment.h>
 #include <asm/mach-types.h>
@@ -101,12 +102,6 @@ struct node_info {
 	int bootmap_pages;
 };
 
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_UP(x)	(PAGE_ALIGN(x) >> PAGE_SHIFT)
-#define PFN_SIZE(x)	((x) >> PAGE_SHIFT)
-#define PFN_RANGE(s,e)	PFN_SIZE(PAGE_ALIGN((unsigned long)(e)) - \
-				(((unsigned long)(s)) & PAGE_MASK))
-
 /*
  * FIXME: We really want to avoid allocating the bootmap bitmap
  * over the top of the initrd.  Hopefully, this is located towards
diff -puN arch/cris/kernel/setup.c~unify_PFN_macros arch/cris/kernel/setup.c
--- work/arch/cris/kernel/setup.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/cris/kernel/setup.c	2006-03-23 08:23:35.000000000 -0800
@@ -18,6 +18,7 @@
 #include <linux/seq_file.h>
 #include <linux/tty.h>
 #include <linux/utsname.h>
+#include <linux/pfn.h>
 
 #include <asm/setup.h>
 
@@ -88,10 +89,6 @@ setup_arch(char **cmdline_p)
 	init_mm.end_data =   (unsigned long) &_edata;
 	init_mm.brk =        (unsigned long) &_end;
 
-#define PFN_UP(x)       (((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)     ((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)     ((x) << PAGE_SHIFT)
-
 	/* min_low_pfn points to the start of DRAM, start_pfn points
 	 * to the first DRAM pages after the kernel, and max_low_pfn
 	 * to the end of DRAM.
diff -puN arch/i386/kernel/setup.c~unify_PFN_macros arch/i386/kernel/setup.c
--- work/arch/i386/kernel/setup.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/i386/kernel/setup.c	2006-03-23 08:23:35.000000000 -0800
@@ -47,6 +47,7 @@
 #include <linux/kexec.h>
 #include <linux/crash_dump.h>
 #include <linux/dmi.h>
+#include <linux/pfn.h>
 
 #include <video/edid.h>
 
diff -puN arch/i386/mm/discontig.c~unify_PFN_macros arch/i386/mm/discontig.c
--- work/arch/i386/mm/discontig.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/i386/mm/discontig.c	2006-03-23 08:23:35.000000000 -0800
@@ -31,6 +31,7 @@
 #include <linux/nodemask.h>
 #include <linux/module.h>
 #include <linux/kexec.h>
+#include <linux/pfn.h>
 
 #include <asm/e820.h>
 #include <asm/setup.h>
diff -puN arch/m32r/kernel/setup.c~unify_PFN_macros arch/m32r/kernel/setup.c
--- work/arch/m32r/kernel/setup.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/m32r/kernel/setup.c	2006-03-23 08:23:35.000000000 -0800
@@ -24,6 +24,7 @@
 #include <linux/tty.h>
 #include <linux/cpu.h>
 #include <linux/nodemask.h>
+#include <linux/pfn.h>
 
 #include <asm/processor.h>
 #include <asm/pgtable.h>
diff -puN arch/m32r/mm/discontig.c~unify_PFN_macros arch/m32r/mm/discontig.c
--- work/arch/m32r/mm/discontig.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/m32r/mm/discontig.c	2006-03-23 08:23:35.000000000 -0800
@@ -13,6 +13,7 @@
 #include <linux/initrd.h>
 #include <linux/nodemask.h>
 #include <linux/module.h>
+#include <linux/pfn.h>
 
 #include <asm/setup.h>
 
diff -puN arch/m32r/mm/init.c~unify_PFN_macros arch/m32r/mm/init.c
--- work/arch/m32r/mm/init.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/m32r/mm/init.c	2006-03-23 08:23:35.000000000 -0800
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/bitops.h>
 #include <linux/nodemask.h>
+#include <linux/pfn.h>
 #include <asm/types.h>
 #include <asm/processor.h>
 #include <asm/page.h>
diff -puN arch/mips/ite-boards/ivr/init.c~unify_PFN_macros arch/mips/ite-boards/ivr/init.c
--- work/arch/mips/ite-boards/ivr/init.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/mips/ite-boards/ivr/init.c	2006-03-23 08:23:35.000000000 -0800
@@ -45,9 +45,6 @@ extern void  __init prom_init_cmdline(vo
 extern unsigned long __init prom_get_memsize(void);
 extern void __init it8172_init_ram_resource(unsigned long memsize);
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
-
 const char *get_system_type(void)
 {
 	return "Globespan IVR";
diff -puN arch/mips/ite-boards/qed-4n-s01b/init.c~unify_PFN_macros arch/mips/ite-boards/qed-4n-s01b/init.c
--- work/arch/mips/ite-boards/qed-4n-s01b/init.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/mips/ite-boards/qed-4n-s01b/init.c	2006-03-23 08:23:35.000000000 -0800
@@ -45,9 +45,6 @@ extern void  __init prom_init_cmdline(vo
 extern unsigned long __init prom_get_memsize(void);
 extern void __init it8172_init_ram_resource(unsigned long memsize);
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
-
 const char *get_system_type(void)
 {
 	return "ITE QED-4N-S01B";
diff -puN arch/mips/kernel/setup.c~unify_PFN_macros arch/mips/kernel/setup.c
--- work/arch/mips/kernel/setup.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/mips/kernel/setup.c	2006-03-23 08:23:35.000000000 -0800
@@ -34,6 +34,7 @@
 #include <linux/highmem.h>
 #include <linux/console.h>
 #include <linux/mmzone.h>
+#include <linux/pfn.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -257,10 +258,6 @@ static inline int parse_rd_cmdline(unsig
 	return 0;
 }
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
-
 #define MAXMEM		HIGHMEM_START
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
 
@@ -493,10 +490,6 @@ static inline void resource_init(void)
 	}
 }
 
-#undef PFN_UP
-#undef PFN_DOWN
-#undef PFN_PHYS
-
 #undef MAXMEM
 #undef MAXMEM_PFN
 
diff -puN arch/mips/mips-boards/generic/memory.c~unify_PFN_macros arch/mips/mips-boards/generic/memory.c
--- work/arch/mips/mips-boards/generic/memory.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/mips/mips-boards/generic/memory.c	2006-03-23 08:23:35.000000000 -0800
@@ -49,9 +49,6 @@ static char *mtypes[3] = {
 /* References to section boundaries */
 extern char _end;
 
-#define PFN_ALIGN(x)    (((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
-
-
 struct prom_pmemblock * __init prom_getmdesc(void)
 {
 	char *memsize_str;
@@ -109,10 +106,10 @@ struct prom_pmemblock * __init prom_getm
 
 	mdesc[3].type = yamon_dontuse;
 	mdesc[3].base = 0x00100000;
-	mdesc[3].size = CPHYSADDR(PFN_ALIGN(&_end)) - mdesc[3].base;
+	mdesc[3].size = CPHYSADDR(PAGE_ALIGN(&_end)) - mdesc[3].base;
 
 	mdesc[4].type = yamon_free;
-	mdesc[4].base = CPHYSADDR(PFN_ALIGN(&_end));
+	mdesc[4].base = CPHYSADDR(PAGE_ALIGN(&_end));
 	mdesc[4].size = memsize - mdesc[4].base;
 
 	return &mdesc[0];
diff -puN arch/mips/mips-boards/sim/sim_mem.c~unify_PFN_macros arch/mips/mips-boards/sim/sim_mem.c
--- work/arch/mips/mips-boards/sim/sim_mem.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/mips/mips-boards/sim/sim_mem.c	2006-03-23 08:23:35.000000000 -0800
@@ -42,9 +42,6 @@ static char *mtypes[3] = {
 /* References to section boundaries */
 extern char _end;
 
-#define PFN_ALIGN(x)    (((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
-
-
 struct prom_pmemblock * __init prom_getmdesc(void)
 {
 	unsigned int memsize;
@@ -64,10 +61,10 @@ struct prom_pmemblock * __init prom_getm
 
 	mdesc[2].type = simmem_reserved;
 	mdesc[2].base = 0x00100000;
-	mdesc[2].size = CPHYSADDR(PFN_ALIGN(&_end)) - mdesc[2].base;
+	mdesc[2].size = CPHYSADDR(PAGE_ALIGN(&_end)) - mdesc[2].base;
 
 	mdesc[3].type = simmem_free;
-	mdesc[3].base = CPHYSADDR(PFN_ALIGN(&_end));
+	mdesc[3].base = CPHYSADDR(PAGE_ALIGN(&_end));
 	mdesc[3].size = memsize - mdesc[3].base;
 
 	return &mdesc[0];
diff -puN arch/mips/mm/init.c~unify_PFN_macros arch/mips/mm/init.c
--- work/arch/mips/mm/init.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/mips/mm/init.c	2006-03-23 08:23:35.000000000 -0800
@@ -25,6 +25,7 @@
 #include <linux/highmem.h>
 #include <linux/swap.h>
 #include <linux/proc_fs.h>
+#include <linux/pfn.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cachectl.h>
@@ -177,9 +178,6 @@ void __init paging_init(void)
 	free_area_init(zones_size);
 }
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-
 static inline int page_is_ram(unsigned long pagenr)
 {
 	int i;
diff -puN arch/mips/sgi-ip27/ip27-memory.c~unify_PFN_macros arch/mips/sgi-ip27/ip27-memory.c
--- work/arch/mips/sgi-ip27/ip27-memory.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/mips/sgi-ip27/ip27-memory.c	2006-03-23 08:23:35.000000000 -0800
@@ -19,6 +19,7 @@
 #include <linux/nodemask.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
+#include <linux/pfn.h>
 #include <asm/page.h>
 #include <asm/sections.h>
 
@@ -28,8 +29,6 @@
 #include <asm/sn/sn_private.h>
 
 
-#define PFN_UP(x)		(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-
 #define SLOT_PFNSHIFT           (SLOT_SHIFT - PAGE_SHIFT)
 #define PFN_NASIDSHFT           (NASID_SHFT - PAGE_SHIFT)
 
diff -puN arch/sh/kernel/setup.c~unify_PFN_macros arch/sh/kernel/setup.c
--- work/arch/sh/kernel/setup.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/sh/kernel/setup.c	2006-03-23 08:23:35.000000000 -0800
@@ -20,6 +20,7 @@
 #include <linux/root_dev.h>
 #include <linux/utsname.h>
 #include <linux/cpu.h>
+#include <linux/pfn.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/sections.h>
@@ -275,10 +276,6 @@ void __init setup_arch(char **cmdline_p)
 
 	sh_mv_setup(cmdline_p);
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
-
 	/*
 	 * Find the highest page frame number we have available
 	 */
diff -puN arch/sh64/kernel/setup.c~unify_PFN_macros arch/sh64/kernel/setup.c
--- work/arch/sh64/kernel/setup.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/sh64/kernel/setup.c	2006-03-23 08:23:35.000000000 -0800
@@ -48,6 +48,7 @@
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/initrd.h>
+#include <linux/pfn.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
diff -puN arch/um/kernel/physmem.c~unify_PFN_macros arch/um/kernel/physmem.c
--- work/arch/um/kernel/physmem.c~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/arch/um/kernel/physmem.c	2006-03-23 08:23:35.000000000 -0800
@@ -9,6 +9,7 @@
 #include "linux/vmalloc.h"
 #include "linux/bootmem.h"
 #include "linux/module.h"
+#include "linux/pfn.h"
 #include "asm/types.h"
 #include "asm/pgtable.h"
 #include "kern_util.h"
@@ -316,8 +317,6 @@ void map_memory(unsigned long virt, unsi
 	}
 }
 
-#define PFN_UP(x) (((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-
 extern int __syscall_stub_start, __binary_start;
 
 void setup_physmem(unsigned long start, unsigned long reserve_end,
diff -puN include/asm-i386/setup.h~unify_PFN_macros include/asm-i386/setup.h
--- work/include/asm-i386/setup.h~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/include/asm-i386/setup.h	2006-03-23 08:23:35.000000000 -0800
@@ -6,9 +6,7 @@
 #ifndef _i386_SETUP_H
 #define _i386_SETUP_H
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
+#include <linux/pfn.h>
 
 /*
  * Reserved space for vmalloc and iomap - defined in asm/page.h
diff -puN include/asm-m32r/setup.h~unify_PFN_macros include/asm-m32r/setup.h
--- work/include/asm-m32r/setup.h~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/include/asm-m32r/setup.h	2006-03-23 08:23:35.000000000 -0800
@@ -24,10 +24,6 @@
 #define RAMDISK_PROMPT_FLAG		(0x8000)
 #define RAMDISK_LOAD_FLAG		(0x4000)
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
-
 extern unsigned long memory_start;
 extern unsigned long memory_end;
 
diff -puN include/asm-sh64/platform.h~unify_PFN_macros include/asm-sh64/platform.h
--- work/include/asm-sh64/platform.h~unify_PFN_macros	2006-03-23 08:23:35.000000000 -0800
+++ work-dave/include/asm-sh64/platform.h	2006-03-23 08:23:35.000000000 -0800
@@ -61,9 +61,4 @@ extern int platform_int_priority[NR_INTC
 #define code_resource (platform_parms.kram_res_p[STANDARD_KRAM_RESOURCES - 2])
 #define data_resource (platform_parms.kram_res_p[STANDARD_KRAM_RESOURCES - 1])
 
-/* Be prepared to 64-bit sign extensions */
-#define PFN_UP(x)       ((((x) + PAGE_SIZE-1) >> PAGE_SHIFT) & 0x000fffff)
-#define PFN_DOWN(x)     (((x) >> PAGE_SHIFT) & 0x000fffff)
-#define PFN_PHYS(x)     ((x) << PAGE_SHIFT)
-
 #endif	/* __ASM_SH64_PLATFORM_H */
diff -puN /dev/null include/linux/pfn.h
--- /dev/null	2005-03-30 22:36:15.000000000 -0800
+++ work-dave/include/linux/pfn.h	2006-03-23 08:23:35.000000000 -0800
@@ -0,0 +1,9 @@
+#ifndef _LINUX_PFN_H_
+#define _LINUX_PFN_H_
+
+#define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
+#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
+#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
+#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
+
+#endif
_

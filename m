Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWH3WQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWH3WQJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWH3WQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:16:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:9188 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932172AbWH3WQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:16:07 -0400
Subject: [RFC][PATCH 1/9] put alignment macros in align.h
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 30 Aug 2006 15:16:05 -0700
References: <20060830221604.E7320C0F@localhost.localdomain>
In-Reply-To: <20060830221604.E7320C0F@localhost.localdomain>
Message-Id: <20060830221605.9B506326@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are several definitions of alignment macros.  We'll take some
of the definitions from the powerpc code (since they are the most
prolific users), and make the generic version not evaluate its
argument twice.  (Thanks Nikita)

We need a new header instead of kernel.h because it has many other
definitions, and we'll get circular dependencies.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 threadalloc-dave/include/linux/kernel.h                       |    2 -
 threadalloc-dave/include/linux/align.h                        |   20 ++++++++++
 threadalloc-dave/include/asm-ppc/page.h                       |   10 +----
 threadalloc-dave/include/asm-ppc/bootinfo.h                   |    2 -
 threadalloc-dave/include/asm-powerpc/page.h                   |   10 +----
 threadalloc-dave/arch/powerpc/kernel/prom.c                   |   20 +++++-----
 threadalloc-dave/arch/powerpc/kernel/prom_init.c              |    9 ++--
 threadalloc-dave/arch/powerpc/mm/44x_mmu.c                    |    2 -
 threadalloc-dave/arch/powerpc/platforms/iseries/setup.c       |    2 -
 threadalloc-dave/arch/powerpc/platforms/powermac/bootx_init.c |    4 +-
 threadalloc-dave/arch/ppc/kernel/setup.c                      |    4 +-
 threadalloc-dave/arch/ppc/mm/44x_mmu.c                        |    2 -
 12 files changed, 48 insertions(+), 39 deletions(-)

diff -puN include/linux/kernel.h~align-h include/linux/kernel.h
--- threadalloc/include/linux/kernel.h~align-h	2006-08-30 15:14:57.000000000 -0700
+++ threadalloc-dave/include/linux/kernel.h	2006-08-30 15:14:59.000000000 -0700
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
+#include <linux/align.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
@@ -31,7 +32,6 @@ extern const char linux_banner[];
 #define STACK_MAGIC	0xdeadbeef
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
 #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 
diff -puN /dev/null include/linux/align.h
--- /dev/null	2005-03-30 22:36:15.000000000 -0800
+++ threadalloc-dave/include/linux/align.h	2006-08-30 15:14:59.000000000 -0700
@@ -0,0 +1,20 @@
+#ifndef _LINUX_ALIGN_H
+#define _LINUX_ALIGN_H
+
+/*
+ * This file should only contain macros which have no outside
+ * dependencies, and can be used safely from any other header.
+ */
+
+#define _ALIGN_UP(x,a) ({ typeof(a) __a = (a); (((x) + __a - 1) & ~(__a - 1)); })
+#define _ALIGN_DOWN(x,a)  ((x)&(~((a)-1)))
+
+/*
+ * ALIGN is special.  There's a linkage.h as well that
+ * has a quite different meaning.
+ */
+#ifndef __ASSEMBLY__
+#define ALIGN(addr,size) _ALIGN_UP(addr,size)
+#endif
+
+#endif /* _LINUX_ALIGN_H */
diff -puN include/asm-ppc/page.h~align-h include/asm-ppc/page.h
--- threadalloc/include/asm-ppc/page.h~align-h	2006-08-30 15:14:57.000000000 -0700
+++ threadalloc-dave/include/asm-ppc/page.h	2006-08-30 15:14:59.000000000 -0700
@@ -1,6 +1,7 @@
 #ifndef _PPC_PAGE_H
 #define _PPC_PAGE_H
 
+#include <linux/align.h>
 #include <asm/asm-compat.h>
 
 /* PAGE_SHIFT determines the page size */
@@ -36,15 +37,8 @@ typedef unsigned long pte_basic_t;
 #define PTE_FMT		"%.8lx"
 #endif
 
-/* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
-
-/* align addr on a size boundary - adjust address up if needed */
-#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
-
 /* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
+#define PAGE_ALIGN(addr)	ALIGN(addr, PAGE_SIZE)
 
 
 #undef STRICT_MM_TYPECHECKS
diff -puN include/asm-ppc/bootinfo.h~align-h include/asm-ppc/bootinfo.h
--- threadalloc/include/asm-ppc/bootinfo.h~align-h	2006-08-30 15:14:57.000000000 -0700
+++ threadalloc-dave/include/asm-ppc/bootinfo.h	2006-08-30 15:14:59.000000000 -0700
@@ -41,7 +41,7 @@ static inline struct bi_record *
 bootinfo_addr(unsigned long offset)
 {
 
-	return (struct bi_record *)_ALIGN((offset) + (1 << 20) - 1,
+	return (struct bi_record *)ALIGN((offset) + (1 << 20) - 1,
 					  (1 << 20));
 }
 #endif /* CONFIG_APUS */
diff -puN include/asm-powerpc/page.h~align-h include/asm-powerpc/page.h
--- threadalloc/include/asm-powerpc/page.h~align-h	2006-08-30 15:14:57.000000000 -0700
+++ threadalloc-dave/include/asm-powerpc/page.h	2006-08-30 15:14:59.000000000 -0700
@@ -11,6 +11,7 @@
  */
 
 #ifdef __KERNEL__
+#include <linux/align.h>
 #include <asm/asm-compat.h>
 #include <asm/kdump.h>
 
@@ -89,15 +90,8 @@
 #include <asm/page_32.h>
 #endif
 
-/* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
-
-/* align addr on a size boundary - adjust address up if needed */
-#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
-
 /* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
+#define PAGE_ALIGN(addr)	ALIGN(addr, PAGE_SIZE)
 
 /*
  * Don't compare things with KERNELBASE or PAGE_OFFSET to test for
diff -puN arch/powerpc/kernel/prom.c~align-h arch/powerpc/kernel/prom.c
--- threadalloc/arch/powerpc/kernel/prom.c~align-h	2006-08-30 15:14:57.000000000 -0700
+++ threadalloc-dave/arch/powerpc/kernel/prom.c	2006-08-30 15:14:59.000000000 -0700
@@ -125,9 +125,9 @@ int __init of_scan_flat_dt(int (*it)(uns
 			u32 sz = *((u32 *)p);
 			p += 8;
 			if (initial_boot_params->version < 0x10)
-				p = _ALIGN(p, sz >= 8 ? 8 : 4);
+				p = ALIGN(p, sz >= 8 ? 8 : 4);
 			p += sz;
-			p = _ALIGN(p, 4);
+			p = ALIGN(p, 4);
 			continue;
 		}
 		if (tag != OF_DT_BEGIN_NODE) {
@@ -137,7 +137,7 @@ int __init of_scan_flat_dt(int (*it)(uns
 		}
 		depth++;
 		pathp = (char *)p;
-		p = _ALIGN(p + strlen(pathp) + 1, 4);
+		p = ALIGN(p + strlen(pathp) + 1, 4);
 		if ((*pathp) == '/') {
 			char *lp, *np;
 			for (lp = NULL, np = pathp; *np; np++)
@@ -163,7 +163,7 @@ unsigned long __init of_get_flat_dt_root
 		p += 4;
 	BUG_ON (*((u32 *)p) != OF_DT_BEGIN_NODE);
 	p += 4;
-	return _ALIGN(p + strlen((char *)p) + 1, 4);
+	return ALIGN(p + strlen((char *)p) + 1, 4);
 }
 
 /**
@@ -190,7 +190,7 @@ void* __init of_get_flat_dt_prop(unsigne
 		noff = *((u32 *)(p + 4));
 		p += 8;
 		if (initial_boot_params->version < 0x10)
-			p = _ALIGN(p, sz >= 8 ? 8 : 4);
+			p = ALIGN(p, sz >= 8 ? 8 : 4);
 
 		nstr = find_flat_dt_string(noff);
 		if (nstr == NULL) {
@@ -204,7 +204,7 @@ void* __init of_get_flat_dt_prop(unsigne
 			return (void *)p;
 		}
 		p += sz;
-		p = _ALIGN(p, 4);
+		p = ALIGN(p, 4);
 	} while(1);
 }
 
@@ -232,7 +232,7 @@ static void *__init unflatten_dt_alloc(u
 {
 	void *res;
 
-	*mem = _ALIGN(*mem, align);
+	*mem = ALIGN(*mem, align);
 	res = (void *)*mem;
 	*mem += size;
 
@@ -261,7 +261,7 @@ static unsigned long __init unflatten_dt
 	*p += 4;
 	pathp = (char *)*p;
 	l = allocl = strlen(pathp) + 1;
-	*p = _ALIGN(*p + l, 4);
+	*p = ALIGN(*p + l, 4);
 
 	/* version 0x10 has a more compact unit name here instead of the full
 	 * path. we accumulate the full path size using "fpsize", we'll rebuild
@@ -340,7 +340,7 @@ static unsigned long __init unflatten_dt
 		noff = *((u32 *)((*p) + 4));
 		*p += 8;
 		if (initial_boot_params->version < 0x10)
-			*p = _ALIGN(*p, sz >= 8 ? 8 : 4);
+			*p = ALIGN(*p, sz >= 8 ? 8 : 4);
 
 		pname = find_flat_dt_string(noff);
 		if (pname == NULL) {
@@ -366,7 +366,7 @@ static unsigned long __init unflatten_dt
 			*prev_pp = pp;
 			prev_pp = &pp->next;
 		}
-		*p = _ALIGN((*p) + sz, 4);
+		*p = ALIGN((*p) + sz, 4);
 	}
 	/* with version 0x10 we may not have the name property, recreate
 	 * it here from the unit name if absent
diff -puN arch/powerpc/kernel/prom_init.c~align-h arch/powerpc/kernel/prom_init.c
--- threadalloc/arch/powerpc/kernel/prom_init.c~align-h	2006-08-30 15:14:57.000000000 -0700
+++ threadalloc-dave/arch/powerpc/kernel/prom_init.c	2006-08-30 15:14:59.000000000 -0700
@@ -16,6 +16,7 @@
 #undef DEBUG_PROM
 
 #include <stdarg.h>
+#include <linux/align.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
@@ -1679,7 +1680,7 @@ static void __init *make_room(unsigned l
 {
 	void *ret;
 
-	*mem_start = _ALIGN(*mem_start, align);
+	*mem_start = ALIGN(*mem_start, align);
 	while ((*mem_start + needed) > *mem_end) {
 		unsigned long room, chunk;
 
@@ -1811,7 +1812,7 @@ static void __init scan_dt_build_struct(
 				*lp++ = *p;
 		}
 		*lp = 0;
-		*mem_start = _ALIGN((unsigned long)lp + 1, 4);
+		*mem_start = ALIGN((unsigned long)lp + 1, 4);
 	}
 
 	/* get it again for debugging */
@@ -1864,7 +1865,7 @@ static void __init scan_dt_build_struct(
 		/* push property content */
 		valp = make_room(mem_start, mem_end, l, 4);
 		call_prom("getprop", 4, 1, node, RELOC(pname), valp, l);
-		*mem_start = _ALIGN(*mem_start, 4);
+		*mem_start = ALIGN(*mem_start, 4);
 	}
 
 	/* Add a "linux,phandle" property. */
@@ -1920,7 +1921,7 @@ static void __init flatten_device_tree(v
 		prom_panic ("couldn't get device tree root\n");
 
 	/* Build header and make room for mem rsv map */ 
-	mem_start = _ALIGN(mem_start, 4);
+	mem_start = ALIGN(mem_start, 4);
 	hdr = make_room(&mem_start, &mem_end,
 			sizeof(struct boot_param_header), 4);
 	RELOC(dt_header_start) = (unsigned long)hdr;
diff -puN arch/powerpc/mm/44x_mmu.c~align-h arch/powerpc/mm/44x_mmu.c
--- threadalloc/arch/powerpc/mm/44x_mmu.c~align-h	2006-08-30 15:14:57.000000000 -0700
+++ threadalloc-dave/arch/powerpc/mm/44x_mmu.c	2006-08-30 15:14:59.000000000 -0700
@@ -103,7 +103,7 @@ unsigned long __init mmu_mapin_ram(void)
 
 	/* Determine number of entries necessary to cover lowmem */
 	pinned_tlbs = (unsigned int)
-		(_ALIGN(total_lowmem, PPC44x_PIN_SIZE) >> PPC44x_PIN_SHIFT);
+		(ALIGN(total_lowmem, PPC44x_PIN_SIZE) >> PPC44x_PIN_SHIFT);
 
 	/* Write upper watermark to save location */
 	tlb_44x_hwater = PPC44x_LOW_SLOT - pinned_tlbs;
diff -puN arch/powerpc/platforms/iseries/setup.c~align-h arch/powerpc/platforms/iseries/setup.c
--- threadalloc/arch/powerpc/platforms/iseries/setup.c~align-h	2006-08-30 15:14:57.000000000 -0700
+++ threadalloc-dave/arch/powerpc/platforms/iseries/setup.c	2006-08-30 15:14:59.000000000 -0700
@@ -354,7 +354,7 @@ EXPORT_SYMBOL(mschunks_map);
 
 void mschunks_alloc(unsigned long num_chunks)
 {
-	klimit = _ALIGN(klimit, sizeof(u32));
+	klimit = ALIGN(klimit, sizeof(u32));
 	mschunks_map.mapping = (u32 *)klimit;
 	klimit += num_chunks * sizeof(u32);
 	mschunks_map.num_chunks = num_chunks;
diff -puN arch/powerpc/platforms/powermac/bootx_init.c~align-h arch/powerpc/platforms/powermac/bootx_init.c
--- threadalloc/arch/powerpc/platforms/powermac/bootx_init.c~align-h	2006-08-30 15:14:57.000000000 -0700
+++ threadalloc-dave/arch/powerpc/platforms/powermac/bootx_init.c	2006-08-30 15:14:59.000000000 -0700
@@ -389,7 +389,7 @@ static unsigned long __init bootx_flatte
 	hdr->dt_strings_size = bootx_dt_strend - bootx_dt_strbase;
 
 	/* Build structure */
-	mem_end = _ALIGN(mem_end, 16);
+	mem_end = ALIGN(mem_end, 16);
 	DBG("Building device tree structure at: %x\n", mem_end);
 	hdr->off_dt_struct = mem_end - mem_start;
 	bootx_scan_dt_build_struct(base, 4, &mem_end);
@@ -407,7 +407,7 @@ static unsigned long __init bootx_flatte
 	 * also bump mem_reserve_cnt to cause further reservations to
 	 * fail since it's too late.
 	 */
-	mem_end = _ALIGN(mem_end, PAGE_SIZE);
+	mem_end = ALIGN(mem_end, PAGE_SIZE);
 	DBG("End of boot params: %x\n", mem_end);
 	rsvmap[0] = mem_start;
 	rsvmap[1] = mem_end;
diff -puN arch/ppc/kernel/setup.c~align-h arch/ppc/kernel/setup.c
--- threadalloc/arch/ppc/kernel/setup.c~align-h	2006-08-30 15:14:57.000000000 -0700
+++ threadalloc-dave/arch/ppc/kernel/setup.c	2006-08-30 15:14:59.000000000 -0700
@@ -341,14 +341,14 @@ struct bi_record *find_bootinfo(void)
 {
 	struct bi_record *rec;
 
-	rec = (struct bi_record *)_ALIGN((ulong)__bss_start+(1<<20)-1,(1<<20));
+	rec = (struct bi_record *)ALIGN((ulong)__bss_start+(1<<20)-1,(1<<20));
 	if ( rec->tag != BI_FIRST ) {
 		/*
 		 * This 0x10000 offset is a terrible hack but it will go away when
 		 * we have the bootloader handle all the relocation and
 		 * prom calls -- Cort
 		 */
-		rec = (struct bi_record *)_ALIGN((ulong)__bss_start+0x10000+(1<<20)-1,(1<<20));
+		rec = (struct bi_record *)ALIGN((ulong)__bss_start+0x10000+(1<<20)-1,(1<<20));
 		if ( rec->tag != BI_FIRST )
 			return NULL;
 	}
diff -puN arch/ppc/mm/44x_mmu.c~align-h arch/ppc/mm/44x_mmu.c
--- threadalloc/arch/ppc/mm/44x_mmu.c~align-h	2006-08-30 15:14:57.000000000 -0700
+++ threadalloc-dave/arch/ppc/mm/44x_mmu.c	2006-08-30 15:14:59.000000000 -0700
@@ -103,7 +103,7 @@ unsigned long __init mmu_mapin_ram(void)
 
 	/* Determine number of entries necessary to cover lowmem */
 	pinned_tlbs = (unsigned int)
-		(_ALIGN(total_lowmem, PPC_PIN_SIZE) >> PPC44x_PIN_SHIFT);
+		(ALIGN(total_lowmem, PPC_PIN_SIZE) >> PPC44x_PIN_SHIFT);
 
 	/* Write upper watermark to save location */
 	tlb_44x_hwater = PPC44x_LOW_SLOT - pinned_tlbs;
_

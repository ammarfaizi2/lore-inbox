Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVCWMLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVCWMLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 07:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVCWMLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 07:11:47 -0500
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:57508 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S261414AbVCWMLQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 07:11:16 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
Organization: IBM LTC
To: Mike kravetz <kravetz@us.ibm.com>
Subject: [PATCH] ppc64: Add mem=X option, updated NUMA support
Date: Wed, 23 Mar 2005 23:11:10 +1100
User-Agent: KMail/1.7.2
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503232311.11113.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Here's an updated version of my mem=X patch with new NUMA code.
Sorry it took so long I've been a bit crook.

Can you test this on your 720 or whatever it was? And if anyone else
has an interesting NUMA machine they can test it on I'd love to hear
about it!

This also includes a fix for the bug Maneesh found last week with
GCC 3.3 generating a switch table in prom_init.c, which doesn't
work.

I've boot tested this on pSeries LPAR and I'll get it going on a G5,
and Power3 tomorrow. Hopefully that'll go well and it'll boot on the
720, and then we can merge it, fingers x'ed!

NB. This applies on top of the other two NUMA fixes I just sent. If
they're no good let me know and I'll roll this doobie again without
them.

cheers

 arch/ppc64/kernel/iSeries_setup.c |   38 +++++++---
 arch/ppc64/kernel/lmb.c           |   33 +++++++++
 arch/ppc64/kernel/prom.c          |   15 ++++
 arch/ppc64/kernel/prom_init.c     |  137 +++++++++++++++++++++++++++++++++++---
 arch/ppc64/kernel/setup.c         |   20 ++++-
 arch/ppc64/mm/hash_utils.c        |   23 +++++-
 arch/ppc64/mm/numa.c              |   55 ++++++++++++---
 include/asm-ppc64/lmb.h           |    1 
 8 files changed, 284 insertions(+), 38 deletions(-)

Index: 2.6.12-rc1-mem-limit/arch/ppc64/kernel/setup.c
===================================================================
--- 2.6.12-rc1-mem-limit.orig/arch/ppc64/kernel/setup.c
+++ 2.6.12-rc1-mem-limit/arch/ppc64/kernel/setup.c
@@ -642,12 +642,11 @@ void __init setup_system(void)
 	early_console_initialized = 1;
 	register_console(&udbg_console);
 
-#endif /* !CONFIG_PPC_ISERIES */
-
 	/* Save unparsed command line copy for /proc/cmdline */
 	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
 
 	parse_early_param();
+#endif /* !CONFIG_PPC_ISERIES */
 
 #if defined(CONFIG_SMP) && !defined(CONFIG_PPC_ISERIES)
 	/*
@@ -806,20 +805,31 @@ struct seq_operations cpuinfo_op = {
 	.show =	show_cpuinfo,
 };
 
-#if 0 /* XXX not currently used */
+/*
+ * These three variables are used to save values passed to us by prom_init()
+ * via the device tree. The TCE variables are needed because with a memory_limit
+ * in force we may need to explicitly map the TCE are at the top of RAM.
+ */
 unsigned long memory_limit;
+unsigned long tce_alloc_start;
+unsigned long tce_alloc_end;
 
+#ifdef CONFIG_PPC_ISERIES
+/* 
+ * On iSeries we just parse the mem=X option from the command line.
+ * On pSeries it's a bit more complicated, see prom_init_mem()
+ */
 static int __init early_parsemem(char *p)
 {
 	if (!p)
 		return 0;
 
-	memory_limit = memparse(p, &p);
+	memory_limit = ALIGN(memparse(p, &p), PAGE_SIZE);
 
 	return 0;
 }
 early_param("mem", early_parsemem);
-#endif
+#endif /* CONFIG_PPC_ISERIES */
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
 static int __init set_preferred_console(void)
Index: 2.6.12-rc1-mem-limit/arch/ppc64/kernel/lmb.c
===================================================================
--- 2.6.12-rc1-mem-limit.orig/arch/ppc64/kernel/lmb.c
+++ 2.6.12-rc1-mem-limit/arch/ppc64/kernel/lmb.c
@@ -344,3 +344,36 @@ lmb_abs_to_phys(unsigned long aa)
 
 	return pa;
 }
+
+/*
+ * Truncate the lmb list to memory_limit if it's set
+ * You must call lmb_analyze() after this.
+ */
+void __init lmb_apply_memory_limit(void)
+{
+	extern unsigned long memory_limit;
+	unsigned long i, limit;
+	struct lmb_region *mem = &(lmb.memory);
+
+	if (! memory_limit)
+		return;
+
+	limit = memory_limit;
+	for (i = 0; i < mem->cnt; i++) {
+		if (limit > mem->region[i].size) {
+			limit -= mem->region[i].size;
+			continue;
+		}
+		
+#ifdef DEBUG
+		udbg_printf("lmb_truncate(): truncating at region %x\n", i);
+		udbg_printf("lmb_truncate(): total = %x\n", total);
+		udbg_printf("lmb_truncate(): size  = %x\n", mem->region[i].size);
+		udbg_printf("lmb_truncate(): crop = %x\n", crop);
+#endif
+
+		mem->region[i].size = limit;
+		mem->cnt = i + 1;
+		break;
+	}
+}
Index: 2.6.12-rc1-mem-limit/include/asm-ppc64/lmb.h
===================================================================
--- 2.6.12-rc1-mem-limit.orig/include/asm-ppc64/lmb.h
+++ 2.6.12-rc1-mem-limit/include/asm-ppc64/lmb.h
@@ -51,6 +51,7 @@ extern unsigned long __init lmb_alloc_ba
 extern unsigned long __init lmb_phys_mem_size(void);
 extern unsigned long __init lmb_end_of_DRAM(void);
 extern unsigned long __init lmb_abs_to_phys(unsigned long);
+extern void __init lmb_apply_memory_limit(void);
 
 extern void lmb_dump_all(void);
 
Index: 2.6.12-rc1-mem-limit/arch/ppc64/kernel/iSeries_setup.c
===================================================================
--- 2.6.12-rc1-mem-limit.orig/arch/ppc64/kernel/iSeries_setup.c
+++ 2.6.12-rc1-mem-limit/arch/ppc64/kernel/iSeries_setup.c
@@ -284,7 +284,7 @@ unsigned long iSeries_process_mainstore_
 	return mem_blocks;
 }
 
-static void __init iSeries_parse_cmdline(void)
+static void __init iSeries_get_cmdline(void)
 {
 	char *p, *q;
 
@@ -304,6 +304,8 @@ static void __init iSeries_parse_cmdline
 
 /*static*/ void __init iSeries_init_early(void)
 {
+	extern unsigned long memory_limit;
+
 	DBG(" -> iSeries_init_early()\n");
 
 	ppcdbg_initialize();
@@ -351,6 +353,29 @@ static void __init iSeries_parse_cmdline
 	 */
 	build_iSeries_Memory_Map();
 
+	iSeries_get_cmdline();
+	
+	/* Save unparsed command line copy for /proc/cmdline */
+	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
+	
+	/* Parse early parameters, in particular mem=x */
+	parse_early_param();
+	
+	if (memory_limit) {
+		if (memory_limit > systemcfg->physicalMemorySize)
+			printk("Ignoring 'mem' option, value %lu is too large.\n", memory_limit);
+		else
+			systemcfg->physicalMemorySize = memory_limit;
+	}
+
+	/* Bolt kernel mappings for all of memory (or just a bit if we've got a limit) */
+	iSeries_bolt_kernel(0, systemcfg->physicalMemorySize);
+	
+	lmb_init();
+	lmb_add(0, systemcfg->physicalMemorySize);
+	lmb_analyze();	/* ?? */
+	lmb_reserve(0, __pa(klimit));
+	
 	/* Initialize machine-dependency vectors */
 #ifdef CONFIG_SMP
 	smp_init_iSeries();
@@ -376,9 +401,6 @@ static void __init iSeries_parse_cmdline
 		initrd_start = initrd_end = 0;
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-
-	iSeries_parse_cmdline();
-
 	DBG(" <- iSeries_init_early()\n");
 }
 
@@ -539,14 +561,6 @@ static void __init build_iSeries_Memory_
 	 *   nextPhysChunk
 	 */
 	systemcfg->physicalMemorySize = chunk_to_addr(nextPhysChunk);
-
-	/* Bolt kernel mappings for all of memory */
-	iSeries_bolt_kernel(0, systemcfg->physicalMemorySize);
-
-	lmb_init();
-	lmb_add(0, systemcfg->physicalMemorySize);
-	lmb_analyze();	/* ?? */
-	lmb_reserve(0, __pa(klimit));
 }
 
 /*
Index: 2.6.12-rc1-mem-limit/arch/ppc64/kernel/prom.c
===================================================================
--- 2.6.12-rc1-mem-limit.orig/arch/ppc64/kernel/prom.c
+++ 2.6.12-rc1-mem-limit/arch/ppc64/kernel/prom.c
@@ -878,6 +878,8 @@ static int __init early_init_dt_scan_cho
 					    const char *full_path, void *data)
 {
 	u32 *prop;
+	u64 *prop64;
+	extern unsigned long memory_limit, tce_alloc_start, tce_alloc_end;
 
 	if (strcmp(full_path, "/chosen") != 0)
 		return 0;
@@ -894,6 +896,18 @@ static int __init early_init_dt_scan_cho
 	if (get_flat_dt_prop(node, "linux,iommu-force-on", NULL) != NULL)
 		iommu_force_on = 1;
 
+ 	prop64 = (u64*)get_flat_dt_prop(node, "linux,memory-limit", NULL);
+ 	if (prop64)
+ 		memory_limit = *prop64;
+ 		
+ 	prop64 = (u64*)get_flat_dt_prop(node, "linux,tce-alloc-start", NULL);
+ 	if (prop64)
+ 		tce_alloc_start = *prop64;
+ 		
+ 	prop64 = (u64*)get_flat_dt_prop(node, "linux,tce-alloc-end", NULL);
+ 	if (prop64)
+ 		tce_alloc_end = *prop64;
+ 
 #ifdef CONFIG_PPC_PSERIES
 	/* To help early debugging via the front panel, we retreive a minimal
 	 * set of RTAS infos now if available
@@ -1033,6 +1047,7 @@ void __init early_init_devtree(void *par
 	lmb_init();
 	scan_flat_dt(early_init_dt_scan_root, NULL);
 	scan_flat_dt(early_init_dt_scan_memory, NULL);
+	lmb_apply_memory_limit();
 	lmb_analyze();
 	systemcfg->physicalMemorySize = lmb_phys_mem_size();
 	lmb_reserve(0, __pa(klimit));
Index: 2.6.12-rc1-mem-limit/arch/ppc64/mm/hash_utils.c
===================================================================
--- 2.6.12-rc1-mem-limit.orig/arch/ppc64/mm/hash_utils.c
+++ 2.6.12-rc1-mem-limit/arch/ppc64/mm/hash_utils.c
@@ -149,6 +149,8 @@ void __init htab_initialize(void)
 	unsigned long pteg_count;
 	unsigned long mode_rw;
 	int i, use_largepages = 0;
+	unsigned long base = 0, size = 0;
+	extern unsigned long tce_alloc_start, tce_alloc_end;
 
 	DBG(" -> htab_initialize()\n");
 
@@ -204,8 +206,6 @@ void __init htab_initialize(void)
 
 	/* create bolted the linear mapping in the hash table */
 	for (i=0; i < lmb.memory.cnt; i++) {
-		unsigned long base, size;
-
 		base = lmb.memory.region[i].physbase + KERNELBASE;
 		size = lmb.memory.region[i].size;
 
@@ -234,6 +234,25 @@ void __init htab_initialize(void)
 #endif /* CONFIG_U3_DART */
 		create_pte_mapping(base, base + size, mode_rw, use_largepages);
 	}
+
+	/*
+	 * If we have a memory_limit and we've allocated TCEs then we need to
+	 * explicitly map the TCE area at the top of RAM. We also cope with the
+	 * case that the TCEs start below memory_limit.
+	 * tce_alloc_start/end are 16MB aligned so the mapping should work
+	 * for either 4K or 16MB pages.
+	 */
+	if (tce_alloc_start) {
+		tce_alloc_start += KERNELBASE;
+		tce_alloc_end += KERNELBASE;
+		
+		if (base + size >= tce_alloc_start)
+			tce_alloc_start = base + size + 1;
+		
+		create_pte_mapping(tce_alloc_start, tce_alloc_end,
+			mode_rw, use_largepages);
+	}
+	
 	DBG(" <- htab_initialize()\n");
 }
 #undef KB
Index: 2.6.12-rc1-mem-limit/arch/ppc64/mm/numa.c
===================================================================
--- 2.6.12-rc1-mem-limit.orig/arch/ppc64/mm/numa.c
+++ 2.6.12-rc1-mem-limit/arch/ppc64/mm/numa.c
@@ -285,6 +285,38 @@ static int cpu_numa_callback(struct noti
 	return ret;
 }
 
+/*
+ * Check and possibly modify a memory region to enforce the memory limit.
+ *
+ * Returns the size the region should have to enforce the memory limit.
+ * This will either be the original value of size, a truncated value,
+ * or zero. If the returned value of size is 0 the region should be
+ * discarded as it lies wholy above the memory limit.
+ */
+static unsigned long __init numa_enforce_memory_limit(unsigned long start, unsigned long size)
+{
+	/* We use lmb_end_of_DRAM() in here instead of memory_limit because
+	 * we've already adjusted it for the limit and it takes care of
+	 * having memory holes below the limit. */
+	extern unsigned long memory_limit;
+
+	if (! memory_limit)
+		return size;
+
+	if (start + size <= lmb_end_of_DRAM()) {
+		dbg("numa_enforce_memory_limit() size = %lx\n", size);
+		return size;
+	}
+
+	if (start >= lmb_end_of_DRAM()) {
+		dbg("numa_enforce_memory_limit() size = %lx\n", (unsigned long)0);
+		return 0;
+	}
+
+	dbg("numa_enforce_memory_limit() size = %lx\n", lmb_end_of_DRAM() - start);
+	return lmb_end_of_DRAM() - start;
+}
+
 static int __init parse_numa_properties(void)
 {
 	struct device_node *cpu = NULL;
@@ -373,6 +405,13 @@ new_range:
 		if (max_domain < numa_domain)
 			max_domain = numa_domain;
 
+		if (! (size = numa_enforce_memory_limit(start, size))) {
+			if (--ranges)
+				goto new_range;
+			else
+				continue;
+		}
+
 		/*
 		 * Initialize new node struct, or add to an existing one.
 		 */
@@ -405,8 +444,7 @@ new_range:
 			numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] =
 				numa_domain;
 
-		ranges--;
-		if (ranges)
+		if (--ranges)
 			goto new_range;
 	}
 
@@ -614,14 +652,16 @@ new_range:
 			if (numa_domain != nid)
 				continue;
 
-			if (mem_start >= start_paddr &&
-			   (mem_start + mem_size) <= end_paddr) {
-				/* should be no overlaps ! */
-				dbg("free_bootmem %lx %lx\n", mem_start, mem_size);
-				free_bootmem_node(NODE_DATA(nid), mem_start,
-						  mem_size);
-			}
-
+ 			if ((mem_size = numa_enforce_memory_limit(mem_start, mem_size))) {
+ 				if (mem_start >= start_paddr &&
+ 			    	(mem_start + mem_size) <= end_paddr) {
+ 					/* should be no overlaps ! */
+ 					dbg("free_bootmem %lx %lx\n", mem_start, mem_size);
+ 					free_bootmem_node(NODE_DATA(nid), mem_start,
+ 							  mem_size);
+ 				}
+  			}
+  
 			if (--ranges)		/* process all ranges in cell */
 				goto new_range;
 		}
Index: 2.6.12-rc1-mem-limit/arch/ppc64/kernel/prom_init.c
===================================================================
--- 2.6.12-rc1-mem-limit.orig/arch/ppc64/kernel/prom_init.c
+++ 2.6.12-rc1-mem-limit/arch/ppc64/kernel/prom_init.c
@@ -177,6 +177,10 @@ static int __initdata of_platform;
 
 static char __initdata prom_cmd_line[COMMAND_LINE_SIZE];
 
+static unsigned long __initdata prom_memory_limit;
+static unsigned long __initdata prom_tce_alloc_start;
+static unsigned long __initdata prom_tce_alloc_end;
+
 static unsigned long __initdata alloc_top;
 static unsigned long __initdata alloc_top_high;
 static unsigned long __initdata alloc_bottom;
@@ -384,10 +388,70 @@ static int __init prom_setprop(phandle n
 			 (u32)(unsigned long) value, (u32) valuelen);
 }
 
+/* We can't use the standard versions because of RELOC headaches. */
+#define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
+			 || ('a' <= (c) && (c) <= 'f') \
+			 || ('A' <= (c) && (c) <= 'F'))
+			 
+#define isdigit(c)	('0' <= (c) && (c) <= '9')
+#define islower(c)	('a' <= (c) && (c) <= 'z')
+#define toupper(c)	(islower(c) ? ((c) - 'a' + 'A') : (c))
+
+unsigned long prom_strtoul(const char *cp, const char **endp)
+{
+	unsigned long result = 0, base = 10, value;
+	
+	if (*cp == '0') {
+		base = 8;
+		cp++;
+		if (toupper(*cp) == 'X') {
+			cp++;
+			base = 16;
+		}
+	}
+
+	while (isxdigit(*cp) &&
+	       (value = isdigit(*cp) ? *cp - '0' : toupper(*cp) - 'A' + 10) < base) {
+		result = result * base + value;
+		cp++;
+	}
+	
+	if (endp)
+		*endp = cp;
+	
+	return result;
+}
+
+unsigned long prom_memparse(const char *ptr, const char **retptr)
+{
+	unsigned long ret = prom_strtoul(ptr, retptr);
+	int shift = 0;
+
+	/*
+	 * We can't use a switch here because GCC *may* generate a
+	 * jump table which won't work, because we're not running at
+	 * the address we're linked at.
+	 */
+	if ('G' == **retptr || 'g' == **retptr)
+		shift = 30;
+
+	if ('M' == **retptr || 'm' == **retptr)
+		shift = 20;
+
+	if ('K' == **retptr || 'k' == **retptr)
+		shift = 10;
+
+	if (shift) {
+		ret <<= shift;
+		(*retptr)++;
+	}
+
+	return ret;
+}
 
 /*
  * Early parsing of the command line passed to the kernel, used for
- * the options that affect the iommu
+ * "mem=x" and the options that affect the iommu
  */
 static void __init early_cmdline_parse(void)
 {
@@ -418,6 +482,14 @@ static void __init early_cmdline_parse(v
 		else if (!strncmp(opt, RELOC("force"), 5))
 			RELOC(iommu_force_on) = 1;
 	}
+	
+	opt = strstr(RELOC(prom_cmd_line), RELOC("mem="));
+	if (opt) {
+		opt += 4;
+		RELOC(prom_memory_limit) = prom_memparse(opt, (const char **)&opt);
+		/* Align to 16 MB == size of large page */
+		RELOC(prom_memory_limit) = ALIGN(RELOC(prom_memory_limit), 0x1000000);
+	}
 }
 
 /*
@@ -664,15 +736,7 @@ static void __init prom_init_mem(void)
 		}
 	}
 
-	/* Setup our top/bottom alloc points, that is top of RMO or top of
-	 * segment 0 when running non-LPAR
-	 */
-	if ( RELOC(of_platform) == PLATFORM_PSERIES_LPAR )
-		RELOC(alloc_top) = RELOC(rmo_top);
-	else
-		RELOC(alloc_top) = RELOC(rmo_top) = min(0x40000000ul, RELOC(ram_top));
 	RELOC(alloc_bottom) = PAGE_ALIGN(RELOC(klimit) - offset + 0x4000);
-	RELOC(alloc_top_high) = RELOC(ram_top);
 
 	/* Check if we have an initrd after the kernel, if we do move our bottom
 	 * point to after it
@@ -681,8 +745,41 @@ static void __init prom_init_mem(void)
 		if (RELOC(prom_initrd_end) > RELOC(alloc_bottom))
 			RELOC(alloc_bottom) = PAGE_ALIGN(RELOC(prom_initrd_end));
 	}
+	
+	/*
+	 * If prom_memory_limit is set we reduce the upper limits *except* for
+	 * alloc_top_high. This must be the real top of RAM so we can put
+	 * TCE's up there.
+	 */
+	
+	RELOC(alloc_top_high) = RELOC(ram_top);
+	
+	if (RELOC(prom_memory_limit)) {
+		if (RELOC(prom_memory_limit) <= RELOC(alloc_bottom)) {
+			prom_printf("Ignoring mem=%x <= alloc_bottom.\n",
+				RELOC(prom_memory_limit));
+			RELOC(prom_memory_limit) = 0;
+		} else if (RELOC(prom_memory_limit) >= RELOC(ram_top)) {
+			prom_printf("Ignoring mem=%x >= ram_top.\n",
+				RELOC(prom_memory_limit));
+			RELOC(prom_memory_limit) = 0;
+		} else {
+			RELOC(ram_top) = RELOC(prom_memory_limit);
+			RELOC(rmo_top) = min(RELOC(rmo_top), RELOC(prom_memory_limit));
+		}
+	}
+
+	/*
+	 * Setup our top alloc point, that is top of RMO or top of
+	 * segment 0 when running non-LPAR.
+	 */
+	if ( RELOC(of_platform) == PLATFORM_PSERIES_LPAR )
+		RELOC(alloc_top) = RELOC(rmo_top);
+	else
+		RELOC(alloc_top) = RELOC(rmo_top) = min(0x40000000ul, RELOC(ram_top));
 
 	prom_printf("memory layout at init:\n");
+	prom_printf("  memory_limit : %x (16 MB aligned)\n", RELOC(prom_memory_limit));
 	prom_printf("  alloc_bottom : %x\n", RELOC(alloc_bottom));
 	prom_printf("  alloc_top    : %x\n", RELOC(alloc_top));
 	prom_printf("  alloc_top_hi : %x\n", RELOC(alloc_top_high));
@@ -871,6 +968,16 @@ static void __init prom_initialize_tce_t
 
 	reserve_mem(local_alloc_bottom, local_alloc_top - local_alloc_bottom);
 
+	if (RELOC(prom_memory_limit)) {
+		/*
+		 * We align the start to a 16MB boundary so we can map the TCE area
+		 * using large pages if possible. The end should be the top of RAM
+		 * so no need to align it.
+		 */
+		RELOC(prom_tce_alloc_start) = _ALIGN_DOWN(local_alloc_bottom, 0x1000000);
+		RELOC(prom_tce_alloc_end) = local_alloc_top;
+	}
+	
 	/* Flag the first invalid entry */
 	prom_debug("ending prom_initialize_tce_table\n");
 }
@@ -1684,9 +1791,21 @@ unsigned long __init prom_init(unsigned 
 	 */
 	if (RELOC(ppc64_iommu_off))
 		prom_setprop(_prom->chosen, "linux,iommu-off", NULL, 0);
+
 	if (RELOC(iommu_force_on))
 		prom_setprop(_prom->chosen, "linux,iommu-force-on", NULL, 0);
 
+	if (RELOC(prom_memory_limit))
+		prom_setprop(_prom->chosen, "linux,memory-limit",
+			PTRRELOC(&prom_memory_limit), sizeof(RELOC(prom_memory_limit)));
+
+	if (RELOC(prom_tce_alloc_start)) {
+		prom_setprop(_prom->chosen, "linux,tce-alloc-start",
+			PTRRELOC(&prom_tce_alloc_start), sizeof(RELOC(prom_tce_alloc_start)));
+		prom_setprop(_prom->chosen, "linux,tce-alloc-end",
+			PTRRELOC(&prom_tce_alloc_end), sizeof(RELOC(prom_tce_alloc_end)));
+	}
+
 	/*
 	 * Now finally create the flattened device-tree
 	 */

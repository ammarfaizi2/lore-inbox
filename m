Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVC2Iao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVC2Iao (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVC2ILa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:11:30 -0500
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:55802 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262189AbVC2ICy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:02:54 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
Organization: IBM LTC
Subject: [PATCH] ppc64: Add mem=X boot command line option
Date: Tue, 29 Mar 2005 18:02:42 +1000
User-Agent: KMail/1.7.2
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       "PPC64-dev" <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503291802.43261.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch adds the mem=X boot command line option for PPC64.

On iSeries the user's mem=X value is aligned to PAGE_SIZE, on
pSeries we align to 16 MB which is the size of a large page.

The iSeries implementation is fairly straight forward, we declare mem=X
as an early_param() and then in iSeries_init_early() we modify the
systemcfg->physicalMemorySize based on that value.

On pSeries the mem=X option is parsed in prom_init.c before the kernel proper
starts, and is used to modify prom_init_mem()'s idea of memory. The mem=X
value and computed tce_alloc_start/end values are saved by prom_init() into
the device tree for later use by the kernel.

The device tree properties are read by the kernel in early_dt_scan_chosen(),
and used to modify the lmb structure in early_init_devtree(). That's the guts
of it.

On non-LPAR machines the tce_alloc_start/end values are read from the device
tree and used in htab_initialize() to make sure the TCE table is mapped at
the real top of RAM.

If NUMA is enabled we also have to make changes in parse_numa_properties()
and do_init_bootmem() to exclude memory regions above the memory limit,
and truncate any region which stradles the limit.

NB. This patch does not facilitate using mem=X to give drivers access to
large regions of contiguous memory.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

This is almost identical to the patch I posted last week, with one minor
change to make boot messages look the same on iSeries & pSeries, and
a few little white space and comment tweaks.

It has been tested on iSeries, pSeries, pSeries LPAR, G5 and Maple.

Thanks to BenH, Anton, Olof, Stephen, Mike & Maneesh for their help.

cheers!

 arch/ppc64/kernel/iSeries_setup.c |   40 +++++++----
 arch/ppc64/kernel/lmb.c           |   26 +++++++
 arch/ppc64/kernel/prom.c          |   15 ++++
 arch/ppc64/kernel/prom_init.c     |  137 +++++++++++++++++++++++++++++++++++---
 arch/ppc64/kernel/setup.c         |   20 ++++-
 arch/ppc64/mm/hash_utils.c        |   23 +++++-
 arch/ppc64/mm/numa.c              |   46 +++++++++++-
 include/asm-ppc64/lmb.h           |    1 
 8 files changed, 276 insertions(+), 32 deletions(-)

Index: bk-current/arch/ppc64/kernel/setup.c
===================================================================
--- bk-current.orig/arch/ppc64/kernel/setup.c
+++ bk-current/arch/ppc64/kernel/setup.c
@@ -636,12 +636,11 @@ void __init setup_system(void)
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
@@ -800,20 +799,31 @@ struct seq_operations cpuinfo_op = {
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
Index: bk-current/arch/ppc64/kernel/lmb.c
===================================================================
--- bk-current.orig/arch/ppc64/kernel/lmb.c
+++ bk-current/arch/ppc64/kernel/lmb.c
@@ -344,3 +344,29 @@ lmb_abs_to_phys(unsigned long aa)
 
 	return pa;
 }
+
+/*
+ * Truncate the lmb list to memory_limit if it's set
+ * You must call lmb_analyze() after this.
+ */
+void __init lmb_enforce_memory_limit(void)
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
+		mem->region[i].size = limit;
+		mem->cnt = i + 1;
+		break;
+	}
+}
Index: bk-current/include/asm-ppc64/lmb.h
===================================================================
--- bk-current.orig/include/asm-ppc64/lmb.h
+++ bk-current/include/asm-ppc64/lmb.h
@@ -51,6 +51,7 @@ extern unsigned long __init lmb_alloc_ba
 extern unsigned long __init lmb_phys_mem_size(void);
 extern unsigned long __init lmb_end_of_DRAM(void);
 extern unsigned long __init lmb_abs_to_phys(unsigned long);
+extern void __init lmb_enforce_memory_limit(void);
 
 extern void lmb_dump_all(void);
 
Index: bk-current/arch/ppc64/kernel/iSeries_setup.c
===================================================================
--- bk-current.orig/arch/ppc64/kernel/iSeries_setup.c
+++ bk-current/arch/ppc64/kernel/iSeries_setup.c
@@ -285,7 +285,7 @@ static unsigned long iSeries_process_mai
 	return mem_blocks;
 }
 
-static void __init iSeries_parse_cmdline(void)
+static void __init iSeries_get_cmdline(void)
 {
 	char *p, *q;
 
@@ -305,6 +305,8 @@ static void __init iSeries_parse_cmdline
 
 static void __init iSeries_init_early(void)
 {
+	extern unsigned long memory_limit;
+
 	DBG(" -> iSeries_init_early()\n");
 
 	ppcdbg_initialize();
@@ -352,6 +354,31 @@ static void __init iSeries_init_early(vo
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
+		if (memory_limit < systemcfg->physicalMemorySize)
+			systemcfg->physicalMemorySize = memory_limit;
+		else {
+			printk("Ignoring mem=%lu >= ram_top.\n", memory_limit);
+			memory_limit = 0;
+		}
+	}
+
+	/* Bolt kernel mappings for all of memory (or just a bit if we've got a limit) */
+	iSeries_bolt_kernel(0, systemcfg->physicalMemorySize);
+	
+	lmb_init();
+	lmb_add(0, systemcfg->physicalMemorySize);
+	lmb_analyze();
+	lmb_reserve(0, __pa(klimit));
+	
 	/* Initialize machine-dependency vectors */
 #ifdef CONFIG_SMP
 	smp_init_iSeries();
@@ -377,9 +404,6 @@ static void __init iSeries_init_early(vo
 		initrd_start = initrd_end = 0;
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-
-	iSeries_parse_cmdline();
-
 	DBG(" <- iSeries_init_early()\n");
 }
 
@@ -540,14 +564,6 @@ static void __init build_iSeries_Memory_
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
Index: bk-current/arch/ppc64/kernel/prom.c
===================================================================
--- bk-current.orig/arch/ppc64/kernel/prom.c
+++ bk-current/arch/ppc64/kernel/prom.c
@@ -912,6 +912,8 @@ static int __init early_init_dt_scan_cho
 					    const char *full_path, void *data)
 {
 	u32 *prop;
+	u64 *prop64;
+	extern unsigned long memory_limit, tce_alloc_start, tce_alloc_end;
 
 	if (strcmp(full_path, "/chosen") != 0)
 		return 0;
@@ -928,6 +930,18 @@ static int __init early_init_dt_scan_cho
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
 #ifdef CONFIG_PPC_RTAS
 	/* To help early debugging via the front panel, we retreive a minimal
 	 * set of RTAS infos now if available
@@ -1067,6 +1081,7 @@ void __init early_init_devtree(void *par
 	lmb_init();
 	scan_flat_dt(early_init_dt_scan_root, NULL);
 	scan_flat_dt(early_init_dt_scan_memory, NULL);
+	lmb_enforce_memory_limit();
 	lmb_analyze();
 	systemcfg->physicalMemorySize = lmb_phys_mem_size();
 	lmb_reserve(0, __pa(klimit));
Index: bk-current/arch/ppc64/mm/hash_utils.c
===================================================================
--- bk-current.orig/arch/ppc64/mm/hash_utils.c
+++ bk-current/arch/ppc64/mm/hash_utils.c
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
Index: bk-current/arch/ppc64/mm/numa.c
===================================================================
--- bk-current.orig/arch/ppc64/mm/numa.c
+++ bk-current/arch/ppc64/mm/numa.c
@@ -285,6 +285,35 @@ static int cpu_numa_callback(struct noti
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
+	/*
+	 * We use lmb_end_of_DRAM() in here instead of memory_limit because
+	 * we've already adjusted it for the limit and it takes care of
+	 * having memory holes below the limit.
+	 */
+	extern unsigned long memory_limit;
+
+	if (! memory_limit)
+		return size;
+
+	if (start + size <= lmb_end_of_DRAM())
+		return size;
+
+	if (start >= lmb_end_of_DRAM())
+		return 0;
+
+	return lmb_end_of_DRAM() - start;
+}
+
 static int __init parse_numa_properties(void)
 {
 	struct device_node *cpu = NULL;
@@ -373,6 +402,13 @@ new_range:
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
@@ -405,8 +441,7 @@ new_range:
 			numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] =
 				numa_domain;
 
-		ranges--;
-		if (ranges)
+		if (--ranges)
 			goto new_range;
 	}
 
@@ -614,8 +649,11 @@ new_range:
 			if (numa_domain != nid)
 				continue;
 
-			dbg("free_bootmem %lx %lx\n", mem_start, mem_size);
-			free_bootmem_node(NODE_DATA(nid), mem_start, mem_size);
+			mem_size = numa_enforce_memory_limit(mem_start, mem_size);
+  			if (mem_size) {
+  				dbg("free_bootmem %lx %lx\n", mem_start, mem_size);
+  				free_bootmem_node(NODE_DATA(nid), mem_start, mem_size);
+			}
 
 			if (--ranges)		/* process all ranges in cell */
 				goto new_range;
Index: bk-current/arch/ppc64/kernel/prom_init.c
===================================================================
--- bk-current.orig/arch/ppc64/kernel/prom_init.c
+++ bk-current/arch/ppc64/kernel/prom_init.c
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

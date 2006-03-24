Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423148AbWCXFmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423148AbWCXFmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423156AbWCXFmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:42:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:25044 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1423148AbWCXFmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:42:52 -0500
Subject: [PATCH] powerpc: Kill machine numbers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 16:42:26 +1100
Message-Id: <1143178947.4257.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes statically assigned machine numbers and reworks the
powerpc platform probe code to use a better mecanism when board support
files can simply declare a new machine type with a macro and implement a
probe() function that uses the flattened device-tree to detect if they
apply for a given machine.

This patch is tested & booted on 64 bits iseries, pseries and powermac
and builds for cell and 32 bits powermac.

It does break ARCH=ppc at the moment. The fix now will be to remove all
occurences of _machine there and either:
 - make prep a config option of it's own in arch/ppc (easy)
 - move prep over to arch/powerpc and kill completely MULTIPLATFORM for
arch/ppc (harder since prep relies on a lot of cruft in the boot wrapper
that needs to be ported over too, but also the best long term solution) 

I will try to do one of the above asap. Help welcome with the
bootwrapper crud :)

Index: linux-work/arch/powerpc/kernel/prom.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom.c	2006-03-24 11:45:28.000000000 +1100
@@ -383,14 +383,14 @@ static int __devinit finish_node_interru
 			/* Apple uses bits in there in a different way, let's
 			 * only keep the real sense bit on macs
 			 */
-			if (_machine == PLATFORM_POWERMAC)
+			if (machine_is(powermac))
 				sense &= 0x1;
 			np->intrs[intrcount].sense = map_mpic_senses[sense];
 		}
 
 #ifdef CONFIG_PPC64
 		/* We offset irq numbers for the u3 MPIC by 128 in PowerMac */
-		if (_machine == PLATFORM_POWERMAC && ic && ic->parent) {
+		if (machine_is(powermac) && ic && ic->parent) {
 			char *name = get_property(ic->parent, "name", NULL);
 			if (name && !strcmp(name, "u3"))
 				np->intrs[intrcount].line += 128;
@@ -570,6 +570,18 @@ int __init of_scan_flat_dt(int (*it)(uns
 	return rc;
 }
 
+unsigned long __init of_get_flat_dt_root(void)
+{
+	unsigned long p = ((unsigned long)initial_boot_params) +
+		initial_boot_params->off_dt_struct;
+
+	while(*((u32 *)p) == OF_DT_NOP)
+		p += 4;
+	BUG_ON (*((u32 *)p) != OF_DT_BEGIN_NODE);
+	p += 4;
+	return _ALIGN(p + strlen((char *)p) + 1, 4);
+}
+
 /**
  * This  function can be used within scan_flattened_dt callback to get
  * access to properties
@@ -612,6 +624,25 @@ void* __init of_get_flat_dt_prop(unsigne
 	} while(1);
 }
 
+int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
+{
+	const char* cp;
+	unsigned long cplen, l;
+
+	cp = of_get_flat_dt_prop(node, "compatible", &cplen);
+	if (cp == NULL)
+		return 0;
+	while (cplen > 0) {
+		if (strncasecmp(cp, compat, strlen(compat)) == 0)
+			return 1;
+		l = strlen(cp) + 1;
+		cp += l;
+		cplen -= l;
+	}
+
+	return 0;
+}
+
 static void *__init unflatten_dt_alloc(unsigned long *mem, unsigned long size,
 				       unsigned long align)
 {
@@ -686,7 +717,7 @@ static unsigned long __init unflatten_dt
 #ifdef DEBUG
 				if ((strlen(p) + l + 1) != allocl) {
 					DBG("%s: p: %d, l: %d, a: %d\n",
-					    pathp, strlen(p), l, allocl);
+					    pathp, (int)strlen(p), l, allocl);
 				}
 #endif
 				p += strlen(p);
@@ -919,7 +950,6 @@ static int __init early_init_dt_scan_cpu
 static int __init early_init_dt_scan_chosen(unsigned long node,
 					    const char *uname, int depth, void *data)
 {
-	u32 *prop;
 	unsigned long *lprop;
 	unsigned long l;
 	char *p;
@@ -930,14 +960,6 @@ static int __init early_init_dt_scan_cho
 	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
 		return 0;
 
-	/* get platform type */
-	prop = (u32 *)of_get_flat_dt_prop(node, "linux,platform", NULL);
-	if (prop == NULL)
-		return 0;
-#ifdef CONFIG_PPC_MULTIPLATFORM
-	_machine = *prop;
-#endif
-
 #ifdef CONFIG_PPC64
 	/* check if iommu is forced on or off */
 	if (of_get_flat_dt_prop(node, "linux,iommu-off", NULL) != NULL)
@@ -964,15 +986,15 @@ static int __init early_init_dt_scan_cho
 	 * set of RTAS infos now if available
 	 */
 	{
-		u64 *basep, *entryp;
+		u64 *basep, *entryp, *sizep;
 
 		basep = of_get_flat_dt_prop(node, "linux,rtas-base", NULL);
 		entryp = of_get_flat_dt_prop(node, "linux,rtas-entry", NULL);
-		prop = of_get_flat_dt_prop(node, "linux,rtas-size", NULL);
-		if (basep && entryp && prop) {
+		sizep = of_get_flat_dt_prop(node, "linux,rtas-size", NULL);
+		if (basep && entryp && sizep) {
 			rtas.base = *basep;
 			rtas.entry = *entryp;
-			rtas.size = *prop;
+			rtas.size = *sizep;
 		}
 	}
 #endif /* CONFIG_PPC_RTAS */
@@ -1755,7 +1777,7 @@ static int of_finish_dynamic_node(struct
 	/* We don't support that function on PowerMac, at least
 	 * not yet
 	 */
-	if (_machine == PLATFORM_POWERMAC)
+	if (machine_is(powermac))
 		return -ENODEV;
 
 	/* fix up new node's linux_phandle field */
Index: linux-work/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup-common.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup-common.c	2006-03-24 11:45:28.000000000 +1100
@@ -9,6 +9,9 @@
  *      as published by the Free Software Foundation; either version
  *      2 of the License, or (at your option) any later version.
  */
+
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/string.h>
@@ -41,6 +44,7 @@
 #include <asm/time.h>
 #include <asm/cputable.h>
 #include <asm/sections.h>
+#include <asm/firmware.h>
 #include <asm/btext.h>
 #include <asm/nvram.h>
 #include <asm/setup.h>
@@ -56,8 +60,6 @@
 
 #include "setup.h"
 
-#undef DEBUG
-
 #ifdef DEBUG
 #include <asm/udbg.h>
 #define DBG(fmt...) udbg_printf(fmt)
@@ -65,10 +67,12 @@
 #define DBG(fmt...)
 #endif
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
-int _machine = 0;
-EXPORT_SYMBOL(_machine);
-#endif
+/* The main machine-dep calls structure
+ */
+struct machdep_calls ppc_md;
+EXPORT_SYMBOL(ppc_md);
+struct machdep_calls *machine_id;
+EXPORT_SYMBOL(machine_id);
 
 unsigned long klimit = (unsigned long) _end;
 
@@ -399,7 +403,7 @@ void __init smp_setup_cpu_maps(void)
 	 * On pSeries LPAR, we need to know how many cpus
 	 * could possibly be added to this partition.
 	 */
-	if (_machine == PLATFORM_PSERIES_LPAR &&
+	if (machine_is(pseries) && firmware_has_feature(FW_FEATURE_LPAR) &&
 	    (dn = of_find_node_by_path("/rtas"))) {
 		int num_addr_cell, num_size_cell, maxcpus;
 		unsigned int *ireg;
@@ -468,3 +472,32 @@ static int __init early_xmon(char *p)
 }
 early_param("xmon", early_xmon);
 #endif
+
+void probe_machine(void)
+{
+	extern struct machdep_calls __machine_desc_start;
+	extern struct machdep_calls __machine_desc_end;
+
+	/*
+	 * Iterate all ppc_md structures until we find the proper
+	 * one for the current machine type
+	 */
+	DBG("Probing machine type ...\n");
+
+	for (machine_id = &__machine_desc_start;
+	     machine_id < &__machine_desc_end;
+	     machine_id++) {
+		DBG("  %s ...", machine_id->name);
+		memcpy(&ppc_md, machine_id, sizeof(struct machdep_calls));
+		if (ppc_md.probe()) {
+			DBG(" match !\n");
+			break;
+		}
+		DBG("\n");
+	}
+	/* What can we do if we didn't find ? */
+	if (machine_id >= &__machine_desc_end) {
+		DBG("No suitable machine found !\n");
+		for (;;);
+	}
+}
Index: linux-work/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_32.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup_32.c	2006-03-24 11:45:28.000000000 +1100
@@ -70,10 +70,6 @@ unsigned int DMA_MODE_WRITE;
 int have_of = 1;
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
-extern void prep_init(void);
-extern void pmac_init(void);
-extern void chrp_init(void);
-
 dev_t boot_dev;
 #endif /* CONFIG_PPC_MULTIPLATFORM */
 
@@ -85,9 +81,6 @@ unsigned long SYSRQ_KEY = 0x54;
 unsigned long vgacon_remap_base;
 #endif
 
-struct machdep_calls ppc_md;
-EXPORT_SYMBOL(ppc_md);
-
 /*
  * These are used in binfmt_elf.c to put aux entries on the stack
  * for each elf executable being started.
@@ -123,48 +116,6 @@ unsigned long __init early_init(unsigned
 	return KERNELBASE + offset;
 }
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
-/*
- * The PPC_MULTIPLATFORM version of platform_init...
- */
-void __init platform_init(void)
-{
-	/* if we didn't get any bootinfo telling us what we are... */
-	if (_machine == 0) {
-		/* prep boot loader tells us if we're prep or not */
-		if ( *(unsigned long *)(KERNELBASE) == (0xdeadc0de) )
-			_machine = _MACH_prep;
-	}
-
-#ifdef CONFIG_PPC_PREP
-	/* not much more to do here, if prep */
-	if (_machine == _MACH_prep) {
-		prep_init();
-		return;
-	}
-#endif
-
-#ifdef CONFIG_ADB
-	if (strstr(cmd_line, "adb_sync")) {
-		extern int __adb_probe_sync;
-		__adb_probe_sync = 1;
-	}
-#endif /* CONFIG_ADB */
-
-	switch (_machine) {
-#ifdef CONFIG_PPC_PMAC
-	case _MACH_Pmac:
-		pmac_init();
-		break;
-#endif
-#ifdef CONFIG_PPC_CHRP
-	case _MACH_chrp:
-		chrp_init();
-		break;
-#endif
-	}
-}
-#endif
 
 /*
  * Find out what kind of machine we're on and save any data we need
@@ -190,8 +141,12 @@ void __init machine_init(unsigned long d
 		strlcpy(cmd_line, CONFIG_CMDLINE, sizeof(cmd_line));
 #endif /* CONFIG_CMDLINE */
 
-	/* Base init based on machine type */
+#ifdef CONFIG_PPC_MULTIPLATFORM
+	probe_machine();
+#else
+	/* Base init based on machine type. Obsoloete, please kill ! */
 	platform_init();
+#endif
 
 #ifdef CONFIG_6xx
 	ppc_md.power_save = ppc6xx_idle;
@@ -366,7 +321,4 @@ void __init setup_arch(char **cmdline_p)
 	if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);
 
 	paging_init();
-
-	/* this is for modules since _machine can be a define -- Cort */
-	ppc_md.ppc_machine = _machine;
 }
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup_64.c	2006-03-24 11:45:28.000000000 +1100
@@ -96,11 +96,6 @@ int dcache_bsize;
 int icache_bsize;
 int ucache_bsize;
 
-/* The main machine-dep calls structure
- */
-struct machdep_calls ppc_md;
-EXPORT_SYMBOL(ppc_md);
-
 #ifdef CONFIG_MAGIC_SYSRQ
 unsigned long SYSRQ_KEY;
 #endif /* CONFIG_MAGIC_SYSRQ */
@@ -161,32 +156,6 @@ early_param("smt-enabled", early_smt_ena
 #define check_smt_enabled()
 #endif /* CONFIG_SMP */
 
-extern struct machdep_calls pSeries_md;
-extern struct machdep_calls pmac_md;
-extern struct machdep_calls maple_md;
-extern struct machdep_calls cell_md;
-extern struct machdep_calls iseries_md;
-
-/* Ultimately, stuff them in an elf section like initcalls... */
-static struct machdep_calls __initdata *machines[] = {
-#ifdef CONFIG_PPC_PSERIES
-	&pSeries_md,
-#endif /* CONFIG_PPC_PSERIES */
-#ifdef CONFIG_PPC_PMAC
-	&pmac_md,
-#endif /* CONFIG_PPC_PMAC */
-#ifdef CONFIG_PPC_MAPLE
-	&maple_md,
-#endif /* CONFIG_PPC_MAPLE */
-#ifdef CONFIG_PPC_CELL
-	&cell_md,
-#endif
-#ifdef CONFIG_PPC_ISERIES
-	&iseries_md,
-#endif
-	NULL
-};
-
 /*
  * Early initialization entry point. This is called by head.S
  * with MMU translation disabled. We rely on the "feature" of
@@ -209,12 +178,11 @@ static struct machdep_calls __initdata *
 void __init early_setup(unsigned long dt_ptr)
 {
 	struct paca_struct *lpaca = get_paca();
-	static struct machdep_calls **mach;
 
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
-	DBG(" -> early_setup()\n");
+	DBG(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
 
 	/*
 	 * Do early initializations using the flattened device
@@ -223,22 +191,8 @@ void __init early_setup(unsigned long dt
 	 */
 	early_init_devtree(__va(dt_ptr));
 
-	/*
-	 * Iterate all ppc_md structures until we find the proper
-	 * one for the current machine type
-	 */
-	DBG("Probing machine type for platform %x...\n", _machine);
-
-	for (mach = machines; *mach; mach++) {
-		if ((*mach)->probe(_machine))
-			break;
-	}
-	/* What can we do if we didn't find ? */
-	if (*mach == NULL) {
-		DBG("No suitable machine found !\n");
-		for (;;);
-	}
-	ppc_md = **mach;
+	/* Probe the machine type */
+	probe_machine();
 
 #ifdef CONFIG_CRASH_DUMP
 	kdump_setup();
@@ -340,7 +294,7 @@ static void __init initialize_cache_info
 			const char *dc, *ic;
 
 			/* Then read cache informations */
-			if (_machine == PLATFORM_POWERMAC) {
+			if (machine_is(powermac)) {
 				dc = "d-cache-block-size";
 				ic = "i-cache-block-size";
 			} else {
@@ -484,7 +438,6 @@ void __init setup_system(void)
 	printk("ppc64_pft_size                = 0x%lx\n", ppc64_pft_size);
 	printk("ppc64_interrupt_controller    = 0x%ld\n",
 	       ppc64_interrupt_controller);
-	printk("platform                      = 0x%x\n", _machine);
 	printk("physicalMemorySize            = 0x%lx\n", lmb_phys_mem_size());
 	printk("ppc64_caches.dcache_line_size = 0x%x\n",
 	       ppc64_caches.dline_size);
Index: linux-work/arch/powerpc/kernel/vmlinux.lds.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vmlinux.lds.S	2006-01-14 14:43:22.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vmlinux.lds.S	2006-03-24 11:45:28.000000000 +1100
@@ -1,9 +1,11 @@
 #include <linux/config.h>
 #ifdef CONFIG_PPC64
 #include <asm/page.h>
+#define PROVIDE32(x)	PROVIDE(__unused__##x)
 #else
 #define PAGE_SIZE	4096
 #define KERNELBASE	CONFIG_KERNEL_START
+#define PROVIDE32(x)	PROVIDE(x)
 #endif
 #include <asm-generic/vmlinux.lds.h>
 
@@ -18,43 +20,42 @@ jiffies = jiffies_64 + 4;
 #endif
 SECTIONS
 {
-  /* Sections to be discarded. */
-  /DISCARD/ : {
-    *(.exitcall.exit)
-    *(.exit.data)
-  }
-
-  . = KERNELBASE;
-
-  /* Read-only sections, merged into text segment: */
-  .text : {
-    *(.text .text.*)
-    SCHED_TEXT
-    LOCK_TEXT
-    KPROBES_TEXT
-    *(.fixup)
-#ifdef CONFIG_PPC32
-    *(.got1)
-    __got2_start = .;
-    *(.got2)
-    __got2_end = .;
-#else
-    . = ALIGN(PAGE_SIZE);
-    _etext = .;
-#endif
-  }
-#ifdef CONFIG_PPC32
-  _etext = .;
-  PROVIDE (etext = .);
+	/* Sections to be discarded. */
+	/DISCARD/ : {
+	*(.exitcall.exit)
+	*(.exit.data)
+	}
 
-  RODATA
-  .fini      : { *(.fini)    } =0
-  .ctors     : { *(.ctors)   }
-  .dtors     : { *(.dtors)   }
+	. = KERNELBASE;
 
-  .fixup   : { *(.fixup) }
-#endif
+/*
+ * Text, read only data and other permanent read-only sections
+ */
+
+	/* Text and gots */
+	.text : {
+		*(.text .text.*)
+		SCHED_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		*(.fixup)
+
+#ifdef CONFIG_PPC32
+		*(.got1)
+		__got2_start = .;
+		*(.got2)
+		__got2_end = .;
+#endif /* CONFIG_PPC32 */
+
+		. = ALIGN(PAGE_SIZE);
+		_etext = .;
+		PROVIDE32 (etext = .);
+	}
+
+	/* Read-only data */
+	RODATA
 
+	/* Exception & bug tables */
 	__ex_table : {
 		__start___ex_table = .;
 		*(__ex_table)
@@ -67,192 +68,172 @@ SECTIONS
 		__stop___bug_table = .;
 	}
 
-#ifdef CONFIG_PPC64
+/*
+ * Init sections discarded at runtime
+ */
+	. = ALIGN(PAGE_SIZE);
+	__init_begin = .;
+
+	.init.text : {
+		_sinittext = .;
+		*(.init.text)
+		_einittext = .;
+	}
+
+	/* .exit.text is discarded at runtime, not link time,
+	 * to deal with references from __bug_table
+	 */
+	.exit.text : { *(.exit.text) }
+
+	.init.data : {
+		*(.init.data);
+		__vtop_table_begin = .;
+		*(.vtop_fixup);
+		__vtop_table_end = .;
+		__ptov_table_begin = .;
+		*(.ptov_fixup);
+		__ptov_table_end = .;
+	}
+
+	. = ALIGN(16);
+	.init.setup : {
+		__setup_start = .;
+		*(.init.setup)
+		__setup_end = .;
+	}
+
+	.initcall.init : {
+		__initcall_start = .;
+		*(.initcall1.init)
+		*(.initcall2.init)
+		*(.initcall3.init)
+		*(.initcall4.init)
+		*(.initcall5.init)
+		*(.initcall6.init)
+		*(.initcall7.init)
+		__initcall_end = .;
+		}
+
+	.con_initcall.init : {
+		__con_initcall_start = .;
+		*(.con_initcall.init)
+		__con_initcall_end = .;
+	}
+
+	SECURITY_INIT
+
+	. = ALIGN(8);
 	__ftr_fixup : {
 		__start___ftr_fixup = .;
 		*(__ftr_fixup)
 		__stop___ftr_fixup = .;
 	}
 
-  RODATA
-#endif
+	. = ALIGN(PAGE_SIZE);
+	.init.ramfs : {
+		__initramfs_start = .;
+		*(.init.ramfs)
+		__initramfs_end = .;
+	}
 
 #ifdef CONFIG_PPC32
-  /* Read-write section, merged into data segment: */
-  . = ALIGN(PAGE_SIZE);
-  _sdata = .;
-  .data    :
-  {
-    *(.data)
-    *(.data1)
-    *(.sdata)
-    *(.sdata2)
-    *(.got.plt) *(.got)
-    *(.dynamic)
-    CONSTRUCTORS
-  }
-
-  . = ALIGN(PAGE_SIZE);
-  __nosave_begin = .;
-  .data_nosave : { *(.data.nosave) }
-  . = ALIGN(PAGE_SIZE);
-  __nosave_end = .;
+	. = ALIGN(32);
+#else
+	. = ALIGN(128);
+#endif
+	.data.percpu : {
+		__per_cpu_start = .;
+		*(.data.percpu)
+		__per_cpu_end = .;
+	}
 
-  . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+	. = ALIGN(8);
+	.machine.desc : {
+		__machine_desc_start = . ;
+		*(.machine.desc)
+		__machine_desc_end = . ;
+	}
 
-  _edata  =  .;
-  PROVIDE (edata = .);
+	/* freed after init ends here */
+	. = ALIGN(PAGE_SIZE);
+	__init_end = .;
+
+/*
+ * And now the various read/write data
+ */
+
+	. = ALIGN(PAGE_SIZE);
+	_sdata = .;
+
+#ifdef CONFIG_PPC32
+	.data    :
+	{
+		*(.data)
+		*(.sdata)
+		*(.got.plt) *(.got)
+	}
+#else
+	.data : {
+		*(.data .data.rel* .toc1)
+		*(.branch_lt)
+	}
 
-  . = ALIGN(8192);
-  .data.init_task : { *(.data.init_task) }
-#endif
+	.opd : {
+		*(.opd)
+	}
 
-  /* will be freed after init */
-  . = ALIGN(PAGE_SIZE);
-  __init_begin = .;
-  .init.text : {
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-#ifdef CONFIG_PPC32
-  /* .exit.text is discarded at runtime, not link time,
-     to deal with references from __bug_table */
-  .exit.text : { *(.exit.text) }
+	.got : {
+		__toc_start = .;
+		*(.got)
+		*(.toc)
+	}
 #endif
-  .init.data : {
-    *(.init.data);
-    __vtop_table_begin = .;
-    *(.vtop_fixup);
-    __vtop_table_end = .;
-    __ptov_table_begin = .;
-    *(.ptov_fixup);
-    __ptov_table_end = .;
-  }
-
-  . = ALIGN(16);
-  .init.setup : {
-    __setup_start = .;
-    *(.init.setup)
-    __setup_end = .;
-  }
-
-  .initcall.init : {
-	__initcall_start = .;
-	*(.initcall1.init)
-	*(.initcall2.init)
-	*(.initcall3.init)
-	*(.initcall4.init)
-	*(.initcall5.init)
-	*(.initcall6.init)
-	*(.initcall7.init)
-	__initcall_end = .;
-  }
-
-  .con_initcall.init : {
-    __con_initcall_start = .;
-    *(.con_initcall.init)
-    __con_initcall_end = .;
-  }
 
-  SECURITY_INIT
+	. = ALIGN(PAGE_SIZE);
+	_edata  =  .;
+	PROVIDE32 (edata = .);
 
+	/* The initial task and kernel stack */
 #ifdef CONFIG_PPC32
-  __start___ftr_fixup = .;
-  __ftr_fixup : { *(__ftr_fixup) }
-  __stop___ftr_fixup = .;
+	. = ALIGN(8192);
 #else
-  . = ALIGN(PAGE_SIZE);
-  .init.ramfs : {
-    __initramfs_start = .;
-    *(.init.ramfs)
-    __initramfs_end = .;
-  }
-#endif
-
-#ifdef CONFIG_PPC32
-  . = ALIGN(32);
+	. = ALIGN(16384);
 #endif
-  .data.percpu : {
-    __per_cpu_start = .;
-    *(.data.percpu)
-    __per_cpu_end = .;
-  }
+	.data.init_task : {
+		*(.data.init_task)
+	}
 
- . = ALIGN(PAGE_SIZE);
-#ifdef CONFIG_PPC64
- . = ALIGN(16384);
- __init_end = .;
- /* freed after init ends here */
-
- /* Read/write sections */
- . = ALIGN(PAGE_SIZE);
- . = ALIGN(16384);
- _sdata = .;
- /* The initial task and kernel stack */
- .data.init_task : {
-      *(.data.init_task)
-      }
-
- . = ALIGN(PAGE_SIZE);
- .data.page_aligned : {
-      *(.data.page_aligned)
-      }
-
- .data.cacheline_aligned : {
-      *(.data.cacheline_aligned)
-      }
-
- .data : {
-      *(.data .data.rel* .toc1)
-      *(.branch_lt)
-      }
-
- .opd : {
-      *(.opd)
-      }
-
- .got : {
-      __toc_start = .;
-      *(.got)
-      *(.toc)
-      . = ALIGN(PAGE_SIZE);
-      _edata = .;
-      }
+	. = ALIGN(PAGE_SIZE);
+	.data.page_aligned : {
+		*(.data.page_aligned)
+	}
 
-  . = ALIGN(PAGE_SIZE);
-#else
-  __initramfs_start = .;
-  .init.ramfs : {
-    *(.init.ramfs)
-  }
-  __initramfs_end = .;
-
-  . = ALIGN(4096);
-  __init_end = .;
-
-  . = ALIGN(4096);
-  _sextratext = .;
-  _eextratext = .;
+	.data.cacheline_aligned : {
+		*(.data.cacheline_aligned)
+	}
 
-  __bss_start = .;
-#endif
+	. = ALIGN(PAGE_SIZE);
+	__data_nosave : {
+		__nosave_begin = .;
+		*(.data.nosave)
+		. = ALIGN(PAGE_SIZE);
+		__nosave_end = .;
+	}
 
-  .bss : {
-    __bss_start = .;
-   *(.sbss) *(.scommon)
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-  __bss_stop = .;
-  }
+/*
+ * And finally the bss
+ */
+
+	.bss : {
+		__bss_start = .;
+		*(.sbss) *(.scommon)
+		*(.dynbss)
+		*(.bss)
+		*(COMMON)
+		__bss_stop = .;
+	}
 
-#ifdef CONFIG_PPC64
-  . = ALIGN(PAGE_SIZE);
-#endif
-  _end = . ;
-#ifdef CONFIG_PPC32
-  PROVIDE (end = .);
-#endif
+	. = ALIGN(PAGE_SIZE);
+	_end = . ;
+	PROVIDE32 (end = .);
 }
Index: linux-work/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/setup.c	2006-03-23 14:26:08.000000000 +1100
+++ linux-work/arch/powerpc/platforms/cell/setup.c	2006-03-24 11:45:28.000000000 +1100
@@ -195,9 +195,10 @@ static void __init cell_init_early(void)
 }
 
 
-static int __init cell_probe(int platform)
+static int __init cell_probe(void)
 {
-	if (platform != PLATFORM_CELL)
+	unsigned long root = of_get_flat_dt_root();
+	if (!of_flat_dt_is_compatible(root, "IBM,CPB"))
 		return 0;
 
 	return 1;
@@ -212,7 +213,7 @@ static int cell_check_legacy_ioport(unsi
 	return -ENODEV;
 }
 
-struct machdep_calls __initdata cell_md = {
+define_machine(cell) {
 	.probe			= cell_probe,
 	.setup_arch		= cell_setup_arch,
 	.init_early		= cell_init_early,
Index: linux-work/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/iseries/setup.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/platforms/iseries/setup.c	2006-03-24 11:45:28.000000000 +1100
@@ -675,9 +675,10 @@ static void iseries_dedicated_idle(void)
 void __init iSeries_init_IRQ(void) { }
 #endif
 
-static int __init iseries_probe(int platform)
+static int __init iseries_probe(void)
 {
-	if (PLATFORM_ISERIES_LPAR != platform)
+	unsigned long root = of_get_flat_dt_root();
+	if (!of_flat_dt_is_compatible(root, "IBM,iSeries"))
 		return 0;
 
 	ppc64_firmware_features |= FW_FEATURE_ISERIES;
@@ -686,7 +687,8 @@ static int __init iseries_probe(int plat
 	return 1;
 }
 
-struct machdep_calls __initdata iseries_md = {
+define_machine(iseries) {
+	.name		= "iSeries",
 	.setup_arch	= iSeries_setup_arch,
 	.show_cpuinfo	= iSeries_show_cpuinfo,
 	.init_IRQ	= iSeries_init_IRQ,
@@ -930,7 +932,6 @@ void build_flat_dt(struct iseries_flat_d
 
 	/* /chosen */
 	dt_start_node(dt, "chosen");
-	dt_prop_u32(dt, "linux,platform", PLATFORM_ISERIES_LPAR);
 	dt_prop_str(dt, "bootargs", cmd_line);
 	if (cmd_mem_limit)
 		dt_prop_u64(dt, "linux,memory-limit", cmd_mem_limit);
Index: linux-work/arch/powerpc/platforms/maple/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/maple/setup.c	2006-03-10 15:58:17.000000000 +1100
+++ linux-work/arch/powerpc/platforms/maple/setup.c	2006-03-24 11:45:28.000000000 +1100
@@ -259,9 +259,10 @@ static void __init maple_progress(char *
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
-static int __init maple_probe(int platform)
+static int __init maple_probe(void)
 {
-	if (platform != PLATFORM_MAPLE)
+	unsigned long root = of_get_flat_dt_root();
+	if (!of_flat_dt_is_compatible(root, "Momentum,Maple"))
 		return 0;
 	/*
 	 * On U3, the DART (iommu) must be allocated now since it
@@ -274,7 +275,8 @@ static int __init maple_probe(int platfo
 	return 1;
 }
 
-struct machdep_calls __initdata maple_md = {
+define_machine(maple_md) {
+	.name			= "Maple",
 	.probe			= maple_probe,
 	.setup_arch		= maple_setup_arch,
 	.init_early		= maple_init_early,
Index: linux-work/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pci.c	2006-03-10 15:58:17.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/pci.c	2006-03-24 11:45:28.000000000 +1100
@@ -1201,7 +1201,7 @@ void __init pmac_pcibios_after_init(void
 #ifdef CONFIG_PPC32
 void pmac_pci_fixup_cardbus(struct pci_dev* dev)
 {
-	if (_machine != _MACH_Pmac)
+	if (!machine_is(powermac))
 		return;
 	/*
 	 * Fix the interrupt routing on the various cardbus bridges
@@ -1244,8 +1244,9 @@ void pmac_pci_fixup_pciata(struct pci_de
         * On PowerMacs, we try to switch any PCI ATA controller to
 	* fully native mode
         */
-	if (_machine != _MACH_Pmac)
+	if (!machine_is(powermac))
 		return;
+
 	/* Some controllers don't have the class IDE */
 	if (dev->vendor == PCI_VENDOR_ID_PROMISE)
 		switch(dev->device) {
Index: linux-work/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/setup.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/setup.c	2006-03-24 11:45:28.000000000 +1100
@@ -350,6 +350,13 @@ static void __init pmac_setup_arch(void)
 		smp_ops = &psurge_smp_ops;
 #endif
 #endif /* CONFIG_SMP */
+
+#ifdef CONFIG_ADB
+	if (strstr(cmd_line, "adb_sync")) {
+		extern int __adb_probe_sync;
+		__adb_probe_sync = 1;
+	}
+#endif /* CONFIG_ADB */
 }
 
 char *bootpath;
@@ -576,30 +583,6 @@ pmac_halt(void)
 	pmac_power_off();
 }
 
-#ifdef CONFIG_PPC32
-void __init pmac_init(void)
-{
-	/* isa_io_base gets set in pmac_pci_init */
-	isa_mem_base = PMAC_ISA_MEM_BASE;
-	pci_dram_offset = PMAC_PCI_DRAM_OFFSET;
-	ISA_DMA_THRESHOLD = ~0L;
-	DMA_MODE_READ = 1;
-	DMA_MODE_WRITE = 2;
-
-	ppc_md = pmac_md;
-
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-        ppc_ide_md.ide_init_hwif	= pmac_ide_init_hwif_ports;
-        ppc_ide_md.default_io_base	= pmac_ide_get_base;
-#endif /* CONFIG_BLK_DEV_IDE_PMAC */
-#endif /* defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE) */
-
-	if (ppc_md.progress) ppc_md.progress("pmac_init(): exit", 0);
-
-}
-#endif
-
 /* 
  * Early initialization.
  */
@@ -646,6 +629,12 @@ static int __init pmac_declare_of_platfo
 {
 	struct device_node *np;
 
+	if (machine_is(chrp))
+		return -1;
+
+	if (!machine_is(powermac))
+		return 0;
+
 	np = of_find_node_by_name(NULL, "valkyrie");
 	if (np)
 		of_platform_device_create(np, "valkyrie", NULL);
@@ -666,12 +655,15 @@ device_initcall(pmac_declare_of_platform
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
-static int __init pmac_probe(int platform)
+static int __init pmac_probe(void)
 {
-#ifdef CONFIG_PPC64
-	if (platform != PLATFORM_POWERMAC)
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "Power Macintosh") &&
+	    !of_flat_dt_is_compatible(root, "MacRISC"))
 		return 0;
 
+#ifdef CONFIG_PPC64
 	/*
 	 * On U3, the DART (iommu) must be allocated now since it
 	 * has an impact on htab_initialize (due to the large page it
@@ -681,6 +673,23 @@ static int __init pmac_probe(int platfor
 	alloc_dart_table();
 #endif
 
+#ifdef CONFIG_PPC32
+	/* isa_io_base gets set in pmac_pci_init */
+	isa_mem_base = PMAC_ISA_MEM_BASE;
+	pci_dram_offset = PMAC_PCI_DRAM_OFFSET;
+	ISA_DMA_THRESHOLD = ~0L;
+	DMA_MODE_READ = 1;
+	DMA_MODE_WRITE = 2;
+
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+#ifdef CONFIG_BLK_DEV_IDE_PMAC
+        ppc_ide_md.ide_init_hwif	= pmac_ide_init_hwif_ports;
+        ppc_ide_md.default_io_base	= pmac_ide_get_base;
+#endif /* CONFIG_BLK_DEV_IDE_PMAC */
+#endif /* defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE) */
+
+#endif /* CONFIG_PPC32 */
+
 #ifdef CONFIG_PMAC_SMU
 	/*
 	 * SMU based G5s need some memory below 2Gb, at least the current
@@ -709,10 +718,8 @@ static int pmac_pci_probe_mode(struct pc
 }
 #endif
 
-struct machdep_calls __initdata pmac_md = {
-#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
-	.cpu_die		= generic_mach_cpu_die,
-#endif
+define_machine(powermac) {
+	.name			= "PowerMac",
 	.probe			= pmac_probe,
 	.setup_arch		= pmac_setup_arch,
 	.init_early		= pmac_init_early,
@@ -746,4 +753,7 @@ struct machdep_calls __initdata pmac_md 
 	.pcibios_after_init	= pmac_pcibios_after_init,
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 #endif
+#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
+	.cpu_die		= generic_mach_cpu_die,
+#endif
 };
Index: linux-work/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/setup.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/setup.c	2006-03-24 11:45:28.000000000 +1100
@@ -375,18 +375,36 @@ static int pSeries_check_legacy_ioport(u
  */
 extern struct machdep_calls pSeries_md;
 
-static int __init pSeries_probe(int platform)
+static int __init pSeries_probe_hypertas(unsigned long node,
+					 const char *uname, int depth,
+					 void *data)
 {
-	if (platform != PLATFORM_PSERIES &&
-	    platform != PLATFORM_PSERIES_LPAR)
+	if (depth != 1 ||
+	    (strcmp(uname, "rtas") != 0 && strcmp(uname, "rtas@0") != 0))
+ 		return 0;
+
+	if (of_get_flat_dt_prop(node, "ibm,hypertas-functions", NULL) != NULL)
+ 		ppc64_firmware_features |= FW_FEATURE_LPAR;
+
+ 	return 1;
+}
+
+static int __init pSeries_probe(void)
+{
+ 	char *dtype = of_get_flat_dt_prop(of_get_flat_dt_root(),
+ 					  "device_type", NULL);
+ 	if (dtype == NULL)
+ 		return 0;
+ 	if (strcmp(dtype, "chrp"))
 		return 0;
 
-	/* if we have some ppc_md fixups for LPAR to do, do
-	 * it here ...
-	 */
+	DBG("pSeries detected, looking for LPAR capability...\n");
+
+	/* Now try to figure out if we are running on LPAR */
+	of_scan_flat_dt(pSeries_probe_hypertas, NULL);
 
-	if (platform == PLATFORM_PSERIES_LPAR)
-		ppc64_firmware_features |= FW_FEATURE_LPAR;
+	DBG("Machine is%s LPAR !\n",
+	    (ppc64_firmware_features & FW_FEATURE_LPAR) ? "" : " not");
 
 	return 1;
 }
@@ -553,7 +571,8 @@ static void pseries_kexec_cpu_down(int c
 }
 #endif
 
-struct machdep_calls __initdata pSeries_md = {
+define_machine(pseries) {
+	.name			= "pSeries",
 	.probe			= pSeries_probe,
 	.setup_arch		= pSeries_setup_arch,
 	.init_early		= pSeries_init_early,
Index: linux-work/include/asm-powerpc/machdep.h
===================================================================
--- linux-work.orig/include/asm-powerpc/machdep.h	2006-01-14 14:43:33.000000000 +1100
+++ linux-work/include/asm-powerpc/machdep.h	2006-03-24 11:45:28.000000000 +1100
@@ -47,6 +47,7 @@ struct smp_ops_t {
 #endif
 
 struct machdep_calls {
+	char		*name;
 #ifdef CONFIG_PPC64
 	void            (*hpte_invalidate)(unsigned long slot,
 					   unsigned long va,
@@ -85,9 +86,9 @@ struct machdep_calls {
 	void		(*iommu_dev_setup)(struct pci_dev *dev);
 	void		(*iommu_bus_setup)(struct pci_bus *bus);
 	void		(*irq_bus_setup)(struct pci_bus *bus);
-#endif
+#endif /* CONFIG_PPC64 */
 
-	int		(*probe)(int platform);
+	int		(*probe)(void);
 	void		(*setup_arch)(void);
 	void		(*init_early)(void);
 	/* Optional, may be NULL. */
@@ -208,8 +209,6 @@ struct machdep_calls {
 	/* Called at then very end of pcibios_init() */
 	void (*pcibios_after_init)(void);
 
-	/* this is for modules, since _machine can be a define -- Cort */
-	int ppc_machine;
 #endif /* CONFIG_PPC32 */
 
 	/* Called to shutdown machine specific hardware not already controlled
@@ -245,7 +244,26 @@ struct machdep_calls {
 extern void default_idle(void);
 extern void native_idle(void);
 
+/*
+ * ppc_md contains a copy of the machine description structure for the
+ * current platform. machine_id contains the initial address where the
+ * description was found during boot.
+ */
 extern struct machdep_calls ppc_md;
+extern struct machdep_calls *machine_id;
+
+#define __machine_desc __attribute__ ((__section__ (".machine.desc")))
+
+#define define_machine(name) struct machdep_calls mach_##name __machine_desc =
+#define machine_is(name) \
+	({ \
+		extern struct machdep_calls mach_##name \
+			__attribute__((weak));		 \
+		machine_id == &mach_##name; \
+	})
+
+extern void probe_machine(void);
+
 extern char cmd_line[COMMAND_LINE_SIZE];
 
 #ifdef CONFIG_PPC_PMAC
Index: linux-work/include/asm-powerpc/processor.h
===================================================================
--- linux-work.orig/include/asm-powerpc/processor.h	2006-03-24 11:42:14.000000000 +1100
+++ linux-work/include/asm-powerpc/processor.h	2006-03-24 11:45:28.000000000 +1100
@@ -22,22 +22,6 @@
  * -- BenH.
  */
 
-/* Platforms codes (to be obsoleted) */
-#define PLATFORM_PSERIES	0x0100
-#define PLATFORM_PSERIES_LPAR	0x0101
-#define PLATFORM_ISERIES_LPAR	0x0201
-#define PLATFORM_LPAR		0x0001
-#define PLATFORM_POWERMAC	0x0400
-#define PLATFORM_MAPLE		0x0500
-#define PLATFORM_PREP		0x0600
-#define PLATFORM_CHRP		0x0700
-#define PLATFORM_CELL		0x1000
-
-/* Compat platform codes for 32 bits */
-#define _MACH_prep	PLATFORM_PREP
-#define _MACH_Pmac	PLATFORM_POWERMAC
-#define _MACH_chrp	PLATFORM_CHRP
-
 /* PREP sub-platform types see residual.h for these */
 #define _PREP_Motorola	0x01	/* motorola prep */
 #define _PREP_Firm	0x02	/* firmworks prep */
@@ -49,14 +33,7 @@
 #define _CHRP_IBM	0x05	/* IBM chrp, the longtrail and longtrail 2 */
 #define _CHRP_Pegasos	0x06	/* Genesi/bplan's Pegasos and Pegasos2 */
 
-#ifdef __KERNEL__
-#define platform_is_pseries()	(_machine == PLATFORM_PSERIES || \
-				 _machine == PLATFORM_PSERIES_LPAR)
-
-#if defined(CONFIG_PPC_MULTIPLATFORM)
-extern int _machine;
-
-#ifdef CONFIG_PPC32
+#if defined(__KERNEL__) && defined(CONFIG_PPC32)
 
 /* what kind of prep workstation we are */
 extern int _prep_type;
@@ -70,17 +47,8 @@ extern int _chrp_type;
 extern unsigned char ucBoardRev;
 extern unsigned char ucBoardRevMaj, ucBoardRevMin;
 
-#endif /* CONFIG_PPC32 */
+#endif /* __KERNEL__ && CONFIG_PPC32 */
 
-#elif defined(CONFIG_PPC_ISERIES)
-/*
- * iSeries is soon to become MULTIPLATFORM hopefully ...
- */
-#define _machine PLATFORM_ISERIES_LPAR
-#else
-#define _machine 0
-#endif /* CONFIG_PPC_MULTIPLATFORM */
-#endif /* __KERNEL__ */
 /*
  * Default implementation of macro that returns current
  * instruction pointer ("program counter").
Index: linux-work/include/asm-powerpc/prom.h
===================================================================
--- linux-work.orig/include/asm-powerpc/prom.h	2006-03-24 11:42:14.000000000 +1100
+++ linux-work/include/asm-powerpc/prom.h	2006-03-24 11:45:28.000000000 +1100
@@ -149,12 +149,14 @@ extern struct device_node *of_node_get(s
 extern void of_node_put(struct device_node *node);
 
 /* For scanning the flat device-tree at boot time */
-int __init of_scan_flat_dt(int (*it)(unsigned long node,
-				     const char *uname, int depth,
-				     void *data),
-			   void *data);
-void* __init of_get_flat_dt_prop(unsigned long node, const char *name,
-				 unsigned long *size);
+extern int __init of_scan_flat_dt(int (*it)(unsigned long node,
+					    const char *uname, int depth,
+					    void *data),
+				  void *data);
+extern void* __init of_get_flat_dt_prop(unsigned long node, const char *name,
+					unsigned long *size);
+extern int __init of_flat_dt_is_compatible(unsigned long node, const char *name);
+extern unsigned long __init of_get_flat_dt_root(void);
 
 /* For updating the device tree at runtime */
 extern void of_attach_node(struct device_node *);
Index: linux-work/arch/powerpc/kernel/nvram_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/nvram_64.c	2006-01-14 14:43:22.000000000 +1100
+++ linux-work/arch/powerpc/kernel/nvram_64.c	2006-03-24 11:45:28.000000000 +1100
@@ -160,7 +160,7 @@ static int dev_nvram_ioctl(struct inode 
 	case IOC_NVRAM_GET_OFFSET: {
 		int part, offset;
 
-		if (_machine != PLATFORM_POWERMAC)
+		if (!machine_is(powermac))
 			return -EINVAL;
 		if (copy_from_user(&part, (void __user*)arg, sizeof(part)) != 0)
 			return -EFAULT;
@@ -443,7 +443,7 @@ static int nvram_setup_partition(void)
 	 * in our nvram, as Apple defined partitions use pretty much
 	 * all of the space
 	 */
-	if (_machine == PLATFORM_POWERMAC)
+	if (machine_is(powermac))
 		return -ENOSPC;
 
 	/* see if we have an OS partition that meets our needs.
Index: linux-work/arch/powerpc/kernel/proc_ppc64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/proc_ppc64.c	2006-01-14 14:43:22.000000000 +1100
+++ linux-work/arch/powerpc/kernel/proc_ppc64.c	2006-03-24 11:45:28.000000000 +1100
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 
+#include <asm/machdep.h>
 #include <asm/vdso_datapage.h>
 #include <asm/rtas.h>
 #include <asm/uaccess.h>
@@ -51,7 +52,7 @@ static int __init proc_ppc64_create(void
 	if (!root)
 		return 1;
 
-	if (!(platform_is_pseries() || _machine == PLATFORM_CELL))
+	if (!machine_is(pseries) && !machine_is(cell))
 		return 0;
 
 	if (!proc_mkdir("rtas", root))
Index: linux-work/arch/powerpc/kernel/rtas-proc.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/rtas-proc.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/kernel/rtas-proc.c	2006-03-24 11:45:28.000000000 +1100
@@ -257,7 +257,7 @@ static int __init proc_rtas_init(void)
 {
 	struct proc_dir_entry *entry;
 
-	if (_machine != PLATFORM_PSERIES && _machine != PLATFORM_PSERIES_LPAR)
+	if (!machine_is(pseries))
 		return 1;
 
 	rtas_node = of_find_node_by_name(NULL, "rtas");
Index: linux-work/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/rtas.c	2006-03-10 15:58:17.000000000 +1100
+++ linux-work/arch/powerpc/kernel/rtas.c	2006-03-24 11:45:28.000000000 +1100
@@ -25,6 +25,7 @@
 #include <asm/hvcall.h>
 #include <asm/semaphore.h>
 #include <asm/machdep.h>
+#include <asm/firmware.h>
 #include <asm/page.h>
 #include <asm/param.h>
 #include <asm/system.h>
@@ -767,7 +768,7 @@ void __init rtas_initialize(void)
 	 * the stop-self token if any
 	 */
 #ifdef CONFIG_PPC64
-	if (_machine == PLATFORM_PSERIES_LPAR) {
+	if (machine_is(pseries) && firmware_has_feature(FW_FEATURE_LPAR)) {
 		rtas_region = min(lmb.rmo_size, RTAS_INSTANTIATE_MAX);
 		ibm_suspend_me_token = rtas_token("ibm,suspend-me");
 	}
Index: linux-work/arch/powerpc/kernel/traps.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/traps.c	2006-03-10 15:58:17.000000000 +1100
+++ linux-work/arch/powerpc/kernel/traps.c	2006-03-24 11:45:28.000000000 +1100
@@ -97,7 +97,6 @@ static DEFINE_SPINLOCK(die_lock);
 int die(const char *str, struct pt_regs *regs, long err)
 {
 	static int die_counter, crash_dump_start = 0;
-	int nl = 0;
 
 	if (debugger(regs))
 		return 1;
@@ -106,7 +105,7 @@ int die(const char *str, struct pt_regs 
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if (_machine == _MACH_Pmac) {
+	if (machine_is(powermac)) {
 		set_backlight_enable(1);
 		set_backlight_level(BACKLIGHT_MAX);
 	}
@@ -114,46 +113,18 @@ int die(const char *str, struct pt_regs 
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 #ifdef CONFIG_PREEMPT
 	printk("PREEMPT ");
-	nl = 1;
 #endif
 #ifdef CONFIG_SMP
 	printk("SMP NR_CPUS=%d ", NR_CPUS);
-	nl = 1;
 #endif
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	printk("DEBUG_PAGEALLOC ");
-	nl = 1;
 #endif
 #ifdef CONFIG_NUMA
 	printk("NUMA ");
-	nl = 1;
 #endif
-#ifdef CONFIG_PPC64
-	switch (_machine) {
-	case PLATFORM_PSERIES:
-		printk("PSERIES ");
-		nl = 1;
-		break;
-	case PLATFORM_PSERIES_LPAR:
-		printk("PSERIES LPAR ");
-		nl = 1;
-		break;
-	case PLATFORM_ISERIES_LPAR:
-		printk("ISERIES LPAR ");
-		nl = 1;
-		break;
-	case PLATFORM_POWERMAC:
-		printk("POWERMAC ");
-		nl = 1;
-		break;
-	case PLATFORM_CELL:
-		printk("CELL ");
-		nl = 1;
-		break;
-	}
-#endif
-	if (nl)
-		printk("\n");
+	printk("%s\n", ppc_md.name ? "" : ppc_md.name);
+
 	print_modules();
 	show_regs(regs);
 	bust_spinlocks(0);
Index: linux-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/feature.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/feature.c	2006-03-24 11:45:28.000000000 +1100
@@ -2951,7 +2951,7 @@ static void *pmac_early_vresume_data;
 
 void pmac_set_early_video_resume(void (*proc)(void *data), void *data)
 {
-	if (_machine != _MACH_Pmac)
+	if (!machine_is(powermac))
 		return;
 	preempt_disable();
 	pmac_early_vresume_proc = proc;
Index: linux-work/arch/powerpc/platforms/powermac/nvram.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/nvram.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/nvram.c	2006-03-24 11:45:28.000000000 +1100
@@ -597,7 +597,7 @@ int __init pmac_nvram_init(void)
 	}
 
 #ifdef CONFIG_PPC32
-	if (_machine == _MACH_chrp && nvram_naddrs == 1) {
+	if (machine_is(chrp) && nvram_naddrs == 1) {
 		nvram_data = ioremap(r1.start, s1);
 		nvram_mult = 1;
 		ppc_md.nvram_read_val	= direct_nvram_read_byte;
Index: linux-work/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/eeh.c	2006-03-10 15:58:17.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/eeh.c	2006-03-24 11:45:28.000000000 +1100
@@ -1018,7 +1018,7 @@ static int __init eeh_init_proc(void)
 {
 	struct proc_dir_entry *e;
 
-	if (platform_is_pseries()) {
+	if (machine_is(pseries)) {
 		e = create_proc_entry("ppc64/eeh", 0, NULL);
 		if (e)
 			e->proc_fops = &proc_eeh_operations;
Index: linux-work/arch/powerpc/platforms/pseries/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/pci.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/pci.c	2006-03-24 11:45:28.000000000 +1100
@@ -120,7 +120,7 @@ static void fixup_winbond_82c105(struct 
 	int i;
 	unsigned int reg;
 
-	if (!platform_is_pseries())
+	if (!machine_is(pseries))
 		return;
 
 	printk("Using INTC for W82c105 IDE controller.\n");
Index: linux-work/arch/powerpc/platforms/pseries/reconfig.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/reconfig.c	2006-03-10 15:58:17.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/reconfig.c	2006-03-24 11:45:28.000000000 +1100
@@ -17,8 +17,9 @@
 #include <linux/proc_fs.h>
 
 #include <asm/prom.h>
-#include <asm/pSeries_reconfig.h>
+#include <asm/machdep.h>
 #include <asm/uaccess.h>
+#include <asm/pSeries_reconfig.h>
 
 
 
@@ -508,7 +509,7 @@ static int proc_ppc64_create_ofdt(void)
 {
 	struct proc_dir_entry *ent;
 
-	if (!platform_is_pseries())
+	if (!machine_is(pseries))
 		return 0;
 
 	ent = create_proc_entry("ppc64/ofdt", S_IWUSR, NULL);
Index: linux-work/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/rtasd.c	2006-01-14 14:43:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/rtasd.c	2006-03-24 11:45:28.000000000 +1100
@@ -27,6 +27,7 @@
 #include <asm/prom.h>
 #include <asm/nvram.h>
 #include <asm/atomic.h>
+#include <asm/machdep.h>
 
 #if 0
 #define DEBUG(A...)	printk(KERN_ERR A)
@@ -481,7 +482,7 @@ static int __init rtas_init(void)
 {
 	struct proc_dir_entry *entry;
 
-	if (!platform_is_pseries())
+	if (!machine_is(pseries))
 		return 0;
 
 	/* No RTAS */
Index: linux-work/include/asm-powerpc/vdso_datapage.h
===================================================================
--- linux-work.orig/include/asm-powerpc/vdso_datapage.h	2006-01-14 14:43:33.000000000 +1100
+++ linux-work/include/asm-powerpc/vdso_datapage.h	2006-03-24 11:45:28.000000000 +1100
@@ -55,6 +55,9 @@ struct vdso_data {
 		__u32 minor;		/* Minor number			0x14 */
 	} version;
 
+	/* Note about the platform flags: it now only contains the lpar
+	 * bit. The actual platform number is dead and burried
+	 */
 	__u32 platform;			/* Platform flags		0x18 */
 	__u32 processor;		/* Processor type		0x1C */
 	__u64 processorCount;		/* # of physical processors	0x20 */
Index: linux-work/arch/powerpc/kernel/vdso.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vdso.c	2006-03-24 11:45:28.000000000 +1100
@@ -33,6 +33,7 @@
 #include <asm/machdep.h>
 #include <asm/cputable.h>
 #include <asm/sections.h>
+#include <asm/firmware.h>
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 
@@ -667,7 +668,13 @@ void __init vdso_init(void)
 	vdso_data->version.major = SYSTEMCFG_MAJOR;
 	vdso_data->version.minor = SYSTEMCFG_MINOR;
 	vdso_data->processor = mfspr(SPRN_PVR);
-	vdso_data->platform = _machine;
+	/*
+	 * Fake the old platform number for pSeries and iSeries and add
+	 * in LPAR bit if necessary
+	 */
+	vdso_data->platform = machine_is(iseries) ? 0x200 : 0x100;
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		vdso_data->platform |= 1;
 	vdso_data->physicalMemorySize = lmb_phys_mem_size();
 	vdso_data->dcache_size = ppc64_caches.dsize;
 	vdso_data->dcache_line_size = ppc64_caches.dline_size;
Index: linux-work/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/asm-offsets.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/kernel/asm-offsets.c	2006-03-24 11:45:28.000000000 +1100
@@ -105,8 +105,6 @@ int main(void)
 	DEFINE(ICACHEL1LINESIZE, offsetof(struct ppc64_caches, iline_size));
 	DEFINE(ICACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_iline_size));
 	DEFINE(ICACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, ilines_per_page));
-	DEFINE(PLATFORM_LPAR, PLATFORM_LPAR);
-
 	/* paca */
 	DEFINE(PACA_SIZE, sizeof(struct paca_struct));
 	DEFINE(PACAPACAINDEX, offsetof(struct paca_struct, paca_index));
Index: linux-work/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_init.c	2006-03-10 15:58:17.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom_init.c	2006-03-24 14:41:14.000000000 +1100
@@ -180,6 +180,16 @@ static unsigned long __initdata prom_tce
 static unsigned long __initdata prom_tce_alloc_end;
 #endif
 
+/* Platforms codes are now obsolete in the kernel. Now only used within this
+ * file and ultimately gone too. Feel free to change them if you need, they
+ * are not shared with anything outside of this file anymore
+ */
+#define PLATFORM_PSERIES	0x0100
+#define PLATFORM_PSERIES_LPAR	0x0101
+#define PLATFORM_LPAR		0x0001
+#define PLATFORM_POWERMAC	0x0400
+#define PLATFORM_GENERIC	0x0500
+
 static int __initdata of_platform;
 
 static char __initdata prom_cmd_line[COMMAND_LINE_SIZE];
@@ -1487,7 +1497,10 @@ static int __init prom_find_machine_type
 	int len, i = 0;
 #ifdef CONFIG_PPC64
 	phandle rtas;
+	int x;
 #endif
+
+	/* Look for a PowerMac */
 	len = prom_getprop(_prom->root, "compatible",
 			   compat, sizeof(compat)-1);
 	if (len > 0) {
@@ -1500,28 +1513,36 @@ static int __init prom_find_machine_type
 			if (strstr(p, RELOC("Power Macintosh")) ||
 			    strstr(p, RELOC("MacRISC")))
 				return PLATFORM_POWERMAC;
-#ifdef CONFIG_PPC64
-			if (strstr(p, RELOC("Momentum,Maple")))
-				return PLATFORM_MAPLE;
-			if (strstr(p, RELOC("IBM,CPB")))
-				return PLATFORM_CELL;
-#endif
 			i += sl + 1;
 		}
 	}
 #ifdef CONFIG_PPC64
+	/* If not a mac, try to figure out if it's an IBM pSeries. We assume
+	 * it is if :
+	 *  - /device_type is "chrp" (please, do NOT use that for future
+	 *    non-IBM designs !
+	 *  - it has /rtas
+	 */
+	len = prom_getprop(_prom->root, "model",
+			   compat, sizeof(compat)-1);
+	if (len <= 0)
+		return PLATFORM_GENERIC;
+	compat[len] = 0;
+	if (strcmp(compat, "chrp"))
+		return PLATFORM_GENERIC;
+
 	/* Default to pSeries. We need to know if we are running LPAR */
 	rtas = call_prom("finddevice", 1, 1, ADDR("/rtas"));
-	if (PHANDLE_VALID(rtas)) {
-		int x = prom_getproplen(rtas, "ibm,hypertas-functions");
-		if (x != PROM_ERROR) {
-			prom_printf("Hypertas detected, assuming LPAR !\n");
-			return PLATFORM_PSERIES_LPAR;
-		}
+	if (!PHANDLE_VALID(rtas))
+		return PLATFORM_GENERIC;
+	x = prom_getproplen(rtas, "ibm,hypertas-functions");
+	if (x != PROM_ERROR) {
+		prom_printf("Hypertas detected, assuming LPAR !\n");
+		return PLATFORM_PSERIES_LPAR;
 	}
 	return PLATFORM_PSERIES;
 #else
-	return PLATFORM_CHRP;
+	return PLATFORM_GENERIC;
 #endif
 }
 
@@ -2029,7 +2050,6 @@ unsigned long __init prom_init(unsigned 
 {	
        	struct prom_t *_prom;
 	unsigned long hdr;
-	u32 getprop_rval;
 	unsigned long offset = reloc_offset();
 
 #ifdef CONFIG_PPC32
@@ -2074,9 +2094,6 @@ unsigned long __init prom_init(unsigned 
 	 * between pSeries SMP and pSeries LPAR
 	 */
 	RELOC(of_platform) = prom_find_machine_type();
-	getprop_rval = RELOC(of_platform);
-	prom_setprop(_prom->chosen, "/chosen", "linux,platform",
-		     &getprop_rval, sizeof(getprop_rval));
 
 #ifdef CONFIG_PPC_PSERIES
 	/*
Index: linux-work/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_utils_64.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/mm/hash_utils_64.c	2006-03-24 11:45:28.000000000 +1100
@@ -167,7 +167,7 @@ int htab_bolt_mapping(unsigned long vsta
 		 * normal insert callback here.
 		 */
 #ifdef CONFIG_PPC_ISERIES
-		if (_machine == PLATFORM_ISERIES_LPAR)
+		if (machine_is(iseries))
 			ret = iSeries_hpte_insert(hpteg, va,
 						  paddr,
 						  tmp_mode,
@@ -176,7 +176,7 @@ int htab_bolt_mapping(unsigned long vsta
 		else
 #endif
 #ifdef CONFIG_PPC_PSERIES
-		if (_machine & PLATFORM_LPAR)
+		if (machine_is(pseries) && firmware_has_feature(FW_FEATURE_LPAR))
 			ret = pSeries_lpar_hpte_insert(hpteg, va,
 						       paddr,
 						       tmp_mode,
@@ -295,8 +295,7 @@ static void __init htab_init_page_sizes(
 	 * Not in the device-tree, let's fallback on known size
 	 * list for 16M capable GP & GR
 	 */
-	if ((_machine != PLATFORM_ISERIES_LPAR) &&
-	    cpu_has_feature(CPU_FTR_16M_PAGE))
+	if (cpu_has_feature(CPU_FTR_16M_PAGE) && !machine_is(iseries))
 		memcpy(mmu_psize_defs, mmu_psize_defaults_gp,
 		       sizeof(mmu_psize_defaults_gp));
  found:
Index: linux-work/drivers/char/generic_nvram.c
===================================================================
--- linux-work.orig/drivers/char/generic_nvram.c	2006-01-14 14:43:23.000000000 +1100
+++ linux-work/drivers/char/generic_nvram.c	2006-03-24 11:45:28.000000000 +1100
@@ -22,6 +22,9 @@
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <asm/nvram.h>
+#ifdef CONFIG_PPC_PMAC
+#include <asm/machdep.h>
+#endif
 
 #define NVRAM_SIZE	8192
 
@@ -92,7 +95,7 @@ static int nvram_ioctl(struct inode *ino
 	case IOC_NVRAM_GET_OFFSET: {
 		int part, offset;
 
-		if (_machine != _MACH_Pmac)
+		if (!machine_is(powermac))
 			return -EINVAL;
 		if (copy_from_user(&part, (void __user*)arg, sizeof(part)) != 0)
 			return -EFAULT;
Index: linux-work/drivers/ide/pci/via82cxxx.c
===================================================================
--- linux-work.orig/drivers/ide/pci/via82cxxx.c	2006-01-14 14:43:23.000000000 +1100
+++ linux-work/drivers/ide/pci/via82cxxx.c	2006-03-24 11:45:28.000000000 +1100
@@ -440,7 +440,7 @@ static void __devinit init_hwif_via82cxx
 
 
 #if defined(CONFIG_PPC_CHRP) && defined(CONFIG_PPC32)
-	if(_machine == _MACH_chrp && _chrp_type == _CHRP_Pegasos) {
+	if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
 		hwif->irq = hwif->channel ? 15 : 14;
 	}
 #endif
Index: linux-work/drivers/ide/ppc/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/ppc/pmac.c	2006-01-14 14:43:23.000000000 +1100
+++ linux-work/drivers/ide/ppc/pmac.c	2006-03-24 11:45:28.000000000 +1100
@@ -1677,7 +1677,7 @@ MODULE_DEVICE_TABLE(pci, pmac_ide_pci_ma
 void __init
 pmac_ide_probe(void)
 {
-	if (_machine != _MACH_Pmac)
+	if (!machine_is(powermac))
 		return;
 
 #ifdef CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST
Index: linux-work/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-work.orig/drivers/ieee1394/ohci1394.c	2006-01-14 14:43:23.000000000 +1100
+++ linux-work/drivers/ieee1394/ohci1394.c	2006-03-24 11:45:28.000000000 +1100
@@ -3526,7 +3526,7 @@ static void ohci1394_pci_remove(struct p
 static int ohci1394_pci_resume (struct pci_dev *pdev)
 {
 #ifdef CONFIG_PPC_PMAC
-	if (_machine == _MACH_Pmac) {
+	if (machine_is(powermac)) {
 		struct device_node *of_node;
 
 		/* Re-enable 1394 */
@@ -3545,7 +3545,7 @@ static int ohci1394_pci_resume (struct p
 static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 #ifdef CONFIG_PPC_PMAC
-	if (_machine == _MACH_Pmac) {
+	if (machine_is(powermac)) {
 		struct device_node *of_node;
 
 		/* Disable 1394 */
Index: linux-work/drivers/macintosh/adb.c
===================================================================
--- linux-work.orig/drivers/macintosh/adb.c	2006-01-14 14:43:23.000000000 +1100
+++ linux-work/drivers/macintosh/adb.c	2006-03-24 11:45:28.000000000 +1100
@@ -42,6 +42,7 @@
 #include <asm/semaphore.h>
 #ifdef CONFIG_PPC
 #include <asm/prom.h>
+#include <asm/machdep.h>
 #endif
 
 
@@ -294,7 +295,7 @@ int __init adb_init(void)
 	int i;
 
 #ifdef CONFIG_PPC32
-	if ( (_machine != _MACH_chrp) && (_machine != _MACH_Pmac) )
+	if (!machine_is(chrp) && !machine_is(powermac))
 		return 0;
 #endif
 #ifdef CONFIG_MAC
Index: linux-work/drivers/macintosh/adbhid.c
===================================================================
--- linux-work.orig/drivers/macintosh/adbhid.c	2006-01-14 14:43:23.000000000 +1100
+++ linux-work/drivers/macintosh/adbhid.c	2006-03-24 11:45:28.000000000 +1100
@@ -1206,8 +1206,8 @@ init_ms_a3(int id)
 static int __init adbhid_init(void)
 {
 #ifndef CONFIG_MAC
-	if ( (_machine != _MACH_chrp) && (_machine != _MACH_Pmac) )
-	    return 0;
+	if (!machine_is(chrp) && !machine_is(powermac))
+		return 0;
 #endif
 
 	led_request.complete = 1;
Index: linux-work/drivers/macintosh/mediabay.c
===================================================================
--- linux-work.orig/drivers/macintosh/mediabay.c	2006-01-14 14:43:23.000000000 +1100
+++ linux-work/drivers/macintosh/mediabay.c	2006-03-24 11:45:28.000000000 +1100
@@ -839,8 +839,8 @@ static int __init media_bay_init(void)
 		media_bays[i].cd_index		= -1;
 #endif
 	}
-	if (_machine != _MACH_Pmac)
-		return -ENODEV;
+	if (!machine_is(powermac))
+		return 0;
 
 	macio_register_driver(&media_bay_driver);	
 
Index: linux-work/drivers/media/video/planb.c
===================================================================
--- linux-work.orig/drivers/media/video/planb.c	2006-03-23 14:26:09.000000000 +1100
+++ linux-work/drivers/media/video/planb.c	2006-03-24 11:45:28.000000000 +1100
@@ -2156,7 +2156,7 @@ static int find_planb(void)
 	struct pci_dev 		*pdev;
 	int rc;
 
-	if (_machine != _MACH_Pmac)
+	if (!machine_is(powermac))
 		return 0;
 
 	planb_devices = find_devices("planb");
Index: linux-work/drivers/scsi/mesh.c
===================================================================
--- linux-work.orig/drivers/scsi/mesh.c	2006-01-14 14:43:31.000000000 +1100
+++ linux-work/drivers/scsi/mesh.c	2006-03-24 11:45:28.000000000 +1100
@@ -1748,7 +1748,7 @@ static int mesh_host_reset(struct scsi_c
 
 static void set_mesh_power(struct mesh_state *ms, int state)
 {
-	if (_machine != _MACH_Pmac)
+	if (!machine_is(powermac))
 		return;
 	if (state) {
 		pmac_call_feature(PMAC_FTR_MESH_ENABLE, macio_get_of_node(ms->mdev), 0, 1);
Index: linux-work/drivers/usb/core/hcd-pci.c
===================================================================
--- linux-work.orig/drivers/usb/core/hcd-pci.c	2006-03-23 14:26:11.000000000 +1100
+++ linux-work/drivers/usb/core/hcd-pci.c	2006-03-24 11:45:28.000000000 +1100
@@ -296,7 +296,7 @@ done:
 
 #ifdef CONFIG_PPC_PMAC
 		/* Disable ASIC clocks for USB */
-		if (_machine == _MACH_Pmac) {
+		if (machine_is(powermac)) {
 			struct device_node	*of_node;
 
 			of_node = pci_device_to_OF_node (dev);
@@ -331,7 +331,7 @@ int usb_hcd_pci_resume (struct pci_dev *
 
 #ifdef CONFIG_PPC_PMAC
 	/* Reenable ASIC clocks for USB */
-	if (_machine == _MACH_Pmac) {
+	if (machine_is(powermac)) {
 		struct device_node *of_node;
 
 		of_node = pci_device_to_OF_node (dev);
Index: linux-work/drivers/video/aty/aty128fb.c
===================================================================
--- linux-work.orig/drivers/video/aty/aty128fb.c	2006-03-23 14:26:11.000000000 +1100
+++ linux-work/drivers/video/aty/aty128fb.c	2006-03-24 11:45:28.000000000 +1100
@@ -67,6 +67,7 @@
 #include <asm/io.h>
 
 #ifdef CONFIG_PPC_PMAC
+#include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
@@ -1748,7 +1749,7 @@ static int __init aty128_init(struct pci
 
 	var = default_var;
 #ifdef CONFIG_PPC_PMAC
-	if (_machine == _MACH_Pmac) {
+	if (machine_is(powermac)) {
 		/* Indicate sleep capability */
 		if (par->chip_gen == rage_M3) {
 			pmac_call_feature(PMAC_FTR_DEVICE_CAN_WAKE, NULL, 0, 1);
@@ -2011,7 +2012,7 @@ static int aty128fb_blank(int blank, str
 		return 0;
 
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if ((_machine == _MACH_Pmac) && blank)
+	if (machine_is(powermac) && blank)
 		set_backlight_enable(0);
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
@@ -2029,7 +2030,7 @@ static int aty128fb_blank(int blank, str
 		aty128_set_lcd_enable(par, par->lcd_on && !blank);
 	}
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if ((_machine == _MACH_Pmac) && !blank)
+	if (machine_is(powermac) && !blank)
 		set_backlight_enable(1);
 #endif /* CONFIG_PMAC_BACKLIGHT */
 	return 0;
Index: linux-work/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/atyfb_base.c	2006-03-10 15:58:20.000000000 +1100
+++ linux-work/drivers/video/aty/atyfb_base.c	2006-03-24 11:45:28.000000000 +1100
@@ -75,6 +75,7 @@
 #include "ati_ids.h"
 
 #ifdef __powerpc__
+#include <asm/machdep.h>
 #include <asm/prom.h>
 #include "../macmodes.h"
 #endif
@@ -2516,7 +2517,7 @@ static int __init aty_init(struct fb_inf
 
 	memset(&var, 0, sizeof(var));
 #ifdef CONFIG_PPC
-	if (_machine == _MACH_Pmac) {
+	if (machine_is(powermac)) {
 		/*
 		 *  FIXME: The NVRAM stuff should be put in a Mac-specific file, as it
 		 *         applies to all Mac video cards
@@ -2671,7 +2672,7 @@ static int atyfb_blank(int blank, struct
 		return 0;
 
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if ((_machine == _MACH_Pmac) && blank > FB_BLANK_NORMAL)
+	if (machine_is(powermac) && blank > FB_BLANK_NORMAL)
 		set_backlight_enable(0);
 #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
 	if (par->lcd_table && blank > FB_BLANK_NORMAL &&
@@ -2703,7 +2704,7 @@ static int atyfb_blank(int blank, struct
 	aty_st_le32(CRTC_GEN_CNTL, gen_cntl, par);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if ((_machine == _MACH_Pmac) && blank <= FB_BLANK_NORMAL)
+	if (machine_is(powermac) && blank <= FB_BLANK_NORMAL)
 		set_backlight_enable(1);
 #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
 	if (par->lcd_table && blank <= FB_BLANK_NORMAL &&
Index: linux-work/drivers/video/aty/radeon_pm.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_pm.c	2006-03-10 15:58:20.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_pm.c	2006-03-24 14:41:02.000000000 +1100
@@ -20,7 +20,7 @@
 #include <linux/agp_backend.h>
 
 #ifdef CONFIG_PPC_PMAC
-#include <asm/processor.h>
+#include <asm/machdep.h>
 #include <asm/prom.h>
 #include <asm/pmac_feature.h>
 #endif
@@ -2745,7 +2745,7 @@ void radeonfb_pm_init(struct radeonfb_in
 		rinfo->pm_mode |= radeon_pm_off;
 	}
 #if defined(CONFIG_PPC_PMAC)
-	if (_machine == _MACH_Pmac && rinfo->of_node) {
+	if (machine_is(powermac) && rinfo->of_node) {
 		if (rinfo->is_mobility && rinfo->pm_reg &&
 		    rinfo->family <= CHIP_FAMILY_RV250)
 			rinfo->pm_mode |= radeon_pm_d2;
Index: linux-work/drivers/video/cirrusfb.c
===================================================================
--- linux-work.orig/drivers/video/cirrusfb.c	2006-01-14 14:43:31.000000000 +1100
+++ linux-work/drivers/video/cirrusfb.c	2006-03-24 11:45:28.000000000 +1100
@@ -60,8 +60,8 @@
 #include <asm/amigahw.h>
 #endif
 #ifdef CONFIG_PPC_PREP
-#include <asm/processor.h>
-#define isPReP (_machine == _MACH_prep)
+#include <asm/machdep.h>
+#define isPReP (machine_is(prep))
 #else
 #define isPReP 0
 #endif
Index: linux-work/drivers/video/matrox/matroxfb_base.c
===================================================================
--- linux-work.orig/drivers/video/matrox/matroxfb_base.c	2006-03-10 15:58:20.000000000 +1100
+++ linux-work/drivers/video/matrox/matroxfb_base.c	2006-03-24 11:45:28.000000000 +1100
@@ -116,6 +116,7 @@
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_PPC_PMAC
+#include <asm/machdep.h>
 unsigned char nvram_read_byte(int);
 static int default_vmode = VMODE_NVRAM;
 static int default_cmode = CMODE_NVRAM;
@@ -1834,7 +1835,7 @@ static int initMatrox2(WPMINFO struct bo
 	/* FIXME: Where to move this?! */
 #if defined(CONFIG_PPC_PMAC)
 #ifndef MODULE
-	if (_machine == _MACH_Pmac) {
+	if (machine_is(powermac)) {
 		struct fb_var_screeninfo var;
 		if (default_vmode <= 0 || default_vmode > VMODE_MAX)
 			default_vmode = VMODE_640_480_60;
Index: linux-work/drivers/video/nvidia/nvidia.c
===================================================================
--- linux-work.orig/drivers/video/nvidia/nvidia.c	2006-03-10 15:58:20.000000000 +1100
+++ linux-work/drivers/video/nvidia/nvidia.c	2006-03-24 11:45:28.000000000 +1100
@@ -29,6 +29,7 @@
 #include <asm/pci-bridge.h>
 #endif
 #ifdef CONFIG_PMAC_BACKLIGHT
+#include <asm/machdep.h>
 #include <asm/backlight.h>
 #endif
 
@@ -1353,7 +1354,7 @@ static int nvidiafb_blank(int blank, str
 	NVWriteCrtc(par, 0x1a, vesa);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if (par->FlatPanel && _machine == _MACH_Pmac) {
+	if (par->FlatPanel && machine_is(powermac)) {
 		set_backlight_enable(!blank);
 	}
 #endif
@@ -1688,7 +1689,7 @@ static int __devinit nvidiafb_probe(stru
 	       info->fix.id,
 	       par->FbMapSize / (1024 * 1024), info->fix.smem_start);
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if (par->FlatPanel && _machine == _MACH_Pmac)
+	if (par->FlatPanel && machine_is(powermac))
 		register_backlight_controller(&nvidia_backlight_controller,
 					      par, "mnca");
 #endif
Index: linux-work/drivers/video/radeonfb.c
===================================================================
--- linux-work.orig/drivers/video/radeonfb.c	2006-03-10 15:58:20.000000000 +1100
+++ linux-work/drivers/video/radeonfb.c	2006-03-24 11:45:28.000000000 +1100
@@ -1596,7 +1596,7 @@ static int radeonfb_blank (int blank, st
 		return 0;
 		
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if (rinfo->dviDisp_type == MT_LCD && _machine == _MACH_Pmac) {
+	if (rinfo->dviDisp_type == MT_LCD && machine_is(powermac)) {
 		set_backlight_enable(!blank);
 		return 0;
 	}
Index: linux-work/drivers/video/riva/fbdev.c
===================================================================
--- linux-work.orig/drivers/video/riva/fbdev.c	2006-01-14 14:43:32.000000000 +1100
+++ linux-work/drivers/video/riva/fbdev.c	2006-03-24 11:45:28.000000000 +1100
@@ -49,6 +49,7 @@
 #include <asm/pci-bridge.h>
 #endif
 #ifdef CONFIG_PMAC_BACKLIGHT
+#include <asm/machdep.h>
 #include <asm/backlight.h>
 #endif
 
@@ -1247,7 +1248,7 @@ static int rivafb_blank(int blank, struc
 	CRTCout(par, 0x1a, vesa);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if ( par->FlatPanel && _machine == _MACH_Pmac) {
+	if ( par->FlatPanel && machine_is(powermac)) {
 		set_backlight_enable(!blank);
 	}
 #endif
@@ -2037,9 +2038,9 @@ static int __devinit rivafb_probe(struct
 		info->fix.smem_len / (1024 * 1024),
 		info->fix.smem_start);
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if (default_par->FlatPanel && _machine == _MACH_Pmac)
-	register_backlight_controller(&riva_backlight_controller,
-						default_par, "mnca");
+	if (default_par->FlatPanel && machine_is(powermac))
+		register_backlight_controller(&riva_backlight_controller,
+					      default_par, "mnca");
 #endif
 	NVTRACE_LEAVE();
 	return 0;
Index: linux-work/include/asm-powerpc/pmac_feature.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pmac_feature.h	2006-01-14 14:43:33.000000000 +1100
+++ linux-work/include/asm-powerpc/pmac_feature.h	2006-03-24 11:45:28.000000000 +1100
@@ -305,7 +305,7 @@ extern void pmac_feature_init(void);
 extern void pmac_set_early_video_resume(void (*proc)(void *data), void *data);
 extern void pmac_call_early_video_resume(void);
 
-#define PMAC_FTR_DEF(x) ((_MACH_Pmac << 16) | (x))
+#define PMAC_FTR_DEF(x) ((0x6660000) | (x))
 
 /* The AGP driver registers itself here */
 extern void pmac_register_agp_pm(struct pci_dev *bridge,
Index: linux-work/arch/powerpc/platforms/powermac/low_i2c.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/low_i2c.c	2006-03-10 15:58:17.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/low_i2c.c	2006-03-24 11:45:28.000000000 +1100
@@ -1457,6 +1457,9 @@ int __init pmac_i2c_init(void)
 		return 0;
 	i2c_inited = 1;
 
+	if (!machine_is(powermac))
+		return 0;
+
 	/* Probe keywest-i2c busses */
 	kw_i2c_probe();
 
Index: linux-work/arch/powerpc/platforms/powermac/pfunc_base.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pfunc_base.c	2006-03-10 15:58:17.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/pfunc_base.c	2006-03-24 11:45:28.000000000 +1100
@@ -336,6 +336,8 @@ int __init pmac_pfunc_base_install(void)
 		return 0;
 	pfbase_inited = 1;
 
+	if (!machine_is(powermac))
+		return 0;
 
 	DBG("Installing base platform functions...\n");
 
Index: linux-work/fs/partitions/mac.c
===================================================================
--- linux-work.orig/fs/partitions/mac.c	2006-01-14 14:43:32.000000000 +1100
+++ linux-work/fs/partitions/mac.c	2006-03-24 11:45:28.000000000 +1100
@@ -12,6 +12,7 @@
 #include "mac.h"
 
 #ifdef CONFIG_PPC_PMAC
+#include <asm/machdep.h>
 extern void note_bootable_part(dev_t dev, int part, int goodness);
 #endif
 
@@ -79,7 +80,7 @@ int mac_partition(struct parsed_partitio
 		 * If this is the first bootable partition, tell the
 		 * setup code, in case it wants to make this the root.
 		 */
-		if (_machine == _MACH_Pmac) {
+		if (machine_is(powermac)) {
 			int goodness = 0;
 
 			mac_fix_string(part->processor, 16);
Index: linux-work/sound/oss/dmasound/dmasound_awacs.c
===================================================================
--- linux-work.orig/sound/oss/dmasound/dmasound_awacs.c	2006-03-24 11:42:14.000000000 +1100
+++ linux-work/sound/oss/dmasound/dmasound_awacs.c	2006-03-24 11:45:28.000000000 +1100
@@ -2814,7 +2814,7 @@ int __init dmasound_awacs_init(void)
 	struct device_node *io = NULL, *info = NULL;
 	int vol, res;
 
-	if (_machine != _MACH_Pmac)
+	if (!machine_is(powermac))
 		return -ENODEV;
 
 	awacs_subframe = 0;
Index: linux-work/sound/ppc/pmac.c
===================================================================
--- linux-work.orig/sound/ppc/pmac.c	2006-03-10 15:58:21.000000000 +1100
+++ linux-work/sound/ppc/pmac.c	2006-03-24 11:45:28.000000000 +1100
@@ -869,7 +869,7 @@ static int __init snd_pmac_detect(struct
 
 	u32 layout_id = 0;
 
-	if (_machine != _MACH_Pmac)
+	if (!machine_is(powermac))
 		return -ENODEV;
 
 	chip->subframe = 0;
Index: linux-work/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/chrp/setup.c	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/arch/powerpc/platforms/chrp/setup.c	2006-03-24 11:45:28.000000000 +1100
@@ -304,6 +304,10 @@ void __init chrp_setup_arch(void)
 
 	pci_create_OF_bus_map();
 
+#ifdef CONFIG_SMP
+	smp_ops = &chrp_smp_ops;
+#endif /* CONFIG_SMP */
+
 	/*
 	 * Print the banner, then scroll down so boot progress
 	 * can be printed.  -- Cort
@@ -480,8 +484,15 @@ chrp_init2(void)
 		ppc_md.progress("  Have fun!    ", 0x7777);
 }
 
-void __init chrp_init(void)
+static int __init chrp_probe(void)
 {
+ 	char *dtype = of_get_flat_dt_prop(of_get_flat_dt_root(),
+ 					  "device_type", NULL);
+ 	if (dtype == NULL)
+ 		return 0;
+ 	if (strcmp(dtype, "chrp"))
+		return 0;
+
 	ISA_DMA_THRESHOLD = ~0L;
 	DMA_MODE_READ = 0x44;
 	DMA_MODE_WRITE = 0x48;
Index: linux-work/arch/powerpc/platforms/powermac/bootx_init.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/bootx_init.c	2006-01-14 14:43:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/bootx_init.c	2006-03-24 11:45:28.000000000 +1100
@@ -161,9 +161,7 @@ static void __init bootx_dt_add_prop(cha
 static void __init bootx_add_chosen_props(unsigned long base,
 					  unsigned long *mem_end)
 {
-	u32 val = _MACH_Pmac;
-
-	bootx_dt_add_prop("linux,platform", &val, 4, mem_end);
+	u32 val;
 
 	if (bootx_info->kernelParamsOffset) {
 		char *args = (char *)((unsigned long)bootx_info) +
Index: linux-work/arch/powerpc/platforms/powermac/time.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/time.c	2006-01-14 14:43:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/time.c	2006-03-24 11:45:28.000000000 +1100
@@ -336,10 +336,10 @@ static struct pmu_sleep_notifier time_sl
  */
 void __init pmac_calibrate_decr(void)
 {
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && defined(CONFIG_ADB_PMU)
 	/* XXX why here? */
 	pmu_register_sleep_notifier(&time_sleep_notifier);
-#endif /* CONFIG_PM */
+#endif
 
 	generic_calibrate_decr();
 
Index: linux-work/drivers/net/tulip/de4x5.c
===================================================================
--- linux-work.orig/drivers/net/tulip/de4x5.c	2006-01-14 14:43:28.000000000 +1100
+++ linux-work/drivers/net/tulip/de4x5.c	2006-03-24 11:45:28.000000000 +1100
@@ -4160,7 +4160,7 @@ get_hw_addr(struct net_device *dev)
     ** If the address starts with 00 a0, we have to bit-reverse
     ** each byte of the address.
     */
-    if ( (_machine & _MACH_Pmac) &&
+    if ( machine_is(powermac) &&
 	 (dev->dev_addr[0] == 0) &&
 	 (dev->dev_addr[1] == 0xa0) )
     {
Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2006-03-10 15:58:17.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2006-03-24 11:45:28.000000000 +1100
@@ -787,7 +787,7 @@ pci_busdev_to_OF_node(struct pci_bus *bu
 	 * fix has to be done by making the remapping per-host and always
 	 * filling the pci_to_OF map. --BenH
 	 */
-	if (_machine == _MACH_Pmac && busnr >= 0xf0)
+	if (machine_is(powermac) && busnr >= 0xf0)
 		busnr -= 0xf0;
 	else
 #endif
@@ -1728,7 +1728,7 @@ long sys_pciconfig_iobase(long which, un
 	 * (bus 0 is HT root), we return the AGP one instead.
 	 */
 #ifdef CONFIG_PPC_PMAC
-	if (_machine == _MACH_Pmac && machine_is_compatible("MacRISC4"))
+	if (machine_is(powermac) && machine_is_compatible("MacRISC4"))
 		if (bus == 0)
 			bus = 0xf0;
 #endif /* CONFIG_PPC_PMAC */
Index: linux-work/arch/powerpc/platforms/pseries/pci_dlpar.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/pci_dlpar.c	2006-03-23 14:26:08.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/pci_dlpar.c	2006-03-24 11:45:28.000000000 +1100
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
+#include <asm/firmware.h>
 
 static struct pci_bus *
 find_bus_among_children(struct pci_bus *bus,
@@ -158,7 +159,7 @@ pcibios_add_pci_devices(struct pci_bus *
 
 	eeh_add_device_tree_early(dn);
 
-	if (_machine == PLATFORM_PSERIES_LPAR) {
+	if (machine_is(pseries) && firmware_has_feature(FW_FEATURE_LPAR)) {
 		/* use ofdt-based probe */
 		of_scan_bus(dn, bus);
 		if (!list_empty(&bus->devices)) {
Index: linux-work/Documentation/powerpc/booting-without-of.txt
===================================================================
--- linux-work.orig/Documentation/powerpc/booting-without-of.txt	2006-03-24 11:42:13.000000000 +1100
+++ linux-work/Documentation/powerpc/booting-without-of.txt	2006-03-24 14:28:27.000000000 +1100
@@ -719,6 +719,10 @@ address which can extend beyond that lim
     - model : this is your board name/model
     - #address-cells : address representation for "root" devices
     - #size-cells: the size representation for "root" devices
+    - device_type : This property shouldn't be necessary. However, if
+      device to create a device_type for your root node, make sure it
+      is _not_ "chrp" as this will be matched by the kernel to be a
+      CHRP machine on 32 bits kernel or a pSeries on 64 bits kernels
 
   Additionally, some recommended properties are:
 



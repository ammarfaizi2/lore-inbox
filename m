Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161151AbWHKHSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWHKHSz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 03:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWHKHSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 03:18:55 -0400
Received: from ozlabs.org ([203.10.76.45]:46528 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161151AbWHKHSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 03:18:54 -0400
Subject: [PATCH] make all archs use early_param
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 17:18:47 +1000
Message-Id: <1155280728.27719.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To celebrate the 2-year anniversary of the creation of the arch-indep
early_param() macros and the generic parse_early_param(), this patch
stops calling it for archs which didn't inserts explicit calls,
polite FIXMEs and a BUG_ON().

Gold star to PowerPC and s390 for calling parse_early_param(), *and*
using it instead of open-coded early cmdline hacking.

Quick guide:
(1) setup_arch() should call parse_early_param() as soon as
    saved_command_line is set.

(2) Use "early_param("param", parse_param);": parse_param() gets a
    NULL arg if cmdline is "param", otherwise whatever follows
    "param=".  Returns 0 on success, -ve on error (which causes printk).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/init/main.c working-2.6.18-rc3-mm2-early_param-for-all/init/main.c
--- linux-2.6.18-rc3-mm2/init/main.c	2006-08-07 12:41:01.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/init/main.c	2006-08-11 17:14:26.000000000 +1000
@@ -445,19 +445,17 @@ static int __init do_early_param(char *p
 	return 0;
 }
 
-/* Arch code calls this early on, or if not, just before other parsing. */
+static __initdata int early_param_parsed;
+
+/* Arch code calls this early on, usually from setup_arch. */
 void __init parse_early_param(void)
 {
-	static __initdata int done = 0;
 	static __initdata char tmp_cmdline[COMMAND_LINE_SIZE];
 
-	if (done)
-		return;
-
 	/* All fall through to do_early_param. */
 	strlcpy(tmp_cmdline, saved_command_line, COMMAND_LINE_SIZE);
 	parse_args("early options", tmp_cmdline, NULL, 0, do_early_param);
-	done = 1;
+	early_param_parsed = 1;
 }
 
 /*
@@ -521,7 +519,7 @@ asmlinkage void __init start_kernel(void
 	build_all_zonelists();
 	page_alloc_init();
 	printk(KERN_NOTICE "Kernel command line: %s\n", saved_command_line);
-	parse_early_param();
+	BUG_ON(!early_param_parsed);
 	parse_args("Booting kernel", command_line, __start___param,
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/alpha/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/alpha/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/alpha/kernel/setup.c	2006-08-07 12:40:14.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/alpha/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -545,8 +545,10 @@ setup_arch(char **cmdline_p)
 	strcpy(saved_command_line, command_line);
 	*cmdline_p = command_line;
 
+	parse_early_param();
+
 	/* 
-	 * Process command-line arguments.
+	 * Process command-line arguments.  FIXME: Convert to early_param()
 	 */
 	while ((p = strsep(&args, " \t")) != NULL) {
 		if (!*p) continue;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/arm26/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/arm26/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/arm26/kernel/setup.c	2006-08-07 12:40:14.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/arm26/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -494,6 +494,7 @@ void __init setup_arch(char **cmdline_p)
 
 	memcpy(saved_command_line, from, COMMAND_LINE_SIZE);
 	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	parse_early_param();
 	parse_cmdline(&meminfo, cmdline_p, from);
 	bootmem_init(&meminfo);
 	paging_init(&meminfo);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/avr32/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/avr32/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/avr32/kernel/setup.c	2006-08-07 12:40:14.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/avr32/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -341,7 +341,9 @@ void __init setup_arch (char **cmdline_p
 	init_mm.end_data = (unsigned long) &_edata;
 	init_mm.brk = (unsigned long) &_end;
 
+	/* FIXME: use early_param() */
 	parse_cmdline_early(cmdline_p);
+	parse_early_param();
 
 	setup_bootmem();
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/cris/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/cris/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/cris/kernel/setup.c	2006-08-07 12:40:14.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/cris/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -155,6 +155,7 @@ setup_arch(char **cmdline_p)
 	/* Save command line for future references. */
 	memcpy(saved_command_line, cris_command_line, COMMAND_LINE_SIZE);
 	saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
+	parse_early_param();
 
 	/* give credit for the CRIS port */
 	show_etrax_copyright();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/frv/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/frv/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/frv/kernel/setup.c	2006-08-03 12:50:11.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/frv/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -765,6 +765,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	memcpy(saved_command_line, redboot_command_line, COMMAND_LINE_SIZE);
+	parse_early_param();
 
 	determine_cpu();
 	determine_clocks(1);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/h8300/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/h8300/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/h8300/kernel/setup.c	2006-08-03 12:50:11.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/h8300/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -156,6 +156,7 @@ void __init setup_arch(char **cmdline_p)
 	*cmdline_p = &command_line[0];
 	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
 	saved_command_line[COMMAND_LINE_SIZE-1] = 0;
+	parse_early_param();
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p)) 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/ia64/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/ia64/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/ia64/kernel/setup.c	2006-08-07 12:40:18.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/ia64/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -444,6 +444,7 @@ setup_arch (char **cmdline_p)
 	machvec_init(NULL);
 #endif
 
+	/* FIXME: Convert this and platform_setup to use early_param() */
 	if (early_console_setup(*cmdline_p) == 0)
 		mark_bsp_online();
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/m32r/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/m32r/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/m32r/kernel/setup.c	2006-08-03 12:50:15.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/m32r/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -260,7 +260,9 @@ void __init setup_arch(char **cmdline_p)
 	data_resource.start = virt_to_phys(_etext);
 	data_resource.end = virt_to_phys(_edata)-1;
 
+	/* FIXME: Use early_param() */
 	parse_mem_cmdline(cmdline_p);
+	parse_early_param();
 
 	setup_memory();
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/m68k/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/m68k/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/m68k/kernel/setup.c	2006-08-03 12:50:15.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/m68k/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -242,7 +242,9 @@ void __init setup_arch(char **cmdline_p)
 
 	*cmdline_p = m68k_command_line;
 	memcpy(saved_command_line, *cmdline_p, CL_SIZE);
+	parse_early_param();
 
+	/* FIXME: Replace with early_param() */
 	/* Parse the command line for arch-specific options.
 	 * For the m68k, this is currently only "debug=xxx" to enable printing
 	 * certain kernel messages to some machine-specific device.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/m68knommu/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/m68knommu/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/m68knommu/kernel/setup.c	2006-08-03 12:50:15.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/m68knommu/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -236,6 +236,7 @@ void setup_arch(char **cmdline_p)
 	*cmdline_p = &command_line[0];
 	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
 	saved_command_line[COMMAND_LINE_SIZE-1] = 0;
+	parse_early_param();
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p))
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/mips/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/mips/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/mips/kernel/setup.c	2006-08-03 12:50:17.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/mips/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -476,7 +476,9 @@ static void __init arch_mem_init(char **
 	strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
+	parse_early_param();
 
+	/* FIXME: replace with early_param() */
 	parse_cmdline_early();
 	bootmem_init();
 	sparse_init();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/parisc/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/parisc/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/parisc/kernel/setup.c	2006-08-03 12:50:18.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/parisc/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -141,6 +141,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	setup_pdc();
 	setup_cmdline(cmdline_p);
+	parse_early_param();
 	collect_boot_cpu_data();
 	do_memory_inventory();  /* probe for physical memory */
 	parisc_cache_init();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/s390/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/s390/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/s390/kernel/setup.c	2006-08-03 12:50:21.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/s390/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -600,6 +600,7 @@ setup_arch(char **cmdline_p)
 
 	/* Save unparsed command line copy for /proc/cmdline */
 	strlcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	parse_early_param();
 
 	*cmdline_p = COMMAND_LINE;
 	*(*cmdline_p + COMMAND_LINE_SIZE - 1) = '\0';
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/sh/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/sh/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/sh/kernel/setup.c	2006-08-07 12:40:19.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/sh/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -274,7 +274,9 @@ void __init setup_arch(char **cmdline_p)
 	data_resource.start = (unsigned long)virt_to_phys(_etext);
 	data_resource.end = (unsigned long)virt_to_phys(_edata)-1;
 
+	/* FIXME: Replace with early_param() */
 	sh_mv_setup(cmdline_p);
+	parse_early_param();
 
 	/*
 	 * Find the highest page frame number we have available
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/sh64/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/sh64/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/sh64/kernel/setup.c	2006-08-03 12:50:21.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/sh64/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -194,7 +194,9 @@ void __init setup_arch(char **cmdline_p)
 	data_resource.start = __pa(_etext);
 	data_resource.end = __pa(_edata)-1;
 
+	/* FIXME: Use early_param() */
 	parse_mem_cmdline(cmdline_p);
+	parse_early_param();
 
 	/*
 	 * Find the lowest and highest page frame numbers we have available
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/sparc/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/sparc/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/sparc/kernel/setup.c	2006-08-03 12:50:21.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/sparc/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -259,6 +259,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
 	strcpy(saved_command_line, *cmdline_p);
+	parse_early_param();
 
 	/* Set sparc_cpu_model */
 	sparc_cpu_model = sun_unknown;
@@ -306,6 +307,7 @@ void __init setup_arch(char **cmdline_p)
 #elif defined(CONFIG_PROM_CONSOLE)
 	conswitchp = &prom_con;
 #endif
+	/* FIXME: use early_param() */
 	boot_flags_init(*cmdline_p);
 
 	idprom_init();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/sparc64/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/sparc64/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/sparc64/kernel/setup.c	2006-08-03 12:50:22.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/sparc64/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -328,6 +328,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
 	strcpy(saved_command_line, *cmdline_p);
+	parse_early_param();
 
 	if (tlb_type == hypervisor)
 		printk("ARCH: SUN4V\n");
@@ -340,6 +341,7 @@ void __init setup_arch(char **cmdline_p)
 	conswitchp = &prom_con;
 #endif
 
+	/* FIXME: use early_param() */
 	boot_flags_init(*cmdline_p);
 
 	idprom_init();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/um/kernel/um_arch.c working-2.6.18-rc3-mm2-early_param-for-all/arch/um/kernel/um_arch.c
--- linux-2.6.18-rc3-mm2/arch/um/kernel/um_arch.c	2006-08-07 12:40:19.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/um/kernel/um_arch.c	2006-08-11 17:14:03.000000000 +1000
@@ -485,6 +485,7 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
         strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
  	*cmdline_p = command_line;
+	parse_early_param();
 	setup_hostinfo();
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/v850/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/v850/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/v850/kernel/setup.c	2006-08-07 12:40:20.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/v850/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -66,6 +66,7 @@ void __init setup_arch (char **cmdline)
 	*cmdline = command_line;
 	memcpy (saved_command_line, command_line, COMMAND_LINE_SIZE);
 	saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
+	parse_early_param();
 
 	console_verbose ();
 
@@ -83,6 +84,7 @@ void __init setup_arch (char **cmdline)
 		CPU_MODEL_LONG, PLATFORM_LONG);
 
 	/* do machine-specific setups.  */
+	/* FIXME: use early_param() */
 	mach_setup (cmdline);
 
 #ifdef CONFIG_MTD
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/xtensa/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/xtensa/kernel/setup.c
--- linux-2.6.18-rc3-mm2/arch/xtensa/kernel/setup.c	2006-08-03 12:50:24.000000000 +1000
+++ working-2.6.18-rc3-mm2-early_param-for-all/arch/xtensa/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
@@ -258,6 +258,7 @@ void __init setup_arch(char **cmdline_p)
 	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
 	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
 	*cmdline_p = command_line;
+	parse_early_param();
 
 	/* Reserve some memory regions */
 

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbUCYAAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUCYAAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:00:03 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:45808 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S262465AbUCXX5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:57:50 -0500
Subject: [patch 3/22] __early_param for ppc
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, paulus@samba.org
From: trini@kernel.crashing.org
Message-Id: <20040324235747.NSKC2428.fed1mtao03.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:57:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Paul Mackerras <paulus@samba.org>
- Remove saved_command_line (and saving of the command line).
- Call parse_early_options
- Convert "gdb", "xmon", "adb_sync" to __early_param.
- Move the PPCBUG_NVRAM bits from platforms/platform.c into setup.c
  so that it's done in time to grab the command line and parse any
  early options found there.
- Slightly related to all of this, change the mem= parsing logic to
  use memparse, instead of duplicating that specific logic.


---

 include/asm-ppc/setup.h                                      |    0 
 linux-2.6-early_setup-trini/arch/ppc/kernel/ppc-stub.c       |   17 +++
 linux-2.6-early_setup-trini/arch/ppc/kernel/setup.c          |   51 +++++------
 linux-2.6-early_setup-trini/arch/ppc/kernel/vmlinux.lds.S    |    3 
 linux-2.6-early_setup-trini/arch/ppc/mm/init.c               |   16 ---
 linux-2.6-early_setup-trini/arch/ppc/platforms/lopec_setup.c |   16 ---
 linux-2.6-early_setup-trini/arch/ppc/platforms/pplus.c       |   17 ---
 linux-2.6-early_setup-trini/arch/ppc/platforms/prep_setup.c  |   15 ---
 linux-2.6-early_setup-trini/arch/ppc/xmon/xmon.c             |    9 +
 9 files changed, 56 insertions(+), 88 deletions(-)

diff -puN arch/ppc/kernel/ppc-stub.c~ppc arch/ppc/kernel/ppc-stub.c
--- linux-2.6-early_setup/arch/ppc/kernel/ppc-stub.c~ppc	2004-03-24 16:15:05.290996369 -0700
+++ linux-2.6-early_setup-trini/arch/ppc/kernel/ppc-stub.c	2004-03-24 16:15:05.311991640 -0700
@@ -105,6 +105,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
+#include <linux/init.h>
 
 #include <asm/cacheflush.h>
 #include <asm/system.h>
@@ -834,6 +835,22 @@ breakpoint(void)
 	     breakinst: .long 0x7d821008");
 }
 
+/* Give us an early hook in. */
+static void __init early_kgdb(char **ign)
+{
+	if (ppc_md.kgdb_map_scc)
+		ppc_md.kgdb_map_scc();
+
+	set_debug_traps();
+
+	if (ppc_md.progress)
+		ppc_md.progress("setup_arch: kgdb breakpoint", 0x4000);
+	printk("kgdb breakpoint activated\n");
+
+	breakpoint();
+}
+__early_param("gdb", early_kgdb);
+
 #ifdef CONFIG_KGDB_CONSOLE
 /* Output string in GDB O-packet format if GDB has connected. If nothing
    output, returns 0 (caller must then handle output). */
diff -puN arch/ppc/kernel/setup.c~ppc arch/ppc/kernel/setup.c
--- linux-2.6-early_setup/arch/ppc/kernel/setup.c~ppc	2004-03-24 16:15:05.292995918 -0700
+++ linux-2.6-early_setup-trini/arch/ppc/kernel/setup.c	2004-03-24 16:15:05.312991415 -0700
@@ -36,6 +36,7 @@
 #include <asm/pmac_feature.h>
 #include <asm/sections.h>
 #include <asm/nvram.h>
+#include <asm/prep_nvram.h>
 #include <asm/xmon.h>
 
 #if defined CONFIG_KGDB
@@ -53,7 +54,6 @@ extern void ppc6xx_idle(void);
 extern void power4_idle(void);
 
 extern boot_infos_t *boot_infos;
-char saved_command_line[COMMAND_LINE_SIZE];
 unsigned char aux_device_present;
 struct ide_machdep_calls ppc_ide_md;
 char *sysmap;
@@ -457,12 +457,6 @@ platform_init(unsigned long r3, unsigned
 			}
 		}
 	}
-#ifdef CONFIG_ADB
-	if (strstr(cmd_line, "adb_sync")) {
-		extern int __adb_probe_sync;
-		__adb_probe_sync = 1;
-	}
-#endif /* CONFIG_ADB */
 
 	switch (_machine) {
 	case _MACH_Pmac:
@@ -473,6 +467,16 @@ platform_init(unsigned long r3, unsigned
 		break;
 	}
 }
+
+#ifdef CONFIG_ADB
+/* Allow us to say that ADB probing will be done synchronously. */
+static void __init early_adb_sync(char **ign)
+{
+	extern int __adb_probe_sync;
+	__adb_probe_sync = 1;
+}
+__early_param("adb_sync", early_adb_sync);
+#endif /* CONFIG_ADB */
 #endif /* CONFIG_PPC_MULTIPLATFORM */
 
 struct bi_record *find_bootinfo(void)
@@ -635,25 +639,8 @@ void __init setup_arch(char **cmdline_p)
 		pmac_feature_init();	/* New cool way */
 #endif
 
-#ifdef CONFIG_XMON
-	xmon_map_scc();
-	if (strstr(cmd_line, "xmon"))
-		xmon(0);
-#endif /* CONFIG_XMON */
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: enter", 0x3eab);
 
-#if defined(CONFIG_KGDB)
-	if (ppc_md.kgdb_map_scc)
-		ppc_md.kgdb_map_scc();
-	set_debug_traps();
-	if (strstr(cmd_line, "gdb")) {
-		if (ppc_md.progress)
-			ppc_md.progress("setup_arch: kgdb breakpoint", 0x4000);
-		printk("kgdb breakpoint activated\n");
-		breakpoint();
-	}
-#endif
-
 	/*
 	 * Set cache line size based on type of cpu as a default.
 	 * Systems with OF can look in the properties on the cpu node(s)
@@ -670,14 +657,24 @@ void __init setup_arch(char **cmdline_p)
 	/* reboot on panic */
 	panic_timeout = 180;
 
+	/* See if we need to grab the command line params from PPCBUG. */
+#ifdef CONFIG_PPCBUG_NVRAM
+	/* Read in NVRAM data */
+	init_prep_nvram();
+
+	if (cmd_line[0] == '\0') {
+		char *bootargs = prep_nvram_get_var("bootargs");
+		if (bootargs != NULL)
+			strlcpy(cmd_line, bootargs, sizeof(cmd_line));
+	}
+#endif
+
 	init_mm.start_code = PAGE_OFFSET;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = (unsigned long) klimit;
-
-	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, cmd_line, sizeof(saved_command_line));
 	*cmdline_p = cmd_line;
+	parse_early_options(cmdline_p);
 
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
diff -puN arch/ppc/kernel/vmlinux.lds.S~ppc arch/ppc/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/ppc/kernel/vmlinux.lds.S~ppc	2004-03-24 16:15:05.294995468 -0700
+++ linux-2.6-early_setup-trini/arch/ppc/kernel/vmlinux.lds.S	2004-03-24 16:15:05.312991415 -0700
@@ -101,6 +101,9 @@ SECTIONS
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;
+  __early_begin = .;
+  __early_param : { *(__early_param) }
+  __early_end = .;
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;
diff -puN arch/ppc/mm/init.c~ppc arch/ppc/mm/init.c
--- linux-2.6-early_setup/arch/ppc/mm/init.c~ppc	2004-03-24 16:15:05.296995018 -0700
+++ linux-2.6-early_setup-trini/arch/ppc/mm/init.c	2004-03-24 16:15:05.313991190 -0700
@@ -209,19 +209,9 @@ void MMU_setup(void)
 		char *p, *q;
 		unsigned long maxmem = 0;
 
-		for (q = cmd_line; (p = strstr(q, "mem=")) != 0; ) {
-			q = p + 4;
-			if (p > cmd_line && p[-1] != ' ')
-				continue;
-			maxmem = simple_strtoul(q, &q, 0);
-			if (*q == 'k' || *q == 'K') {
-				maxmem <<= 10;
-				++q;
-			} else if (*q == 'm' || *q == 'M') {
-				maxmem <<= 20;
-				++q;
-			}
-		}
+		for (q = cmd_line; (p = strstr(q, "mem=")) != 0; )
+			maxmem = memparse(p + 4, &q);
+
 		__max_memory = maxmem;
 	}
 }
diff -puN arch/ppc/platforms/lopec_setup.c~ppc arch/ppc/platforms/lopec_setup.c
--- linux-2.6-early_setup/arch/ppc/platforms/lopec_setup.c~ppc	2004-03-24 16:15:05.298994567 -0700
+++ linux-2.6-early_setup-trini/arch/ppc/platforms/lopec_setup.c	2004-03-24 16:15:05.313991190 -0700
@@ -33,7 +33,6 @@
 #include <asm/hw_irq.h>
 #include <asm/prep_nvram.h>
 
-extern char saved_command_line[];
 extern void lopec_find_bridges(void);
 
 /*
@@ -327,21 +326,6 @@ lopec_setup_arch(void)
 #ifdef CONFIG_VT
 	conswitchp = &dummy_con;
 #endif
-#ifdef CONFIG_PPCBUG_NVRAM
-	/* Read in NVRAM data */
-	init_prep_nvram();
-
-	/* if no bootargs, look in NVRAM */
-	if ( cmd_line[0] == '\0' ) {
-		char *bootargs;
-		 bootargs = prep_nvram_get_var("bootargs");
-		 if (bootargs != NULL) {
-			 strcpy(cmd_line, bootargs);
-			 /* again.. */
-			 strcpy(saved_command_line, cmd_line);
-		}
-	}
-#endif
 }
 
 void __init
diff -puN arch/ppc/platforms/pplus.c~ppc arch/ppc/platforms/pplus.c
--- linux-2.6-early_setup/arch/ppc/platforms/pplus.c~ppc	2004-03-24 16:15:05.300994117 -0700
+++ linux-2.6-early_setup-trini/arch/ppc/platforms/pplus.c	2004-03-24 16:15:05.314990965 -0700
@@ -48,8 +48,6 @@
 
 TODC_ALLOC();
 
-extern char saved_command_line[];
-
 extern void pplus_setup_hose(void);
 extern void pplus_set_VIA_IDE_native(void);
 
@@ -588,21 +586,6 @@ static void __init pplus_setup_arch(void
 #elif defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp = &dummy_con;
 #endif
-#ifdef CONFIG_PPCBUG_NVRAM
-	/* Read in NVRAM data */
-	init_prep_nvram();
-
-	/* if no bootargs, look in NVRAM */
-	if (cmd_line[0] == '\0') {
-		char *bootargs;
-		bootargs = prep_nvram_get_var("bootargs");
-		if (bootargs != NULL) {
-			strcpy(cmd_line, bootargs);
-			/* again.. */
-			strcpy(saved_command_line, cmd_line);
-		}
-	}
-#endif
 	if (ppc_md.progress)
 		ppc_md.progress("pplus_setup_arch: exit", 0);
 }
diff -puN arch/ppc/platforms/prep_setup.c~ppc arch/ppc/platforms/prep_setup.c
--- linux-2.6-early_setup/arch/ppc/platforms/prep_setup.c~ppc	2004-03-24 16:15:05.302993667 -0700
+++ linux-2.6-early_setup-trini/arch/ppc/platforms/prep_setup.c	2004-03-24 16:15:05.315990740 -0700
@@ -76,7 +76,6 @@ extern void rs_nvram_write_val(int addr,
 extern void ibm_prep_init(void);
 
 extern void prep_find_bridges(void);
-extern char saved_command_line[];
 
 int _prep_type;
 
@@ -774,20 +773,6 @@ prep_setup_arch(void)
 		break;
 	}
 
-	/* Read in NVRAM data */
-	init_prep_nvram();
-
-	/* if no bootargs, look in NVRAM */
-	if ( cmd_line[0] == '\0' ) {
-		char *bootargs;
-		 bootargs = prep_nvram_get_var("bootargs");
-		 if (bootargs != NULL) {
-			 strcpy(cmd_line, bootargs);
-			 /* again.. */
-			 strcpy(saved_command_line, cmd_line);
-		}
-	}
-
 #ifdef CONFIG_SOUND_CS4232
 	prep_init_sound();
 #endif /* CONFIG_SOUND_CS4232 */
diff -puN arch/ppc/xmon/xmon.c~ppc arch/ppc/xmon/xmon.c
--- linux-2.6-early_setup/arch/ppc/xmon/xmon.c~ppc	2004-03-24 16:15:05.304993216 -0700
+++ linux-2.6-early_setup-trini/arch/ppc/xmon/xmon.c	2004-03-24 16:15:05.316990515 -0700
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
+#include <linux/init.h>
 #include <asm/ptrace.h>
 #include <asm/string.h>
 #include <asm/prom.h>
@@ -262,6 +263,14 @@ xmon(struct pt_regs *excp)
 	get_tb(start_tb[smp_processor_id()]);
 }
 
+/* Allow us a hook to drop in early. */
+static void __init early_xmon(char **ign)
+{
+	xmon_map_scc();
+	xmon(0);
+}
+__early_param("xmon", early_xmon);
+
 irqreturn_t
 xmon_irq(int irq, void *d, struct pt_regs *regs)
 {
diff -puN include/asm-ppc/machdep.h~ppc include/asm-ppc/machdep.h
diff -puN include/asm-ppc/setup.h~ppc include/asm-ppc/setup.h

_

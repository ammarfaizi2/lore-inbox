Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUCYAVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUCYADG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:03:06 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:52959 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S262774AbUCXX7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:59:46 -0500
Subject: [patch 12/22] __early_param for mips
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ralf@linux-mips.org
From: trini@kernel.crashing.org
Message-Id: <20040324235943.JUW2477.fed1mtao01.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:59:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: ralf@linux-mips.org
- Remove saved_command_line (and saving of the command line).
- Call parse_early_options
- Convert mem= to __early_param


---

 linux-2.6-early_setup-trini/arch/mips/kernel/setup.c       |   75 ++++---------
 linux-2.6-early_setup-trini/arch/mips/kernel/vmlinux.lds.S |    3 
 2 files changed, 31 insertions(+), 47 deletions(-)

diff -puN arch/mips/kernel/setup.c~mips arch/mips/kernel/setup.c
--- linux-2.6-early_setup/arch/mips/kernel/setup.c~mips	2004-03-24 16:15:08.074369511 -0700
+++ linux-2.6-early_setup-trini/arch/mips/kernel/setup.c	2004-03-24 16:15:08.079368385 -0700
@@ -71,7 +71,6 @@ EXPORT_SYMBOL(mips_machgroup);
 struct boot_mem_map boot_mem_map;
 
 static char command_line[CL_SIZE];
-       char saved_command_line[CL_SIZE];
        char arcs_cmdline[CL_SIZE]=CONFIG_CMDLINE;
 
 /*
@@ -143,57 +142,37 @@ static void __init print_memory_map(void
 	}
 }
 
-static inline void parse_cmdline_early(void)
+/*
+ * "mem=XXX[kKmM]" defines a memory region from 0 to <XXX>, overriding
+ * the determined size. "mem=XXX[KkmM]@YYY[KkmM]" defines a memory region
+ * from <YYY> to <YYY>+<XXX>, overriding the determined size.
+ */
+static int __init early_mem(char *from)
 {
-	char c = ' ', *to = command_line, *from = saved_command_line;
 	unsigned long start_at, mem_size;
 	int len = 0;
-	int usermem = 0;
 
-	printk("Determined physical RAM map:\n");
-	print_memory_map();
+	/*
+	 * The user has specified the memory size, so we blow away any
+	 * automatically generated size.
+	 */
+	boot_mem_map.nr_map = 0;
 
-	for (;;) {
-		/*
-		 * "mem=XXX[kKmM]" defines a memory region from
-		 * 0 to <XXX>, overriding the determined size.
-		 * "mem=XXX[KkmM]@YYY[KkmM]" defines a memory region from
-		 * <YYY> to <YYY>+<XXX>, overriding the determined size.
-		 */
-		if (c == ' ' && !memcmp(from, "mem=", 4)) {
-			if (to != command_line)
-				to--;
-			/*
-			 * If a user specifies memory size, we
-			 * blow away any automatically generated
-			 * size.
-			 */
-			if (usermem == 0) {
-				boot_mem_map.nr_map = 0;
-				usermem = 1;
-			}
-			mem_size = memparse(from + 4, &from);
-			if (*from == '@')
-				start_at = memparse(from + 1, &from);
-			else
-				start_at = 0;
-			add_memory_region(start_at, mem_size, BOOT_MEM_RAM);
-		}
-		c = *(from++);
-		if (!c)
-			break;
-		if (CL_SIZE <= ++len)
-			break;
-		*(to++) = c;
-	}
-	*to = '\0';
+	mem_size = memparse(from, &from);
 
-	if (usermem) {
-		printk("User-defined physical RAM map:\n");
-		print_memory_map();
-	}
-}
+	if (*from == '@')
+		start_at = memparse(from + 1, &from);
+	else
+		start_at = 0;
+
+	add_memory_region(start_at, mem_size, BOOT_MEM_RAM);
 
+	printk("User-defined physical RAM map:\n");
+	print_memory_map();
+
+	return 0;
+}
+__early_param("mem=", early_mem);
 
 #define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
@@ -484,11 +463,13 @@ void __init setup_arch(char **cmdline_p)
 	do_earlyinitcalls();
 
 	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
-	strlcpy(saved_command_line, command_line, sizeof(saved_command_line));
+
+	printk("Determined physical RAM map:\n");
+	print_memory_map();
 
 	*cmdline_p = command_line;
+	parse_early_options(cmdline_p);
 
-	parse_cmdline_early();
 	bootmem_init();
 	paging_init();
 	resource_init();
diff -puN arch/mips/kernel/vmlinux.lds.S~mips arch/mips/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/mips/kernel/vmlinux.lds.S~mips	2004-03-24 16:15:08.076369060 -0700
+++ linux-2.6-early_setup-trini/arch/mips/kernel/vmlinux.lds.S	2004-03-24 16:15:08.079368385 -0700
@@ -95,6 +95,9 @@ SECTIONS
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;
+  __early_begin = .;
+  __early_param : { *(__early_param) }
+  __early_end = .;
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;

_

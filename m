Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUCYAHx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUCYAFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:05:39 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:55518 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S262648AbUCXX7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:59:07 -0500
Subject: [patch 9/22] __early_param for ia64
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, davidm@hpl.hp.com
From: trini@kernel.crashing.org
Message-Id: <20040324235904.JMM2477.fed1mtao01.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:59:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: davidm@hpl.hp.com
- Remove saved_command_line (and saving of the command line).
- Call parse_early_options
- Convert mem= to __early_param.


---

 linux-2.6-early_setup-trini/arch/ia64/kernel/efi.c         |   34 +++++--------
 linux-2.6-early_setup-trini/arch/ia64/kernel/setup.c       |    4 -
 linux-2.6-early_setup-trini/arch/ia64/kernel/vmlinux.lds.S |    6 ++
 3 files changed, 21 insertions(+), 23 deletions(-)

diff -puN arch/ia64/kernel/efi.c~ia64 arch/ia64/kernel/efi.c
--- linux-2.6-early_setup/arch/ia64/kernel/efi.c~ia64	2004-03-24 16:15:07.152577112 -0700
+++ linux-2.6-early_setup-trini/arch/ia64/kernel/efi.c	2004-03-24 16:15:07.159575536 -0700
@@ -469,6 +469,19 @@ efi_map_pal_code (void)
 	}
 }
 
+static int __init
+early_mem(char *cp)
+{
+	mem_limit = memparse(cp, &cp) - 1;
+
+	if (mem_limit != ~0UL)
+		printk(KERN_INFO "Ignoring memory above %luMB\n",
+				mem_limit >> 20);
+
+	return 0;
+}
+__early_param("mem=", early_mem);
+
 void __init
 efi_init (void)
 {
@@ -476,28 +489,9 @@ efi_init (void)
 	efi_config_table_t *config_tables;
 	efi_char16_t *c16;
 	u64 efi_desc_size;
-	char *cp, *end, vendor[100] = "unknown";
-	extern char saved_command_line[];
+	char vendor[100] = "unknown";
 	int i;
 
-	/* it's too early to be able to use the standard kernel command line support... */
-	for (cp = saved_command_line; *cp; ) {
-		if (memcmp(cp, "mem=", 4) == 0) {
-			cp += 4;
-			mem_limit = memparse(cp, &end) - 1;
-			if (end != cp)
-				break;
-			cp = end;
-		} else {
-			while (*cp != ' ' && *cp)
-				++cp;
-			while (*cp == ' ')
-				++cp;
-		}
-	}
-	if (mem_limit != ~0UL)
-		printk(KERN_INFO "Ignoring memory above %luMB\n", mem_limit >> 20);
-
 	efi.systab = __va(ia64_boot_param->efi_systab);
 
 	/*
diff -puN arch/ia64/kernel/setup.c~ia64 arch/ia64/kernel/setup.c
--- linux-2.6-early_setup/arch/ia64/kernel/setup.c~ia64	2004-03-24 16:15:07.154576662 -0700
+++ linux-2.6-early_setup-trini/arch/ia64/kernel/setup.c	2004-03-24 16:15:07.160575311 -0700
@@ -90,8 +90,6 @@ EXPORT_SYMBOL(ia64_max_iommu_merge_mask)
 
 #define COMMAND_LINE_SIZE	512
 
-char saved_command_line[COMMAND_LINE_SIZE]; /* used in proc filesystem */
-
 /*
  * We use a special marker for the end of memory and it uses the extra (+1) slot
  */
@@ -259,7 +257,7 @@ setup_arch (char **cmdline_p)
 	ia64_patch_vtop((u64) __start___vtop_patchlist, (u64) __end___vtop_patchlist);
 
 	*cmdline_p = __va(ia64_boot_param->command_line);
-	strlcpy(saved_command_line, *cmdline_p, sizeof(saved_command_line));
+	parse_early_options(cmdline_p);
 
 	efi_init();
 
diff -puN arch/ia64/kernel/vmlinux.lds.S~ia64 arch/ia64/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/ia64/kernel/vmlinux.lds.S~ia64	2004-03-24 16:15:07.156576212 -0700
+++ linux-2.6-early_setup-trini/arch/ia64/kernel/vmlinux.lds.S	2004-03-24 16:15:07.160575311 -0700
@@ -128,6 +128,12 @@ SECTIONS
 	  *(.init.setup)
 	  __setup_end = .;
 	}
+  __early_param : AT(ADDR(__early_param) - LOAD_OFFSET)
+	{
+	  __early_begin = .;
+	  *(__early_param)
+	  __early_end = .;
+	}
   __param : AT(ADDR(__param) - LOAD_OFFSET)
         {
 	  __start___param = .;

_

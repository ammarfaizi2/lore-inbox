Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbUCYAmJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUCYAlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:41:12 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:19597 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S262490AbUCXX6F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:58:05 -0500
Subject: [patch 4/22] __early_param for arm
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rmk@arm.linux.org.uk
From: trini@kernel.crashing.org
Message-Id: <20040324235800.FMRL2451.fed1mtao05.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:58:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Russell King <rmk@arm.linux.org.uk>
- Remove saved_command_line (and saving of the command line).
- Call parse_early_options
- Convert initrd=, mem=, *cache* options.


---

 linux-2.6-early_setup-trini/arch/arm/kernel/setup.c |   70 ++++----------------
 linux-2.6-early_setup-trini/arch/arm/mm/mm-armv.c   |   31 +++++---
 linux-2.6-early_setup-trini/include/asm-arm/setup.h |   12 ---
 3 files changed, 34 insertions(+), 79 deletions(-)

diff -puN arch/arm/kernel/setup.c~arm arch/arm/kernel/setup.c
--- linux-2.6-early_setup/arch/arm/kernel/setup.c~arm	2004-03-24 16:15:05.735896171 -0700
+++ linux-2.6-early_setup-trini/arch/arm/kernel/setup.c	2004-03-24 16:15:05.741894820 -0700
@@ -81,7 +81,6 @@ struct cpu_cache_fns cpu_cache;
 
 unsigned char aux_device_present;
 char elf_platform[ELF_PLATFORM_SIZE];
-char saved_command_line[COMMAND_LINE_SIZE];
 unsigned long phys_initrd_start __initdata = 0;
 unsigned long phys_initrd_size __initdata = 0;
 
@@ -330,17 +329,19 @@ static struct machine_desc * __init setu
 	return list;
 }
 
-static void __init early_initrd(char **p)
+static int __init early_initrd(char *p)
 {
 	unsigned long start, size;
 
-	start = memparse(*p, p);
-	if (**p == ',') {
-		size = memparse((*p) + 1, p);
+	start = memparse(p, &p);
+	if (*p == ',') {
+		size = memparse(p++, &p);
 
 		phys_initrd_start = start;
 		phys_initrd_size = size;
 	}
+
+	return 0;
 }
 __early_param("initrd=", early_initrd);
 
@@ -348,15 +349,14 @@ __early_param("initrd=", early_initrd);
  * Pick out the memory size.  We look for mem=size@start,
  * where start and size are "size[KkMm]"
  */
-static void __init early_mem(char **p)
+static int __init early_mem(char *p)
 {
 	static int usermem __initdata = 0;
 	unsigned long size, start;
 
 	/*
-	 * If the user specifies memory size, we
-	 * blow away any automatically generated
-	 * size.
+	 * The user has specified the memory size for the first time,
+	 * so we blow away any automatically generated size.
 	 */
 	if (usermem == 0) {
 		usermem = 1;
@@ -364,55 +364,18 @@ static void __init early_mem(char **p)
 	}
 
 	start = PHYS_OFFSET;
-	size  = memparse(*p, p);
-	if (**p == '@')
-		start = memparse(*p + 1, p);
+	size  = memparse(p, &p);
+	if (*p == '@')
+		start = memparse(p + 1, &p);
 
 	meminfo.bank[meminfo.nr_banks].start = start;
 	meminfo.bank[meminfo.nr_banks].size  = size;
 	meminfo.bank[meminfo.nr_banks].node  = PHYS_TO_NID(start);
 	meminfo.nr_banks += 1;
-}
-__early_param("mem=", early_mem);
-
-/*
- * Initial parsing of the command line.
- */
-static void __init parse_cmdline(char **cmdline_p, char *from)
-{
-	char c = ' ', *to = command_line;
-	int len = 0;
 
-	for (;;) {
-		if (c == ' ') {
-			extern struct early_params __early_begin, __early_end;
-			struct early_params *p;
-
-			for (p = &__early_begin; p < &__early_end; p++) {
-				int len = strlen(p->arg);
-
-				if (memcmp(from, p->arg, len) == 0) {
-					if (to != command_line)
-						to -= 1;
-					from += len;
-					p->fn(&from);
-
-					while (*from != ' ' && *from != '\0')
-						from++;
-					break;
-				}
-			}
-		}
-		c = *from++;
-		if (!c)
-			break;
-		if (COMMAND_LINE_SIZE <= ++len)
-			break;
-		*to++ = c;
-	}
-	*to = '\0';
-	*cmdline_p = command_line;
+	return 0;
 }
+__early_param("mem=", early_mem);
 
 static void __init
 setup_ramdisk(int doload, int prompt, int image_start, unsigned int rd_sz)
@@ -704,9 +667,8 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data   = (unsigned long) &_edata;
 	init_mm.brk	   = (unsigned long) &_end;
 
-	memcpy(saved_command_line, from, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
-	parse_cmdline(cmdline_p, from);
+	*cmdline_p = from;
+	parse_early_options(cmdline_p);
 	bootmem_init(&meminfo);
 	paging_init(&meminfo, mdesc);
 	request_standard_resources(&meminfo, mdesc);
diff -puN arch/arm/mm/mm-armv.c~arm arch/arm/mm/mm-armv.c
--- linux-2.6-early_setup/arch/arm/mm/mm-armv.c~arm	2004-03-24 16:15:05.737895720 -0700
+++ linux-2.6-early_setup-trini/arch/arm/mm/mm-armv.c	2004-03-24 16:15:05.742894594 -0700
@@ -80,18 +80,18 @@ static struct cachepolicy cache_policies
  * writebuffer to be turned off.  (Note: the write
  * buffer should not be on and the cache off).
  */
-static void __init early_cachepolicy(char **p)
+static int __init early_cachepolicy(char *p)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(cache_policies); i++) {
 		int len = strlen(cache_policies[i].policy);
 
-		if (memcmp(*p, cache_policies[i].policy, len) == 0) {
+		if (memcmp(p, cache_policies[i].policy, len) == 0) {
 			cachepolicy = i;
 			cr_alignment &= ~cache_policies[i].cr_mask;
 			cr_no_alignment &= ~cache_policies[i].cr_mask;
-			*p += len;
+			p += len;
 			break;
 		}
 	}
@@ -99,31 +99,36 @@ static void __init early_cachepolicy(cha
 		printk(KERN_ERR "ERROR: unknown or unsupported cache policy\n");
 	flush_cache_all();
 	set_cr(cr_alignment);
+
+	return 0;
 }
 
-static void __init early_nocache(char **__unused)
+static int __init early_nocache(char *__unused)
 {
 	char *p = "buffered";
 	printk(KERN_WARNING "nocache is deprecated; use cachepolicy=%s\n", p);
-	early_cachepolicy(&p);
+	early_cachepolicy(p);
+
+	return 0;
 }
 
-static void __init early_nowrite(char **__unused)
+static int __init early_nowrite(char *__unused)
 {
 	char *p = "uncached";
 	printk(KERN_WARNING "nowb is deprecated; use cachepolicy=%s\n", p);
-	early_cachepolicy(&p);
+	early_cachepolicy(p);
+
+	return 0;
 }
 
-static void __init early_ecc(char **p)
+static int __init early_ecc(char *p)
 {
-	if (memcmp(*p, "on", 2) == 0) {
+	if (memcmp(p, "on", 2) == 0)
 		ecc_mask = PMD_PROTECTION;
-		*p += 2;
-	} else if (memcmp(*p, "off", 3) == 0) {
+	else if (memcmp(p, "off", 3) == 0)
 		ecc_mask = 0;
-		*p += 3;
-	}
+
+	return 0;
 }
 
 __early_param("nocache", early_nocache);
diff -puN include/asm-arm/setup.h~arm include/asm-arm/setup.h
--- linux-2.6-early_setup/include/asm-arm/setup.h~arm	2004-03-24 16:15:05.738895495 -0700
+++ linux-2.6-early_setup-trini/include/asm-arm/setup.h	2004-03-24 16:15:05.742894594 -0700
@@ -202,16 +202,4 @@ struct meminfo {
 
 extern struct meminfo meminfo;
 
-/*
- * Early command line parameters.
- */
-struct early_params {
-	const char *arg;
-	void (*fn)(char **p);
-};
-
-#define __early_param(name,fn)					\
-static struct early_params __early_##fn __attribute_used__	\
-__attribute__((__section__("__early_param"))) = { name, fn }
-
 #endif

_

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbUCYApN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbUCYAjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:39:55 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:45752 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262618AbUCXX6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:58:32 -0500
Subject: [patch 6/22] __early_param for arm26
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
From: trini@kernel.crashing.org
Message-Id: <20040324235828.YFBC19401.fed1mtao06.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:58:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Remove saved_command_line (and saving of the command line).
- Call parse_early_options
- Convert parse_cmdline into an __early_param for mem= (based on arm).


---

 linux-2.6-early_setup-trini/arch/arm26/kernel/setup.c |   75 ++++++------------
 1 files changed, 29 insertions(+), 46 deletions(-)

diff -puN arch/arm26/kernel/setup.c~arm26 arch/arm26/kernel/setup.c
--- linux-2.6-early_setup/arch/arm26/kernel/setup.c~arm26	2004-03-24 16:15:06.331761973 -0700
+++ linux-2.6-early_setup-trini/arch/arm26/kernel/setup.c	2004-03-24 16:15:06.334761297 -0700
@@ -76,7 +76,6 @@ struct processor processor;
 
 unsigned char aux_device_present;
 char elf_platform[ELF_PLATFORM_SIZE];
-char saved_command_line[COMMAND_LINE_SIZE];
 
 unsigned long phys_initrd_start __initdata = 0;
 unsigned long phys_initrd_size __initdata = 0;
@@ -154,53 +153,38 @@ static void __init setup_processor(void)
 }
 
 /*
- * Initial parsing of the command line.  We need to pick out the
- * memory size.  We look for mem=size@start, where start and size
- * are "size[KkMm]"
+ * Pick out the memory size.  We look for mem=size@start,
+ * where start and size are "size[KkMm]"
  */
-static void __init
-parse_cmdline(struct meminfo *mi, char **cmdline_p, char *from)
+static int __init early_mem(char *p)
 {
-	char c = ' ', *to = command_line;
-	int usermem = 0, len = 0;
+	static int usermem __initdata = 0;
+	unsigned long size, start;
 
-	for (;;) {
-		if (c == ' ' && !memcmp(from, "mem=", 4)) {
-			unsigned long size, start;
-
-			if (to != command_line)
-				to -= 1;
-
-			/*
-			 * If the user specifies memory size, we
-			 * blow away any automatically generated
-			 * size.
-			 */
-			if (usermem == 0) {
-				usermem = 1;
-				mi->nr_banks = 0;
-			}
-
-			start = PHYS_OFFSET;
-			size  = memparse(from + 4, &from);
-			if (*from == '@')
-				start = memparse(from + 1, &from);
-
-			mi->bank[mi->nr_banks].start = start;
-			mi->bank[mi->nr_banks].size  = size;
-			mi->bank[mi->nr_banks].node  = PHYS_TO_NID(start);
-			mi->nr_banks += 1;
-		}
-		c = *from++;
-		if (!c)
-			break;
-		if (COMMAND_LINE_SIZE <= ++len)
-			break;
-		*to++ = c;
+	/*
+	 * The user has specified the memory size for the first time,
+	 * so we blow away any automatically generated size.
+	 */
+	if (usermem == 0) {
+		usermem = 1;
+		mi->nr_banks = 0;
 	}
-	*to = '\0';
-	*cmdline_p = command_line;
+
+	unsigned long size, start;
+
+	start = PHYS_OFFSET;
+	size  = memparse(p, &p);
+	if (*p == '@')
+		start = memparse(p + 1, &p);
+
+	mi->bank[mi->nr_banks].start = start;
+	mi->bank[mi->nr_banks].size  = size;
+	mi->bank[mi->nr_banks].node  = PHYS_TO_NID(start);
+	mi->nr_banks += 1;
+
+	return 0;
 }
+__early_param("mem=", early_mem);
 
 static void __init
 setup_ramdisk(int doload, int prompt, int image_start, unsigned int rd_sz)
@@ -495,9 +479,8 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data   = (unsigned long) &_edata;
 	init_mm.brk	   = (unsigned long) &_end;
 
-	memcpy(saved_command_line, from, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
-	parse_cmdline(&meminfo, cmdline_p, from);
+	*cmdline_p = from;
+	parse_early_options(cmdline_p);
 	bootmem_init(&meminfo);
 	paging_init(&meminfo);
 	request_standard_resources(&meminfo);

_

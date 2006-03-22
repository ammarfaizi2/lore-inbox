Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWCVPPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWCVPPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWCVPPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:15:37 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:11393 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751277AbWCVPPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:15:35 -0500
Date: Wed, 22 Mar 2006 16:16:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 4/24] s390: early parameter parsing.
Message-ID: <20060322151602.GD5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[patch 4/24] s390: early parameter parsing.

Use common code parser for early parameters instead of our own.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c |  108 +++++++++++++++++++----------------------------
 1 files changed, 45 insertions(+), 63 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-03-22 14:36:12.000000000 +0100
@@ -78,8 +78,6 @@ extern int _text,_etext, _edata, _end;
 
 #include <asm/setup.h>
 
-static char command_line[COMMAND_LINE_SIZE] = { 0, };
-
 static struct resource code_resource = {
 	.name  = "Kernel code",
 	.start = (unsigned long) &_text,
@@ -335,63 +333,38 @@ add_memory_hole(unsigned long start, uns
 	}
 }
 
-static void __init
-parse_cmdline_early(char **cmdline_p)
+static int __init early_parse_mem(char *p)
+{
+	memory_end = memparse(p, &p);
+	return 0;
+}
+early_param("mem", early_parse_mem);
+
+/*
+ * "ipldelay=XXX[sm]" sets ipl delay in seconds or minutes
+ */
+static int __init early_parse_ipldelay(char *p)
 {
-	char c = ' ', cn, *to = command_line, *from = COMMAND_LINE;
 	unsigned long delay = 0;
 
-	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	delay = simple_strtoul(p, &p, 0);
 
-	for (;;) {
-		/*
-		 * "mem=XXX[kKmM]" sets memsize
-		 */
-		if (c == ' ' && strncmp(from, "mem=", 4) == 0) {
-			memory_end = simple_strtoul(from+4, &from, 0);
-			if ( *from == 'K' || *from == 'k' ) {
-				memory_end = memory_end << 10;
-				from++;
-			} else if ( *from == 'M' || *from == 'm' ) {
-				memory_end = memory_end << 20;
-				from++;
-			}
-		}
-		/*
-		 * "ipldelay=XXX[sm]" sets ipl delay in seconds or minutes
-		 */
-		if (c == ' ' && strncmp(from, "ipldelay=", 9) == 0) {
-			delay = simple_strtoul(from+9, &from, 0);
-			if (*from == 's' || *from == 'S') {
-				delay = delay*1000000;
-				from++;
-			} else if (*from == 'm' || *from == 'M') {
-				delay = delay*60*1000000;
-				from++;
-			}
-			/* now wait for the requested amount of time */
-			udelay(delay);
-		}
-		cn = *(from++);
-		if (!cn)
-			break;
-		if (cn == '\n')
-			cn = ' ';  /* replace newlines with space */
-		if (cn == 0x0d)
-			cn = ' ';  /* replace 0x0d with space */
-		if (cn == ' ' && c == ' ')
-			continue;  /* remove additional spaces */
-		c = cn;
-		if (to - command_line >= COMMAND_LINE_SIZE)
-			break;
-		*(to++) = c;
+	switch (*p) {
+	case 's':
+	case 'S':
+		delay *= 1000000;
+		break;
+	case 'm':
+	case 'M':
+		delay *= 60 * 1000000;
 	}
-	if (c == ' ' && to > command_line) to--;
-	*to = '\0';
-	*cmdline_p = command_line;
+
+	/* now wait for the requested amount of time */
+	udelay(delay);
+
+	return 0;
 }
+early_param("ipldelay", early_parse_ipldelay);
 
 static void __init
 setup_lowcore(void)
@@ -580,9 +553,26 @@ setup_arch(char **cmdline_p)
 	       "We are running native (64 bit mode)\n");
 #endif /* CONFIG_64BIT */
 
+	/* Save unparsed command line copy for /proc/cmdline */
+	strlcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+
+	*cmdline_p = COMMAND_LINE;
+	*(*cmdline_p + COMMAND_LINE_SIZE - 1) = '\0';
+
         ROOT_DEV = Root_RAM0;
+
+	init_mm.start_code = PAGE_OFFSET;
+	init_mm.end_code = (unsigned long) &_etext;
+	init_mm.end_data = (unsigned long) &_edata;
+	init_mm.brk = (unsigned long) &_end;
+
+	memory_end = memory_size;
+
+	parse_early_param();
+
 #ifndef CONFIG_64BIT
-	memory_end = memory_size & ~0x400000UL;  /* align memory end to 4MB */
+	memory_end &= ~0x400000UL;
+
         /*
          * We need some free virtual space to be able to do vmalloc.
          * On a machine with 2GB memory we make sure that we have at
@@ -591,17 +581,9 @@ setup_arch(char **cmdline_p)
         if (memory_end > 1920*1024*1024)
                 memory_end = 1920*1024*1024;
 #else /* CONFIG_64BIT */
-	memory_end = memory_size & ~0x200000UL;  /* detected in head.s */
+	memory_end &= ~0x200000UL;
 #endif /* CONFIG_64BIT */
 
-	init_mm.start_code = PAGE_OFFSET;
-	init_mm.end_code = (unsigned long) &_etext;
-	init_mm.end_data = (unsigned long) &_edata;
-	init_mm.brk = (unsigned long) &_end;
-
-	parse_cmdline_early(cmdline_p);
-	parse_early_param();
-
 	setup_memory();
 	setup_resources();
 	setup_lowcore();

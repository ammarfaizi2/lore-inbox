Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUCYAE7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUCYAEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:04:46 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:34215 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S262316AbUCXX7W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:59:22 -0500
Subject: [patch 10/22] __early_param for m68k
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, geert@linux-m68k.org
From: trini@kernel.crashing.org
Message-Id: <20040324235920.SSIR29083.fed1mtao08.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:59:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Geert Uytterhoeven <geert@linux-m68k.org>
- Remove saved_command_line (and saving of the command line).
- Call parse_early_options
- Convert debug=, switches= to __early_param.


---

 linux-2.6-early_setup-trini/arch/m68k/kernel/setup.c          |   68 ++++------
 linux-2.6-early_setup-trini/arch/m68k/kernel/vmlinux-std.lds  |    3 
 linux-2.6-early_setup-trini/arch/m68k/kernel/vmlinux-sun3.lds |    3 
 linux-2.6-early_setup-trini/arch/m68k/q40/config.c            |    1 
 4 files changed, 39 insertions(+), 36 deletions(-)

diff -puN arch/m68k/kernel/setup.c~m68k arch/m68k/kernel/setup.c
--- linux-2.6-early_setup/arch/m68k/kernel/setup.c~m68k	2004-03-24 16:15:07.460507762 -0700
+++ linux-2.6-early_setup-trini/arch/m68k/kernel/setup.c	2004-03-24 16:15:07.469505735 -0700
@@ -62,7 +62,6 @@ struct mem_info m68k_memory[NUM_MEMINFO]
 static struct mem_info m68k_ramdisk = { 0, 0 };
 
 static char m68k_command_line[CL_SIZE];
-char saved_command_line[CL_SIZE];
 
 char m68k_debug_device[6] = "";
 
@@ -196,6 +195,38 @@ static void __init m68k_parse_bootinfo(c
 #endif
 }
 
+/*
+ * "debug=xxx" will enable printing certain kernel messages to some
+ * machine-specific device.
+ */
+static int __init early_debug(char *p)
+{
+	strlcpy(m68k_debug_device, p, sizeof(m68k_debug_device));
+
+	/* Terminate the arg. */
+	if ((p = strchr(m68k_debug_device, ' ' )))
+		*p = 0;
+
+	return 0;
+}
+__early_param("debug=", early_debug);
+
+#ifdef CONFIG_ATARI
+/* This option must be parsed very early */
+static int __init early_switches(char *p)
+{
+	char *q;
+	extern void atari_switches_setup( const char *, int );
+
+	atari_switches_setup(p, (q = strchr(p, ' ' )) ?
+				           (q - p) : strlen(p));
+
+	return 0;
+}
+__early_param("switches=", early_switches);
+#endif
+
+
 void __init setup_arch(char **cmdline_p)
 {
 	extern int _etext, _edata, _end;
@@ -203,7 +234,6 @@ void __init setup_arch(char **cmdline_p)
 	unsigned long endmem, startmem;
 #endif
 	int i;
-	char *p, *q;
 
 	if (!MACH_IS_HP300) {
 		/* The bootinfo is located right after the kernel bss */
@@ -244,39 +274,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.brk = (unsigned long) &_end;
 
 	*cmdline_p = m68k_command_line;
-	memcpy(saved_command_line, *cmdline_p, CL_SIZE);
-
-	/* Parse the command line for arch-specific options.
-	 * For the m68k, this is currently only "debug=xxx" to enable printing
-	 * certain kernel messages to some machine-specific device.
-	 */
-	for( p = *cmdline_p; p && *p; ) {
-	    i = 0;
-	    if (!strncmp( p, "debug=", 6 )) {
-		strlcpy( m68k_debug_device, p+6, sizeof(m68k_debug_device) );
-		if ((q = strchr( m68k_debug_device, ' ' ))) *q = 0;
-		i = 1;
-	    }
-#ifdef CONFIG_ATARI
-	    /* This option must be parsed very early */
-	    if (!strncmp( p, "switches=", 9 )) {
-		extern void atari_switches_setup( const char *, int );
-		atari_switches_setup( p+9, (q = strchr( p+9, ' ' )) ?
-				           (q - (p+9)) : strlen(p+9) );
-		i = 1;
-	    }
-#endif
-
-	    if (i) {
-		/* option processed, delete it */
-		if ((q = strchr( p, ' ' )))
-		    strcpy( p, q+1 );
-		else
-		    *p = 0;
-	    } else {
-		if ((p = strchr( p, ' ' ))) ++p;
-	    }
-	}
+	parse_early_options(cmdline_p);
 
 	switch (m68k_machtype) {
 #ifdef CONFIG_AMIGA
diff -puN arch/m68k/kernel/vmlinux-std.lds~m68k arch/m68k/kernel/vmlinux-std.lds
--- linux-2.6-early_setup/arch/m68k/kernel/vmlinux-std.lds~m68k	2004-03-24 16:15:07.462507311 -0700
+++ linux-2.6-early_setup-trini/arch/m68k/kernel/vmlinux-std.lds	2004-03-24 16:15:07.469505735 -0700
@@ -50,6 +50,9 @@ SECTIONS
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;
+  __early_begin = .;
+  __early_param : { *(__early_param) }
+  __early_end = .;
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;
diff -puN arch/m68k/kernel/vmlinux-sun3.lds~m68k arch/m68k/kernel/vmlinux-sun3.lds
--- linux-2.6-early_setup/arch/m68k/kernel/vmlinux-sun3.lds~m68k	2004-03-24 16:15:07.464506861 -0700
+++ linux-2.6-early_setup-trini/arch/m68k/kernel/vmlinux-sun3.lds	2004-03-24 16:15:07.469505735 -0700
@@ -44,6 +44,9 @@ __init_begin = .;
 	__setup_start = .;
 	.init.setup : { *(.init.setup) }
 	__setup_end = .;
+	__early_begin = .;
+	__early_param : { *(__early_param) }
+	__early_end = .;
 	__start___param = .;
 	__param : { *(__param) }
 	__stop___param = .;
diff -puN arch/m68k/q40/config.c~m68k arch/m68k/q40/config.c
--- linux-2.6-early_setup/arch/m68k/q40/config.c~m68k	2004-03-24 16:15:07.466506411 -0700
+++ linux-2.6-early_setup-trini/arch/m68k/q40/config.c	2004-03-24 16:15:07.470505510 -0700
@@ -64,7 +64,6 @@ void q40_set_vectors (void);
 
 extern void q40_mksound(unsigned int /*freq*/, unsigned int /*ticks*/ );
 
-extern char *saved_command_line;
 extern char m68k_debug_device[];
 static void q40_mem_console_write(struct console *co, const char *b,
 				    unsigned int count);

_

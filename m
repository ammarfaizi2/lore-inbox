Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUCXX5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 18:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbUCXX5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:57:38 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:21246 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262370AbUCXX5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:57:22 -0500
Subject: [patch 1/22] Add __early_param for all arches
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
From: trini@kernel.crashing.org
Message-Id: <20040324235722.QDLK23486.fed1mtao04.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:57:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Russell King <rmk@arm.linux.org.uk>, Paul Mackerras <paulus@samba.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andi Kleen <ak@suse.de>, davidm@hpl.hp.com, ralf@linux-mips.org, matthew@wil.cx, grundler@parisc-linux.org
[ CC'ing of arch maintainers where I've made non-trivial changes ]
Hello.  The following is outcome of talking with David Woodhouse about
the need in various parts of the kernel to parse the command line very
early and set some options based on what we read.  The result is
__early_param("arg", fn) based very heavily on the macro of the same name
in the arm kernel.  The following is the core of these changes, adding the
macro, struct and externs to <linux/init.h>, the parser to init/main.c
and converting console= to this format.  As a follow on to this thread are
patches against all arches (vs 2.6.5-rc2) to use the global define of
saved_command_line, add the appropriate bits to
arch/$(ARCH)/kernel/vmlinux.lds.S and in some cases, convert params
from the old arch-specific variant to the new __early_param way.


---

 linux-2.6-early_setup-trini/include/linux/init.h |   14 ++++++
 linux-2.6-early_setup-trini/init/main.c          |   53 ++++++++++++++++++++++-
 linux-2.6-early_setup-trini/kernel/printk.c      |    2 
 3 files changed, 67 insertions(+), 2 deletions(-)

diff -puN include/linux/init.h~core include/linux/init.h
--- linux-2.6-early_setup/include/linux/init.h~core	2004-03-24 16:15:04.645141825 -0700
+++ linux-2.6-early_setup-trini/include/linux/init.h	2004-03-24 16:15:04.651140474 -0700
@@ -66,6 +66,20 @@ typedef void (*exitcall_t)(void);
 
 extern initcall_t __con_initcall_start, __con_initcall_end;
 extern initcall_t __security_initcall_start, __security_initcall_end;
+
+/*
+ * Early command line parameters.
+ */
+struct early_params {
+	const char *arg;
+	int (*fn)(char *p);
+};
+extern struct early_params __early_begin, __early_end;
+extern void parse_early_options(char **cmdline_p);
+
+#define __early_param(name,fn)					\
+static struct early_params __early_##fn __attribute_used__	\
+__attribute__((__section__("__early_param"))) = { name, fn }
 #endif
   
 #ifndef MODULE
diff -puN init/main.c~core init/main.c
--- linux-2.6-early_setup/init/main.c~core	2004-03-24 16:15:04.647141375 -0700
+++ linux-2.6-early_setup-trini/init/main.c	2004-03-24 16:15:04.652140249 -0700
@@ -43,6 +43,7 @@
 #include <linux/efi.h>
 #include <linux/unistd.h>
 
+#include <asm/setup.h>
 #include <asm/io.h>
 #include <asm/bugs.h>
 
@@ -111,6 +112,10 @@ extern void time_init(void);
 void (*late_time_init)(void);
 extern void softirq_init(void);
 
+/* Stuff for the command line. */
+char saved_command_line[COMMAND_LINE_SIZE];		/* For /proc */
+static char tmp_command_line[COMMAND_LINE_SIZE];	/* Parsed. */
+
 static char *execute_command;
 
 /* Setup configured maximum number of CPUs to activate */
@@ -396,13 +401,59 @@ static void noinline rest_init(void)
 } 
 
 /*
+ * Initial parsing of the command line.  We destructivly
+ * scan the pointer, and take out any params for which we have
+ * an early handler for.
+ */
+void __init parse_early_options(char **cmdline_p)
+{
+	char *from = *cmdline_p;	/* Original. */
+	char c = ' ', *to = tmp_command_line;	/* Parsed. */
+	int len = 0;
+
+	/* Save it, if we need to. */
+	if (*cmdline_p != saved_command_line)
+		memcpy(saved_command_line, *cmdline_p, COMMAND_LINE_SIZE);
+	saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
+
+	for (;;) {
+		if (c == ' ') {
+			struct early_params *p;
+
+			for (p = &__early_begin; p < &__early_end; p++) {
+				int len = strlen(p->arg);
+
+				if (memcmp(from, p->arg, len) == 0) {
+					if (to != *cmdline_p)
+						to -= 1;
+					from += len;
+					p->fn(from);
+
+					while (*from != ' ' && *from != '\0')
+						from++;
+					break;
+				}
+			}
+		}
+		c = *from++;
+		if (!c)
+			break;
+		if (COMMAND_LINE_SIZE <= ++len)
+			break;
+		*to++ = c;
+	}
+
+	*to = '\0';
+	*cmdline_p = tmp_command_line;
+}
+
+/*
  *	Activate the first processor.
  */
 
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
-	extern char saved_command_line[];
 	extern struct kernel_param __start___param[], __stop___param[];
 /*
  * Interrupts are still disabled. Do necessary setups, then
diff -puN kernel/printk.c~core kernel/printk.c
--- linux-2.6-early_setup/kernel/printk.c~core	2004-03-24 16:15:04.649140924 -0700
+++ linux-2.6-early_setup-trini/kernel/printk.c	2004-03-24 16:15:04.653140024 -0700
@@ -149,7 +149,7 @@ static int __init console_setup(char *st
 	return 1;
 }
 
-__setup("console=", console_setup);
+__early_param("console=", console_setup);
 
 /**
  * add_preferred_console - add a device to the list of preferred consoles.

_

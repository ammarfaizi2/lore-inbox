Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUCaEXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 23:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUCaEXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 23:23:17 -0500
Received: from ozlabs.org ([203.10.76.45]:18411 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261724AbUCaEXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 23:23:11 -0500
Subject: Re: [patch 1/22] Add __early_param for all arches
From: Rusty Russell <rusty@rustcorp.com.au>
To: trini@kernel.crashing.org
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040324235722.QDLK23486.fed1mtao04.cox.net@localhost.localdomain>
References: <20040324235722.QDLK23486.fed1mtao04.cox.net@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1080706985.29195.12.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 31 Mar 2004 14:23:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-25 at 10:57, trini@kernel.crashing.org wrote: 
> +void __init parse_early_options(char **cmdline_p)

Please, don't do it this way.

__setup() has icky semantics which are only used in three places (ide,
ppc64's eeh, and um's eth).  The string is a prefix and the rest of the
parameter is handed to the fn as an arg.  Meaning misspellings aren't
usually caught, and accidental name reuse is hard to catch.

Secondly, we already have a parser in the kernel.

I like the idea of cleaning up saved_command_line crap: ideally
the archs would just assign to a global "command_line" var, and
anyone wanting to write to it would make their own copies.

How's this version, instead?  If you agree, I'll produce a merged
version.

Thanks!
Rusty.

Name: Merge __early_param() with __setup code
Author: Rusty Russell
Status: Tested on 2.6.5-rc3

The __early_param implementation added yet another commandline parser
to the kernel.  Try just overloading the __setup() code insteadm and
fix up the semantics (require exact match, hand args in two pieces, fn
returns void).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.5-rc3/arch/i386/kernel/head.S working-2.6.5-rc3-early_param-with-setup/arch/i386/kernel/head.S
--- linux-2.6.5-rc3/arch/i386/kernel/head.S	2004-03-30 16:14:04.000000000 +1000
+++ working-2.6.5-rc3-early_param-with-setup/arch/i386/kernel/head.S	2004-03-31 13:38:31.000000000 +1000
@@ -19,6 +19,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm_offsets.h>
 #include <asm/setup.h>
+#include <asm/param.h>
 
 /*
  * References to members of the new_cpu_data structure.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.5-rc3/include/asm-i386/param.h working-2.6.5-rc3-early_param-with-setup/include/asm-i386/param.h
--- linux-2.6.5-rc3/include/asm-i386/param.h	2004-03-12 07:57:19.000000000 +1100
+++ working-2.6.5-rc3-early_param-with-setup/include/asm-i386/param.h	2004-03-31 13:38:31.000000000 +1000
@@ -18,5 +23,6 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
+#define COMMAND_LINE_SIZE 256
 
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.5-rc3/include/asm-i386/setup.h working-2.6.5-rc3-early_param-with-setup/include/asm-i386/setup.h
--- linux-2.6.5-rc3/include/asm-i386/setup.h	2004-03-30 16:14:30.000000000 +1000
+++ working-2.6.5-rc3-early_param-with-setup/include/asm-i386/setup.h	2004-03-31 13:38:31.000000000 +1000
@@ -17,7 +17,6 @@
 #define MAX_NONPAE_PFN	(1 << 20)
 
 #define PARAM_SIZE 2048
-#define COMMAND_LINE_SIZE 256
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.5-rc3/include/linux/init.h working-2.6.5-rc3-early_param-with-setup/include/linux/init.h
--- linux-2.6.5-rc3/include/linux/init.h	2004-03-30 16:14:35.000000000 +1000
+++ working-2.6.5-rc3-early_param-with-setup/include/linux/init.h	2004-03-31 14:14:21.000000000 +1000
@@ -106,26 +106,38 @@ extern initcall_t __security_initcall_st
 
 struct obs_kernel_param {
 	const char *str;
-	int (*setup_func)(char *);
+	union {
+		int (*setup_func)(char *);
+		void (*param_func)(char *);
+	} u;
+	int early;
 };
 
-/* OBSOLETE: see moduleparam.h for the right way. */
-#define __setup_param(str, unique_id, fn)			\
+/* These only when builtin: see moduleparam.h for the normal way. */
+/* Called if str matches prefix: fn returns 1 if we're the right one. */
+#define __setup(prefix, fn)					\
+	__setup_param(prefix, fn, {.setup_func = fn}, 0)
+
+/* Called v. early on when option matches str: fn gets string after =,
+ * or NULL. */
+#define __early_param(str, fn)					\
+	__setup_param(str, fn, {.param_func = fn}, 1)
+
+#define __setup_param(str, unique_id, fn_init, early)		\
 	static char __setup_str_##unique_id[] __initdata = str;	\
 	static struct obs_kernel_param __setup_##unique_id	\
 		 __attribute_used__				\
 		 __attribute__((__section__(".init.setup")))	\
-		= { __setup_str_##unique_id, fn }
-
-#define __setup_null_param(str, unique_id)			\
-	__setup_param(str, unique_id, NULL)
+		= { __setup_str_##unique_id, fn_init, early }
 
-#define __setup(str, fn)					\
-	__setup_param(str, fn, fn)
+#define __obsolete_setup2(str, unique_id)			\
+	__setup_param(str, unique_id, {.setup_func = NULL}, 0)
 
+/* Does nothing, but will warn user if it's used. */
 #define __obsolete_setup(str)					\
-	__setup_null_param(str, __LINE__)
+	__obsolete_setup2(str, __LINE__)
 
+void __init parse_early_options(const char *saved_command_line);
 #endif /* __ASSEMBLY__ */
 
 /**
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.5-rc3/init/main.c working-2.6.5-rc3-early_param-with-setup/init/main.c
--- linux-2.6.5-rc3/init/main.c	2004-03-30 16:14:35.000000000 +1000
+++ working-2.6.5-rc3-early_param-with-setup/init/main.c	2004-03-31 14:14:26.000000000 +1000
@@ -157,10 +157,13 @@ static int __init obsolete_checksetup(ch
 	do {
 		int n = strlen(p->str);
 		if (!strncmp(line, p->str, n)) {
-			if (!p->setup_func) {
+			/* Already done in handle_early_option? */
+			if (p->early)
+				return 1;
+			if (!p->u.setup_func) {
 				printk(KERN_WARNING "Parameter %s is obsolete, ignored\n", p->str);
 				return 1;
-			} else if (p->setup_func(line + n))
+			} else if (p->u.setup_func(line + n))
 				return 1;
 		}
 		p++;
@@ -393,7 +397,31 @@ static void noinline rest_init(void)
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	unlock_kernel();
  	cpu_idle();
-} 
+}
+
+/* Check for early options. */
+static int __init early_option(char *param, char *val)
+{
+	struct obs_kernel_param *p;
+	extern struct obs_kernel_param __setup_start, __setup_end;
+
+	for (p = &__setup_start; p < &__setup_end; p++)
+		if (p->early && strcmp(param, p->str) == 0)
+			p->u.param_func(val);
+
+	/* We accept everything at this stage. */
+	return 0;
+}
+
+/* Arch code calls this early on. */
+void __init parse_early_options(const char *saved_command_line)
+{
+	static char __initdata command_line[COMMAND_LINE_SIZE];
+	strcpy(command_line, saved_command_line);
+
+	/* All fall through to handle_early_option. */
+	parse_args("early options", command_line, NULL, 0, early_option);
+}
 
 /*
  *	Activate the first processor.


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell


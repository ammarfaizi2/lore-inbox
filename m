Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSIYDfb>; Tue, 24 Sep 2002 23:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261892AbSIYDYI>; Tue, 24 Sep 2002 23:24:08 -0400
Received: from dp.samba.org ([66.70.73.150]:44672 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261894AbSIYDQr>;
	Tue, 24 Sep 2002 23:16:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module rewrite 7/20: Boot and module PARAM unification
Date: Wed, 25 Sep 2002 13:01:15 +1000
Message-Id: <20020925032201.A85AB2C133@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Parameter Core Patch
Author: Rusty Russell
Status: Tested on 2.5.38
Depends: Misc/strcspn.patch.gz
Depends: Misc/bigrefs.patch.gz
Depends: Misc/streq.patch.gz

D: This patch is a rewrite of the insmod and boot parameter handling,
D: to unify them.  It only contains the core of the infrastructure,
D: and the conversion main boot parameters: all other boot parameters
D: will no longer work with this change (although stubs are in place
D: to let them compile).
D: 
D: The new format is fairly simple: built on top of __PARAM_CALL there
D: are several helpers, eg "PARAM(foo, int, 000)".  The final argument
D: is the permissions bits, for exposing parameters in driverfs (if
D: non-zero) at a later stage.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19230-linux-2.5.38/include/asm-i386/setup.h .19230-linux-2.5.38.updated/include/asm-i386/setup.h
--- .19230-linux-2.5.38/include/asm-i386/setup.h	2002-09-18 16:03:30.000000000 +1000
+++ .19230-linux-2.5.38.updated/include/asm-i386/setup.h	2002-09-25 06:36:30.000000000 +1000
@@ -19,25 +19,25 @@
 /*
  * This is set up by the setup-routine at boot-time
  */
-#define PARAM	((unsigned char *)empty_zero_page)
-#define SCREEN_INFO (*(struct screen_info *) (PARAM+0))
-#define EXT_MEM_K (*(unsigned short *) (PARAM+2))
-#define ALT_MEM_K (*(unsigned long *) (PARAM+0x1e0))
-#define E820_MAP_NR (*(char*) (PARAM+E820NR))
-#define E820_MAP    ((struct e820entry *) (PARAM+E820MAP))
-#define APM_BIOS_INFO (*(struct apm_bios_info *) (PARAM+0x40))
-#define DRIVE_INFO (*(struct drive_info_struct *) (PARAM+0x80))
-#define SYS_DESC_TABLE (*(struct sys_desc_table_struct*)(PARAM+0xa0))
-#define MOUNT_ROOT_RDONLY (*(unsigned short *) (PARAM+0x1F2))
-#define RAMDISK_FLAGS (*(unsigned short *) (PARAM+0x1F8))
-#define VIDEO_MODE (*(unsigned short *) (PARAM+0x1FA))
-#define ORIG_ROOT_DEV (*(unsigned short *) (PARAM+0x1FC))
-#define AUX_DEVICE_INFO (*(unsigned char *) (PARAM+0x1FF))
-#define LOADER_TYPE (*(unsigned char *) (PARAM+0x210))
-#define KERNEL_START (*(unsigned long *) (PARAM+0x214))
-#define INITRD_START (*(unsigned long *) (PARAM+0x218))
-#define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
-#define COMMAND_LINE ((char *) (PARAM+2048))
+#define PARAMS	((unsigned char *)empty_zero_page)
+#define SCREEN_INFO (*(struct screen_info *) (PARAMS+0))
+#define EXT_MEM_K (*(unsigned short *) (PARAMS+2))
+#define ALT_MEM_K (*(unsigned long *) (PARAMS+0x1e0))
+#define E820_MAP_NR (*(char*) (PARAMS+E820NR))
+#define E820_MAP    ((struct e820entry *) (PARAMS+E820MAP))
+#define APM_BIOS_INFO (*(struct apm_bios_info *) (PARAMS+0x40))
+#define DRIVE_INFO (*(struct drive_info_struct *) (PARAMS+0x80))
+#define SYS_DESC_TABLE (*(struct sys_desc_table_struct*)(PARAMS+0xa0))
+#define MOUNT_ROOT_RDONLY (*(unsigned short *) (PARAMS+0x1F2))
+#define RAMDISK_FLAGS (*(unsigned short *) (PARAMS+0x1F8))
+#define VIDEO_MODE (*(unsigned short *) (PARAMS+0x1FA))
+#define ORIG_ROOT_DEV (*(unsigned short *) (PARAMS+0x1FC))
+#define AUX_DEVICE_INFO (*(unsigned char *) (PARAMS+0x1FF))
+#define LOADER_TYPE (*(unsigned char *) (PARAMS+0x210))
+#define KERNEL_START (*(unsigned long *) (PARAMS+0x214))
+#define INITRD_START (*(unsigned long *) (PARAMS+0x218))
+#define INITRD_SIZE (*(unsigned long *) (PARAMS+0x21c))
+#define COMMAND_LINE ((char *) (PARAMS+2048))
 #define COMMAND_LINE_SIZE 256
 
 #endif /* _i386_SETUP_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19230-linux-2.5.38/include/linux/init.h .19230-linux-2.5.38.updated/include/linux/init.h
--- .19230-linux-2.5.38/include/linux/init.h	2002-08-11 15:31:43.000000000 +1000
+++ .19230-linux-2.5.38.updated/include/linux/init.h	2002-09-25 06:36:30.000000000 +1000
@@ -172,6 +172,16 @@ typedef void (*__cleanup_module_func_t)(
 /* Data marked not to be saved by software_suspend() */
 #define __nosavedata __attribute__ ((__section__ (".data.nosave")))
 
+/* This means "can be init if no module support, otherwise module load
+   may call it." */
+#ifdef CONFIG_MODULES
+#define __init_or_module
+#define __initdata_or_module
+#else
+#define __init_or_module __init
+#define __initdata_or_module __initdata
+#endif /*CONFIG_MODULES*/
+
 #ifdef CONFIG_HOTPLUG
 #define __devinit
 #define __devinitdata
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19230-linux-2.5.38/include/linux/kernel.h .19230-linux-2.5.38.updated/include/linux/kernel.h
--- .19230-linux-2.5.38/include/linux/kernel.h	2002-09-18 16:04:41.000000000 +1000
+++ .19230-linux-2.5.38.updated/include/linux/kernel.h	2002-09-25 06:36:30.000000000 +1000
@@ -63,8 +63,8 @@ extern int sscanf(const char *, const ch
 	__attribute__ ((format (scanf,2,3)));
 extern int vsscanf(const char *, const char *, va_list);
 
-extern int get_option(char **str, int *pint);
-extern char *get_options(char *str, int nints, int *ints);
+extern int get_option(const char **str, int *pint);
+extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(char *ptr, char **retptr);
 extern void dev_probe_lock(void);
 extern void dev_probe_unlock(void);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19230-linux-2.5.38/include/linux/params.h .19230-linux-2.5.38.updated/include/linux/params.h
--- .19230-linux-2.5.38/include/linux/params.h	1970-01-01 10:00:00.000000000 +1000
+++ .19230-linux-2.5.38.updated/include/linux/params.h	2002-09-25 06:36:30.000000000 +1000
@@ -0,0 +1,123 @@
+#ifndef _LINUX_PARAMS_H
+#define _LINUX_PARAMS_H
+/* (C) Copyright 2001, 2002 Rusty Russell IBM Corporation */
+#include <linux/init.h>
+#include <linux/stringify.h>
+
+/* You can override this manually, but generally this should match the
+   module name. */
+#define PARAM_PREFIX __stringify(KBUILD_MODNAME) "."
+
+struct kernel_param;
+
+/* Returns 0, or -errno.  arg is in kp->arg. */
+typedef int (*param_set_fn)(const char *val, struct kernel_param *kp);
+/* Returns length written or -errno.  Buffer is 4k (ie. be short!) */
+typedef int (*param_get_fn)(char *buffer, struct kernel_param *kp);
+
+struct kernel_param {
+	const char *name;
+	unsigned int perm;
+	param_set_fn set;
+	param_get_fn get;
+	void *arg;
+};
+
+/* Special one for strings we want to copy into */
+struct kparam_string {
+	unsigned int maxlen;
+	char *string;
+};
+
+/* This is the fundamental function for registering boot/module
+   parameters.  perm sets the visibility in driverfs: 000 means it's
+   not there, read bits mean it's readable, write bits mean it's
+   writable. */
+#define __PARAM_CALL(prefix, name, set, get, arg, perm)			\
+	static char __param_str_##name[] __initdata = prefix #name;	\
+	static struct kernel_param __param_##name			\
+		 __attribute__ ((unused,__section__ (".setup.init")))	\
+	= { __param_str_##name, perm, set, get, arg }
+
+#define PARAM_CALL(name, set, get, arg, perm)				      \
+	__PARAM_CALL(PARAM_PREFIX, name, set, get, arg, perm)
+
+/* Helper functions: type is byte, short, ushort, int, uint, long,
+   ulong, charp, bool or invbool, or XXX if you define param_get_XXX,
+   param_set_XXX and param_check_XXX. */
+#define PARAM_NAMED(name, value, type, perm)				   \
+	param_check_##type(name, &(value));				   \
+	PARAM_CALL(name, param_set_##type, param_get_##type, &value, perm)
+
+#define PARAM(name, type, perm)				\
+	PARAM_NAMED(name, name, type, perm)
+
+/* Actually copy string: maxlen param is usually sizeof(string). */
+#define PARAM_STRING(name, string, len, perm)				\
+	static struct kparam_string __param_string_##name __initdata	\
+		= { len, string };					\
+	PARAM_CALL(name, param_set_copystring, param_get_charp,		\
+		   &__param_string_##name, perm)
+
+/* Called on module insert or kernel boot */
+extern int parse_args(const char *name,
+		      char *args,
+		      struct kernel_param *params,
+		      unsigned num,
+		      int (*unknown)(char *param, char *val));
+
+/* All the helper functions */
+/* The macros to do compile-time type checking stolen from Jakub
+   Jelinek, who IIRC came up with this idea for the 2.4 module init code. */
+#define __param_check(name, p, type) \
+	static inline type *__check_##name(void) { return(p); }
+
+extern int param_set_short(const char *val, struct kernel_param *kp);
+extern int param_get_short(char *buffer, struct kernel_param *kp);
+#define param_check_short(name, p) __param_check(name, p, short)
+
+extern int param_set_ushort(const char *val, struct kernel_param *kp);
+extern int param_get_ushort(char *buffer, struct kernel_param *kp);
+#define param_check_ushort(name, p) __param_check(name, p, unsigned short)
+
+extern int param_set_int(const char *val, struct kernel_param *kp);
+extern int param_get_int(char *buffer, struct kernel_param *kp);
+#define param_check_int(name, p) __param_check(name, p, int)
+
+extern int param_set_uint(const char *val, struct kernel_param *kp);
+extern int param_get_uint(char *buffer, struct kernel_param *kp);
+#define param_check_uint(name, p) __param_check(name, p, unsigned int)
+
+extern int param_set_long(const char *val, struct kernel_param *kp);
+extern int param_get_long(char *buffer, struct kernel_param *kp);
+#define param_check_long(name, p) __param_check(name, p, long)
+
+extern int param_set_ulong(const char *val, struct kernel_param *kp);
+extern int param_get_ulong(char *buffer, struct kernel_param *kp);
+#define param_check_ulong(name, p) __param_check(name, p, unsigned long)
+
+extern int param_set_charp(const char *val, struct kernel_param *kp);
+extern int param_get_charp(char *buffer, struct kernel_param *kp);
+#define param_check_charp(name, p) __param_check(name, p, char *)
+
+extern int param_set_bool(const char *val, struct kernel_param *kp);
+extern int param_get_bool(char *buffer, struct kernel_param *kp);
+#define param_check_bool(name, p) __param_check(name, p, int)
+
+extern int param_set_invbool(const char *val, struct kernel_param *kp);
+extern int param_get_invbool(char *buffer, struct kernel_param *kp);
+#define param_check_invbool(name, p) __param_check(name, p, int)
+
+/* First two elements are the max and min array length (which don't change) */
+extern int param_set_intarray(const char *val, struct kernel_param *kp);
+extern int param_get_intarray(char *buffer, struct kernel_param *kp);
+#define param_check_intarray(name, p) __param_check(name, p, int *)
+
+extern int param_set_copystring(const char *val, struct kernel_param *kp);
+
+int param_array(const char *name,
+		const char *val,
+		unsigned int min, unsigned int max,
+		void *elem, int elemsize,
+		int (*set)(const char *, struct kernel_param *kp));
+#endif /* _LINUX_PARAM_TYPES_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19230-linux-2.5.38/init/main.c .19230-linux-2.5.38.updated/init/main.c
--- .19230-linux-2.5.38/init/main.c	2002-09-21 13:55:19.000000000 +1000
+++ .19230-linux-2.5.38.updated/init/main.c	2002-09-25 06:36:30.000000000 +1000
@@ -30,6 +30,7 @@
 #include <linux/percpu.h>
 #include <linux/kernel_stat.h>
 #include <linux/security.h>
+#include <linux/params.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -224,74 +225,39 @@ static int __init quiet_kernel(char *str
 __setup("debug", debug_kernel);
 __setup("quiet", quiet_kernel);
 
-/*
- * This is a simple kernel command line parsing function: it parses
- * the command line, and fills in the arguments/environment to init
- * as appropriate. Any cmd-line option is taken to be an environment
- * variable if it contains the character '='.
- *
- * This routine also checks for options meant for the kernel.
- * These options are not given to init - they are for internal kernel use only.
- */
-static void __init parse_options(char *line)
+/* Unknown boot options get handed to init, unless they look like
+   failed parameters */
+static int unknown_bootoption(char *param, char *val)
 {
-	char *next,*quote;
-	int args, envs;
+	/* Preemptive maintenance for "why didn't my mispelled command
+           line work?" */
+	if (strchr(param, '.')) {
+		printk(KERN_ERR "Unknown boot option `%s': ignoring\n", param);
+		return 0;
+	}
 
-	if (!*line)
-		return;
-	args = 0;
-	envs = 1;	/* TERM is set to 'linux' by default */
-	next = line;
-	while ((line = next) != NULL) {
-                quote = strchr(line,'"');
-                next = strchr(line, ' ');
-                while (next != NULL && quote != NULL && quote < next) {
-                        /* we found a left quote before the next blank
-                         * now we have to find the matching right quote
-                         */
-                        next = strchr(quote+1, '"');
-                        if (next != NULL) {
-                                quote = strchr(next+1, '"');
-                                next = strchr(next+1, ' ');
-                        }
-                }
-                if (next != NULL)
-                        *next++ = 0;
-		if (!strncmp(line,"init=",5)) {
-			line += 5;
-			execute_command = line;
-			/* In case LILO is going to boot us with default command line,
-			 * it prepends "auto" before the whole cmdline which makes
-			 * the shell think it should execute a script with such name.
-			 * So we ignore all arguments entered _before_ init=... [MJ]
-			 */
-			args = 0;
-			continue;
+	if (val) {
+		/* Environment option */
+		unsigned int i;
+		for (i = 0; envp_init[i]; i++) {
+			if (i == MAX_INIT_ENVS)
+				panic("Too many boot env vars at `%s'", param);
 		}
-		if (checksetup(line))
-			continue;
-		
-		/*
-		 * Then check if it's an environment variable or
-		 * an option.
-		 */
-		if (strchr(line,'=')) {
-			if (envs >= MAX_INIT_ENVS)
-				break;
-			envp_init[++envs] = line;
-		} else {
-			if (args >= MAX_INIT_ARGS)
-				break;
-			if (*line)
-				argv_init[++args] = line;
+		/* Change NUL term back to "=" */
+		val[-1] = '=';
+		envp_init[i] = param;
+	} else {
+		/* Command line option */
+		unsigned int i;
+		for (i = 0; argv_init[i]; i++) {
+			if (i == MAX_INIT_ARGS)
+				panic("Too many boot init vars at `%s'",param);
 		}
+		argv_init[i] = param;
 	}
-	argv_init[args+1] = NULL;
-	envp_init[envs+1] = NULL;
+	return 0;
 }
 
-
 extern void setup_arch(char **);
 extern void cpu_idle(void);
 
@@ -395,7 +361,9 @@ asmlinkage void __init start_kernel(void
 	setup_per_cpu_areas();
 	build_all_zonelists();
 	printk("Kernel command line: %s\n", saved_command_line);
-	parse_options(command_line);
+	parse_args("Booting kernel", command_line, &__setup_start,
+		   &__setup_end - &__setup_start - 1,
+		   &unknown_bootoption);
 	trap_init();
 	init_IRQ();
 	sched_init();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19230-linux-2.5.38/kernel/Makefile .19230-linux-2.5.38.updated/kernel/Makefile
--- .19230-linux-2.5.38/kernel/Makefile	2002-09-25 06:36:08.000000000 +1000
+++ .19230-linux-2.5.38.updated/kernel/Makefile	2002-09-25 06:36:42.000000000 +1000
@@ -2,13 +2,14 @@
 # Makefile for the linux kernel.
 #
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o params.o \
 		printk.o platform.o suspend.o dma.o bigref.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o pid.o bigref.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o pid.o bigref.o \
+	    params.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19230-linux-2.5.38/kernel/params.c .19230-linux-2.5.38.updated/kernel/params.c
--- .19230-linux-2.5.38/kernel/params.c	1970-01-01 10:00:00.000000000 +1000
+++ .19230-linux-2.5.38.updated/kernel/params.c	2002-09-25 06:36:30.000000000 +1000
@@ -0,0 +1,338 @@
+/* Helpers for initial module or kernel cmdline parsing
+   Copyright (C) 2001 Rusty Russell.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+#include <linux/params.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+
+#if 0
+#define DEBUGP printk
+#else
+#define DEBUGP(fmt , ...)
+#endif
+
+static int parse_one(char *param,
+		     char *val,
+		     struct kernel_param *params, 
+		     unsigned num_params,
+		     int (*handle_unknown)(char *param, char *val))
+{
+	unsigned int i;
+
+	/* Find parameter */
+	for (i = 0; i < num_params; i++) {
+		if (strcmp(param, params[i].name) == 0) {
+			DEBUGP("They are equal!  Calling %p\n",
+			       params[i].set);
+			return params[i].set(val, &params[i]);
+		}
+	}
+
+	if (handle_unknown) {
+		DEBUGP("Unknown argument: calling %p\n", handle_unknown);
+		return handle_unknown(param, val);
+	}
+
+	DEBUGP("Unknown argument `%s'\n", param);
+	return -ENOENT;
+}
+
+/* You can use " around spaces, but can't escape ". */
+/* Hyphens and underscores equivalent in parameter names. */
+static char *next_arg(char *args, char **param, char **val)
+{
+	unsigned int i, equals = 0;
+	int in_quote = 0;
+
+	/* Chew any extra spaces */
+	while (*args == ' ') args++;
+
+	for (i = 0; args[i]; i++) {
+		if (args[i] == ' ' && !in_quote)
+			break;
+		if (equals == 0) {
+			if (args[i] == '=')
+				equals = i;
+			else if (args[i] == '-')
+				args[i] = '_';
+		}
+		if (args[i] == '"')
+			in_quote = !in_quote;
+	}
+
+	*param = args;
+	if (!equals)
+		*val = NULL;
+	else {
+		args[equals] = '\0';
+		*val = args + equals + 1;
+	}
+
+	if (args[i]) {
+		args[i] = '\0';
+		return args + i + 1;
+	} else
+		return args + i;
+}
+
+/* Args looks like "foo=bar,bar2 baz=fuz wiz". */
+int parse_args(const char *name,
+	       char *args,
+	       struct kernel_param *params,
+	       unsigned num,
+	       int (*unknown)(char *param, char *val))
+{
+	char *param, *val;
+
+	DEBUGP("Parsing ARGS: %s\n", args);
+
+	while (*args) {
+		int ret;
+
+		args = next_arg(args, &param, &val);
+		ret = parse_one(param, val, params, num, unknown);
+		switch (ret) {
+		case -ENOENT:
+			printk(KERN_ERR "%s: Unknown parameter `%s'\n",
+			       name, param);
+			return ret;
+		case -ENOSPC:
+			printk(KERN_ERR
+			       "%s: `%s' too large for parameter `%s'\n",
+			       name, val ?: "", param);
+			return ret;
+		case 0:
+			break;
+		default:
+			printk(KERN_ERR
+			       "%s: `%s' invalid for parameter `%s'\n",
+			       name, val ?: "", param);
+			return ret;
+		}
+	}
+
+	/* All parsed OK. */
+	return 0;
+}
+
+/* Lazy bastard, eh? */
+#define STANDARD_PARAM_DEF(name, type, format, tmptype, strtolfn)      	\
+	int param_set_##name(const char *val, struct kernel_param *kp)	\
+	{								\
+		char *endp;						\
+		tmptype l;						\
+									\
+		if (!val) return -EINVAL;				\
+		l = strtolfn(val, &endp, 0);				\
+		if (endp == val || *endp || ((type)l != l))		\
+			return -EINVAL;					\
+		*((type *)kp->arg) = l;					\
+		return 0;						\
+	}								\
+	int param_get_##name(char *buffer, struct kernel_param *kp)	\
+	{								\
+		return sprintf(buffer, format, *((type *)kp->arg));	\
+	}
+
+STANDARD_PARAM_DEF(short, short, "%hi", long, simple_strtol);
+STANDARD_PARAM_DEF(ushort, unsigned short, "%hu", long, simple_strtol);
+STANDARD_PARAM_DEF(int, int, "%i", long, simple_strtol);
+STANDARD_PARAM_DEF(uint, unsigned int, "%u", long, simple_strtol);
+STANDARD_PARAM_DEF(long, long, "%li", long, simple_strtol);
+STANDARD_PARAM_DEF(ulong, unsigned long, "%lu", unsigned long, simple_strtoul);
+
+int param_set_charp(const char *val, struct kernel_param *kp)
+{
+	if (!val) {
+		printk(KERN_ERR "%s: string parameter expected\n",
+		       kp->name);
+		return -EINVAL;
+	}
+
+	if (strlen(val) > 1024) {
+		printk(KERN_ERR "%s: string parameter too long\n",
+		       kp->name);
+		return -ENOSPC;
+	}
+
+	*(char **)kp->arg = (char *)val;
+	return 0;
+}
+
+int param_get_charp(char *buffer, struct kernel_param *kp)
+{
+	return sprintf(buffer, "%s", *((char **)kp->arg));
+}
+
+int param_set_bool(const char *val, struct kernel_param *kp)
+{
+	/* No equals means "set"... */
+	if (!val) val = "1";
+
+	/* One of =[yYnN01] */
+	switch (val[0]) {
+	case 'y': case 'Y': case '1':
+		*(int *)kp->arg = 1;
+		return 0;
+	case 'n': case 'N': case '0':
+		*(int *)kp->arg = 0;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+int param_get_bool(char *buffer, struct kernel_param *kp)
+{
+	/* Y and N chosen as being relatively non-coder friendly */
+	return sprintf(buffer, "%c", (*(int *)kp->arg) ? 'Y' : 'N');
+}
+
+int param_set_invbool(const char *val, struct kernel_param *kp)
+{
+	int boolval, ret;
+	struct kernel_param dummy = { .arg = &boolval };
+
+	ret = param_set_bool(val, &dummy);
+	if (ret == 0)
+		*(int *)kp->arg = !boolval;
+	return ret;
+}
+
+int param_get_invbool(char *buffer, struct kernel_param *kp)
+{
+	int val;
+	struct kernel_param dummy = { .arg = &val };
+
+	val = !*(int *)kp->arg;
+	return param_get_bool(buffer, &dummy);
+}
+
+/* We cheat here and temporarily mangle the string. */
+int param_array(const char *name,
+		const char *val,
+		unsigned int min, unsigned int max,
+		void *elem, int elemsize,
+		int (*set)(const char *, struct kernel_param *kp))
+{
+	int ret;
+	unsigned int count = 0;
+	struct kernel_param kp;
+
+	/* Get the name right for errors. */
+	kp.name = name;
+	kp.arg = elem;
+
+	/* No equals sign? */
+	if (!val) {
+		printk(KERN_ERR "%s: expects arguments\n", name);
+		return -EINVAL;
+	}
+
+	/* We expect a comma-separated list of values. */
+	do {
+		int len;
+		char save;
+
+		if (count > max) {
+			printk(KERN_ERR "%s: can only take %i arguments\n",
+			       name, max);
+			return -EINVAL;
+		}
+		len = strcspn(val, ",");
+
+		/* Temporarily nul-terminate and parse */
+		save = val[len];
+		((char *)val)[len] = '\0';
+		ret = set(val, &kp);
+		((char *)val)[len] = save;
+
+		if (ret != 0)
+			return ret;
+		kp.arg += elemsize;
+		val += len+1;
+		count++;
+	} while (val[-1] == ',');
+
+	if (count < min) {
+		printk(KERN_ERR "%s: needs at least %i arguments\n",
+		       name, min);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/* First two elements are the max and min array length (which don't change) */
+int param_set_intarray(const char *val, struct kernel_param *kp)
+{
+	int *array;
+
+	/* Grab min and max as first two elements */
+	array = kp->arg;
+	return param_array(kp->name, val, array[0], array[1], &array[2],
+			   sizeof(int), param_set_int);
+}
+
+int param_get_intarray(char *buffer, struct kernel_param *kp)
+{
+	int max;
+	int *array;
+	unsigned int i;
+
+	array = kp->arg;
+	max = array[1];
+
+	for (i = 2; i < max + 2; i++)
+		sprintf(buffer, "%s%i", i > 2 ? "," : "", array[i]);
+	return strlen(buffer);
+}
+
+int param_set_copystring(const char *val, struct kernel_param *kp)
+{
+	struct kparam_string *kps = kp->arg;
+
+	if (strlen(val)+1 > kps->maxlen) {
+		printk(KERN_ERR "%s: string doesn't fit in %u chars.\n",
+		       kp->name, kps->maxlen-1);
+		return -ENOSPC;
+	}
+	strcpy(kps->string, val);
+	return 0;
+}
+
+EXPORT_SYMBOL(param_set_short);
+EXPORT_SYMBOL(param_get_short);
+EXPORT_SYMBOL(param_set_ushort);
+EXPORT_SYMBOL(param_get_ushort);
+EXPORT_SYMBOL(param_set_int);
+EXPORT_SYMBOL(param_get_int);
+EXPORT_SYMBOL(param_set_uint);
+EXPORT_SYMBOL(param_get_uint);
+EXPORT_SYMBOL(param_set_long);
+EXPORT_SYMBOL(param_get_long);
+EXPORT_SYMBOL(param_set_ulong);
+EXPORT_SYMBOL(param_get_ulong);
+EXPORT_SYMBOL(param_set_charp);
+EXPORT_SYMBOL(param_get_charp);
+EXPORT_SYMBOL(param_set_bool);
+EXPORT_SYMBOL(param_get_bool);
+EXPORT_SYMBOL(param_set_invbool);
+EXPORT_SYMBOL(param_get_invbool);
+EXPORT_SYMBOL(param_set_intarray);
+EXPORT_SYMBOL(param_get_intarray);
+EXPORT_SYMBOL(param_set_copystring);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .19230-linux-2.5.38/lib/cmdline.c .19230-linux-2.5.38.updated/lib/cmdline.c
--- .19230-linux-2.5.38/lib/cmdline.c	2001-04-13 05:25:53.000000000 +1000
+++ .19230-linux-2.5.38.updated/lib/cmdline.c	2002-09-25 06:36:30.000000000 +1000
@@ -31,13 +31,13 @@
  *	2 : int found including a subsequent comma
  */
 
-int get_option (char **str, int *pint)
+int get_option (const char **str, int *pint)
 {
-	char *cur = *str;
+	const char *cur = *str;
 
 	if (!cur || !(*cur))
 		return 0;
-	*pint = simple_strtol (cur, str, 0);
+	*pint = simple_strtol (cur, (char **)str, 0);
 	if (cur == *str)
 		return 0;
 	if (**str == ',') {
@@ -64,7 +64,7 @@ int get_option (char **str, int *pint)
  *	completely parseable).
  */
  
-char *get_options (char *str, int nints, int *ints)
+char *get_options (const char *str, int nints, int *ints)
 {
 	int res, i = 1;
 
@@ -77,7 +77,7 @@ char *get_options (char *str, int nints,
 			break;
 	}
 	ints[0] = i - 1;
-	return (str);
+	return (char *)str;
 }
 
 /**
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

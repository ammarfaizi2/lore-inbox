Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267149AbTAUS0K>; Tue, 21 Jan 2003 13:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbTAUS0K>; Tue, 21 Jan 2003 13:26:10 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:8200 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267149AbTAUSZL>; Tue, 21 Jan 2003 13:25:11 -0500
Date: Tue, 21 Jan 2003 19:28:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] restore modules compatibility
Message-ID: <Pine.LNX.4.44.0301211749390.5658-100000@spit.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below does two things:
1. The new param stuff suffers from serious bloat, I replaced it with a
much simpler implementation. The interesting feature here is that even
without changing any module all parameters are reachable from the command
line via "<modname>.<param>=..."
2. I added the old module system calls back and modules are now installed
with the ".o" suffix again, so the old modutils are working again. Special
feature here is that the same module should be loadable with either module
tools.

The patch is against 2.5.59-um, if you don't have Jeffs patch just ignore
the single reject.

BTW I'm still looking for a reason, why we need a kernel linker. If
someone has any relevant information, I'd be very happy to know about it.

bye, Roman

diff -ur -X /home/roman/nodiff linux-2.5.59.org/Makefile linux-2.5.59/Makefile
--- linux-2.5.59.org/Makefile	2003-01-20 20:23:26.000000000 +0100
+++ linux-2.5.59/Makefile	2003-01-20 17:05:34.000000000 +0100
@@ -163,7 +163,7 @@
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
-LDFLAGS_MODULE  = -r
+LDFLAGS_MODULE  = -r -T modules.lds
 CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=

diff -ur -X /home/roman/nodiff linux-2.5.59.org/arch/i386/kernel/entry.S linux-2.5.59/arch/i386/kernel/entry.S
--- linux-2.5.59.org/arch/i386/kernel/entry.S	2003-01-20 20:23:27.000000000 +0100
+++ linux-2.5.59/arch/i386/kernel/entry.S	2003-01-20 17:05:34.000000000 +0100
@@ -669,7 +669,7 @@
 	.long sys_adjtimex
 	.long sys_mprotect	/* 125 */
 	.long sys_sigprocmask
-	.long sys_ni_syscall	/* old "create_module" */
+	.long sys_create_module
 	.long sys_init_module
 	.long sys_delete_module
 	.long sys_ni_syscall	/* 130:	old "get_kernel_syms" */
@@ -709,7 +709,7 @@
 	.long sys_setresuid16
 	.long sys_getresuid16	/* 165 */
 	.long sys_vm86
-	.long sys_ni_syscall	/* Old sys_query_module */
+	.long sys_query_module
 	.long sys_poll
 	.long sys_nfsservctl
 	.long sys_setresgid16	/* 170 */
diff -ur -X /home/roman/nodiff linux-2.5.59.org/arch/um/kernel/sys_call_table.c linux-2.5.59/arch/um/kernel/sys_call_table.c
--- linux-2.5.59.org/arch/um/kernel/sys_call_table.c	2003-01-21 16:55:00.000000000 +0100
+++ linux-2.5.59/arch/um/kernel/sys_call_table.c	2003-01-20 17:05:34.000000000 +0100
@@ -127,6 +127,7 @@
 extern syscall_handler_t sys_adjtimex;
 extern syscall_handler_t sys_mprotect;
 extern syscall_handler_t sys_sigprocmask;
+extern syscall_handler_t sys_create_module;
 extern syscall_handler_t sys_init_module;
 extern syscall_handler_t sys_delete_module;
 extern syscall_handler_t sys_quotactl;
@@ -162,6 +163,7 @@
 extern syscall_handler_t sys_setresuid16;
 extern syscall_handler_t sys_getresuid16;
 extern syscall_handler_t sys_ni_syscall;
+extern syscall_handler_t sys_query_module;
 extern syscall_handler_t sys_poll;
 extern syscall_handler_t sys_nfsservctl;
 extern syscall_handler_t sys_setresgid16;
@@ -384,7 +386,7 @@
 	[ __NR_adjtimex ] = sys_adjtimex,
 	[ __NR_mprotect ] = sys_mprotect,
 	[ __NR_sigprocmask ] = sys_sigprocmask,
-	[ __NR_create_module ] = sys_ni_syscall,
+	[ __NR_create_module ] = sys_create_module,
 	[ __NR_init_module ] = sys_init_module,
 	[ __NR_delete_module ] = sys_delete_module,
 	[ __NR_get_kernel_syms ] = sys_ni_syscall,
@@ -424,7 +426,7 @@
 	[ __NR_setresuid ] = sys_setresuid16,
 	[ __NR_getresuid ] = sys_getresuid16,
 	[ __NR_vm86 ] = sys_ni_syscall,
-	[ __NR_query_module ] = sys_ni_syscall,
+	[ __NR_query_module ] = sys_query_module,
 	[ __NR_poll ] = sys_poll,
 	[ __NR_nfsservctl ] = NFSSERVCTL,
 	[ __NR_setresgid ] = sys_setresgid16,
diff -ur -X /home/roman/nodiff linux-2.5.59.org/fs/proc/proc_misc.c linux-2.5.59/fs/proc/proc_misc.c
--- linux-2.5.59.org/fs/proc/proc_misc.c	2003-01-20 20:23:32.000000000 +0100
+++ linux-2.5.59/fs/proc/proc_misc.c	2003-01-20 17:05:34.000000000 +0100
@@ -296,6 +296,18 @@
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
+
+extern struct seq_operations ksyms_op;
+static int ksyms_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &ksyms_op);
+}
+static struct file_operations proc_ksyms_operations = {
+	.open		= ksyms_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
 #endif

 extern struct seq_operations slabinfo_op;
@@ -594,6 +606,7 @@
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
+	create_seq_entry("ksyms", 0, &proc_ksyms_operations);
 #endif
 	proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
 	if (proc_root_kcore) {
diff -ur -X /home/roman/nodiff linux-2.5.59.org/include/asm-generic/vmlinux.lds.h linux-2.5.59/include/asm-generic/vmlinux.lds.h
--- linux-2.5.59.org/include/asm-generic/vmlinux.lds.h	2003-01-20 20:23:32.000000000 +0100
+++ linux-2.5.59/include/asm-generic/vmlinux.lds.h	2003-01-20 21:19:34.000000000 +0100
@@ -12,19 +12,14 @@
 		*(.rodata1)						\
 	}								\
 									\
-	/* Kernel symbol table: Normal symbols */			\
-	__start___ksymtab = .;						\
-	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
+	/* Kernel symbol table */					\
+	__ksymtab : {							\
+		__start___ksymtab = .;					\
 		*(__ksymtab)						\
-	}								\
-	__stop___ksymtab = .;						\
-									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__start___gpl_ksymtab = .;					\
-	__gpl_ksymtab     : AT(ADDR(__gpl_ksymtab) - LOAD_OFFSET) {	\
+		__start___gpl_ksymtab = .;				\
 		*(__gpl_ksymtab)					\
+		__stop___ksymtab = .;					\
 	}								\
-	__stop___gpl_ksymtab = .;					\
 									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
diff -ur -X /home/roman/nodiff linux-2.5.59.org/include/asm-um/common.lds.S linux-2.5.59/include/asm-um/common.lds.S
--- linux-2.5.59.org/include/asm-um/common.lds.S	2003-01-21 16:55:00.000000000 +0100
+++ linux-2.5.59/include/asm-um/common.lds.S	2003-01-20 21:19:40.000000000 +0100
@@ -13,18 +13,6 @@

   RODATA

-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
-
-  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
-  __gpl_ksymtab : { *(__gpl_ksymtab) }
-  __stop___gpl_ksymtab = .;
-
-  __start___kallsyms = .;       /* All kernel symbols */
-  __kallsyms : { *(__kallsyms) }
-  __stop___kallsyms = .;
-
   .unprotected : { *(.unprotected) }
   . = ALIGN(4096);
   PROVIDE (_unprotected_end = .);
diff -ur -X /home/roman/nodiff linux-2.5.59.org/include/linux/module.h linux-2.5.59/include/linux/module.h
--- linux-2.5.59.org/include/linux/module.h	2003-01-20 20:23:33.000000000 +0100
+++ linux-2.5.59/include/linux/module.h	2003-01-21 14:52:55.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/kmod.h>
 #include <linux/elf.h>
 #include <linux/stringify.h>
+#include <linux/moduleparam.h>

 #include <asm/module.h>
 #include <asm/uaccess.h> /* For struct exception_table_entry */
@@ -32,7 +33,6 @@
 #define MODULE_SYMBOL_PREFIX ""
 #endif

-#define MODULE_NAME_LEN (64 - sizeof(unsigned long))
 struct kernel_symbol
 {
 	unsigned long value;
@@ -40,7 +40,7 @@
 };

 /* These are either module local, or the kernel's dummy ones. */
-extern int init_module(void);
+extern int __init_module(void);
 extern void cleanup_module(void);

 /* Archs provide a method of finding the correct exception table. */
@@ -91,7 +91,10 @@
  * 3.	So vendors can do likewise based on their own policies
  */
 #define MODULE_LICENSE(license)					\
-	static const char __module_license[]			\
+	static const char __module_license1[]			\
+		__attribute__((section(".modinfo")))		\
+		= "license=" license;				\
+	static const char __module_license2[]			\
 		__attribute__((section(".init.license"))) = license

 #else  /* !MODULE */
@@ -117,8 +120,7 @@
 	/* Are we internal use only? */
 	int gplonly;

-	unsigned int num_syms;
-	const struct kernel_symbol *syms;
+	const struct kernel_symbol *sym, *end_sym;
 };

 /* Given an address, look for it in the exception tables */
@@ -128,8 +130,7 @@
 {
 	struct list_head list;

-	unsigned int num_entries;
-	const struct exception_table_entry *entry;
+	const struct exception_table_entry *entry, *end_entry;
 };


@@ -140,23 +141,22 @@
 #define symbol_get(x) ((typeof(&x))(__symbol_get(MODULE_SYMBOL_PREFIX #x)))

 /* For every exported symbol, place a struct in the __ksymtab section */
-#define EXPORT_SYMBOL(sym)					\
-	static const char __kstrtab_##sym[]			\
-	__attribute__((section("__ksymtab_strings")))		\
-	= MODULE_SYMBOL_PREFIX #sym;                    	\
-	static const struct kernel_symbol __ksymtab_##sym	\
-	__attribute__((section("__ksymtab")))			\
-	= { (unsigned long)&sym, __kstrtab_##sym }
-
+#define __EXPORT_SYMBOL(sym, str)			\
+	static const char __kstrtab_##sym[]		\
+	__attribute__((section(".kstrtab"))) = str;	\
+	const struct kernel_symbol __ksymtab_##sym	\
+	__attribute__((section("__ksymtab"))) =		\
+	{ (unsigned long)&sym, __kstrtab_##sym }
+#define EXPORT_SYMBOL(var) __EXPORT_SYMBOL(var, __stringify(var))
 #define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)

-#define EXPORT_SYMBOL_GPL(sym)					\
+#define __EXPORT_SYMBOL_GPL(sym, str)				\
 	static const char __kstrtab_##sym[]			\
-	__attribute__((section("__ksymtab_strings")))		\
-	= MODULE_SYMBOL_PREFIX #sym;                    	\
-	static const struct kernel_symbol __ksymtab_##sym	\
-	__attribute__((section("__gpl_ksymtab")))		\
-	= { (unsigned long)&sym, __kstrtab_##sym }
+	__attribute__((section(".kstrtab"))) = "GPLONLY_" str;	\
+	const struct kernel_symbol __ksymtab_##sym		\
+	__attribute__((section("__gpl_ksymtab"))) =		\
+	{ (unsigned long)&sym, __kstrtab_##sym }
+#define EXPORT_SYMBOL_GPL(sym) __EXPORT_SYMBOL_GPL(sym, __stringify(sym))

 struct module_ref
 {
@@ -178,7 +178,7 @@
 	struct list_head list;

 	/* Unique handle for this module */
-	char name[MODULE_NAME_LEN];
+	char *name;

 	/* Exported symbols */
 	struct kernel_symbol_group symbols;
@@ -210,6 +210,9 @@
 	/* Am I GPL-compatible */
 	int license_gplok;

+	const struct kernel_param *param, *end_param;
+	void *init_start, *init_end;
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* Reference counts */
 	struct module_ref ref[NR_CPUS];
@@ -372,15 +375,25 @@
 #endif /* CONFIG_MODULES */

 #ifdef MODULE
+#define init_module(args...) __init_module(args)
+#define __this_module init_module
+
 extern struct module __this_module;
+extern const struct kernel_symbol __syms_start[], __gpl_syms_start[], __syms_end[];
+extern const struct kernel_param __param_start[], __param_end[];
+extern const struct exception_table_entry __ex_table_start[], __ex_table_end[];
+extern char __init_start[], __init_end[];
 #ifdef KBUILD_MODNAME
 /* We make the linker do some of the work. */
 struct module __this_module
 __attribute__((section(".gnu.linkonce.this_module"))) = {
 	.name = __stringify(KBUILD_MODNAME),
-	.symbols = { .owner = &__this_module },
-	.gpl_symbols = { .owner = &__this_module, .gplonly = 1 },
-	.init = init_module,
+	.symbols = { .owner = &__this_module, .sym = __syms_start, .end_sym = __gpl_syms_start },
+	.gpl_symbols = { .owner = &__this_module, .gplonly = 1, .sym = __gpl_syms_start, .end_sym = __syms_end },
+	.param = __param_start, .end_param = __param_end,
+	.extable = { .entry = __ex_table_start, .end_entry = __ex_table_end },
+	.init_start = __init_start, .init_end = __init_end,
+	.init = __init_module,
 #ifdef CONFIG_MODULE_UNLOAD
 	.exit = cleanup_module,
 #endif
@@ -407,21 +420,6 @@

 #define SET_MODULE_OWNER(dev) ((dev)->owner = THIS_MODULE)

-struct obsolete_modparm {
-	char name[64];
-	char type[64-sizeof(void *)];
-	void *addr;
-};
-#ifdef MODULE
-/* DEPRECATED: Do not use. */
-#define MODULE_PARM(var,type)						    \
-struct obsolete_modparm __parm_##var __attribute__((section("__obsparm"))) = \
-{ __stringify(var), type };
-
-#else
-#define MODULE_PARM(var,type)
-#endif
-
 /* People do this inside their init routines, when the module isn't
    "live" yet.  They should no longer be doing that, but
    meanwhile... */
@@ -455,4 +453,10 @@
 extern const void *inter_module_get_request(const char *, const char *);
 extern void inter_module_put(const char *);

+#ifdef MODULE
+#include <linux/version.h>
+static const char __module_kernel_version[] __attribute__((section(".modinfo"))) =
+"kernel_version=" UTS_RELEASE;
+#endif
+
 #endif /* _LINUX_MODULE_H */
diff -ur -X /home/roman/nodiff linux-2.5.59.org/include/linux/moduleparam.h linux-2.5.59/include/linux/moduleparam.h
--- linux-2.5.59.org/include/linux/moduleparam.h	2003-01-20 20:22:55.000000000 +0100
+++ linux-2.5.59/include/linux/moduleparam.h	2003-01-20 22:39:41.000000000 +0100
@@ -4,71 +4,26 @@
 #include <linux/init.h>
 #include <linux/stringify.h>

-/* You can override this manually, but generally this should match the
-   module name. */
-#ifdef MODULE
-#define MODULE_PARAM_PREFIX /* empty */
-#else
-#define MODULE_PARAM_PREFIX __stringify(KBUILD_MODNAME) "."
-#endif
-
-struct kernel_param;
-
-/* Returns 0, or -errno.  arg is in kp->arg. */
-typedef int (*param_set_fn)(const char *val, struct kernel_param *kp);
-/* Returns length written or -errno.  Buffer is 4k (ie. be short!) */
-typedef int (*param_get_fn)(char *buffer, struct kernel_param *kp);
-
 struct kernel_param {
 	const char *name;
-	unsigned int perm;
-	param_set_fn set;
-	param_get_fn get;
-	void *arg;
-};
-
-/* Special one for strings we want to copy into */
-struct kparam_string {
-	unsigned int maxlen;
-	char *string;
+	const char *type;
+	void *addr;
 };

-/* This is the fundamental function for registering boot/module
-   parameters.  perm sets the visibility in driverfs: 000 means it's
-   not there, read bits mean it's readable, write bits mean it's
-   writable. */
-#define __module_param_call(prefix, name, set, get, arg, perm)		\
-	static char __param_str_##name[] __initdata = prefix #name;	\
-	static struct kernel_param const __param_##name			\
-		 __attribute__ ((unused,__section__ ("__param")))	\
-	= { __param_str_##name, perm, set, get, arg }
-
-#define module_param_call(name, set, get, arg, perm)			      \
-	__module_param_call(MODULE_PARAM_PREFIX, name, set, get, arg, perm)
-
-/* Helper functions: type is byte, short, ushort, int, uint, long,
-   ulong, charp, bool or invbool, or XXX if you define param_get_XXX,
-   param_set_XXX and param_check_XXX. */
-#define module_param_named(name, value, type, perm)			   \
-	param_check_##type(name, &(value));				   \
-	module_param_call(name, param_set_##type, param_get_##type, &value, perm)
-
-#define module_param(name, type, perm)				\
-	module_param_named(name, name, type, perm)
-
-/* Actually copy string: maxlen param is usually sizeof(string). */
-#define module_param_string(name, string, len, perm)			\
-	static struct kparam_string __param_string_##name __initdata	\
-		= { len, string };					\
-	module_param_call(name, param_set_copystring, param_get_charp,	\
-		   &__param_string_##name, perm)
-
-/* Called on module insert or kernel boot */
-extern int parse_args(const char *name,
-		      char *args,
-		      struct kernel_param *params,
-		      unsigned num,
-		      int (*unknown)(char *param, char *val));
+#ifdef MODULE
+#define MODULE_PARM(var, type)				\
+	const char __module_info_##var[]		\
+	__attribute__((section(".modinfo"))) =		\
+	"parm_" __MODULE_STRING(var) "=" type;		\
+	const struct kernel_param __module_param_##var	\
+	__attribute__((section(".modparm"))) =		\
+	{ __MODULE_STRING(var), type, &var }
+#else
+#define MODULE_PARM(var, type)				\
+	const struct kernel_param __module_param_##var	\
+	__attribute__((section("__param"))) =		\
+	{ __stringify(KBUILD_MODNAME) "." __stringify(var), type, &var }
+#endif

 /* All the helper functions */
 /* The macros to do compile-time type checking stolen from Jakub
@@ -76,52 +31,28 @@
 #define __param_check(name, p, type) \
 	static inline type *__check_##name(void) { return(p); }

-extern int param_set_short(const char *val, struct kernel_param *kp);
-extern int param_get_short(char *buffer, struct kernel_param *kp);
-#define param_check_short(name, p) __param_check(name, p, short)
-
-extern int param_set_ushort(const char *val, struct kernel_param *kp);
-extern int param_get_ushort(char *buffer, struct kernel_param *kp);
-#define param_check_ushort(name, p) __param_check(name, p, unsigned short)
-
-extern int param_set_int(const char *val, struct kernel_param *kp);
-extern int param_get_int(char *buffer, struct kernel_param *kp);
-#define param_check_int(name, p) __param_check(name, p, int)
-
-extern int param_set_uint(const char *val, struct kernel_param *kp);
-extern int param_get_uint(char *buffer, struct kernel_param *kp);
-#define param_check_uint(name, p) __param_check(name, p, unsigned int)
-
-extern int param_set_long(const char *val, struct kernel_param *kp);
-extern int param_get_long(char *buffer, struct kernel_param *kp);
-#define param_check_long(name, p) __param_check(name, p, long)
-
-extern int param_set_ulong(const char *val, struct kernel_param *kp);
-extern int param_get_ulong(char *buffer, struct kernel_param *kp);
-#define param_check_ulong(name, p) __param_check(name, p, unsigned long)
-
-extern int param_set_charp(const char *val, struct kernel_param *kp);
-extern int param_get_charp(char *buffer, struct kernel_param *kp);
-#define param_check_charp(name, p) __param_check(name, p, char *)
-
-extern int param_set_bool(const char *val, struct kernel_param *kp);
-extern int param_get_bool(char *buffer, struct kernel_param *kp);
-#define param_check_bool(name, p) __param_check(name, p, int)
-
-extern int param_set_invbool(const char *val, struct kernel_param *kp);
-extern int param_get_invbool(char *buffer, struct kernel_param *kp);
-#define param_check_invbool(name, p) __param_check(name, p, int)
-
-/* First two elements are the max and min array length (which don't change) */
-extern int param_set_intarray(const char *val, struct kernel_param *kp);
-extern int param_get_intarray(char *buffer, struct kernel_param *kp);
-#define param_check_intarray(name, p) __param_check(name, p, int *)
-
-extern int param_set_copystring(const char *val, struct kernel_param *kp);
-
-int param_array(const char *name,
-		const char *val,
-		unsigned int min, unsigned int max,
-		void *elem, int elemsize,
-		int (*set)(const char *, struct kernel_param *kp));
+#define param_check_char(name, p)	__param_check(name, p, char)
+#define param_check_short(name, p)	__param_check(name, p, short)
+#define param_check_ushort(name, p)	__param_check(name, p, unsigned short)
+#define param_check_int(name, p)	__param_check(name, p, int)
+#define param_check_uint(name, p)	__param_check(name, p, unsigned int)
+#define param_check_long(name, p)	__param_check(name, p, long)
+#define param_check_ulong(name, p)	__param_check(name, p, unsigned long)
+
+#define __module_const_char	"b"
+#define __module_const_short	"h"
+#define __module_const_ushort	"h"
+#define __module_const_int	"i"
+#define __module_const_uint	"i"
+#define __module_const_long	"l"
+#define __module_const_ulong	"l"
+
+#define module_param(name, type)		\
+	param_check_##type(name, &name);	\
+	MODULE_PARM(name,__module_const_##type)
+
+extern int parse_args(const char *name, char *args,
+		      const struct kernel_param *params, unsigned num,
+		      int (*unknown)(char *param, char *val));
+
 #endif /* _LINUX_MODULE_PARAM_TYPES_H */
diff -ur -X /home/roman/nodiff linux-2.5.59.org/kernel/module.c linux-2.5.59/kernel/module.c
--- linux-2.5.59.org/kernel/module.c	2003-01-20 20:23:33.000000000 +0100
+++ linux-2.5.59/kernel/module.c	2003-01-21 17:34:27.000000000 +0100
@@ -68,29 +68,23 @@
 	return try_module_get(mod);
 }

-/* Stub function for modules which don't have an initfn */
-int init_module(void)
-{
-	return 0;
-}
-EXPORT_SYMBOL(init_module);
-
 /* Find a symbol, return value and the symbol group */
 static unsigned long __find_symbol(const char *name,
 				   struct kernel_symbol_group **group,
 				   int gplok)
 {
 	struct kernel_symbol_group *ks;
+	const struct kernel_symbol *sym;
+	int offset;

 	list_for_each_entry(ks, &symbols, list) {
- 		unsigned int i;
-
 		if (ks->gplonly && !gplok)
 			continue;
-		for (i = 0; i < ks->num_syms; i++) {
-			if (strcmp(ks->syms[i].name, name) == 0) {
+		offset = ks->gplonly ? sizeof("GPLONLY_") - 1 : 0;
+		for (sym = ks->sym; sym < ks->end_sym; sym++) {
+			if (strcmp(sym->name + offset, name) == 0) {
 				*group = ks;
-				return ks->syms[i].value;
+				return sym->value;
 			}
 		}
 	}
@@ -98,24 +92,6 @@
  	return 0;
 }

-/* Find a symbol in this elf symbol table */
-static unsigned long find_local_symbol(Elf_Shdr *sechdrs,
-				       unsigned int symindex,
-				       const char *strtab,
-				       const char *name)
-{
-	unsigned int i;
-	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
-
-	/* Search (defined) internal symbols first. */
-	for (i = 1; i < sechdrs[symindex].sh_size/sizeof(*sym); i++) {
-		if (sym[i].st_shndx != SHN_UNDEF
-		    && strcmp(name, strtab + sym[i].st_name) == 0)
-			return sym[i].st_value;
-	}
-	return 0;
-}
-
 /* Search for module by name: must hold module_mutex. */
 static struct module *find_module(const char *name)
 {
@@ -375,28 +351,25 @@
 }
 #endif /* CONFIG_MODULE_FORCE_UNLOAD */

-/* Stub function for modules which don't have an exitfn */
-void cleanup_module(void)
-{
-}
-EXPORT_SYMBOL(cleanup_module);
-
 asmlinkage long
 sys_delete_module(const char *name_user, unsigned int flags)
 {
 	struct module *mod;
-	char name[MODULE_NAME_LEN];
+	char *name;
 	int ret, forced = 0;

 	if (!capable(CAP_SYS_MODULE))
 		return -EPERM;

-	if (strncpy_from_user(name, name_user, MODULE_NAME_LEN-1) < 0)
-		return -EFAULT;
-	name[MODULE_NAME_LEN-1] = '\0';
-
-	if (down_interruptible(&module_mutex) != 0)
-		return -EINTR;
+	flags = 0;
+	name = getname(name_user);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	if (down_interruptible(&module_mutex) != 0) {
+		ret = -EINTR;
+		goto release_name;
+	}

 	mod = find_module(name);
 	if (!mod) {
@@ -430,8 +403,7 @@
 	}

 	/* If it has an init func, it must have an exit func to unload */
-	if ((mod->init != init_module && mod->exit == cleanup_module)
-	    || mod->unsafe) {
+	if ((mod->init && !mod->exit) || mod->unsafe) {
 		forced = try_force(flags);
 		if (!forced) {
 			/* This module can't be removed */
@@ -483,6 +455,8 @@

  out:
 	up(&module_mutex);
+ release_name:
+	putname(name);
 	return ret;
 }

@@ -505,7 +479,7 @@
 		seq_printf(m, "[unsafe],");
 	}

-	if (mod->init != init_module && mod->exit == cleanup_module) {
+	if (mod->init && !mod->exit) {
 		printed_something = 1;
 		seq_printf(m, "[permanent],");
 	}
@@ -530,14 +504,13 @@
 void symbol_put_addr(void *addr)
 {
 	struct kernel_symbol_group *ks;
+	const struct kernel_symbol *sym;
 	unsigned long flags;

 	spin_lock_irqsave(&modlist_lock, flags);
 	list_for_each_entry(ks, &symbols, list) {
- 		unsigned int i;
-
-		for (i = 0; i < ks->num_syms; i++) {
-			if (ks->syms[i].value == (unsigned long)addr) {
+		for (sym = ks->sym; sym < ks->end_sym; sym++) {
+			if (sym->value == (unsigned long)addr) {
 				module_put(ks->owner);
 				spin_unlock_irqrestore(&modlist_lock, flags);
 				return;
@@ -577,151 +550,6 @@

 #endif /* CONFIG_MODULE_UNLOAD */

-#ifdef CONFIG_OBSOLETE_MODPARM
-static int param_set_byte(const char *val, struct kernel_param *kp)
-{
-	char *endp;
-	long l;
-
-	if (!val) return -EINVAL;
-	l = simple_strtol(val, &endp, 0);
-	if (endp == val || *endp || ((char)l != l))
-		return -EINVAL;
-	*((char *)kp->arg) = l;
-	return 0;
-}
-
-/* Bounds checking done below */
-static int obsparm_copy_string(const char *val, struct kernel_param *kp)
-{
-	strcpy(kp->arg, val);
-	return 0;
-}
-
-extern int set_obsolete(const char *val, struct kernel_param *kp)
-{
-	unsigned int min, max;
-	unsigned int size, maxsize;
-	char *endp;
-	const char *p;
-	struct obsolete_modparm *obsparm = kp->arg;
-
-	if (!val) {
-		printk(KERN_ERR "Parameter %s needs an argument\n", kp->name);
-		return -EINVAL;
-	}
-
-	/* type is: [min[-max]]{b,h,i,l,s} */
-	p = obsparm->type;
-	min = simple_strtol(p, &endp, 10);
-	if (endp == obsparm->type)
-		min = max = 1;
-	else if (*endp == '-') {
-		p = endp+1;
-		max = simple_strtol(p, &endp, 10);
-	} else
-		max = min;
-	switch (*endp) {
-	case 'b':
-		return param_array(kp->name, val, min, max, obsparm->addr,
-				   1, param_set_byte);
-	case 'h':
-		return param_array(kp->name, val, min, max, obsparm->addr,
-				   sizeof(short), param_set_short);
-	case 'i':
-		return param_array(kp->name, val, min, max, obsparm->addr,
-				   sizeof(int), param_set_int);
-	case 'l':
-		return param_array(kp->name, val, min, max, obsparm->addr,
-				   sizeof(long), param_set_long);
-	case 's':
-		return param_array(kp->name, val, min, max, obsparm->addr,
-				   sizeof(char *), param_set_charp);
-
-	case 'c':
-		/* Undocumented: 1-5c50 means 1-5 strings of up to 49 chars,
-		   and the decl is "char xxx[5][50];" */
-		p = endp+1;
-		maxsize = simple_strtol(p, &endp, 10);
-		/* We check lengths here (yes, this is a hack). */
-		p = val;
-		while (p[size = strcspn(p, ",")]) {
-			if (size >= maxsize)
-				goto oversize;
-			p += size+1;
-		}
-		if (size >= maxsize)
-			goto oversize;
-		return param_array(kp->name, val, min, max, obsparm->addr,
-				   maxsize, obsparm_copy_string);
-	}
-	printk(KERN_ERR "Unknown obsolete parameter type %s\n", obsparm->type);
-	return -EINVAL;
- oversize:
-	printk(KERN_ERR
-	       "Parameter %s doesn't fit in %u chars.\n", kp->name, maxsize);
-	return -EINVAL;
-}
-
-static int obsolete_params(const char *name,
-			   char *args,
-			   struct obsolete_modparm obsparm[],
-			   unsigned int num,
-			   Elf_Shdr *sechdrs,
-			   unsigned int symindex,
-			   const char *strtab)
-{
-	struct kernel_param *kp;
-	unsigned int i;
-	int ret;
-
-	kp = kmalloc(sizeof(kp[0]) * num, GFP_KERNEL);
-	if (!kp)
-		return -ENOMEM;
-
-	for (i = 0; i < num; i++) {
-		char sym_name[128 + sizeof(MODULE_SYMBOL_PREFIX)];
-
-		snprintf(sym_name, sizeof(sym_name), "%s%s",
-			 MODULE_SYMBOL_PREFIX, obsparm[i].name);
-
-		kp[i].name = obsparm[i].name;
-		kp[i].perm = 000;
-		kp[i].set = set_obsolete;
-		kp[i].get = NULL;
-		obsparm[i].addr
-			= (void *)find_local_symbol(sechdrs, symindex, strtab,
-						    sym_name);
-		if (!obsparm[i].addr) {
-			printk("%s: falsely claims to have parameter %s\n",
-			       name, obsparm[i].name);
-			ret = -EINVAL;
-			goto out;
-		}
-		kp[i].arg = &obsparm[i];
-	}
-
-	ret = parse_args(name, args, kp, num, NULL);
- out:
-	kfree(kp);
-	return ret;
-}
-#else
-static int obsolete_params(const char *name,
-			   char *args,
-			   struct obsolete_modparm obsparm[],
-			   unsigned int num,
-			   Elf_Shdr *sechdrs,
-			   unsigned int symindex,
-			   const char *strtab)
-{
-	if (num != 0)
-		printk(KERN_WARNING "%s: Ignoring obsolete parameters\n",
-		       name);
-	return 0;
-}
-#endif /* CONFIG_OBSOLETE_MODPARM */
-
 /* Resolve a symbol for this module.  I.e. if we find one, record usage.
    Must be holding module_mutex. */
 static unsigned long resolve_symbol(Elf_Shdr *sechdrs,
@@ -975,8 +803,8 @@
 	Elf_Ehdr *hdr;
 	Elf_Shdr *sechdrs;
 	char *secstrings, *args;
-	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modindex, obsparmindex, licenseindex, gplindex, vmagindex;
+	unsigned int i, symindex, strindex,
+		modindex, licenseindex, vmagindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -1012,10 +840,10 @@

 	/* May not export symbols, or have setup params, so these may
            not exist */
-	exportindex = setupindex = obsparmindex = gplindex = licenseindex = 0;
+	licenseindex = 0;

 	/* And these should exist, but gcc whinges if we don't init them */
-	symindex = strindex = exindex = modindex = vmagindex = 0;
+	symindex = strindex = modindex = vmagindex = 0;

 	/* Find where important sections are */
 	for (i = 1; i < hdr->e_shnum; i++) {
@@ -1035,37 +863,12 @@
 			/* The module struct */
 			DEBUGP("Module in section %u\n", i);
 			modindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__ksymtab")
-			   == 0) {
-			/* Exported symbols. */
-			DEBUGP("EXPORT table in section %u\n", i);
-			exportindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__param")
-			   == 0) {
-			/* Setup parameter info */
-			DEBUGP("Setup table found in section %u\n", i);
-			setupindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__ex_table")
-			   == 0) {
-			/* Exception table */
-			DEBUGP("Exception table found in section %u\n", i);
-			exindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__obsparm")
-			   == 0) {
-			/* Obsolete MODULE_PARM() table */
-			DEBUGP("Obsolete param found in section %u\n", i);
-			obsparmindex = i;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name,".init.license")
 			   == 0) {
 			/* MODULE_LICENSE() */
 			DEBUGP("Licence found in section %u\n", i);
 			licenseindex = i;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name,
-				  "__gpl_ksymtab") == 0) {
-			/* EXPORT_SYMBOL_GPL() */
-			DEBUGP("GPL symbols found in section %u\n", i);
-			gplindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name,
 				  "__vermagic") == 0) {
 			/* Version magic. */
 			DEBUGP("Version magic found in section %u\n", i);
@@ -1185,22 +988,7 @@
 	if (err < 0)
 		goto cleanup;

-	/* Set up EXPORTed & EXPORT_GPLed symbols (section 0 is 0 length) */
-	mod->symbols.num_syms = (sechdrs[exportindex].sh_size
-				 / sizeof(*mod->symbols.syms));
-	mod->symbols.syms = (void *)sechdrs[exportindex].sh_addr;
-	mod->gpl_symbols.num_syms = (sechdrs[gplindex].sh_size
-				 / sizeof(*mod->symbols.syms));
-	mod->gpl_symbols.syms = (void *)sechdrs[gplindex].sh_addr;
-
-	/* Set up exception table */
-	if (exindex) {
-		/* FIXME: Sort exception table. */
-		mod->extable.num_entries = (sechdrs[exindex].sh_size
-					    / sizeof(struct
-						     exception_table_entry));
-		mod->extable.entry = (void *)sechdrs[exindex].sh_addr;
-	}
+	/* FIXME: Sort exception table. */

 	/* Now handle each section. */
 	for (i = 1; i < hdr->e_shnum; i++) {
@@ -1220,23 +1008,10 @@
 		goto cleanup;

 	mod->args = args;
-	if (obsparmindex) {
-		err = obsolete_params(mod->name, mod->args,
-				      (struct obsolete_modparm *)
-				      sechdrs[obsparmindex].sh_addr,
-				      sechdrs[obsparmindex].sh_size
-				      / sizeof(struct obsolete_modparm),
-				      sechdrs, symindex,
-				      (char *)sechdrs[strindex].sh_addr);
-	} else {
-		/* Size of section 0 is 0, so this works well if no params */
-		err = parse_args(mod->name, mod->args,
-				 (struct kernel_param *)
-				 sechdrs[setupindex].sh_addr,
-				 sechdrs[setupindex].sh_size
-				 / sizeof(struct kernel_param),
-				 NULL);
-	}
+	/* Size of section 0 is 0, so this works well if no params */
+	err = parse_args(mod->name, mod->args,
+			 mod->param, mod->end_param - mod->param,
+			 NULL);
 	if (err < 0)
 		goto cleanup;

@@ -1259,6 +1034,9 @@
 	else return ptr;
 }

+struct module_old;
+static struct module *sys_init_module_old(const char *name_user, struct module_old *mod_user);
+
 /* This is where the real work happens */
 asmlinkage long
 sys_init_module(void *umod,
@@ -1266,7 +1044,7 @@
 		const char *uargs)
 {
 	struct module *mod;
-	int ret;
+	int ret, tmp;

 	/* Must have permission */
 	if (!capable(CAP_SYS_MODULE))
@@ -1276,6 +1054,15 @@
 	if (down_interruptible(&module_mutex) != 0)
 		return -EINTR;

+	if (!get_user(tmp, (int *)umod) && memcmp(&tmp, ELFMAG, 4)) {
+		mod = sys_init_module_old((const char *)umod, (struct module_old *)len);
+		if (IS_ERR(mod)) {
+			up(&module_mutex);
+			return PTR_ERR(mod);
+		}
+		goto cont_load;
+	}
+
 	/* Do all the hard work */
 	mod = load_module(umod, len, uargs);
 	if (IS_ERR(mod)) {
@@ -1288,6 +1075,7 @@
 		flush_icache_range((unsigned long)mod->module_init,
 				   (unsigned long)mod->module_init
 				   + mod->init_size);
+cont_load:
 	flush_icache_range((unsigned long)mod->module_core,
 			   (unsigned long)mod->module_core + mod->core_size);

@@ -1458,15 +1246,18 @@
 const struct exception_table_entry *search_module_extables(unsigned long addr)
 {
 	unsigned long flags;
+	const struct exception_table_entry *first, *end;
 	const struct exception_table_entry *e = NULL;
 	struct exception_table *i;

 	spin_lock_irqsave(&modlist_lock, flags);
 	list_for_each_entry(i, &extables, list) {
-		if (i->num_entries == 0)
+		first = i->entry;
+		end = i->end_entry;
+		if (first == end)
 			continue;

-		e = search_extable(i->entry, i->entry+i->num_entries-1, addr);
+		e = search_extable(first, end - 1, addr);
 		if (e)
 			break;
 	}
@@ -1493,20 +1284,18 @@
 extern const struct kernel_symbol __start___ksymtab[];
 extern const struct kernel_symbol __stop___ksymtab[];
 extern const struct kernel_symbol __start___gpl_ksymtab[];
-extern const struct kernel_symbol __stop___gpl_ksymtab[];

 static struct kernel_symbol_group kernel_symbols, kernel_gpl_symbols;

 static int __init symbols_init(void)
 {
 	/* Add kernel symbols to symbol table */
-	kernel_symbols.num_syms = (__stop___ksymtab - __start___ksymtab);
-	kernel_symbols.syms = __start___ksymtab;
+	kernel_symbols.sym = __start___ksymtab;
+	kernel_symbols.end_sym = __start___gpl_ksymtab;
 	kernel_symbols.gplonly = 0;
 	list_add(&kernel_symbols.list, &symbols);
-	kernel_gpl_symbols.num_syms = (__stop___gpl_ksymtab
-				       - __start___gpl_ksymtab);
-	kernel_gpl_symbols.syms = __start___gpl_ksymtab;
+	kernel_gpl_symbols.sym = __start___gpl_ksymtab;
+	kernel_gpl_symbols.end_sym = __stop___ksymtab;
 	kernel_gpl_symbols.gplonly = 1;
 	list_add(&kernel_gpl_symbols.list, &symbols);

@@ -1514,3 +1303,434 @@
 }

 __initcall(symbols_init);
+
+#define MOD_UNINITIALIZED	0
+#define MOD_RUNNING		1
+#define MOD_DELETED		2
+#define MOD_AUTOCLEAN		4
+#define MOD_VISITED		8
+#define MOD_USED_ONCE		16
+#define MOD_JUST_FREED		32
+#define MOD_INITIALIZING	64
+
+#define QM_MODULES	1
+#define QM_DEPS		2
+#define QM_REFS		3
+#define QM_SYMBOLS	4
+#define QM_INFO		5
+
+struct module_ref_old
+{
+	struct module_old *dep;	/* "parent" pointer */
+	struct module_old *ref;	/* "child" pointer */
+	struct module_ref_old *next_ref;
+};
+
+struct module_old
+{
+	unsigned long size_of_struct;	/* == sizeof(module) */
+	struct module_old *next;
+	const char *name;
+	unsigned long size;
+
+	union
+	{
+		atomic_t usecount;
+		long pad;
+	} uc;				/* Needs to keep its size - so says rth */
+
+	unsigned long flags;		/* AUTOCLEAN et al */
+
+	unsigned nsyms;
+	unsigned ndeps;
+
+	struct kernel_symbol *syms;
+	struct module_ref_old *deps;
+	struct module_ref_old *refs;
+	int (*init)(void);
+	void (*cleanup)(void);
+	const struct exception_table_entry *ex_table_start;
+	const struct exception_table_entry *ex_table_end;
+#ifdef __alpha__
+	unsigned long gp;
+#endif
+	/* Members past this point are extensions to the basic
+	   module support and are optional.  Use mod_member_present()
+	   to examine them.  */
+	const struct module_persist *persist_start;
+	const struct module_persist *persist_end;
+	int (*can_unload)(void);
+	int runsize;			/* In modutils, not currently used */
+	const char *kallsyms_start;	/* All symbols for kernel debugging */
+	const char *kallsyms_end;
+	const char *archdata_start;	/* arch specific data for module */
+	const char *archdata_end;
+	const char *kernel_data;	/* Reserved for kernel internal use */
+};
+
+struct module_info
+{
+	unsigned long addr;
+	unsigned long size;
+	unsigned long flags;
+	long usecount;
+};
+
+static int qm_modules(char *buf, size_t bufsize, size_t *ret)
+{
+	struct module *mod;
+	size_t nmod, space, len;
+	int res = 0;
+
+	nmod = space = 0;
+	list_for_each_entry(mod, &modules, list) {
+		nmod++;
+		len = strlen(mod->name) + 1;
+		space += len;
+		if (len > bufsize) {
+			bufsize = 0;
+			res = -ENOSPC;
+			continue;
+		}
+		if (copy_to_user(buf, mod->name, len))
+			return -EFAULT;
+		buf += len;
+		bufsize -= len;
+	}
+	return put_user(res ? space : nmod, ret) ? -EFAULT : res;
+}
+
+static int qm_deps(struct module *mod, char *buf, size_t bufsize, size_t *ret)
+{
+	struct module *mod2;
+	size_t ndeps, space, len;
+	int res = 0;
+
+	ndeps = space = 0;
+	list_for_each_entry(mod2, &modules, list) {
+		if (!already_uses(mod, mod2))
+			continue;
+		len = strlen(mod2->name) + 1;
+		space += len;
+		if (len > bufsize) {
+			bufsize = 0;
+			res = -EFAULT;
+			continue;
+		}
+		if (copy_to_user(buf, mod2->name, len))
+			return -EFAULT;
+		buf += len;
+		bufsize -= len;
+		ndeps++;
+	}
+	return put_user(res ? space : ndeps, ret) ? -EFAULT : res;
+}
+
+static int qm_refs(struct module *mod, char *buf, size_t bufsize, size_t *ret)
+{
+	size_t nrefs, space, len;
+	struct module_use *use;
+	int res = 0;
+
+	if (!mod)
+		return -EINVAL;
+
+	nrefs = space = 0;
+	list_for_each_entry(use, &mod->modules_which_use_me, list) {
+		len = strlen(use->module_which_uses->name) + 1;
+		space += len;
+		if (len > bufsize) {
+			bufsize = 0;
+			res = -EFAULT;
+			continue;
+		}
+		if (copy_to_user(buf, use->module_which_uses->name, len))
+			return -EFAULT;
+		buf += len;
+		bufsize -= len;
+		nrefs++;
+	}
+	return put_user(res ? space : nrefs, ret) ? -EFAULT : res;
+}
+
+static int qm_symbols(struct module *mod, char *buf, size_t bufsize, size_t *ret)
+{
+	const struct kernel_symbol *sym, *end_sym;
+	char *strings;
+	unsigned long *vals;
+	size_t space, len;
+	int num_syms, res = 0;
+
+	if (mod) {
+		sym = mod->symbols.sym;
+		end_sym = mod->gpl_symbols.end_sym;
+	} else {
+		sym = kernel_symbols.sym;
+		end_sym = kernel_gpl_symbols.end_sym;
+	}
+	num_syms = end_sym - sym;
+	space = num_syms * 2 * sizeof(void *);
+
+	vals = (unsigned long *)buf;
+	strings = buf + space;
+	if (space > bufsize) {
+		res = -ENOSPC;
+		bufsize = 0;
+	} else
+		bufsize -= space;
+
+	for (; sym < end_sym; sym++) {
+		len = strlen(sym->name) + 1;
+		if (len > bufsize) {
+			space += len;
+			bufsize = 0;
+			res = -ENOSPC;
+			continue;
+		}
+		if (copy_to_user(strings, sym->name, len)
+		    || put_user(sym->value, vals)
+		    || put_user(space, vals + 1))
+			return -EFAULT;
+		space += len;
+		strings += len;
+		vals += 2;
+		bufsize -= len;
+	}
+	return put_user(res ? space : num_syms, ret) ? -EFAULT : res;
+}
+
+static int qm_info(struct module *mod, char *buf, size_t bufsize, size_t *ret)
+{
+	int res = 0;
+
+	if (!mod)
+		return -EINVAL;
+
+	if (sizeof(struct module_info) <= bufsize) {
+		struct module_info info;
+		info.addr = (unsigned long)mod;
+		info.size = mod->core_size;
+		switch (mod->state) {
+		case MODULE_STATE_LIVE:
+			info.flags = MOD_RUNNING;
+			break;
+		case MODULE_STATE_COMING:
+			info.flags = MOD_UNINITIALIZED;
+			break;
+		case MODULE_STATE_GOING:
+			info.flags = MOD_DELETED;
+			break;
+		}
+		info.usecount = module_refcount(mod);
+		if (copy_to_user(buf, &info, sizeof(struct module_info)))
+			return -EFAULT;
+	} else
+		res = -ENOSPC;
+
+	return put_user(sizeof(struct module_info), ret) ? -EFAULT : res;
+}
+
+int sys_query_module(const char *name_user, int which, char *buf,
+		     size_t bufsize, size_t *ret)
+{
+	struct module *mod = NULL;
+	char *name;
+	int res;
+
+	down(&module_mutex);
+	if (name_user) {
+		name = getname(name_user);
+		if (IS_ERR(name)) {
+			res = PTR_ERR(name);
+			goto out;
+		}
+
+		mod = find_module(name);
+		putname(name);
+		if (!mod) {
+			res = -ENOENT;
+			goto out;
+		}
+	}
+
+	switch (which) {
+	case 0:
+		res = 0;
+		break;
+	case QM_MODULES:
+		res = qm_modules(buf, bufsize, ret);
+		break;
+	case QM_DEPS:
+		res = qm_deps(mod, buf, bufsize, ret);
+		break;
+	case QM_REFS:
+		res = qm_refs(mod, buf, bufsize, ret);
+		break;
+	case QM_SYMBOLS:
+		res = qm_symbols(mod, buf, bufsize, ret);
+		break;
+	case QM_INFO:
+		res = qm_info(mod, buf, bufsize, ret);
+		break;
+	default:
+		res = -EINVAL;
+	}
+out:
+	up(&module_mutex);
+	return res;
+}
+
+unsigned long sys_create_module(const char *name_user, size_t size)
+{
+	char *name;
+	struct module *mod;
+	char *data = NULL;
+	int len, res = 0;
+
+	if (!capable(CAP_SYS_MODULE))
+		return -EPERM;
+	name = getname(name_user);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	down(&module_mutex);
+	mod = find_module(name);
+	if (mod) {
+		res = -EEXIST;
+		goto out;
+	}
+	len = strlen(name) + 1;
+	mod = kmalloc(sizeof(*mod), GFP_KERNEL);
+	data = module_alloc(size + len);
+	if (!mod || !data) {
+		module_free(NULL, data);
+		kfree(mod);
+		res = -ENOMEM;
+		goto out;
+	}
+	memset(mod, 0, sizeof(*mod));
+	module_unload_init(mod);
+	mod->module_core = data;
+	mod->core_size = size;
+	mod->state = MODULE_STATE_GOING;
+	mod->name = data + size;
+	strcpy(mod->name, name);
+	list_add(&mod->list, &modules);
+out:
+	up(&module_mutex);
+	putname(name);
+
+	return res ? res : (unsigned long)data;
+}
+
+static struct module *sys_init_module_old(const char *name_user, struct module_old *mod_user)
+{
+	char *name;
+	struct module *mod, *tmp_mod;
+	struct module_old *oldmod;
+	struct module_ref_old *dep;
+	int i;
+
+	name = getname(name_user);
+	if (IS_ERR(name))
+		return (struct module *)name;
+
+	tmp_mod = find_module(name);
+	putname(name);
+	if (!tmp_mod)
+		return ERR_PTR(-ENOENT);
+
+	if (copy_from_user(tmp_mod->module_core, mod_user, tmp_mod->core_size))
+		return ERR_PTR(-EFAULT);
+
+	oldmod = tmp_mod->module_core;
+	oldmod->size = tmp_mod->core_size;
+	mod = (struct module *)oldmod->init;
+	mod->state = MODULE_STATE_COMING;
+	module_unload_init(mod);
+	mod->module_core = tmp_mod->module_core;
+	mod->core_size = tmp_mod->core_size;
+	mod->name = tmp_mod->name;
+	list_del(&tmp_mod->list);
+	kfree(tmp_mod);
+	if (oldmod->nsyms) {
+		if (mod->symbols.sym == oldmod->syms) {
+			mod->gpl_symbols.end_sym = mod->symbols.sym + oldmod->nsyms;
+		} else if (mod->symbols.sym == mod->gpl_symbols.end_sym) {
+			mod->symbols.sym = mod->symbols.end_sym = mod->gpl_symbols.sym = oldmod->syms;
+			mod->gpl_symbols.end_sym = mod->symbols.sym + oldmod->nsyms;
+		} else
+			printk("warning unable to join symbols\n");
+	}
+
+	for (i = 0, dep = oldmod->deps; i < oldmod->ndeps; ++i, ++dep)
+		use_module(mod, (struct module *)dep->dep);
+
+	if (mod->init_end == mod->module_core + mod->core_size)
+		printk("truncate init: %p -> %p (%ld)\n",
+			mod->init_end, mod->init_start,
+			PAGE_ALIGN((unsigned long)mod->init_end) -
+			PAGE_ALIGN((unsigned long)mod->init_start));
+
+	return mod;
+}
+
+static void *s_start(struct seq_file *m, loff_t *pos)
+{
+	struct kernel_symbol_group *sg;
+	struct list_head *i;
+	loff_t n = 0;
+
+	down(&module_mutex);
+	list_for_each(i, &symbols) {
+		sg = list_entry(i, struct kernel_symbol_group, list);
+		if (sg->sym == sg->end_sym)
+			continue;
+		if (n++ == *pos)
+			return sg;
+	}
+	return NULL;
+}
+
+static void *s_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	struct kernel_symbol_group *sg = p;
+	struct list_head *i;
+
+	(*pos)++;
+	do {
+		i = sg->list.next;
+		if (i == &symbols)
+			return NULL;
+		sg = list_entry(i, struct kernel_symbol_group, list);
+	} while (sg->sym == sg->end_sym);
+	return sg;
+}
+
+static void s_stop(struct seq_file *m, void *p)
+{
+	up(&module_mutex);
+}
+
+static int s_show(struct seq_file *m, void *p)
+{
+	struct kernel_symbol_group *sg = p;
+	const struct kernel_symbol *sym;
+
+	for (sym = sg->sym; sym < sg->end_sym; sym++) {
+		if (sg->owner)
+			seq_printf(m, "%0*lx %s\t[%s]\n", (int)(2*sizeof(void*)),
+				sym->value, sym->name, sg->owner->name);
+		else
+			seq_printf(m, "%0*lx %s\n", (int)(2*sizeof(void*)),
+				sym->value, sym->name);
+	}
+	return 0;
+}
+
+struct seq_operations ksyms_op = {
+	.start	= s_start,
+	.next	= s_next,
+	.stop	= s_stop,
+	.show	= s_show
+};
diff -ur -X /home/roman/nodiff linux-2.5.59.org/kernel/params.c linux-2.5.59/kernel/params.c
--- linux-2.5.59.org/kernel/params.c	2003-01-20 20:22:56.000000000 +0100
+++ linux-2.5.59/kernel/params.c	2003-01-21 17:32:13.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/module.h>

@@ -27,20 +28,81 @@
 #define DEBUGP(fmt, a...)
 #endif

+static int handle_one(char *val, const struct kernel_param *kp)
+{
+	int min, max, count, type, len;
+	char *p, *next, *loc;
+
+	p = (char *)kp->type;
+
+	min = max = 1;
+	if (isdigit(*p)) {
+		min = max = simple_strtol(p, &p, 10);
+		if (*p == '-')
+			max = simple_strtol(p + 1, &p, 10);
+	}
+	type = *p++;
+	loc = kp->addr;
+	count = 0;
+
+	do {
+		if (++count > max) {
+			printk(KERN_ERR "%s: can only take %i arguments\n", kp->name, max);
+			return -EINVAL;
+		}
+		next = strchr(val, ',');
+		if (next)
+			*next++ = 0;
+
+		switch (type) {
+		case 'b':
+			*loc++ = simple_strtol(val, NULL, 0);
+			break;
+		case 'h':
+			*((short *)loc)++ = simple_strtol(val, NULL, 0);
+			break;
+		case 'i':
+			*((int *)loc)++ = simple_strtol(val, NULL, 0);
+			break;
+		case 'l':
+			*((long *)loc)++ = simple_strtol(val, NULL, 0);
+			break;
+		case 's':
+			*((char **)loc)++ = val;
+			break;
+		case 'c':
+			len = simple_strtol(p, NULL, 10);
+			strncpy(loc, val, len);
+			loc[len - 1] = 0;
+			loc += len;
+			break;
+		default:
+			printk(KERN_ERR "Unknown parameter type %c\n", type);
+			return -EINVAL;
+		}
+	} while ((val = next));
+
+	if (count < min) {
+		printk(KERN_ERR "%s: needs at least %i arguments\n",
+		       kp->name, min);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int parse_one(char *param,
 		     char *val,
-		     struct kernel_param *params,
+		     const struct kernel_param *params,
 		     unsigned num_params,
 		     int (*handle_unknown)(char *param, char *val))
 {
 	unsigned int i;

 	/* Find parameter */
-	for (i = 0; i < num_params; i++) {
-		if (strcmp(param, params[i].name) == 0) {
-			DEBUGP("They are equal!  Calling %p\n",
-			       params[i].set);
-			return params[i].set(val, &params[i]);
+	if (val) {
+		for (i = 0; i < num_params; i++) {
+			if (!strcmp(param, params[i].name))
+				return handle_one(val, params + i);
 		}
 	}

@@ -94,7 +156,7 @@
 /* Args looks like "foo=bar,bar2 baz=fuz wiz". */
 int parse_args(const char *name,
 	       char *args,
-	       struct kernel_param *params,
+	       const struct kernel_param *params,
 	       unsigned num,
 	       int (*unknown)(char *param, char *val))
 {
@@ -130,208 +192,3 @@
 	/* All parsed OK. */
 	return 0;
 }
-
-/* Lazy bastard, eh? */
-#define STANDARD_PARAM_DEF(name, type, format, tmptype, strtolfn)      	\
-	int param_set_##name(const char *val, struct kernel_param *kp)	\
-	{								\
-		char *endp;						\
-		tmptype l;						\
-									\
-		if (!val) return -EINVAL;				\
-		l = strtolfn(val, &endp, 0);				\
-		if (endp == val || *endp || ((type)l != l))		\
-			return -EINVAL;					\
-		*((type *)kp->arg) = l;					\
-		return 0;						\
-	}								\
-	int param_get_##name(char *buffer, struct kernel_param *kp)	\
-	{								\
-		return sprintf(buffer, format, *((type *)kp->arg));	\
-	}
-
-STANDARD_PARAM_DEF(short, short, "%hi", long, simple_strtol);
-STANDARD_PARAM_DEF(ushort, unsigned short, "%hu", long, simple_strtol);
-STANDARD_PARAM_DEF(int, int, "%i", long, simple_strtol);
-STANDARD_PARAM_DEF(uint, unsigned int, "%u", long, simple_strtol);
-STANDARD_PARAM_DEF(long, long, "%li", long, simple_strtol);
-STANDARD_PARAM_DEF(ulong, unsigned long, "%lu", unsigned long, simple_strtoul);
-
-int param_set_charp(const char *val, struct kernel_param *kp)
-{
-	if (!val) {
-		printk(KERN_ERR "%s: string parameter expected\n",
-		       kp->name);
-		return -EINVAL;
-	}
-
-	if (strlen(val) > 1024) {
-		printk(KERN_ERR "%s: string parameter too long\n",
-		       kp->name);
-		return -ENOSPC;
-	}
-
-	*(char **)kp->arg = (char *)val;
-	return 0;
-}
-
-int param_get_charp(char *buffer, struct kernel_param *kp)
-{
-	return sprintf(buffer, "%s", *((char **)kp->arg));
-}
-
-int param_set_bool(const char *val, struct kernel_param *kp)
-{
-	/* No equals means "set"... */
-	if (!val) val = "1";
-
-	/* One of =[yYnN01] */
-	switch (val[0]) {
-	case 'y': case 'Y': case '1':
-		*(int *)kp->arg = 1;
-		return 0;
-	case 'n': case 'N': case '0':
-		*(int *)kp->arg = 0;
-		return 0;
-	}
-	return -EINVAL;
-}
-
-int param_get_bool(char *buffer, struct kernel_param *kp)
-{
-	/* Y and N chosen as being relatively non-coder friendly */
-	return sprintf(buffer, "%c", (*(int *)kp->arg) ? 'Y' : 'N');
-}
-
-int param_set_invbool(const char *val, struct kernel_param *kp)
-{
-	int boolval, ret;
-	struct kernel_param dummy = { .arg = &boolval };
-
-	ret = param_set_bool(val, &dummy);
-	if (ret == 0)
-		*(int *)kp->arg = !boolval;
-	return ret;
-}
-
-int param_get_invbool(char *buffer, struct kernel_param *kp)
-{
-	int val;
-	struct kernel_param dummy = { .arg = &val };
-
-	val = !*(int *)kp->arg;
-	return param_get_bool(buffer, &dummy);
-}
-
-/* We cheat here and temporarily mangle the string. */
-int param_array(const char *name,
-		const char *val,
-		unsigned int min, unsigned int max,
-		void *elem, int elemsize,
-		int (*set)(const char *, struct kernel_param *kp))
-{
-	int ret;
-	unsigned int count = 0;
-	struct kernel_param kp;
-	char save;
-
-	/* Get the name right for errors. */
-	kp.name = name;
-	kp.arg = elem;
-
-	/* No equals sign? */
-	if (!val) {
-		printk(KERN_ERR "%s: expects arguments\n", name);
-		return -EINVAL;
-	}
-
-	/* We expect a comma-separated list of values. */
-	do {
-		int len;
-
-		if (count > max) {
-			printk(KERN_ERR "%s: can only take %i arguments\n",
-			       name, max);
-			return -EINVAL;
-		}
-		len = strcspn(val, ",");
-
-		/* nul-terminate and parse */
-		save = val[len];
-		((char *)val)[len] = '\0';
-		ret = set(val, &kp);
-
-		if (ret != 0)
-			return ret;
-		kp.arg += elemsize;
-		val += len+1;
-		count++;
-	} while (save == ',');
-
-	if (count < min) {
-		printk(KERN_ERR "%s: needs at least %i arguments\n",
-		       name, min);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-/* First two elements are the max and min array length (which don't change) */
-int param_set_intarray(const char *val, struct kernel_param *kp)
-{
-	int *array;
-
-	/* Grab min and max as first two elements */
-	array = kp->arg;
-	return param_array(kp->name, val, array[0], array[1], &array[2],
-			   sizeof(int), param_set_int);
-}
-
-int param_get_intarray(char *buffer, struct kernel_param *kp)
-{
-	int max;
-	int *array;
-	unsigned int i;
-
-	array = kp->arg;
-	max = array[1];
-
-	for (i = 2; i < max + 2; i++)
-		sprintf(buffer, "%s%i", i > 2 ? "," : "", array[i]);
-	return strlen(buffer);
-}
-
-int param_set_copystring(const char *val, struct kernel_param *kp)
-{
-	struct kparam_string *kps = kp->arg;
-
-	if (strlen(val)+1 > kps->maxlen) {
-		printk(KERN_ERR "%s: string doesn't fit in %u chars.\n",
-		       kp->name, kps->maxlen-1);
-		return -ENOSPC;
-	}
-	strcpy(kps->string, val);
-	return 0;
-}
-
-EXPORT_SYMBOL(param_set_short);
-EXPORT_SYMBOL(param_get_short);
-EXPORT_SYMBOL(param_set_ushort);
-EXPORT_SYMBOL(param_get_ushort);
-EXPORT_SYMBOL(param_set_int);
-EXPORT_SYMBOL(param_get_int);
-EXPORT_SYMBOL(param_set_uint);
-EXPORT_SYMBOL(param_get_uint);
-EXPORT_SYMBOL(param_set_long);
-EXPORT_SYMBOL(param_get_long);
-EXPORT_SYMBOL(param_set_ulong);
-EXPORT_SYMBOL(param_get_ulong);
-EXPORT_SYMBOL(param_set_charp);
-EXPORT_SYMBOL(param_get_charp);
-EXPORT_SYMBOL(param_set_bool);
-EXPORT_SYMBOL(param_get_bool);
-EXPORT_SYMBOL(param_set_invbool);
-EXPORT_SYMBOL(param_get_invbool);
-EXPORT_SYMBOL(param_set_intarray);
-EXPORT_SYMBOL(param_get_intarray);
-EXPORT_SYMBOL(param_set_copystring);
diff -ur -X /home/roman/nodiff linux-2.5.59.org/scripts/Makefile.modinst linux-2.5.59/scripts/Makefile.modinst
--- linux-2.5.59.org/scripts/Makefile.modinst	2002-12-16 03:08:09.000000000 +0100
+++ linux-2.5.59/scripts/Makefile.modinst	2003-01-20 20:46:25.000000000 +0100
@@ -15,12 +15,12 @@

 # ==========================================================================

-quiet_cmd_modules_install = INSTALL $(obj-m:.o=.ko)
-      cmd_modules_install = mkdir -p $(MODLIB)/kernel/$(obj); \
-			    cp $(obj-m:.o=.ko) $(MODLIB)/kernel/$(obj)
+quiet_cmd_modules_install = INSTALL $(obj-m)
+      cmd_modules_install = mkdir -p $(MODLIB)/kernel/$(obj) \
+			    $(foreach o,$(obj-m),; cp $(o:.o=.ko) $(MODLIB)/kernel/$(o))

 modules_install: $(subdir-ym)
-ifneq ($(obj-m:.o=.ko),)
+ifneq ($(obj-m),)
 	$(call cmd,modules_install)
 else
 	@:
--- linux-2.5.59.org/modules.lds	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.59/modules.lds	2003-01-21 16:33:58.000000000 +0100
@@ -0,0 +1,38 @@
+SECTIONS
+{
+	.text : {
+		*(.text)
+		PROVIDE(__init_module = 0);
+		PROVIDE(cleanup_module = 0);
+	}
+	.data : {
+		*(.data)
+		*(.rodata*)
+	}
+	__modparam : {
+		__param_start = .;
+		*(.modparm)
+		__param_end = .;
+	}
+	__ex_table : {
+		__ex_table_start = .;
+		*(__ex_table)
+		__ex_table_end = .;
+	}
+	__ksymtab : {
+		__syms_start = .;
+		*(__ksymtab)
+		__gpl_syms_start = .;
+		*(__gpl_ksymtab)
+		__syms_end = .;
+	}
+	.kstrtab : { *(.kstrtab) }
+	__vermagic (INFO) : { *(__vermagic) }
+	.modinfo (INFO) : { *(.modinfo) }
+	.bss : { *(.bss) *(COMMON) }
+	.init.init : {
+		__init_start = .;
+		*(.init*)
+		__init_end = .;
+	}
+}



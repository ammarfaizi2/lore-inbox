Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266354AbSKEAwY>; Mon, 4 Nov 2002 19:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSKEAwX>; Mon, 4 Nov 2002 19:52:23 -0500
Received: from dp.samba.org ([66.70.73.150]:28607 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265613AbSKEApj>;
	Mon, 4 Nov 2002 19:45:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Module loader against 2.5.46: 9/9 
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
In-reply-to: Your message of "Tue, 05 Nov 2002 11:21:48 +1100."
             <20021105002215.8EEE22C0F8@lists.samba.org> 
Date: Tue, 05 Nov 2002 11:47:27 +1100
Message-Id: <20021105005214.0AEAB2C237@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I believe kallsyms is important, this reimplements it sanely,
using the current module infrastructure, and not using an external
kallsyms script.

FYI, the previous interface was:

int kallsyms_symbol_to_address(
	const char       *name,			/* Name to lookup */
	unsigned long    *token,		/* Which module to start with */
	const char      **mod_name,		/* Set to module name or "kernel" */
	unsigned long    *mod_start,		/* Set to start address of module */
	unsigned long    *mod_end,		/* Set to end address of module */
	const char      **sec_name,		/* Set to section name */
	unsigned long    *sec_start,		/* Set to start address of section */
	unsigned long    *sec_end,		/* Set to end address of section */
	const char      **sym_name,		/* Set to full symbol name */
	unsigned long    *sym_start,		/* Set to start address of symbol */
	unsigned long    *sym_end		/* Set to end address of symbol */
	);

The new one is:
/* Lookup an address.  modname is set to NULL if it's in the kernel. */
const char *kallsyms_lookup(unsigned long addr,
			    unsigned long *symbolsize,
			    unsigned long *offset,
			    char **modname);

Rusty.

Name: kallsyms support
Author: Rusty Russell
Status: Documentation
Depends: Module/param-oldstyle.patch.gz

D: Reintroduces kallsyms support.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/Makefile .7287-linux-2.5.46.updated/Makefile
--- .7287-linux-2.5.46/Makefile	2002-11-05 11:12:39.000000000 +1100
+++ .7287-linux-2.5.46.updated/Makefile	2002-11-05 11:13:10.000000000 +1100
@@ -157,7 +157,7 @@ OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
 AWK		= awk
 GENKSYMS	= /sbin/genksyms
-KALLSYMS	= /sbin/kallsyms
+KALLSYMS	= scripts/kallsyms
 PERL		= perl
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
@@ -335,7 +335,7 @@ ifdef CONFIG_KALLSYMS
 kallsyms.o := .tmp_kallsyms2.o
 
 quiet_cmd_kallsyms = KSYM    $@
-cmd_kallsyms = $(KALLSYMS) $< > $@
+cmd_kallsyms = sh $(KALLSYMS) $< $@
 
 .tmp_kallsyms1.o: .tmp_vmlinux1
 	$(call cmd,kallsyms)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/arch/i386/Kconfig .7287-linux-2.5.46.updated/arch/i386/Kconfig
--- .7287-linux-2.5.46/arch/i386/Kconfig	2002-11-05 11:12:39.000000000 +1100
+++ .7287-linux-2.5.46.updated/arch/i386/Kconfig	2002-11-05 11:13:10.000000000 +1100
@@ -1605,14 +1605,13 @@ config DEBUG_HIGHMEM
 	  This options enables addition error checking for high memory systems.
 	  Disable for production systems.
 
-# Reimplemented RSN.
-#config KALLSYMS
-#	bool "Load all symbols for debugging/kksymoops"
-#	depends on DEBUG_KERNEL
-#	help
-#	  Say Y here to let the kernel print out symbolic crash information and
-#	  symbolic stack backtraces. This increases the size of the kernel
-#	  somewhat, as all symbols have to be loaded into the kernel image.
+config KALLSYMS
+	bool "Load all symbols for debugging/kksymoops"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to let the kernel print out symbolic crash information and
+	  symbolic stack backtraces. This increases the size of the kernel
+	  somewhat, as all symbols have to be loaded into the kernel image.
 
 config X86_EXTRA_IRQS
 	bool
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/arch/ia64/Kconfig .7287-linux-2.5.46.updated/arch/ia64/Kconfig
--- .7287-linux-2.5.46/arch/ia64/Kconfig	2002-11-05 11:12:39.000000000 +1100
+++ .7287-linux-2.5.46.updated/arch/ia64/Kconfig	2002-11-05 11:13:10.000000000 +1100
@@ -813,13 +813,13 @@ config DEBUG_KERNEL
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
-#  config KALLSYMS
-#  	bool "Load all symbols for debugging/kksymoops"
-#  	depends on DEBUG_KERNEL
-#  	help
-#  	  Say Y here to let the kernel print out symbolic crash information and
-#  	  symbolic stack backtraces. This increases the size of the kernel
-#  	  somewhat, as all symbols have to be loaded into the kernel image.
+config KALLSYMS
+	bool "Load all symbols for debugging/kksymoops"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to let the kernel print out symbolic crash information and
+	  symbolic stack backtraces. This increases the size of the kernel
+	  somewhat, as all symbols have to be loaded into the kernel image.
 
 config IA64_PRINT_HAZARDS
 	bool "Print possible IA-64 dependency violations to console"
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/arch/ppc/Kconfig .7287-linux-2.5.46.updated/arch/ppc/Kconfig
--- .7287-linux-2.5.46/arch/ppc/Kconfig	2002-11-05 11:12:39.000000000 +1100
+++ .7287-linux-2.5.46.updated/arch/ppc/Kconfig	2002-11-05 11:13:10.000000000 +1100
@@ -1784,9 +1784,9 @@ config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
 
-#  config KALLSYMS
-#  	bool "Load all symbols for debugging/kksymoops"
-#  	depends on DEBUG_KERNEL
+config KALLSYMS
+	bool "Load all symbols for debugging/kksymoops"
+	depends on DEBUG_KERNEL
 
 config KGDB
 	bool "Include kgdb kernel debugger"
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/arch/ppc/kernel/process.c .7287-linux-2.5.46.updated/arch/ppc/kernel/process.c
--- .7287-linux-2.5.46/arch/ppc/kernel/process.c	2002-10-15 15:30:52.000000000 +1000
+++ .7287-linux-2.5.46.updated/arch/ppc/kernel/process.c	2002-11-05 11:13:10.000000000 +1100
@@ -34,6 +34,7 @@
 #include <linux/prctl.h>
 #include <linux/init_task.h>
 #include <linux/module.h>
+#include <linux/kallsyms.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/arch/x86_64/Kconfig .7287-linux-2.5.46.updated/arch/x86_64/Kconfig
--- .7287-linux-2.5.46/arch/x86_64/Kconfig	2002-11-05 11:12:39.000000000 +1100
+++ .7287-linux-2.5.46.updated/arch/x86_64/Kconfig	2002-11-05 11:13:10.000000000 +1100
@@ -739,13 +739,13 @@ config INIT_DEBUG
 	help
 	  Fill __init and __initdata at the end of boot. This is only for debugging.
 
-#  config KALLSYMS
-#  	bool "Load all symbols for debugging/kksymoops"
-#  	depends on DEBUG_KERNEL
-#  	help
-#  	  Say Y here to let the kernel print out symbolic crash information and
-#  	  symbolic stack backtraces. This increases the size of the kernel
-#  	  somewhat, as all symbols have to be loaded into the kernel image.
+config KALLSYMS
+	bool "Load all symbols for debugging/kksymoops"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to let the kernel print out symbolic crash information and
+	  symbolic stack backtraces. This increases the size of the kernel
+	  somewhat, as all symbols have to be loaded into the kernel image.
 
 endmenu
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/fs/proc/base.c .7287-linux-2.5.46.updated/fs/proc/base.c
--- .7287-linux-2.5.46/fs/proc/base.c	2002-11-05 10:54:27.000000000 +1100
+++ .7287-linux-2.5.46.updated/fs/proc/base.c	2002-11-05 11:13:10.000000000 +1100
@@ -257,20 +257,18 @@ out:
  */
 static int proc_pid_wchan(struct task_struct *task, char *buffer)
 {
-	const char *sym_name, *ignore;
-	unsigned long wchan, dummy;
+	char *modname;
+	const char *sym_name;
+	unsigned long wchan, size, offset;
 
 	wchan = get_wchan(task);
 
-	if (!kallsyms_address_to_symbol(wchan, &ignore, &dummy, &dummy,
-			&ignore, &dummy, &dummy, &sym_name,
-			&dummy, &dummy)) {
-		return sprintf(buffer, "%lu", wchan);
-	}
-
-	return sprintf(buffer, "%s", sym_name);
+	sym_name = kallsyms_lookup(wchan, &size, &offset, &modname);
+	if (sym_name)
+		return sprintf(buffer, "%s", sym_name);
+	return sprintf(buffer, "%lu", wchan);
 }
-#endif
+#endif /* CONFIG_KALLSYMS */
 
 /************************************************************************/
 /*                       Here the fs part begins                        */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/include/linux/kallsyms.h .7287-linux-2.5.46.updated/include/linux/kallsyms.h
--- .7287-linux-2.5.46/include/linux/kallsyms.h	2002-10-15 15:19:44.000000000 +1000
+++ .7287-linux-2.5.46.updated/include/linux/kallsyms.h	2002-11-05 11:13:11.000000000 +1100
@@ -1,163 +1,47 @@
-/* kallsyms headers
-   Copyright 2000 Keith Owens <kaos@ocs.com.au>
-
-   This file is part of the Linux modutils.  It is exported to kernel
-   space so debuggers can access the kallsyms data.
-
-   The kallsyms data contains all the non-stack symbols from a kernel
-   or a module.  The kernel symbols are held between __start___kallsyms
-   and __stop___kallsyms.  The symbols for a module are accessed via
-   the struct module chain which is based at module_list.
-
-   This program is free software; you can redistribute it and/or modify it
-   under the terms of the GNU General Public License as published by the
-   Free Software Foundation; either version 2 of the License, or (at your
-   option) any later version.
-
-   This program is distributed in the hope that it will be useful, but
-   WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software Foundation,
-   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-#ident "$Id: linux-2.4.9-kallsyms.patch,v 1.8 2002/02/11 18:34:53 arjanv Exp $"
-
-#ifndef MODUTILS_KALLSYMS_H
-#define MODUTILS_KALLSYMS_H 1
-
-/* Have to (re)define these ElfW entries here because external kallsyms
- * code does not have access to modutils/include/obj.h.  This code is
- * included from user spaces tools (modutils) and kernel, they need
- * different includes.
+/* Rewritten and vastly simplified by Rusty Russell for in-kernel
+ * module loader:
+ *   Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
  */
+#ifndef _LINUX_KALLSYMS_H
+#define _LINUX_KALLSYMS_H
 
-#ifndef ELFCLASS32
-#ifdef __KERNEL__
-#include <linux/elf.h>
-#else	/* __KERNEL__ */
-#include <elf.h>
-#endif	/* __KERNEL__ */
-#endif	/* ELFCLASS32 */
-
-#ifndef ELFCLASSM
-#define ELFCLASSM ELF_CLASS
-#endif
-
-#ifndef ElfW
-# if ELFCLASSM == ELFCLASS32
-#  define ElfW(x)  Elf32_ ## x
-#  define ELFW(x)  ELF32_ ## x
-# else
-#  define ElfW(x)  Elf64_ ## x
-#  define ELFW(x)  ELF64_ ## x
-# endif
-#endif
-
-/* Format of data in the kallsyms section.
- * Most of the fields are small numbers but the total size and all
- * offsets can be large so use the 32/64 bit types for these fields.
- *
- * Do not use sizeof() on these structures, modutils may be using extra
- * fields.  Instead use the size fields in the header to access the
- * other bits of data.
- */  
-
-struct kallsyms_header {
-	int		size;		/* Size of this header */
-	ElfW(Word)	total_size;	/* Total size of kallsyms data */
-	int		sections;	/* Number of section entries */
-	ElfW(Off)	section_off;	/* Offset to first section entry */
-	int		section_size;	/* Size of one section entry */
-	int		symbols;	/* Number of symbol entries */
-	ElfW(Off)	symbol_off;	/* Offset to first symbol entry */
-	int		symbol_size;	/* Size of one symbol entry */
-	ElfW(Off)	string_off;	/* Offset to first string */
-	ElfW(Addr)	start;		/* Start address of first section */
-	ElfW(Addr)	end;		/* End address of last section */
-};
-
-struct kallsyms_section {
-	ElfW(Addr)	start;		/* Start address of section */
-	ElfW(Word)	size;		/* Size of this section */
-	ElfW(Off)	name_off;	/* Offset to section name */
-	ElfW(Word)	flags;		/* Flags from section */
-};
-
-struct kallsyms_symbol {
-	ElfW(Off)	section_off;	/* Offset to section that owns this symbol */
-	ElfW(Addr)	symbol_addr;	/* Address of symbol */
-	ElfW(Off)	name_off;	/* Offset to symbol name */
-};
-
-#define KALLSYMS_SEC_NAME "__kallsyms"
-#define KALLSYMS_IDX 2			/* obj_kallsyms creates kallsyms as section 2 */
-
-#define kallsyms_next_sec(h,s) \
-	((s) = (struct kallsyms_section *)((char *)(s) + (h)->section_size))
-#define kallsyms_next_sym(h,s) \
-	((s) = (struct kallsyms_symbol *)((char *)(s) + (h)->symbol_size))
+#include <linux/config.h>
 
 #ifdef CONFIG_KALLSYMS
+/* Lookup an address.  modname is set to NULL if it's in the kernel. */
+const char *kallsyms_lookup(unsigned long addr,
+			    unsigned long *symbolsize,
+			    unsigned long *offset,
+			    char **modname);
 
-int kallsyms_symbol_to_address(
-	const char       *name,			/* Name to lookup */
-	unsigned long    *token,		/* Which module to start with */
-	const char      **mod_name,		/* Set to module name or "kernel" */
-	unsigned long    *mod_start,		/* Set to start address of module */
-	unsigned long    *mod_end,		/* Set to end address of module */
-	const char      **sec_name,		/* Set to section name */
-	unsigned long    *sec_start,		/* Set to start address of section */
-	unsigned long    *sec_end,		/* Set to end address of section */
-	const char      **sym_name,		/* Set to full symbol name */
-	unsigned long    *sym_start,		/* Set to start address of symbol */
-	unsigned long    *sym_end		/* Set to end address of symbol */
-	);
+/* Replace "%s" in format with address, if found */
+extern void __print_symbol(const char *fmt, unsigned long address);
 
-int kallsyms_address_to_symbol(
-	unsigned long     address,		/* Address to lookup */
-	const char      **mod_name,		/* Set to module name */
-	unsigned long    *mod_start,		/* Set to start address of module */
-	unsigned long    *mod_end,		/* Set to end address of module */
-	const char      **sec_name,		/* Set to section name */
-	unsigned long    *sec_start,		/* Set to start address of section */
-	unsigned long    *sec_end,		/* Set to end address of section */
-	const char      **sym_name,		/* Set to full symbol name */
-	unsigned long    *sym_start,		/* Set to start address of symbol */
-	unsigned long    *sym_end		/* Set to end address of symbol */
-	);
+#else /* !CONFIG_KALLSYMS */
 
-int kallsyms_sections(void *token,
-		      int (*callback)(void *,	/* token */
-		      	const char *,		/* module name */
-			const char *,		/* section name */
-			ElfW(Addr),		/* Section start */
-			ElfW(Addr),		/* Section end */
-			ElfW(Word)		/* Section flags */
-		      )
-		);
+static inline const char *kallsyms_lookup(unsigned long addr,
+					  unsigned long *symbolsize,
+					  unsigned long *offset,
+					  char **modname)
+{
+	return NULL;
+}
 
-#else
+/* Stupid that this does nothing, but I didn't create this mess. */
+#define __print_symbol(fmt, addr)
+#endif /*CONFIG_KALLSYMS*/
 
-static inline int kallsyms_address_to_symbol(
-	unsigned long     address,		/* Address to lookup */
-	const char      **mod_name,		/* Set to module name */
-	unsigned long    *mod_start,		/* Set to start address of module */
-	unsigned long    *mod_end,		/* Set to end address of module */
-	const char      **sec_name,		/* Set to section name */
-	unsigned long    *sec_start,		/* Set to start address of section */
-	unsigned long    *sec_end,		/* Set to end address of section */
-	const char      **sym_name,		/* Set to full symbol name */
-	unsigned long    *sym_start,		/* Set to start address of symbol */
-	unsigned long    *sym_end		/* Set to end address of symbol */
-	)
+/* This macro allows us to keep printk typechecking */
+static void __check_printsym_format(const char *fmt, ...)
+__attribute__((format(printf,1,2)));
+static inline void __check_printsym_format(const char *fmt, ...)
 {
-	return -ESRCH;
 }
 
-#endif
+#define print_symbol(fmt, addr)			\
+do {						\
+	__check_printsym_format(fmt, "");	\
+	__print_symbol(fmt, addr);		\
+} while(0)
 
-#endif /* kallsyms.h */
+#endif /*_LINUX_KALLSYMS_H*/
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/include/linux/module.h .7287-linux-2.5.46.updated/include/linux/module.h
--- .7287-linux-2.5.46/include/linux/module.h	2002-11-05 11:12:43.000000000 +1100
+++ .7287-linux-2.5.46.updated/include/linux/module.h	2002-11-05 11:13:11.000000000 +1100
@@ -27,8 +27,6 @@
 #define MODULE_GENERIC_TABLE(gtype,name)
 #define MODULE_DEVICE_TABLE(type,name)
 #define MODULE_PARM_DESC(var,desc)
-#define print_symbol(format, addr)
-#define print_modules()
 
 #define MODULE_NAME_LEN (64 - sizeof(unsigned long))
 struct kernel_symbol
@@ -136,6 +134,13 @@ struct module
 	void (*exit)(void);
 #endif
 
+#ifdef CONFIG_KALLSYMS
+	/* We keep the symbol and string tables for kallsyms. */
+	Elf_Sym *symtab;
+	unsigned long num_syms;
+	char *strtab;
+#endif
+
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
 	char args[0];
@@ -248,6 +253,12 @@ do {									     \
 	}								     \
 } while(0)
 
+/* For kallsyms to ask for address resolution.  NULL means not found. */
+const char *module_address_lookup(unsigned long addr,
+				  unsigned long *symbolsize,
+				  unsigned long *offset,
+				  char **modname);
+
 #else /* !CONFIG_MODULES... */
 #define EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym)
@@ -261,6 +272,15 @@ do {									     \
 #define module_put(module) do { } while(0)
 
 #define __unsafe(mod)
+
+/* For kallsyms to ask for address resolution.  NULL means not found. */
+static inline const char *module_address_lookup(unsigned long addr,
+						unsigned long *symbolsize,
+						unsigned long *offset,
+						char **modname)
+{
+	return NULL;
+}
 #endif /* CONFIG_MODULES */
 
 /* For archs to search exception tables */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/kernel/Makefile .7287-linux-2.5.46.updated/kernel/Makefile
--- .7287-linux-2.5.46/kernel/Makefile	2002-11-05 11:12:41.000000000 +1100
+++ .7287-linux-2.5.46.updated/kernel/Makefile	2002-11-05 11:14:07.000000000 +1100
@@ -4,7 +4,7 @@
 
 export-objs = signal.o sys.o kmod.o workqueue.o ksyms.o pm.o exec_domain.o \
 		printk.o platform.o suspend.o dma.o module.o cpufreq.o \
-		profile.o rcupdate.o intermodule.o params.o
+		profile.o rcupdate.o intermodule.o params.o kallsyms.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    exit.o itimer.o time.o softirq.o resource.o \
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/kernel/kallsyms.c .7287-linux-2.5.46.updated/kernel/kallsyms.c
--- .7287-linux-2.5.46/kernel/kallsyms.c	2002-10-15 15:30:05.000000000 +1000
+++ .7287-linux-2.5.46.updated/kernel/kallsyms.c	2002-11-05 11:13:11.000000000 +1100
@@ -1,233 +1,105 @@
 /*
- * kksymoops.c: in-kernel printing of symbolic oopses and stack traces.
- *
- *  Copyright 2000 Keith Owens <kaos@ocs.com.au> April 2000
- *  Copyright 2002 Arjan van de Ven <arjanv@redhat.com>
+ * kallsyms.c: in-kernel printing of symbolic oopses and stack traces.
  *
-   This code uses the list of all kernel and module symbols to :-
+ * Rewritten and vastly simplified by Rusty Russell for in-kernel
+ * module loader:
+ *   Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
+ */
+#include <linux/kallsyms.h>
+#include <linux/module.h>
 
-   * Find any non-stack symbol in a kernel or module.  Symbols do
-     not have to be exported for debugging.
+static char kallsyms_dummy;
 
-   * Convert an address to the module (or kernel) that owns it, the
-     section it is in and the nearest symbol.  This finds all non-stack
-     symbols, not just exported ones.
+/* These get overridden when the real kallsyms.o is linked in. */
+extern unsigned long kallsyms_addresses[1]
+	__attribute__((alias("kallsyms_dummy"), weak));
+extern unsigned long kallsyms_num_syms
+	__attribute__((alias("kallsyms_dummy"), weak));
+extern char kallsyms_names[1]
+	__attribute__((alias("kallsyms_dummy"), weak));
 
- */
+/* Defined by the linker script. */
+extern char _stext[], _etext[];
 
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/kallsyms.h>
+/* Lookup an address.  modname is set to NULL if it's in the kernel. */
+const char *kallsyms_lookup(unsigned long addr,
+			    unsigned long *symbolsize,
+			    unsigned long *offset,
+			    char **modname)
+{
+	unsigned long i, best = 0;
 
-/* A symbol can appear in more than one module.  A token is used to
- * restart the scan at the next module, set the token to 0 for the
- * first scan of each symbol.
- */
+	/* This kernel should never had been booted. */
+	if ((void *)kallsyms_addresses == &kallsyms_dummy)
+		BUG();
 
-int kallsyms_symbol_to_address(
-	const char	 *name,		/* Name to lookup */
-	unsigned long 	 *token,	/* Which module to start at */
-	const char	**mod_name,	/* Set to module name */
-	unsigned long 	 *mod_start,	/* Set to start address of module */
-	unsigned long 	 *mod_end,	/* Set to end address of module */
-	const char	**sec_name,	/* Set to section name */
-	unsigned long 	 *sec_start,	/* Set to start address of section */
-	unsigned long 	 *sec_end,	/* Set to end address of section */
-	const char	**sym_name,	/* Set to full symbol name */
-	unsigned long 	 *sym_start,	/* Set to start address of symbol */
-	unsigned long 	 *sym_end	/* Set to end address of symbol */
-	)
-{
-	const struct kallsyms_header	*ka_hdr = NULL;	/* stupid gcc */
-	const struct kallsyms_section	*ka_sec;
-	const struct kallsyms_symbol	*ka_sym = NULL;
-	const char			*ka_str = NULL;
-	const struct module *m;
-	int i = 0, l;
-	const char *p, *pt_R;
-	char *p2;
+	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) {
+		unsigned long symbol_end;
+		char *name = kallsyms_names;
 
-	/* Restart? */
-	m = module_list;
-	if (token && *token) {
-		for (; m; m = m->next)
-			if ((unsigned long)m == *token)
-				break;
-		if (m)
-			m = m->next;
-	}
+		/* They're sorted, we could be clever here, but who cares? */
+		for (i = 0; i < kallsyms_num_syms; i++) {
+			if (kallsyms_addresses[i] > kallsyms_addresses[best] &&
+			    kallsyms_addresses[i] <= addr)
+				best = i;
+		}
 
-	for (; m; m = m->next) {
-		if (!mod_member_present(m, kallsyms_start) || 
-		    !mod_member_present(m, kallsyms_end) ||
-		    m->kallsyms_start >= m->kallsyms_end)
-			continue;
-		ka_hdr = (struct kallsyms_header *)m->kallsyms_start;
-		ka_sym = (struct kallsyms_symbol *)
-			((char *)(ka_hdr) + ka_hdr->symbol_off);
-		ka_str = 
-			((char *)(ka_hdr) + ka_hdr->string_off);
-		for (i = 0; i < ka_hdr->symbols; ++i, kallsyms_next_sym(ka_hdr, ka_sym)) {
-			p = ka_str + ka_sym->name_off;
-			if (strcmp(p, name) == 0)
+		/* Grab name */
+		for (i = 0; i < best; i++)
+			name += strlen(name)+1;
+
+		/* Base symbol size on next symbol, but beware aliases. */
+		symbol_end = (unsigned long)_etext;
+		for (i = best+1; i < kallsyms_num_syms; i++) {
+			if (kallsyms_addresses[i] != kallsyms_addresses[best]){
+				symbol_end = kallsyms_addresses[i];
 				break;
-			/* Unversioned requests match versioned names */
-			if (!(pt_R = strstr(p, "_R")))
-				continue;
-			l = strlen(pt_R);
-			if (l < 10)
-				continue;	/* Not _R.*xxxxxxxx */
-			(void)simple_strtoul(pt_R+l-8, &p2, 16);
-			if (*p2)
-				continue;	/* Not _R.*xxxxxxxx */
-			if (strncmp(p, name, pt_R-p) == 0)
-				break;	/* Match with version */
+			}
 		}
-		if (i < ka_hdr->symbols)
-			break;
-	}
 
-	if (token)
-		*token = (unsigned long)m;
-	if (!m)
-		return(0);	/* not found */
-
-	ka_sec = (const struct kallsyms_section *)
-		((char *)ka_hdr + ka_hdr->section_off + ka_sym->section_off);
-	*mod_name = m->name;
-	*mod_start = ka_hdr->start;
-	*mod_end = ka_hdr->end;
-	*sec_name = ka_sec->name_off + ka_str;
-	*sec_start = ka_sec->start;
-	*sec_end = ka_sec->start + ka_sec->size;
-	*sym_name = ka_sym->name_off + ka_str;
-	*sym_start = ka_sym->symbol_addr;
-	if (i < ka_hdr->symbols-1) {
-		const struct kallsyms_symbol *ka_symn = ka_sym;
-		kallsyms_next_sym(ka_hdr, ka_symn);
-		*sym_end = ka_symn->symbol_addr;
+		*symbolsize = symbol_end - kallsyms_addresses[best];
+		*modname = NULL;
+		*offset = addr - kallsyms_addresses[best];
+		return name;
 	}
-	else
-		*sym_end = *sec_end;
-	return(1);
+
+	return module_address_lookup(addr, symbolsize, offset, modname);
 }
 
-int kallsyms_address_to_symbol(
-	unsigned long	  address,	/* Address to lookup */
-	const char	**mod_name,	/* Set to module name */
-	unsigned long 	 *mod_start,	/* Set to start address of module */
-	unsigned long 	 *mod_end,	/* Set to end address of module */
-	const char	**sec_name,	/* Set to section name */
-	unsigned long 	 *sec_start,	/* Set to start address of section */
-	unsigned long 	 *sec_end,	/* Set to end address of section */
-	const char	**sym_name,	/* Set to full symbol name */
-	unsigned long 	 *sym_start,	/* Set to start address of symbol */
-	unsigned long 	 *sym_end	/* Set to end address of symbol */
-	)
+/* Replace "%s" in format with address, or returns -errno. */
+void __print_symbol(const char *fmt, unsigned long address)
 {
-	const struct kallsyms_header	*ka_hdr = NULL;	/* stupid gcc */
-	const struct kallsyms_section	*ka_sec = NULL;
-	const struct kallsyms_symbol	*ka_sym;
-	const char			*ka_str;
-	const struct module *m;
-	int i;
-	unsigned long end;
-
-	for (m = module_list; m; m = m->next) {
-	  
-		if (!mod_member_present(m, kallsyms_start) || 
-		    !mod_member_present(m, kallsyms_end) ||
-		    m->kallsyms_start >= m->kallsyms_end)
-			continue;
-		ka_hdr = (struct kallsyms_header *)m->kallsyms_start;
-		ka_sec = (const struct kallsyms_section *)
-			((char *)ka_hdr + ka_hdr->section_off);
-		/* Is the address in any section in this module? */
-		for (i = 0; i < ka_hdr->sections; ++i, kallsyms_next_sec(ka_hdr, ka_sec)) {
-			if (ka_sec->start <= address &&
-			    (ka_sec->start + ka_sec->size) > address)
-				break;
-		}
-		if (i < ka_hdr->sections)
-			break;	/* Found a matching section */
-	}
+	char *modname;
+	const char *name;
+	unsigned long offset, size;
 
-	if (!m)
-		return(0);	/* not found */
+	name = kallsyms_lookup(address, &size, &offset, &modname);
 
-	ka_sym = (struct kallsyms_symbol *)
-		((char *)(ka_hdr) + ka_hdr->symbol_off);
-	ka_str = 
-		((char *)(ka_hdr) + ka_hdr->string_off);
-	*mod_name = m->name;
-	*mod_start = ka_hdr->start;
-	*mod_end = ka_hdr->end;
-	*sec_name = ka_sec->name_off + ka_str;
-	*sec_start = ka_sec->start;
-	*sec_end = ka_sec->start + ka_sec->size;
-	*sym_name = *sec_name;		/* In case we find no matching symbol */
-	*sym_start = *sec_start;
-	*sym_end = *sec_end;
+	if (!name) {
+		char addrstr[sizeof("0x%lx") + (BITS_PER_LONG*3/10)];
 
-	for (i = 0; i < ka_hdr->symbols; ++i, kallsyms_next_sym(ka_hdr, ka_sym)) {
-		if (ka_sym->symbol_addr > address)
-			continue;
-		if (i < ka_hdr->symbols-1) {
-			const struct kallsyms_symbol *ka_symn = ka_sym;
-			kallsyms_next_sym(ka_hdr, ka_symn);
-			end = ka_symn->symbol_addr;
-		}
-		else
-			end = *sec_end;
-		if (end <= address)
-			continue;
-		if ((char *)ka_hdr + ka_hdr->section_off + ka_sym->section_off
-		    != (char *)ka_sec)
-			continue;	/* wrong section */
-		*sym_name = ka_str + ka_sym->name_off;
-		*sym_start = ka_sym->symbol_addr;
-		*sym_end = end;
-		break;
+		sprintf(addrstr, "0x%lx", address);
+		printk(fmt, addrstr);
+		return;
 	}
-	return(1);
-}
 
-/* List all sections in all modules.  The callback routine is invoked with
- * token, module name, section name, section start, section end, section flags.
- */
-int kallsyms_sections(void *token,
-		      int (*callback)(void *, const char *, const char *, ElfW(Addr), ElfW(Addr), ElfW(Word)))
-{
-	const struct kallsyms_header	*ka_hdr = NULL;	/* stupid gcc */
-	const struct kallsyms_section	*ka_sec = NULL;
-	const char			*ka_str;
-	const struct module *m;
-	int i;
+	if (modname) {
+		/* This is pretty small. */
+		char buffer[sizeof("%s+%#lx/%#lx [%s]")
+			   + strlen(name) + 2*(BITS_PER_LONG*3/10)
+			   + strlen(modname)];
 
-	for (m = module_list; m; m = m->next) {
-		if (!mod_member_present(m, kallsyms_start) || 
-		    !mod_member_present(m, kallsyms_end) ||
-		    m->kallsyms_start >= m->kallsyms_end)
-			continue;
-		ka_hdr = (struct kallsyms_header *)m->kallsyms_start;
-		ka_sec = (const struct kallsyms_section *) ((char *)ka_hdr + ka_hdr->section_off);
-		ka_str = ((char *)(ka_hdr) + ka_hdr->string_off);
-		for (i = 0; i < ka_hdr->sections; ++i, kallsyms_next_sec(ka_hdr, ka_sec)) {
-			if (callback(
-				token,
-				*(m->name) ? m->name : "kernel",
-				ka_sec->name_off + ka_str,
-				ka_sec->start,
-				ka_sec->start + ka_sec->size,
-				ka_sec->flags))
-				return(0);
-		}
+		sprintf(buffer, "%s+%#lx/%#lx [%s]",
+			name, offset, size, modname);
+		printk(fmt, buffer);
+	} else {
+		char buffer[sizeof("%s+%#lx/%#lx")
+			   + strlen(name) + 2*(BITS_PER_LONG*3/10)];
+
+		sprintf(buffer, "%s+%#lx/%#lx", name, offset, size);
+		printk(fmt, buffer);
 	}
-	return(1);
 }
 
-/* Allocate the __kallsyms section, so it's already present in
- * the temporary vmlinux that kallsyms is run on, so the first
- * run will pick up the section info already. */
-
-__asm__(".section __kallsyms,\"a\"\n.previous");
+EXPORT_SYMBOL(kallsyms_lookup);
+EXPORT_SYMBOL(__print_symbol);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/kernel/module.c .7287-linux-2.5.46.updated/kernel/module.c
--- .7287-linux-2.5.46/kernel/module.c	2002-11-05 11:12:43.000000000 +1100
+++ .7287-linux-2.5.46.updated/kernel/module.c	2002-11-05 11:13:11.000000000 +1100
@@ -1026,6 +1026,11 @@ static struct module *load_module(void *
 			DEBUGP("Obsolete param found in section %u\n", i);
 			obsparmindex = i;
 		}
+#ifdef CONFIG_KALLSYMS
+		/* symbol and string tables for decoding later. */
+		if (sechdrs[i].sh_type == SHT_SYMTAB || i == hdr->e_shstrndx)
+			sechdrs[i].sh_flags |= SHF_ALLOC;
+#endif
 #ifndef CONFIG_MODULE_UNLOAD
 		/* Don't load .exit sections */
 		if (strstr(secstrings+sechdrs[i].sh_name, ".exit"))
@@ -1138,6 +1143,11 @@ static struct module *load_module(void *
 			goto cleanup;
 	}
 
+#ifdef CONFIG_KALLSYMS
+	mod->symtab = (void *)sechdrs[symindex].sh_offset;
+	mod->num_syms = sechdrs[symindex].sh_size / sizeof(Elf_Sym);
+	mod->strtab = (void *)sechdrs[strindex].sh_offset;
+#endif
 	err = module_finalize(hdr, sechdrs, mod);
 	if (err < 0)
 		goto cleanup;
@@ -1252,9 +1262,82 @@ sys_init_module(void *umod,
 	return 0;
 }
 
-/* Called by the /proc file system to return a current list of
-   modules.  Al Viro came up with this interface as an "improvement".
-   God save us from any more such interface improvements. */
+#ifdef CONFIG_KALLSYMS
+static inline int inside_init(struct module *mod, unsigned long addr)
+{
+	if (mod->module_init
+	    && (unsigned long)mod->module_init <= addr
+	    && (unsigned long)mod->module_init + mod->init_size > addr)
+		return 1;
+	return 0;
+}
+
+static inline int inside_core(struct module *mod, unsigned long addr)
+{
+	if ((unsigned long)mod->module_core <= addr
+	    && (unsigned long)mod->module_core + mod->core_size > addr)
+		return 1;
+	return 0;
+}
+
+static const char *get_ksymbol(struct module *mod,
+			       unsigned long addr,
+			       unsigned long *size,
+			       unsigned long *offset)
+{
+	unsigned int i, next = 0, best = 0;
+
+	/* Scan for closest preceeding symbol, and next symbol. (ELF
+           starts real symbols at 1). */
+	for (i = 1; i < mod->num_syms; i++) {
+		if (mod->symtab[i].st_shndx == SHN_UNDEF)
+			continue;
+
+		if (mod->symtab[i].st_value <= addr
+		    && mod->symtab[i].st_value > mod->symtab[best].st_value)
+			best = i;
+		if (mod->symtab[i].st_value > addr
+		    && mod->symtab[i].st_value < mod->symtab[next].st_value)
+			next = i;
+	}
+
+	if (!best)
+		return NULL;
+
+	if (!next) {
+		/* Last symbol?  It ends at the end of the module then. */
+		if (inside_core(mod, addr))
+			*size = mod->module_core+mod->core_size - (void*)addr;
+		else
+			*size = mod->module_init+mod->init_size - (void*)addr;
+	} else
+		*size = mod->symtab[next].st_value - addr;
+
+	*offset = addr - mod->symtab[best].st_value;
+	return mod->strtab + mod->symtab[best].st_name;
+}
+
+/* For kallsyms to ask for address resolution.  NULL means not found.
+   We don't lock, as this is used for oops resolution and races are a
+   lesser concern. */
+const char *module_address_lookup(unsigned long addr,
+				  unsigned long *size,
+				  unsigned long *offset,
+				  char **modname)
+{
+	struct module *mod;
+
+	list_for_each_entry(mod, &modules, list) {
+		if (inside_core(mod, addr) || inside_init(mod, addr)) {
+			*modname = mod->name;
+			return get_ksymbol(mod, addr, size, offset);
+		}
+	}
+	return NULL;
+}
+#endif /* CONFIG_KALLSYMS */
+
+/* Called by the /proc file system to return a list of modules. */
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct list_head *i;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7287-linux-2.5.46/scripts/kallsyms .7287-linux-2.5.46.updated/scripts/kallsyms
--- .7287-linux-2.5.46/scripts/kallsyms	1970-01-01 10:00:00.000000000 +1000
+++ .7287-linux-2.5.46.updated/scripts/kallsyms	2002-11-05 11:13:11.000000000 +1100
@@ -0,0 +1,40 @@
+#! /bin/sh
+# Written by Rusty Russell <rusty@rustcorp.com.au> 2002.
+
+if [ $# -ne 2 ]; then
+    echo Usage: kallsyms vmlinux objfile >&2
+
+    echo Adds a .kallsyms section containing symbol info.
+    exit 1
+fi
+
+set -e
+
+# Clean up on exit.
+trap "rm -f kallsyms.map kallsyms.c $2" 0
+
+# Takes nm output from $1, produces a .c file on standard output.
+encode_symbols()
+{
+    # First take addresses.
+    echo "unsigned long kallsyms_addresses[] = {"
+    sed 's/^[	]*\([A-Fa-f0-9]*\).*/0x\1UL,/' < $1
+    echo "};"
+
+    # Now output size.
+    echo "unsigned long kallsyms_num_syms = `wc -l < $1`;"
+
+    # Now output names.
+    echo "char kallsyms_names[] = ";
+    sed 's/^[         ]*[A-Fa-f0-9]*[         ]*.[    ]\(.*\)/"\1\\0"/' < $1
+    echo ";"
+}
+
+# FIXME: Use System.map as input, and regenerate each time in Makefile.
+$NM $1 | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > kallsyms.map
+
+encode_symbols kallsyms.map > kallsyms.c
+$CC $CFLAGS -c -o $2 kallsyms.c
+
+trap "rm -f kallsyms.map kallsyms.c" 0
+exit 0

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

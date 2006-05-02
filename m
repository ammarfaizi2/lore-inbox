Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWEBPEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWEBPEy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWEBPEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:04:54 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:18114 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S964865AbWEBPEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:04:53 -0400
Subject: [patch 1/17] Infrastructure to mark exported symbols as
	unused-for-removal-soon
From: Arjan van de Ven <arjan@linux.intel.com>
To: akpm@osdl.org
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 02 May 2006 16:53:07 +0200
Message-Id: <1146581587.32045.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
As discussed on lkml before; the patch with the infrastructure to deprecate unused symbols

This is patch one in a series of 17; to not overload lkml the other 16 will be mailed direct;
people who want to see them all can see them at http://www.fenrus.org/unused





This patch temporarily adds EXPORT_UNUSED_SYMBOL and EXPORT_UNUSED_SYMBOL_GPL.
These will be used as transition measure for symbols that aren't used in the 
kernel and are on the way out. When a module uses such a symbol, a warning
is printk'd at modprobe time.

The main reason for removing unused exports is size: eacho export takes roughly
between 100 and 150 bytes of kernel space in the binary. This patch gives
users the option to immediately get this size gain via a config option.

It would be nice to at least get this infrastructure into 2.6.17 even if
the rest of this series won't get there.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 Documentation/feature-removal-schedule.txt |   10 +++
 include/asm-generic/vmlinux.lds.h          |   28 ++++++++++
 include/linux/module.h                     |   20 +++++++
 kernel/module.c                            |   79 +++++++++++++++++++++++++++--
 lib/Kconfig.debug                          |   14 +++++
 5 files changed, 148 insertions(+), 3 deletions(-)

Index: linux-2.6.17-rc3-mm1-unused/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.17-rc3-mm1-unused.orig/Documentation/feature-removal-schedule.txt
+++ linux-2.6.17-rc3-mm1-unused/Documentation/feature-removal-schedule.txt
@@ -22,6 +22,16 @@ Who:	Adrian Bunk <bunk@stusta.de>
 
 ---------------------------
 
+What:	Unused EXPORT_SYMBOL/EXPORT_SYMBOL_GPL exports
+	(temporary transition config option provided until then)
+	The transition config option will also be removed at the same time.
+When:	before 2.6.19
+Why:	Unused symbols are both increasing the size of the kernel binary
+	and are often a sign of "wrong API"
+Who:	Arjan van de Ven <arjan@linux.intel.com>
+
+---------------------------
+
 What:	RCU API moves to EXPORT_SYMBOL_GPL
 When:	April 2006
 Files:	include/linux/rcupdate.h, kernel/rcupdate.c
Index: linux-2.6.17-rc3-mm1-unused/include/asm-generic/vmlinux.lds.h
===================================================================
--- linux-2.6.17-rc3-mm1-unused.orig/include/asm-generic/vmlinux.lds.h
+++ linux-2.6.17-rc3-mm1-unused/include/asm-generic/vmlinux.lds.h
@@ -58,6 +58,20 @@
 		VMLINUX_SYMBOL(__stop___ksymtab_gpl) = .;		\
 	}								\
 									\
+	/* Kernel symbol table: Normal unused symbols */		\
+	__ksymtab_unused  : AT(ADDR(__ksymtab_unused) - LOAD_OFFSET) {	\
+		VMLINUX_SYMBOL(__start___ksymtab_unused) = .;		\
+		*(__ksymtab_unused)					\
+		VMLINUX_SYMBOL(__stop___ksymtab_unused) = .;		\
+	}								\
+									\
+	/* Kernel symbol table: GPL-only unused symbols */		\
+	__ksymtab_unused_gpl : AT(ADDR(__ksymtab_unused_gpl) - LOAD_OFFSET) { \
+		VMLINUX_SYMBOL(__start___ksymtab_unused_gpl) = .;	\
+		*(__ksymtab_unused_gpl)					\
+		VMLINUX_SYMBOL(__stop___ksymtab_unused_gpl) = .;	\
+	}								\
+									\
 	/* Kernel symbol table: GPL-future-only symbols */		\
 	__ksymtab_gpl_future : AT(ADDR(__ksymtab_gpl_future) - LOAD_OFFSET) { \
 		VMLINUX_SYMBOL(__start___ksymtab_gpl_future) = .;	\
@@ -79,6 +93,20 @@
 		VMLINUX_SYMBOL(__stop___kcrctab_gpl) = .;		\
 	}								\
 									\
+	/* Kernel symbol table: Normal unused symbols */		\
+	__kcrctab_unused  : AT(ADDR(__kcrctab_unused) - LOAD_OFFSET) {	\
+		VMLINUX_SYMBOL(__start___kcrctab_unused) = .;		\
+		*(__kcrctab_unused)					\
+		VMLINUX_SYMBOL(__stop___kcrctab_unused) = .;		\
+	}								\
+									\
+	/* Kernel symbol table: GPL-only unused symbols */		\
+	__kcrctab_unused_gpl : AT(ADDR(__kcrctab_unused_gpl) - LOAD_OFFSET) { \
+		VMLINUX_SYMBOL(__start___kcrctab_unused_gpl) = .;	\
+		*(__kcrctab_unused_gpl)					\
+		VMLINUX_SYMBOL(__stop___kcrctab_unused_gpl) = .;	\
+	}								\
+									\
 	/* Kernel symbol table: GPL-future-only symbols */		\
 	__kcrctab_gpl_future : AT(ADDR(__kcrctab_gpl_future) - LOAD_OFFSET) { \
 		VMLINUX_SYMBOL(__start___kcrctab_gpl_future) = .;	\
Index: linux-2.6.17-rc3-mm1-unused/include/linux/module.h
===================================================================
--- linux-2.6.17-rc3-mm1-unused.orig/include/linux/module.h
+++ linux-2.6.17-rc3-mm1-unused/include/linux/module.h
@@ -204,6 +204,15 @@ void *__symbol_get_gpl(const char *symbo
 #define EXPORT_SYMBOL_GPL_FUTURE(sym)				\
 	__EXPORT_SYMBOL(sym, "_gpl_future")
 
+
+#ifdef CONFIG_UNUSED_SYMBOLS
+#define EXPORT_UNUSED_SYMBOL(sym) __EXPORT_SYMBOL(sym, "_unused")
+#define EXPORT_UNUSED_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_unused_gpl")
+#else
+#define EXPORT_UNUSED_SYMBOL(sym)
+#define EXPORT_UNUSED_SYMBOL_GPL(sym)
+#endif
+
 #endif
 
 struct module_ref
@@ -278,6 +287,15 @@ struct module
 	unsigned int num_gpl_syms;
 	const unsigned long *gpl_crcs;
 
+	/* unused exported symbols. */
+	const struct kernel_symbol *unused_syms;
+	unsigned int num_unused_syms;
+	const unsigned long *unused_crcs;
+	/* GPL-only, unused exported symbols. */
+	const struct kernel_symbol *unused_gpl_syms;
+	unsigned int num_unused_gpl_syms;
+	const unsigned long *unused_gpl_crcs;
+
 	/* symbols that will be GPL-only in the near future. */
 	const struct kernel_symbol *gpl_future_syms;
 	unsigned int num_gpl_future_syms;
@@ -470,6 +488,8 @@ void module_remove_driver(struct device_
 #define EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym)
 #define EXPORT_SYMBOL_GPL_FUTURE(sym)
+#define EXPORT_UNUSED_SYMBOL(sym)
+#define EXPORT_UNUSED_SYMBOL_GPL(sym)
 
 /* Given an address, look for it in the exception tables. */
 static inline const struct exception_table_entry *
Index: linux-2.6.17-rc3-mm1-unused/kernel/module.c
===================================================================
--- linux-2.6.17-rc3-mm1-unused.orig/kernel/module.c
+++ linux-2.6.17-rc3-mm1-unused/kernel/module.c
@@ -1,4 +1,4 @@
-/* Rewritten by Rusty Russell, on the backs of many others...
+/*
    Copyright (C) 2002 Richard Henderson
    Copyright (C) 2001 Rusty Russell, 2002 Rusty Russell IBM.
 
@@ -120,9 +120,17 @@ extern const struct kernel_symbol __star
 extern const struct kernel_symbol __stop___ksymtab_gpl[];
 extern const struct kernel_symbol __start___ksymtab_gpl_future[];
 extern const struct kernel_symbol __stop___ksymtab_gpl_future[];
+extern const struct kernel_symbol __start___ksymtab_unused[];
+extern const struct kernel_symbol __stop___ksymtab_unused[];
+extern const struct kernel_symbol __start___ksymtab_unused_gpl[];
+extern const struct kernel_symbol __stop___ksymtab_unused_gpl[];
+extern const struct kernel_symbol __start___ksymtab_gpl_future[];
+extern const struct kernel_symbol __stop___ksymtab_gpl_future[];
 extern const unsigned long __start___kcrctab[];
 extern const unsigned long __start___kcrctab_gpl[];
 extern const unsigned long __start___kcrctab_gpl_future[];
+extern const unsigned long __start___kcrctab_unused[];
+extern const unsigned long __start___kcrctab_unused_gpl[];
 
 #ifndef CONFIG_MODVERSIONS
 #define symversion(base, idx) NULL
@@ -142,6 +150,17 @@ static const struct kernel_symbol *looku
 	return NULL;
 }
 
+static void printk_unused_warning(const char *name)
+{
+	printk(KERN_WARNING "Symbol %s is marked as UNUSED, "
+		"however this module is using it. \n", name);
+	printk(KERN_WARNING "This symbol will go away in the future.\n");
+	printk(KERN_WARNING "Please evalute if this is the right api to use, "
+		"and if it really is, submit a report the linux kernel "
+		"mailinglist together with submitting your code for "
+		"inclusion.\n");
+}
+
 /* Find a symbol, return value, crc and module which owns it */
 static unsigned long __find_symbol(const char *name,
 				   struct module **owner,
@@ -184,6 +203,25 @@ static unsigned long __find_symbol(const
 		return ks->value;
 	}
 
+	ks = lookup_symbol(name, __start___ksymtab_unused,
+				 __stop___ksymtab_unused);
+	if (ks) {
+		printk_unused_warning(name);
+		*crc = symversion(__start___kcrctab_unused,
+				  (ks - __start___ksymtab_unused));
+		return ks->value;
+	}
+
+	if (gplok)
+		ks = lookup_symbol(name, __start___ksymtab_unused_gpl,
+				 __stop___ksymtab_unused_gpl);
+	if (ks) {
+		printk_unused_warning(name);
+		*crc = symversion(__start___kcrctab_unused_gpl,
+				  (ks - __start___ksymtab_unused_gpl));
+		return ks->value;
+	}
+
 	/* Now try modules. */ 
 	list_for_each_entry(mod, &modules, list) {
 		*owner = mod;
@@ -202,6 +240,23 @@ static unsigned long __find_symbol(const
 				return ks->value;
 			}
 		}
+		ks = lookup_symbol(name, mod->unused_syms, mod->unused_syms + mod->num_unused_syms);
+		if (ks) {
+			printk_unused_warning(name);
+			*crc = symversion(mod->unused_crcs, (ks - mod->unused_syms));
+			return ks->value;
+		}
+
+		if (gplok) {
+			ks = lookup_symbol(name, mod->unused_gpl_syms,
+					   mod->unused_gpl_syms + mod->num_unused_gpl_syms);
+			if (ks) {
+				printk_unused_warning(name);
+				*crc = symversion(mod->unused_gpl_crcs,
+						  (ks - mod->unused_gpl_syms));
+				return ks->value;
+			}
+		}
 		ks = lookup_symbol(name, mod->gpl_future_syms,
 				   (mod->gpl_future_syms +
 				    mod->num_gpl_future_syms));
@@ -1449,7 +1504,8 @@ static struct module *load_module(void _
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
 		crcindex, gplcrcindex, versindex, pcpuindex, gplfutureindex,
-		gplfuturecrcindex;
+		gplfuturecrcindex, unusedindex, unusedcrcindex, unusedgplindex,
+		unusedgplcrcindex;
 	struct module *mod;
 	long err = 0;
 	void *percpu = NULL, *ptr = NULL; /* Stops spurious gcc warning */
@@ -1530,9 +1586,13 @@ static struct module *load_module(void _
 	exportindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab");
 	gplindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab_gpl");
 	gplfutureindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab_gpl_future");
+	unusedindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab_unused");
+	unusedgplindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab_unused_gpl");
 	crcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab");
 	gplcrcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab_gpl");
 	gplfuturecrcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab_gpl_future");
+	unusedcrcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab_unused");
+	unusedgplcrcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab_unused_gpl");
 	setupindex = find_sec(hdr, sechdrs, secstrings, "__param");
 	exindex = find_sec(hdr, sechdrs, secstrings, "__ex_table");
 	obsparmindex = find_sec(hdr, sechdrs, secstrings, "__obsparm");
@@ -1676,14 +1736,27 @@ static struct module *load_module(void _
 		mod->gpl_crcs = (void *)sechdrs[gplcrcindex].sh_addr;
 	mod->num_gpl_future_syms = sechdrs[gplfutureindex].sh_size /
 					sizeof(*mod->gpl_future_syms);
+	mod->num_unused_syms = sechdrs[unusedindex].sh_size /
+					sizeof(*mod->unused_syms);
+	mod->num_unused_gpl_syms = sechdrs[unusedgplindex].sh_size /
+					sizeof(*mod->unused_gpl_syms);
 	mod->gpl_future_syms = (void *)sechdrs[gplfutureindex].sh_addr;
 	if (gplfuturecrcindex)
 		mod->gpl_future_crcs = (void *)sechdrs[gplfuturecrcindex].sh_addr;
 
+	mod->unused_syms = (void *)sechdrs[unusedindex].sh_addr;
+	if (unusedcrcindex)
+		mod->unused_crcs = (void *)sechdrs[unusedcrcindex].sh_addr;
+	mod->unused_gpl_syms = (void *)sechdrs[unusedgplindex].sh_addr;
+	if (unusedgplcrcindex)
+		mod->unused_crcs = (void *)sechdrs[unusedgplcrcindex].sh_addr;
+
 #ifdef CONFIG_MODVERSIONS
 	if ((mod->num_syms && !crcindex) || 
 	    (mod->num_gpl_syms && !gplcrcindex) ||
-	    (mod->num_gpl_future_syms && !gplfuturecrcindex)) {
+	    (mod->num_gpl_future_syms && !gplfuturecrcindex) ||
+	    (mod->num_unused_syms && !unusedcrcindex) ||
+	    (mod->num_unused_gpl_syms && !unusedgplcrcindex)) {
 		printk(KERN_WARNING "%s: No versions for exported symbols."
 		       " Tainting kernel.\n", mod->name);
 		add_taint(TAINT_FORCED_MODULE);
Index: linux-2.6.17-rc3-mm1-unused/lib/Kconfig.debug
===================================================================
--- linux-2.6.17-rc3-mm1-unused.orig/lib/Kconfig.debug
+++ linux-2.6.17-rc3-mm1-unused/lib/Kconfig.debug
@@ -32,6 +32,20 @@ config DEBUG_SHIRQ
 	 to be able to handle interrupts coming in at those points; some don't and
 	 need to be caught.
 
+config UNUSED_SYMBOLS
+	bool "Enable unused/obsolete exported symbols"
+	help
+	  Unused but exported symbols make the kernel needlessly bigger. For that
+	  reason most of these unused exports will soon be removed. This option is
+	  provided temporarily to provide a transition period in case some external
+	  kernel module needs one of these symbols anyway. If you encounter such
+	  a case in your module, consider if you are actually using the right API.
+	  (rationale: since nobody in the kernel is using this in a module, there is
+	  a pretty good chance it's actually the wrong interface to use)
+	  If you really need the symbol, please send a mail to the linux kernel
+	  mailing list mentioning the symbol and why you really need it, and what
+	  the merge plan to the mainline kernel for your module is.
+
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help


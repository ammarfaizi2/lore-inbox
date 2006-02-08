Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030558AbWBHGUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558AbWBHGUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030560AbWBHGUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:20:43 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:25306
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030558AbWBHGUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:20:17 -0500
Date: Tue, 7 Feb 2006 22:20:07 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] EXPORT_SYMBOL_GPL_FUTURE()
Message-ID: <20060208062007.GA7936@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we don't have a way to show people that some kernel symbols
will be changed in the future from EXPORT_SYMBOL() to
EXPORT_SYMBOL_GPL().  As we all know, not everyone reads the
Documentation/feature_removal.txt file, so we need a bigger way to
remind people.

So, here's a patch that implements EXPORT_SYMBOL_GPL_FUTURE().  It
basically says that some time in the future, this symbol is going to
change and not be allowed to be called from non-GPL licensed kernel
modules.

Now I'm not wed to the name, so if anyone else has a better suggestion
as to what to call this, please let me know.  I also feel that the text
that is spit out to the kernel log is a bit stilted, so again,
suggestions welcome.

Comments?

I only implemented this for those arches and sub-arches that use the
asm-generic/vmlinux.lds.h file.  I think there are still a few others
out there that do not do this, so I'll have to fix them up too for the
final version of this patch.

thanks,

greg k-h


---------------------
From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] add EXPORT_SYMBOL_GPL_FUTURE()

This patch adds the ability to mark symbols that will be changed in the
future, so that non-GPL usage of them is flagged by the kernel and
printed out to the system log.


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 include/asm-generic/vmlinux.lds.h |   14 ++++++++++++
 include/linux/module.h            |    8 +++++++
 kernel/module.c                   |   36 +++++++++++++++++++++++++++++++--

--- gregkh-2.6.orig/include/asm-generic/vmlinux.lds.h
+++ gregkh-2.6/include/asm-generic/vmlinux.lds.h
@@ -58,6 +58,13 @@
 		VMLINUX_SYMBOL(__stop___ksymtab_gpl) = .;		\
 	}								\
 									\
+	/* Kernel symbol table: GPL-future-only symbols */		\
+	__ksymtab_gpl_future : AT(ADDR(__ksymtab_gpl_future) - LOAD_OFFSET) {	\
+		VMLINUX_SYMBOL(__start___ksymtab_gpl_future) = .;	\
+		*(__ksymtab_gpl_future)					\
+		VMLINUX_SYMBOL(__stop___ksymtab_gpl_future) = .;	\
+	}								\
+									\
 	/* Kernel symbol table: Normal symbols */			\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start___kcrctab) = .;			\
@@ -72,6 +79,13 @@
 		VMLINUX_SYMBOL(__stop___kcrctab_gpl) = .;		\
 	}								\
 									\
+	/* Kernel symbol table: GPL-only symbols */			\
+	__kcrctab_gpl_future : AT(ADDR(__kcrctab_gpl_future) - LOAD_OFFSET) {	\
+		VMLINUX_SYMBOL(__start___kcrctab_gpl_future) = .;	\
+		*(__kcrctab_gpl_future)					\
+		VMLINUX_SYMBOL(__stop___kcrctab_gpl_future) = .;	\
+	}								\
+									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
--- gregkh-2.6.orig/include/linux/module.h
+++ gregkh-2.6/include/linux/module.h
@@ -198,6 +198,9 @@ void *__symbol_get_gpl(const char *symbo
 #define EXPORT_SYMBOL_GPL(sym)					\
 	__EXPORT_SYMBOL(sym, "_gpl")
 
+#define EXPORT_SYMBOL_GPL_FUTURE(sym)				\
+	__EXPORT_SYMBOL(sym, "_gpl_future")
+
 #endif
 
 struct module_ref
@@ -255,6 +258,11 @@ struct module
 	unsigned int num_gpl_syms;
 	const unsigned long *gpl_crcs;
 
+	/* symbols that will be GPL-only in the near future. */
+	const struct kernel_symbol *gpl_future_syms;
+	unsigned int num_gpl_future_syms;
+	const unsigned long *gpl_future_crcs;
+
 	/* Exception table */
 	unsigned int num_exentries;
 	const struct exception_table_entry *extable;
--- gregkh-2.6.orig/kernel/module.c
+++ gregkh-2.6/kernel/module.c
@@ -126,8 +126,11 @@ extern const struct kernel_symbol __star
 extern const struct kernel_symbol __stop___ksymtab[];
 extern const struct kernel_symbol __start___ksymtab_gpl[];
 extern const struct kernel_symbol __stop___ksymtab_gpl[];
+extern const struct kernel_symbol __start___ksymtab_gpl_future[];
+extern const struct kernel_symbol __stop___ksymtab_gpl_future[];
 extern const unsigned long __start___kcrctab[];
 extern const unsigned long __start___kcrctab_gpl[];
+extern const unsigned long __start___kcrctab_gpl_future[];
 
 #ifndef CONFIG_MODVERSIONS
 #define symversion(base, idx) NULL
@@ -159,6 +162,16 @@ static unsigned long __find_symbol(const
 				return __start___ksymtab_gpl[i].value;
 			}
 	}
+	for (i = 0; __start___ksymtab_gpl_future+i < __stop___ksymtab_gpl_future; i++) {
+		if (strcmp(__start___ksymtab_gpl_future[i].name, name) == 0) {
+			*crc = symversion(__start___kcrctab_gpl_future, i);
+			if (!gplok)
+				printk(KERN_WARNING "symbol %s is being used "
+					"by a non-GPL module, which will not "
+					"be allowed in the future\n", name);
+			return __start___ksymtab_gpl_future[i].value;
+		}
+	}
 
 	/* Now try modules. */ 
 	list_for_each_entry(mod, &modules, list) {
@@ -177,6 +190,16 @@ static unsigned long __find_symbol(const
 				}
 			}
 		}
+		for (i = 0; i < mod->num_gpl_future_syms; i++) {
+			if (strcmp(mod->gpl_future_syms[i].name, name) == 0) {
+				*crc = symversion(mod->gpl_future_crcs, i);
+				if (!gplok)
+					printk(KERN_WARNING "symbol %s is being used "
+						"by a non-GPL module, which will not "
+						"be allowed in the future\n", name);
+				return mod->gpl_future_syms[i].value;
+			}
+		}
 	}
 	DEBUGP("Failed to find symbol %s\n", name);
  	return 0;
@@ -1537,7 +1560,8 @@ static struct module *load_module(void _
 	char *secstrings, *args, *modmagic, *strtab = NULL;
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
-		crcindex, gplcrcindex, versindex, pcpuindex;
+		crcindex, gplcrcindex, versindex, pcpuindex, gplfutureindex,
+		gplfuturecrcindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -1618,8 +1642,10 @@ static struct module *load_module(void _
 	/* Optional sections */
 	exportindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab");
 	gplindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab_gpl");
+	gplfutureindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab_gpl_future");
 	crcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab");
 	gplcrcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab_gpl");
+	gplfuturecrcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab_gpl_future");
 	setupindex = find_sec(hdr, sechdrs, secstrings, "__param");
 	exindex = find_sec(hdr, sechdrs, secstrings, "__ex_table");
 	obsparmindex = find_sec(hdr, sechdrs, secstrings, "__obsparm");
@@ -1772,10 +1798,16 @@ static struct module *load_module(void _
 	mod->gpl_syms = (void *)sechdrs[gplindex].sh_addr;
 	if (gplcrcindex)
 		mod->gpl_crcs = (void *)sechdrs[gplcrcindex].sh_addr;
+	mod->num_gpl_future_syms = sechdrs[gplfutureindex].sh_size /
+					sizeof(*mod->gpl_future_syms);
+	mod->gpl_future_syms = (void *)sechdrs[gplfutureindex].sh_addr;
+	if (gplfuturecrcindex)
+		mod->gpl_future_crcs = (void *)sechdrs[gplfuturecrcindex].sh_addr;
 
 #ifdef CONFIG_MODVERSIONS
 	if ((mod->num_syms && !crcindex) || 
-	    (mod->num_gpl_syms && !gplcrcindex)) {
+	    (mod->num_gpl_syms && !gplcrcindex) ||
+	    (mod->num_gpl_future_syms && !gplfuturecrcindex)) {
 		printk(KERN_WARNING "%s: No versions for exported symbols."
 		       " Tainting kernel.\n", mod->name);
 		add_taint(TAINT_FORCED_MODULE);

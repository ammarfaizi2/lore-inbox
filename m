Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030552AbWCTWCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbWCTWCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbWCTWBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:60345 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030542AbWCTWBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:16 -0500
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 09/23] add EXPORT_SYMBOL_GPL_FUTURE()
In-Reply-To: <11428920381135-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <11428920383496-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ability to mark symbols that will be changed in the
future, so that kernel modules that don't include MODULE_LICENSE("GPL")
and use the symbols, will be flagged and printed out to the system log.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 arch/m68knommu/kernel/vmlinux.lds.S |   10 ++++
 arch/v850/kernel/vmlinux.lds.S      |    8 +++
 include/asm-generic/vmlinux.lds.h   |   14 +++++
 include/linux/module.h              |    9 +++
 kernel/module.c                     |   49 ++++++++++++++++++-
 scripts/genksyms/keywords.c_shipped |   91 ++++++++++++++++++-----------------
 scripts/genksyms/keywords.gperf     |    1 
 7 files changed, 135 insertions(+), 47 deletions(-)

9f28bb7e1d0188a993403ab39b774785892805e1
diff --git a/arch/m68knommu/kernel/vmlinux.lds.S b/arch/m68knommu/kernel/vmlinux.lds.S
index ac9de26..a331cc9 100644
--- a/arch/m68knommu/kernel/vmlinux.lds.S
+++ b/arch/m68knommu/kernel/vmlinux.lds.S
@@ -269,6 +269,11 @@ SECTIONS {
 		*(__ksymtab_gpl)
 		__stop___ksymtab_gpl = .;
 
+		/* Kernel symbol table: GPL-future symbols */
+		__start___ksymtab_gpl_future = .;
+		*(__ksymtab_gpl_future)
+		__stop___ksymtab_gpl_future = .;
+
 		/* Kernel symbol table: Normal symbols */
 		__start___kcrctab = .;
 		*(__kcrctab)
@@ -279,6 +284,11 @@ SECTIONS {
 		*(__kcrctab_gpl)
 		__stop___kcrctab_gpl = .;
 
+		/* Kernel symbol table: GPL-future symbols */
+		__start___kcrctab_gpl_future = .;
+		*(__kcrctab_gpl_future)
+		__stop___kcrctab_gpl_future = .;
+
 		/* Kernel symbol table: strings */
 		*(__ksymtab_strings)
 
diff --git a/arch/v850/kernel/vmlinux.lds.S b/arch/v850/kernel/vmlinux.lds.S
index 5be05f4..5b2ffcc 100644
--- a/arch/v850/kernel/vmlinux.lds.S
+++ b/arch/v850/kernel/vmlinux.lds.S
@@ -64,6 +64,10 @@
 		___start___ksymtab_gpl = .;				      \
 			*(__ksymtab_gpl)				      \
 		___stop___ksymtab_gpl = .;				      \
+		/* Kernel symbol table: GPL-future symbols */		      \
+		___start___ksymtab_gpl_future = .;			      \
+			*(__ksymtab_gpl_future)				      \
+		___stop___ksymtab_gpl_future = .;			      \
 		/* Kernel symbol table: strings */			      \
 			*(__ksymtab_strings)				      \
 		/* Kernel symbol table: Normal symbols */		      \
@@ -74,6 +78,10 @@
 		___start___kcrctab_gpl = .;				      \
 			*(__kcrctab_gpl)				      \
 		___stop___kcrctab_gpl = .;				      \
+		/* Kernel symbol table: GPL-future symbols */		      \
+		___start___kcrctab_gpl_future = .;			      \
+			*(__kcrctab_gpl_future)				      \
+		___stop___kcrctab_gpl_future = .;			      \
 		/* Built-in module parameters */			      \
 		. = ALIGN (4) ;						      \
 		___start___param = .;					      \
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 35de20c..9d11550 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -58,6 +58,13 @@
 		VMLINUX_SYMBOL(__stop___ksymtab_gpl) = .;		\
 	}								\
 									\
+	/* Kernel symbol table: GPL-future-only symbols */		\
+	__ksymtab_gpl_future : AT(ADDR(__ksymtab_gpl_future) - LOAD_OFFSET) { \
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
+	/* Kernel symbol table: GPL-future-only symbols */		\
+	__kcrctab_gpl_future : AT(ADDR(__kcrctab_gpl_future) - LOAD_OFFSET) { \
+		VMLINUX_SYMBOL(__start___kcrctab_gpl_future) = .;	\
+		*(__kcrctab_gpl_future)					\
+		VMLINUX_SYMBOL(__stop___kcrctab_gpl_future) = .;	\
+	}								\
+									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
diff --git a/include/linux/module.h b/include/linux/module.h
index 84d75f3..a25d5f6 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
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
@@ -441,6 +449,7 @@ void module_remove_driver(struct device_
 #else /* !CONFIG_MODULES... */
 #define EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym)
+#define EXPORT_SYMBOL_GPL_FUTURE(sym)
 
 /* Given an address, look for it in the exception tables. */
 static inline const struct exception_table_entry *
diff --git a/kernel/module.c b/kernel/module.c
index 2a892b2..5ca99fb 100644
--- a/kernel/module.c
+++ b/kernel/module.c
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
@@ -172,6 +175,22 @@ static unsigned long __find_symbol(const
 			return ks->value;
 		}
 	}
+	ks = lookup_symbol(name, __start___ksymtab_gpl_future,
+				 __stop___ksymtab_gpl_future);
+	if (ks) {
+		if (!gplok) {
+			printk(KERN_WARNING "Symbol %s is being used "
+			       "by a non-GPL module, which will not "
+			       "be allowed in the future\n", name);
+			printk(KERN_WARNING "Please see the file "
+			       "Documentation/feature-removal-schedule.txt "
+			       "in the kernel source tree for more "
+			       "details.\n");
+		}
+		*crc = symversion(__start___kcrctab_gpl_future,
+				  (ks - __start___ksymtab_gpl_future));
+		return ks->value;
+	}
 
 	/* Now try modules. */ 
 	list_for_each_entry(mod, &modules, list) {
@@ -191,6 +210,23 @@ static unsigned long __find_symbol(const
 				return ks->value;
 			}
 		}
+		ks = lookup_symbol(name, mod->gpl_future_syms,
+				   (mod->gpl_future_syms +
+				    mod->num_gpl_future_syms));
+		if (ks) {
+			if (!gplok) {
+				printk(KERN_WARNING "Symbol %s is being used "
+				       "by a non-GPL module, which will not "
+				       "be allowed in the future\n", name);
+				printk(KERN_WARNING "Please see the file "
+				       "Documentation/feature-removal-schedule.txt "
+				       "in the kernel source tree for more "
+				       "details.\n");
+			}
+			*crc = symversion(mod->gpl_future_crcs,
+					  (ks - mod->gpl_future_syms));
+			return ks->value;
+		}
 	}
 	DEBUGP("Failed to find symbol %s\n", name);
  	return 0;
@@ -1546,7 +1582,8 @@ static struct module *load_module(void _
 	char *secstrings, *args, *modmagic, *strtab = NULL;
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
 		exportindex, modindex, obsparmindex, infoindex, gplindex,
-		crcindex, gplcrcindex, versindex, pcpuindex;
+		crcindex, gplcrcindex, versindex, pcpuindex, gplfutureindex,
+		gplfuturecrcindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -1627,8 +1664,10 @@ static struct module *load_module(void _
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
@@ -1784,10 +1823,16 @@ static struct module *load_module(void _
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
diff --git a/scripts/genksyms/keywords.c_shipped b/scripts/genksyms/keywords.c_shipped
index ee46478..d8153f5 100644
--- a/scripts/genksyms/keywords.c_shipped
+++ b/scripts/genksyms/keywords.c_shipped
@@ -52,9 +52,9 @@ is_reserved_hash (register const char *s
       71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
       71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
       71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
-      71, 71, 71, 71, 71, 71, 71, 71, 71, 15,
-      71, 71, 71, 71, 71, 71, 15, 71, 71, 71,
-      10, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71,  0,
+      71, 71, 71, 71, 71, 71, 35, 71, 71, 71,
+       5, 71, 71, 71, 71, 71, 71, 71, 71, 71,
       71, 71, 71, 71, 71,  0, 71,  0, 71,  5,
        5,  0, 10, 20, 71, 25, 71, 71, 20,  0,
       20, 30, 25, 71, 10,  5,  0, 20, 15, 71,
@@ -84,9 +84,9 @@ is_reserved_word (register const char *s
 {
   enum
     {
-      TOTAL_KEYWORDS = 41,
+      TOTAL_KEYWORDS = 42,
       MIN_WORD_LENGTH = 3,
-      MAX_WORD_LENGTH = 17,
+      MAX_WORD_LENGTH = 24,
       MIN_HASH_VALUE = 3,
       MAX_HASH_VALUE = 70
     };
@@ -94,104 +94,105 @@ is_reserved_word (register const char *s
   static const struct resword wordlist[] =
     {
       {""}, {""}, {""},
-#line 24 "scripts/genksyms/keywords.gperf"
+#line 25 "scripts/genksyms/keywords.gperf"
       {"asm", ASM_KEYW},
       {""},
-#line 7 "scripts/genksyms/keywords.gperf"
+#line 8 "scripts/genksyms/keywords.gperf"
       {"__asm", ASM_KEYW},
       {""},
-#line 8 "scripts/genksyms/keywords.gperf"
+#line 9 "scripts/genksyms/keywords.gperf"
       {"__asm__", ASM_KEYW},
       {""},
-#line 21 "scripts/genksyms/keywords.gperf"
+#line 22 "scripts/genksyms/keywords.gperf"
       {"_restrict", RESTRICT_KEYW},
-#line 50 "scripts/genksyms/keywords.gperf"
+#line 51 "scripts/genksyms/keywords.gperf"
       {"__typeof__", TYPEOF_KEYW},
-#line 9 "scripts/genksyms/keywords.gperf"
+#line 10 "scripts/genksyms/keywords.gperf"
       {"__attribute", ATTRIBUTE_KEYW},
-#line 11 "scripts/genksyms/keywords.gperf"
+#line 12 "scripts/genksyms/keywords.gperf"
       {"__const", CONST_KEYW},
-#line 10 "scripts/genksyms/keywords.gperf"
+#line 11 "scripts/genksyms/keywords.gperf"
       {"__attribute__", ATTRIBUTE_KEYW},
-#line 12 "scripts/genksyms/keywords.gperf"
+#line 13 "scripts/genksyms/keywords.gperf"
       {"__const__", CONST_KEYW},
-#line 16 "scripts/genksyms/keywords.gperf"
+#line 17 "scripts/genksyms/keywords.gperf"
       {"__signed__", SIGNED_KEYW},
-#line 42 "scripts/genksyms/keywords.gperf"
+#line 43 "scripts/genksyms/keywords.gperf"
       {"static", STATIC_KEYW},
       {""},
-#line 15 "scripts/genksyms/keywords.gperf"
+#line 16 "scripts/genksyms/keywords.gperf"
       {"__signed", SIGNED_KEYW},
-#line 30 "scripts/genksyms/keywords.gperf"
+#line 31 "scripts/genksyms/keywords.gperf"
       {"char", CHAR_KEYW},
       {""},
-#line 43 "scripts/genksyms/keywords.gperf"
+#line 44 "scripts/genksyms/keywords.gperf"
       {"struct", STRUCT_KEYW},
-#line 22 "scripts/genksyms/keywords.gperf"
-      {"__restrict__", RESTRICT_KEYW},
 #line 23 "scripts/genksyms/keywords.gperf"
+      {"__restrict__", RESTRICT_KEYW},
+#line 24 "scripts/genksyms/keywords.gperf"
       {"restrict", RESTRICT_KEYW},
-#line 33 "scripts/genksyms/keywords.gperf"
+#line 34 "scripts/genksyms/keywords.gperf"
       {"enum", ENUM_KEYW},
-#line 17 "scripts/genksyms/keywords.gperf"
+#line 18 "scripts/genksyms/keywords.gperf"
       {"__volatile", VOLATILE_KEYW},
-#line 34 "scripts/genksyms/keywords.gperf"
+#line 35 "scripts/genksyms/keywords.gperf"
       {"extern", EXTERN_KEYW},
-#line 18 "scripts/genksyms/keywords.gperf"
+#line 19 "scripts/genksyms/keywords.gperf"
       {"__volatile__", VOLATILE_KEYW},
-#line 37 "scripts/genksyms/keywords.gperf"
+#line 38 "scripts/genksyms/keywords.gperf"
       {"int", INT_KEYW},
-      {""},
-#line 31 "scripts/genksyms/keywords.gperf"
-      {"const", CONST_KEYW},
+#line 7 "scripts/genksyms/keywords.gperf"
+      {"EXPORT_SYMBOL_GPL_FUTURE", EXPORT_SYMBOL_KEYW},
 #line 32 "scripts/genksyms/keywords.gperf"
+      {"const", CONST_KEYW},
+#line 33 "scripts/genksyms/keywords.gperf"
       {"double", DOUBLE_KEYW},
       {""},
-#line 13 "scripts/genksyms/keywords.gperf"
+#line 14 "scripts/genksyms/keywords.gperf"
       {"__inline", INLINE_KEYW},
-#line 29 "scripts/genksyms/keywords.gperf"
+#line 30 "scripts/genksyms/keywords.gperf"
       {"auto", AUTO_KEYW},
-#line 14 "scripts/genksyms/keywords.gperf"
+#line 15 "scripts/genksyms/keywords.gperf"
       {"__inline__", INLINE_KEYW},
-#line 41 "scripts/genksyms/keywords.gperf"
+#line 42 "scripts/genksyms/keywords.gperf"
       {"signed", SIGNED_KEYW},
       {""},
-#line 46 "scripts/genksyms/keywords.gperf"
+#line 47 "scripts/genksyms/keywords.gperf"
       {"unsigned", UNSIGNED_KEYW},
       {""},
-#line 40 "scripts/genksyms/keywords.gperf"
+#line 41 "scripts/genksyms/keywords.gperf"
       {"short", SHORT_KEYW},
-#line 49 "scripts/genksyms/keywords.gperf"
+#line 50 "scripts/genksyms/keywords.gperf"
       {"typeof", TYPEOF_KEYW},
-#line 44 "scripts/genksyms/keywords.gperf"
+#line 45 "scripts/genksyms/keywords.gperf"
       {"typedef", TYPEDEF_KEYW},
-#line 48 "scripts/genksyms/keywords.gperf"
+#line 49 "scripts/genksyms/keywords.gperf"
       {"volatile", VOLATILE_KEYW},
       {""},
-#line 35 "scripts/genksyms/keywords.gperf"
+#line 36 "scripts/genksyms/keywords.gperf"
       {"float", FLOAT_KEYW},
       {""}, {""},
-#line 39 "scripts/genksyms/keywords.gperf"
+#line 40 "scripts/genksyms/keywords.gperf"
       {"register", REGISTER_KEYW},
-#line 47 "scripts/genksyms/keywords.gperf"
+#line 48 "scripts/genksyms/keywords.gperf"
       {"void", VOID_KEYW},
       {""},
-#line 36 "scripts/genksyms/keywords.gperf"
+#line 37 "scripts/genksyms/keywords.gperf"
       {"inline", INLINE_KEYW},
       {""},
 #line 5 "scripts/genksyms/keywords.gperf"
       {"EXPORT_SYMBOL", EXPORT_SYMBOL_KEYW},
       {""},
-#line 20 "scripts/genksyms/keywords.gperf"
+#line 21 "scripts/genksyms/keywords.gperf"
       {"_Bool", BOOL_KEYW},
       {""},
 #line 6 "scripts/genksyms/keywords.gperf"
       {"EXPORT_SYMBOL_GPL", EXPORT_SYMBOL_KEYW},
       {""}, {""}, {""}, {""}, {""}, {""},
-#line 38 "scripts/genksyms/keywords.gperf"
+#line 39 "scripts/genksyms/keywords.gperf"
       {"long", LONG_KEYW},
       {""}, {""}, {""}, {""}, {""},
-#line 45 "scripts/genksyms/keywords.gperf"
+#line 46 "scripts/genksyms/keywords.gperf"
       {"union", UNION_KEYW}
     };
 
diff --git a/scripts/genksyms/keywords.gperf b/scripts/genksyms/keywords.gperf
index b6bec76..c75e0c8 100644
--- a/scripts/genksyms/keywords.gperf
+++ b/scripts/genksyms/keywords.gperf
@@ -4,6 +4,7 @@ struct resword { const char *name; int t
 %%
 EXPORT_SYMBOL, EXPORT_SYMBOL_KEYW
 EXPORT_SYMBOL_GPL, EXPORT_SYMBOL_KEYW
+EXPORT_SYMBOL_GPL_FUTURE, EXPORT_SYMBOL_KEYW
 __asm, ASM_KEYW
 __asm__, ASM_KEYW
 __attribute, ATTRIBUTE_KEYW
-- 
1.2.4



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWHXP0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWHXP0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWHXP0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:26:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16557 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965009AbWHXP0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:26:10 -0400
Subject: [PATCH 2/4] Core support for --combine -fwhole-program
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1156429585.3012.58.camel@pmac.infradead.org>
References: <1156429585.3012.58.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 16:26:07 +0100
Message-Id: <1156433167.3012.119.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a config option for COMBINE_COMPILE, adds the __global
tag to compiler.h and makes EXPORT_SYMBOL automatically use it. It also
contains a crappy Makefile hack which uses -fwhole-program --combine for
all multi-obj .o files -- anything which was 
	obj-m := foo.o
	foo-objs := bar.o wibble.o 
... should now use gcc -o foo.o --combine -fwhole-program bar.c wibble.c

The makefile hack is known not to work properly for generated C files in
out-of-source-tree builds, and for multi-obj files where one of the
sources is _assembly_ instead of C. It's good enough for the proof of
concept, until someone more clueful can do it properly though. It would
be useful to make built-in.o build with --combine from _everything_
which uses standard CFLAGS, rather than doing just what I've done here.

For example only; do not apply as-is. 

diff --git a/include/asm-i386/linkage.h b/include/asm-i386/linkage.h
index f4a6eba..8b06e3e 100644
--- a/include/asm-i386/linkage.h
+++ b/include/asm-i386/linkage.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_LINKAGE_H
 #define __ASM_LINKAGE_H
 
-#define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
+#define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0))) __global
 #define FASTCALL(x)	x __attribute__((regparm(3)))
 #define fastcall	__attribute__((regparm(3)))
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 9b4f110..ed4cf0c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -156,4 +156,10 @@ #ifndef __attribute_const__
 # define __attribute_const__	/* unimplemented */
 #endif
 
+#ifdef CONFIG_COMBINED_COMPILE
+#define __global __attribute__((externally_visible,used))
+#else
+#define __global
+#endif
+
 #endif /* __LINUX_COMPILER_H */
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 932021f..d78eec9 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -10,7 +10,7 @@ #define CPP_ASMLINKAGE
 #endif
 
 #ifndef asmlinkage
-#define asmlinkage CPP_ASMLINKAGE
+#define asmlinkage __global CPP_ASMLINKAGE
 #endif
 
 #ifndef prevent_tail_call
diff --git a/include/linux/module.h b/include/linux/module.h
index 0dfb794..725e5df 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -175,7 +175,7 @@ #ifdef CONFIG_MODVERSIONS
 #define __CRC_SYMBOL(sym, sec)					\
 	extern void *__crc_##sym __attribute__((weak));		\
 	static const unsigned long __kcrctab_##sym		\
-	__attribute_used__					\
+	__attribute_used__ __global				\
 	__attribute__((section("__kcrctab" sec), unused))	\
 	= (unsigned long) &__crc_##sym;
 #else
@@ -184,13 +184,15 @@ #endif
 
 /* For every exported symbol, place a struct in the __ksymtab section */
 #define __EXPORT_SYMBOL(sym, sec)				\
-	extern typeof(sym) sym;					\
+	extern typeof(sym) sym __global;		\
 	__CRC_SYMBOL(sym, sec)					\
 	static const char __kstrtab_##sym[]			\
+	asm("__kstrtab_" #sym)					\
 	__attribute__((section("__ksymtab_strings")))		\
 	= MODULE_SYMBOL_PREFIX #sym;                    	\
 	static const struct kernel_symbol __ksymtab_##sym	\
-	__attribute_used__					\
+	asm("__ksymtab_" #sym)					\
+	__attribute_used__ __global				\
 	__attribute__((section("__ksymtab" sec), unused))	\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
@@ -208,8 +210,8 @@ #ifdef CONFIG_UNUSED_SYMBOLS
 #define EXPORT_UNUSED_SYMBOL(sym) __EXPORT_SYMBOL(sym, "_unused")
 #define EXPORT_UNUSED_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_unused_gpl")
 #else
-#define EXPORT_UNUSED_SYMBOL(sym)
-#define EXPORT_UNUSED_SYMBOL_GPL(sym)
+#define EXPORT_UNUSED_SYMBOL(sym) extern typeof(sym) sym  __global
+#define EXPORT_UNUSED_SYMBOL_GPL(sym) extern typeof(sym) sym  __global
 #endif
 
 #endif
@@ -470,11 +472,12 @@ void module_add_driver(struct module *, 
 void module_remove_driver(struct device_driver *);
 
 #else /* !CONFIG_MODULES... */
-#define EXPORT_SYMBOL(sym)
-#define EXPORT_SYMBOL_GPL(sym)
-#define EXPORT_SYMBOL_GPL_FUTURE(sym)
-#define EXPORT_UNUSED_SYMBOL(sym)
-#define EXPORT_UNUSED_SYMBOL_GPL(sym)
+
+#define EXPORT_SYMBOL(sym) extern typeof(sym) sym __global
+#define EXPORT_SYMBOL_GPL(sym) EXPORT_SYMBOL(sym)
+#define EXPORT_SYMBOL_GPL_FUTURE(sym) EXPORT_SYMBOL(sym)
+#define EXPORT_UNUSED_SYMBOL(sym) EXPORT_SYMBOL(sym)
+#define EXPORT_UNUSED_SYMBOL_GPL(sym) EXPORT_SYMBOL(sym)
 
 /* Given an address, look for it in the exception tables. */
 static inline const struct exception_table_entry *
diff --git a/init/Kconfig b/init/Kconfig
index a099fc6..b19cfd1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -468,6 +468,16 @@ config MODULE_FORCE_UNLOAD
 	  rmmod).  This is mainly for kernel developers and desperate users.
 	  If unsure, say N.
 
+config COMBINED_COMPILE
+        bool "Compile multiple source files at once"
+	help
+	  GCC can perform optimisation between different C files by
+	  using its '--combine' option to compile them all at once. By
+	  also adding the '-fwhole-program' option to make global symbols
+	  static, further optimisations are made possible. Say N unless you
+	  have a version of GCC in which at least PR27898, PR28706, PR28712,
+	  PR28744 and PR28779 are fixed.
+	
 config MODVERSIONS
 	bool "Module versioning support"
 	depends on MODULES
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3cb445c..2f2075d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -128,6 +128,12 @@ modname = $(basetarget)
 $(multi-objs-y:.o=.s)   : modname = $(modname-multi)
 $(multi-objs-y:.o=.lst) : modname = $(modname-multi)
 
+ifdef CONFIG_COMBINED_COMPILE
+$(multi-used-m)		: modkern_cflags += $(CFLAGS_MODULE) -fwhole-program --combine $(sort $(addprefix $(srctree)/$(obj)/,$($(subst $(obj)/,,$(@:.o=-y)):.o=.c) $($(subst $(obj)/,,$(@:.o=-objs)):.o=.c)))
+
+$(multi-used-y)		: CFLAGS += -fwhole-program --combine $(sort $(addprefix $(srctree)/$(obj)/,$($(subst $(obj)/,,$(@:.o=-y)):.o=.c) $($(subst $(obj)/,,$(@:.o=-objs)):.o=.c)))
+endif
+
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
 cmd_cc_s_c       = $(CC) $(c_flags) -fverbose-asm -S -o $@ $<
 
@@ -283,6 +289,23 @@ cmd_link_l_target = rm -f $@; $(AR) $(EX
 targets += $(lib-target)
 endif
 
+ifdef CONFIG_COMBINED_COMPILE
+# We would rather have a list of rules like
+# 	foo.o: $(foo-objs)
+# but that's not so easy, so we rather make all composite objects depend
+# on the set of all their parts
+
+$(multi-used-y) : %.o: $(srctree)/dummy.c $(multi-objs-y:.o=.c) FORCE
+	$(call cmd,force_checksrc)
+	$(call if_changed_rule,cc_o_c)
+
+$(multi-used-m) : %.o: $(srctree)/dummy.c $(multi-objs-m:.o=.c) FORCE
+	$(call cmd,force_checksrc)
+	$(call if_changed_rule,cc_o_c)
+	@{ echo $(@:.o=.ko); echo $(link_multi_deps); } > $(MODVERDIR)/$(@F:.o=.mod)
+
+targets += $(multi-used-y) $(multi-used-m)
+else
 #
 # Rule to link composite objects
 #
@@ -313,7 +336,7 @@ # on the set of all their parts
 	@{ echo $(@:.o=.ko); echo $(link_multi_deps); } > $(MODVERDIR)/$(@F:.o=.mod)
 
 targets += $(multi-used-y) $(multi-used-m)
-
+endif
 
 # Descending
 # ---------------------------------------------------------------------------

-- 
dwmw2


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261890AbSIYDXK>; Tue, 24 Sep 2002 23:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbSIYDXK>; Tue, 24 Sep 2002 23:23:10 -0400
Received: from dp.samba.org ([66.70.73.150]:44160 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261890AbSIYDQr>;
	Tue, 24 Sep 2002 23:16:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] Module rewrite 13/20: Module versions
Date: Wed, 25 Sep 2002 13:03:04 +1000
Message-Id: <20020925032201.9CAD52C120@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This does not delete the old CONFIG_MODVERSIONS code: I'll leave
  that to Kai's pleasure, in return for fixing remaining makefile issues.
  You'll note that the export-objs lines in Makefiles should no longer
  be neccessary now. ]

Name: modversions support
Author: Rusty Russell
Status: Tested on 2.5.38
Depends: Module/param-oldstyle.patch.gz
Depends: Misc/2-5-38-fixes.patch.gz

D: This implementes CONFIG_MODVERSIONING (similar to the old
D: CONFIG_MODVERSIONS, but with a separate name for the moment so the
D: two can be clearly separated).
D:
D: The makefiles do not quite work correctly: you have to build using:
D:  make kernel/modversions.o bzImage
D:  make modules
D:
D: The idea is that modules which want to export symbols place their
D: full path name in the .needmodversion section.  Just before the kernel
D: is linked, these names are extracted, and genksyms scans those files to
D: create a version table.  This table is then linked into the kernel.
D:
D: For modules, after they have been built, another pass adds a
D: .versions section to each module containing the version of each
D: undefined symbol in it.
D:
D: These symbol versions are then checked on insmod.  This means that
D: you can insert an unversioned module into a versioned kernel, and
D: vice versa (which taints your kernel).
D:
D: Also, the offensive export-objs defines in Makefiles are now unneccessary.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .3225-linux-2.5.38/Makefile .3225-linux-2.5.38.updated/Makefile
--- .3225-linux-2.5.38/Makefile	2002-09-25 07:34:07.000000000 +1000
+++ .3225-linux-2.5.38.updated/Makefile	2002-09-25 07:34:34.000000000 +1000
@@ -296,6 +296,7 @@ cmd_link_vmlinux = $(LD) $(LDFLAGS) $(LD
 		$(LIBS) \
 		$(DRIVERS) \
 		$(NETWORKS) \
+		$(kernel_modversions) \
 		--end-group \
 		-o vmlinux
 
@@ -314,7 +315,7 @@ endef
 
 LDFLAGS_vmlinux += -T arch/$(ARCH)/vmlinux.lds.s
 
-vmlinux: $(vmlinux-objs) arch/$(ARCH)/vmlinux.lds.s FORCE
+vmlinux: $(vmlinux-objs) $(kernel_modversions) arch/$(ARCH)/vmlinux.lds.s FORCE
 	$(call if_changed_rule,link_vmlinux)
 
 #	The actual objects are generated when descending, 
@@ -424,8 +425,30 @@ depend dep: .hdepend
 	@$(MAKE) include/linux/modversions.h
 	@touch $@
 
-ifdef CONFIG_MODVERSIONS
+ifdef CONFIG_MODVERSIONING
+# Module versions for the kernel:
+kernel_modversions = kernel/modversions.o
 
+quiet_cmd_get_modversions = MODVER      $@
+cmd_get_modversions = $(CONFIG_SHELL) scripts/extract_versions $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) $(vmlinux-objs) >$@
+
+include/linux/generated-modversions.h: $(vmlinux-objs) scripts/extract_versions
+	$(call cmd,get_modversions)
+
+kernel/modversions.o: kernel/modversions.c include/linux/generated-modversions.h
+	$(CC) $(CFLAGS) -c -o $@ $<
+
+# FIXME: We don't version symbols exported by modules --RR
+module_modversions = add_modversions
+
+add_modversions: include/linux/generated-modversions.h $(patsubst %, _addmodver_%, $(SUBDIRS))
+
+$(patsubst %,_addmodver_%,$(SUBDIRS)): FORCE
+	@$(MAKE) -C $(patsubst _addmodver_%, %, $@) add_modversions
+
+endif
+
+ifdef CONFIG_MODVERSIONS
 # 	Update modversions.h, but only if it would change.
 
 include/linux/modversions.h: scripts/fixdep prepare FORCE
@@ -465,7 +488,7 @@ MODFLAGS += -include $(objtree)/include/
 endif
 
 .PHONY: modules
-modules: $(SUBDIRS)
+modules: $(SUBDIRS) $(module_modversions)
 
 #	Install modules
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .3225-linux-2.5.38/Rules.make .3225-linux-2.5.38.updated/Rules.make
--- .3225-linux-2.5.38/Rules.make	2002-09-25 07:34:07.000000000 +1000
+++ .3225-linux-2.5.38.updated/Rules.make	2002-09-25 07:34:34.000000000 +1000
@@ -44,6 +44,13 @@ endif
 obj := .
 src := .
 
+# We insert an extra symbol for modversions on SMP
+ifdef CONFIG_SMP
+modversions_extra = { "__SMP__", 0x01 },
+else
+modversions_extra = { "__SMP__", 0x00 },
+endif
+
 # For use in the quiet output
 
 echo_target = $(RELDIR)/$@
@@ -130,7 +137,7 @@ basename_flags = -DKBUILD_BASENAME=$(sub
 modname_flags  = -DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname)))
 c_flags        = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
 	         $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
-	         $(basename_flags) $(modname_flags) $(export_flags) 
+	         $(basename_flags) $(modname_flags) $(export_flags) -D__DIRNAME__=\"$(CURDIR)\"
 
 # Finds the multi-part object the current object will be linked into
 modname-multi = $(subst $(space),_,$(strip $(foreach m,$(multi-used),\
@@ -271,6 +278,12 @@ first_rule: $(if $(KBUILD_BUILTIN),$(O_T
 	    sub_dirs
 	@echo -n
 
+# Module versioning
+add_modversions: sub_dirs FORCE
+	@RELDIR=$(RELDIR) $(CONFIG_SHELL) -e $(TOPDIR)/scripts/add_versions '$(modversions_extra)' $(obj-m)
+
+
+
 # Compile C sources (.c)
 # ---------------------------------------------------------------------------
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .3225-linux-2.5.38/include/linux/module.h .3225-linux-2.5.38.updated/include/linux/module.h
--- .3225-linux-2.5.38/include/linux/module.h	2002-09-25 07:34:11.000000000 +1000
+++ .3225-linux-2.5.38.updated/include/linux/module.h	2002-09-25 07:34:51.000000000 +1000
@@ -34,6 +34,11 @@ struct kernel_symbol
 	char name[MODULE_NAME_LEN];
 };
 
+struct modversion_info {
+	char symbol[MODULE_NAME_LEN];
+	unsigned long checksum;
+};
+
 #ifdef MODULE
 /* This is magically filled in by the linker, but THIS_MODULE must be
    a constant so it works in initializers. */
@@ -47,13 +52,28 @@ extern struct module __this_module;
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) ((typeof(&x))(__get_symbol(#x)))
 
+#ifdef CONFIG_MODVERSIONING
+#define NEED_MODVERSION(sym) 				\
+	const char __needver_##sym[256]			\
+	__attribute__((section(".needmodversion")))	\
+	= { __DIRNAME__ "/" __FILE__ };
+
+extern struct modversion_info modversions[];
+#else /* !CONFIG_MODVERSIONING */
+#define NEED_MODVERSION(sym)
+#endif
+
 /* For every exported symbol, place a struct in the __ksymtab section */
-#define EXPORT_SYMBOL(sym)				\
+#define EXPORT_SYMBOL_NOVERS(sym)			\
 	const struct kernel_symbol __ksymtab_##sym	\
 	__attribute__((section("__ksymtab")))		\
 	= { (unsigned long)&sym, #sym }
 
-#define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
+#define EXPORT_SYMBOL(sym)				\
+	NEED_MODVERSION(sym)				\
+	EXPORT_SYMBOL_NOVERS(sym)
+
+/* FIXME: Enforce this. */
 #define EXPORT_SYMBOL_GPL(sym) EXPORT_SYMBOL(sym)
 
 struct kernel_symbol_group
@@ -285,4 +305,12 @@ extern int module_dummy_usage;
 (((m)->module_init						\
   && __mod_between((p),(n),(m)->module_init,(m)->init_size))	\
  || __mod_between((p),(n),(m)->module_core,(m)->core_size))
+
+#ifdef __GENKSYMS__
+/* We want the EXPORT_SYMBOL tag left intact for recognition.  */
+#undef EXPORT_SYMBOL
+#undef EXPORT_SYMBOL_NOVERS
+#undef EXPORT_SYMBOL_GPL
+#endif /* __GENKSYMS__ */
+
 #endif /* _LINUX_MODULE_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .3225-linux-2.5.38/init/Config.in .3225-linux-2.5.38.updated/init/Config.in
--- .3225-linux-2.5.38/init/Config.in	2002-09-25 07:34:11.000000000 +1000
+++ .3225-linux-2.5.38.updated/init/Config.in	2002-09-25 07:34:34.000000000 +1000
@@ -15,6 +15,7 @@ mainmenu_option next_comment
 comment 'Loadable module support'
 bool 'Enable loadable module support' CONFIG_MODULES
 dep_bool '  Kernel module loader' CONFIG_KMOD $CONFIG_MODULES
+dep_bool '  Kernel module versioning' CONFIG_MODVERSIONING $CONFIG_MODULES
 dep_bool '  Module unloading' CONFIG_MODULE_UNLOAD $CONFIG_MODULES
 dep_bool '  Obsolete module parameters' CONFIG_OBSOLETE_MODPARM $CONFIG_MODULES
 endmenu
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .3225-linux-2.5.38/kernel/module.c .3225-linux-2.5.38.updated/kernel/module.c
--- .3225-linux-2.5.38/kernel/module.c	2002-09-25 07:34:11.000000000 +1000
+++ .3225-linux-2.5.38.updated/kernel/module.c	2002-09-25 07:34:34.000000000 +1000
@@ -459,6 +459,48 @@ static int obsolete_params(const char *n
 }
 #endif /* CONFIG_OBSOLETE_MODPARM */
 
+#ifdef CONFIG_MODVERSIONING
+static inline int check_version(const char *name,
+				const char *symname,
+				const struct modversion_info *versions,
+				unsigned int num)
+{
+	unsigned int i, k;
+
+	/* First search kernel (unversioned symbols not listed). */
+	for (k = 0; !streq(modversions[k].symbol, symname); k++)
+		if (!modversions[k].symbol[0])
+			return 0;
+
+	/* Now see if module has matching symbol. */
+	for (i = 0; i < num; i++) {
+		if (streq(versions[i].symbol, symname)) {
+			if (versions[i].checksum == modversions[k].checksum)
+				return 0;
+			printk("%s: disagrees about version of symbol %s\n",
+			       name, symname);
+			DEBUGP("Kernel checksum %lX vs module %lX\n",
+			       modversions[k].checksum, versions[i].checksum);
+			return -ESRCH;
+		}
+	}
+
+	/* Not in module's version table.  OK, but that taints the kernel. */
+	printk("%s: no version for %s found: kernel tainted.\n",
+	       name, symname);
+	tainted |= TAINT_FORCED_MODULE;
+	return 0;
+}
+#else
+static inline int check_version(const char *name,
+				const char *symname,
+				const struct modversion_info *versions,
+				unsigned int num)
+{
+	return 0;
+}
+#endif /* CONFIG_MODVERSIONING */
+
 /* Find an symbol for this module (ie. resolve internals first).
    It we find one, record usage.  Must be holding module_mutex. */
 unsigned long find_symbol_internal(Elf_Shdr *sechdrs,
@@ -644,21 +686,21 @@ static unsigned long read_commons(void *
 }
 
 /* Change all symbols so that sh_value encodes the pointer directly. */
-static void simplify_symbols(Elf_Shdr *sechdrs,
+static int simplify_symbols(Elf_Shdr *sechdrs,
 			     unsigned int symindex,
 			     unsigned int strindex,
+			     unsigned int versindex,
 			     void *common,
 			     struct module *mod)
 {
+	int ret;
 	unsigned int i;
-	Elf_Sym *sym;
+	Elf_Sym *sym = (void *)sechdrs[symindex].sh_offset;
 
 	/* First simplify defined symbols, so if they become the
            "answer" to undefined symbols, copying their st_value us
            correct. */
-	for (sym = (void *)sechdrs[symindex].sh_offset, i = 0;
-	     i < sechdrs[symindex].sh_size / sizeof(Elf_Sym);
-	     i++) {
+	for (i = 0; i < sechdrs[symindex].sh_size / sizeof(Elf_Sym); i++) {
 		switch (sym[i].st_shndx) {
 		case SHN_COMMON:
 			/* Value encodes alignment. */
@@ -687,27 +729,38 @@ static void simplify_symbols(Elf_Shdr *s
 	}
 
 	/* Now try to resolve undefined symbols */
-	for (sym = (void *)sechdrs[symindex].sh_offset, i = 0;
-	     i < sechdrs[symindex].sh_size / sizeof(Elf_Sym);
-	     i++) {
-		if (sym[i].st_shndx == SHN_UNDEF) {
-			/* Look for symbol */
-			struct kernel_symbol_group *ksg = NULL;
-			const char *strtab 
-				= (char *)sechdrs[strindex].sh_offset;
+	for (i = 0; i < sechdrs[symindex].sh_size / sizeof(Elf_Sym); i++) {
+		struct kernel_symbol_group *ksg = NULL;
+		const char *strtab = (char *)sechdrs[strindex].sh_offset;
 
-			sym[i].st_value
-				= find_symbol_internal(sechdrs,
-						       symindex,
-						       strtab,
-						       strtab + sym[i].st_name,
-						       mod,
-						       &ksg);
-			/* We fake up "__this_module" */
-			if (strcmp(strtab+sym[i].st_name, "__this_module")==0)
-				sym[i].st_value = (unsigned long)mod;
+		if (sym[i].st_shndx != SHN_UNDEF)
+			continue;
+
+		/* Look for symbol */
+		sym[i].st_value
+			= find_symbol_internal(sechdrs,
+					       symindex,
+					       strtab,
+					       strtab + sym[i].st_name,
+					       mod,
+					       &ksg);
+
+		if (sym[i].st_value && ksg == &kernel_symbols) {
+			ret = check_version(mod->name,
+					    strtab + sym[i].st_name,
+					    (void *)sechdrs[versindex]
+					    .sh_offset,
+					    sechdrs[versindex].sh_size
+					    / sizeof(struct modversion_info));
+			if (ret != 0)
+				return ret;
 		}
+
+		/* We fake up "__this_module" */
+		if (streq(strtab+sym[i].st_name, "__this_module"))
+			sym[i].st_value = (unsigned long)mod;
 	}
+	return 0;
 }
 
 /* Get the total allocation size of the init and non-init sections */
@@ -748,7 +801,7 @@ static struct module *load_module(void *
 	Elf_Shdr *sechdrs;
 	char *secstrings;
 	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modnameindex, obsparmindex;
+		modnameindex, obsparmindex, versindex;
 	long arglen;
 	unsigned long common_length;
 	struct sizes sizes, used;
@@ -786,7 +839,7 @@ static struct module *load_module(void *
 
 	/* May not export symbols, or have setup params, so these may
            not exist */
-	exportindex = setupindex = obsparmindex = 0;
+	exportindex = setupindex = obsparmindex = versindex = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
 	symindex = strindex = exindex = modnameindex = 0;
@@ -827,6 +880,11 @@ static struct module *load_module(void *
 			/* Obsolete MODULE_PARM() table */
 			DEBUGP("Obsolete param found in section %u\n", i);
 			obsparmindex = i;
+		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".versions")
+			   == 0) {
+			/* Module versioning table. */
+			DEBUGP("Symbol versions found in section %u\n", i);
+			versindex = i;
 		}
 #ifndef CONFIG_MODULE_UNLOAD
 		/* Don't load .exit sections */
@@ -913,7 +971,18 @@ static struct module *load_module(void *
 		BUG();
 
 	/* Fix up syms, so that st_value is a pointer to location. */
-	simplify_symbols(sechdrs, symindex, strindex, mod->module_core, mod);
+	err = simplify_symbols(sechdrs, symindex, strindex, versindex,
+			       mod->module_core, mod);
+	if (err < 0)
+		goto cleanup;
+
+	/* Always do SMP check for modversions. */
+	err = check_version(mod->name, "__SMP__",
+			    (void *)sechdrs[versindex].sh_offset,
+			    sechdrs[versindex].sh_size
+			    / sizeof(struct modversion_info));
+	if (err < 0)
+		goto cleanup;
 
 	/* Set up EXPORTed symbols */
 	if (exportindex) {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .3225-linux-2.5.38/kernel/modversions.c .3225-linux-2.5.38.updated/kernel/modversions.c
--- .3225-linux-2.5.38/kernel/modversions.c	1970-01-01 10:00:00.000000000 +1000
+++ .3225-linux-2.5.38.updated/kernel/modversions.c	2002-09-25 07:34:34.000000000 +1000
@@ -0,0 +1,13 @@
+/* Made very late: not referred to be normal makefiles.
+   (C) Copyright 2002 Rusty Russell, IBM Corporation.
+*/
+#include <linux/module.h>
+struct modversion_info modversions[] __attribute__((section(".versions"))) = {
+#include <linux/generated-modversions.h>
+#ifdef CONFIG_SMP
+	{ "__SMP__", 1 },
+#else
+	{ "__SMP__", 0 },
+#endif
+	{ "", 0 }
+};
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .3225-linux-2.5.38/scripts/add_versions .3225-linux-2.5.38.updated/scripts/add_versions
--- .3225-linux-2.5.38/scripts/add_versions	1970-01-01 10:00:00.000000000 +1000
+++ .3225-linux-2.5.38.updated/scripts/add_versions	2002-09-25 07:34:34.000000000 +1000
@@ -0,0 +1,32 @@
+#! /bin/sh
+# For a given list of modules, add a .versions section containing the
+# versions it expects.
+
+set -e
+
+if [ $# -lt 1 ]; then
+    echo Usage: add_versions extraversion objfiles... >&2
+    exit 1
+fi
+
+EXTRAVERSION=$1
+shift 1
+
+for file; do
+    trap "rm -f .$file.versions.*" 0
+    $NM -u $file | sed 's/\(.*\)/"\1",/' | sort | join -1 1 -2 2  -o 2.1,1.1,2.3,2.4 - $TOPDIR/include/linux/generated-modversions.h > .$file.versions
+    if [ -s .$file.versions ]; then
+	echo "Adding versions to $RELDIR/$file"
+	echo '#include <linux/module.h>' > .$file.versions.c
+	echo 'struct modversion_info __modversions[] __attribute__((section(".versions"))) = {' >> .$file.versions.c
+	cat .$file.versions >> .$file.versions.c
+	echo "$EXTRAVERSION" >> .$file.versions.c
+	echo '};' >> .$file.versions.c
+	# Remove old .versions section, won't be required once Makefiles work.
+	$OBJCOPY --remove-section=.versions $file .$file.versions.none.o
+	# Compile and add .versions section.
+	$CC $CFLAGS -c .$file.versions.c
+	$LD $LDFLAGS -r -o $file .$file.versions.none.o .$file.versions.o
+    fi
+    rm -f .$file.versions.*
+done
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .3225-linux-2.5.38/scripts/extract_versions .3225-linux-2.5.38.updated/scripts/extract_versions
--- .3225-linux-2.5.38/scripts/extract_versions	1970-01-01 10:00:00.000000000 +1000
+++ .3225-linux-2.5.38.updated/scripts/extract_versions	2002-09-25 07:34:34.000000000 +1000
@@ -0,0 +1,23 @@
+#! /bin/sh
+# Given a list of object files, output the C structure for the version table.
+
+set -e
+
+if [ $# -lt 2 ]; then
+    echo Usage: extract_versions kernelversion objfiles... >&2
+    exit 1
+fi
+
+VERSION=$1
+shift 1
+
+# Join 16-lines into one big filename, then run each filename through genksyms.
+# Genksyms produces:
+# #define __ver_printk	smp_1b7d4074
+# #define printk	_set_ver(printk)
+# 
+# And since it's outside the kernel source tree, we use sed on it.
+for file in `"$OBJDUMP" --section=.needmodversion --full-contents "$@" | sed -n '/^ *[0-9a-fA-Z][0-9a-fA-Z][0-9a-fA-Z][0-9a-fA-Z] /{N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;s/[0-9A-Za-z ]*  //g;s/\n//g;s/\.*$//gp;}' | sort -u`; do
+    echo "GENKSYMS	$file" >&2
+    $CPP $CFLAGS -D__GENKSYMS__ $file | genksyms -k $VERSION | sed -n '/#define __ver_/{s///;N;s/\n.*//;s/\([a-zA-Z0-9_]*\)[^a-zA-Z0-9_]*\(.*\)/{ "\1", 0x\2 },/p;}'
+done | sort

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265627AbUBBGB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 01:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265630AbUBBGB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 01:01:26 -0500
Received: from ns.suse.de ([195.135.220.2]:32408 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265627AbUBBGBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 01:01:14 -0500
Subject: [RFC] External kernel modules
From: Andreas Gruenbacher <agruen@suse.de>
To: "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-HrrT4dflb52qA+ZgWcXD"
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1075701681.8018.66.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 02 Feb 2004 07:01:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HrrT4dflb52qA+ZgWcXD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

the kernel build system (kbuild) allows to compile modules whose sources
live outside the kernel source tree by setting SUBDIRS as follows (from
the module sources's directory):

  $ make -C /lib/modules/$(uname -r)/build modules SUBDIRS=$(pwd)

people use this mechanism to compile kernel modules that are missing in
their kernel sources, or have been updated/fixed in the meantime.

Currently there are a number of deficiencies for building such modules:

  (1) symbol versioning (MODVERSIONS) is not properly supported, and

  (2) only the `modules' make target is supported.

Problem (1) did not exist in the 2.4 kernel series. The current
situation has lead authors of several external modules to implement some
of the kbuild functionality in their own makefiles, which can only lead
to problems later on.

During the kernel compile, a list of all files that export symbols is
created in .tmp_versions/ of the kernel source tree. After everything is
compiled, the module versions of all these object files are resolved
with modpost. When an external module is compiled, it ends up being the
only file in .tmp_versions/, and so symbols in other modules would not
be found.

An additional problem is that resolving symbol versions requires all
module files plus vmlinux to be in the kernel source tree, so modules
cannot be build against a clean kernel source tree.

I propose the attached patch: It adds symbol version dump/load
functionality to modpost: When compiling the kernel, the module versions
are dumped to a file. When compiling external modules, the dumped
symbols are first loaded. Also, to allow a read-only kernel source tree
and not interfere with the kernel sources, the .tmp_versions/ directory
is placed in the external module's directory.

Furthermore, the patch adds clean/distclean/mrproper make targets with
reasonable semantics for external modules, and also adds a modules_add
target that installs the external modules into
/lib/modules/$(KERNELRELEASE). (The modules_install target could be
used, but it has different semantics, so I have used a different name
instead.)


There also is one fix for using tempfiles instead of writing into the
kernel source tree. A few problems with compiling against a read-only
kernel source tree seem to remain.


Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

--=-HrrT4dflb52qA+ZgWcXD
Content-Disposition: attachment; filename=kbuild-out-of-tree.diff
Content-Type: text/x-patch; name=kbuild-out-of-tree.diff; charset=
Content-Transfer-Encoding: 7bit

Index: linux-2.6.1/Makefile
===================================================================
--- linux-2.6.1.orig/Makefile
+++ linux-2.6.1/Makefile
@@ -289,7 +289,10 @@ export CPPFLAGS NOSTDINC_FLAGS OBJCOPYFL
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
 export AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 
-export MODVERDIR := .tmp_versions
+# When compiling out-of-tree modules, put MODVERDIR in the module source
+# tree rather than in the kernel source tree. The kernel source tree might
+# even be read-only.
+export MODVERDIR := $(patsubst %,%/,$(firstword $(filter ../% /%,$(SUBDIRS)))).tmp_versions
 
 # The temporary file to save gcc -MD generated dependencies must not
 # contain a comma
@@ -748,6 +751,9 @@ endif
 _modinst_post: _modinst_
 	if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
 
+modules_add:
+	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
+
 else # CONFIG_MODULES
 
 # Modules not configured
@@ -819,11 +825,28 @@ clean-dirs += $(addprefix _clean_,$(ALL_
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
+.PHONY: _clean _mrproper
+ifeq ($(filter ../% /%,$(SUBDIRS)),)
+
+clean_subdirs := .
+clean: _clean archclean $(clean-dirs)
+	$(call cmd,rmclean)
+mrproper distclean: clean _mrproper archmrproper
+	$(call cmd,mrproper)
+
+else
+
+clean_subdirs := $(filter ../% /%,$(SUBDIRS))
+clean: _clean
+mrproper distclean: _mrproper
+	$(Q)rm -rf $(MODVERDIR)
+
+endif
+
 quiet_cmd_rmclean = RM  $$(CLEAN_FILES)
 cmd_rmclean	  = rm -f $(CLEAN_FILES)
-clean: archclean $(clean-dirs)
-	$(call cmd,rmclean)
-	@find . $(RCS_FIND_IGNORE) \
+_clean:
+	@find $(clean_subdirs) $(RCS_FIND_IGNORE) \
 	 	\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
 		-type f -print | xargs rm -f
@@ -832,15 +855,13 @@ clean: archclean $(clean-dirs)
 #
 quiet_cmd_mrproper = RM  $$(MRPROPER_DIRS) + $$(MRPROPER_FILES)
 cmd_mrproper = rm -rf $(MRPROPER_DIRS) && rm -f $(MRPROPER_FILES)
-mrproper distclean: clean archmrproper
-	@echo '  Making $@ in the srctree'
-	@find . $(RCS_FIND_IGNORE) \
+_mrproper:
+	@find $(clean_subdirs) $(RCS_FIND_IGNORE) \
 	 	\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
 	 	-o -name '.*.rej' -o -size 0 \
 		-o -name '*%' -o -name '.*.cmd' -o -name 'core' \) \
 		-type f -print | xargs rm -f
-	$(call cmd,mrproper)
 
 # Generate tags for editors
 # ---------------------------------------------------------------------------
@@ -1045,12 +1066,13 @@ define filechk
 	@set -e;				\
 	echo '  CHK     $@';			\
 	mkdir -p $(dir $@);			\
-	$(filechk_$(1)) < $< > $@.tmp;		\
-	if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
-		rm -f $@.tmp;			\
+	tmp=$$(/bin/mktemp /tmp/kbuild.XXXXXX);	\
+	$(filechk_$(1)) < $< > $$tmp;		\
+	if [ -r $@ ] && cmp -s $@ $$tmp; then	\
+		rm -f $$tmp;			\
 	else					\
 		echo '  UPD     $@';		\
-		mv -f $@.tmp $@;		\
+		mv -f $$tmp $@;		\
 	fi
 endef
 
Index: linux-2.6.1/scripts/modpost.c
===================================================================
--- linux-2.6.1.orig/scripts/modpost.c
+++ linux-2.6.1/scripts/modpost.c
@@ -15,7 +15,7 @@
 
 /* Are we using CONFIG_MODVERSIONS? */
 int modversions = 0;
-/* Do we have vmlinux? */
+/* Warn about undefined symbols? (do so if we have vmlinux) */
 int have_vmlinux = 0;
 
 void
@@ -60,6 +60,17 @@ void *do_nofail(void *ptr, const char *f
 static struct module *modules;
 
 struct module *
+find_module(char *modname)
+{
+	struct module *mod;
+
+	for (mod = modules; mod; mod = mod->next)
+		if (strcmp(mod->name, modname) == 0)
+			break;
+	return mod;
+}
+
+struct module *
 new_module(char *modname)
 {
 	struct module *mod;
@@ -165,7 +176,7 @@ add_exported_symbol(const char *name, st
 	struct symbol *s = find_symbol(name);
 
 	if (!s) {
-		new_symbol(name, modules, crc);
+		new_symbol(name, module, crc);
 		return;
 	}
 	if (crc) {
@@ -346,14 +357,17 @@ read_symbols(char *modname)
 	struct symbol *s;
 	Elf_Sym *sym;
 
-	/* When there's no vmlinux, don't print warnings about
-	 * unresolved symbols (since there'll be too many ;) */
-	have_vmlinux = is_vmlinux(modname);
-
 	parse_elf(&info, modname);
 
 	mod = new_module(modname);
 
+	/* When we have vmlinux, print warnings about unresolved
+	 * symbols. (Otherwise, there might be too many). */
+	if (strcmp(modname, "vmlinux") == 0) {
+		have_vmlinux = 1;
+		mod->skip = 1;
+	}
+
 	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
 		symname = info.strtab + sym->st_name;
 
@@ -541,19 +555,91 @@ write_if_changed(struct buffer *b, const
 	fclose(file);
 }
 
+void
+read_dump(FILE *file)
+{
+	unsigned int crc;
+	char symname[128], modname[4096];
+
+	while (fscanf(file, "%x %128s %4096s", &crc, symname, modname) == 3) {
+		struct module *mod;
+		if (!(mod = find_module(modname))) {
+			mod = new_module(NOFAIL(strdup(modname)));
+			mod->skip = 1;
+		}
+		add_exported_symbol(symname, mod, &crc);
+	}
+	if (!feof(file)) {
+		fatal("parse error in symbol dump file\n");
+	}
+}
+
+void
+write_dump(FILE *file)
+{
+	struct symbol *symbol;
+	int n;
+
+	for (n = 0; n < SYMBOL_HASH_SIZE ; n++) {
+		symbol = symbolhash[n];
+		while (symbol) {
+			symbol = symbol->next;
+		}
+	}
+
+	for (n = 0; n < SYMBOL_HASH_SIZE ; n++) {
+		symbol = symbolhash[n];
+		while (symbol) {
+			fprintf(file, "0x%08x\t%s\t%s\n", symbol->crc,
+				symbol->name, symbol->module->name);
+			symbol = symbol->next;
+		}
+	}
+}
+
 int
 main(int argc, char **argv)
 {
 	struct module *mod;
 	struct buffer buf = { };
 	char fname[SZ];
+	char *read_dumpfile = NULL, *write_dumpfile = NULL;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "i:o:")) != -1) {
+		switch(opt) {
+			case 'i':
+				read_dumpfile = optarg;
+				modversions = 1;
+				have_vmlinux = 1;
+				break;
+			case 'o':
+				write_dumpfile = optarg;
+				break;
+			default:
+				exit(1);
+		}
+	}
+
+	if (read_dumpfile) {
+		FILE *file = fopen(read_dumpfile, "r");
+		if (!file) {
+			perror(read_dumpfile);
+			exit(1);
+		}
+		read_dump(file);
+		if (fclose(file) != 0) {
+			perror(read_dumpfile);
+			exit(1);
+		}
+	}
 
-	for (; argv[1]; argv++) {
-		read_symbols(argv[1]);
+	while (optind < argc) {
+		read_symbols(argv[optind++]);
 	}
 
 	for (mod = modules; mod; mod = mod->next) {
-		if (is_vmlinux(mod->name))
+		if (mod->skip)
 			continue;
 
 		buf.pos = 0;
@@ -566,6 +652,20 @@ main(int argc, char **argv)
 		sprintf(fname, "%s.mod.c", mod->name);
 		write_if_changed(&buf, fname);
 	}
+
+	if (write_dumpfile) {
+		FILE *file = fopen(write_dumpfile, "w");
+		if (!file) {
+			perror(write_dumpfile);
+			exit(1);
+		}
+		write_dump(file);
+		if (fclose(file) != 0) {
+			perror(write_dumpfile);
+			exit(1);
+		}
+	}
+
 	return 0;
 }
 
Index: linux-2.6.1/scripts/modpost.h
===================================================================
--- linux-2.6.1.orig/scripts/modpost.h
+++ linux-2.6.1/scripts/modpost.h
@@ -70,6 +70,7 @@ struct module {
 	const char *name;
 	struct symbol *unres;
 	int seen;
+	int skip;
 	struct buffer dev_table_buf;
 };
 
Index: linux-2.6.1/scripts/Makefile.modinst
===================================================================
--- linux-2.6.1.orig/scripts/Makefile.modinst
+++ linux-2.6.1/scripts/Makefile.modinst
@@ -29,11 +29,13 @@ quiet_cmd_modules_install = INSTALL $@
 $(filter-out ../% /%,$(modules)):
 	$(call cmd,modules_install)
 
-# Modules built outside just go into extra
+# Modules built outside go into extra by default
 
-quiet_cmd_modules_install_extra = INSTALL $(obj-m:.o=.ko)
-      cmd_modules_install_extra = mkdir -p $(MODLIB)/extra; \
-			    	  cp $@ $(MODLIB)/extra
+MOD_DIR ?= extra
+
+quiet_cmd_modules_install_extra = INSTALL $(@F)
+      cmd_modules_install_extra = mkdir -p $(MODLIB)/$(MOD_DIR); \
+			    	  cp $@ $(MODLIB)/$(MOD_DIR)
 
 $(filter     ../% /%,$(modules)):
 	$(call cmd,modules_install_extra)
Index: linux-2.6.1/scripts/Makefile.modpost
===================================================================
--- linux-2.6.1.orig/scripts/Makefile.modpost
+++ linux-2.6.1/scripts/Makefile.modpost
@@ -51,11 +51,21 @@ $(modules:.ko=.mod.c): __modpost ;
 
 # Extract all checksums for all exported symbols
 
-quiet_cmd_modpost = MODPOST
-      cmd_modpost = scripts/modpost $(filter-out FORCE,$^)
+# Are we building out-of-tree modules?
 
+ifeq ($(filter ../% /%,$(SUBDIRS)),)
+modver_file := modversions
+quiet_cmd_modpost = MODPOST
+      cmd_modpost = scripts/modpost $(filter-out FORCE,$^) -o $(modver_file)
 __modpost: $(wildcard vmlinux) $(modules:.ko=.o) FORCE
 	$(call if_changed,modpost)
+else
+modver_file := $(wildcard modversions)
+quiet_cmd_modpost = MODPOST
+      cmd_modpost = scripts/modpost $^ $(if $(modver_file),-i $(modver_file))
+__modpost: $(modules:.ko=.o)
+	$(call cmd,modpost)
+endif
 
 targets += __modpost
 

--=-HrrT4dflb52qA+ZgWcXD--


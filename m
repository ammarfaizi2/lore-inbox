Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUDIUXQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 16:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUDIUXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 16:23:16 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:37236 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261704AbUDIUWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 16:22:43 -0400
Date: Fri, 9 Apr 2004 22:28:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Andreas Gruenbacher <agruen@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: external module support
Message-ID: <20040409202808.GA11862@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
References: <20040409200839.GA11601@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040409200839.GA11601@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 10:08:39PM +0200, Sam Ravnborg wrote:
> 
> This patch is made on top of the previously posted patch to divide
> make clean in three steps.

Here is a patch on top of -mm3 that includes the other kbuild stuff.
Makes it easier to play with.

	Sam

diff -upr linux-2.6.5/Makefile mm4/Makefile
--- linux-2.6.5/Makefile	2004-04-09 14:03:35.000000000 +0200
+++ mm4/Makefile	2004-04-09 21:24:15.000000000 +0200
@@ -53,6 +53,19 @@ ifndef KBUILD_CHECKSRC
   KBUILD_CHECKSRC = 0
 endif
 
+# Use make M=dir to specify direcotry of external module to build
+# Old syntax make ... SUBDIRS=$PWD is still supported
+# Setting the environment variable KBUILD_EXTMOD take precedence
+ifdef SUBDIRS
+  KBUILD_EXTMOD ?= $(SUBDIRS)
+endif
+ifdef M
+  ifeq ("$(origin M)", "command line")
+    KBUILD_EXTMOD := $(M)
+  endif
+endif
+
+
 # kbuild supports saving output files in a separate directory.
 # To locate output files in a separate directory two syntax'es are supported.
 # In both cases the working directory must be the root of the kernel src.
@@ -81,9 +94,9 @@ ifdef O
 endif
 
 # That's our default target when none is given on the command line
-.PHONY: all
-all:
-  
+.PHONY: _all
+_all:
+
 ifneq ($(KBUILD_OUTPUT),)
 # Invoke a second make in the output directory, passing relevant variables
 # check that the output directory actually exists
@@ -94,10 +107,11 @@ $(if $(wildcard $(KBUILD_OUTPUT)),, \
 
 .PHONY: $(MAKECMDGOALS)
 
-$(filter-out all,$(MAKECMDGOALS)) all:
+$(filter-out _all,$(MAKECMDGOALS)) _all:
 	$(if $(KBUILD_VERBOSE:1=),@)$(MAKE) -C $(KBUILD_OUTPUT)		\
-	KBUILD_SRC=$(CURDIR)	KBUILD_VERBOSE=$(KBUILD_VERBOSE)	\
-	KBUILD_CHECK=$(KBUILD_CHECK) -f $(CURDIR)/Makefile $@
+	KBUILD_SRC=$(CURDIR)	     KBUILD_VERBOSE=$(KBUILD_VERBOSE)	\
+	KBUILD_CHECK=$(KBUILD_CHECK) KBUILD_EXTMOD=$(KBUILD_EXTMOD)     \
+        -f $(CURDIR)/Makefile $@
 
 # Leave processing to above invocation of make
 skip-makefile := 1
@@ -107,6 +121,15 @@ endif # ifeq ($(KBUILD_SRC),)
 # We process the rest of the Makefile if this is the final invocation of make
 ifeq ($(skip-makefile),)
 
+# If building an external module we do not care about the all: rule
+# but instead _all depend on modules
+.PHONY: all
+ifeq ($(KBUILD_EXTMOD),)
+_all: all
+else 
+_all: modules
+endif
+
 # Make sure we're not wasting cpu-cycles doing locale handling, yet do make
 # sure error messages appear in the user-desired language
 ifdef LC_ALL
@@ -194,7 +217,7 @@ endif
 #	in addition to whatever we do anyway.
 #	Just "make" or "make all" shall build modules as well
 
-ifneq ($(filter all modules,$(MAKECMDGOALS)),)
+ifneq ($(filter all _all modules,$(MAKECMDGOALS)),)
   KBUILD_MODULES := 1
 endif
 
@@ -203,7 +226,7 @@ ifeq ($(MAKECMDGOALS),)
 endif
 
 export KBUILD_MODULES KBUILD_BUILTIN KBUILD_VERBOSE
-export KBUILD_CHECKSRC KBUILD_SRC
+export KBUILD_CHECKSRC KBUILD_SRC KBUILD_EXTMOD
 
 # Beautify output
 # ---------------------------------------------------------------------------
@@ -299,7 +322,10 @@ export CPPFLAGS NOSTDINC_FLAGS OBJCOPYFL
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
 export AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 
-export MODVERDIR := .tmp_versions
+# When compiling out-of-tree modules, put MODVERDIR in the module
+# tree rather than in the kernel tree. The kernel tree might
+# even be read-only.
+export MODVERDIR := $(if $(KBUILD_EXTMOD),$(KBUILD_EXTMOD)/).tmp_versions
 
 # The temporary file to save gcc -MD generated dependencies must not
 # contain a comma
@@ -340,11 +366,13 @@ ifneq ($(filter $(no-dot-config-targets)
 	endif
 endif
 
-ifneq ($(filter config %config,$(MAKECMDGOALS)),)
-	config-targets := 1
-	ifneq ($(filter-out config %config,$(MAKECMDGOALS)),)
-		mixed-targets := 1
-	endif
+ifeq ($(KBUILD_EXTMOD),)
+        ifneq ($(filter config %config,$(MAKECMDGOALS)),)
+                config-targets := 1
+                ifneq ($(filter-out config %config,$(MAKECMDGOALS)),)
+                        mixed-targets := 1
+                endif
+        endif
 endif
 
 ifeq ($(mixed-targets),1)
@@ -371,6 +399,7 @@ else
 # Build targets only - this includes vmlinux, arch specific targets, clean
 # targets and others. In general all targets except *config targets.
 
+ifeq ($(KBUILD_EXTMOD),)
 # Additional helpers built in scripts/
 # Carefully list dependencies so we do not try to build scripts twice
 # in parrallel
@@ -393,7 +422,7 @@ drivers-y	:= drivers/ sound/
 net-y		:= net/
 libs-y		:= lib/
 core-y		:= usr/
-SUBDIRS		:=
+endif # KBUILD_EXTMOD
 
 ifeq ($(dot-config),1)
 # In this section, we need .config
@@ -420,33 +449,6 @@ endif
 
 include $(srctree)/arch/$(ARCH)/Makefile
 
-# Let architecture Makefiles change CPPFLAGS if needed
-CFLAGS := $(CPPFLAGS) $(CFLAGS)
-AFLAGS := $(CPPFLAGS) $(AFLAGS)
-
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/
-
-SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
-		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
-		     $(net-y) $(net-m) $(libs-y) $(libs-m)))
-
-ALL_SUBDIRS     := $(sort $(SUBDIRS) $(patsubst %/,%,$(filter %/, \
-		     $(init-n) $(init-) \
-		     $(core-n) $(core-) $(drivers-n) $(drivers-) \
-		     $(net-n)  $(net-)  $(libs-n)    $(libs-))))
-
-init-y		:= $(patsubst %/, %/built-in.o, $(init-y))
-core-y		:= $(patsubst %/, %/built-in.o, $(core-y))
-drivers-y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
-net-y		:= $(patsubst %/, %/built-in.o, $(net-y))
-libs-y1		:= $(patsubst %/, %/lib.a, $(libs-y))
-libs-y2		:= $(patsubst %/, %/built-in.o, $(libs-y))
-libs-y		:= $(libs-y1) $(libs-y2)
-
-# Here goes the main Makefile
-# ---------------------------------------------------------------------------
-
-
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 CFLAGS		+= -Os
 else
@@ -481,6 +483,27 @@ CFLAGS += $(call check_gcc,-Wdeclaration
 MODLIB	:= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
 export MODLIB
 
+
+ifeq ($(KBUILD_EXTMOD),)
+core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/
+
+vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
+		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
+		     $(net-y) $(net-m) $(libs-y) $(libs-m)))
+
+vmlinux-alldirs	:= $(sort $(vmlinux-dirs) $(patsubst %/,%,$(filter %/, \
+		     $(init-n) $(init-) \
+		     $(core-n) $(core-) $(drivers-n) $(drivers-) \
+		     $(net-n)  $(net-)  $(libs-n)    $(libs-))))
+
+init-y		:= $(patsubst %/, %/built-in.o, $(init-y))
+core-y		:= $(patsubst %/, %/built-in.o, $(core-y))
+drivers-y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
+net-y		:= $(patsubst %/, %/built-in.o, $(net-y))
+libs-y1		:= $(patsubst %/, %/lib.a, $(libs-y))
+libs-y2		:= $(patsubst %/, %/built-in.o, $(libs-y))
+libs-y		:= $(libs-y1) $(libs-y2)
+
 # Build vmlinux
 # ---------------------------------------------------------------------------
 
@@ -569,12 +592,12 @@ vmlinux: $(vmlinux-objs) $(kallsyms.o) a
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
 
-$(sort $(vmlinux-objs)) arch/$(ARCH)/kernel/vmlinux.lds.s: $(SUBDIRS) ;
+$(sort $(vmlinux-objs)) arch/$(ARCH)/kernel/vmlinux.lds.s: $(vmlinux-dirs) ;
 
-# 	Handle descending into subdirectories listed in $(SUBDIRS)
+# 	Handle descending into subdirectories listed in $(vmlinux-dirs)
 
-.PHONY: $(SUBDIRS)
-$(SUBDIRS): prepare-all scripts
+.PHONY: $(vmlinux-dirs)
+$(vmlinux-dirs): prepare-all scripts
 	$(Q)$(MAKE) $(build)=$@
 
 # Things we need to do before we recursively start building the kernel
@@ -602,14 +625,7 @@ ifneq ($(KBUILD_SRC),)
 endif
 
 prepare0: prepare1 include/linux/version.h include/asm include/config/MARKER
-ifdef KBUILD_MODULES
-ifeq ($(origin SUBDIRS),file)
 	$(Q)rm -rf $(MODVERDIR)
-else
-	@echo '*** Warning: Overriding SUBDIRS on the command line can cause'
-	@echo '***          inconsistencies'
-endif
-endif
 	$(if $(CONFIG_MODULES),$(Q)mkdir -p $(MODVERDIR))
 
 # All the preparing..
@@ -694,7 +710,7 @@ all: modules
 #	Build modules
 
 .PHONY: modules
-modules: $(SUBDIRS) $(if $(KBUILD_BUILTIN),vmlinux)
+modules: $(vmlinux-dirs) $(if $(KBUILD_BUILTIN),vmlinux)
 	@echo '  Building modules, stage 2.';
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
@@ -767,39 +783,38 @@ endef
 
 ###
 # Cleaning is done on three levels.
-# make clean     Delete all automatically generated files, including
-#                tools and firmware.
-# make mrproper  Delete the current configuration, and related files
-#                Any core files spread around are deleted as well
+# make clean     Delete most generated files
+#                Leave enough to build external modules
+# make mrproper  Delete the current configuration, and all generated files
 # make distclean Remove editor backup files, patch leftover files and the like
 
-# Directories & files removed with 'make clean'
-CLEAN_DIRS  += $(MODVERDIR) include/config include2
-CLEAN_FILES +=	vmlinux System.map \
-		include/linux/autoconf.h include/linux/version.h \
-		include/asm include/linux/modversions.h \
-		kernel.spec .tmp*
+quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
+      cmd_rmdirs = rm -rf $(rm-dirs)
+
+quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
+      cmd_rmfiles = rm -f $(rm-files)
 
-# Files removed with 'make mrproper'
-MRPROPER_FILES += .version .config .config.old tags TAGS cscope*
+# Directories & files removed with 'make clean'
+CLEAN_DIRS  += $(MODVERDIR)
+CLEAN_FILES +=	vmlinux System.map kernel.spec \
+                .tmp_kallsyms* .tmp_version .tmp_vmlinux*
+
+# Directories & files removed with 'make mrproper'
+MRPROPER_DIRS  += include/config include2
+MRPROPER_FILES += .config .config.old include/asm .version \
+                  include/linux/autoconf.h include/linux/version.h \
+                  Module.symvers tags TAGS cscope*
 
-# clean - Delete all intermediate files
+# clean - Delete most, but leave enough to build external modules
 #
-clean-dirs += $(addprefix _clean_,$(ALL_SUBDIRS) Documentation/DocBook scripts)
-.PHONY: $(clean-dirs) clean archclean mrproper archmrproper distclean
+clean: rm-dirs  := $(CLEAN_DIRS)
+clean: rm-files := $(CLEAN_FILES)
+clean-dirs      := $(addprefix _clean_,$(vmlinux-alldirs))
+
+.PHONY: $(clean-dirs) clean archclean
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
-clean:		rm-dirs  := $(wildcard $(CLEAN_DIRS))
-mrproper:	rm-dirs  := $(wildcard $(MRPROPER_DIRS))
-quiet_cmd_rmdirs = $(if $(rm-dirs),CLEAN   $(rm-dirs))
-      cmd_rmdirs = rm -rf $(rm-dirs)
-
-clean:		rm-files := $(wildcard $(CLEAN_FILES))
-mrproper:	rm-files := $(wildcard $(MRPROPER_FILES))
-quiet_cmd_rmfiles = $(if $(rm-files),CLEAN   $(rm-files))
-      cmd_rmfiles = rm -rf $(rm-files)
-
 clean: archclean $(clean-dirs)
 	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
@@ -808,12 +823,25 @@ clean: archclean $(clean-dirs)
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
 		-type f -print | xargs rm -f
 
-# mrproper
+# mrproper - Delete all generated files, including .config
 #
-distclean: mrproper
-mrproper: clean archmrproper
+mrproper: rm-dirs  := $(wildcard $(MRPROPER_DIRS))
+mrproper: rm-files := $(wildcard $(MRPROPER_FILES))
+mrproper-dirs      := $(addprefix _mrproper_,Documentation/DocBook scripts)
+
+.PHONY: $(mrproper-dirs) mrproper archmrproper
+$(mrproper-dirs):
+	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
+
+mrproper: clean archmrproper $(mrproper-dirs)
 	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
+
+# distclean
+#
+.PHONY: distclean
+
+distclean: mrproper
 	@find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
@@ -821,52 +849,6 @@ mrproper: clean archmrproper
 		-o -name '*%' -o -name '.*.cmd' -o -name 'core' \) \
 		-type f -print | xargs rm -f
 
-# Generate tags for editors
-# ---------------------------------------------------------------------------
-
-define all-sources
-	( find . $(RCS_FIND_IGNORE) \
-	       \( -name include -o -name arch \) -prune -o \
-	       -name '*.[chS]' -print; \
-	  find arch/$(ARCH) $(RCS_FIND_IGNORE) \
-	       -name '*.[chS]' -print; \
-	  find include $(RCS_FIND_IGNORE) \
-	       \( -name config -o -name 'asm-*' \) -prune \
-	       -o -name '*.[chS]' -print; \
-	  find include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
-	       -name '*.[chS]' -print; \
-	  find include/asm-generic $(RCS_FIND_IGNORE) \
-	       -name '*.[chS]' -print )
-endef
-
-quiet_cmd_cscope-file = FILELST cscope.files
-      cmd_cscope-file = $(all-sources) > cscope.files
-
-quiet_cmd_cscope = MAKE    cscope.out
-      cmd_cscope = cscope -k -b -q
-
-cscope: FORCE
-	$(call cmd,cscope-file)
-	$(call cmd,cscope)
-
-quiet_cmd_TAGS = MAKE   $@
-cmd_TAGS = $(all-sources) | etags -
-
-# 	Exuberant ctags works better with -I
-
-quiet_cmd_tags = MAKE   $@
-define cmd_tags
-	rm -f $@; \
-	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
-	$(all-sources) | xargs ctags $$CTAGSF -a
-endef
-
-TAGS: FORCE
-	$(call cmd,TAGS)
-
-tags: FORCE
-	$(call cmd,tags)
-
 # RPM target
 # ---------------------------------------------------------------------------
 
@@ -946,9 +928,113 @@ help:
 
 # Documentation targets
 # ---------------------------------------------------------------------------
-%docs: scripts FORCE
+%docs: scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=Documentation/DocBook $@
 
+else # KBUILD_EXTMOD
+
+###
+# External module support.
+# When building external modules the kernel used as basis is considered
+# read-only, and no consistency checks are made and the make
+# system is not used on the basis kernel. If updates are required
+# in the basis kernel ordinary make commands (without M=...) must
+# be used.
+# 
+# The following are the only valid targets when building external
+# modules.
+# make M=dir clean     Delete all automatically generated files
+# make M=dir modules   Make all modules in specified dir
+# make M=dir	       Same as 'make M=dir modules' 
+# make M=dir modules_install
+#                      Install the modules build in the module directory
+#                      Assumes install directory is already created
+
+# We are always building modules
+KBUILD_MODULES := 1
+
+.PHONY: $(KBUILD_EXTMOD)
+$(KBUILD_EXTMOD): FORCE
+	$(Q)$(MAKE) $(build)=$@
+
+.PHONY: modules
+modules: $(KBUILD_EXTMOD)
+	@echo '  Building modules, stage 2.';
+	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
+
+.PHONY: modules_install
+modules_install:
+	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
+
+clean-dirs := _clean_$(KBUILD_EXTMOD)
+
+.PHONY: $(clean-dirs) clean
+$(clean-dirs):
+	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
+
+clean: $(clean-dirs)
+	@find $(KBUILD_EXTMOD) $(RCS_FIND_IGNORE) \
+	 	\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
+		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
+		-type f -print | xargs rm -f
+
+help:
+	@echo  '  Building external modules.'
+	@echo  '  Syntax: make -C path/to/kernel/src M=$$PWD target'
+	@echo  ''
+	@echo  '  modules         - default target, build the module(s)'
+	@echo  '  modules_install - install the module'
+	@echo  '  clean           - remove generated files in module directory only'
+	@echo  ''
+endif # KBUILD_EXTMOD
+
+# Generate tags for editors
+# ---------------------------------------------------------------------------
+
+define all-sources
+	( find . $(RCS_FIND_IGNORE) \
+	       \( -name include -o -name arch \) -prune -o \
+	       -name '*.[chS]' -print; \
+	  find arch/$(ARCH) $(RCS_FIND_IGNORE) \
+	       -name '*.[chS]' -print; \
+	  find include $(RCS_FIND_IGNORE) \
+	       \( -name config -o -name 'asm-*' \) -prune \
+	       -o -name '*.[chS]' -print; \
+	  find include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
+	       -name '*.[chS]' -print; \
+	  find include/asm-generic $(RCS_FIND_IGNORE) \
+	       -name '*.[chS]' -print )
+endef
+
+quiet_cmd_cscope-file = FILELST cscope.files
+      cmd_cscope-file = $(all-sources) > cscope.files
+
+quiet_cmd_cscope = MAKE    cscope.out
+      cmd_cscope = cscope -k -b -q
+
+cscope: FORCE
+	$(call cmd,cscope-file)
+	$(call cmd,cscope)
+
+quiet_cmd_TAGS = MAKE   $@
+cmd_TAGS = $(all-sources) | etags -
+
+# 	Exuberant ctags works better with -I
+
+quiet_cmd_tags = MAKE   $@
+define cmd_tags
+	rm -f $@; \
+	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
+	$(all-sources) | xargs ctags $$CTAGSF -a
+endef
+
+TAGS: FORCE
+	$(call cmd,TAGS)
+
+tags: FORCE
+	$(call cmd,tags)
+
+
 # Scripts to check various things for consistency
 # ---------------------------------------------------------------------------
 
diff -upr linux-2.6.5/scripts/Makefile.modpost mm4/scripts/Makefile.modpost
--- linux-2.6.5/scripts/Makefile.modpost	2004-04-09 14:03:35.000000000 +0200
+++ mm4/scripts/Makefile.modpost	2004-04-09 21:25:12.000000000 +0200
@@ -13,12 +13,6 @@ include scripts/Makefile.lib
 __modules := $(shell head -q -n1 /dev/null $(wildcard $(MODVERDIR)/*.mod))
 modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
 
-ifneq ($(filter-out $(modules),$(__modules)),)
-  $(warning Trouble: $(filter-out $(modules),$(__modules)))
-  $(warning *** Uh-oh, you have stale module entries. You messed with SUBDIRS,)
-  $(warning     do not complain if something goes wrong.)
-endif
-
 __modversions: $(modules)
 	@:
 
@@ -55,9 +49,11 @@ $(modules:.ko=.mod.c): __modpost ;
 # Extract all checksums for all exported symbols
 
 quiet_cmd_modpost = MODPOST
-      cmd_modpost = scripts/modpost $(filter-out FORCE,$^)
+      cmd_modpost = scripts/modpost \
+	$(if $(filter vmlinux,$^),-o,-i) $(objtree)/Module.symvers \
+	$(filter-out FORCE,$^)
 
-__modpost: $(wildcard vmlinux) $(modules:.ko=.o) FORCE
+__modpost: $(if $(KBUILD_EXTMOD),,$(wildcard vmlinux)) $(modules:.ko=.o) FORCE
 	$(call if_changed,modpost)
 
 targets += __modpost
diff -upr linux-2.6.5/scripts/modpost.c mm4/scripts/modpost.c
--- linux-2.6.5/scripts/modpost.c	2004-04-09 14:03:35.000000000 +0200
+++ mm4/scripts/modpost.c	2004-04-09 21:40:01.000000000 +0200
@@ -16,7 +16,7 @@
 
 /* Are we using CONFIG_MODVERSIONS? */
 int modversions = 0;
-/* Do we have vmlinux? */
+/* Warn about undefined symbols? (do so if we have vmlinux) */
 int have_vmlinux = 0;
 
 void
@@ -59,6 +59,17 @@ void *do_nofail(void *ptr, const char *f
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
@@ -181,7 +192,7 @@ grab_file(const char *filename, unsigned
 	int fd;
 
 	fd = open(filename, O_RDONLY);
-	if (fstat(fd, &st) != 0)
+	if (fd < 0 || fstat(fd, &st) != 0)
 		return NULL;
 
 	*size = st.st_size;
@@ -402,6 +413,8 @@ read_symbols(char *modname)
 		/* May not have this if !CONFIG_MODULE_UNLOAD: fake it.
 		   If it appears, we'll get the real CRC. */
 		add_exported_symbol("cleanup_module", mod, &fake_crc);
+		add_exported_symbol("struct_module", mod, &fake_crc);
+		mod->skip = 1;
 	}
 
 	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
@@ -604,19 +617,106 @@ write_if_changed(struct buffer *b, const
 	fclose(file);
 }
 
+void
+read_dump(const char *fname)
+{
+	unsigned long size, pos = 0;
+	void *file = grab_file(fname, &size);
+	char *line;
+
+        if (!file) {
+                perror(fname);
+                abort();
+        }
+
+	while ((line = get_next_line(&pos, file, size))) {
+		char *symname, *modname, *d;
+		unsigned int crc;
+		struct module *mod;
+
+		if (!(symname = strchr(line, '\t')))
+			goto fail;
+		*symname++ = '\0';
+		if (!(modname = strchr(symname, '\t')))
+			goto fail;
+		*modname++ = '\0';
+		if (strchr(modname, '\t'))
+			goto fail;
+		crc = strtoul(line, &d, 16);
+		if (*symname == '\0' || *modname == '\0' || *d != '\0')
+			goto fail;
+
+		if (!(mod = find_module(modname))) {
+			if (is_vmlinux(modname)) {
+				modversions = 1;
+				have_vmlinux = 1;
+			}
+			mod = new_module(NOFAIL(strdup(modname)));
+			mod->skip = 1;
+		}
+		add_exported_symbol(symname, mod, &crc);
+	}
+	return;
+fail:
+	fatal("parse error in symbol dump file\n");
+}
+
+void
+write_dump(const char *fname)
+{
+	struct buffer buf = { };
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
+			buf_printf(&buf, "0x%08x\t%s\t%s\n", symbol->crc,
+				symbol->name, symbol->module->name);
+			symbol = symbol->next;
+		}
+	}
+	write_if_changed(&buf, fname);
+}
+
 int
 main(int argc, char **argv)
 {
 	struct module *mod;
 	struct buffer buf = { };
 	char fname[SZ];
+	char *dump_read = NULL, *dump_write = NULL;
+	int opt;
 
-	for (; argv[1]; argv++) {
-		read_symbols(argv[1]);
+	while ((opt = getopt(argc, argv, "i:o:")) != -1) {
+		switch(opt) {
+			case 'i':
+				dump_read = optarg;
+				break;
+			case 'o':
+				dump_write = optarg;
+				break;
+			default:
+				exit(1);
+		}
+	}
+
+	if (dump_read)
+		read_dump(dump_read);
+
+	while (optind < argc) {
+		read_symbols(argv[optind++]);
 	}
 
 	for (mod = modules; mod; mod = mod->next) {
-		if (is_vmlinux(mod->name))
+		if (mod->skip)
 			continue;
 
 		buf.pos = 0;
@@ -629,6 +729,10 @@ main(int argc, char **argv)
 		sprintf(fname, "%s.mod.c", mod->name);
 		write_if_changed(&buf, fname);
 	}
+
+	if (dump_write)
+		write_dump(dump_write);
+
 	return 0;
 }
 
diff -upr linux-2.6.5/scripts/modpost.h mm4/scripts/modpost.h
--- linux-2.6.5/scripts/modpost.h	2004-04-04 05:36:10.000000000 +0200
+++ mm4/scripts/modpost.h	2004-04-09 20:56:10.000000000 +0200
@@ -73,6 +73,7 @@ struct module {
 	const char *name;
 	struct symbol *unres;
 	int seen;
+	int skip;
 	struct buffer dev_table_buf;
 };
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTHSV64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTHSV6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:58:02 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1029 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261336AbTHSVy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:54:57 -0400
Date: Tue, 19 Aug 2003 23:51:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: kbuild: Separate output directory - core patch
Message-ID: <20030819215157.GA1791@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1269  -> 1.1270 
#	scripts/Makefile.lib	1.20    -> 1.21   
#	scripts/Makefile.modpost	1.4     -> 1.5    
#	            Makefile	1.421   -> 1.422  
#	scripts/Makefile.build	1.39    -> 1.40   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/19	sam@mars.ravnborg.org	1.1270
# kbuild: Separate output directory
# 
# Enable the possibility to build a kernel in a separate output
# directory. This is useful when dealing with several kernel configurations
# based on the same src, or if you do not want to mix source code
# and output files.
# 
# Usage is simple:
# make O=dir/to/kernel/src {usual make targets}
# 
# This patch implements the core part of separate output directory
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Tue Aug 19 23:40:39 2003
+++ b/Makefile	Tue Aug 19 23:40:39 2003
@@ -9,6 +9,9 @@
 # Comments in this file are targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.
 
+# Do not print "Entering directory ..."
+MAKEFLAGS += --no-print-directory
+
 # We are using a recursive build, so we need to do a little thinking
 # to get the ordering right.
 #
@@ -25,6 +28,85 @@
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
+# To put more focus on warnings, be less verbose as default
+# Use 'make V=1' to see the full commands
+
+ifdef V
+  ifeq ("$(origin V)", "command line")
+    KBUILD_VERBOSE = $(V)
+  endif
+endif
+ifndef KBUILD_VERBOSE
+  KBUILD_VERBOSE = 0 
+endif
+
+# Call sparse as part of compilation of C files
+# Use 'make C=1' to enable sparse checking
+
+ifdef C
+  ifeq ("$(origin C)", "command line")
+    KBUILD_CHECKSRC = $(C)
+  endif
+endif
+ifndef KBUILD_CHECKSRC
+  KBUILD_CHECKSRC = 0
+endif
+
+# kbuild support locating output files in a separate directory.
+# To locate output files in a separate directory two syntax'es are supported.
+# In both cases the working directory must be the root of the kernel src.
+# 1) O=
+# Use "make O=dir/to/store/output/files/"
+# 
+# 2) Set KBUILD_OBJ
+# Set the environment variable KBUILD_OBJ to point to the directory
+# where the output files shall be placed.
+# export KBUILD_OBJ=dir/to/store/output/files/
+# make
+#
+# The O= assigment takes precedence over the KBUILD_OBJ environment variable.
+
+# KBUILD_OUTPUT is set on invocation of make in OBJ directory
+ifeq ($(KBUILD_OUTPUT),)
+
+# OK, Make called in directory where kernel src resides
+# Do we want to locate output files in a separate directory?
+ifdef O
+  ifeq ("$(origin O)", "command line")
+    KBUILD_OBJ := $(O)
+  endif
+endif
+
+# Invoke a second make in the output directory, passing relevant variables
+ifneq ($(KBUILD_OBJ),)
+	KBUILD_OBJ := $(shell cd $(KBUILD_OBJ); /bin/pwd)
+%:
+	@$(MAKE) -C $(KBUILD_OBJ)		\
+	KBUILD_OUTPUT=1				\
+	KBUILD_SRC=$(CURDIR)			\
+	KBUILD_VERBOSE=$(KBUILD_VERBOSE)	\
+	KBUILD_CHECK=$(KBUILD_CHECK)		\
+	-f $(CURDIR)/Makefile $(MAKECMDGOALS)
+
+# Leave processing to above invocation of make
+skip-makefile := 1
+endif # ifneq ($(KBUILD_OBJ),)
+endif # ifeq ($(KBUILD_OUTPUT),)
+
+# We process the rest of the Makefile if this is the final invocation of make
+ifeq ($(skip-makefile),)
+
+srctree		:= $(if $(KBUILD_SRC),$(KBUILD_SRC),.)
+TOPDIR		:= $(srctree)
+# FIXME - TOPDIR is obsolete, use srctree/objtree
+objtree		:= $(CURDIR)
+src		:= $(srctree)
+obj		:= $(objtree)
+
+VPATH		:= $(srctree)
+
+export srctree objtree VPATH TOPDIR
+
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
@@ -69,7 +151,6 @@
 CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
 	  else if [ -x /bin/bash ]; then echo /bin/bash; \
 	  else echo sh; fi ; fi)
-TOPDIR	:= $(CURDIR)
 
 HOSTCC  	= gcc
 HOSTCXX  	= g++
@@ -110,40 +191,8 @@
   KBUILD_MODULES := 1
 endif
 
-export KBUILD_MODULES KBUILD_BUILTIN KBUILD_VERBOSE KBUILD_CHECKSRC
-
-# To put more focus on warnings, less verbose as default
-# Use 'make V=1' to see the full commands
-
-ifdef V
-  ifeq ("$(origin V)", "command line")
-    KBUILD_VERBOSE = $(V)
-  endif
-endif
-ifndef KBUILD_VERBOSE
-  KBUILD_VERBOSE = 0 
-endif
-
-# Call sparse as part of compilation of C files
-# Use 'make C=1' to enable sparse checking
-
-ifdef C
-  ifeq ("$(origin C)", "command line")
-    KBUILD_CHECKSRC = $(C)
-  endif
-endif
-ifndef KBUILD_CHECKSRC
-  KBUILD_CHECKSRC = 0
-endif
-
-# Do not print 'Entering directory ...'
-
-MAKEFLAGS += --no-print-directory
-
-# For maximum performance (+ possibly random breakage, uncomment
-# the following)
-
-#MAKEFLAGS += -rR
+export KBUILD_MODULES KBUILD_BUILTIN KBUILD_VERBOSE
+export KBUILD_CHECKSRC KBUILD_OUTPUT
 
 # Beautify output
 # ---------------------------------------------------------------------------
@@ -185,14 +234,13 @@
 
 export quiet Q KBUILD_VERBOSE
 
-# Paths to obj / src tree
+# Look for make include files relative to root of kernel src
+MAKEFLAGS += --include-dir=$(srctree)
 
-src	:= .
-obj	:= .
-srctree := .
-objtree := .
+# For maximum performance (+ possibly random breakage, uncomment
+# the following)
 
-export srctree objtree
+#MAKEFLAGS += -rR
 
 # Make variables (CC, etc...)
 
@@ -222,13 +270,15 @@
 
 NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
 
-CPPFLAGS	:= -D__KERNEL__ -Iinclude
+CPPFLAGS        := -D__KERNEL__ -Iinclude \
+		   $(if $(KBUILD_OUTPUT),-Iinclude2 -I$(srctree)/include)
+
 CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
-	CONFIG_SHELL TOPDIR HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
+	CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
 	HOSTCXX HOSTCXXFLAGS LDFLAGS_BLOB LDFLAGS_MODULE CHECK
 
@@ -283,7 +333,7 @@
 # Handle them one by one.
 
 %:: FORCE
-	$(Q)$(MAKE) $@
+	$(Q)$(MAKE) -C $(srctree) KBUILD_OUTPUT= $@
 
 else
 ifeq ($(config-targets),1)
@@ -311,7 +361,7 @@
 
 -include .config
 
-include arch/$(ARCH)/Makefile
+include $(srctree)/arch/$(ARCH)/Makefile
 
 # Let architecture Makefiles change CPPFLAGS if needed
 CFLAGS += $(CPPFLAGS) $(CFLAGS)
@@ -465,14 +515,34 @@
 # 	Handle descending into subdirectories listed in $(SUBDIRS)
 
 .PHONY: $(SUBDIRS)
-$(SUBDIRS): prepare
+$(SUBDIRS): prepare-all
 	$(Q)$(MAKE) $(build)=$@
 
-#	Things we need done before we descend to build or make
-#	module versions are listed in "prepare"
+# Things we need to do before we recursively start building the kernel
+# or the modules are listed in "prepare-all".
+# A multi level approach is used. prepare1 is updated first, then prepare0.
+# prepare-all is the collection point for the prepare targets.
+
+.PHONY: prepare-all prepare prepare0 prepare1
+
+# prepare1 is used to check if we are building in a separate output directory,
+# and if so do:
+# 1) Check that make has not been executed in the kernel src $(srctree)
+# 2) Create the include2 directory, used for the second asm symlink
+
+prepare1:
+ifneq ($(KBUILD_OUTPUT),)
+	@echo '  Using $(srctree) as source for kernel'
+	$(Q)if [ -h $(srctree)/include/asm -o -f $(srctree)/.config ]; then \
+		echo "  $(srctree) is not clean, please run 'make mrproper'";\
+		echo "  in the '$(srctree)' directory.";\
+		/bin/false; \
+	fi;
+	$(Q)if [ ! -d include2 ]; then mkdir -p include2; fi;
+	$(Q)ln -fsn $(srctree)/include/asm-$(ARCH) include2/asm
+endif
 
-.PHONY: prepare
-prepare: include/linux/version.h include/asm include/config/MARKER
+prepare0: prepare1 include/linux/version.h include/asm include/config/MARKER
 ifdef KBUILD_MODULES
 ifeq ($(origin SUBDIRS),file)
 	$(Q)rm -rf $(MODVERDIR)
@@ -483,6 +553,9 @@
 endif
 	$(if $(CONFIG_MODULES),$(Q)mkdir -p $(MODVERDIR))
 
+# All the preparing..
+prepare-all: prepare0 prepare
+
 #	Leave this as default for preprocessing vmlinux.lds.S, which is now
 #	done in arch/$(ARCH)/kernel/Makefile
 
@@ -511,8 +584,9 @@
 #	before switching between archs anyway.
 
 include/asm:
-	@echo '  Making asm->asm-$(ARCH) symlink'
-	@ln -s asm-$(ARCH) $@
+	@echo '  SYMLINK $@ -> include/asm-$(ARCH)'
+	$(Q)if [ ! -d include ]; then mkdir -p include; fi;
+	@ln -fsn asm-$(ARCH) $@
 
 # 	Split autoconf.h into include/linux/config/*
 
@@ -570,7 +644,7 @@
 .PHONY: modules
 modules: $(SUBDIRS) $(if $(KBUILD_BUILTIN),vmlinux)
 	@echo '  Building modules, stage 2.';
-	$(Q)$(MAKE) -rR -f scripts/Makefile.modpost
+	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
 #	Install modules
 
@@ -583,7 +657,7 @@
 	@rm -f $(MODLIB)/build
 	@mkdir -p $(MODLIB)/kernel
 	@ln -s $(TOPDIR) $(MODLIB)/build
-	$(Q)$(MAKE) -rR -f scripts/Makefile.modinst
+	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
 
 # If System.map exists, run depmod.  This deliberately does not have a
 # dependency on System.map since that would run the dependency tree on
@@ -660,7 +734,8 @@
 	$(MODVERDIR) \
 	.tmp_export-objs \
 	include/config \
-	include/linux/modules
+	include/linux/modules \
+	include2
 
 # clean - Delete all intermediate files
 #
@@ -794,6 +869,7 @@
 		echo '  No architecture specific help defined for $(ARCH)')
 	@echo  ''
 	@echo  '  make V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
+	@echo  '  make O=dir [targets] Locate all build output files in \'dir\', including .config'
 	@echo  '  make C=1   [targets] Check all c source with checker tool'
 	@echo  ''
 	@echo  'Execute "make" or "make all" to build all targets marked with [*] '
@@ -824,7 +900,8 @@
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
 
-a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(AFLAGS_KERNEL) $(NOSTDINC_FLAGS) \
+a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(AFLAGS_KERNEL) \
+	  $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
 
 quiet_cmd_as_o_S = AS      $@
@@ -882,6 +959,7 @@
 define filechk
 	@set -e;				\
 	echo '  CHK     $@';			\
+	mkdir -p $(dir $@);			\
 	$(filechk_$(1)) < $< > $@.tmp;		\
 	if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
 		rm -f $@.tmp;			\
@@ -894,16 +972,18 @@
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=dir
 # Usage:
 # $(Q)$(MAKE) $(build)=dir
-build := -f scripts/Makefile.build obj
+build := -f $(if $(KBUILD_OUTPUT),$(srctree)/)scripts/Makefile.build obj
 
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.clean obj=dir
 # Usage:
 # $(Q)$(MAKE) $(clean)=dir
-clean := -f scripts/Makefile.clean obj
+clean := -f $(if $(KBUILD_OUTPUT),$(srctree)/)scripts/Makefile.clean obj
 
 #	$(call descend,<dir>,<target>)
 #	Recursively call a sub-make in <dir> with target <target>
 # Usage is deprecated, because make does not see this as an invocation of make.
-descend =$(Q)$(MAKE) -f scripts/Makefile.build obj=$(1) $(2)
+descend =$(Q)$(MAKE) -f $(if $(KBUILD_OUTPUT),$(srctree)/)scripts/Makefile.build obj=$(1) $(2)
+
+endif	# skip-makefile
 
 FORCE:
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	Tue Aug 19 23:40:39 2003
+++ b/scripts/Makefile.build	Tue Aug 19 23:40:39 2003
@@ -14,6 +14,16 @@
 
 include scripts/Makefile.lib
 
+ifneq ($(KBUILD_OUTPUT),)
+# Create output directory if not already present
+_dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
+
+# Create directories for object files if directory does not exist
+# Needed when obj-y := dir/file.o syntax is used
+_dummy := $(foreach d,$(obj-dirs), $(shell [ -d $(d) ] || mkdir -p $(d)))
+endif
+
+
 ifdef EXTRA_TARGETS
 $(warning kbuild: $(obj)/Makefile - Usage of EXTRA_TARGETS is obsolete in 2.5. Please fix!)
 endif
diff -Nru a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib	Tue Aug 19 23:40:39 2003
+++ b/scripts/Makefile.lib	Tue Aug 19 23:40:39 2003
@@ -58,6 +58,9 @@
 # in the local directory
 subdir-obj-y := $(foreach o,$(obj-y),$(if $(filter-out $(o),$(notdir $(o))),$(o)))
 
+# $(obj-dirs) is a list of directories that contain object files
+obj-dirs := $(filter-out ./, $(sort $(dir $(multi-objs) $(subdir-obj-y))))
+
 # Replace multi-part objects by their individual parts, look at local dir only
 real-objs-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m))) $(extra-y)
 real-objs-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
@@ -107,6 +110,7 @@
 multi-objs-y	:= $(addprefix $(obj)/,$(multi-objs-y))
 multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
+obj-dirs	:= $(addprefix $(obj)/,$(obj-dirs))
 host-progs      := $(addprefix $(obj)/,$(host-progs))
 host-csingle	:= $(addprefix $(obj)/,$(host-csingle))
 host-cmulti	:= $(addprefix $(obj)/,$(host-cmulti))
@@ -129,15 +133,46 @@
 #       where foo and bar are the name of the modules.
 basename_flags = -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))
 modname_flags  = $(if $(filter 1,$(words $(modname))),-DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname))))
-c_flags        = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
-	         $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
-	         $(basename_flags) $(modname_flags)
-a_flags        = -Wp,-MD,$(depfile) $(AFLAGS) $(NOSTDINC_FLAGS)\
-		 $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
-hostc_flags    = -Wp,-MD,$(depfile) $(HOSTCFLAGS) $(HOST_EXTRACFLAGS)\
-		 $(HOSTCFLAGS_$(*F).o)
-hostcxx_flags  = -Wp,-MD,$(depfile) $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS)\
-		 $(HOSTCXXFLAGS_$(*F).o)
+
+
+_c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
+_a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
+_hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   $(HOSTCFLAGS_$(*F).o)
+_hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) $(HOSTCXXFLAGS_$(*F).o)
+
+
+# If building the kernel in a separate objtree expand all occurrences
+# of -Idir to -Idir -I$(srctree)/dir.
+# hereby allowing gcc to locate files in both trees. Local tree first.
+
+ifeq ($(KBUILD_OUTPUT),)
+__c_flags	= $(_c_flags)
+__a_flags	= $(_a_flags)
+__hostc_flags	= $(_hostc_flags)
+__hostcxx_flags	= $(_hostcxx_flags)
+else
+flags = $(foreach o,$($(1)),\
+	$(if $(filter -I%,$(o)),$(patsubst -I%,-I$(srctree)/%,$(o)),$(o)))
+
+# -I$(obj) locate generated .h files
+# -I$(srctree)/$(src) locate .h files in srctree, from generated .c files
+# FIXME: Replace both with specific EXTRA_CFLAGS statements
+__c_flags	= -I$(obj) -I$(srctree)/$(src) $(call flags,_c_flags)
+__a_flags	=                              $(call flags,_a_flags)
+__hostc_flags	= -I$(obj)                     $(call flags,_hostc_flags)
+__hostcxx_flags	=                              $(call flags,_hostcxx_flags)
+endif
+
+c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
+		 $(__c_flags) $(modkern_cflags) \
+		 $(basename_flags) $(modname_flags)
+
+a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
+		 $(__a_flags) $(modkern_aflags)
+
+hostc_flags    = -Wp,-MD,$(depfile) $(__hostc_flags)
+hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
+
 ld_flags       = $(LDFLAGS) $(EXTRA_LDFLAGS)
 
 # Finds the multi-part object the current object will be linked into
@@ -230,9 +265,9 @@
 #	$(call descend,<dir>,<target>)
 #	Recursively call a sub-make in <dir> with target <target> 
 # Usage is deprecated, because make do not see this as an invocation of make.
-descend =$(Q)$(MAKE) -f scripts/Makefile.build obj=$(1) $(2)
+descend =$(Q)$(MAKE) -f $(if $(KBUILD_OUTPUT),$(srctree)/)scripts/Makefile.build obj=$(1) $(2)
 
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=
 # Usage:
 # $(Q)$(MAKE) $(build)=dir
-build := -f scripts/Makefile.build obj
+build := -f $(if $(KBUILD_OUTPUT),$(srctree)/)scripts/Makefile.build obj
diff -Nru a/scripts/Makefile.modpost b/scripts/Makefile.modpost
--- a/scripts/Makefile.modpost	Tue Aug 19 23:40:39 2003
+++ b/scripts/Makefile.modpost	Tue Aug 19 23:40:39 2003
@@ -35,7 +35,7 @@
 # Compile version info for unresolved symbols
 
 quiet_cmd_cc_o_c = CC      $@
-      cmd_cc_o_c = $(CC) -Wp,-MD,$(depfile) $(CFLAGS) $(CFLAGS_MODULE)	\
+      cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE)	\
 		   -c -o $@ $<
 
 $(modules:.ko=.mod.o): %.mod.o: %.mod.c FORCE

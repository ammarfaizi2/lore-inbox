Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWFZBCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWFZBCF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWFZA7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:59:41 -0400
Received: from terminus.zytor.com ([192.83.249.54]:21135 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964985AbWFZA67
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:59 -0400
Date: Sun, 25 Jun 2006 17:58:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 19/43] klibc basic build infrastructure
Message-Id: <klibc.200606251757.19@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basic infrastructure for building klibc.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 5bba564a5c133369b3e83e5827d053a98cb3c59a
tree 11f2acc1f9d845e8764fa790f522b79ea1106b80
parent 378abd8f4d39024ea6c87eb5b54155238f647f0d
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:08 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:08 -0700

 scripts/Kbuild.klibc |  358 ++++++++++++++++++++++++++++++++++++++++++++++++++
 usr/Kbuild           |   75 ++++++++++
 2 files changed, 433 insertions(+), 0 deletions(-)

diff --git a/scripts/Kbuild.klibc b/scripts/Kbuild.klibc
new file mode 100644
index 0000000..ac0439e
--- /dev/null
+++ b/scripts/Kbuild.klibc
@@ -0,0 +1,358 @@
+# ==========================================================================
+# Support for building klibc and related programs
+# ==========================================================================
+#
+# To create a kbuild file for a userspace program do the following:
+#
+# Kbuild:
+#
+# static-y := cat
+# # This will compile a file named cat.c -> the executable 'cat'
+# # The executable will be linked statically
+#
+# shared-y := cats
+# # This will compile a file named cats.c -> the executable 'cats'
+# # The executable will be linked shared
+#
+# If the userspace program consist of more files do the following:
+# Kbuild:
+#
+# static-y   := ipconfig
+# ipconfig-y := main.o netdev.c
+# So ipconfig will be linked statically using the two .o files
+# specified with ipconfig-y.
+#
+# To set directory wide CFLAGS use:
+# EXTRA_KLIBCCFLAGS := -DDEBUG
+# To set directory wide AFLAGS use:
+# EXTRA_KLIBCAFLAGS := -DDEBUG
+#
+# To set target specific CFLAGS (for .c files) use
+# KLIBCCFLAGS-main.o := -DDEBUG=3
+# To set target specific AFLAGS (for .s files) use
+# KLIBCAFLAGS-main.o := -DDEBUG=3
+
+src := $(obj)
+# Preset target and make sure it is a ':=' variable
+targets :=
+
+.phony: __build
+__build:
+
+# Read .config if it exist, otherwise ignore
+-include .config
+
+# Generic Kbuild routines
+include $(srctree)/scripts/Kbuild.include
+
+# Defines used when compiling early userspace (klibc programs)
+# ---------------------------------------------------------------------------
+
+KLIBCREQFLAGS     :=
+KLIBCARCHREQFLAGS :=
+KLIBCOPTFLAGS     :=
+KLIBCWARNFLAGS    := -W -Wall -Wno-sign-compare -Wno-unused-parameter
+KLIBCSHAREDFLAGS  :=
+KLIBCBITSIZE      :=
+KLIBCLDFLAGS      :=
+KLIBCCFLAGS       :=
+
+# Arch specific definitions for klibc
+include $(KLIBCSRC)/arch/$(KLIBCARCHDIR)/MCONFIG
+
+# include/asm-* architecture
+KLIBCASMARCH	  ?= $(KLIBCARCH)
+
+# klibc version
+KLIBCMAJOR        := $(shell cut -d. -f1 $(srctree)/usr/klibc/version)
+KLIBCMINOR        := $(shell cut -d. -f2 $(srctree)/usr/klibc/version)
+
+# binutils
+KLIBCLD          := $(LD)
+KLIBCCC          := $(CC)
+KLIBCAR          := $(AR)
+KLIBCRANLIB      := $(RANLIB)
+KLIBCSTRIP       := $(STRIP)
+KLIBCNM          := $(NM)
+KLIBCOBJCOPY	 := $(OBJCOPY)
+KLIBCOBJDUMP	 := $(OBJDUMP)
+
+# klibc include paths
+KLIBCCPPFLAGS    := -I$(KLIBCINC)/arch/$(KLIBCARCHDIR)	\
+                    -I$(KLIBCINC)/bits$(KLIBCBITSIZE)	\
+		    -I$(KLIBCOBJ)/../include		\
+                    -I$(KLIBCINC)
+# kernel include paths
+KLIBCKERNELSRC	 ?= $(srctree)/
+KLIBCCPPFLAGS    += -I$(KLIBCKERNELSRC)include		\
+                     $(if $(KBUILD_SRC),-I$(KLIBCKERNELOBJ)include2 -I$(KLIBCKERNELOBJ)include -I$(srctree)/include)    \
+		     $(KLIBCARCHINCFLAGS)
+
+# klibc definitions
+KLIBCDEFS        += -D__KLIBC__=$(KLIBCMAJOR)          \
+		    -D__KLIBC_MINOR__=$(KLIBCMINOR)    \
+		    -D_BITSIZE=$(KLIBCBITSIZE)
+KLIBCCPPFLAGS    += $(KLIBCDEFS)
+KLIBCCFLAGS      += $(KLIBCCPPFLAGS) $(KLIBCREQFLAGS) $(KLIBCARCHREQFLAGS)  \
+                    $(KLIBCOPTFLAGS) $(KLIBCWARNFLAGS)
+KLIBCAFLAGS      += -D__ASSEMBLY__ $(KLIBCCFLAGS)
+KLIBCSTRIPFLAGS  += --strip-all -R .comment -R .note
+
+KLIBCLIBGCC_DEF  := $(shell $(KLIBCCC) $(KLIBCCFLAGS) --print-libgcc)
+KLIBCLIBGCC	 ?= $(KLIBCLIBGCC_DEF)
+KLIBCCRT0        := $(KLIBCOBJ)/arch/$(KLIBCARCHDIR)/crt0.o
+KLIBCLIBC        := $(KLIBCOBJ)/libc.a
+KLIBCCRTSHARED   := $(KLIBCOBJ)/interp.o
+KLIBCLIBCSHARED  := $(KLIBCOBJ)/libc.so
+# How to tell the linker main() is the entrypoint
+KLIBCEMAIN	 ?= -e main
+
+#
+# This indicates the location of the final version of the shared library.
+# THIS MUST BE AN ABSOLUTE PATH WITH NO FINAL SLASH.
+# Leave this empty to make it the root.
+#
+SHLIBDIR = /lib
+
+export KLIBCLD KLIBCCC KLIBCAR KLIBCSTRIP KLIBCNM
+export KLIBCCFLAGS KLIBCAFLAGS KLIBCLIBGCC KLIBCSHAREDFLAGS KLIBCSTRIPFLAGS
+export KLIBCCRT0 KLIBCLIBC SHLIBDIR
+
+# kernel configuration
+include .config
+
+# Add $(obj)/ for paths that is not absolute
+objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
+
+# Kbuild file in the directory that is being build
+include $(obj)/Kbuild
+
+#####
+# static-y + shared-y handling
+klibc-progs := $(static-y) $(shared-y)
+# klibc-progs based on a single .o file (with same name + .o)
+klibc-objs := $(foreach p, $(klibc-progs), $(if $($(p)-y),,$(p)))
+klibc-objs := $(addsuffix .o, $(klibc-objs))
+# klibc-progs which is based on several .o files
+klibc-multi := $(foreach p, $(klibc-progs), $(if $($(p)-y),$(p)))
+# objects used for klibc-progs with more then one .o file
+klibc-objs += $(foreach p, $(klibc-multi), $($(p)-y))
+# objects build in this dir
+klibc-real-objs := $(patsubst %/,,$(klibc-objs))
+# Directories we need to visit before klibc-objs are up-to-date
+klibc-dirs :=  $(patsubst %/,%,$(filter %/, $(klibc-objs)))
+# replace all dir/ with dir/lib.a
+klibc-objs := $(patsubst %/, %/lib.a, $(klibc-objs))
+
+targets += $(static-y) $(shared-y)
+
+# $(output-dirs) are a list of directories that contain object files
+output-dirs := $(dir $(klibc-dirs) $(klibc-objs))
+output-dirs += $(foreach f, $(hostprogs-y) $(targets), \
+               $(if $(dir $(f)), $(dir $(f))))
+output-dirs := $(strip $(sort $(filter-out ./,$(output-dirs))))
+
+# prefix so we get full dir
+static-y        := $(addprefix $(obj)/,$(static-y))
+shared-y        := $(addprefix $(obj)/,$(shared-y))
+klibc-objs      := $(addprefix $(obj)/,$(klibc-objs))
+klibc-real-objs := $(addprefix $(obj)/,$(klibc-real-objs))
+output-dirs     := $(addprefix $(obj)/,$(output-dirs))
+klibc-dirs      := $(addprefix $(obj)/,$(klibc-dirs))
+subdir-y        := $(addprefix $(obj)/,$(subdir-y))
+lib-y           := $(addprefix $(obj)/,$(lib-y))
+always          := $(addprefix $(obj)/,$(always))
+targets         := $(addprefix $(obj)/,$(targets))
+
+#####
+# Handle options to gcc. Support building with separate output directory
+
+__klibccflags    = $(KLIBCCFLAGS) $(EXTRA_KLIBCCFLAGS) $(KLIBCCFLAGS_$(*F).o)
+__klibcaflags    = $(KLIBCAFLAGS) $(EXTRA_KLIBCAFLAGS) $(KLIBCAFLAGS_$(*F).o)
+
+ifeq ($(KBUILD_SRC),)
+_klibccflags    = $(__klibccflags)
+_klibcaflags    = $(__klibcaflags)
+else
+_klibccflags    = $(call flags,__klibccflags)
+_klibcaflags    = $(call flags,__klibcaflags)
+endif
+
+klibccflags     = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(_klibccflags)
+klibcaflags     = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(_klibcaflags)
+
+# Create output directory if not already present
+_dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
+
+# Create directories for object files if directory does not exist
+# Needed when lib-y := dir/file.o syntax is used
+_dummy := $(foreach d,$(output-dirs), $(shell [ -d $(d) ] || mkdir -p $(d)))
+
+# Do we have to make a lib.a in this dir?
+ifneq ($(strip $(lib-y) $(lib-n) $(lib-)),)
+lib-target := $(obj)/lib.a
+endif
+
+__build: $(subdir-y) $(lib-target) $(always)
+	@:
+
+# Compile C sources (.c)
+# ---------------------------------------------------------------------------
+
+quiet_cmd_cc_s_c = KLIBCCC $@
+      cmd_cc_s_c = $(KLIBCCC) $(klibccflags) -S -o $@ $<
+
+%.s: %.c FORCE
+	$(call if_changed_dep,cc_s_c)
+
+quiet_cmd_cc_o_c = KLIBCCC $@
+      cmd_cc_o_c = $(KLIBCCC) $(klibccflags) -c -o $@ $<
+
+%.o: %.c FORCE
+	$(call if_changed_dep,cc_o_c)
+
+quiet_cmd_cc_i_c = CPP     $@
+      cmd_cc_i_c = $(KLIBCCC) -E $(klibccflags) -o $@ $<
+%.i: %.c FORCE
+	$(call if_changed_dep,cc_i_c)
+
+# Compile assembler sources (.S)
+# ---------------------------------------------------------------------------
+
+quiet_cmd_as_o_S = KLIBCAS $@
+      cmd_as_o_S = $(KLIBCCC) $(klibcaflags) -c -o $@ $<
+
+%.o: %.S FORCE
+	$(call if_changed_dep,as_o_S)
+
+targets += $(real-objs-y)
+
+#
+# Rule to compile a set of .o files into one .o file
+#
+ifdef lib-target
+quiet_cmd_link_o_target = LD      $@
+# If the list of objects to link is empty, just create an empty lib.a
+cmd_link_o_target = $(if $(strip $(lib-y)),\
+                    rm -f $@; $(KLIBCAR) cru $@ $(filter $(lib-y), $^),\
+                    rm -f $@; $(KLIBCAR) crs $@)
+
+$(lib-target): $(lib-y) FORCE
+	$(call if_changed,link_o_target)
+targets += $(lib-target) $(lib-y)
+endif # lib-target
+
+
+ifdef klibc-progs
+# Compile klibcspace programs for the target
+# ===========================================================================
+
+__build : $(klibc-dirs) $(static-y) $(shared-y)
+
+# Descend if needed
+$(sort $(addsuffix /lib.a,$(klibc-dirs))): $(klibc-dirs) ;
+
+# Define dependencies for link of progs
+# For the simple program:
+#	file.o => file
+# A program with multiple objects
+#	filea.o, fileb.o => file
+# A program with .o files in another dir
+#	dir/lib.a filea.o => file
+
+stripobj  = $(subst $(obj)/,,$@)
+addliba   = $(addprefix $(obj)/, $(patsubst %/, %/lib.a, $(1)))
+link-deps = $(if $($(stripobj)-y), $(call addliba, $($(stripobj)-y)), $@.o)
+
+quiet_cmd_ld-static = KLIBCLD $@
+      cmd_ld-static = $(KLIBCLD) $(KLIBCLDFLAGS) -o $@    	\
+                       $(EXTRA_KLIBCLDFLAGS)              	\
+                       $(KLIBCCRT0)                       	\
+                       $(link-deps)                       	\
+                       --start-group $(KLIBCLIBC) 	  	\
+		       $(KLIBCLIBGCC) --end-group ;       	\
+                      cp -f $@ $@.g ;                     	\
+                      $(KLIBCSTRIP) $(KLIBCSTRIPFLAGS) $@
+
+
+$(static-y): $(klibc-objs) $(lib-target) $(KLIBCCRT0) $(KLIBCLIBC) FORCE
+	$(call if_changed,ld-static)
+
+quiet_cmd_ld-shared = KLIBCLD $@
+      cmd_ld-shared = $(KLIBCLD) $(KLIBCLDFLAGS) -o $@    	\
+                       $(EXTRA_KLIBCLDFLAGS)              	\
+                       $(KLIBCEMAIN) $(KLIBCCRTSHARED)    	\
+                       $(link-deps)                       	\
+                       --start-group -R $(KLIBCLIBCSHARED) 	\
+	               $(KLIBCLIBGCC) --end-group ;		\
+                      cp -f $@ $@.g ;                     	\
+                      $(KLIBCSTRIP) $(KLIBCSTRIPFLAGS) $@
+
+
+$(shared-y): $(klibc-objs) $(lib-target) $(KLIBCCRTSHARED) \
+                                         $(KLIBCLIBCSHARED) FORCE
+	$(call if_changed,ld-shared)
+
+# Do not try to build KLIBC libaries if we are building klibc
+ifeq ($(klibc-build),)
+$(KLIBCCRT0) $(KLIBCLIBC): ;
+$(KLIBCCRTSHARED) $(KLIBCLIBCSHARED): ;
+endif
+
+targets += $(klibc-real-objs)
+endif
+
+# Compile programs on the host
+# ===========================================================================
+ifdef hostprogs-y
+include $(srctree)/scripts/Makefile.host
+endif
+
+# Descending
+# ---------------------------------------------------------------------------
+
+.PHONY: $(subdir-y) $(klibc-dirs)
+$(subdir-y) $(klibc-dirs):
+	$(Q)$(MAKE) $(klibc)=$@
+
+# Add FORCE to the prequisites of a target to force it to be always rebuilt.
+# ---------------------------------------------------------------------------
+
+.PHONY: FORCE
+
+FORCE:
+
+# Linking
+# Create a reloctable composite object file
+# ---------------------------------------------------------------------------
+quiet_cmd_klibcld = KLIBCLD $@
+      cmd_klibcld = $(KLIBCLD) -r $(KLIBCLDFLAGS) \
+                                $(EXTRA_KLIBCLDFLAGS) $(KLIBCLDFLAGS_$(@F)) \
+                                $(filter-out FORCE,$^) -o $@
+
+
+# Link target to a new name
+# ---------------------------------------------------------------------------
+quiet_cmd_ln = LN      $@
+      cmd_ln = rm -f $@ && ln $< $@
+
+# Strip target (remove all debugging info)
+quiet_cmd_strip = STRIP   $@
+      cmd_strip = $(KLIBCSTRIP) $(KLIBCSTRIPFLAGS) $< -o $@
+
+
+# Read all saved command lines and dependencies for the $(targets) we
+# may be building above, using $(if_changed{,_dep}). As an
+# optimization, we don't need to read them if the target does not
+# exist, we will rebuild anyway in that case.
+targets := $(wildcard $(sort $(targets)))
+cmd_files := $(wildcard $(foreach f,$(targets),$(dir $(f)).$(notdir $(f)).cmd))
+
+ifneq ($(cmd_files),)
+  include $(cmd_files)
+endif
+
+# Shorthand for $(Q)$(MAKE) -f scripts/Kbuild.klibc obj
+# Usage:
+# $(Q)$(MAKE) $(klibc)=dir
+klibc := -rR -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Kbuild.klibc obj
diff --git a/usr/Kbuild b/usr/Kbuild
new file mode 100644
index 0000000..f874f51
--- /dev/null
+++ b/usr/Kbuild
@@ -0,0 +1,75 @@
+#
+# kbuild file for usr/ - including initramfs image and klibc
+#
+
+CONFIG_KLIBC := 1
+
+include-subdir := include
+klibc-subdir := klibc
+usr-subdirs  := kinit utils dash gzip
+subdir-      := $(include-subdir) $(klibc-subdir) $(usr-subdirs)
+
+usr-subdirs  := $(addprefix _usr_,$(usr-subdirs))
+klibc-subdir := $(addprefix _usr_,$(klibc-subdir))
+
+# Klibc binaries
+ifdef CONFIG_KLIBC
+
+# .initramfs_data.cpio.gz.d is used to identify all files included
+# in initramfs and to detect if any files are added/removed.
+# Removed files are identified by directory timestamp being updated
+# The dependency list is generated by gen_initramfs.sh -l
+ifneq ($(wildcard $(obj)/.initramfs_data.cpio.gz.d),)
+	include $(obj)/.initramfs_data.cpio.gz.d
+endif
+
+# build klibc library before the klibc programs
+# build klibc programs before cpio.gz
+.PHONY: initramfs $(usr-subdirs) $(klibc-subdir) $(include-subdir)
+initramfs:         $(usr-subdirs) $(klibc-subdir) $(include-subdir)
+$(deps_initramfs): $(usr-subdirs) $(klibc-subdir) $(include-subdir)
+
+$(usr-subdirs): $(klibc-subdir)
+	$(Q)$(MAKE) $(klibc)=$(src)/$(patsubst _usr_%,%,$(@))
+
+$(klibc-subdir): $(include-subdir)
+	$(Q)$(MAKE) $(klibc)=$(src)/$(patsubst _usr_%,%,$(@))
+
+$(include-subdir):
+	$(Q)$(MAKE) $(klibc)=$(src)/$(patsubst _usr_%,%,$(@))
+endif
+
+
+# Generate builtin.o based on initramfs_data.o
+obj-y := initramfs_data.o
+
+# initramfs_data.o contains the initramfs_data.cpio.gz image.
+# The image is included using .incbin, a dependency which is not
+# tracked automatically.
+$(obj)/initramfs_data.o: $(obj)/initramfs_data.cpio.gz FORCE
+
+#####
+# Generate the initramfs cpio archive
+
+hostprogs-y := gen_init_cpio
+ginitramfs  := $(CONFIG_SHELL) $(srctree)/scripts/gen_initramfs_list.sh
+ramfs-def   := $(srctree)/$(src)/initramfs.default
+ramfs-input := $(shell echo $(CONFIG_INITRAMFS_SOURCE))
+ramfs-input := $(if $(ramfs-input), $(ramfs-input), $(ramfs-def))
+
+ramfs-args  := \
+        $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
+        $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID))
+
+quiet_cmd_initfs = GEN     $@
+      cmd_initfs = $(ginitramfs) -o $@ $(ramfs-args) $(ramfs-input)
+
+targets := initramfs_data.cpio.gz
+# We rebuild initramfs_data.cpio.gz if:
+# 1) Any included file is newer then initramfs_data.cpio.gz
+# 2) There are changes in which files are included (added or deleted)
+# 3) If gen_init_cpio are newer than initramfs_data.cpio.gz
+# 4) arguments to gen_initramfs.sh changes
+$(obj)/initramfs_data.cpio.gz: $(obj)/gen_init_cpio $(deps_initramfs) initramfs
+	$(Q)$(ginitramfs) -l $(ramfs-input) > $(obj)/.initramfs_data.cpio.gz.d
+	$(call if_changed,initfs)

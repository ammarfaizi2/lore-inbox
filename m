Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423172AbWF1F10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423172AbWF1F10 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423162AbWF1F1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:27:04 -0400
Received: from terminus.zytor.com ([192.83.249.54]:4814 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423172AbWF1FTL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:11 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 24/31] klibc basic build infrastructure
Date: Tue, 27 Jun 2006 22:17:24 -0700
Message-Id: <klibc.200606272217.24@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basic infrastructure for building klibc.
Mostly written by Sam Ravnborg <sam@ravnborg.org>.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 412867937f3298c6ab1b4a3d6fc8050214a1b7c0
tree 077c26fc13a808e6b0d7cad04e5898081da5a4ac
parent b202cbd956d9433d6e00cabb63546773c10680a9
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:09 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:09 -0700

 scripts/Kbuild.include        |    5 +
 scripts/Kbuild.klibc          |  358 +++++++++++++++++++++++++++++++++++++++++
 scripts/gen_initramfs_list.sh |   51 ++----
 usr/Kbuild                    |   75 +++++++++
 usr/Kconfig                   |   21 ++
 usr/Makefile                  |   47 -----
 usr/initramfs.default         |    9 +
 7 files changed, 488 insertions(+), 78 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index b0d067b..3c90468 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -87,6 +87,11 @@ # Usage:
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.build obj
 
+# Shorthand for $(Q)$(MAKE) -f scripts/Kbuild.klibc obj=
+# Usage:
+# $(Q)$(MAKE) $(klibc)=dir
+klibc := -f $(srctree)/scripts/Kbuild.klibc obj
+
 # Prefix -I with $(srctree) if it is not an absolute path
 addtree = $(if $(filter-out -I/%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1))) $(1)
 # Find all -I options and call addtree
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
diff --git a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
index 331c079..624015c 100644
--- a/scripts/gen_initramfs_list.sh
+++ b/scripts/gen_initramfs_list.sh
@@ -15,7 +15,7 @@ set -e
 usage() {
 cat << EOF
 Usage:
-$0 [-o <file>] [-u <uid>] [-g <gid>] {-d | <cpio_source>} ...
+$0 [-o <file>] [-u <uid>] [-g <gid>] <cpio_source> ...
 	-o <file>      Create gzipped initramfs file named <file> using
 	               gen_init_cpio and gzip
 	-u <uid>       User ID to map to user ID 0 (root).
@@ -27,7 +27,6 @@ Usage:
 	<cpio_source>  File list or directory for cpio archive.
 	               If <cpio_source> is a .cpio file it will be used
 		       as direct input to initramfs.
-	-d             Output the default cpio list.
 
 All options except -o and -l may be repeated and are interpreted
 sequentially and immediately.  -u and -g states are preserved across
@@ -36,23 +35,6 @@ to reset the root/group mapping.
 EOF
 }
 
-list_default_initramfs() {
-	# echo usr/kinit/kinit
-	:
-}
-
-default_initramfs() {
-	cat <<-EOF >> ${output}
-		# This is a very simple, default initramfs
-
-		dir /dev 0755 0 0
-		nod /dev/console 0600 0 0 c 5 1
-		dir /root 0700 0 0
-		# file /kinit usr/kinit/kinit 0755 0 0
-		# slink /init kinit 0755 0 0
-	EOF
-}
-
 filetype() {
 	local argv1="$1"
 
@@ -167,8 +149,6 @@ header() {
 
 # process one directory (incl sub-directories)
 dir_filelist() {
-	${dep_list}header "$1"
-
 	srcdir=$(echo "$1" | sed -e 's://*:/:g')
 	dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n" 2>/dev/null)
 
@@ -187,9 +167,7 @@ # if only one file is specified and it i
 # if a directory is specified then add all files in given direcotry to fs
 # if a regular file is specified assume it is in gen_initramfs format
 input_file() {
-	source="$1"
 	if [ -f "$1" ]; then
-		${dep_list}header "$1"
 		is_cpio="$(echo "$1" | sed 's/^.*\.cpio/cpio/')"
 		if [ $2 -eq 0 -a ${is_cpio} == "cpio" ]; then
 			cpio_file=$1
@@ -214,6 +192,15 @@ input_file() {
 	fi
 }
 
+# input file/dir - process it
+process_file() {
+	if [ -z ${print_header} ]; then
+		${dep_list}header "$1"
+	fi
+	print_header=y
+	input_file "$1" "$2"
+}
+
 prog=$0
 root_uid=0
 root_gid=0
@@ -249,27 +236,29 @@ while [ $# -gt 0 ]; do
 			root_gid="$1"
 			shift
 			;;
-		"-d")	# display default initramfs list
-			default_list="$arg"
-			${dep_list}default_initramfs
-			;;
 		"-h")
 			usage
 			exit 0
 			;;
 		*)
 			case "$arg" in
-				"-"*)
-					unknown_option
+				"-"*)	unknown_option
 					;;
-				*)	# input file/dir - process it
-					input_file "$arg" "$#"
+				*)	process_file "$arg" "$#"
 					;;
 			esac
 			;;
 	esac
 done
 
+# trailer of dependency list
+if [ ! -z ${dep_list} ]; then
+	echo ""
+	echo "initramfs: \$(deps_initramfs)"
+	echo "\$(deps_initramfs): ;"
+	echo ""
+fi
+
 # If output_file is set we will generate cpio archive and gzip it
 # we are carefull to delete tmp files
 if [ ! -z ${output_file} ]; then
diff --git a/usr/Kbuild b/usr/Kbuild
new file mode 100644
index 0000000..4b2be06
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
+usr-subdirs  := kinit
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
diff --git a/usr/Kconfig b/usr/Kconfig
index 07727f3..cf6bad6 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -44,3 +44,24 @@ config INITRAMFS_ROOT_GID
 	  owned by group root in the initial ramdisk image.
 
 	  If you are not sure, leave it set to "0".
+
+config KLIBC_ERRLIST
+	bool "Early userspace real error messages" if EMBEDDED
+	default y
+	help
+	  If this is set, kinit (and other klibc-derived binaries)
+	  will have the standard list of error messages built in, and
+	  thus will report, for example, "No such file or directory"
+	  instead of "Error 1".  Leaving it out will save
+	  approximately 4K from each static binary (one, unless you
+	  have a different initramfs_source.txt) or the shared
+	  library.
+
+	  If you are not sure, "Y" is highly recommended.
+
+config KLIBC_ZLIB
+	bool
+	default y
+	help
+	  This builds the zlib portion of klibc.  This is currently
+	  required.
diff --git a/usr/Makefile b/usr/Makefile
deleted file mode 100644
index e938242..0000000
--- a/usr/Makefile
+++ /dev/null
@@ -1,47 +0,0 @@
-#
-# kbuild file for usr/ - including initramfs image
-#
-
-klibcdirs:;
-
-# Generate builtin.o based on initramfs_data.o
-obj-y := initramfs_data.o
-
-# initramfs_data.o contains the initramfs_data.cpio.gz image.
-# The image is included using .incbin, a dependency which is not
-# tracked automatically.
-$(obj)/initramfs_data.o: $(obj)/initramfs_data.cpio.gz FORCE
-
-#####
-# Generate the initramfs cpio archive
-
-hostprogs-y := gen_init_cpio
-initramfs   := $(CONFIG_SHELL) $(srctree)/scripts/gen_initramfs_list.sh
-ramfs-input := $(if $(filter-out "",$(CONFIG_INITRAMFS_SOURCE)), \
-                    $(CONFIG_INITRAMFS_SOURCE),-d)
-ramfs-args  := \
-        $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
-        $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID))
-
-# .initramfs_data.cpio.gz.d is used to identify all files included
-# in initramfs and to detect if any files are added/removed.
-# Removed files are identified by directory timestamp being updated
-# The dependency list is generated by gen_initramfs.sh -l
-ifneq ($(wildcard $(obj)/.initramfs_data.cpio.gz.d),)
-	include $(obj)/.initramfs_data.cpio.gz.d
-endif
-
-quiet_cmd_initfs = GEN     $@
-      cmd_initfs = $(initramfs) -o $@ $(ramfs-args) $(ramfs-input)
-
-targets := initramfs_data.cpio.gz
-$(deps_initramfs): klibcdirs
-# We rebuild initramfs_data.cpio.gz if:
-# 1) Any included file is newer then initramfs_data.cpio.gz
-# 2) There are changes in which files are included (added or deleted)
-# 3) If gen_init_cpio are newer than initramfs_data.cpio.gz
-# 4) arguments to gen_initramfs.sh changes
-$(obj)/initramfs_data.cpio.gz: $(obj)/gen_init_cpio $(deps_initramfs) klibcdirs
-	$(Q)$(initramfs) -l $(ramfs-input) > $(obj)/.initramfs_data.cpio.gz.d
-	$(call if_changed,initfs)
-
diff --git a/usr/initramfs.default b/usr/initramfs.default
new file mode 100644
index 0000000..d23437a
--- /dev/null
+++ b/usr/initramfs.default
@@ -0,0 +1,9 @@
+#####################
+# This is a very simple, default initramfs
+# See gen_init_cpio for syntax
+
+dir dev 0755 0 0
+nod dev/console 0600 0 0 c 5 1
+dir root 0700 0 0
+file kinit usr/kinit/kinit 0755 0 0
+slink init kinit 0755 0 0

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUCBSky (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 13:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbUCBSky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 13:40:54 -0500
Received: from NS1.idleaire.net ([65.220.16.2]:33470 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S261731AbUCBSkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 13:40:10 -0500
Subject: [PATCH 1/3] Auto checkout for kbuild
From: Dave Dillow <ddillow@idleaire.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-idPoI1HPuc/krFvgQT71"
Message-Id: <1078252807.31309.23.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 13:40:07 -0500
X-OriginalArrivalTime: 02 Mar 2004 18:40:07.0436 (UTC) FILETIME=[C8E5A4C0:01C40085]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-idPoI1HPuc/krFvgQT71
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The initial support for auto checkout from the repository for missing or
updated files.
-- 
Dave Dillow <ddillow@idleaire.com>

--=-idPoI1HPuc/krFvgQT71
Content-Disposition: attachment; filename=autoget-basic.patch
Content-Type: text/plain; name=autoget-basic.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1504  -> 1.1505 
#	            Makefile	1.439   -> 1.440  
#	scripts/Makefile.build	1.41    -> 1.42   
#	drivers/scsi/aic7xxx/Makefile	1.21    -> 1.22   
#	scripts/kconfig/Makefile	1.10    -> 1.11   
#	               (new)	        -> 1.1     scripts/getfiles
#	               (new)	        -> 1.1     scripts/Makefile.repo
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/03	dave@thedillows.org	1.1505
# Teach the kbuild system how to pull needed files from the repository.
# With this, you can copy your config into a clean repository, type
# make, and it will build the kernel, retrieving any needed files that
# have not yet been checked out.
#         
# We cannot use make's default implicit rules to do this, as we do
# not list the dependencies for each file in the Makefiles, nor do we
# want to. Therefore, we use the getfiles script to parse error
# messages from a gcc -E run to determine which files are missing.
#         
# This does not handle Kconfig files yet, only the source files.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Tue Mar  2 13:19:18 2004
+++ b/Makefile	Tue Mar  2 13:19:18 2004
@@ -937,6 +937,36 @@
 endif #ifeq ($(config-targets),1)
 endif #ifeq ($(mixed-targets),1)
 
+
+# Rules to automatically check files out of the repository during build
+# ===========================================================================
+
+# Command to use to perform actual pull of a file from the repository
+GET = get
+export GET
+
+# Need this rule so that getfiles will get the proper CFLAGS to complete
+# its dependency checkout
+arch/$(ARCH)/kernel/asm-offsets.c: include/config/MARKER
+	$(Q)$(MAKE) $(build)=$(@D) $@
+
+# $(kbuild_base_files) lists the files we need to have pulled from the
+# repository before we start doing anything else in order correctly build
+
+kbuild_base_files := scripts/Makefile.build scripts/Makefile.lib
+kbuild_base_files += scripts/Makefile.modpost scripts/Makefile.modinst
+kbuild_base_files += scripts/Makefile.repo scripts/mkversion
+kbuild_base_files += scripts/getfiles scripts/mkcompile_h
+
+# This rule will ensure these files exist, or are pulled from the repository
+.get_kbuild_files.d: $(kbuild_base_files)
+	$(Q)touch .get_kbuild_files.d
+
+-include .get_kbuild_files.d
+
+include $(srctree)/scripts/Makefile.repo
+
+
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
 
diff -Nru a/drivers/scsi/aic7xxx/Makefile b/drivers/scsi/aic7xxx/Makefile
--- a/drivers/scsi/aic7xxx/Makefile	Tue Mar  2 13:19:18 2004
+++ b/drivers/scsi/aic7xxx/Makefile	Tue Mar  2 13:19:18 2004
@@ -44,8 +44,6 @@
 
 $(obj)/aic7xxx_core.o: $(obj)/aic7xxx_seq.h
 $(obj)/aic79xx_core.o: $(obj)/aic79xx_seq.h
-$(obj)/aic79xx_reg_print.c: $(src)/aic79xx_reg_print.c_shipped
-$(obj)/aic7xxx_reg_print.c: $(src)/aic7xxx_reg_print.c_shipped
 
 $(addprefix $(obj)/,$(aic7xxx-y)): $(obj)/aic7xxx_reg.h
 $(addprefix $(obj)/,$(aic79xx-y)): $(obj)/aic79xx_reg.h
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	Tue Mar  2 13:19:18 2004
+++ b/scripts/Makefile.build	Tue Mar  2 13:19:18 2004
@@ -24,6 +24,8 @@
 endif
 
 
+include scripts/Makefile.repo
+
 ifdef EXTRA_TARGETS
 $(warning kbuild: $(obj)/Makefile - Usage of EXTRA_TARGETS is obsolete in 2.6. Please fix!)
 endif
diff -Nru a/scripts/Makefile.repo b/scripts/Makefile.repo
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/Makefile.repo	Tue Mar  2 13:19:18 2004
@@ -0,0 +1,124 @@
+ifeq ($(KBUILD_SRC),)
+# ==========================================================================
+# Tools to automatically pull files from the repository
+# ==========================================================================
+
+# If you want getfiles to complain about files it cannot find, uncomment
+# the next two lines
+#DEBUG_GETFILES := 1
+#export DEBUG_GETFILES
+
+# Mark files as secondary, so make will not remove the files we just
+# checked out of the repository. First, get a list of all possible
+# objects, then build a list of potential source files. Of all the
+# possible source files, just keep the ones that actually exist in the
+# repository.
+#
+obj-list-vars := extra-y always targets obj-y obj-m lib-y subdir-obj-y
+obj-list-vars += real-objs-y real-objs-m single-used-m multi-used-y
+obj-list-vars += multi-used-m multi-objs-y multi-objs-m host-progs
+obj-list-vars += host-csingle host-cmulti host-cobjs host-cxxmulti
+obj-list-vars += host-cxxobjs host-cshlib host-cshobjs
+
+all-objs-listed := $(foreach var,$(obj-list-vars),$($(var)))
+
+objs-with-o := $(filter %.o,$(all-objs-listed))
+objs-without-o := $(filter-out %.o,$(all-objs-listed))
+
+add-suffixes = $(foreach i,$(foreach suffix,c cc s S h y l,$(1).$(suffix)),$(i) $(i)_shipped)
+
+secondaries := $(foreach file,$(objs-with-o),$(call add-suffixes,$(file:.o=)))
+secondaries += $(foreach file,$(objs-without-o),$(if $(suffix $(file)),$(empty),$(call add-suffixes,$(file))))
+secondaries := $(sort $(secondaries))
+secondaries-dir := $(dir $(secondaries))
+secondaries-notdir := $(addprefix SCCS/s.,$(notdir $(secondaries)))
+secondaries := $(wildcard $(join $(secondaries-dir), $(secondaries-notdir)))
+secondaries := $(subst SCCS/s.,$(empty),$(secondaries))
+secondaries := $(subst _shipped,$(empty),$(secondaries))
+
+.SECONDARY: $(secondaries)
+
+
+# The commands to actually pull files from the repository. We use getfiles
+# for everything, as it does the locking for us, and will try to get
+# all of the files needed to build the target file.
+# ==========================================================================
+
+quiet_cmd_get = GET     $@
+define cmd_get
+	export GETCC="$(CC)"; \
+	scripts/getfiles $<
+endef
+
+quiet_cmd_get_s = GET     $@ (and related files)
+define cmd_get_s
+	export GETCC="$(CC)"; \
+	scripts/getfiles $(a_flags) $<
+endef
+
+# Determine if this target has been mentioned as a host target
+define if_host
+	$(if  $(filter $@,$(addsuffix .c,$(host-csingle)) \
+		$(host-cobjs:.o=.c) $(host-cshobjs:.o=.c)),$(1),$(2))
+endef
+
+quiet_cmd_get_c = GET     $@ (and related files)
+define cmd_get_c
+	export GETCC="$(strip $(call if_host,$(HOSTCC),$(CC)))"; \
+	scripts/getfiles $(call if_host,$(hostc_flags),$(c_flags)) $<
+endef
+
+quiet_cmd_get_hostcxx = GET     $@ (and related files)
+define cmd_get_hostcxx
+	export GETCC="$(strip $(call if_host,$(HOSTCXX),$(CXX)))"; \
+	scripts/getfiles $(hostcxx_flags) $<
+endef
+
+# Determine the flags to pass to getfiles for a _shipped file
+define get_shipped_flags
+	$(if $(filter %.S_shipped,$<),$(a_flags),$(call if_host,$(hostc_flags),$(c_flags)))
+endef
+
+quiet_cmd_get_shipped = GET     $(*)_shipped (and related)
+define cmd_get_shipped
+	export GETCC="$(strip $(call if_host,$(HOSTCC),$(CC)))"; \
+	scripts/getfiles $(call get_shipped_flags) $< ; \
+	$(if $(quiet),echo '  SHIPPED $*';) \
+	cat $(*)_shipped > $@
+endef
+
+bare_sccs_get = $(if $(quiet),@echo '  GET    ' $@ ;,) $(GET) $(GFLAGS) $<
+
+%.c:: SCCS/s.%.c
+	$(call cmd,get_c)
+
+%.cc:: SCCS/s.%.cc
+	$(call cmd,get_hostcxx)
+
+%.S:: SCCS/s.%.S
+	$(call cmd,get_s)
+
+%:: SCCS/s.%_shipped
+	$(call cmd,get_shipped)
+
+%:: SCCS/s.%
+	$(if $(filter scripts/getfiles,$@),$(bare_sccs_get),$(call cmd,get))
+
+else # ifneq ($(KBUILD_SRC),)
+
+%.c:: SCCS/s.%.c
+	$(error Cannot autocheckout with O or KBUILD_OUTPUT options set)
+
+%.cc:: SCCS/s.%.cc
+	$(error Cannot autocheckout with O or KBUILD_OUTPUT options set)
+
+%.S:: SCCS/s.%.S
+	$(error Cannot autocheckout with O or KBUILD_OUTPUT options set)
+
+%:: SCCS/s.%_shipped
+	$(error Cannot autocheckout with O or KBUILD_OUTPUT options set)
+
+%:: SCCS/s.%
+	$(error Cannot autocheckout with O or KBUILD_OUTPUT options set)
+
+endif
diff -Nru a/scripts/getfiles b/scripts/getfiles
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/getfiles	Tue Mar  2 13:19:18 2004
@@ -0,0 +1,245 @@
+#!/bin/bash
+#
+# Script to retrieve files from the repository. This script will attempt
+# to pull all dependencies needed to build the file given on the command
+# line with the given flags (for the include search).
+#
+# Contains logic to serialize the extraction of files to avoid corruption.
+# If it fails to remove its lock, a "make clean" or rm .lock.*.d .lock.d
+# will clean it up
+#
+# Copyright (C) 2003
+# David Dillow <dave@thedillows.org>
+#
+# This file is licensed under the GPL, see COPYING for details
+#
+
+usage() {
+	echo "usage: getfiles [cflags...] filename" 1>&2
+	exit 2
+}
+
+need_get() {
+	echo "getfiles: need valid \$GET (currently '$GET')" 1>&2
+	exit 2
+}
+
+need_getcc() {
+	echo "getfiles: need valid \$GETCC (currently '$GETCC')" 1>&2
+	exit 2
+}
+
+# If usleep exists, use it to sleep for a brief time, otherwise
+# we sleep for a second
+#
+if type usleep &> /dev/null; then
+	yield() { usleep 100000; }
+else
+	yield() { sleep 1; }
+fi
+
+obtain_getfiles_lock() {
+	trap "rm -f .lock.$$.d" EXIT
+
+	echo &> .lock.$$.d
+
+	while ! ln .lock.$$.d .lock.d &> /dev/null; do
+		yield
+	done
+
+	# Race here, I know, but a make clean will clean up if we die here
+	#
+	trap "release_getfiles_lock" EXIT
+}
+
+release_getfiles_lock() {
+	# Race between removing the exit trap and unlinking the lock file,
+	# but a make clean will fix it up (or just remove the lock files)
+	#
+	rm -f .lock.$$.d .lock.d
+}
+
+get_returned_error() {
+	local get_err=$?
+	echo "$get_output" 1>&2
+	exit $get_err
+}
+
+# Gleen the paths that the compiler will search for include files
+# from the command line options, and store them in inc_path[]
+#
+get_include_path() {
+	local elem
+
+	while [[ $1 ]]; do
+		if [[ ${1:0:2} == -I ]]; then
+			elem=${1:2}
+			elem=`echo $elem | sed -re 's@(/)+@/@g' -e 's@/$@@'`
+			inc_path[${#inc_path[@]}]=$elem
+		elif [[ ${1:0:6} == -iwith ]]; then
+			shift
+			[[ $1 ]] && inc_path[${#inc_path[@]}]=$1
+		fi
+		shift
+	done
+}
+
+# Search for a file in the incude path. Only list it if it doesn't
+# exist, and we have a repository file to retrieve it from
+#
+search_inc_path() {
+	local file dir base elem local_path
+
+	file=$1
+	dir=${file%/*}
+	base=${file##*/}
+	[[ $dir == $base ]] && dir=.
+	local_path=$2
+
+	for elem in ${inc_path[@]} ${local_path}; do
+		[[ -e ${elem}/${file} ]] && return 0
+		[[ ! -e ${elem}/${dir}/SCCS/s.${base} ]] && continue
+		echo ${elem}/${dir}/SCCS/s.${base}
+		return 0
+	done
+
+	return 1
+}
+
+# Doh! We hit a file we cannot resolve. If it's not one we know we get
+# from the host or compiler, then spit it and the include path out if
+# we're debugging
+#
+# FIXME: we're called in a subshell, so we'll print the include path
+# for each pass that has a hopeless file....
+#
+hopeless_file() {
+
+	[[ $DEBUG_GETFILES ]] || return 0
+
+	# If it's something we know to come from a location outside of
+	# the repository, then ignore it
+	#
+	[[ $1 == stdarg.h ]] && return 0
+
+	if [[ ! $DID_INCLUDE_PATH ]]; then
+		local elem
+
+		echo getfiles: include search path: 1>&2
+		for elem in ${inc_path[@]}; do
+			echo "getfiles:    $elem" 1>&2
+		done
+
+		DID_INCLUDE_PATH=1
+	fi
+
+	echo "getfiles: Unable to find a match for $1, included by $2" 1>&2
+	return 0
+}
+
+# Parse gcc's ($GETCC) output for missing include files, and try to
+# resolve them
+#
+find_missing_deps() {
+	local local_dir dir base missing includer
+
+	$GETCC $lang -E $FLAGS $1 2>&1 > /dev/null |
+					grep "No such file or directory" |
+					while read; do
+		includer=${REPLY%%:*}
+		local_dir=${includer%/*}
+		[[ $local_dir == $includer ]] && local_dir=.
+
+		missing=${REPLY%:*}
+		missing=${missing##*:}
+		missing=${missing## }
+
+		if ! search_inc_path ${missing} ${local_dir}; then
+			hopeless_file ${missing} ${includer}
+		fi
+	done
+}
+
+# Main routine starts here
+#
+# Perform some sanity checking on our environment
+#
+[[ $# -ge 1 ]] || usage
+[[ $GET ]] || need_get
+[[ $GETCC ]] || need_getcc
+type $GET &> /dev/null || need_get
+type $GETCC &> /dev/null || need_getcc
+
+unset QUIET_FLAGS
+[[ $Q ]] && QUIET_FLAGS=-q
+
+# Ignore the flags to output dependency information while building
+# and certain problem prefix arguments
+#
+while [[ $2 ]]; do
+	new_flag="$1"
+	shift
+	[[ ${new_flag:0:8} == -Wp,-MD, ]] && continue
+	if [[ ${new_flag:0:6} == -iwith ]]; then
+		shift; continue
+	fi
+	FLAGS="$FLAGS $new_flag"
+done
+
+# Prevent other getfiles instances from trampling on us, and get the
+# file we came for. We never explicitly drop the lock, but bash will
+# take care of it for us when we exit
+#
+obtain_getfiles_lock
+get_output=`$GET $@ 2>&1` || get_returned_error
+[[ ! $QUIET_FLAGS ]] && echo "$get_output"
+
+real_initial_file=`echo "$get_output" |
+	sed -re 's/^(.*) [[:digit:]]+\.[[:digit:]]+: [[:digit:]]+ lines/\1/'`
+
+# Everything else is just trying to check out the dependencies of that file
+#
+initial_file=${real_initial_file%%_shipped}
+[[ $real_initial_file != $initial_file ]] && shipped=1
+
+(( start_2 = ${#initial_file} - 2 ))
+(( start_3 = start_2 - 1 ))
+last2=${initial_file:$start_2:2}
+last3=${initial_file:$start_3:3}
+
+# Only look for included files in C, C++, or assembly source and headers
+#
+[[ $last2 == .c || $last2 == .h || $last2 == .S || $last3 == .cc ]] || exit 0
+
+declare -a inc_path
+
+if [[ $last3 == .cc ]]; then
+	last2=.c
+	initial_obj=${initial_file:0:$start_3}.o
+else
+	initial_obj=${initial_file:0:$start_2}.o
+fi
+initial_obj=${initial_obj##*/}
+
+# If it was a shipped file, we need to tell gcc the real file type
+#
+case $last2 in
+	.c|.h)	lang=${shipped+-x c}
+		;;
+	.S)	lang=${shipped+-x assembler}
+		;;
+esac
+
+get_include_path $FLAGS
+
+# While we're missing files, and making progress on finding new ones --
+# ie. if we get new missing files each time through -- keep plugging away
+#
+missing=( `find_missing_deps $real_initial_file` )
+while [[ ${#missing[@]} -ne 0 && ${last_missing[@]} != ${missing[@]} ]]; do
+	$GET $QUIET_FLAGS ${missing[@]} || exit 1
+	last_missing=( ${missing[@]} )
+	missing=( `find_missing_deps $real_initial_file` )
+done
+
+exit 0
diff -Nru a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
--- a/scripts/kconfig/Makefile	Tue Mar  2 13:19:18 2004
+++ b/scripts/kconfig/Makefile	Tue Mar  2 13:19:18 2004
@@ -139,7 +139,10 @@
 -include $(obj)/.tmp_gtkcheck
 
 # GTK needs some extra effort, too...
-$(obj)/.tmp_gtkcheck:
+# ... and some extra files from the repository. It doesn't really depend
+# on gconf.glade, but it won't hurt to re-run .tmp_gtkcheck, and this
+# is a convienient place to tell make it is needed from the repository
+$(obj)/.tmp_gtkcheck: $(obj)/gconf.glade
 	@if `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --exists`; then		\
 		if `pkg-config gtk+-2.0 --atleast-version=2.0.0`; then			\
 			touch $@;								\

--=-idPoI1HPuc/krFvgQT71--


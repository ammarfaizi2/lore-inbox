Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268230AbTB1VkU>; Fri, 28 Feb 2003 16:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268246AbTB1Vjn>; Fri, 28 Feb 2003 16:39:43 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:45074 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S268230AbTB1ViT>;
	Fri, 28 Feb 2003 16:38:19 -0500
Date: Fri, 28 Feb 2003 22:48:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: [PATCH/CFT] kbuild: Separate objdir
Message-ID: <20030228214832.GD23006@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here follows a patch to allow compilation of the kernel outside the
src tree.
A prerequisite is that the kernel srctree is free of generated
files for it to work - so you cannot mix the two methods.

A small script 'kbuild' is located in the root of the kernel src tree,
and when executed from a separate directory it will make a simple check
and issue an error if there is generated files in the kernel src tree.

Typical usage is when one has to compile several kernel verions
based on the same kernel src:

Consider the following scenario:

~/repo/linux-2.5/ <kernel src tree>
~/build/i386UP/   <all generated files related to UP on i386>
~/build/i386SMP/  <all generated files releated to SMP on i386>
~/build/ppc/      <all generated files for ppc>

To use the feature invoke kbuild like this:
cd ~/build/i386SMP
~/repo/linux-2.5/kbuild defconfig
~/repo/linux-2.5/kbuild

Note: kbuild MUST be located at the root of the src tree.

What is enabled now is an easy way to share the same src for
several configurations.
As an added bonus the kernel src may now reside in RO - because no files
are written to in the kernel src tree, and no files are generated in the
kernel src tree.

The patch is tested with i386 and ppc - test with other architectures
are most welcome.

Can be pulled from bk://linux-sam.bkbits.net/kbuild
As normal patch below.

	Sam

ChangeSet@1.1119, 2003-02-28 22:03:32+01:00, sam@mars.ravnborg.org
  kbuild: Support for separate objdir
  
  Compiling the kernel in a separate objdir makes it trivial to share the same src
  but with different configurations.
  When a UP, a SMP and a alpha kernel is needed based on the same src the following set-up can be used:
  ~/bk/linux-2.5/<kernel-src>
  
  ~/kernel/UP/<here the UP kernel is built>
  ~/kernel/SMP/<here the SMP kernel is built>
  ~/kernel/alpha/<here the alpha kernel is built>
  
  To build the alpha kernel:
  cd ~/alpha
  ~/bk/linux-2.5/kbuild
  
  The kbuild script _must_ be located in the root of the kernel src.
  All generated files are stored in ~/kernel/XXX/* directory structure,
  including the configuration.

ChangeSet@1.1118, 2003-02-27 20:41:33+01:00, sam@mars.ravnborg.org
  kbuild: Small updates in top-level makefile
  
  1) Define comma so dependency files does not include a '_' in the filename
  2) Use correct path for mkspec and mkversion
  3) Removed checkhelp - corresponding perl script is no longer present
  4) Spelling correction (reported on lkml)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1117  -> 1.1118 
#	            Makefile	1.381   -> 1.382  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/27	sam@mars.ravnborg.org	1.1118
# kbuild: Small updates in top-level makefile
# 
# 1) Define comma so dependency files does not include a '_' in the filename
# 2) Use correct path for mkspec and mkversion
# 3) Removed checkhelp - corresponding perl script is no longer present
# 4) Spelling correction (reported on lkml)
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Fri Feb 28 22:15:32 2003
+++ b/Makefile	Fri Feb 28 22:15:32 2003
@@ -190,6 +190,7 @@
 
 # The temporary file to save gcc -MD generated dependencies must not
 # contain a comma
+comma := ,
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
 
 noconfig_targets := xconfig menuconfig config oldconfig randconfig \
@@ -326,7 +327,7 @@
 	set -e
 	$(if $(filter .tmp_kallsyms%,$^),,
 	  echo '  Generating build number'
-	  . $(src)/scripts/mkversion > .tmp_version
+	  . $(srctree)/scripts/mkversion > .tmp_version
 	  mv -f .tmp_version .version
 	  $(Q)$(MAKE) $(build)=init
 	)
@@ -741,10 +742,10 @@
 #	If you do a make spec before packing the tarball you can rpm -ta it
 
 spec:
-	. scripts/mkspec >kernel.spec
+	. $(srctree)/scripts/mkspec >kernel.spec
 
 #	Build a tar ball, generate an rpm from it and pack the result
-#	There arw two bits of magic here
+#	There are two bits of magic here
 #	1) The use of /. to avoid tar packing just the symlink
 #	2) Removing the .dep files as they have source paths in them that
 #	   will become invalid
@@ -814,11 +815,6 @@
 	find * $(RCS_FIND_IGNORE) \
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkconfig.pl
-
-checkhelp:
-	find * $(RCS_FIND_IGNORE) \
-		-name [cC]onfig.in -print | sort \
-		| xargs $(PERL) -w scripts/checkhelp.pl
 
 checkincludes:
 	find * $(RCS_FIND_IGNORE) \

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1118  -> 1.1119 
#	            Makefile	1.382   -> 1.383  
#	scripts/Makefile.lib	1.15    -> 1.16   
#	scripts/Makefile.modpost	1.1     -> 1.2    
#	               (new)	        -> 1.1     kbuild         
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/28	sam@mars.ravnborg.org	1.1119
# kbuild: Support for separate objdir
# 
# Compiling the kernel in a separate objdir makes it trivial to share the same src
# but with different configurations.
# When a UP, a SMP and a alpha kernel is needed based on the same src the following set-up can be used:
# ~/bk/linux-2.5/<kernel-src>
# 
# ~/kernel/UP/<here the UP kernel is built>
# ~/kernel/SMP/<here the SMP kernel is built>
# ~/kernel/alpha/<here the alpha kernel is built>
# 
# To build the alpha kernel:
# cd ~/alpha
# ~/bk/linux-2.5/kbuild
# 
# The kbuild script _must_ be located in the root of the kernel src.
# All generated files are stored in ~/kernel/XXX/* directory structure,
# including the configuration.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Fri Feb 28 22:15:40 2003
+++ b/Makefile	Fri Feb 28 22:15:40 2003
@@ -61,9 +61,11 @@
 
 # 	Decide whether to build built-in, modular, or both.
 #	Normally, just do built-in.
+#	Are we doing a build in a separate object directory
 
 KBUILD_MODULES :=
 KBUILD_BUILTIN := 1
+KBUILD_SEPOBJ  :=
 
 #	If we have only "make modules", don't compile built-in objects.
 
@@ -88,7 +90,7 @@
   KBUILD_MODULES := 1
 endif
 
-export KBUILD_MODULES KBUILD_BUILTIN KBUILD_VERBOSE
+export KBUILD_MODULES KBUILD_BUILTIN KBUILD_VERBOSE KBUILD_SEPOBJ
 
 # Beautify output
 # ---------------------------------------------------------------------------
@@ -139,13 +141,23 @@
 export quiet Q KBUILD_VERBOSE
 
 #	Paths to obj / src tree
+#	If kbuild.config is present then we are building in
+#	a separate object directory
 
-src	:= .
-obj	:= .
-srctree := .
-objtree := .
+obj		:= .
 
-export srctree objtree
+ifneq ($(wildcard kbuild.config),)
+include	kbuild.config		# Set srctree and objtree
+src		:= $(srctree)
+VPATH		:= $(srctree)
+KBUILD_SEPOBJ	:= 1
+else
+src		:= .
+srctree		:= .
+objtree		:= .
+endif
+
+export srctree objtree VPATH
 
 # 	Make variables (CC, etc...)
 
@@ -453,7 +465,11 @@
 
 include/asm:
 	@echo '  Making asm->asm-$(ARCH) symlink'
+ifeq ($(KBUILD_SEPOBJ),)
 	@ln -s asm-$(ARCH) $@
+else
+	@ln -s $(srctree)/include/asm-$(ARCH) $@
+endif
 
 # 	Split autoconf.h into include/linux/config/*
 
@@ -478,6 +494,7 @@
 uts_len := 64
 
 include/linux/version.h: Makefile
+	@mkdir -p $(dir $@)
 	@if expr length "$(KERNELRELEASE)" \> $(uts_len) >/dev/null ; then \
 	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2; \
 	  exit 1; \
@@ -654,7 +671,7 @@
 	.menuconfig.log \
 	include/asm \
 	.hdepend include/linux/modversions.h \
-	tags TAGS cscope kernel.spec \
+	tags TAGS cscope kernel.spec kbuild.config \
 	.tmp*
 
 # Directories removed with 'make mrproper'
@@ -836,7 +853,8 @@
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
 
-a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(AFLAGS_KERNEL) $(NOSTDINC_FLAGS) \
+a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(AFLAGS_KERNEL) \
+	  $(if $(KBUILD_SEPOBJ), -I.tmp_include) $(NOSTDINC_FLAGS) \
 	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
 
 quiet_cmd_as_s_S = CPP     $@
diff -Nru a/kbuild b/kbuild
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kbuild	Fri Feb 28 22:15:40 2003
@@ -0,0 +1,86 @@
+#!/bin/sh
+#
+# This script is used to build a kernel from a directory
+# separate from the kernel src tree.
+# The location of this script is assumed to be the root of
+# the kernel src tree. Do not copy it elsewhere.
+# Usage: kbuild [Usual options provided to make]
+
+# kbuild prints out SRCTREE and OBJTREE when started, and then makes 
+# symlinks of relevant files from the kernelsrc.
+
+# Obtain absolute paths for SRCTREE and OBJTREE
+OBJTREE=`/bin/pwd`
+cd `dirname $0`
+SRCTREE=`/bin/pwd`
+cd $OBJTREE
+echo OBJTREE=$OBJTREE
+echo SRCTREE=$SRCTREE
+
+# If kbuild is executed from the root of the kernel src tree just call make
+if [ "$SRCTREE" == "$OBJTREE" ]; then
+	rm -f kbuild.config
+	make $*
+else
+	# A directory separate from kernel src tree
+	# Check if the kerneltree has changed if executed before
+	if [ -f kbuild.config ]; then
+		source kbuild.config
+		if [ $SRCTREE != $srctree ]; then
+			echo
+			echo "$0: The kernel srctree has changed!"
+			echo "Now: \"$SRCTREE\""
+			echo "Was: \"$srctree\""
+			echo "Do 'rm -rf *' before compiling a new kernel"
+			exit 1
+		fi
+	fi
+	# Check that there is a Makefile in the root of the kernel tree
+	if [ ! -f $SRCTREE/Makefile ]; then
+		echo '$0: $SRCTREE/Makefile missing - aborting'
+		exit 2
+	fi
+
+	# Check if make has been executed in kerneltree already
+	if [ -f $SRCTREE/.config -o -d $SRCTREE/include/asm ]; then
+		echo '$SRCTREE contains generated files, please run "make mrproper" in the SRCTREE'
+		exit 3
+	fi
+
+	ln -fs $SRCTREE/Makefile Makefile
+	# Symlink all directories recursively except include
+	for a in $SRCTREE/*; do
+		if [ -d $a ] && [ $a != $SRCTREE/include ]; then
+			d="${a#${SRCTREE}\/} $d"
+		fi
+	done
+	for a in $d; do
+		echo -n .
+		for b in `cd $SRCTREE/$a; find -type d`; do
+			b=${b#./}
+			if [ ! -d $a/$b ]; then
+				mkdir -p $a/$b
+			fi
+			for f in $SRCTREE/$a/$b/Makefile*; do
+				if [ -f $f ]; then
+					f=${f/\/.\///}
+					ln -fs $f ${f#$SRCTREE\/}
+				fi
+			done
+			
+		done
+	done
+	echo -n .
+	# $SRCTREE/include is symlinked inside $OBJTREE/.tmp_include
+	if [ ! -d .tmp_include ]; then
+		mkdir .tmp_include
+	fi
+	for a in $SRCTREE/include/*; do
+		ln -fs $a .tmp_include/
+	done
+	echo
+	( echo "srctree=$SRCTREE";
+	  echo "objtree=$OBJTREE";
+	) > kbuild.config
+	make $*
+fi
diff -Nru a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib	Fri Feb 28 22:15:40 2003
+++ b/scripts/Makefile.lib	Fri Feb 28 22:15:40 2003
@@ -119,15 +119,45 @@
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
+ifeq ($(KBUILD_SEPOBJ),)
+__c_flags	= $(_c_flags)
+__a_flags	= $(_a_flags)
+__hostc_flags	= $(_hostc_flags)
+__hostcxx_flags	= $(_hostcxx_flags)
+else
+flags = $(foreach o,$($(1)), $(o)\
+	$(if $(filter -I%,$(o)),$(patsubst -I%,-I$(srctree)/%,$(o))))
+
+#-I$(obj) used to locate generated .h files
+#-I$(srctree)/$(src) used to locate .h files in srctree, from generated .c files
+__c_flags	= -I$(obj) -I$(srctree)/$(src) $(call flags,_c_flags)
+__a_flags	= -I$(obj) -I$(srctree)/$(src) $(call flags,_a_flags)
+__hostc_flags	= -I$(obj) -I$(srctree)/$(src) $(call flags,_hostc_flags)
+__hostcxx_flags	= -I$(obj) -I$(srctree)/$(src) $(call flags,_hostcxx_flags)
+endif
+
+c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) \
+		 $(__c_flags) $(modkern_cflags) \
+		 $(basename_flags) $(modname_flags)
+
+a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) \
+		 $(__a_flags) $(modkern_aflags)
+
+hostc_flags    = -Wp,-MD,$(depfile) $(__hostc_flags)
+hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
+
 ld_flags       = $(LDFLAGS) $(EXTRA_LDFLAGS)
 
 # Finds the multi-part object the current object will be linked into
diff -Nru a/scripts/Makefile.modpost b/scripts/Makefile.modpost
--- a/scripts/Makefile.modpost	Fri Feb 28 22:15:40 2003
+++ b/scripts/Makefile.modpost	Fri Feb 28 22:15:40 2003
@@ -35,7 +35,7 @@
 # Compile version info for unresolved symbols
 
 quiet_cmd_cc_o_c = CC      $@
-      cmd_cc_o_c = $(CC) $(CFLAGS) $(CFLAGS_MODULE) -c -o $@ $<
+      cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE) -c -o $@ $<
 
 #	We have a fake dependency on compile.h to make sure that we
 #	notice if the compiler version changes under us.

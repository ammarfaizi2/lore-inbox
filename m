Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbSKSUEN>; Tue, 19 Nov 2002 15:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267120AbSKSUEN>; Tue, 19 Nov 2002 15:04:13 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:12554 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267104AbSKSUEJ>;
	Tue, 19 Nov 2002 15:04:09 -0500
Date: Tue, 19 Nov 2002 21:11:10 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [RFC/CFT] Separate obj/src dir
Message-ID: <20021119201110.GA11192@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on some initial work by Kai Germaschewski I have made a
working prototype of separate obj/src tree.

Usage example:
#src located in ~/bk/linux-2.5.sepobj
mkdir ~/compile/v2.5
cd ~/compile/v2.5
sh ../../kb/v2.5/kbuild

Prints out:
SRCTREE=/home/sam/bk/linux-2.5.sepobj
OBJTREE=/home/sam/compile/v2.5
And then the normal make process starts after a short period.

The kbuild shell script takes a verbatim copy of all Makefiles,
all Kconfig files and all defconfigs. I did not even look into
using symlinks, I was not sure how they work across NFS
and the like.

The VPATH feature of make is used to let make locate the
src in the directory where the kbuild script is located.

I had to do some trikery with the CFLAGS to make it work.
The processing done in the flags define in Makefile.build is
rather unpleasent and I have another solution in mind I will
give a try soon.
I will try to include files via a directory in the root
of OBJTREE and then create symlinks towards the directories
present in SRCTREE - but need to play a bit more with that.

Another drawback is that when a .h file exist in the
SRCTREE but not in the OBJTREE the generated dependencies
will point out the .h file located in SRCTREE.
This happens for generated .h files, and therefore a simple
check is made in kbuild to check that the SRCTREE is
cleaned/mrpropered.

kconfig did not have an option to read the Kconfig files +
defconfig from somewhere else than current directory,
therefore they are copied. But that should be trivial to do.
Possible solutions:
1) Command line option:
	-r path-to-rrot-of-tree
2) Deduct it from the argument given, but then kconfig
   needs to know a bit too much about the kernel src tree.
3) Utilise the environment variable $(srctree), which is
   anyway valid.

Comments expected...

	Sam


===== Makefile 1.346 vs edited =====
--- 1.346/Makefile	Sat Nov  9 05:08:32 2002
+++ edited/Makefile	Mon Nov 18 23:07:59 2002
@@ -136,13 +136,18 @@
 export quiet Q KBUILD_VERBOSE
 
 #	Paths to obj / src tree
-
+ifneq ($(wildcard .tmp_make_config),)
+include .tmp_make_config
+src     := $(srctree)
+obj     := .
+VPATH   := $(srctree)
+else
 src	:= .
 obj	:= .
 srctree := .
 objtree := .
-
-export srctree objtree
+endif
+export srctree objtree VPATH
 
 # 	Make variables (CC, etc...)
 
@@ -304,7 +309,7 @@
 	set -e
 	$(if $(filter .tmp_kallsyms%,$^),,
 	  echo '  Generating build number'
-	  . scripts/mkversion > .tmp_version
+	  $(CONFIG_SHELL) $(src)/scripts/mkversion > .tmp_version
 	  mv -f .tmp_version .version
 	  $(Q)$(MAKE) -f scripts/Makefile.build obj=init
 	)
@@ -406,7 +411,11 @@
 
 include/asm:
 	@echo '  Making asm->asm-$(ARCH) symlink'
+ifeq ($(srctree),$(objtree))
 	@ln -s asm-$(ARCH) $@
+else
+	@ln -s $(src)/include/asm-$(ARCH) $@
+endif
 
 # 	Split autoconf.h into include/linux/config/*
 
@@ -585,7 +594,7 @@
 	tar -cvz $(RCS_TAR_IGNORE) -f $(KERNELPATH).tar.gz $(KERNELPATH)/. ; \
 	rm $(KERNELPATH) ; \
 	cd $(TOPDIR) ; \
-	. scripts/mkversion > .version ; \
+	$(CONFIG_SHELL) $(src)/scripts/mkversion > .version ; \
 	rpm -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
 	rm $(TOPDIR)/../$(KERNELPATH).tar.gz
 
===== scripts/Makefile.build 1.11 vs edited =====
--- 1.11/scripts/Makefile.build	Thu Nov 14 17:08:38 2002
+++ edited/scripts/Makefile.build	Tue Nov 19 20:39:41 2002
@@ -84,26 +84,34 @@
 $(multi-objs-y:.o=.s)   : modname = $(modname-multi)
 $(multi-objs-y:.o=.lst) : modname = $(modname-multi)
 
+# Allow gcc to locate header files in srctree, if we use separate objtree
+ifeq ($(srctree),$(objtree))
+flags = $($(1))
+else
+flags = -I$(obj) -I$(srctree)/$(src) $($(1)) $(patsubst -I%,-I$(srctree)/%,$(filter -I%,$($(1))))
+endif
+
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
-cmd_cc_s_c       = $(CC) $(c_flags) -S -o $@ $< 
+cmd_cc_s_c       = $(CC) $(call flags,c_flags) -S -o $@ $< 
 
 %.s: %.c FORCE
 	$(call if_changed_dep,cc_s_c)
 
 quiet_cmd_cc_i_c = CPP $(quiet_modtag) $@
-cmd_cc_i_c       = $(CPP) $(c_flags)   -o $@ $<
+cmd_cc_i_c       = $(CPP) $(call flags,c_flags) -o $@ $<
 
 %.i: %.c FORCE
 	$(call if_changed_dep,cc_i_c)
 
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
-cmd_cc_o_c       = $(CC) $(c_flags) -c -o $@ $<
+cmd_cc_o_c       = $(CC) $(call flags,c_flags) -c -o $@ $<
 
 %.o: %.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
 quiet_cmd_cc_lst_c = MKLST   $@
-cmd_cc_lst_c       = $(CC) $(c_flags) -g -c -o $*.o $< && sh scripts/makelst $*.o System.map $(OBJDUMP) > $@
+cmd_cc_lst_c       = $(CC) $(call flags,c_flags) -g -c -o $*.o $< && \
+		     sh $(src)/scripts/makelst $*.o System.map $(OBJDUMP) > $@
 
 %.lst: %.c FORCE
 	$(call if_changed_dep,cc_lst_c)
@@ -116,17 +124,14 @@
 $(real-objs-m)      : modkern_aflags := $(AFLAGS_MODULE)
 $(real-objs-m:.o=.s): modkern_aflags := $(AFLAGS_MODULE)
 
-a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(NOSTDINC_FLAGS) \
-	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
-
 quiet_cmd_as_s_S = CPP $(quiet_modtag) $@
-cmd_as_s_S       = $(CPP) $(a_flags)   -o $@ $< 
+cmd_as_s_S       = $(CPP) $(call flags,a_flags) -o $@ $< 
 
 %.s: %.S FORCE
 	$(call if_changed_dep,as_s_S)
 
 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
-cmd_as_o_S       = $(CC) $(a_flags) -c -o $@ $<
+cmd_as_o_S       = $(CC) $(call flags,a_flags) -c -o $@ $<
 
 %.o: %.S FORCE
 	$(call if_changed_dep,as_o_S)
@@ -217,8 +222,7 @@
 # Create executable from a single .c file
 # host-csingle -> Executable
 quiet_cmd_host-csingle 	= HOSTCC  $@
-      cmd_host-csingle	= $(HOSTCC) -Wp,-MD,$(depfile) \
-			  $(HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
+      cmd_host-csingle	= $(HOSTCC) $(call flags,hostc_flags) \
 			  $(HOST_LOADLIBES) -o $@ $<
 $(host-csingle): %: %.c FORCE
 	$(call if_changed_dep,host-csingle)
@@ -235,9 +239,7 @@
 # Create .o file from a single .c file
 # host-cobjs -> .o
 quiet_cmd_host-cobjs	= HOSTCC  $@
-      cmd_host-cobjs	= $(HOSTCC) -Wp,-MD,$(depfile) \
-			  $(HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
-			  $(HOSTCFLAGS_$(@F)) -c -o $@ $<
+      cmd_host-cobjs	= $(HOSTCC) $(call flags,hostc_flags) -c -o $@ $<
 $(host-cobjs): %.o: %.c FORCE
 	$(call if_changed_dep,host-cobjs)
 
@@ -253,18 +255,14 @@
 
 # Create .o file from a single .cc (C++) file
 quiet_cmd_host-cxxobjs	= HOSTCXX $@
-      cmd_host-cxxobjs	= $(HOSTCXX) -Wp,-MD,$(depfile) \
-			  $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
-			  $(HOSTCXXFLAGS_$(@F)) -c -o $@ $<
+      cmd_host-cxxobjs	= $(HOSTCXX) $(call flags,hostcxx_flags) -c -o $@ $<
 $(host-cxxobjs): %.o: %.cc FORCE
 	$(call if_changed_dep,host-cxxobjs)
 
 # Compile .c file, create position independent .o file
 # host-cshobjs -> .o
 quiet_cmd_host-cshobjs	= HOSTCC  -fPIC $@
-      cmd_host-cshobjs	= $(HOSTCC) -Wp,-MD,$(depfile) -fPIC\
-			  $(HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
-			  $(HOSTCFLAGS_$(@F)) -c -o $@ $<
+      cmd_host-cshobjs	= $(HOSTCC) $(call flags,hostc_flags) -fPIC -c -o $@ $<
 $(host-cshobjs): %.o: %.c FORCE
 	$(call if_changed_dep,host-cshobjs)
 
===== scripts/Makefile.lib 1.3 vs edited =====
--- 1.3/scripts/Makefile.lib	Wed Oct 30 03:52:07 2002
+++ edited/scripts/Makefile.lib	Tue Nov 19 20:45:25 2002
@@ -128,6 +128,14 @@
 c_flags        = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
 	         $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
 	         $(basename_flags) $(modname_flags) $(export_flags) 
+a_flags        = -Wp,-MD,$(depfile) $(AFLAGS) $(NOSTDINC_FLAGS) \
+		 $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
+hostc_flags    = -Wp,-MD,$(depfile) \
+		 $(HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
+		 $(HOSTCFLAGS_$(*F).o)
+hostcxx_flags  = -Wp,-MD,$(depfile) \
+	 	 $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
+		 $(HOSTCXXFLAGS_$(*F).o)
 
 # Finds the multi-part object the current object will be linked into
 modname-multi = $(subst $(space),_,$(strip $(foreach m,$(multi-used),\
@@ -139,7 +147,7 @@
 quiet_cmd_shipped = SHIPPED $@
 cmd_shipped = cat $< > $@
 
-%:: %_shipped
+$(obj)/%:: $(src)/%_shipped
 	$(call cmd,shipped)
 
 # Commands useful for building a boot image
--- /dev/null	2002-08-31 01:31:37.000000000 +0200
+++ kbuild	2002-11-19 20:07:35.000000000 +0100
@@ -0,0 +1,28 @@
+#!/bin/sh
+OBJTREE=$PWD
+cd `dirname $0`
+SRCTREE=$PWD
+cd $OBJTREE
+echo OBJTREE $OBJTREE
+echo SRCTREE $SRCTREE
+if [ "$SRCTREE" != "$OBJTREE" ]; then
+  if [ -f $SRCTREE/.config -o -d $SRCTREE/include/asm ]; then
+    echo '$SRCTREE contains generated files, please run "make mrproper" in the SRCTREE'
+  else
+    for a in `cd $SRCTREE; find -type d`; do
+      mkdir -p $a;
+    done
+    for a in `cd $SRCTREE; find -name Makefile\* -o -name Kconfig\* -o -name defconfig`; do
+      cp -f $SRCTREE/$a $a
+    done
+
+    ( echo "srctree := $SRCTREE";
+      echo "objtree := $OBJTREE";
+    ) > .tmp_make_config
+    touch Rules.make
+  make $*
+  fi
+else
+  rm -f .tmp_make_config
+  make $*
+fi



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVIFUNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVIFUNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVIFUNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:13:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:27346 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750855AbVIFUNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:13:55 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE LINUX Products GMBH
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [patch] kbuild: building with a mostly-clean /usr/src/linux and O=
Date: Tue, 6 Sep 2005 22:13:52 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200509062213.52989.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling a kernel with a separate output directory,

  /var/tmp/kernel-obj>  cp $CONFIG_FILE .config
  /var/tmp/kernel-obj>  make -C /usr/src/linux O=`pwd`

the main kernel Makefile first tries to make sure that /usr/src/linux
is a clean source tree by checking if /usr/src/linux contains .config
or the include/asm symlink. This test is more restrictive than
necessary, and can be relaxed with a few additional changes so that
/usr/src/linux may contain a few additional critical files, and may
still be used as the kernel compilation source.

The additional files I have in mind are include/asm,
include/linux/version.h, include/linux/autoconf.h, and perhaps also
include/asm/offset.h. With these files present, it's possible to use
kernel headers from user-space. I know that's evil and frowned upon,
but it's still done once in a while, and sometimes it's the least
painful path compared to the alternatives. The kbuild changes required
to allow this IMHO are harmless; please consider for inclusion.

Thanks,
Andreas.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.13-kbuild/Makefile
===================================================================
--- linux-2.6.13-kbuild.orig/Makefile
+++ linux-2.6.13-kbuild/Makefile
@@ -465,7 +465,7 @@ ifeq ($(KBUILD_EXTMOD),)
 scripts: scripts_basic include/config/MARKER
 	$(Q)$(MAKE) $(build)=$(@)
 
-scripts_basic: include/linux/autoconf.h
+scripts_basic: $(objtree)/include/linux/autoconf.h
 
 # Objects we will link into vmlinux / subdirs we need to visit
 init-y		:= init/
@@ -491,11 +491,11 @@ include .config
 
 # If .config is newer than include/linux/autoconf.h, someone tinkered
 # with it and forgot to run make oldconfig
-include/linux/autoconf.h: .config
+$(objtree)/include/linux/autoconf.h: .config
 	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
 else
 # Dummy target needed, because used as prerequisite
-include/linux/autoconf.h: ;
+$(objtree)/include/linux/autoconf.h: ;
 endif
 
 # The all: target is the default when no target is given on the
@@ -757,7 +757,7 @@ $(vmlinux-dirs): prepare-all scripts
 prepare2:
 ifneq ($(KBUILD_SRC),)
 	@echo '  Using $(srctree) as source for kernel'
-	$(Q)if [ -h $(srctree)/include/asm -o -f $(srctree)/.config ]; then \
+	$(Q)if [ -f $(srctree)/.config ]; then \
 		echo "  $(srctree) is not clean, please run 'make mrproper'";\
 		echo "  in the '$(srctree)' directory.";\
 		/bin/false; \
@@ -769,7 +769,7 @@ endif
 # prepare1 creates a makefile if using a separate output directory
 prepare1: prepare2 outputmakefile
 
-prepare0: prepare1 include/linux/version.h include/asm include/config/MARKER
+prepare0: prepare1 $(objtree)/include/linux/version.h $(objtree)/include/asm include/config/MARKER
 ifneq ($(KBUILD_MODULES),)
 	$(Q)rm -rf $(MODVERDIR)
 	$(Q)mkdir -p $(MODVERDIR)
@@ -808,14 +808,15 @@ export CPPFLAGS_vmlinux.lds += -P -C -U$
 #	hard to detect, but I suppose "make mrproper" is a good idea
 #	before switching between archs anyway.
 
-include/asm:
+include/asm: $(objtree)/include/asm
+$(objtree)/include/asm:
 	@echo '  SYMLINK $@ -> include/asm-$(ARCH)'
 	$(Q)if [ ! -d include ]; then mkdir -p include; fi;
 	@ln -fsn asm-$(ARCH) $@
 
 # 	Split autoconf.h into include/linux/config/*
 
-include/config/MARKER: include/linux/autoconf.h
+include/config/MARKER: $(objtree)/include/linux/autoconf.h
 	@echo '  SPLIT   include/linux/autoconf.h -> include/config/*'
 	@scripts/basic/split-include include/linux/autoconf.h include/config
 	@touch $@
@@ -839,7 +840,7 @@ define filechk_version.h
 	)
 endef
 
-include/linux/version.h: $(srctree)/Makefile FORCE
+$(objtree)/include/linux/version.h: $(srctree)/Makefile FORCE
 	$(call filechk,version.h)
 
 # ---------------------------------------------------------------------------
Index: linux-2.6.13-kbuild/scripts/Makefile.lib
===================================================================
--- linux-2.6.13-kbuild.orig/scripts/Makefile.lib
+++ linux-2.6.13-kbuild/scripts/Makefile.lib
@@ -112,7 +112,7 @@ __cpp_flags     = $(_cpp_flags)
 else
 
 # Prefix -I with $(srctree) if it is not an absolute path
-addtree = $(if $(filter-out -I/%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1))) $(1)
+addtree = $(1) $(if $(filter-out -I/%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1)))
 # Find all -I options and call addtree
 flags = $(foreach o,$($(1)),$(if $(filter -I%,$(o)),$(call addtree,$(o)),$(o)))

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVIKHoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVIKHoR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 03:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVIKHoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 03:44:17 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:48945 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S964815AbVIKHoQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 03:44:16 -0400
Date: Sun, 11 Sep 2005 09:45:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new asm-offsets.h patch problems
Message-ID: <20050911074557.GA22452@mars.ravnborg.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F045A8DF3@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F045A8DF3@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iHi Tony

> I'm sometimes ending up with just "#define IA64_TASK_SIZE 0"
> in include/asm-ia64/asm-offsets.h ... but only sometimes.
> 
> My build script does "make prepare; make -j8" ... so I guess
> there are some races in the parallel build?  The "make prepare"
> part used to do the full of build offsets.h, but now it just does
> the ia64 hack.
First an explanation why it doess less today.
The dependency chain looks like this now:

prepare-all
     |
     +---> prepare0
              |
              +--> prepare
              |
	      +--> prepare1
	              |
		      +---> prepare2
		               |
			       +--> prepare3

So executing `make prepare` will only do a subset of what is needed to do
the full build.
But make -j8 should not fail - and I have tried to find what dependency
is missing since you see this odd behaviour. So far with no luck.
Testing on my UP with an ia64 toolchain did not reveal the problem.

Do you recall why you have this make prepare step. It smells like a
workaround for a missing dependency somewhere.


But you put my attention on another matter. I recall several
cross-compile scripts that uses the 'make prepare' target,
and it will no longer behave as expected. So the only correct
solution for that issue is to move up the prepare target in the
dependency chain. But prepare0 needs stuff to be done in arch makefiles
so we cannot have a nameclash there. The solution I made was to rename
the remaining prepare targets in arch Makefile to archprepare.

Tony - can you test below patch and tell it this solve the problem you
see?

Changes outside top-level Makefile and ia64 Makefile is irellevant for
you.

	Sam

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -776,15 +776,16 @@ $(sort $(vmlinux-init) $(vmlinux-main)) 
 # Error messages still appears in the original language
 
 .PHONY: $(vmlinux-dirs)
-$(vmlinux-dirs): prepare-all scripts
+$(vmlinux-dirs): prepare scripts
 	$(Q)$(MAKE) $(build)=$@
 
 # Things we need to do before we recursively start building the kernel
-# or the modules are listed in "prepare-all".
+# or the modules are listed in "prepare".
 # A multi level approach is used. prepare1 is updated first, then prepare0.
-# prepare-all is the collection point for the prepare targets.
+# prepare is the collection point for the prepare targets.
+# prepare-all is old style and kept for compatibility with users build scripts
 
-.PHONY: prepare-all prepare prepare0 prepare1 prepare2 prepare3
+.PHONY: prepare-all prepare archprepare prepare0 prepare1 prepare2 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -813,11 +814,11 @@ ifneq ($(KBUILD_MODULES),)
 	$(Q)mkdir -p $(MODVERDIR)
 endif
 
-prepare0: prepare prepare1 FORCE
+prepare0: archprepare prepare1 FORCE
 	$(Q)$(MAKE) $(build)=.
 
 # All the preparing..
-prepare-all: prepare0
+prepare prepare-all: prepare0
 
 #	Leave this as default for preprocessing vmlinux.lds.S, which is now
 #	done in arch/$(ARCH)/kernel/Makefile
@@ -908,7 +909,7 @@ modules: $(vmlinux-dirs) $(if $(KBUILD_B
 
 # Target to prepare building external modules
 .PHONY: modules_prepare
-modules_prepare: prepare-all scripts
+modules_prepare: prepare scripts
 
 # Target to install modules
 .PHONY: modules_install
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -175,7 +175,7 @@ else
 endif
 	@touch $@
 
-prepare: maketools include/asm-arm/.arch
+archprepare: maketools include/asm-arm/.arch
 
 .PHONY: maketools FORCE
 maketools: include/linux/version.h FORCE
diff --git a/arch/cris/Makefile b/arch/cris/Makefile
--- a/arch/cris/Makefile
+++ b/arch/cris/Makefile
@@ -107,7 +107,7 @@ archclean:
 	rm -f timage vmlinux.bin decompress.bin rescue.bin cramfs.img
 	rm -rf $(LD_SCRIPT).tmp
 
-prepare: $(SRC_ARCH)/.links $(srctree)/include/asm-$(ARCH)/.arch
+archprepare: $(SRC_ARCH)/.links $(srctree)/include/asm-$(ARCH)/.arch
 
 # Create some links to make all tools happy
 $(SRC_ARCH)/.links:
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -82,7 +82,7 @@ unwcheck: vmlinux
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-prepare:  include/asm-ia64/.offsets.h.stamp
+archprepare:  include/asm-ia64/.offsets.h.stamp
 
 include/asm-ia64/.offsets.h.stamp:
 	mkdir -p include/asm-ia64
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -105,7 +105,7 @@ archclean:
 	$(Q)$(MAKE) $(clean)=arch/ppc/boot
 	$(Q)rm -rf include3
 
-prepare: checkbin
+archprepare: checkbin
 
 # Temporary hack until we have migrated to asm-powerpc
 include/asm: include3/asm
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -152,7 +152,7 @@ endif
 	@touch $@
 
 
-prepare: maketools include/asm-sh/.cpu include/asm-sh/.mach
+archprepare: maketools include/asm-sh/.cpu include/asm-sh/.mach
 
 .PHONY: maketools FORCE
 maketools:  include/linux/version.h FORCE
diff --git a/arch/sh64/Makefile b/arch/sh64/Makefile
--- a/arch/sh64/Makefile
+++ b/arch/sh64/Makefile
@@ -73,7 +73,7 @@ compressed: zImage
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-prepare: arch/$(ARCH)/lib/syscalltab.h
+archprepare: arch/$(ARCH)/lib/syscalltab.h
 
 define filechk_gen-syscalltab
        (set -e; \
diff --git a/arch/um/Makefile b/arch/um/Makefile
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -108,7 +108,7 @@ else
 $(shell cd $(ARCH_DIR) && ln -sf Kconfig.$(SUBARCH) Kconfig.arch)
 endif
 
-prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
+archprepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -66,7 +66,7 @@ boot		:= arch/xtensa/boot
 
 archinc		:= include/asm-xtensa
 
-prepare: $(archinc)/.platform
+archprepare: $(archinc)/.platform
 
 # Update machine cpu and platform symlinks if something which affects
 # them changed.

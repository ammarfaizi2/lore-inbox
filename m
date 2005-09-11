Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVIKVrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVIKVrq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbVIKVrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:47:46 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:45953 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750939AbVIKVrp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:47:45 -0400
Date: Sun, 11 Sep 2005 23:49:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: rename prepare to archprepare to fix dependency chain
Message-ID: <20050911214938.GB2177@mars.ravnborg.org>
References: <20050911214850.GA2177@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911214850.GA2177@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH 1/3] kbuild: rename prepare to archprepare to fix dependency chain

When introducing the generic asm-offsets.h support the dependency
chain for the prepare targets was changed. All build scripts expecting
include/asm/asm-offsets.h to be made when using the prepare target would broke.
With the limited number of prepare targets left in arch Makefiles
the trivial solution was to introduce a new arch specific target: archprepare

The dependency chain looks like this now:

prepare
  |
  +--> prepare0
         |
         +--> archprepare
                |
		+--> scripts_basic
                +--> prepare1
                       |
                       +---> prepare2
                               |
                               +--> prepare3

So prepare 3 is processed before prepare2 etc.
This guaantees that the asm symlink, version.h, scripts_basic
are all updated before archprepare is processed.

prepare0 which build the asm-offsets.h file will need the
actions performed by archprepare.

The head target is now named prepare, because users scripts will most
likely use that target, but prepare-all has been kept for compatibility.
Updated Documentation/kbuild/makefiles.txt.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Documentation/kbuild/makefiles.txt |   14 +++++++-------
 Makefile                           |   23 +++++++++++++++--------
 arch/arm/Makefile                  |    2 +-
 arch/cris/Makefile                 |    2 +-
 arch/ia64/Makefile                 |    2 +-
 arch/ppc/Makefile                  |    2 +-
 arch/sh/Makefile                   |    2 +-
 arch/sh64/Makefile                 |    2 +-
 arch/um/Makefile                   |    2 +-
 arch/xtensa/Makefile               |    2 +-
 10 files changed, 30 insertions(+), 23 deletions(-)

5bb78269000cf326bfdfa19f79449c02a9158020
diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -31,7 +31,7 @@ This document describes the Linux kernel
 
 	=== 6 Architecture Makefiles
 	   --- 6.1 Set variables to tweak the build to the architecture
-	   --- 6.2 Add prerequisites to prepare:
+	   --- 6.2 Add prerequisites to archprepare:
 	   --- 6.3 List directories to visit when descending
 	   --- 6.4 Architecture specific boot images
 	   --- 6.5 Building non-kbuild targets
@@ -734,18 +734,18 @@ When kbuild executes the following steps
 	for loadable kernel modules.
 
  
---- 6.2 Add prerequisites to prepare:
+--- 6.2 Add prerequisites to archprepare:
 
-	The prepare: rule is used to list prerequisites that needs to be
+	The archprepare: rule is used to list prerequisites that needs to be
 	built before starting to descend down in the subdirectories.
 	This is usual header files containing assembler constants.
 
 		Example:
-		#arch/s390/Makefile
-		prepare: include/asm-$(ARCH)/offsets.h
+		#arch/arm/Makefile
+		archprepare: maketools
 
-	In this example the file include/asm-$(ARCH)/offsets.h will
-	be built before descending down in the subdirectories.
+	In this example the file target maketools will be processed
+	before descending down in the subdirectories.
 	See also chapter XXX-TODO that describe how kbuild supports
 	generating offset header files.
 
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -776,15 +776,20 @@ $(sort $(vmlinux-init) $(vmlinux-main)) 
 # Error messages still appears in the original language
 
 .PHONY: $(vmlinux-dirs)
-$(vmlinux-dirs): prepare-all scripts
+$(vmlinux-dirs): prepare scripts
 	$(Q)$(MAKE) $(build)=$@
 
 # Things we need to do before we recursively start building the kernel
-# or the modules are listed in "prepare-all".
-# A multi level approach is used. prepare1 is updated first, then prepare0.
-# prepare-all is the collection point for the prepare targets.
+# or the modules are listed in "prepare".
+# A multi level approach is used. prepareN is processed before prepareN-1.
+# archprepare is used in arch Makefiles and when processed asm symlink,
+# version.h and scripts_basic is processed / created.
 
-.PHONY: prepare-all prepare prepare0 prepare1 prepare2 prepare3
+# Listed in dependency order
+.PHONY: prepare archprepare prepare0 prepare1 prepare2 prepare3
+
+# prepare-all is deprecated, use prepare as valid replacement
+.PHONY: prepare-all
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -813,11 +818,13 @@ ifneq ($(KBUILD_MODULES),)
 	$(Q)mkdir -p $(MODVERDIR)
 endif
 
-prepare0: prepare prepare1 FORCE
+archprepare: prepare1 scripts_basic
+
+prepare0: archprepare FORCE
 	$(Q)$(MAKE) $(build)=.
 
 # All the preparing..
-prepare-all: prepare0
+prepare prepare-all: prepare0
 
 #	Leave this as default for preprocessing vmlinux.lds.S, which is now
 #	done in arch/$(ARCH)/kernel/Makefile
@@ -908,7 +915,7 @@ modules: $(vmlinux-dirs) $(if $(KBUILD_B
 
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
@@ -107,7 +107,7 @@ archclean:
 	# Temporary hack until we have migrated to asm-powerpc
 	$(Q)rm -rf arch/$(ARCH)/include
 
-prepare: checkbin
+archprepare: checkbin
 
 # Temporary hack until we have migrated to asm-powerpc
 include/asm: arch/$(ARCH)/include/asm
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
@@ -107,7 +107,7 @@ else
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

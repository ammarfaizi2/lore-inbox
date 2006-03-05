Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWCEWON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWCEWON (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWCEWON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:14:13 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:55451 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751880AbWCEWOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:14:12 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] change kbuild to not rely on incorrect GNU make behavior
Organization: GNU's Not UNIX!
From: Paul Smith <psmith@gnu.org>
Reply-to: Paul Smith <psmith@gnu.org>
Message-Id: <E1FG1UQ-00045B-5P@fencepost.gnu.org>
Date: Sun, 05 Mar 2006 17:14:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kbuild system takes advantage of an incorrect behavior in GNU make.
Once this behavior is fixed, all files in the kernel rebuild every time,
even if nothing has changed.  This patch ensures kbuild works with both
the incorrect and correct behaviors of GNU make.

For more details on the incorrect behavior, see:

http://lists.gnu.org/archive/html/bug-make/2006-03/msg00003.html


Changes in this patch:
  - Keep all targets that are to be marked .PHONY in a variable, PHONY.
  - Add .PHONY: $(PHONY) to mark them properly.
  - Remove any $(PHONY) files from the $? list when determining whether
    targets are up-to-date or not.


Signed-off-by: Paul Smith <psmith@gnu.org>

---
diff -u -uprN linux-2.6.15-vanilla/Documentation/DocBook/Makefile linux-2.6.15/Documentation/DocBook/Makefile
--- linux-2.6.15-vanilla/Documentation/DocBook/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/Documentation/DocBook/Makefile	2006-03-05 12:34:26.617709252 -0500
@@ -28,7 +28,7 @@ PS_METHOD	= $(prefer-db2x)
 
 ###
 # The targets that may be used.
-.PHONY:	xmldocs sgmldocs psdocs pdfdocs htmldocs mandocs installmandocs
+PHONY += xmldocs sgmldocs psdocs pdfdocs htmldocs mandocs installmandocs
 
 BOOKS := $(addprefix $(obj)/,$(DOCBOOKS))
 xmldocs: $(BOOKS)
@@ -211,3 +211,9 @@ clean-dirs := $(patsubst %.xml,%,$(DOCBO
 
 #man put files in man subdir - traverse down
 subdir- := man/
+
+
+# Declare the contents of the .PHONY variable as phony.  We keep that
+# information in a variable se we can use it in if_changed and friends.
+
+.PHONY: $(PHONY)
diff -u -uprN linux-2.6.15-vanilla/Makefile linux-2.6.15/Makefile
--- linux-2.6.15-vanilla/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/Makefile	2006-03-05 12:34:26.620707970 -0500
@@ -95,7 +95,7 @@ ifdef O
 endif
 
 # That's our default target when none is given on the command line
-.PHONY: _all
+PHONY := _all
 _all:
 
 ifneq ($(KBUILD_OUTPUT),)
@@ -106,7 +106,7 @@ KBUILD_OUTPUT := $(shell cd $(KBUILD_OUT
 $(if $(KBUILD_OUTPUT),, \
      $(error output directory "$(saved-output)" does not exist))
 
-.PHONY: $(MAKECMDGOALS)
+PHONY += $(MAKECMDGOALS)
 
 $(filter-out _all,$(MAKECMDGOALS)) _all:
 	$(if $(KBUILD_VERBOSE:1=),@)$(MAKE) -C $(KBUILD_OUTPUT) \
@@ -123,7 +123,7 @@ ifeq ($(skip-makefile),)
 
 # If building an external module we do not care about the all: rule
 # but instead _all depend on modules
-.PHONY: all
+PHONY += all
 ifeq ($(KBUILD_EXTMOD),)
 _all: all
 else
@@ -380,14 +380,14 @@ export RCS_TAR_IGNORE := --exclude SCCS 
 # Rules shared between *config targets and build targets
 
 # Basic helpers built in scripts/
-.PHONY: scripts_basic
+PHONY += scripts_basic
 scripts_basic:
 	$(Q)$(MAKE) $(build)=scripts/basic
 
 # To avoid any implicit rule to kick in, define an empty command.
 scripts/basic/%: scripts_basic ;
 
-.PHONY: outputmakefile
+PHONY += outputmakefile
 # outputmakefile generate a Makefile to be placed in output directory, if
 # using a seperate output directory. This allows convinient use
 # of make in output directory
@@ -462,7 +462,7 @@ ifeq ($(KBUILD_EXTMOD),)
 # Additional helpers built in scripts/
 # Carefully list dependencies so we do not try to build scripts twice
 # in parrallel
-.PHONY: scripts
+PHONY += scripts
 scripts: scripts_basic include/config/MARKER
 	$(Q)$(MAKE) $(build)=$(@)
 
@@ -780,7 +780,7 @@ $(sort $(vmlinux-init) $(vmlinux-main)) 
 # make menuconfig etc.
 # Error messages still appears in the original language
 
-.PHONY: $(vmlinux-dirs)
+PHONY += $(vmlinux-dirs)
 $(vmlinux-dirs): prepare scripts
 	$(Q)$(MAKE) $(build)=$@
 
@@ -791,10 +791,10 @@ $(vmlinux-dirs): prepare scripts
 # version.h and scripts_basic is processed / created.
 
 # Listed in dependency order
-.PHONY: prepare archprepare prepare0 prepare1 prepare2 prepare3
+PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
 
 # prepare-all is deprecated, use prepare as valid replacement
-.PHONY: prepare-all
+PHONY += prepare-all
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -897,7 +897,7 @@ include/linux/version.h: $(srctree)/Make
 
 # ---------------------------------------------------------------------------
 
-.PHONY: depend dep
+PHONY += depend dep
 depend dep:
 	@echo '*** Warning: make $@ is unnecessary now.'
 
@@ -912,21 +912,21 @@ all: modules
 
 #	Build modules
 
-.PHONY: modules
+PHONY += modules
 modules: $(vmlinux-dirs) $(if $(KBUILD_BUILTIN),vmlinux)
 	@echo '  Building modules, stage 2.';
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
 
 # Target to prepare building external modules
-.PHONY: modules_prepare
+PHONY += modules_prepare
 modules_prepare: prepare scripts
 
 # Target to install modules
-.PHONY: modules_install
+PHONY += modules_install
 modules_install: _modinst_ _modinst_post
 
-.PHONY: _modinst_
+PHONY += _modinst_
 _modinst_:
 	@if [ -z "`$(DEPMOD) -V 2>/dev/null | grep module-init-tools`" ]; then \
 		echo "Warning: you may need to install module-init-tools"; \
@@ -953,7 +953,7 @@ depmod_opts	:=
 else
 depmod_opts	:= -b $(INSTALL_MOD_PATH) -r
 endif
-.PHONY: _modinst_post
+PHONY += _modinst_post
 _modinst_post: _modinst_
 	if [ -r System.map -a -x $(DEPMOD) ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
 
@@ -996,7 +996,7 @@ clean: rm-dirs  := $(CLEAN_DIRS)
 clean: rm-files := $(CLEAN_FILES)
 clean-dirs      := $(addprefix _clean_,$(srctree) $(vmlinux-alldirs))
 
-.PHONY: $(clean-dirs) clean archclean
+PHONY += $(clean-dirs) clean archclean
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
@@ -1014,7 +1014,7 @@ mrproper: rm-dirs  := $(wildcard $(MRPRO
 mrproper: rm-files := $(wildcard $(MRPROPER_FILES))
 mrproper-dirs      := $(addprefix _mrproper_,Documentation/DocBook scripts)
 
-.PHONY: $(mrproper-dirs) mrproper archmrproper
+PHONY += $(mrproper-dirs) mrproper archmrproper
 $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
 
@@ -1024,7 +1024,7 @@ mrproper: clean archmrproper $(mrproper-
 
 # distclean
 #
-.PHONY: distclean
+PHONY += distclean
 
 distclean: mrproper
 	@find $(srctree) $(RCS_FIND_IGNORE) \
@@ -1040,7 +1040,7 @@ distclean: mrproper
 # rpm target kept for backward compatibility
 package-dir	:= $(srctree)/scripts/package
 
-.PHONY: %-pkg rpm
+PHONY += %-pkg rpm
 
 %pkg: FORCE
 	$(Q)$(MAKE) -f $(package-dir)/Makefile $@
@@ -1131,11 +1131,11 @@ else # KBUILD_EXTMOD
 
 # We are always building modules
 KBUILD_MODULES := 1
-.PHONY: crmodverdir
+PHONY += crmodverdir
 crmodverdir:
 	$(Q)mkdir -p $(MODVERDIR)
 
-.PHONY: $(objtree)/Module.symvers
+PHONY += $(objtree)/Module.symvers
 $(objtree)/Module.symvers:
 	@test -e $(objtree)/Module.symvers || ( \
 	echo; \
@@ -1144,7 +1144,7 @@ $(objtree)/Module.symvers:
 	echo )
 
 module-dirs := $(addprefix _module_,$(KBUILD_EXTMOD))
-.PHONY: $(module-dirs) modules
+PHONY += $(module-dirs) modules
 $(module-dirs): crmodverdir $(objtree)/Module.symvers
 	$(Q)$(MAKE) $(build)=$(patsubst _module_%,%,$@)
 
@@ -1152,13 +1152,13 @@ modules: $(module-dirs)
 	@echo '  Building modules, stage 2.';
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
-.PHONY: modules_install
+PHONY += modules_install
 modules_install:
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
 
 clean-dirs := $(addprefix _clean_,$(KBUILD_EXTMOD))
 
-.PHONY: $(clean-dirs) clean
+PHONY += $(clean-dirs) clean
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
@@ -1282,7 +1282,7 @@ namespacecheck:
 endif #ifeq ($(config-targets),1)
 endif #ifeq ($(mixed-targets),1)
 
-.PHONY: checkstack
+PHONY += checkstack
 checkstack:
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
 	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
@@ -1324,4 +1324,11 @@ clean := -f $(if $(KBUILD_SRC),$(srctree
 
 endif	# skip-makefile
 
+PHONY += FORCE
 FORCE:
+
+
+# Declare the contents of the .PHONY variable as phony.  We keep that
+# information in a variable se we can use it in if_changed and friends.
+
+.PHONY: $(PHONY)
diff -u -uprN linux-2.6.15-vanilla/arch/arm/Makefile linux-2.6.15/arch/arm/Makefile
--- linux-2.6.15-vanilla/arch/arm/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/arm/Makefile	2006-03-05 12:34:26.621707543 -0500
@@ -1,6 +1,9 @@
 #
 # arch/arm/Makefile
 #
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
@@ -172,7 +176,7 @@ endif
 
 archprepare: maketools
 
-.PHONY: maketools FORCE
+PHONY += maketools FORCE
 maketools: include/linux/version.h include/asm-arm/.arch FORCE
 	$(Q)$(MAKE) $(build)=arch/arm/tools include/asm-arm/mach-types.h
 
diff -u -uprN linux-2.6.15-vanilla/arch/arm/boot/Makefile linux-2.6.15/arch/arm/boot/Makefile
--- linux-2.6.15-vanilla/arch/arm/boot/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/arm/boot/Makefile	2006-03-05 12:34:26.621707543 -0500
@@ -1,6 +1,9 @@
 #
 # arch/arm/boot/Makefile
 #
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
@@ -73,7 +77,7 @@ $(obj)/bootpImage: $(obj)/bootp/bootp FO
 	$(call if_changed,objcopy)
 	@echo '  Kernel: $@ is ready'
 
-.PHONY: initrd FORCE
+PHONY += initrd FORCE
 initrd:
 	@test "$(INITRD_PHYS)" != "" || \
 	(echo This machine does not support INITRD; exit -1)
diff -u -uprN linux-2.6.15-vanilla/arch/arm/boot/bootp/Makefile linux-2.6.15/arch/arm/boot/bootp/Makefile
--- linux-2.6.15-vanilla/arch/arm/boot/bootp/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/arm/boot/bootp/Makefile	2006-03-05 12:34:26.622707115 -0500
@@ -1,6 +1,9 @@
 #
 # linux/arch/arm/boot/bootp/Makefile
 #
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 
 LDFLAGS_bootp	:=-p --no-undefined -X \
 		 --defsym initrd_phys=$(INITRD_PHYS) \
@@ -21,4 +25,4 @@ $(obj)/kernel.o: arch/arm/boot/zImage FO
 
 $(obj)/initrd.o: $(INITRD) FORCE
 
-.PHONY:	$(INITRD) FORCE
+PHONY += $(INITRD) FORCE
diff -u -uprN linux-2.6.15-vanilla/arch/arm26/Makefile linux-2.6.15/arch/arm26/Makefile
--- linux-2.6.15-vanilla/arch/arm26/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/arm26/Makefile	2006-03-05 12:34:26.635701560 -0500
@@ -1,6 +1,9 @@
 #
 # arch/arm26/Makefile
 #
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
@@ -49,9 +53,9 @@ all: zImage
 
 boot := arch/arm26/boot
 
-.PHONY: maketools FORCE
+PHONY += maketools FORCE
 maketools: FORCE
-	
+
 
 # Convert bzImage to zImage
 bzImage: vmlinux
diff -u -uprN linux-2.6.15-vanilla/arch/arm26/boot/Makefile linux-2.6.15/arch/arm26/boot/Makefile
--- linux-2.6.15-vanilla/arch/arm26/boot/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/arm26/boot/Makefile	2006-03-05 12:34:26.642698569 -0500
@@ -1,6 +1,9 @@
 #
 # arch/arm26/boot/Makefile
 #
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
@@ -60,7 +64,7 @@ $(obj)/xipImage: vmlinux FORCE
 	@echo '  Kernel: $@ is ready'
 endif
 
-.PHONY: initrd
+PHONY += initrd
 initrd:
 	@test "$(INITRD_PHYS)" != "" || \
 	(echo This machine does not support INITRD; exit -1)
diff -u -uprN linux-2.6.15-vanilla/arch/i386/Makefile linux-2.6.15/arch/i386/Makefile
--- linux-2.6.15-vanilla/arch/i386/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/i386/Makefile	2006-03-05 12:34:26.657692159 -0500
@@ -102,8 +102,8 @@ AFLAGS += $(mflags-y)
 
 boot := arch/i386/boot
 
-.PHONY: zImage bzImage compressed zlilo bzlilo \
-	zdisk bzdisk fdimage fdimage144 fdimage288 install kernel_install
+PHONY += zImage bzImage compressed zlilo bzlilo \
+	 zdisk bzdisk fdimage fdimage144 fdimage288 install kernel_install
 
 all: bzImage
 
diff -u -uprN linux-2.6.15-vanilla/arch/ia64/Makefile linux-2.6.15/arch/ia64/Makefile
--- linux-2.6.15-vanilla/arch/ia64/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/ia64/Makefile	2006-03-05 12:34:26.658691732 -0500
@@ -1,6 +1,9 @@
 #
 # ia64/Makefile
 #
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
@@ -67,7 +71,7 @@ drivers-$(CONFIG_OPROFILE)	+= arch/ia64/
 
 boot := arch/ia64/hp/sim/boot
 
-.PHONY: boot compressed check
+PHONY += boot compressed check
 
 all: compressed unwcheck
 
diff -u -uprN linux-2.6.15-vanilla/arch/m32r/Makefile linux-2.6.15/arch/m32r/Makefile
--- linux-2.6.15-vanilla/arch/m32r/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/m32r/Makefile	2006-03-05 12:34:26.658691732 -0500
@@ -1,6 +1,9 @@
 #
 # m32r/Makefile
 #
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 
 LDFLAGS		:=
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
@@ -39,7 +43,7 @@ drivers-$(CONFIG_OPROFILE)	+= arch/m32r/
 
 boot := arch/m32r/boot
 
-.PHONY: zImage
+PHONY += zImage
 
 all: zImage
 
diff -u -uprN linux-2.6.15-vanilla/arch/powerpc/Makefile linux-2.6.15/arch/powerpc/Makefile
--- linux-2.6.15-vanilla/arch/powerpc/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/powerpc/Makefile	2006-03-05 12:34:26.659691305 -0500
@@ -153,7 +153,7 @@ bzImage: zImage
 
 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
 
-.PHONY: $(BOOT_TARGETS)
+PHONY += $(BOOT_TARGETS)
 
 boot := arch/$(ARCH)/boot
 
diff -u -uprN linux-2.6.15-vanilla/arch/ppc/Makefile linux-2.6.15/arch/ppc/Makefile
--- linux-2.6.15-vanilla/arch/ppc/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/ppc/Makefile	2006-03-05 12:34:26.659691305 -0500
@@ -82,7 +82,7 @@ drivers-$(CONFIG_OPROFILE)	+= arch/power
 
 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
 
-.PHONY: $(BOOT_TARGETS)
+PHONY += $(BOOT_TARGETS)
 
 all: uImage zImage
 
diff -u -uprN linux-2.6.15-vanilla/arch/ppc/boot/Makefile linux-2.6.15/arch/ppc/boot/Makefile
--- linux-2.6.15-vanilla/arch/ppc/boot/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/ppc/boot/Makefile	2006-03-05 12:34:26.660690877 -0500
@@ -1,6 +1,9 @@
 #
 # arch/ppc/boot/Makefile
 #
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
@@ -25,7 +29,7 @@ subdir-				+= simple openfirmware
 
 hostprogs-y := $(addprefix utils/, addnote mknote hack-coff mkprep mkbugboot mktree)
 
-.PHONY: $(BOOT_TARGETS) $(bootdir-y)
+PHONY += $(BOOT_TARGETS) $(bootdir-y)
 
 $(BOOT_TARGETS): $(bootdir-y)
 
diff -u -uprN linux-2.6.15-vanilla/arch/ppc/boot/openfirmware/Makefile linux-2.6.15/arch/ppc/boot/openfirmware/Makefile
--- linux-2.6.15-vanilla/arch/ppc/boot/openfirmware/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/ppc/boot/openfirmware/Makefile	2006-03-05 12:34:26.669687031 -0500
@@ -1,5 +1,8 @@
 # Makefile for making bootable images on various OpenFirmware machines.
 #
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 # Paul Mackerras	January 1997
 #	XCOFF bootable images for PowerMacs
 # Geert Uytterhoeven	September 1997
@@ -150,7 +154,7 @@ $(images)/miboot.initrd.image: $(images)
 
 # The targets used on the make command-line
 
-.PHONY: zImage zImage.initrd
+PHONY += zImage zImage.initrd
 zImage:		 $(images)/vmlinux.coff 	\
 		 $(images)/vmlinux.elf-pmac	\
 		 $(images)/zImage.chrp		\
@@ -166,7 +170,7 @@ zImage.initrd:	 $(images)/vmlinux.initrd
 
 TFTPIMAGE	:= /tftpboot/zImage
 
-.PHONY: znetboot znetboot.initrd
+PHONY += znetboot znetboot.initrd
 znetboot:	$(images)/vmlinux.coff		\
 		$(images)/vmlinux.elf-pmac	\
 		$(images)/zImage.chrp
diff -u -uprN linux-2.6.15-vanilla/arch/sh/Makefile linux-2.6.15/arch/sh/Makefile
--- linux-2.6.15-vanilla/arch/sh/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/sh/Makefile	2006-03-05 12:34:26.670686604 -0500
@@ -146,7 +146,7 @@ endif
 
 archprepare: maketools include/asm-sh/.cpu include/asm-sh/.mach
 
-.PHONY: maketools FORCE
+PHONY += maketools FORCE
 maketools:  include/linux/version.h FORCE
 	$(Q)$(MAKE) $(build)=arch/sh/tools include/asm-sh/machtypes.h
 
diff -u -uprN linux-2.6.15-vanilla/arch/um/Makefile linux-2.6.15/arch/um/Makefile
--- linux-2.6.15-vanilla/arch/um/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/um/Makefile	2006-03-05 12:34:26.676684040 -0500
@@ -1,4 +1,7 @@
-# 
+#
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 # Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
 # Licensed under the GPL
 #
@@ -83,7 +87,7 @@ CONFIG_KERNEL_HALF_GIGS ?= 0
 
 SIZE = (($(CONFIG_NEST_LEVEL) + $(CONFIG_KERNEL_HALF_GIGS)) * 0x20000000)
 
-.PHONY: linux
+PHONY += linux
 
 all: linux
 
diff -u -uprN linux-2.6.15-vanilla/arch/x86_64/Makefile linux-2.6.15/arch/x86_64/Makefile
--- linux-2.6.15-vanilla/arch/x86_64/Makefile	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/arch/x86_64/Makefile	2006-03-05 12:34:26.676684040 -0500
@@ -62,8 +62,8 @@ drivers-$(CONFIG_OPROFILE)		+= arch/x86_
 
 boot := arch/x86_64/boot
 
-.PHONY: bzImage bzlilo install archmrproper \
-	fdimage fdimage144 fdimage288 archclean
+PHONY += bzImage bzlilo install archmrproper \
+	 fdimage fdimage144 fdimage288 archclean
 
 #Default target when executing "make"
 all: bzImage
diff -u -uprN linux-2.6.15-vanilla/scripts/Kbuild.include linux-2.6.15/scripts/Kbuild.include
--- linux-2.6.15-vanilla/scripts/Kbuild.include	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/scripts/Kbuild.include	2006-03-05 12:34:26.000000000 -0500
@@ -73,8 +73,8 @@ echo-cmd = $(if $($(quiet)cmd_$(1)), \
 # function to only execute the passed command if necessary
 # >'< substitution is for echo to work, >$< substitution to preserve $ when reloading .cmd file
 # note: when using inline perl scripts [perl -e '...$$t=1;...'] in $(cmd_xxx) double $$ your perl vars
-# 
-if_changed = $(if $(strip $? $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
+#
+if_changed = $(if $(strip $(filter-out $(PHONY),$?) $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
 	@set -e; \
 	$(echo-cmd) \
 	$(cmd_$(1)); \
@@ -82,7 +82,7 @@ if_changed = $(if $(strip $? $(call arg-
 
 # execute the command and also postprocess generated .d dependencies
 # file
-if_changed_dep = $(if $(strip $? $(filter-out FORCE $(wildcard $^),$^)\
+if_changed_dep = $(if $(strip $(filter-out $(PHONY),$?) $(filter-out FORCE $(wildcard $^),$^)\
 	$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),                  \
 	@set -e; \
 	$(echo-cmd) \
@@ -94,6 +94,6 @@ if_changed_dep = $(if $(strip $? $(filte
 # Usage: $(call if_changed_rule,foo)
 # will check if $(cmd_foo) changed, or any of the prequisites changed,
 # and if so will execute $(rule_foo)
-if_changed_rule = $(if $(strip $? $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
+if_changed_rule = $(if $(strip $(filter-out $(PHONY),$?) $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
 			@set -e; \
 			$(rule_$(1)))
diff -u -uprN linux-2.6.15-vanilla/scripts/Makefile.build linux-2.6.15/scripts/Makefile.build
--- linux-2.6.15-vanilla/scripts/Makefile.build	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/scripts/Makefile.build	2006-03-05 12:34:39.859048614 -0500
@@ -4,7 +4,7 @@
 
 src := $(obj)
 
-.PHONY: __build
+PHONY := __build
 __build:
 
 # Read .config if it exist, otherwise ignore
@@ -309,14 +309,14 @@ targets += $(multi-used-y) $(multi-used-
 # Descending
 # ---------------------------------------------------------------------------
 
-.PHONY: $(subdir-ym)
+PHONY += $(subdir-ym)
 $(subdir-ym):
 	$(Q)$(MAKE) $(build)=$@
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
 
-.PHONY: FORCE
+PHONY += FORCE
 
 FORCE:
 
@@ -331,3 +331,9 @@ cmd_files := $(wildcard $(foreach f,$(ta
 ifneq ($(cmd_files),)
   include $(cmd_files)
 endif
+
+
+# Declare the contents of the .PHONY variable as phony.  We keep that
+# information in a variable se we can use it in if_changed and friends.
+
+.PHONY: $(PHONY)
diff -u -uprN linux-2.6.15-vanilla/scripts/Makefile.clean linux-2.6.15/scripts/Makefile.clean
--- linux-2.6.15-vanilla/scripts/Makefile.clean	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/scripts/Makefile.clean	2006-03-05 12:34:26.000000000 -0500
@@ -4,7 +4,7 @@
 
 src := $(obj)
 
-.PHONY: __clean
+PHONY := __clean
 __clean:
 
 # Shorthand for $(Q)$(MAKE) scripts/Makefile.clean obj=dir
@@ -87,10 +87,16 @@ endif
 # Descending
 # ---------------------------------------------------------------------------
 
-.PHONY: $(subdir-ymn)
+PHONY += $(subdir-ymn)
 $(subdir-ymn):
 	$(Q)$(MAKE) $(clean)=$@
 
 # If quiet is set, only print short version of command
 
 cmd = @$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))' &&) $(cmd_$(1))
+
+
+# Declare the contents of the .PHONY variable as phony.  We keep that
+# information in a variable se we can use it in if_changed and friends.
+
+.PHONY: $(PHONY)
diff -u -uprN linux-2.6.15-vanilla/scripts/Makefile.modinst linux-2.6.15/scripts/Makefile.modinst
--- linux-2.6.15-vanilla/scripts/Makefile.modinst	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/scripts/Makefile.modinst	2006-03-05 12:34:26.000000000 -0500
@@ -2,7 +2,7 @@
 # Installing modules
 # ==========================================================================
 
-.PHONY: __modinst
+PHONY := __modinst
 __modinst:
 
 include scripts/Kbuild.include
@@ -12,7 +12,7 @@ include scripts/Kbuild.include
 __modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
 modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
 
-.PHONY: $(modules)
+PHONY += $(modules)
 __modinst: $(modules)
 	@:
 
@@ -27,3 +27,9 @@ modinst_dir = $(if $(KBUILD_EXTMOD),$(ex
 
 $(modules):
 	$(call cmd,modules_install,$(MODLIB)/$(modinst_dir))
+
+
+# Declare the contents of the .PHONY variable as phony.  We keep that
+# information in a variable se we can use it in if_changed and friends.
+
+.PHONY: $(PHONY)
diff -u -uprN linux-2.6.15-vanilla/scripts/Makefile.modpost linux-2.6.15/scripts/Makefile.modpost
--- linux-2.6.15-vanilla/scripts/Makefile.modpost	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/scripts/Makefile.modpost	2006-03-05 12:34:26.000000000 -0500
@@ -32,7 +32,7 @@
 # Step 4 is solely used to allow module versioning in external modules,
 # where the CRC of each module is retreived from the Module.symers file.
 
-.PHONY: _modpost
+PHONY := _modpost
 _modpost: __modpost
 
 include .config
@@ -57,7 +57,7 @@ quiet_cmd_modpost = MODPOST
 	$(if $(KBUILD_EXTMOD),-i,-o) $(symverfile) \
 	$(filter-out FORCE,$^)
 
-.PHONY: __modpost
+PHONY += __modpost
 __modpost: $(wildcard vmlinux) $(modules:.ko=.o) FORCE
 	$(call cmd,modpost)
 
@@ -94,7 +94,7 @@ targets += $(modules)
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
 
-.PHONY: FORCE
+PHONY += FORCE
 
 FORCE:
 
@@ -109,3 +109,9 @@ cmd_files := $(wildcard $(foreach f,$(ta
 ifneq ($(cmd_files),)
   include $(cmd_files)
 endif
+
+
+# Declare the contents of the .PHONY variable as phony.  We keep that
+# information in a variable se we can use it in if_changed and friends.
+
+.PHONY: $(PHONY)


-- 
-------------------------------------------------------------------------------
 Paul D. Smith <psmith@gnu.org>          Find some GNU make tips at:
 http://www.gnu.org                      http://make.paulandlesley.org
 "Please remain calm...I may be mad, but I am a professional." --Mad Scientist

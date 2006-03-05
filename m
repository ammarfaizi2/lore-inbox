Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751911AbWCEXN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWCEXN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbWCEXN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:13:29 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:7945 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751911AbWCEXN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:13:28 -0500
Date: Mon, 6 Mar 2006 00:13:12 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Paul Smith <psmith@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] change kbuild to not rely on incorrect GNU make behavior
Message-ID: <20060305231312.GA25673@mars.ravnborg.org>
References: <E1FG1UQ-00045B-5P@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FG1UQ-00045B-5P@fencepost.gnu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 05:14:10PM -0500, Paul Smith wrote:
> The kbuild system takes advantage of an incorrect behavior in GNU make.
> Once this behavior is fixed, all files in the kernel rebuild every time,
> even if nothing has changed.  This patch ensures kbuild works with both
> the incorrect and correct behaviors of GNU make.
> 
> For more details on the incorrect behavior, see:
> 
> http://lists.gnu.org/archive/html/bug-make/2006-03/msg00003.html
> 
> 
> Changes in this patch:
>   - Keep all targets that are to be marked .PHONY in a variable, PHONY.
>   - Add .PHONY: $(PHONY) to mark them properly.
>   - Remove any $(PHONY) files from the $? list when determining whether
>     targets are up-to-date or not.
> 
> 
> Signed-off-by: Paul Smith <psmith@gnu.org>

Thanks Paul.
Adapted to -rc4 and applied to my kbuild tree which I have pushed out.
For reference I added the applied patch below.

The patch will be included in 2.6.17 and will see exposure in -mm when
Andrew does next -mm.

	Sam

diff --git a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
index 1c95588..2c6f66d 100644
--- a/Documentation/DocBook/Makefile
+++ b/Documentation/DocBook/Makefile
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
diff --git a/Makefile b/Makefile
index 12c8d71..a59c1e2 100644
--- a/Makefile
+++ b/Makefile
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
@@ -337,14 +337,14 @@ export RCS_TAR_IGNORE := --exclude SCCS 
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
@@ -420,7 +420,7 @@ ifeq ($(KBUILD_EXTMOD),)
 # Additional helpers built in scripts/
 # Carefully list dependencies so we do not try to build scripts twice
 # in parrallel
-.PHONY: scripts
+PHONY += scripts
 scripts: scripts_basic include/config/MARKER
 	$(Q)$(MAKE) $(build)=$(@)
 
@@ -720,7 +720,7 @@ $(sort $(vmlinux-init) $(vmlinux-main)) 
 # make menuconfig etc.
 # Error messages still appears in the original language
 
-.PHONY: $(vmlinux-dirs)
+PHONY += $(vmlinux-dirs)
 $(vmlinux-dirs): prepare scripts
 	$(Q)$(MAKE) $(build)=$@
 
@@ -773,10 +773,10 @@ kernelrelease = $(KERNELVERSION)$(localv
 # version.h and scripts_basic is processed / created.
 
 # Listed in dependency order
-.PHONY: prepare archprepare prepare0 prepare1 prepare2 prepare3
+PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
 
 # prepare-all is deprecated, use prepare as valid replacement
-.PHONY: prepare-all
+PHONY += prepare-all
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -857,7 +857,7 @@ include/linux/version.h: $(srctree)/Make
 
 # ---------------------------------------------------------------------------
 
-.PHONY: depend dep
+PHONY += depend dep
 depend dep:
 	@echo '*** Warning: make $@ is unnecessary now.'
 
@@ -872,21 +872,21 @@ all: modules
 
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
@@ -913,7 +913,7 @@ depmod_opts	:=
 else
 depmod_opts	:= -b $(INSTALL_MOD_PATH) -r
 endif
-.PHONY: _modinst_post
+PHONY += _modinst_post
 _modinst_post: _modinst_
 	if [ -r System.map -a -x $(DEPMOD) ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
 
@@ -956,7 +956,7 @@ clean: rm-dirs  := $(CLEAN_DIRS)
 clean: rm-files := $(CLEAN_FILES)
 clean-dirs      := $(addprefix _clean_,$(srctree) $(vmlinux-alldirs))
 
-.PHONY: $(clean-dirs) clean archclean
+PHONY += $(clean-dirs) clean archclean
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
@@ -974,7 +974,7 @@ mrproper: rm-dirs  := $(wildcard $(MRPRO
 mrproper: rm-files := $(wildcard $(MRPROPER_FILES))
 mrproper-dirs      := $(addprefix _mrproper_,Documentation/DocBook scripts)
 
-.PHONY: $(mrproper-dirs) mrproper archmrproper
+PHONY += $(mrproper-dirs) mrproper archmrproper
 $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
 
@@ -984,7 +984,7 @@ mrproper: clean archmrproper $(mrproper-
 
 # distclean
 #
-.PHONY: distclean
+PHONY += distclean
 
 distclean: mrproper
 	@find $(srctree) $(RCS_FIND_IGNORE) \
@@ -1000,7 +1000,7 @@ distclean: mrproper
 # rpm target kept for backward compatibility
 package-dir	:= $(srctree)/scripts/package
 
-.PHONY: %-pkg rpm
+PHONY += %-pkg rpm
 
 %pkg: FORCE
 	$(Q)$(MAKE) -f $(package-dir)/Makefile $@
@@ -1092,12 +1092,12 @@ else # KBUILD_EXTMOD
 
 # We are always building modules
 KBUILD_MODULES := 1
-.PHONY: crmodverdir
+PHONY += crmodverdir
 crmodverdir:
 	$(Q)rm -rf $(MODVERDIR)
 	$(Q)mkdir -p $(MODVERDIR)
 
-.PHONY: $(objtree)/Module.symvers
+PHONY += $(objtree)/Module.symvers
 $(objtree)/Module.symvers:
 	@test -e $(objtree)/Module.symvers || ( \
 	echo; \
@@ -1106,7 +1106,7 @@ $(objtree)/Module.symvers:
 	echo )
 
 module-dirs := $(addprefix _module_,$(KBUILD_EXTMOD))
-.PHONY: $(module-dirs) modules
+PHONY += $(module-dirs) modules
 $(module-dirs): crmodverdir $(objtree)/Module.symvers
 	$(Q)$(MAKE) $(build)=$(patsubst _module_%,%,$@)
 
@@ -1114,11 +1114,11 @@ modules: $(module-dirs)
 	@echo '  Building modules, stage 2.';
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
-.PHONY: modules_install
+PHONY += modules_install
 modules_install: _emodinst_ _emodinst_post
 
-install-dir := $(if $(INSTALL_MOD_DIR),$(INSTALL_MOD_DIR),extra)	
-.PHONY: _emodinst_
+install-dir := $(if $(INSTALL_MOD_DIR),$(INSTALL_MOD_DIR),extra)
+PHONY += _emodinst_
 _emodinst_:
 	$(Q)rm -rf $(MODLIB)/$(install-dir)
 	$(Q)mkdir -p $(MODLIB)/$(install-dir)
@@ -1133,13 +1133,13 @@ quiet_cmd_depmod = DEPMOD  $(KERNELRELEA
 		      $(KERNELRELEASE);                       \
                    fi
 
-.PHONY: _emodinst_post
+PHONY += _emodinst_post
 _emodinst_post: _emodinst_
 	$(call cmd,depmod)
 
 clean-dirs := $(addprefix _clean_,$(KBUILD_EXTMOD))
 
-.PHONY: $(clean-dirs) clean
+PHONY += $(clean-dirs) clean
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
@@ -1161,7 +1161,7 @@ help:
 	@echo  ''
 
 # Dummies...
-.PHONY: prepare scripts
+PHONY += prepare scripts
 prepare: ;
 scripts: ;
 endif # KBUILD_EXTMOD
@@ -1274,7 +1274,7 @@ namespacecheck:
 endif #ifeq ($(config-targets),1)
 endif #ifeq ($(mixed-targets),1)
 
-.PHONY: checkstack
+PHONY += checkstack
 checkstack:
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
 	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
@@ -1357,4 +1357,10 @@ clean := -f $(if $(KBUILD_SRC),$(srctree
 
 endif	# skip-makefile
 
+PHONY += FORCE
 FORCE:
+
+
+# Declare the contents of the .PHONY variable as phony.  We keep that
+# information in a variable se we can use it in if_changed and friends.
+.PHONY: $(PHONY)
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index fbfc14a..585d334 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
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
@@ -176,7 +179,7 @@ endif
 
 archprepare: maketools
 
-.PHONY: maketools FORCE
+PHONY += maketools FORCE
 maketools: include/linux/version.h include/asm-arm/.arch FORCE
 	$(Q)$(MAKE) $(build)=arch/arm/tools include/asm-arm/mach-types.h
 
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index a174d63..ec9c400 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
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
@@ -73,7 +76,7 @@ $(obj)/bootpImage: $(obj)/bootp/bootp FO
 	$(call if_changed,objcopy)
 	@echo '  Kernel: $@ is ready'
 
-.PHONY: initrd FORCE
+PHONY += initrd FORCE
 initrd:
 	@test "$(INITRD_PHYS)" != "" || \
 	(echo This machine does not support INITRD; exit -1)
diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
index 8e8879b..c394e30 100644
--- a/arch/arm/boot/bootp/Makefile
+++ b/arch/arm/boot/bootp/Makefile
@@ -1,6 +1,9 @@
 #
 # linux/arch/arm/boot/bootp/Makefile
 #
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 
 LDFLAGS_bootp	:=-p --no-undefined -X \
 		 --defsym initrd_phys=$(INITRD_PHYS) \
@@ -21,4 +24,4 @@ $(obj)/kernel.o: arch/arm/boot/zImage FO
 
 $(obj)/initrd.o: $(INITRD) FORCE
 
-.PHONY:	$(INITRD) FORCE
+PHONY += $(INITRD) FORCE
diff --git a/arch/arm26/Makefile b/arch/arm26/Makefile
index 844a9e4..fe91eda 100644
--- a/arch/arm26/Makefile
+++ b/arch/arm26/Makefile
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
@@ -49,9 +52,9 @@ all: zImage
 
 boot := arch/arm26/boot
 
-.PHONY: maketools FORCE
+PHONY += maketools FORCE
 maketools: FORCE
-	
+
 
 # Convert bzImage to zImage
 bzImage: vmlinux
diff --git a/arch/arm26/boot/Makefile b/arch/arm26/boot/Makefile
index b5c2277..68acb7b 100644
--- a/arch/arm26/boot/Makefile
+++ b/arch/arm26/boot/Makefile
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
@@ -60,7 +63,7 @@ $(obj)/xipImage: vmlinux FORCE
 	@echo '  Kernel: $@ is ready'
 endif
 
-.PHONY: initrd
+PHONY += initrd
 initrd:
 	@test "$(INITRD_PHYS)" != "" || \
 	(echo This machine does not support INITRD; exit -1)
diff --git a/arch/i386/Makefile b/arch/i386/Makefile
index 36bef65..ff6973a 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -99,8 +99,8 @@ AFLAGS += $(mflags-y)
 
 boot := arch/i386/boot
 
-.PHONY: zImage bzImage compressed zlilo bzlilo \
-	zdisk bzdisk fdimage fdimage144 fdimage288 install
+PHONY += zImage bzImage compressed zlilo bzlilo \
+         zdisk bzdisk fdimage fdimage144 fdimage288 install
 
 all: bzImage
 
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index f722e1a..80ea750 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
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
@@ -62,7 +65,7 @@ drivers-$(CONFIG_OPROFILE)	+= arch/ia64/
 
 boot := arch/ia64/hp/sim/boot
 
-.PHONY: boot compressed check
+PHONY += boot compressed check
 
 all: compressed unwcheck
 
diff --git a/arch/m32r/Makefile b/arch/m32r/Makefile
index 983d438..229f66f 100644
--- a/arch/m32r/Makefile
+++ b/arch/m32r/Makefile
@@ -1,6 +1,9 @@
 #
 # m32r/Makefile
 #
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 
 LDFLAGS		:=
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
@@ -39,7 +42,7 @@ drivers-$(CONFIG_OPROFILE)	+= arch/m32r/
 
 boot := arch/m32r/boot
 
-.PHONY: zImage
+PHONY += zImage
 
 all: zImage
 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 5500ab5..5787d55 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -150,7 +150,7 @@ CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm uImage
 
-.PHONY: $(BOOT_TARGETS)
+PHONY += $(BOOT_TARGETS)
 
 boot := arch/$(ARCH)/boot
 
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
index 98e940b..9fbdf54 100644
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -82,7 +82,7 @@ drivers-$(CONFIG_OPROFILE)	+= arch/power
 
 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
 
-.PHONY: $(BOOT_TARGETS)
+PHONY += $(BOOT_TARGETS)
 
 all: uImage zImage
 
diff --git a/arch/ppc/boot/Makefile b/arch/ppc/boot/Makefile
index efd8ce5..84eec0b 100644
--- a/arch/ppc/boot/Makefile
+++ b/arch/ppc/boot/Makefile
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
@@ -25,7 +28,7 @@ subdir-				+= simple openfirmware
 
 hostprogs-y := $(addprefix utils/, addnote mknote hack-coff mkprep mkbugboot mktree)
 
-.PHONY: $(BOOT_TARGETS) $(bootdir-y)
+PHONY += $(BOOT_TARGETS) $(bootdir-y)
 
 $(BOOT_TARGETS): $(bootdir-y)
 
diff --git a/arch/ppc/boot/openfirmware/Makefile b/arch/ppc/boot/openfirmware/Makefile
index 2a411ec..66b7397 100644
--- a/arch/ppc/boot/openfirmware/Makefile
+++ b/arch/ppc/boot/openfirmware/Makefile
@@ -1,5 +1,8 @@
 # Makefile for making bootable images on various OpenFirmware machines.
 #
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 # Paul Mackerras	January 1997
 #	XCOFF bootable images for PowerMacs
 # Geert Uytterhoeven	September 1997
@@ -86,7 +89,7 @@ $(images)/zImage.chrp-rs6k $(images)/zIm
 
 # The targets used on the make command-line
 
-.PHONY: zImage zImage.initrd
+PHONY += zImage zImage.initrd
 zImage:		 $(images)/zImage.chrp		\
 		 $(images)/zImage.chrp-rs6k
 	@echo '  kernel: $@ is ready ($<)'
@@ -96,7 +99,7 @@ zImage.initrd:	 $(images)/zImage.initrd.
 
 TFTPIMAGE	:= /tftpboot/zImage
 
-.PHONY: znetboot znetboot.initrd
+PHONY += znetboot znetboot.initrd
 znetboot:	$(images)/zImage.chrp
 	cp $(images)/zImage.chrp      $(TFTPIMAGE).chrp$(END)
 	@echo '  kernel: $@ is ready ($<)'
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 08c9515..c72e17a 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -172,7 +172,7 @@ include/asm-sh/.mach: $(wildcard include
 
 archprepare: maketools include/asm-sh/.cpu include/asm-sh/.mach
 
-.PHONY: maketools FORCE
+PHONY += maketools FORCE
 maketools:  include/linux/version.h FORCE
 	$(Q)$(MAKE) $(build)=arch/sh/tools include/asm-sh/machtypes.h
 
diff --git a/arch/um/Makefile b/arch/um/Makefile
index c58b657..8d14c7a 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -1,4 +1,7 @@
-# 
+#
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
 # Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
 # Licensed under the GPL
 #
@@ -88,7 +91,7 @@ CONFIG_KERNEL_HALF_GIGS ?= 0
 
 SIZE = (($(CONFIG_NEST_LEVEL) + $(CONFIG_KERNEL_HALF_GIGS)) * 0x20000000)
 
-.PHONY: linux
+PHONY += linux
 
 all: linux
 
diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
index d7fd464..7405dfd 100644
--- a/arch/x86_64/Makefile
+++ b/arch/x86_64/Makefile
@@ -67,8 +67,8 @@ drivers-$(CONFIG_OPROFILE)		+= arch/x86_
 
 boot := arch/x86_64/boot
 
-.PHONY: bzImage bzlilo install archmrproper \
-	fdimage fdimage144 fdimage288 archclean
+PHONY += bzImage bzlilo install archmrproper \
+	 fdimage fdimage144 fdimage288 archclean
 
 #Default target when executing "make"
 all: bzImage
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index c3d2e4e..59620b1 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -116,16 +116,18 @@ make-cmd = $(subst \#,\\\#,$(subst $$,$$
 # function to only execute the passed command if necessary
 # >'< substitution is for echo to work, >$< substitution to preserve $ when reloading .cmd file
 # note: when using inline perl scripts [perl -e '...$$t=1;...'] in $(cmd_xxx) double $$ your perl vars
-# 
-if_changed = $(if $(strip $? $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
+#
+if_changed = $(if $(strip $(filter-out $(PHONY),$?)          \
+		$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
 	@set -e; \
 	$(echo-cmd) $(cmd_$(1)); \
 	echo 'cmd_$@ := $(make-cmd)' > $(@D)/.$(@F).cmd)
 
 # execute the command and also postprocess generated .d dependencies
 # file
-if_changed_dep = $(if $(strip $? $(filter-out FORCE $(wildcard $^),$^)\
-	$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),                  \
+if_changed_dep = $(if $(strip $(filter-out $(PHONY),$?)  \
+		$(filter-out FORCE $(wildcard $^),$^)    \
+	$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),     \
 	@set -e; \
 	$(echo-cmd) $(cmd_$(1)); \
 	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(@D)/.$(@F).tmp; \
@@ -135,6 +137,7 @@ if_changed_dep = $(if $(strip $? $(filte
 # Usage: $(call if_changed_rule,foo)
 # will check if $(cmd_foo) changed, or any of the prequisites changed,
 # and if so will execute $(rule_foo)
-if_changed_rule = $(if $(strip $? $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
+if_changed_rule = $(if $(strip $(filter-out $(PHONY),$?)            \
+			$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
 			@set -e; \
 			$(rule_$(1)))
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 6ac96ea..7afe3e7 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -4,7 +4,7 @@
 
 src := $(obj)
 
-.PHONY: __build
+PHONY := __build
 __build:
 
 # Read .config if it exist, otherwise ignore
@@ -308,14 +308,14 @@ targets += $(multi-used-y) $(multi-used-
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
 
@@ -330,3 +330,9 @@ cmd_files := $(wildcard $(foreach f,$(ta
 ifneq ($(cmd_files),)
   include $(cmd_files)
 endif
+
+
+# Declare the contents of the .PHONY variable as phony.  We keep that
+# information in a variable se we can use it in if_changed and friends.
+
+.PHONY: $(PHONY)
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index 8974ea5..cff3349 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
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
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 23fd1bd..2686dd5 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
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
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 563e3c5..0cfbe1c 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -32,7 +32,7 @@
 # Step 4 is solely used to allow module versioning in external modules,
 # where the CRC of each module is retrieved from the Module.symers file.
 
-.PHONY: _modpost
+PHONY := _modpost
 _modpost: __modpost
 
 include .config
@@ -60,7 +60,7 @@ quiet_cmd_modpost = MODPOST
 	$(if $(KBUILD_EXTMOD),-o $(modulesymfile)) \
 	$(filter-out FORCE,$^)
 
-.PHONY: __modpost
+PHONY += __modpost
 __modpost: $(wildcard vmlinux) $(modules:.ko=.o) FORCE
 	$(call cmd,modpost)
 
@@ -97,7 +97,7 @@ targets += $(modules)
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
 
-.PHONY: FORCE
+PHONY += FORCE
 
 FORCE:
 
@@ -112,3 +112,9 @@ cmd_files := $(wildcard $(foreach f,$(ta
 ifneq ($(cmd_files),)
   include $(cmd_files)
 endif
+
+
+# Declare the contents of the .PHONY variable as phony.  We keep that
+# information in a variable se we can use it in if_changed and friends.
+
+.PHONY: $(PHONY)
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 5280945..e6499db 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -2,7 +2,7 @@
 # Kernel configuration targets
 # These targets are used from top-level makefile
 
-.PHONY: oldconfig xconfig gconfig menuconfig config silentoldconfig update-po-config
+PHONY += oldconfig xconfig gconfig menuconfig config silentoldconfig update-po-config
 
 xconfig: $(obj)/qconf
 	$< arch/$(ARCH)/Kconfig
@@ -42,7 +42,7 @@ update-po-config: $(obj)/kxgettext
 	$(Q)rm -f arch/um/Kconfig_arch
 	$(Q)rm -f scripts/kconfig/linux_*.pot scripts/kconfig/config.pot
 
-.PHONY: randconfig allyesconfig allnoconfig allmodconfig defconfig
+PHONY += randconfig allyesconfig allnoconfig allmodconfig defconfig
 
 randconfig: $(obj)/conf
 	$< -r arch/$(ARCH)/Kconfig
diff --git a/scripts/kconfig/lxdialog/Makefile b/scripts/kconfig/lxdialog/Makefile
index bbf4887..a8b0263 100644
--- a/scripts/kconfig/lxdialog/Makefile
+++ b/scripts/kconfig/lxdialog/Makefile
@@ -7,10 +7,10 @@ check-lxdialog  := $(srctree)/$(src)/che
 # we really need to do so. (Do not call gcc as part of make mrproper)
 HOST_EXTRACFLAGS = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
 HOST_LOADLIBES   = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))
- 
-HOST_EXTRACFLAGS += -DLOCALE 
 
-.PHONY: dochecklxdialog
+HOST_EXTRACFLAGS += -DLOCALE
+
+PHONY += dochecklxdialog
 $(obj)/dochecklxdialog:
 	$(Q)$(CONFIG_SHELL) $(check-lxdialog) -check $(HOSTCC) $(HOST_LOADLIBES)
 
diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index c201ef0..d3038b7 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -32,7 +32,7 @@ MKSPEC     := $(srctree)/scripts/package
 PREV       := set -e; cd ..;
 
 # rpm-pkg
-.PHONY: rpm-pkg rpm
+PHONY += rpm-pkg rpm
 
 $(objtree)/kernel.spec: $(MKSPEC) $(srctree)/Makefile
 	$(CONFIG_SHELL) $(MKSPEC) > $@
@@ -54,10 +54,10 @@ rpm-pkg rpm: $(objtree)/kernel.spec
 clean-files := $(objtree)/kernel.spec
 
 # binrpm-pkg
-.PHONY: binrpm-pkg
+PHONY += binrpm-pkg
 $(objtree)/binkernel.spec: $(MKSPEC) $(srctree)/Makefile
 	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $@
-	
+
 binrpm-pkg: $(objtree)/binkernel.spec
 	$(MAKE) KBUILD_SRC=
 	set -e; \
@@ -72,7 +72,7 @@ clean-files += $(objtree)/binkernel.spec
 # Deb target
 # ---------------------------------------------------------------------------
 #
-.PHONY: deb-pkg
+PHONY += deb-pkg
 deb-pkg:
 	$(MAKE) KBUILD_SRC=
 	$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
@@ -82,7 +82,7 @@ clean-dirs += $(objtree)/debian/
 
 # tarball targets
 # ---------------------------------------------------------------------------
-.PHONY: tar%pkg
+PHONY += tar%pkg
 tar%pkg:
 	$(MAKE) KBUILD_SRC=
 	$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@

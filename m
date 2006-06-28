Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423151AbWF1FSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423151AbWF1FSJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423152AbWF1FSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:18:09 -0400
Received: from terminus.zytor.com ([192.83.249.54]:34025 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423151AbWF1FSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:07 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 02/31] Main Makefile changes for klibc
Date: Tue, 27 Jun 2006 22:17:02 -0700
Message-Id: <klibc.200606272217.02@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

klibc requires that the main Makefile exports RANLIB, KLIBCARCH and
KLIBCARCHDIR.  KLIBCARCH and KLIBCARCHDIR are usually the same as
ARCH, but there are a few exceptions:

powerpc: KLIBCARCH is ppc or ppc64, KLIBCARCHDIR is powerpc
s390:	 KLIBCARCH is s390 or s390x, KLIBCARCHDIR is s390
um:      KLIBCARCH is the underlying architecture,
         KLIBCARCHDIR is set by that architecture.

s390 support by Heiko Carstens <heiko.carstens@de.ibm.com>.

Additionally, add support for building single files that have to be
built with klibc rules.  Support by Sam Ravnborg <sam@ravnborg.org>.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 6af9454fcd8dc22f657feff4f31923e3aa73c475
tree abf579fa4cca8e409474e9cd2a65201f8691bbb1
parent 9371ae0abc260d3f87f243b364e86d837a3a23fd
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:21 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:21 -0700

 Makefile              |   32 +++++++++++++++++++++++---------
 arch/powerpc/Makefile |    1 +
 arch/s390/Makefile    |    4 ++++
 arch/um/Makefile      |    2 ++
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index e9560c6..6a4c559 100644
--- a/Makefile
+++ b/Makefile
@@ -176,7 +176,16 @@ ARCH		?= $(SUBARCH)
 CROSS_COMPILE	?=
 
 # Architecture as present in compile.h
-UTS_MACHINE := $(ARCH)
+UTS_MACHINE	:= $(ARCH)
+
+# Architecture used to compile user-space code
+KLIBCARCH	?= $(ARCH)
+KLIBCARCHDIR	?= $(KLIBCARCH)
+
+# klibc definitions
+export KLIBCINC := usr/include
+export KLIBCSRC := $(srctree)/usr/klibc
+export KLIBCOBJ := $(objtree)/usr/klibc
 
 KCONFIG_CONFIG	?= .config
 
@@ -278,6 +287,7 @@ LD		= $(CROSS_COMPILE)ld
 CC		= $(CROSS_COMPILE)gcc
 CPP		= $(CC) -E
 AR		= $(CROSS_COMPILE)ar
+RANLIB		= $(CROSS_COMPILE)ranlib
 NM		= $(CROSS_COMPILE)nm
 STRIP		= $(CROSS_COMPILE)strip
 OBJCOPY		= $(CROSS_COMPILE)objcopy
@@ -318,6 +328,7 @@ export VERSION PATCHLEVEL SUBLEVEL KERNE
 export ARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE
 export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
+export RANLIB KLIBCARCH KLIBCARCHDIR
 
 export CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
@@ -1303,41 +1314,44 @@ # Single targets are compatible with:
 # - build whith mixed source and output
 # - build with separate output dir 'make O=...'
 # - external modules
+# - klibc library and klibc programs (everything under usr/)
 #
 #  target-dir => where to store outputfile
 #  build-dir  => directory in kernel source tree to use
 
 ifeq ($(KBUILD_EXTMOD),)
+        singlebld  = $(if $(filter usr/%,$(dir $@)),$(klibc),$(build))
         build-dir  = $(patsubst %/,%,$(dir $@))
         target-dir = $(dir $@)
 else
+        singlebld  = $(build)
         zap-slash=$(filter-out .,$(patsubst %/,%,$(dir $@)))
         build-dir  = $(KBUILD_EXTMOD)$(if $(zap-slash),/$(zap-slash))
         target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
 endif
 
 %.s: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+	$(Q)$(MAKE) $(singlebld)=$(build-dir) $(target-dir)$(notdir $@)
 %.i: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+	$(Q)$(MAKE) $(singlebld)=$(build-dir) $(target-dir)$(notdir $@)
 %.o: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+	$(Q)$(MAKE) $(singlebld)=$(build-dir) $(target-dir)$(notdir $@)
 %.lst: %.c prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+	$(Q)$(MAKE) $(singlebld)=$(build-dir) $(target-dir)$(notdir $@)
 %.s: %.S prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+	$(Q)$(MAKE) $(singlebld)=$(build-dir) $(target-dir)$(notdir $@)
 %.o: %.S prepare scripts FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+	$(Q)$(MAKE) $(singlebld)=$(build-dir) $(target-dir)$(notdir $@)
 %.symtypes: %.c prepare scripts FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 
 # Modules
 / %/: prepare scripts FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
-	$(build)=$(build-dir)
+	$(singlebld)=$(build-dir)
 %.ko: prepare scripts FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
-	$(build)=$(build-dir) $(@:.ko=.o)
+	$(singlebld)=$(build-dir) $(@:.ko=.o)
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
 
 # FIXME Should go into a make.lib or something 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 01667d1..db9e79c 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -51,6 +51,7 @@ SZ	:= 32
 endif
 
 UTS_MACHINE := $(OLDARCH)
+KLIBCARCH   := $(OLDARCH)
 
 ifeq ($(HAS_BIARCH),y)
 override AS	+= -a$(SZ)
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index b3791fb..30832b3 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -20,6 +20,7 @@ AFLAGS		+= -m31
 UTS_MACHINE	:= s390
 STACK_SIZE	:= 8192
 CHECKFLAGS	+= -D__s390__
+KLIBCARCH	:= s390
 else
 LDFLAGS		:= -m elf64_s390
 MODFLAGS	+= -fpic -D__PIC__
@@ -28,8 +29,11 @@ AFLAGS		+= -m64
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= 16384
 CHECKFLAGS	+= -D__s390__ -D__s390x__
+KLIBCARCH	:= s390x
 endif
 
+KLIBCARCHDIR	:= s390
+
 cflags-$(CONFIG_MARCH_G5)   += $(call cc-option,-march=g5)
 cflags-$(CONFIG_MARCH_Z900) += $(call cc-option,-march=z900)
 cflags-$(CONFIG_MARCH_Z990) += $(call cc-option,-march=z990)
diff --git a/arch/um/Makefile b/arch/um/Makefile
index f6ad832..f8e96f2 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -50,6 +50,8 @@ ARCH_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)
 endif
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
+KLIBCARCH	:= $(SUBARCH)
+
 # -Dvmap=kernel_vmap prevents anything from referencing the libpcap.o symbol so
 # named - it's a common symbol in libpcap, so we get a binary which crashes.
 #

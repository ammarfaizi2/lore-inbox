Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVAMXSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVAMXSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVAMWMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:12:25 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:40453 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261739AbVAMV62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:58:28 -0500
Subject: [patch 01/11] uml: Makefile simplification and correction.
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it,
       chrisw@osdl.org
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 22:00:49 +0100
Message-Id: <20050113210049.3087FAB25@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Cc: Chris Wright <chrisw@osdl.org>, Jeff Dike <jdike@addtoit.com>

Cleanup: simplify a lot of strange constructs and whatever present in
arch/um/Makefile.

Also, get rid of ridondant cleaning code introduced in
"uml-fix-make-clean.patch" from 2.6.10-mm3 - when it was written it made
sense, but I fixed most problems it addressed in a more elegant way.

Also about that, don't remove $(ARCH_SYMLINKS) in make clean, but rather in
make mrproper as we already do, like for include/asm-um and other symlinks.

Finally, remove one wrong thing (almost a bug) introduced in that - the usage
of the clean-dirs construct:

clean-dirs := sys-$(SUBARCH)

which is intended to delete one whole folder, rather than to descend to clean
it, when used in normal Makefiles (not in the arch Makefile where is used,
with no effect). It's also not needed because that folder is cleaned because
is listed in either $(core-y) or $(libs-y).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig           |   10 ++
 linux-2.6.11-paolo/arch/um/Makefile          |   97 ++++++++++-----------------
 linux-2.6.11-paolo/arch/um/Makefile-os-Linux |    4 -
 linux-2.6.11-paolo/arch/um/Makefile-skas     |    5 -
 linux-2.6.11-paolo/arch/um/Makefile-tt       |    1 
 5 files changed, 52 insertions(+), 65 deletions(-)

diff -puN arch/um/Makefile~uml-Makefile-simplify arch/um/Makefile
--- linux-2.6.11/arch/um/Makefile~uml-Makefile-simplify	2005-01-13 02:38:29.011915568 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile	2005-01-13 02:55:25.377404528 +0100
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-ARCH_DIR = arch/um
+ARCH_DIR := arch/um
 OS := $(shell uname -s)
 # We require bash because the vmlinux link and loader script cpp use bash
 # features.
@@ -12,34 +12,38 @@ SHELL := /bin/bash
 filechk_gen_header = $<
 
 core-y			+= $(ARCH_DIR)/kernel/		\
-			   $(ARCH_DIR)/drivers/
-
-clean-dirs := sys-$(SUBARCH)
+			   $(ARCH_DIR)/drivers/		\
+			   $(ARCH_DIR)/os-$(OS)/
 
 # Have to precede the include because the included Makefiles reference them.
-SYMLINK_HEADERS = archparam.h system.h sigcontext.h processor.h ptrace.h \
+SYMLINK_HEADERS := archparam.h system.h sigcontext.h processor.h ptrace.h \
 	arch-signal.h module.h vm-flags.h
 SYMLINK_HEADERS := $(foreach header,$(SYMLINK_HEADERS),include/asm-um/$(header))
 
-CLEAN_FILES += $(ARCH_SYMLINKS)
-
+# The "os" symlink is only used by arch/um/include/os.h, which includes
+# ../os/include/file.h
 ARCH_SYMLINKS = include/asm-um/arch $(ARCH_DIR)/include/sysdep $(ARCH_DIR)/os \
 	$(SYMLINK_HEADERS) $(ARCH_DIR)/include/uml-config.h
 
 GEN_HEADERS += $(ARCH_DIR)/include/task.h $(ARCH_DIR)/include/kern_constants.h
 
-MAKEFILE-$(CONFIG_MODE_TT) += Makefile-tt
-MAKEFILE-$(CONFIG_MODE_SKAS) += Makefile-skas
+um-modes-$(CONFIG_MODE_TT) += tt
+um-modes-$(CONFIG_MODE_SKAS) += skas
+
+MODE_INCLUDE	+= $(foreach mode,$(um-modes-y),\
+		   -I$(srctree)/$(ARCH_DIR)/kernel/$(mode)/include)
 
-ifneq ($(MAKEFILE-y),)
-  include $(addprefix $(srctree)/$(ARCH_DIR)/,$(MAKEFILE-y))
+MAKEFILES-INCL	+= $(foreach mode,$(um-modes-y),\
+		   $(srctree)/$(ARCH_DIR)/Makefile-$(mode))
+
+ifneq ($(MAKEFILE-INCL),)
+  include $(MAKEFILE-INCL)
 endif
 
 ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
 include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
-include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
 core-y += $(SUBARCH_CORE)
 libs-y += $(SUBARCH_LIBS)
@@ -50,12 +54,16 @@ libs-y += $(SUBARCH_LIBS)
 # errnos.
 
 CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\" \
-	-D_LARGEFILE64_SOURCE $(ARCH_INCLUDE) -Derrno=kernel_errno \
-	-Dsigprocmask=kernel_sigprocmask $(MODE_INCLUDE)
+	$(ARCH_INCLUDE) $(MODE_INCLUDE)
 
+USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
+USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
+	$(MODE_INCLUDE)
+CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask
 CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
-LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
+#This will adjust *FLAGS accordingly to the platform.
+include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
 # These are needed for clean and mrproper, since in that case .config is not
 # included; the values here are meaningless
@@ -85,34 +93,16 @@ endef
 
 $(shell cd $(ARCH_DIR) && ln -sf Kconfig_$(SUBARCH) Kconfig_arch)
 
-CLEAN_FILES += $(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h \
-	$(TOPDIR)/$(ARCH_DIR)/os
-
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
 	$(ARCH_DIR)/kernel/vmlinux.lds.S
 
-# These aren't in Makefile-tt because they are needed in the !CONFIG_MODE_TT +
-# CONFIG_MODE_SKAS + CONFIG_STATIC_LINK case.
-
-LINK_TT = -static
-LD_SCRIPT_TT := uml.lds.S
+LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
+LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
 
-ifeq ($(CONFIG_STATIC_LINK),y)
-  LINK-y += $(LINK_TT)
-  LD_SCRIPT-y := $(LD_SCRIPT_TT)
-else
-ifeq ($(CONFIG_MODE_TT),y)
-  LINK-y += $(LINK_TT)
-  LD_SCRIPT-y := $(LD_SCRIPT_TT)
-else
-ifeq ($(CONFIG_MODE_SKAS),y)
-  LINK-y += $(LINK_SKAS)
-  LD_SCRIPT-y := $(LD_SCRIPT_SKAS)
-endif
-endif
-endif
+LD_SCRIPT-$(CONFIG_LD_SCRIPT_STATIC) := uml.lds.S
+LD_SCRIPT-$(CONFIG_LD_SCRIPT_DYN) := dyn.lds.S
 
-CPP_MODE_TT := $(shell [ "$(CONFIG_MODE_TT)" = "y" ] && echo -DMODE_TT)
+CPP_MODE-$(CONFIG_MODE_TT) := -DMODE_TT
 CONFIG_KERNEL_STACK_ORDER ?= 2
 STACK_SIZE := $(shell echo $$[ 4096 * (1 << $(CONFIG_KERNEL_STACK_ORDER)) ] )
 
@@ -122,9 +112,12 @@ endif
 
 CPPFLAGS_vmlinux.lds = $(shell echo -U$(SUBARCH) \
 	-DSTART=$(START) -DELF_ARCH=$(ELF_ARCH) \
-	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE_TT) \
+	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE-y) \
 	-DKERNEL_STACK_SIZE=$(STACK_SIZE))
 
+#The wrappers will select whether using "malloc" or the kernel allocator.
+LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
+
 CFLAGS_vmlinux = $(LINK-y) $(LINK_WRAPS)
 define cmd_vmlinux__
 	$(CC) $(CFLAGS_vmlinux) -o $@ \
@@ -135,39 +128,27 @@ define cmd_vmlinux__
 	FORCE ,$^) ; rm -f linux
 endef
 
-USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
-USER_CFLAGS := $(patsubst -Derrno=kernel_errno,,$(USER_CFLAGS))
-USER_CFLAGS := $(patsubst -Dsigprocmask=kernel_sigprocmask,,$(USER_CFLAGS))
-USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
-	$(MODE_INCLUDE)
-USER_CFLAGS += $(ARCH_USER_CFLAGS)
-
-# To get a definition of F_SETSIG
-USER_CFLAGS += -D_GNU_SOURCE
-
 #When cleaning we don't include .config, so we don't include
 #TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/include/uml-config.h \
-	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h \
-	$(ARCH_DIR)/util/mk_constants $(ARCH_DIR)/util/mk_task
+	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
 	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os
 
-archmrproper:
-	@:
-
 archclean:
 	$(Q)$(MAKE) $(clean)=$(ARCH_DIR)/util
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 
 #We need to re-preprocess this when the symlink dest changes.
-#So we touch it.
+#So we touch it when needed.
 $(ARCH_DIR)/kernel/vmlinux.lds.S: FORCE
-	@echo '  SYMLINK $@'
-	$(Q)ln -sf $(LD_SCRIPT-y) $@
-	$(Q)touch $@
+	$(Q)if [ "$(shell readlink $@)" != "$(LD_SCRIPT-y)" ]; then \
+		echo '  SYMLINK $@'; \
+		ln -sf $(LD_SCRIPT-y) $@; \
+		touch $@; \
+	fi;
 
 $(SYMLINK_HEADERS):
 	@echo '  SYMLINK $@'
diff -puN arch/um/Kconfig~uml-Makefile-simplify arch/um/Kconfig
--- linux-2.6.11/arch/um/Kconfig~uml-Makefile-simplify	2005-01-13 02:38:29.012915416 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig	2005-01-13 02:38:29.049909792 +0100
@@ -70,6 +70,16 @@ config MODE_SKAS
 
 source "arch/um/Kconfig_arch"
 
+config LD_SCRIPT_STATIC
+	bool
+	default y
+	depends on MODE_TT || STATIC_LINK
+
+config LD_SCRIPT_DYN
+	bool
+	default y
+	depends on !LD_SCRIPT_STATIC
+
 config NET
 	bool "Networking support"
 	help
diff -puN arch/um/Makefile-os-Linux~uml-Makefile-simplify arch/um/Makefile-os-Linux
--- linux-2.6.11/arch/um/Makefile-os-Linux~uml-Makefile-simplify	2005-01-13 02:38:29.014915112 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile-os-Linux	2005-01-13 02:38:29.049909792 +0100
@@ -3,4 +3,6 @@
 # Licensed under the GPL
 #
 
-core-y		+= $(ARCH_DIR)/os-$(OS)/
+# To get a definition of F_SETSIG
+USER_CFLAGS += -D_GNU_SOURCE -D_LARGEFILE64_SOURCE
+CFLAGS += -D_LARGEFILE64_SOURCE
diff -puN arch/um/Makefile-tt~uml-Makefile-simplify arch/um/Makefile-tt
--- linux-2.6.11/arch/um/Makefile-tt~uml-Makefile-simplify	2005-01-13 02:38:29.015914960 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile-tt	2005-01-13 02:38:29.049909792 +0100
@@ -3,4 +3,3 @@
 # Licensed under the GPL
 #
 
-MODE_INCLUDE += -I$(srctree)/$(ARCH_DIR)/kernel/tt/include
diff -puN arch/um/Makefile-skas~uml-Makefile-simplify arch/um/Makefile-skas
--- linux-2.6.11/arch/um/Makefile-skas~uml-Makefile-simplify	2005-01-13 02:38:29.019914352 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile-skas	2005-01-13 02:38:29.049909792 +0100
@@ -9,9 +9,4 @@ CFLAGS-$(CONFIG_GCOV) += -fprofile-arcs 
 CFLAGS-$(CONFIG_GPROF) += $(PROFILE)
 LINK-$(CONFIG_GPROF) += $(PROFILE)
 
-MODE_INCLUDE += -I$(srctree)/$(ARCH_DIR)/kernel/skas/include
-
-LINK_SKAS = -Wl,-rpath,/lib 
-LD_SCRIPT_SKAS = dyn.lds.S
-
 GEN_HEADERS += $(ARCH_DIR)/include/skas_ptregs.h
_

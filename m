Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVBMONb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVBMONb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 09:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVBMOMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 09:12:50 -0500
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:20141 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261213AbVBMOMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 09:12:31 -0500
Date: Sun, 13 Feb 2005 15:19:11 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH] uml: support a separate build tree; support USER_OBJS dependencies  
From: "Vadim Abrossimov" <vadim_abrossimov@yahoo.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opsl43d9yilfdzum@localhost.localdomain>
User-Agent: Opera M2/7.54 (Linux, build 751)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. To support a separate build tree for the um/i386 architecture
the following changes have been done:
- fix makefiles to generate new files and to create symlinks in the  
'<objtree>' only
- in particular, to solve the issue of 'arch/um/include/sysdep-<subarch>',
the same technique as for 'include/asm' has been used: create a symlink  
from
'<objtree>/arch/um/include2/sysdep' to  
'<srctree>/arch/um/include/sysdep-<subarch>'
- fix '#include's in the header files that the assumption of included  
files located in
the same directory has been broken.

The patch applies (and has been tested) on the i386 sub-architecture only.
Other supported sub-architectures should still work as previously building  
in
the source tree only.

2. In order to support dependencies for 'USER_OBJS' object files use the  
generic Kbuild
infrastructure overwriting 'c_flags' as needed.

These two changes have been combined in one patch because some makefiles  
are impacted by both.

Signed-off-by: <Vadim_Abrossimov@yahoo.com>
---

  arch/um/Makefile                         |   37  
+++++++++++++++++++++++--------
  arch/um/drivers/Makefile                 |    4 +--
  arch/um/include/sysdep-i386/sigcontext.h |    2 -
  arch/um/kernel/Makefile                  |    7 ++---
  arch/um/kernel/skas/Makefile             |    3 --
  arch/um/kernel/tt/Makefile               |    6 +----
  arch/um/kernel/tt/ptproxy/Makefile       |    3 --
  arch/um/os-Linux/Makefile                |    3 --
  arch/um/os-Linux/drivers/Makefile        |    3 --
  arch/um/os-Linux/sys-i386/Makefile       |    4 +--
  arch/um/sys-i386/Makefile                |    5 +---
  include/asm-um/archparam-i386.h          |    2 -
  12 files changed, 45 insertions(+), 34 deletions(-)

===== arch/um/Makefile 1.54 vs edited =====
--- 1.54/arch/um/Makefile	2005-02-11 07:57:42 +01:00
+++ edited/arch/um/Makefile	2005-02-13 11:57:01 +01:00
@@ -43,7 +43,9 @@ ifneq ($(MAKEFILES-INCL),)
    include $(MAKEFILES-INCL)
  endif

-ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
+ARCH_INCLUDE	:= -I$(ARCH_DIR)/include \
+                   $(if $(KBUILD_SRC), -I$(objtree)/$(ARCH_DIR)/include2)
+
  SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)

  include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
@@ -60,8 +62,12 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
  	$(ARCH_INCLUDE) $(MODE_INCLUDE)

  USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
-USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
-	$(MODE_INCLUDE) $(ARCH_USER_CFLAGS)
+USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS))
+# If building the kernel in a separate tree we need to add this path  
manually.
+# Note, that for CFLAGS it's done in the generic 'scripts/Makefile.lib'
+USER_CFLAGS += $(if $(KBUILD_SRC), -I$(srctree)/$(ARCH_DIR)/include)
+USER_CFLAGS += $(ARCH_INCLUDE) $(MODE_INCLUDE) $(ARCH_USER_CFLAGS)
+
  CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask
  CFLAGS += $(call cc-option,-fno-unit-at-a-time,)

@@ -94,7 +100,7 @@ define archhelp
    echo '		   find in the kernel root.'
  endef

-$(shell cd $(ARCH_DIR) && ln -sf Kconfig_$(SUBARCH) Kconfig_arch)
+$(shell cd $(ARCH_DIR) && ln -sf $(if $(KBUILD_SRC),  
$(srctree)/$(ARCH_DIR)/)Kconfig_$(SUBARCH) Kconfig_arch)

  prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
  	$(ARCH_DIR)/kernel/vmlinux.lds.S
@@ -138,6 +144,7 @@ CLEAN_FILES += linux x.i gmon.out $(ARCH

  MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
  	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os \
+	$(ARCH_DIR)/include2/sysdep \
  	$(ARCH_DIR)/Kconfig_arch

  archclean:
@@ -150,26 +157,38 @@ archclean:
  $(ARCH_DIR)/kernel/vmlinux.lds.S: FORCE
  	$(Q)if [ "$(shell readlink $@)" != "$(LD_SCRIPT-y)" ]; then \
  		echo '  SYMLINK $@'; \
-		ln -sf $(LD_SCRIPT-y) $@; \
+		ln -sf $(if $(KBUILD_SRC),  
$(srctree)/$(ARCH_DIR)/kernel/)$(LD_SCRIPT-y) $@; \
  		touch $@; \
  	fi;

  $(SYMLINK_HEADERS):
  	@echo '  SYMLINK $@'
-	$(Q)cd $(TOPDIR)/$(dir $@) ; \
+ifneq ($(KBUILD_SRC),)
+	$(Q)mkdir -p $(dir $@)
+	$(Q)cd $(dir $@) ; \
+	ln -sf $(srctree)/$(basename $@)-$(SUBARCH)$(suffix $@) $(notdir $@)
+else
+	$(Q)cd $(srctree)/$(dir $@) ; \
  	ln -sf $(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $(notdir $@)
+endif

  include/asm-um/arch:
  	@echo '  SYMLINK $@'
-	$(Q)cd $(TOPDIR)/include/asm-um && ln -sf ../asm-$(SUBARCH) arch
+	$(if $(KBUILD_SRC), $(Q)mkdir -p include/asm-um)
+	$(Q)cd include/asm-um && ln -fsn $(if $(KBUILD_SRC), $(srctree)/include,  
..)/asm-$(SUBARCH) arch

  $(ARCH_DIR)/include/sysdep:
  	@echo '  SYMLINK $@'
-	$(Q)cd $(ARCH_DIR)/include && ln -sf sysdep-$(SUBARCH) sysdep
+ifneq ($(KBUILD_SRC),)
+	$(Q)mkdir -p $(ARCH_DIR)/include2
+	$(Q)cd $(ARCH_DIR)/include2 && ln -fsn  
$(srctree)/$(ARCH_DIR)/include/sysdep-$(SUBARCH) sysdep
+endif
+	$(Q)cd $(ARCH_DIR)/include && ln -fsn sysdep-$(SUBARCH) sysdep

  $(ARCH_DIR)/os:
  	@echo '  SYMLINK $@'
-	$(Q)cd $(ARCH_DIR) && ln -sf os-$(OS) os
+	$(if $(KBUILD_SRC), $(Q)mkdir -p $(ARCH_DIR))
+	$(Q)cd $(ARCH_DIR) && ln -fsn $(if $(KBUILD_SRC),  
$(srctree)/$(ARCH_DIR)/)os-$(OS) os

  # Generated files
  define filechk_umlconfig
===== arch/um/drivers/Makefile 1.15 vs edited =====
--- 1.15/arch/um/drivers/Makefile	2005-01-12 01:42:51 +01:00
+++ edited/arch/um/drivers/Makefile	2005-02-13 11:57:01 +01:00
@@ -49,5 +49,5 @@ USER_OBJS := $(filter %_user.o,$(obj-y)
  	null.o pty.o tty.o xterm.o
  USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)
+
===== arch/um/include/sysdep-i386/sigcontext.h 1.4 vs edited =====
--- 1.4/arch/um/include/sysdep-i386/sigcontext.h	2004-08-24 11:08:18 +02:00
+++ edited/arch/um/include/sysdep-i386/sigcontext.h	2005-02-13 11:57:01  
+01:00
@@ -6,7 +6,7 @@
  #ifndef __SYS_SIGCONTEXT_I386_H
  #define __SYS_SIGCONTEXT_I386_H

-#include "sc.h"
+#include <sysdep/sc.h>

  #define IP_RESTART_SYSCALL(ip) ((ip) -= 2)

===== arch/um/kernel/Makefile 1.29 vs edited =====
--- 1.29/arch/um/kernel/Makefile	2005-01-04 00:49:33 +01:00
+++ edited/arch/um/kernel/Makefile	2005-02-13 11:57:01 +01:00
@@ -30,14 +30,13 @@ USER_OBJS := $(foreach file,$(USER_OBJS)

  CFLAGS_frame.o := -fno-omit-frame-pointer

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(USER_CFLAGS) $(CFLAGS_$(notdir $@)) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS)  
$(CFLAGS_$(notdir $@))

-QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ;  
$$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/;  
print $$_ }'
+QUOTE = 'my $$config=`cat $(objtree)/.config`; $$config =~ s/"/\\"/g ;  
$$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/;  
print $$_ }'

  quiet_cmd_quote = QUOTE   $@
  cmd_quote = $(PERL) -e $(QUOTE) < $< > $@

  targets += config.c
-$(obj)/config.c : $(src)/config.c.in $(TOPDIR)/.config FORCE
+$(obj)/config.c : $(src)/config.c.in $(objtree)/.config FORCE
  	$(call if_changed,quote)
===== arch/um/kernel/skas/Makefile 1.14 vs edited =====
--- 1.14/arch/um/kernel/skas/Makefile	2005-02-08 03:25:10 +01:00
+++ edited/arch/um/kernel/skas/Makefile	2005-02-13 11:57:01 +01:00
@@ -9,7 +9,6 @@ obj-y := exec_kern.o mem.o mem_user.o mm
  USER_OBJS = $(filter %_user.o,$(obj-y)) process.o time.o
  USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)

  subdir- := util
===== arch/um/kernel/tt/Makefile 1.17 vs edited =====
--- 1.17/arch/um/kernel/tt/Makefile	2005-01-12 01:42:50 +01:00
+++ edited/arch/um/kernel/tt/Makefile	2005-02-13 11:57:01 +01:00
@@ -18,11 +18,9 @@ USER_OBJS := $(foreach file,$(USER_OBJS)
  UNMAP_CFLAGS := $(patsubst -pg -DPROFILING,,$(USER_CFLAGS))
  UNMAP_CFLAGS := $(patsubst -fprofile-arcs  
-ftest-coverage,,$(UNMAP_CFLAGS))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)

-$(obj)/unmap.o: $(src)/unmap.c
-	$(CC) $(UNMAP_CFLAGS) -c -o $@ $<
+$(obj)/unmap.o: c_flags = -Wp,-MD,$(depfile) $(UNMAP_CFLAGS)

  LIBC_DIR ?= /usr/lib

===== arch/um/kernel/tt/ptproxy/Makefile 1.9 vs edited =====
--- 1.9/arch/um/kernel/tt/ptproxy/Makefile	2004-08-24 11:08:18 +02:00
+++ edited/arch/um/kernel/tt/ptproxy/Makefile	2005-02-13 11:57:01 +01:00
@@ -7,5 +7,4 @@ obj-y = proxy.o ptrace.o sysdep.o wait.o

  USER_OBJS := $(foreach file,$(obj-y),$(src)/$(file))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)
===== arch/um/os-Linux/Makefile 1.12 vs edited =====
--- 1.12/arch/um/os-Linux/Makefile	2005-01-12 01:42:53 +01:00
+++ edited/arch/um/os-Linux/Makefile	2005-02-13 11:57:01 +01:00
@@ -9,7 +9,6 @@ obj-y = elf_aux.o file.o process.o signa
  USER_OBJS := elf_aux.o file.o process.o signal.o time.o tty.o
  USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)

  CFLAGS_user_syms.o += -DSUBARCH_$(SUBARCH)
===== arch/um/os-Linux/drivers/Makefile 1.5 vs edited =====
--- 1.5/arch/um/os-Linux/drivers/Makefile	2002-12-17 08:54:52 +01:00
+++ edited/arch/um/os-Linux/drivers/Makefile	2005-02-13 11:57:01 +01:00
@@ -15,5 +15,4 @@ USER_SINGLE_OBJS = $(foreach f,$(patsubs
  USER_OBJS = $(filter %_user.o,$(obj-y) $(USER_SINGLE_OBJS))
  USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)
===== arch/um/os-Linux/sys-i386/Makefile 1.1 vs edited =====
--- 1.1/arch/um/os-Linux/sys-i386/Makefile	2005-01-12 01:42:50 +01:00
+++ edited/arch/um/os-Linux/sys-i386/Makefile	2005-02-13 11:57:01 +01:00
@@ -7,5 +7,5 @@ obj-$(CONFIG_MODE_SKAS) = registers.o

  USER_OBJS := $(foreach file,$(obj-y),$(obj)/$(file))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)
+
===== arch/um/sys-i386/Makefile 1.21 vs edited =====
--- 1.21/arch/um/sys-i386/Makefile	2005-01-12 01:42:52 +01:00
+++ edited/arch/um/sys-i386/Makefile	2005-02-13 11:57:01 +01:00
@@ -22,11 +22,10 @@ module.c-dir = kernel

  define make_link
  	-rm -f $1
-	ln -sf $(TOPDIR)/arch/i386/$($(notdir $1)-dir)/$(notdir $1) $1
+	ln -sf $(srctree)/arch/i386/$($(notdir $1)-dir)/$(notdir $1) $1
  endef

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)

  $(SYMLINKS):
  	$(call make_link,$@)
===== include/asm-um/archparam-i386.h 1.9 vs edited =====
--- 1.9/include/asm-um/archparam-i386.h	2005-01-12 01:42:52 +01:00
+++ edited/include/asm-um/archparam-i386.h	2005-02-13 11:57:01 +01:00
@@ -8,7 +8,7 @@

  /********* Bits for asm-um/elf.h ************/

-#include "user.h"
+#include <asm/user.h>

  extern char * elf_aux_platform;
  #define ELF_PLATFORM (elf_aux_platform)

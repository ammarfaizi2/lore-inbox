Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269419AbUJLAcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269419AbUJLAcU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269418AbUJLAZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:25:19 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:24963
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269396AbUJLATL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:19:11 -0400
Subject: [patch 05/10] uml: make -j fix
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:17:54 +0200
Message-Id: <20041012001754.7252A8691@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Makes the UML build system work well even under parallel make (tested, so far,
even with -j50). Please notice that it must be updated for every makefile
change. Or better, every makefile change must use correct dependencies (and
they are easy to miss).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile                  |   64 +++++++-----
 linux-2.6.9-current-paolo/arch/um/Makefile-i386             |   27 ++---
 linux-2.6.9-current-paolo/arch/um/Makefile-skas             |    7 -
 linux-2.6.9-current-paolo/arch/um/Makefile-tt               |    3 
 linux-2.6.9-current-paolo/arch/um/kernel/Makefile           |   20 ---
 linux-2.6.9-current-paolo/arch/um/kernel/skas/Makefile      |   16 ---
 linux-2.6.9-current-paolo/arch/um/kernel/skas/util/Makefile |   11 --
 linux-2.6.9-current-paolo/arch/um/sys-i386/Makefile         |    5 
 linux-2.6.9-current-paolo/arch/um/sys-i386/util/Makefile    |    5 
 linux-2.6.9-current/arch/um/include/Makefile                |    7 -
 10 files changed, 66 insertions(+), 99 deletions(-)

diff -puN arch/um/Makefile-i386~uml-parallel-make-fix arch/um/Makefile-i386
--- linux-2.6.9-current/arch/um/Makefile-i386~uml-parallel-make-fix	2004-10-08 18:01:52.841033976 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile-i386	2004-10-08 18:01:53.764893528 +0200
@@ -1,12 +1,12 @@
 ifeq ($(CONFIG_HOST_2G_2G), y)
-TOP_ADDR = 0x80000000
+TOP_ADDR := 0x80000000
 else
-TOP_ADDR = 0xc0000000
+TOP_ADDR := 0xc0000000
 endif
 
 ifeq ($(CONFIG_MODE_SKAS),y)
   ifneq ($(CONFIG_MODE_TT),y)
-     START = 0x8048000
+     START := 0x8048000
   endif
 endif
 
@@ -16,35 +16,30 @@ ifneq ($(CONFIG_GPROF),y)
 ARCH_CFLAGS += -DUM_FASTCALL
 endif
 
-ELF_ARCH = $(SUBARCH)
-ELF_FORMAT = elf32-$(SUBARCH)
+ELF_ARCH := $(SUBARCH)
+ELF_FORMAT := elf32-$(SUBARCH)
 
 OBJCOPYFLAGS  := -O binary -R .note -R .comment -S
 
-SYS_DIR		:= $(ARCH_DIR)/include/sysdep-i386
 SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
 
-SYS_HEADERS = $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
+SYS_HEADERS := $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
 
 prepare: $(SYS_HEADERS)
 
-filechk_$(SYS_DIR)/sc.h := $(SYS_UTIL_DIR)/mk_sc
-
 $(SYS_DIR)/sc.h: $(SYS_UTIL_DIR)/mk_sc
-	$(call filechk,$@)
-
-filechk_$(SYS_DIR)/thread.h := $(SYS_UTIL_DIR)/mk_thread
+	$(call filechk,gen_header)
 
 $(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread 
-	$(call filechk,$@)
+	$(call filechk,gen_header)
 
-$(SYS_UTIL_DIR)/mk_sc: scripts/basic/fixdep include/config/MARKER FORCE
+$(SYS_UTIL_DIR)/mk_sc: scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
 
-$(SYS_UTIL_DIR)/mk_thread: $(ARCH_SYMLINKS) $(GEN_HEADERS) FORCE
+$(SYS_UTIL_DIR)/mk_thread: scripts_basic $(ARCH_SYMLINKS) $(GEN_HEADERS) FORCE
 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
 
-$(SYS_UTIL_DIR): include/asm FORCE
+$(SYS_UTIL_DIR): scripts_basic include/asm FORCE
 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR)
 
 CLEAN_FILES += $(SYS_HEADERS)
diff -puN arch/um/Makefile~uml-parallel-make-fix arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-parallel-make-fix	2004-10-08 18:01:52.843033672 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-08 18:01:53.765893376 +0200
@@ -8,8 +8,10 @@ OS := $(shell uname -s)
 #We require it or things break.
 SHELL := /bin/bash
 
-core-y			+= $(ARCH_DIR)/kernel/		 \
-			   $(ARCH_DIR)/drivers/          \
+filechk_gen_header = $<
+
+core-y			+= $(ARCH_DIR)/kernel/		\
+			   $(ARCH_DIR)/drivers/		\
 			   $(ARCH_DIR)/sys-$(SUBARCH)/
 
 # Have to precede the include because the included Makefiles reference them.
@@ -29,11 +31,12 @@ ifneq ($(MAKEFILE-y),)
   include $(addprefix $(ARCH_DIR)/,$(MAKEFILE-y))
 endif
 
+ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
+SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
+
 include $(ARCH_DIR)/Makefile-$(SUBARCH)
 include $(ARCH_DIR)/Makefile-os-$(OS)
 
-ARCH_INCLUDE = -I$(ARCH_DIR)/include
-
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
 # in CFLAGS.  Otherwise, it would cause ld to complain about the two different
@@ -56,7 +59,7 @@ CONFIG_KERNEL_HALF_GIGS ?= 0
 SIZE = (($(CONFIG_NEST_LEVEL) + $(CONFIG_KERNEL_HALF_GIGS)) * 0x20000000)
 
 ifeq ($(CONFIG_MODE_SKAS), y)
-$(SYS_HEADERS) : $(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h
+$(SYS_HEADERS) : $(ARCH_DIR)/include/skas_ptregs.h
 endif
 
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
@@ -83,12 +86,6 @@ endif
 endif
 endif
 
-#We need to re-preprocess this when the symlink dest changes.
-#So we just touch it.
-$(ARCH_DIR)/kernel/vmlinux.lds.S:
-	ln -sf $(LD_SCRIPT-y) $@
-	touch $@
-
 CPP_MODE_TT := $(shell [ "$(CONFIG_MODE_TT)" = "y" ] && echo -DMODE_TT)
 CONFIG_KERNEL_STACK_ORDER ?= 2
 STACK_SIZE := $(shell echo $$[ 4096 * (1 << $(CONFIG_KERNEL_STACK_ORDER)) ] )
@@ -120,9 +117,10 @@ USER_CFLAGS := $(patsubst -D__KERNEL__,,
 # To get a definition of F_SETSIG
 USER_CFLAGS += -D_GNU_SOURCE
 
-CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/uml.lds \
-	$(ARCH_DIR)/dyn_link.ld.s $(ARCH_DIR)/include/uml-config.h \
-	$(GEN_HEADERS)
+#When cleaning we don't include .config, so we don't include
+#TT or skas makefiles and don't clean skas_ptregs.h.
+CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/include/uml-config.h \
+	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
 	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS))
@@ -131,42 +129,60 @@ archmrproper:
 	@:
 
 archclean:
+	$(Q)$(MAKE) $(clean)=$(ARCH_DIR)/util
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 
+#We need to re-preprocess this when the symlink dest changes.
+#So we touch it.
+$(ARCH_DIR)/kernel/vmlinux.lds.S: FORCE
+	@echo '  SYMLINK $@'
+	$(Q)ln -sf $(LD_SCRIPT-y) $@
+	$(Q)touch $@
+
 $(SYMLINK_HEADERS):
-	cd $(TOPDIR)/$(dir $@) ; \
+	@echo '  SYMLINK $@'
+	$(Q)cd $(TOPDIR)/$(dir $@) ; \
 	ln -sf $(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $(notdir $@)
 
 include/asm-um/arch:
-	cd $(TOPDIR)/include/asm-um && ln -sf ../asm-$(SUBARCH) arch
+	@echo '  SYMLINK $@'
+	$(Q)cd $(TOPDIR)/include/asm-um && ln -sf ../asm-$(SUBARCH) arch
 
 $(ARCH_DIR)/include/sysdep:
-	cd $(ARCH_DIR)/include && ln -sf sysdep-$(SUBARCH) sysdep
+	@echo '  SYMLINK $@'
+	$(Q)cd $(ARCH_DIR)/include && ln -sf sysdep-$(SUBARCH) sysdep
 
 $(ARCH_DIR)/os:
-	cd $(ARCH_DIR) && ln -sf os-$(OS) os
+	@echo '  SYMLINK $@'
+	$(Q)cd $(ARCH_DIR) && ln -sf os-$(OS) os
 
 # Generated files
 define filechk_umlconfig
 	sed 's/ CONFIG/ UML_CONFIG/'
 endef
 
-$(ARCH_DIR)/include/uml-config.h : $(TOPDIR)/include/linux/autoconf.h
+$(ARCH_DIR)/include/uml-config.h : include/linux/autoconf.h
 	$(call filechk,umlconfig)
 
-filechk_gen_header = $<
+$(ARCH_DIR)/include/task.h: $(ARCH_DIR)/util/mk_task
+	$(call filechk,gen_header)
 
-$(ARCH_DIR)/include/task.h : $(ARCH_DIR)/util/mk_task
+$(ARCH_DIR)/include/kern_constants.h: $(ARCH_DIR)/util/mk_constants
 	$(call filechk,gen_header)
 
-$(ARCH_DIR)/include/kern_constants.h : $(ARCH_DIR)/util/mk_constants
+$(ARCH_DIR)/include/skas_ptregs.h: $(ARCH_DIR)/kernel/skas/util/mk_ptregs
 	$(call filechk,gen_header)
 
-$(ARCH_DIR)/util/mk_task $(ARCH_DIR)/util/mk_constants : $(ARCH_DIR)/util \
+$(ARCH_DIR)/util/mk_task $(ARCH_DIR)/util/mk_constants: $(ARCH_DIR)/util \
 	FORCE ;
 
-$(ARCH_DIR)/util: $(SYS_DIR)/sc.h FORCE
+$(ARCH_DIR)/kernel/skas/util/mk_ptregs: $(ARCH_DIR)/kernel/skas/util FORCE ;
+
+$(ARCH_DIR)/util: scripts_basic $(SYS_DIR)/sc.h FORCE
+	$(Q)$(MAKE) $(build)=$@
+
+$(ARCH_DIR)/kernel/skas/util: scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=$@
 
 export SUBARCH USER_CFLAGS OS
diff -puN arch/um/kernel/Makefile~uml-parallel-make-fix arch/um/kernel/Makefile
--- linux-2.6.9-current/arch/um/kernel/Makefile~uml-parallel-make-fix	2004-10-08 18:01:52.844033520 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/Makefile	2004-10-08 18:01:54.103842000 +0200
@@ -4,11 +4,7 @@
 #
 
 extra-y := vmlinux.lds
-
-# Descend into ../util for make clean.  This is here because it doesn't work
-# in arch/um/Makefile.
-
-subdir- = ../util
+clean-files := vmlinux.lds.S
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
@@ -29,24 +25,16 @@ obj-$(CONFIG_MODE_SKAS) += skas/
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
 USER_OBJS := $(filter %_user.o,$(obj-y))  $(user-objs-y) config.o helper.o \
-	main.o process.o tempfile.o time.o tty_log.o umid.o user_util.o
+	main.o process.o tempfile.o time.o tty_log.o umid.o user_util.o frame.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
-CFLAGS_frame.o := $(patsubst -fomit-frame-pointer,,$(USER_CFLAGS))
-
-# This has to be separate because it needs be compiled with frame pointers
-# regardless of how the rest of the kernel is built.
-
-$(obj)/frame.o: $(src)/frame.c
-	$(CC) $(CFLAGS_$(notdir $@)) -c -o $@ $<
+CFLAGS_frame.o := -fno-omit-frame-pointer
 
 $(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+	$(CC) $(USER_CFLAGS) $(CFLAGS_$(notdir $@)) -c -o $@ $<
 
 QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
 
-$(obj)/config.o : $(obj)/config.c
-
 quiet_cmd_quote = QUOTE   $@
 cmd_quote = $(PERL) -e $(QUOTE) < $< > $@
 
diff -puN arch/um/util/Makefile~uml-parallel-make-fix arch/um/util/Makefile
diff -L arch/um/include/Makefile -puN arch/um/include/Makefile~uml-parallel-make-fix /dev/null
--- linux-2.6.9-current/arch/um/include/Makefile
+++ /dev/null	2004-06-25 17:47:25.000000000 +0200
@@ -1,7 +0,0 @@
-all : sc.h
-
-sc.h : ../util/mk_sc
-	../util/mk_sc > $@
-
-../util/mk_sc :
-	$(MAKE) -C ../util mk_sc
diff -puN arch/um/kernel/skas/Makefile~uml-parallel-make-fix arch/um/kernel/skas/Makefile
--- linux-2.6.9-current/arch/um/kernel/skas/Makefile~uml-parallel-make-fix	2004-10-08 18:01:53.208978040 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/skas/Makefile	2004-10-08 18:01:53.851880304 +0200
@@ -3,26 +3,14 @@
 # Licensed under the GPL
 #
 
-obj-y = exec_kern.o exec_user.o mem.o mem_user.o mmu.o process.o \
+obj-y := exec_kern.o exec_user.o mem.o mem_user.o mmu.o process.o \
 	process_kern.o syscall_kern.o syscall_user.o time.o tlb.o trap_user.o \
 	uaccess.o sys-$(SUBARCH)/
 
-hostprogs-y	:= util/mk_ptregs
-clean-files	:= include/skas_ptregs.h
+subdir-y := util
 
 USER_OBJS = $(filter %_user.o,$(obj-y)) process.o time.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
-$(TOPDIR)/arch/um/include/skas_ptregs.h : $(src)/util/mk_ptregs
-	@echo -n '  Generating $@'
-	@$< > $@.tmp
-	@if [ -r $@ ] && cmp -s $@ $@.tmp; then \
-		echo ' (unchanged)'; \
-		rm -f $@.tmp; \
-	else \
-		echo ' (updated)'; \
-		mv -f $@.tmp $@; \
-	fi
-
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
diff -puN arch/um/kernel/skas/util/Makefile~uml-parallel-make-fix arch/um/kernel/skas/util/Makefile
--- linux-2.6.9-current/arch/um/kernel/skas/util/Makefile~uml-parallel-make-fix	2004-10-08 18:01:53.293965120 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/skas/util/Makefile	2004-10-08 18:01:53.851880304 +0200
@@ -1,9 +1,2 @@
-all: mk_ptregs
-
-mk_ptregs : mk_ptregs.o
-	$(HOSTCC) -o mk_ptregs mk_ptregs.o
-
-mk_ptregs.o : mk_ptregs.c
-	$(HOSTCC) -c $<
-
-clean-files := mk_ptregs *.o *~
+host-progs		:= mk_ptregs
+always			:= $(host-progs)
diff -puN arch/um/sys-i386/util/Makefile~uml-parallel-make-fix arch/um/sys-i386/util/Makefile
--- linux-2.6.9-current/arch/um/sys-i386/util/Makefile~uml-parallel-make-fix	2004-10-08 18:01:53.295964816 +0200
+++ linux-2.6.9-current-paolo/arch/um/sys-i386/util/Makefile	2004-10-08 18:01:53.851880304 +0200
@@ -6,8 +6,3 @@ mk_thread-objs	:= mk_thread_kern.o mk_th
 
 HOSTCFLAGS_mk_thread_kern.o	:= $(CFLAGS) $(CPPFLAGS)
 HOSTCFLAGS_mk_thread_user.o	:= $(USER_CFLAGS)
-
-clean :
-	$(RM) -f $(build-targets)
-
-archmrproper : clean
diff -puN arch/um/Makefile-skas~uml-parallel-make-fix arch/um/Makefile-skas
--- linux-2.6.9-current/arch/um/Makefile-skas~uml-parallel-make-fix	2004-10-08 18:01:53.732898392 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile-skas	2004-10-08 18:01:53.852880152 +0200
@@ -9,12 +9,9 @@ CFLAGS-$(CONFIG_GCOV) += -fprofile-arcs 
 CFLAGS-$(CONFIG_GPROF) += $(PROFILE)
 LINK-$(CONFIG_GPROF) += $(PROFILE)
 
-MODE_INCLUDE += -I$(TOPDIR)/$(ARCH_DIR)/kernel/skas/include
+MODE_INCLUDE += -I$(srctree)/$(ARCH_DIR)/kernel/skas/include
 
 LINK_SKAS = -Wl,-rpath,/lib 
 LD_SCRIPT_SKAS = dyn.lds.S
 
-GEN_HEADERS += $(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h
-
-$(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h :
-	$(Q)$(MAKE) $(build)=$(ARCH_DIR)/kernel/skas $@
+GEN_HEADERS += $(ARCH_DIR)/include/skas_ptregs.h
diff -puN arch/um/sys-i386/Makefile~uml-parallel-make-fix arch/um/sys-i386/Makefile
--- linux-2.6.9-current/arch/um/sys-i386/Makefile~uml-parallel-make-fix	2004-10-08 18:01:53.733898240 +0200
+++ linux-2.6.9-current-paolo/arch/um/sys-i386/Makefile	2004-10-08 18:01:53.852880152 +0200
@@ -8,10 +8,13 @@ USER_OBJS := bugs.o ptrace_user.o sigcon
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 SYMLINKS = bitops.c semaphore.c highmem.c module.c
-SYMLINKS := $(foreach f,$(SYMLINKS),$(src)/$f)
 
+# this needs to be before the foreach, because clean-files does not accept
+# complete paths like $(src)/$f.
 clean-files := $(SYMLINKS)
 
+SYMLINKS := $(foreach f,$(SYMLINKS),$(src)/$f)
+
 bitops.c-dir = lib
 semaphore.c-dir = kernel
 highmem.c-dir = mm
diff -puN arch/um/Makefile-tt~uml-parallel-make-fix arch/um/Makefile-tt
--- linux-2.6.9-current/arch/um/Makefile-tt~uml-parallel-make-fix	2004-10-08 18:01:53.734898088 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile-tt	2004-10-08 18:01:53.890874376 +0200
@@ -3,5 +3,4 @@
 # Licensed under the GPL
 #
 
-MODE_INCLUDE += -I$(TOPDIR)/$(ARCH_DIR)/kernel/tt/include
-
+MODE_INCLUDE += -I$(srctree)/$(ARCH_DIR)/kernel/tt/include
_

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSJLQnw>; Sat, 12 Oct 2002 12:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbSJLQnw>; Sat, 12 Oct 2002 12:43:52 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:55702 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261290AbSJLQnr>; Sat, 12 Oct 2002 12:43:47 -0400
Date: Sat, 12 Oct 2002 11:49:35 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: linux-kernel@vger.kernel.org, <torvalds@transmeta.com>,
       <user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [PATCH] 2.5.42: UML build error
In-Reply-To: <877kgn7kmk.fsf@goat.bogus.local>
Message-ID: <Pine.LNX.4.44.0210121145510.17947-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2002, Olaf Dietsche wrote:

> When building 2.5.42 UML it fails with:
> [...]

Okay, so here's a patch which fixes the UML build for me (i386) -
generally, UML could use some more kbuild work, but I'll leave that for
post-freeze ;)

--Kai


Pull from http://linux-isdn.bkbits.net/linux-2.5.make

(Merging changesets omitted for clarity)

-----------------------------------------------------------------------------
ChangeSet@1.784, 2002-10-12 11:47:37-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Fix UML build
  
  Not perfectly clean yet, but uses the standard way to descend into subdirs
  and gives me working vmlinux and linux targets without spurious rebuilds.

 ----------------------------------------------------------------------------
 Makefile               |   33 ++++++++++++++++++++-------------
 Makefile-i386          |   35 ++++++++++++++++-------------------
 sys-i386/util/Makefile |   14 ++++++++------
 util/Makefile          |   18 +++++++++---------
 4 files changed, 53 insertions(+), 47 deletions(-)





=============================================================================
unified diffs follow for reference
=============================================================================

-----------------------------------------------------------------------------
ChangeSet@1.784, 2002-10-12 11:47:37-05:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: Fix UML build
  
  Not perfectly clean yet, but uses the standard way to descend into subdirs
  and gives me working vmlinux and linux targets without spurious rebuilds.

  ---------------------------------------------------------------------------

diff -Nru a/arch/um/Makefile b/arch/um/Makefile
--- a/arch/um/Makefile	Sat Oct 12 11:48:06 2002
+++ b/arch/um/Makefile	Sat Oct 12 11:48:06 2002
@@ -51,14 +51,6 @@
 
 SIZE = (($(CONFIG_NEST_LEVEL) + $(CONFIG_KERNEL_HALF_GIGS)) * 0x20000000)
 
-$(ARCH_DIR)/uml.lds.s : $(ARCH_DIR)/uml.lds.S
-	$(call if_changed_dep,as_s_S)
-
-AFLAGS_uml.lds.o = -U$(SUBARCH) -DSTART=$$(($(TOP_ADDR) - $(SIZE))) \
-	-DELF_ARCH=$(ELF_ARCH) -DELF_FORMAT=\"$(ELF_FORMAT)\" -P -C -Uum
-
-LDFLAGS_vmlinux = -r $(ARCH_DIR)/main.o
-
 SYMLINK_HEADERS = include/asm-um/archparam.h include/asm-um/system.h \
 	include/asm-um/sigcontext.h include/asm-um/processor.h \
 	include/asm-um/ptrace.h include/asm-um/arch-signal.h
@@ -71,11 +63,25 @@
 $(ARCH_DIR)/vmlinux.lds.S :
 	touch $@
 
-linux: scripts $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
-	arch/um/uml.lds.s $(ARCH_DIR)/main.o vmlinux
+prepare: $(ARCH_SYMLINKS) $(GEN_HEADERS)
+
+
+LDFLAGS_vmlinux = -r $(ARCH_DIR)/main.o
+
+vmlinux: $(ARCH_DIR)/main.o 
+
+
+$(ARCH_DIR)/uml.lds.s : $(ARCH_DIR)/uml.lds.S
+	$(call if_changed_dep,as_s_S)
+
+AFLAGS_uml.lds.o = -U$(SUBARCH) -DSTART=$$(($(TOP_ADDR) - $(SIZE))) \
+	-DELF_ARCH=$(ELF_ARCH) -DELF_FORMAT=\"$(ELF_FORMAT)\" -P -C -Uum
+
+linux: arch/um/uml.lds.s vmlinux
 	$(CC) -Wl,-T,arch/um/uml.lds.s -o $@ $(LINK_PROFILE) \
 	$(LINK_WRAPS) -static vmlinux -L/usr/lib -lutil
 
+
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -Derrno=kernel_errno,,$(USER_CFLAGS))
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) -I$(ARCH_INCLUDE)
@@ -125,8 +131,9 @@
 $(ARCH_DIR)/include/task.h : $(ARCH_DIR)/util/mk_task
 	$< > $@
 
-$(ARCH_DIR)/util/mk_task : $(ARCH_DIR)/util/mk_task_user.c \
-	$(ARCH_DIR)/util/mk_task_kern.c 
-	$(MAKE) $(MFLAGS) -C $(ARCH_DIR)/util all
+$(ARCH_DIR)/util/mk_task : $(ARCH_DIR)/util FORCE ;
+
+$(ARCH_DIR)/util: FORCE
+	@$(call descend,$@,)
 
 export SUBARCH USER_CFLAGS OS
diff -Nru a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
--- a/arch/um/Makefile-i386	Sat Oct 12 11:48:06 2002
+++ b/arch/um/Makefile-i386	Sat Oct 12 11:48:06 2002
@@ -8,27 +8,24 @@
 ELF_ARCH = $(SUBARCH)
 ELF_FORMAT = elf32-$(SUBARCH)
 
+SYS_DIR		:= $(ARCH_DIR)/include/sysdep-i386
+SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
 
-SYS_HEADERS = $(ARCH_DIR)/include/sysdep-i386/sc.h \
-	$(ARCH_DIR)/include/sysdep-i386/thread.h
+SYS_HEADERS = $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
 
-$(ARCH_DIR)/include/sysdep-i386/sc.h : $(ARCH_DIR)/sys-i386/util/mk_sc \
-	include/asm
-	$(ARCH_DIR)/sys-i386/util/mk_sc > $@
-
-$(ARCH_DIR)/include/sysdep-i386/thread.h : $(ARCH_DIR)/sys-i386/util/mk_thread\
-	include/asm
-	$(ARCH_DIR)/sys-i386/util/mk_thread > $@
-
-$(ARCH_DIR)/sys-i386/util/mk_sc : $(ARCH_DIR)/sys-i386/util/mk_sc.c \
-	include/asm
-	$(MAKE) -C $(ARCH_DIR)/sys-i386/util mk_sc
-
-$(ARCH_DIR)/sys-i386/util/mk_thread : \
-	$(ARCH_DIR)/sys-i386/util/mk_thread_user.c \
-	$(ARCH_DIR)/sys-i386/util/mk_thread_kern.c
-	$(MAKE) -C $(ARCH_DIR)/sys-i386/util mk_thread
+prepare: $(SYS_HEADERS)
+
+$(SYS_DIR)/sc.h: $(SYS_UTIL_DIR)/mk_sc
+	$< > $@
+
+$(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread
+	$< > $@
+
+$(SYS_UTIL_DIR)/mk_sc $(SYS_UTIL_DIR)/mk_thread: $(SYS_UTIL_DIR) FORCE ; 
+
+$(SYS_UTIL_DIR): include/asm FORCE
+	@$(call descend,$@,)
 
 sysclean :
 	rm -f $(SYS_HEADERS)
-	make -C $(ARCH_DIR)/sys-i386/util clean
+	@$(call descend,$(SYS_DIR),clean)
diff -Nru a/arch/um/sys-i386/util/Makefile b/arch/um/sys-i386/util/Makefile
--- a/arch/um/sys-i386/util/Makefile	Sat Oct 12 11:48:06 2002
+++ b/arch/um/sys-i386/util/Makefile	Sat Oct 12 11:48:06 2002
@@ -1,16 +1,18 @@
-host-progs = mk_sc
+EXTRA_TARGETS	:= mk_sc mk_thread mk_thread_kern.o
 
-mk_sc-objs = mk_sc.o
+host-progs	:= mk_sc
+
+mk_sc-objs	:= mk_sc.o
 
 include $(TOPDIR)/Rules.make
 
-mk_thread : mk_thread_kern.o mk_thread_user.o
-	$(CC) $(CFLAGS) -o $@ mk_thread_user.o mk_thread_kern.o
+$(obj)/mk_thread : $(obj)/mk_thread_kern.o $(obj)/mk_thread_user.o
+	$(CC) $(CFLAGS) -o $@ $^
 
-mk_thread_user.o : mk_thread_user.c
+$(obj)/mk_thread_user.o : $(src)/mk_thread_user.c
 	$(CC) $(USER_CFLAGS) -c -o $@ $<
 
 clean :
-	$(RM) $(host-progs) mk_thread
+	$(RM) -f $(EXTRA_TARGETS)
 
 archmrproper : clean
diff -Nru a/arch/um/util/Makefile b/arch/um/util/Makefile
--- a/arch/um/util/Makefile	Sat Oct 12 11:48:06 2002
+++ b/arch/um/util/Makefile	Sat Oct 12 11:48:06 2002
@@ -1,14 +1,14 @@
-include $(TOPDIR)/Rules.make
+EXTRA_TARGETS := mk_task mk_task_kern.o
 
-all : mk_task
+include $(TOPDIR)/Rules.make
 
-mk_task : mk_task_user.o mk_task_kern.o
-	$(CC) -o mk_task mk_task_user.o mk_task_kern.o
+$(obj)/mk_task: $(obj)/mk_task_user.o $(obj)/mk_task_kern.o
+	$(CC) -o $@ $^
 
-mk_task_user.o : mk_task_user.c
-	$(CC) -c $< 
+$(obj)/mk_task_user.o: $(src)/mk_task_user.c
+	$(CC) -o $@ -c $< 
 
-clean :
-	$(RM) mk_task *.o *~
+clean:
+	$(RM) $(EXTRA_TARGETS)
 
-archmrproper : clean
+archmrproper:



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268377AbUHLDOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268377AbUHLDOd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 23:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268388AbUHLDOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 23:14:32 -0400
Received: from [12.177.129.25] ([12.177.129.25]:2244 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268377AbUHLDON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 23:14:13 -0400
Message-Id: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, kai@germaschewski.name, sam@ravnborg.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Aug 2004 00:14:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes UML build in the face of the ldchk addition to 2.6.8.
The basic problem for UML is that it has always had a two-stage link to produce
the final executable -
	vmlinux contains all the kernel bits, but no libc or gcc libs
	linux is vmlinux plus another .o, massaged by gcc, and linked against 
		libc

This means that, for UML, vmlinux will have unresolved symbols, and will fail
the ldchk test.

I fixed this in a reasonably nasty way by
	adding a $(post-y) to the end of the list of objects
	defining it to be 
		some link flags, an object, and a library from the old linux 
			link command
		a set of libraries pulled from the output of 'gcc -v'
	adding a -L flag to LDFLAGS_vmlinux which points at the location of
		the -lgcc, etc libraries - this is determined by using 'gcc -v'
		to figure out where its spec file is located and assuming that
		its libraries will be located in the same place
	adding arch/um/main.o to $(extra-y) in arch/um/kernel/Makefile because
		I couldn't figure out how to get it to build from 
		arch/um/Makefile

This is all inside UML, except for the $(post-y) in the top-level Makefile.

With this, vmlinux contains all the bits needed for UML, and passes the ldchk
test.  However, it won't run, and a gcc run is needed in order to produce a
real executable.  gcc needs to polish the bits or something.

This getting entirely too familiar with gcc, and I'd appreciate clues about
how to back out of this.  Ideally, I'd like to use the gcc driver as the 
vmlinux linker, but that would require at least rewriting the command, so
I'm not sure how practical that is.

Anyway, you have been warned.  Here it is.  Andrew, please apply.

				Jeff

Index: 2.6.8-rc4-mm1/Makefile
===================================================================
--- 2.6.8-rc4-mm1.orig/Makefile	2004-08-11 22:44:43.000000000 -0400
+++ 2.6.8-rc4-mm1/Makefile	2004-08-11 22:44:49.000000000 -0400
@@ -519,6 +519,7 @@
 	$(drivers-y) \
 	$(net-y) \
 	--end-group \
+	$(post-y) \
 	$(filter .tmp_kallsyms%,$^) \
 	-o $@
 endef
Index: 2.6.8-rc4-mm1/arch/um/Makefile
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/Makefile	2004-08-11 22:44:43.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/Makefile	2004-08-11 22:44:49.000000000 -0400
@@ -21,6 +21,10 @@
 			   $(ARCH_DIR)/drivers/          \
 			   $(ARCH_DIR)/sys-$(SUBARCH)/
 
+post-y			= --wrap malloc --wrap free --wrap calloc \
+			  $(ARCH_DIR)/main.o -lutil \
+			  --start-group -lgcc -lgcc_eh -lc --end-group
+
 # Have to precede the include because the included Makefiles reference them.
 SYMLINK_HEADERS = archparam.h system.h sigcontext.h processor.h ptrace.h \
 	arch-signal.h module.h
@@ -84,7 +88,10 @@
 
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
 
-LDFLAGS_vmlinux = -r
+# This stupidity extracts the directory in which gcc lives so that it can
+# be fed to ld when it's linking .tmp_vmlinux during the ldchk stage.
+LD_DIR = $(shell dirname `gcc -v 2>&1 | head -1 | awk '{print $$NF}'`)
+LDFLAGS_vmlinux = -L/usr/lib -L$(LD_DIR) -r
 
 vmlinux: $(ARCH_DIR)/main.o 
 
@@ -126,8 +133,7 @@
 #	$(call if_changed_dep,as_s_S)
 
 linux: vmlinux $(LD_SCRIPT-y)
-	$(CC) -Wl,-T,$(LD_SCRIPT-y) $(LINK-y) $(LINK_WRAPS) \
-		-o linux $(ARCH_DIR)/main.o vmlinux -L/usr/lib -lutil
+	$(CC) -Wl,-T,$(LD_SCRIPT-y) $(LINK-y) -o linux vmlinux
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -Derrno=kernel_errno,,$(USER_CFLAGS))
Index: 2.6.8-rc4-mm1/arch/um/kernel/Makefile
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/kernel/Makefile	2004-08-11 22:44:43.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/kernel/Makefile	2004-08-11 22:44:49.000000000 -0400
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-extra-y := vmlinux.lds.s
+extra-y := vmlinux.lds.s ../main.o
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o mem.o mem_user.o \
@@ -24,7 +24,7 @@
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
 USER_OBJS := $(filter %_user.o,$(obj-y))  $(user-objs-y) config.o helper.o \
-	process.o tempfile.o time.o tty_log.o umid.o user_util.o
+	process.o tempfile.o time.o tty_log.o umid.o user_util.o ../main.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 CFLAGS_frame.o := $(patsubst -fomit-frame-pointer,,$(USER_CFLAGS))
Index: 2.6.8-rc4-mm1/arch/um/kernel/vmlinux.lds.S
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/kernel/vmlinux.lds.S	2004-08-11 22:44:43.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/kernel/vmlinux.lds.S	2004-08-11 22:44:49.000000000 -0400
@@ -42,11 +42,10 @@
 
   #include "asm/common.lds.S"
 
-  init.data : { *(init.data) }
+  .init.data : { *(init.data) }
+  .data.init_task : { *(.data.init_task) } 
   .data    :
   {
-    . = ALIGN(KERNEL_STACK_SIZE);		/* init_task */
-    *(.data.init_task)
     *(.data)
     *(.gnu.linkonce.d*)
     CONSTRUCTORS
Index: 2.6.8-rc4-mm1/arch/um/sys-i386/Makefile
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/sys-i386/Makefile	2004-08-11 22:44:43.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/sys-i386/Makefile	2004-08-11 22:44:49.000000000 -0400
@@ -1,5 +1,5 @@
-obj-y = bugs.o checksum.o fault.o ksyms.o ldt.o ptrace.o ptrace_user.o \
-	semaphore.o sigcontext.o syscalls.o sysrq.o time.o
+obj-y = bitops.o bugs.o checksum.o fault.o ksyms.o ldt.o ptrace.o \
+	ptrace_user.o semaphore.o sigcontext.o syscalls.o sysrq.o time.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
@@ -7,11 +7,12 @@
 USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
-SYMLINKS = semaphore.c highmem.c module.c
+SYMLINKS = bitops.c semaphore.c highmem.c module.c
 SYMLINKS := $(foreach f,$(SYMLINKS),$(src)/$f)
 
 clean-files := $(SYMLINKS)
 
+bitops.c-dir = lib
 semaphore.c-dir = kernel
 highmem.c-dir = mm
 module.c-dir = kernel
Index: 2.6.8-rc4-mm1/arch/um/uml.lds.S
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/uml.lds.S	2004-08-11 22:44:43.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/uml.lds.S	2004-08-11 22:44:49.000000000 -0400
@@ -11,15 +11,9 @@
 
   __binary_start = .;
 #ifdef MODE_TT
-  .thread_private : {
-    __start_thread_private = .;
-    errno = .;
-    . += 4;
-    arch/um/kernel/tt/unmap_fin.o (.data)
-    __end_thread_private = .;
-  }
+  .thread_private : { *(.thread_private) }
   . = ALIGN(4096);
-  .remap : { arch/um/kernel/tt/unmap_fin.o (.text) }
+  .remap : { *(.remap) }
 #endif
 
   . = ALIGN(4096);		/* Init code and data */


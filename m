Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268102AbUHQFCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268102AbUHQFCp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 01:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUHQFCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 01:02:45 -0400
Received: from [12.177.129.25] ([12.177.129.25]:19396 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268115AbUHQFBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 01:01:14 -0400
Message-Id: <200408170602.i7H62LNj019126@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Andrew Morton <akpm@osdl.org>
cc: kai@germaschewski.name, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build 
In-Reply-To: Your message of "Sun, 15 Aug 2004 15:06:35 PDT."
             <20040815150635.5ac4f5df.akpm@osdl.org> 
References: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org>  <20040815150635.5ac4f5df.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Aug 2004 02:02:21 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org said:
> Confused.  

So was I for a while :-)

> Your vmlinux.lds.S doesn't look anything like mine: 

My apologies.  A combination of a mashed stock tree and some quilt lossage
at my end caused some bogus patches and let them pass my sanity tests.

Here is a fixed fix-build patch, against 2.6.8.1-mm1.

The undefined symbol checking is continuing to cause UML pain.  This time,
it picked up a bunch of 'w' symbols as undefined.  They were present in the
2.6.8-rc4-mm1 vmlinux and caused no problems for the final link, so I added
them as a second special case to mksysmap (and I just noticed that I forgot
a comment there - I can submit a patch for that if there's demand for one).

				Jeff

Index: test/Makefile
===================================================================
--- test.orig/Makefile	2004-08-17 00:37:33.000000000 -0400
+++ test/Makefile	2004-08-17 00:38:20.000000000 -0400
@@ -523,6 +523,7 @@
 	$(drivers-y) \
 	$(net-y) \
 	--end-group \
+	$(post-y) \
 	$(filter .tmp_kallsyms%,$^) \
 	-o $@
 endef
Index: test/arch/um/Makefile
===================================================================
--- test.orig/arch/um/Makefile	2004-08-17 00:37:33.000000000 -0400
+++ test/arch/um/Makefile	2004-08-17 00:38:20.000000000 -0400
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
 
@@ -117,17 +124,28 @@
 	-DSTART=$$(($(TOP_ADDR) - $(SIZE))) -DELF_ARCH=$(ELF_ARCH) \
 	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE_TT) \
 	-DKERNEL_STACK_SIZE=$(STACK_SIZE))
+CPPFLAGS_$(LD_SCRIPT-y) = $(CPPFLAGS_vmlinux.lds) -P -C -Uum
 
-export CPPFLAGS_$(LD_SCRIPT-y) = $(CPPFLAGS_vmlinux.lds) -P -C -Uum
+export CPPFLAGS_$(LD_SCRIPT-y)
 
 LD_SCRIPT-y := $(ARCH_DIR)/$(LD_SCRIPT-y)
 
-#$(LD_SCRIPT-y) : $(LD_SCRIPT-y:.s=.S) scripts FORCE
-#	$(call if_changed_dep,as_s_S)
+# More kbuild lossage - I can't get uml.lds to fire the %.lds : %.lds.S rule.
+# It always ends up going into the .S assembly rule.  So, an explicit rule
+# here works around that.  Then, it turns out that cmd_cpp_lds_S is undefined,
+# which I don't understand since I would have thought that the entire Makefile
+# had been read by the time it executes commands.  So, defining that here works
+# around that.  Then, it turns out that cpp_flags isn't defined, which I don't
+# understand for the same reason.  So, I just included the expansion here,
+# and after much grossness, you get a building and working UML.
+quiet_cmd_cpp_lds_S = LDS     $@
+      cmd_cpp_lds_S = $(CPP) -Wp,-MD,$(depfile) -Iinclude $(CPPFLAGS_vmlinux.lds) -P -C -Uum $(NOSTDINC_FLAGS) -D__ASSEMBLY__ -o $@ $<
+
+$(LD_SCRIPT-y) : $(LD_SCRIPT-y).S scripts FORCE
+	$(call if_changed_dep,cpp_lds_S)
 
 linux: vmlinux $(LD_SCRIPT-y)
-	$(CC) -Wl,-T,$(LD_SCRIPT-y) $(LINK-y) $(LINK_WRAPS) \
-		-o linux $(ARCH_DIR)/main.o vmlinux -L/usr/lib -lutil
+	$(CC) -Wl,-T,$(LD_SCRIPT-y) $(LINK-y) -o linux vmlinux
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -Derrno=kernel_errno,,$(USER_CFLAGS))
Index: test/arch/um/kernel/Makefile
===================================================================
--- test.orig/arch/um/kernel/Makefile	2004-08-17 00:37:33.000000000 -0400
+++ test/arch/um/kernel/Makefile	2004-08-17 00:38:20.000000000 -0400
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-extra-y := vmlinux.lds
+extra-y := vmlinux.lds ../main.o
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o mem.o mem_user.o \
@@ -24,7 +24,7 @@
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
 USER_OBJS := $(filter %_user.o,$(obj-y))  $(user-objs-y) config.o helper.o \
-	process.o tempfile.o time.o tty_log.o umid.o user_util.o
+	process.o tempfile.o time.o tty_log.o umid.o user_util.o ../main.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 CFLAGS_frame.o := $(patsubst -fomit-frame-pointer,,$(USER_CFLAGS))
Index: test/arch/um/kernel/vmlinux.lds.S
===================================================================
--- test.orig/arch/um/kernel/vmlinux.lds.S	2004-06-16 01:18:37.000000000 -0400
+++ test/arch/um/kernel/vmlinux.lds.S	2004-08-17 00:38:20.000000000 -0400
@@ -7,5 +7,89 @@
 
 SECTIONS
 {
-#include "asm/common.lds.S"
+  . = START + SIZEOF_HEADERS;
+
+  __binary_start = .;
+#ifdef MODE_TT
+  .thread_private : {
+    __start_thread_private = .;
+    errno = .;
+    . += 4;
+    arch/um/kernel/tt/unmap_fin.o (.data)
+    __end_thread_private = .;
+  }
+  . = ALIGN(4096);
+  .remap : { arch/um/kernel/tt/unmap_fin.o (.text) }
+#endif
+
+  . = ALIGN(4096);		/* Init code and data */
+  _stext = .;
+  __init_begin = .;
+  .init.text : {
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
+  . = ALIGN(4096);
+  .text      :
+  {
+    *(.text)
+    SCHED_TEXT
+    /* .gnu.warning sections are handled specially by elf32.em.  */
+    *(.gnu.warning)
+    *(.gnu.linkonce.t*)
+  }
+
+  #include "asm/common.lds.S"
+
+  .init.data : { *(init.data) }
+  .data.init_task : { *(.data.init_task) } 
+  .data    :
+  {
+    *(.data)
+    *(.gnu.linkonce.d*)
+    CONSTRUCTORS
+  }
+  .data1   : { *(.data1) }
+  .ctors         :
+  {
+    *(.ctors)
+  }
+  .dtors         :
+  {
+    *(.dtors)
+  }
+
+  .got           : { *(.got.plt) *(.got) }
+  .dynamic       : { *(.dynamic) }
+  /* We want the small data sections together, so single-instruction offsets
+     can access them all, and initialized data all before uninitialized, so
+     we can shorten the on-disk segment size.  */
+  .sdata     : { *(.sdata) }
+  _edata  =  .;
+  PROVIDE (edata = .);
+  . = ALIGN(0x1000);
+  .sbss      : 
+  {
+   __bss_start = .;
+   PROVIDE(_bss_start = .);
+   *(.sbss) 
+   *(.scommon) 
+  }
+  .bss       :
+  {
+   *(.dynbss)
+   *(.bss)
+   *(COMMON)
+  }
+  _end = . ;
+  PROVIDE (end = .);
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
 }
Index: test/arch/um/sys-i386/Makefile
===================================================================
--- test.orig/arch/um/sys-i386/Makefile	2004-08-17 00:37:33.000000000 -0400
+++ test/arch/um/sys-i386/Makefile	2004-08-17 00:38:20.000000000 -0400
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
Index: test/arch/um/uml.lds.S
===================================================================
--- test.orig/arch/um/uml.lds.S	2004-08-17 00:37:33.000000000 -0400
+++ test/arch/um/uml.lds.S	2004-08-17 00:38:20.000000000 -0400
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
Index: test/scripts/mksysmap
===================================================================
--- test.orig/scripts/mksysmap	2004-08-17 00:37:45.000000000 -0400
+++ test/scripts/mksysmap	2004-08-17 00:38:20.000000000 -0400
@@ -18,7 +18,7 @@
 # they are used by the sparc BTFIXUP logic - and is assumed to be undefined.
 
 
-if [ "`$NM -u $1 | grep -v ' ___'`" != "" ]; then
+if [ "`$NM -u $1 | grep -v '\( ___\)\|\(^ *w \)'`" != "" ]; then
 	echo "$1: error: undefined symbol(s) found:"
 	$NM -u $1 | grep -v ' ___'
 	exit 1


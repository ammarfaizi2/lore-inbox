Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVEAVYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVEAVYu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVEAVXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:23:40 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:27923 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262677AbVEAVSe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:34 -0400
Message-Id: <200505012112.j41LC9fa016385@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH 1/22] UML - Include the linker script rather than symlink it
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:09 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro:

	Make vmlinux.lds.S include appopriate script instead of playing
games with symlinks.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11-mm/arch/um/Makefile
===================================================================
--- linux-2.6.11-mm.orig/arch/um/Makefile	2005-04-30 12:57:43.000000000 -0400
+++ linux-2.6.11-mm/arch/um/Makefile	2005-04-30 12:58:23.000000000 -0400
@@ -96,15 +96,11 @@
 
 $(shell cd $(ARCH_DIR) && ln -sf Kconfig_$(SUBARCH) Kconfig_arch)
 
-prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
-	$(ARCH_DIR)/kernel/vmlinux.lds.S
+prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
 
-LD_SCRIPT-$(CONFIG_LD_SCRIPT_STATIC) := uml.lds.S
-LD_SCRIPT-$(CONFIG_LD_SCRIPT_DYN) := dyn.lds.S
-
 CPP_MODE-$(CONFIG_MODE_TT) := -DMODE_TT
 CONFIG_KERNEL_STACK_ORDER ?= 2
 STACK_SIZE := $(shell echo $$[ 4096 * (1 << $(CONFIG_KERNEL_STACK_ORDER)) ] )
@@ -145,15 +141,6 @@
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 
-#We need to re-preprocess this when the symlink dest changes.
-#So we touch it when needed.
-$(ARCH_DIR)/kernel/vmlinux.lds.S: FORCE
-	$(Q)if [ "$(shell readlink $@)" != "$(LD_SCRIPT-y)" ]; then \
-		echo '  SYMLINK $@'; \
-		ln -sf $(LD_SCRIPT-y) $@; \
-		touch $@; \
-	fi;
-
 $(SYMLINK_HEADERS):
 	@echo '  SYMLINK $@'
 	$(Q)cd $(TOPDIR)/$(dir $@) ; \
Index: linux-2.6.11-mm/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/Makefile	2005-04-30 12:57:43.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/Makefile	2005-04-30 12:59:28.000000000 -0400
@@ -4,7 +4,6 @@
 #
 
 extra-y := vmlinux.lds
-clean-files := vmlinux.lds.S
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
Index: linux-2.6.11-mm/arch/um/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/vmlinux.lds.S	2005-04-30 12:56:25.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/vmlinux.lds.S	2005-04-30 12:58:23.000000000 -0400
@@ -1,113 +1,6 @@
-#include <asm-generic/vmlinux.lds.h>
-
-OUTPUT_FORMAT(ELF_FORMAT)
-OUTPUT_ARCH(ELF_ARCH)
-ENTRY(_start)
-jiffies = jiffies_64;
-
-SECTIONS
-{
-  /*This must contain the right address - not quite the default ELF one.*/
-  PROVIDE (__executable_start = START);
-  . = START + SIZEOF_HEADERS;
-
-  /* Used in arch/um/kernel/mem.c. Any memory between START and __binary_start
-   * is remapped.*/
-  __binary_start = .;
-#ifdef MODE_TT
-  .thread_private : {
-    __start_thread_private = .;
-    errno = .;
-    . += 4;
-    arch/um/kernel/tt/unmap_fin.o (.data)
-    __end_thread_private = .;
-  }
-  . = ALIGN(4096);
-  .remap : { arch/um/kernel/tt/unmap_fin.o (.text) }
-
-  /* We want it only if we are in MODE_TT. In both cases, however, when MODE_TT
-   * is off the resulting binary segfaults.*/
-
-  . = ALIGN(4096);		/* Init code and data */
+#include <linux/config.h>
+#ifdef CONFIG_LD_SCRIPT_STATIC
+#include "uml.lds.S"
+#else
+#include "dyn.lds.S"
 #endif
-
-  _stext = .;
-  __init_begin = .;
-  .init.text : {
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  . = ALIGN(4096);
-
-  .text      :
-  {
-    *(.text)
-    SCHED_TEXT
-    LOCK_TEXT
-    *(.fixup)
-    /* .gnu.warning sections are handled specially by elf32.em.  */
-    *(.gnu.warning)
-    *(.gnu.linkonce.t*)
-
-    . = ALIGN(4096);
-    __syscall_stub_start = .;
-    *(.__syscall_stub*)
-    __syscall_stub_end = .;
-    . = ALIGN(4096);
-  }
-
-  #include "asm/common.lds.S"
-
-  init.data : { *(init.data) }
-  .data    :
-  {
-    . = ALIGN(KERNEL_STACK_SIZE);		/* init_task */
-    *(.data.init_task)
-    *(.data)
-    *(.gnu.linkonce.d*)
-    CONSTRUCTORS
-  }
-  .data1   : { *(.data1) }
-  .ctors         :
-  {
-    *(.ctors)
-  }
-  .dtors         :
-  {
-    *(.dtors)
-  }
-
-  .got           : { *(.got.plt) *(.got) }
-  .dynamic       : { *(.dynamic) }
-  /* We want the small data sections together, so single-instruction offsets
-     can access them all, and initialized data all before uninitialized, so
-     we can shorten the on-disk segment size.  */
-  .sdata     : { *(.sdata) }
-  _edata  =  .;
-  PROVIDE (edata = .);
-  . = ALIGN(0x1000);
-  .sbss      :
-  {
-   __bss_start = .;
-   PROVIDE(_bss_start = .);
-   *(.sbss)
-   *(.scommon)
-  }
-  .bss       :
-  {
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-  }
-  _end = . ;
-  PROVIDE (end = .);
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-}


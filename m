Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUHSM3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUHSM3r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 08:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUHSM3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 08:29:47 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:34301 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265808AbUHSM3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 08:29:34 -0400
Date: Thu, 19 Aug 2004 05:29:15 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>
Subject: [PATCH] 2.6.8.1-mm2 --- UML build fixes
Message-ID: <20040819122915.GA2085@taniwha.stupidest.org>
References: <20040819014204.2d412e9b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819014204.2d412e9b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 01:42:04AM -0700, Andrew Morton wrote:

> +uml-remove-cow-driver.patch
> +uml-updates-2.patch
>
>  UML fixes

This (merged from jdike earlier email) is required to get uml to
build.


 Makefile                     |    1
 arch/um/Makefile             |   31 ++++++++++++---
 arch/um/kernel/Makefile      |    4 +-
 arch/um/kernel/vmlinux.lds.S |   86 ++++++++++++++++++++++++++++++++++++++++++-
 arch/um/sys-i386/Makefile    |    7 ++-
 arch/um/uml.lds.S            |   10 +----
 6 files changed, 119 insertions(+), 20 deletions(-)


===== Makefile 1.514 vs edited =====
--- 1.514/Makefile	2004-08-19 04:32:25 -07:00
+++ edited/Makefile	2004-08-19 04:38:27 -07:00
@@ -523,6 +523,7 @@
 	$(drivers-y) \
 	$(net-y) \
 	--end-group \
+	$(post-y) \
 	$(filter .tmp_kallsyms%,$^) \
 	-o $@
 endef
===== arch/um/Makefile 1.27 vs edited =====
--- 1.27/arch/um/Makefile	2004-08-19 04:33:04 -07:00
+++ edited/arch/um/Makefile	2004-08-19 04:38:27 -07:00
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
@@ -84,7 +88,11 @@
 
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
 
-LDFLAGS_vmlinux = -r
+# This extracts the library path from gcc with -print-search-dirs and munges
+# the output into a bunch of -L switches.
+LD_DIRS = $(shell gcc -print-search-dirs | grep libraries | \
+	sed -e 's/^.*=/-L/' -e 's/:/ -L/g')
+LDFLAGS_vmlinux = $(LD_DIRS) -r
 
 vmlinux: $(ARCH_DIR)/main.o 
 
@@ -117,17 +125,28 @@
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
===== arch/um/uml.lds.S 1.17 vs edited =====
--- 1.17/arch/um/uml.lds.S	2004-08-19 04:33:04 -07:00
+++ edited/arch/um/uml.lds.S	2004-08-19 04:38:27 -07:00
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
===== arch/um/kernel/Makefile 1.21 vs edited =====
--- 1.21/arch/um/kernel/Makefile	2004-08-19 04:33:10 -07:00
+++ edited/arch/um/kernel/Makefile	2004-08-19 04:38:27 -07:00
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
===== arch/um/kernel/vmlinux.lds.S 1.2 vs edited =====
--- 1.2/arch/um/kernel/vmlinux.lds.S	2003-08-04 20:42:07 -07:00
+++ edited/arch/um/kernel/vmlinux.lds.S	2004-08-19 04:57:31 -07:00
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
===== arch/um/sys-i386/Makefile 1.16 vs edited =====
--- 1.16/arch/um/sys-i386/Makefile	2004-08-19 04:33:16 -07:00
+++ edited/arch/um/sys-i386/Makefile	2004-08-19 04:38:27 -07:00
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

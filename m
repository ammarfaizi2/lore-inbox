Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUHPBbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUHPBbc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 21:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267315AbUHPBbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 21:31:32 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:22169 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S267314AbUHPBbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 21:31:21 -0400
Subject: [PATCH] Centralize i386 Constants
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1092619849.29612.49.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 11:30:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Centralize i386 Constants
Status: Tested on 2.6.5-rc2-bk1
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (created)

__FIXADDR_TOP and PAGE_OFFSET are hardcoded in various places.  I had
to change it to run the kernel under qemu-fast, so I wanted to
centralize them.

To do this, we rename vsyscall.lds to vsyscall.lds.s, and generate it
from vsyscall.lds.S.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9001-linux-2.6.5-rc2-bk1/arch/i386/kernel/Makefile .9001-linux-2.6.5-rc2-bk1.updated/arch/i386/kernel/Makefile
--- .9001-linux-2.6.5-rc2-bk1/arch/i386/kernel/Makefile	2004-03-20 21:20:49.000000000 +1100
+++ .9001-linux-2.6.5-rc2-bk1.updated/arch/i386/kernel/Makefile	2004-03-22 09:53:31.000000000 +1100
@@ -47,12 +47,14 @@ quiet_cmd_syscall = SYSCALL $@
       cmd_syscall = $(CC) -nostdlib $(SYSCFLAGS_$(@F)) \
 		          -Wl,-T,$(filter-out FORCE,$^) -o $@
 
+export AFLAGS_vsyscall.lds.o += -P -C -U$(ARCH)
+
 vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1
 SYSCFLAGS_vsyscall-sysenter.so	= $(vsyscall-flags)
 SYSCFLAGS_vsyscall-int80.so	= $(vsyscall-flags)
 
 $(obj)/vsyscall-int80.so $(obj)/vsyscall-sysenter.so: \
-$(obj)/vsyscall-%.so: $(src)/vsyscall.lds $(obj)/vsyscall-%.o FORCE
+$(obj)/vsyscall-%.so: $(src)/vsyscall.lds.s $(obj)/vsyscall-%.o FORCE
 	$(call if_changed,syscall)
 
 # We also create a special relocatable object that should mirror the symbol
@@ -63,5 +65,5 @@ $(obj)/built-in.o: $(obj)/vsyscall-syms.
 $(obj)/built-in.o: ld_flags += -R $(obj)/vsyscall-syms.o
 
 SYSCFLAGS_vsyscall-syms.o = -r
-$(obj)/vsyscall-syms.o: $(src)/vsyscall.lds $(obj)/vsyscall-sysenter.o FORCE
+$(obj)/vsyscall-syms.o: $(src)/vsyscall.lds.s $(obj)/vsyscall-sysenter.o FORCE
 	$(call if_changed,syscall)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9001-linux-2.6.5-rc2-bk1/arch/i386/kernel/vmlinux.lds.S .9001-linux-2.6.5-rc2-bk1.updated/arch/i386/kernel/vmlinux.lds.S
--- .9001-linux-2.6.5-rc2-bk1/arch/i386/kernel/vmlinux.lds.S	2004-03-20 21:20:49.000000000 +1100
+++ .9001-linux-2.6.5-rc2-bk1.updated/arch/i386/kernel/vmlinux.lds.S	2004-03-22 09:53:56.000000000 +1100
@@ -4,6 +4,7 @@
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
+#include <asm/page.h>
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
@@ -11,7 +12,7 @@ ENTRY(startup_32)
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = 0xC0000000 + 0x100000;
+  . = __PAGE_OFFSET + 0x100000;
   /* read-only */
   _text = .;			/* Text and read-only data */
   .text : {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9001-linux-2.6.5-rc2-bk1/arch/i386/kernel/vsyscall.lds .9001-linux-2.6.5-rc2-bk1.updated/arch/i386/kernel/vsyscall.lds
--- .9001-linux-2.6.5-rc2-bk1/arch/i386/kernel/vsyscall.lds	2003-09-22 10:07:26.000000000 +1000
+++ .9001-linux-2.6.5-rc2-bk1.updated/arch/i386/kernel/vsyscall.lds	1970-01-01 10:00:00.000000000 +1000
@@ -1,67 +0,0 @@
-/*
- * Linker script for vsyscall DSO.  The vsyscall page is an ELF shared
- * object prelinked to its virtual address, and with only one read-only
- * segment (that fits in one page).  This script controls its layout.
- */
-
-/* This must match <asm/fixmap.h>.  */
-VSYSCALL_BASE = 0xffffe000;
-
-SECTIONS
-{
-  . = VSYSCALL_BASE + SIZEOF_HEADERS;
-
-  .hash           : { *(.hash) }		:text
-  .dynsym         : { *(.dynsym) }
-  .dynstr         : { *(.dynstr) }
-  .gnu.version    : { *(.gnu.version) }
-  .gnu.version_d  : { *(.gnu.version_d) }
-  .gnu.version_r  : { *(.gnu.version_r) }
-
-  /* This linker script is used both with -r and with -shared.
-     For the layouts to match, we need to skip more than enough
-     space for the dynamic symbol table et al.  If this amount
-     is insufficient, ld -shared will barf.  Just increase it here.  */
-  . = VSYSCALL_BASE + 0x400;
-
-  .text           : { *(.text) }		:text =0x90909090
-
-  .eh_frame_hdr   : { *(.eh_frame_hdr) }	:text :eh_frame_hdr
-  .eh_frame       : { KEEP (*(.eh_frame)) }	:text
-  .dynamic        : { *(.dynamic) }		:text :dynamic
-  .useless        : {
-  	*(.got.plt) *(.got)
-	*(.data .data.* .gnu.linkonce.d.*)
-	*(.dynbss)
-	*(.bss .bss.* .gnu.linkonce.b.*)
-  }						:text
-}
-
-/*
- * We must supply the ELF program headers explicitly to get just one
- * PT_LOAD segment, and set the flags explicitly to make segments read-only.
- */
-PHDRS
-{
-  text PT_LOAD FILEHDR PHDRS FLAGS(5); /* PF_R|PF_X */
-  dynamic PT_DYNAMIC FLAGS(4); /* PF_R */
-  eh_frame_hdr 0x6474e550; /* PT_GNU_EH_FRAME, but ld doesn't match the name */
-}
-
-/*
- * This controls what symbols we export from the DSO.
- */
-VERSION
-{
-  LINUX_2.5 {
-    global:
-    	__kernel_vsyscall;
-    	__kernel_sigreturn;
-    	__kernel_rt_sigreturn;
-
-    local: *;
-  };
-}
-
-/* The ELF entry point can be used to set the AT_SYSINFO value.  */
-ENTRY(__kernel_vsyscall);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9001-linux-2.6.5-rc2-bk1/arch/i386/kernel/vsyscall.lds.S .9001-linux-2.6.5-rc2-bk1.updated/arch/i386/kernel/vsyscall.lds.S
--- .9001-linux-2.6.5-rc2-bk1/arch/i386/kernel/vsyscall.lds.S	1970-01-01 10:00:00.000000000 +1000
+++ .9001-linux-2.6.5-rc2-bk1.updated/arch/i386/kernel/vsyscall.lds.S	2004-03-22 09:53:31.000000000 +1100
@@ -0,0 +1,67 @@
+/*
+ * Linker script for vsyscall DSO.  The vsyscall page is an ELF shared
+ * object prelinked to its virtual address, and with only one read-only
+ * segment (that fits in one page).  This script controls its layout.
+ */
+#include <asm/fixmap.h>
+	
+VSYSCALL_BASE = __FIXADDR_TOP - 0x1000;
+
+SECTIONS
+{
+  . = VSYSCALL_BASE + SIZEOF_HEADERS;
+
+  .hash           : { *(.hash) }		:text
+  .dynsym         : { *(.dynsym) }
+  .dynstr         : { *(.dynstr) }
+  .gnu.version    : { *(.gnu.version) }
+  .gnu.version_d  : { *(.gnu.version_d) }
+  .gnu.version_r  : { *(.gnu.version_r) }
+
+  /* This linker script is used both with -r and with -shared.
+     For the layouts to match, we need to skip more than enough
+     space for the dynamic symbol table et al.  If this amount
+     is insufficient, ld -shared will barf.  Just increase it here.  */
+  . = VSYSCALL_BASE + 0x400;
+
+  .text           : { *(.text) }		:text =0x90909090
+
+  .eh_frame_hdr   : { *(.eh_frame_hdr) }	:text :eh_frame_hdr
+  .eh_frame       : { KEEP (*(.eh_frame)) }	:text
+  .dynamic        : { *(.dynamic) }		:text :dynamic
+  .useless        : {
+  	*(.got.plt) *(.got)
+	*(.data .data.* .gnu.linkonce.d.*)
+	*(.dynbss)
+	*(.bss .bss.* .gnu.linkonce.b.*)
+  }						:text
+}
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+  text PT_LOAD FILEHDR PHDRS FLAGS(5); /* PF_R|PF_X */
+  dynamic PT_DYNAMIC FLAGS(4); /* PF_R */
+  eh_frame_hdr 0x6474e550; /* PT_GNU_EH_FRAME, but ld doesn't match the name */
+}
+
+/*
+ * This controls what symbols we export from the DSO.
+ */
+VERSION
+{
+  LINUX_2.5 {
+    global:
+    	__kernel_vsyscall;
+    	__kernel_sigreturn;
+    	__kernel_rt_sigreturn;
+
+    local: *;
+  };
+}
+
+/* The ELF entry point can be used to set the AT_SYSINFO value.  */
+ENTRY(__kernel_vsyscall);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9001-linux-2.6.5-rc2-bk1/include/asm-i386/fixmap.h .9001-linux-2.6.5-rc2-bk1.updated/include/asm-i386/fixmap.h
--- .9001-linux-2.6.5-rc2-bk1/include/asm-i386/fixmap.h	2004-03-12 07:57:19.000000000 +1100
+++ .9001-linux-2.6.5-rc2-bk1.updated/include/asm-i386/fixmap.h	2004-03-22 09:53:31.000000000 +1100
@@ -14,6 +14,15 @@
 #define _ASM_FIXMAP_H
 
 #include <linux/config.h>
+
+/* used by vmalloc.c, vsyscall.lds.S.
+ *
+ * Leave one empty page between vmalloc'ed areas and
+ * the start of the fixmap.
+ */
+#define __FIXADDR_TOP	0xfffff000
+
+#ifndef __ASSEMBLY__
 #include <linux/kernel.h>
 #include <asm/acpi.h>
 #include <asm/apicdef.h>
@@ -97,13 +110,8 @@ extern void __set_fixmap (enum fixed_add
 #define clear_fixmap(idx) \
 		__set_fixmap(idx, 0, __pgprot(0))
 
-/*
- * used by vmalloc.c.
- *
- * Leave one empty page between vmalloc'ed areas and
- * the start of the fixmap.
- */
-#define FIXADDR_TOP	(0xfffff000UL)
+#define FIXADDR_TOP	((unsigned long)__FIXADDR_TOP)
+
 #define __FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - __FIXADDR_SIZE)
 
@@ -148,4 +156,5 @@ static inline unsigned long virt_to_fix(
 	return __virt_to_fix(vaddr);
 }
 
+#endif /* !__ASSEMBLY__ */
 #endif

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell


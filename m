Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVEAKYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVEAKYf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 06:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVEAKXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 06:23:40 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:64211 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261583AbVEAKVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 06:21:24 -0400
Subject: [patch 1/1] Uml: kludgy compilation fixes for x86-64 subarch modules support [for -mm]
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       ak@suse.de
From: blaisorblade@yahoo.it
Date: Sun, 01 May 2005 20:45:15 +0200
Message-Id: <20050501184515.F1AA48D835@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andi Kleen <ak@suse.de>

These are some trivial fixes for the x86-64 subarch module support. The only
potential problem is that I have to modify arch/x86_64/kernel/module.c, to
avoid copying the whole of it.

I can't use it verbatim because it depends on a special vmalloc-like area for
modules, which for now (maybe that's to fix, I guess not) UML/x86-64 has not.
I went the easy way and reused the i386 vmalloc()-based allocator.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/sys-x86_64/Makefile    |    7 ++++-
 linux-2.6.12-paolo/arch/um/sys-x86_64/ksyms.c     |   23 ++++++++++++++++++
 linux-2.6.12-paolo/arch/um/sys-x86_64/um_module.c |   19 +++++++++++++++
 linux-2.6.12-paolo/arch/x86_64/kernel/module.c    |    4 +++
 linux-2.6.12-paolo/include/asm-um/elf.h           |   27 ++++++++++++++++++++++
 5 files changed, 79 insertions(+), 1 deletion(-)

diff -puN /dev/null arch/um/sys-x86_64/ksyms.c
--- /dev/null	2005-04-30 21:19:18.900148040 +0200
+++ linux-2.6.12-paolo/arch/um/sys-x86_64/ksyms.c	2005-05-01 20:40:52.000000000 +0200
@@ -0,0 +1,23 @@
+#include "linux/module.h"
+#include "linux/in6.h"
+#include "linux/rwsem.h"
+#include "asm/byteorder.h"
+#include "asm/semaphore.h"
+#include "asm/uaccess.h"
+#include "asm/checksum.h"
+#include "asm/errno.h"
+
+EXPORT_SYMBOL(__down_failed);
+EXPORT_SYMBOL(__down_failed_interruptible);
+EXPORT_SYMBOL(__down_failed_trylock);
+EXPORT_SYMBOL(__up_wakeup);
+
+/*XXX: we need them because they would be exported by x86_64 */
+EXPORT_SYMBOL(__memcpy);
+EXPORT_SYMBOL(strcmp);
+EXPORT_SYMBOL(strcat);
+EXPORT_SYMBOL(strcpy);
+
+/* Networking helper routines. */
+/*EXPORT_SYMBOL(csum_partial_copy_from);
+EXPORT_SYMBOL(csum_partial_copy_to);*/
diff -puN arch/um/sys-x86_64/Makefile~uml-x86-64-compilation arch/um/sys-x86_64/Makefile
--- linux-2.6.12/arch/um/sys-x86_64/Makefile~uml-x86-64-compilation	2005-05-01 20:40:52.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/sys-x86_64/Makefile	2005-05-01 20:40:52.000000000 +0200
@@ -4,14 +4,18 @@
 # Licensed under the GPL
 #
 
+#XXX: why into lib-y?
 lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o mem.o memcpy.o \
 	ptrace.o ptrace_user.o semaphore.o sigcontext.o signal.o \
 	syscalls.o sysrq.o thunk.o syscall_table.o
 
+obj-y := ksyms.o
+obj-$(CONFIG_MODULES) += module.o um_module.o
+
 USER_OBJS := ptrace_user.o sigcontext.o
 
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c memcpy.S \
-	semaphore.c thunk.S
+	semaphore.c thunk.S module.c
 
 bitops.c-dir = lib
 csum-copy.S-dir = lib
@@ -20,6 +24,7 @@ csum-wrappers.c-dir = lib
 memcpy.S-dir = lib
 semaphore.c-dir = kernel
 thunk.S-dir = lib
+module.c-dir = kernel
 
 CFLAGS_csum-partial.o := -Dcsum_partial=arch_csum_partial
 
diff -puN /dev/null arch/um/sys-x86_64/um_module.c
--- /dev/null	2005-04-30 21:19:18.900148040 +0200
+++ linux-2.6.12-paolo/arch/um/sys-x86_64/um_module.c	2005-05-01 20:40:52.000000000 +0200
@@ -0,0 +1,19 @@
+#include <linux/vmalloc.h>
+#include <linux/moduleloader.h>
+
+/*Copied from i386 arch/i386/kernel/module.c */
+void *module_alloc(unsigned long size)
+{
+	if (size == 0)
+		return NULL;
+	return vmalloc_exec(size);
+}
+
+/* Free memory returned from module_alloc */
+void module_free(struct module *mod, void *module_region)
+{
+	vfree(module_region);
+	/* FIXME: If module_region == mod->init_region, trim exception
+           table entries. */
+}
+
diff -puN arch/x86_64/kernel/module.c~uml-x86-64-compilation arch/x86_64/kernel/module.c
--- linux-2.6.12/arch/x86_64/kernel/module.c~uml-x86-64-compilation	2005-05-01 20:40:52.000000000 +0200
+++ linux-2.6.12-paolo/arch/x86_64/kernel/module.c	2005-05-01 20:40:52.000000000 +0200
@@ -30,9 +30,12 @@
 
 #define DEBUGP(fmt...) 
 
+#ifndef CONFIG_UML
 void module_free(struct module *mod, void *module_region)
 {
 	vfree(module_region);
+	/* FIXME: If module_region == mod->init_region, trim exception
+           table entries. */
 }
 
 void *module_alloc(unsigned long size)
@@ -51,6 +54,7 @@ void *module_alloc(unsigned long size)
 
 	return __vmalloc_area(area, GFP_KERNEL, PAGE_KERNEL_EXEC);
 }
+#endif
 
 /* We don't need anything special. */
 int module_frob_arch_sections(Elf_Ehdr *hdr,
diff -puN include/asm-um/elf.h~uml-x86-64-compilation include/asm-um/elf.h
--- linux-2.6.12/include/asm-um/elf.h~uml-x86-64-compilation	2005-05-01 20:40:52.000000000 +0200
+++ linux-2.6.12-paolo/include/asm-um/elf.h	2005-05-01 20:40:52.000000000 +0200
@@ -21,6 +21,8 @@ extern long elf_aux_hwcap;
 
 #define USE_ELF_CORE_DUMP
 
+#if defined(CONFIG_UML_X86) && !defined(CONFIG_64BIT)
+
 #define R_386_NONE	0
 #define R_386_32	1
 #define R_386_PC32	2
@@ -34,4 +36,29 @@ extern long elf_aux_hwcap;
 #define R_386_GOTPC	10
 #define R_386_NUM	11
 
+#elif defined(CONFIG_UML_X86) && defined(CONFIG_64BIT)
+
+/* x86-64 relocation types */
+#define R_X86_64_NONE		0	/* No reloc */
+#define R_X86_64_64		1	/* Direct 64 bit  */
+#define R_X86_64_PC32		2	/* PC relative 32 bit signed */
+#define R_X86_64_GOT32		3	/* 32 bit GOT entry */
+#define R_X86_64_PLT32		4	/* 32 bit PLT address */
+#define R_X86_64_COPY		5	/* Copy symbol at runtime */
+#define R_X86_64_GLOB_DAT	6	/* Create GOT entry */
+#define R_X86_64_JUMP_SLOT	7	/* Create PLT entry */
+#define R_X86_64_RELATIVE	8	/* Adjust by program base */
+#define R_X86_64_GOTPCREL	9	/* 32 bit signed pc relative
+					   offset to GOT */
+#define R_X86_64_32		10	/* Direct 32 bit zero extended */
+#define R_X86_64_32S		11	/* Direct 32 bit sign extended */
+#define R_X86_64_16		12	/* Direct 16 bit zero extended */
+#define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
+#define R_X86_64_8		14	/* Direct 8 bit sign extended  */
+#define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
+
+#define R_X86_64_NUM		16
+
+#endif
+
 #endif
_

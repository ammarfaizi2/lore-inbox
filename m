Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbUJ1RHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbUJ1RHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbUJ1RGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:06:01 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:33817 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261850AbUJ1RDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:03:02 -0400
Date: Thu, 28 Oct 2004 21:03:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: arm: use generic support for constants.h
Message-ID: <20041028190317.GE9004@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028185917.GA9004@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arm: Use new generic offset.h infrastructure
   
The symlinking taking place in include/asm-arm had to move also.
Did not have an arm toolchain to test it..
  
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff -Nru a/arch/arm/Makefile b/arch/arm/Makefile
--- a/arch/arm/Makefile	2004-10-28 20:54:28 +02:00
+++ b/arch/arm/Makefile	2004-10-28 20:54:28 +02:00
@@ -108,7 +108,7 @@
 ifeq ($(incdir-y),)
 incdir-y := $(machine-y)
 endif
-INCDIR   := arch-$(incdir-y)
+export INCDIR   := arch-$(incdir-y)
 ifneq ($(machine-y),)
 MACHINE  := arch/arm/mach-$(machine-y)/
 else
@@ -141,21 +141,7 @@
 
 boot := arch/arm/boot
 
-#	Update machine arch and proc symlinks if something which affects
-#	them changed.  We use .arch to indicate when they were updated
-#	last, otherwise make uses the target directory mtime.
-
-include/asm-arm/.arch: $(wildcard include/config/arch/*.h) include/config/MARKER
-	@echo '  SYMLINK include/asm-arm/arch -> include/asm-arm/$(INCDIR)'
-ifneq ($(KBUILD_SRC),)
-	$(Q)mkdir -p include/asm-arm
-	$(Q)ln -fsn $(srctree)/include/asm-arm/$(INCDIR) include/asm-arm/arch
-else
-	$(Q)ln -fsn $(INCDIR) include/asm-arm/arch
-endif
-	@touch $@
-
-prepare: maketools include/asm-arm/.arch
+prepare: maketools
 
 .PHONY: maketools FORCE
 maketools: include/asm-arm/constants.h include/linux/version.h FORCE
@@ -171,7 +157,7 @@
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
 CLEAN_FILES += include/asm-arm/constants.h* include/asm-arm/mach-types.h \
-	       include/asm-arm/arch include/asm-arm/.arch
+	       include/asm-arm/arch
 
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
@@ -180,12 +166,6 @@
 # My testing targets (bypasses dependencies)
 bp:;	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/bootpImage
 i zi:;	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/asm-arm/.arch
-
-include/asm-$(ARCH)/constants.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
 
 define archhelp
   echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
diff -Nru a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
--- a/arch/arm/kernel/asm-offsets.c	2004-10-28 20:54:28 +02:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,80 +0,0 @@
-/*
- * Copyright (C) 1995-2003 Russell King
- *               2001-2002 Keith Owens
- *     
- * Generate definitions needed by assembly language modules.
- * This code generates raw asm output which is post-processed to extract
- * and format the required data.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <asm/mach/arch.h>
-#include <asm/thread_info.h>
-
-/*
- * Make sure that the compiler and target are compatible.
- */
-#if defined(__APCS_26__)
-#error Sorry, your compiler targets APCS-26 but this kernel requires APCS-32
-#endif
-/*
- * GCC 2.95.1, 2.95.2: ignores register clobber list in asm().
- * GCC 3.0, 3.1: general bad code generation.
- * GCC 3.2.0: incorrect function argument offset calculation.
- * GCC 3.2.x: miscompiles NEW_AUX_ENT in fs/binfmt_elf.c
- *            (http://gcc.gnu.org/PR8896) and incorrect structure
- *	      initialisation in fs/jffs2/erase.c
- */
-#if __GNUC__ < 2 || \
-   (__GNUC__ == 2 && __GNUC_MINOR__ < 95) || \
-   (__GNUC__ == 2 && __GNUC_MINOR__ == 95 && __GNUC_PATCHLEVEL__ != 0 && \
-					     __GNUC_PATCHLEVEL__ < 3) || \
-   (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
-#error Your compiler is too buggy; it is known to miscompile kernels.
-#error    Known good compilers: 2.95.3, 2.95.4, 2.96, 3.3
-#endif
-
-/* Use marker if you need to separate the values later */
-
-#define DEFINE(sym, val) \
-        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
-
-#define BLANK() asm volatile("\n->" : : )
-
-int main(void)
-{
-  DEFINE(TSK_ACTIVE_MM,		offsetof(struct task_struct, active_mm));
-  BLANK();
-  DEFINE(TI_FLAGS,		offsetof(struct thread_info, flags));
-  DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
-  DEFINE(TI_ADDR_LIMIT,		offsetof(struct thread_info, addr_limit));
-  DEFINE(TI_TASK,		offsetof(struct thread_info, task));
-  DEFINE(TI_EXEC_DOMAIN,	offsetof(struct thread_info, exec_domain));
-  DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
-  DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
-  DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
-  DEFINE(TI_USED_CP,		offsetof(struct thread_info, used_cp));
-  DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
-  DEFINE(TI_VFPSTATE,		offsetof(struct thread_info, vfpstate));
-  DEFINE(TI_IWMMXT_STATE,	(offsetof(struct thread_info, fpstate)+4)&~7);
-  BLANK();
-#if __LINUX_ARM_ARCH__ >= 6
-  DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id));
-  BLANK();
-#endif
-  DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
-  DEFINE(VMA_VM_FLAGS,		offsetof(struct vm_area_struct, vm_flags));
-  BLANK();
-  DEFINE(VM_EXEC,	       	VM_EXEC);
-  BLANK();
-  DEFINE(PAGE_SZ,	       	PAGE_SIZE);
-  BLANK();
-  DEFINE(SYS_ERROR0,		0x9f0000);
-  BLANK();
-  DEFINE(SIZEOF_MACHINE_DESC,	sizeof(struct machine_desc));
-  return 0; 
-}
diff -Nru a/include/asm-arm/Kbuild b/include/asm-arm/Kbuild
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-arm/Kbuild	2004-10-28 20:54:28 +02:00
@@ -0,0 +1,35 @@
+# Generate header files required for $(ARCH)
+# Pull in generic stuff from include/asm-generic
+# Used to:
+# 1) Generate include/asm/offset.h
+
+# pull in generic parts
+include $(srctree)/include/asm-generic/Kbuild
+
+always  := constants.h include/asm-arm/.arch
+
+# Update machine arch and proc symlinks if something which affects
+# them changed.  We use .arch to indicate when they were updated
+# last, otherwise make uses the target directory mtime.
+
+include/asm-arm/.arch: $(wildcard include/config/arch/*.h) include/config/MARKER
+	@echo '  SYMLINK include/asm-arm/arch -> include/asm-arm/$(INCDIR)'
+ifneq ($(KBUILD_SRC),)
+	$(Q)mkdir -p include/asm-arm
+	$(Q)ln -fsn $(srctree)/include/asm-arm/$(INCDIR) include/asm-arm/arch
+else
+	$(Q)ln -fsn $(INCDIR) include/asm-arm/arch
+endif
+	@touch $@
+
+
+# generate offsets.h file
+targets := offsets.s
+
+CFLAGS_offsets.o := -I arch/$(ARCH)/kernel
+
+# explicit dependency
+$(obj)/offsets.s: include/asm-arm/.arch
+
+$(obj)/constants.h: $(obj)/offsets.s FORCE
+	$(call filechk,gen-asm-offsets, < $<)
diff -Nru a/include/asm-arm/offsets.c b/include/asm-arm/offsets.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-arm/offsets.c	2004-10-28 20:54:28 +02:00
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 1995-2003 Russell King
+ *               2001-2002 Keith Owens
+ *     
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed to extract
+ * and format the required data.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/mach/arch.h>
+#include <asm/thread_info.h>
+
+/*
+ * Make sure that the compiler and target are compatible.
+ */
+#if defined(__APCS_26__)
+#error Sorry, your compiler targets APCS-26 but this kernel requires APCS-32
+#endif
+/*
+ * GCC 2.95.1, 2.95.2: ignores register clobber list in asm().
+ * GCC 3.0, 3.1: general bad code generation.
+ * GCC 3.2.0: incorrect function argument offset calculation.
+ * GCC 3.2.x: miscompiles NEW_AUX_ENT in fs/binfmt_elf.c
+ *            (http://gcc.gnu.org/PR8896) and incorrect structure
+ *	      initialisation in fs/jffs2/erase.c
+ */
+#if __GNUC__ < 2 || \
+   (__GNUC__ == 2 && __GNUC_MINOR__ < 95) || \
+   (__GNUC__ == 2 && __GNUC_MINOR__ == 95 && __GNUC_PATCHLEVEL__ != 0 && \
+					     __GNUC_PATCHLEVEL__ < 3) || \
+   (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
+#error Your compiler is too buggy; it is known to miscompile kernels.
+#error    Known good compilers: 2.95.3, 2.95.4, 2.96, 3.3
+#endif
+
+/* Use marker if you need to separate the values later */
+
+#define DEFINE(sym, val) \
+        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+int main(void)
+{
+  DEFINE(TSK_ACTIVE_MM,		offsetof(struct task_struct, active_mm));
+  BLANK();
+  DEFINE(TI_FLAGS,		offsetof(struct thread_info, flags));
+  DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
+  DEFINE(TI_ADDR_LIMIT,		offsetof(struct thread_info, addr_limit));
+  DEFINE(TI_TASK,		offsetof(struct thread_info, task));
+  DEFINE(TI_EXEC_DOMAIN,	offsetof(struct thread_info, exec_domain));
+  DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
+  DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
+  DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
+  DEFINE(TI_USED_CP,		offsetof(struct thread_info, used_cp));
+  DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
+  DEFINE(TI_VFPSTATE,		offsetof(struct thread_info, vfpstate));
+  DEFINE(TI_IWMMXT_STATE,	(offsetof(struct thread_info, fpstate)+4)&~7);
+  BLANK();
+#if __LINUX_ARM_ARCH__ >= 6
+  DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id));
+  BLANK();
+#endif
+  DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
+  DEFINE(VMA_VM_FLAGS,		offsetof(struct vm_area_struct, vm_flags));
+  BLANK();
+  DEFINE(VM_EXEC,	       	VM_EXEC);
+  BLANK();
+  DEFINE(PAGE_SZ,	       	PAGE_SIZE);
+  BLANK();
+  DEFINE(SYS_ERROR0,		0x9f0000);
+  BLANK();
+  DEFINE(SIZEOF_MACHINE_DESC,	sizeof(struct machine_desc));
+  return 0; 
+}

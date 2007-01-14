Return-Path: <linux-kernel-owner+w=401wt.eu-S1751114AbXANFbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbXANFbr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 00:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbXANFbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 00:31:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58157 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbXANFbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 00:31:46 -0500
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/11] Fix CONFIG_COMPAT_VDSO
X-Zippy-Says: If I had a Q-TIP, I could prevent th'collapse of NEGOTIATIONS!!
Message-Id: <20070114053140.351701800E5@magilla.sf.frob.com>
Date: Sat, 13 Jan 2007 21:31:39 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wouldn't mind if CONFIG_COMPAT_VDSO went away entirely.
But if it's there, it should work properly.  Currently
it's quite haphazard: both real vma and fixmap are
mapped, both are put in the two different AT_* slots,
sysenter returns to the vma address rather than the
fixmap address, and core dumps yet are another story.

This patch makes CONFIG_COMPAT_VDSO disable the real vma
and use the fixmap area consistently.  This makes it
actually compatible with what the old vdso implementation did.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/i386/kernel/entry.S    |    4 ++++
 arch/i386/kernel/sysenter.c |    2 ++
 include/asm-i386/elf.h      |    7 +++----
 include/asm-i386/fixmap.h   |    2 ++
 include/asm-i386/page.h     |    2 ++
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
index 06461b8..5e47683 100644  
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -302,12 +302,16 @@ sysenter_past_esp:
 	pushl $(__USER_CS)
 	CFI_ADJUST_CFA_OFFSET 4
 	/*CFI_REL_OFFSET cs, 0*/
+#ifndef CONFIG_COMPAT_VDSO
 	/*
 	 * Push current_thread_info()->sysenter_return to the stack.
 	 * A tiny bit of offset fixup is necessary - 4*4 means the 4 words
 	 * pushed above; +8 corresponds to copy_thread's esp0 setting.
 	 */
 	pushl (TI_sysenter_return-THREAD_SIZE+8+4*4)(%esp)
+#else
+	pushl $SYSENTER_RETURN
+#endif
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET eip, 0
 
diff --git a/arch/i386/kernel/sysenter.c b/arch/i386/kernel/sysenter.c
index 7de9117..454d12d 100644  
--- a/arch/i386/kernel/sysenter.c
+++ b/arch/i386/kernel/sysenter.c
@@ -100,6 +100,7 @@ int __init sysenter_setup(void)
 	return 0;
 }
 
+#ifndef CONFIG_COMPAT_VDSO
 static struct page *syscall_nopage(struct vm_area_struct *vma,
 				unsigned long adr, int *type)
 {
@@ -187,3 +188,4 @@ int in_gate_area_no_task(unsigned long a
 {
 	return 0;
 }
+#endif
diff --git a/include/asm-i386/elf.h b/include/asm-i386/elf.h
index 45d21a0..0515d61 100644  
--- a/include/asm-i386/elf.h
+++ b/include/asm-i386/elf.h
@@ -143,11 +143,8 @@ extern int dump_task_extended_fpu (struc
 # define VDSO_PRELINK		0
 #endif
 
-#define VDSO_COMPAT_SYM(x) \
-		(VDSO_COMPAT_BASE + (unsigned long)(x) - VDSO_PRELINK)
-
 #define VDSO_SYM(x) \
-		(VDSO_BASE + (unsigned long)(x) - VDSO_PRELINK)
+		(VDSO_COMPAT_BASE + (unsigned long)(x) - VDSO_PRELINK)
 
 #define VDSO_HIGH_EHDR		((const struct elfhdr *) VDSO_HIGH_BASE)
 #define VDSO_EHDR		((const struct elfhdr *) VDSO_COMPAT_BASE)
@@ -156,10 +153,12 @@ extern void __kernel_vsyscall;
 
 #define VDSO_ENTRY		VDSO_SYM(&__kernel_vsyscall)
 
+#ifndef CONFIG_COMPAT_VDSO
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
                                        int executable_stack);
+#endif
 
 extern unsigned int vdso_enabled;
 
diff --git a/include/asm-i386/fixmap.h b/include/asm-i386/fixmap.h
index 02428cb..3e9f610 100644  
--- a/include/asm-i386/fixmap.h
+++ b/include/asm-i386/fixmap.h
@@ -23,6 +23,8 @@
 extern unsigned long __FIXADDR_TOP;
 #else
 #define __FIXADDR_TOP  0xfffff000
+#define FIXADDR_USER_START	__fix_to_virt(FIX_VDSO)
+#define FIXADDR_USER_END	__fix_to_virt(FIX_VDSO - 1)
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/include/asm-i386/page.h b/include/asm-i386/page.h
index fd3f64a..7b19f45 100644  
--- a/include/asm-i386/page.h
+++ b/include/asm-i386/page.h
@@ -143,7 +143,9 @@ extern int page_is_ram(unsigned long pag
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#ifndef CONFIG_COMPAT_VDSO
 #define __HAVE_ARCH_GATE_AREA 1
+#endif
 #endif /* __KERNEL__ */
 
 #endif /* _I386_PAGE_H */

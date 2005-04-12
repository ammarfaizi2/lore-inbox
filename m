Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVDLT44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVDLT44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVDLTzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:55:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:44232 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262158AbVDLKbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:47 -0400
Message-Id: <200504121031.j3CAVTX0005324@shell0.pdx.osdl.net>
Subject: [patch 050/198] ppc64: Improve mapping of vDSO
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benh@kernel.crashing.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch reworks the way the ppc64 is mapped in user memory by the kernel
to make it more robust against possible collisions with executable
segments.  Instead of just whacking a VMA at 1Mb, I now use
get_unmapped_area() with a hint, and I moved the mapping of the vDSO to
after the mapping of the various ELF segments and of the interpreter, so
that conflicts get caught properly (it still has to be before
create_elf_tables since the later will fill the AT_SYSINFO_EHDR with the
proper address).

While I was at it, I also changed the 32 and 64 bits vDSO's to link at
their "natural" address of 1Mb instead of 0.  This is the address where
they are normally mapped in absence of conflict.  By doing so, it should be
possible to properly prelink one it's been verified to work on glibc.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc64/kernel/vdso.c |   19 ++++++++++++-------
 25-akpm/fs/binfmt_elf.c          |   16 ++++++++--------
 25-akpm/include/asm-ppc64/vdso.h |    8 ++++----
 3 files changed, 24 insertions(+), 19 deletions(-)

diff -puN arch/ppc64/kernel/vdso.c~ppc64-improve-mapping-of-vdso arch/ppc64/kernel/vdso.c
--- 25/arch/ppc64/kernel/vdso.c~ppc64-improve-mapping-of-vdso	2005-04-12 03:21:15.474784376 -0700
+++ 25-akpm/arch/ppc64/kernel/vdso.c	2005-04-12 03:21:15.480783464 -0700
@@ -213,13 +213,14 @@ int arch_setup_additional_pages(struct l
 		vdso_base = VDSO64_MBASE;
 	}
 
+	current->thread.vdso_base = 0;
+
 	/* vDSO has a problem and was disabled, just don't "enable" it for the
 	 * process
 	 */
-	if (vdso_pages == 0) {
-		current->thread.vdso_base = 0;
+	if (vdso_pages == 0)
 		return 0;
-	}
+
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (vma == NULL)
 		return -ENOMEM;
@@ -230,12 +231,16 @@ int arch_setup_additional_pages(struct l
 	memset(vma, 0, sizeof(*vma));
 
 	/*
-	 * pick a base address for the vDSO in process space. We have a default
-	 * base of 1Mb on which we had a random offset up to 1Mb.
-	 * XXX: Add possibility for a program header to specify that location
+	 * pick a base address for the vDSO in process space. We try to put it
+	 * at vdso_base which is the "natural" base for it, but we might fail
+	 * and end up putting it elsewhere.
 	 */
+	vdso_base = get_unmapped_area(NULL, vdso_base,
+				      vdso_pages << PAGE_SHIFT, 0, 0);
+	if (vdso_base & ~PAGE_MASK)
+		return (int)vdso_base;
+
 	current->thread.vdso_base = vdso_base;
-	/*  + ((unsigned long)vma & 0x000ff000); */
 
 	vma->vm_mm = mm;
 	vma->vm_start = current->thread.vdso_base;
diff -puN fs/binfmt_elf.c~ppc64-improve-mapping-of-vdso fs/binfmt_elf.c
--- 25/fs/binfmt_elf.c~ppc64-improve-mapping-of-vdso	2005-04-12 03:21:15.475784224 -0700
+++ 25-akpm/fs/binfmt_elf.c	2005-04-12 03:21:15.482783160 -0700
@@ -782,14 +782,6 @@ static int load_elf_binary(struct linux_
 		goto out_free_dentry;
 	}
 	
-#ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
-	retval = arch_setup_additional_pages(bprm, executable_stack);
-	if (retval < 0) {
-		send_sig(SIGKILL, current, 0);
-		goto out_free_dentry;
-	}
-#endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
-
 	current->mm->start_stack = bprm->p;
 
 	/* Now we do a little grungy work by mmaping the ELF image into
@@ -949,6 +941,14 @@ static int load_elf_binary(struct linux_
 
 	set_binfmt(&elf_format);
 
+#ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
+	retval = arch_setup_additional_pages(bprm, executable_stack);
+	if (retval < 0) {
+		send_sig(SIGKILL, current, 0);
+		goto out_free_dentry;
+	}
+#endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
+
 	compute_creds(bprm);
 	current->flags &= ~PF_FORKNOEXEC;
 	create_elf_tables(bprm, &loc->elf_ex, (interpreter_type == INTERPRETER_AOUT),
diff -puN include/asm-ppc64/vdso.h~ppc64-improve-mapping-of-vdso include/asm-ppc64/vdso.h
--- 25/include/asm-ppc64/vdso.h~ppc64-improve-mapping-of-vdso	2005-04-12 03:21:15.477783920 -0700
+++ 25-akpm/include/asm-ppc64/vdso.h	2005-04-12 03:21:15.482783160 -0700
@@ -4,12 +4,12 @@
 #ifdef __KERNEL__
 
 /* Default link addresses for the vDSOs */
-#define VDSO32_LBASE	0
-#define VDSO64_LBASE	0
+#define VDSO32_LBASE	0x100000
+#define VDSO64_LBASE	0x100000
 
 /* Default map addresses */
-#define VDSO32_MBASE	0x100000
-#define VDSO64_MBASE	0x100000
+#define VDSO32_MBASE	VDSO32_LBASE
+#define VDSO64_MBASE	VDSO64_LBASE
 
 #define VDSO_VERSION_STRING	LINUX_2.6.12
 
_

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbTK3QnO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 11:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbTK3QnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 11:43:14 -0500
Received: from holomorphy.com ([199.26.172.102]:10183 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264936AbTK3QnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 11:43:04 -0500
Date: Sun, 30 Nov 2003 08:43:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.6.0-test5-bk3-17
Message-ID: <20031130164301.GK8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031128041558.GW19856@holomorphy.com> <20031128072148.GY8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128072148.GY8039@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 27, 2003 at 11:21:48PM -0800, William Lee Irwin III wrote:
> Now also ported to 2.6.0-test11:
> ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/pgcl-2.6.0-test11-1.gz
> This also corrects some PAGE_SHIFT instances that crept into mm/mmap.c
> while I wasn't looking and drops sym2 driver changes.

I wonder if this would be enough to get sysenter support going again.
I've not got a sysenter-capable userspace around, so I can't really
test this myself.

vs. pgcl-2.6.0-test11-5


-- wli


diff -prauN pgcl-2.6.0-test11-5/include/asm-i386/elf.h pgcl-2.6.0-test11-6/include/asm-i386/elf.h
--- pgcl-2.6.0-test11-5/include/asm-i386/elf.h	2003-11-27 21:55:19.000000000 -0800
+++ pgcl-2.6.0-test11-6/include/asm-i386/elf.h	2003-11-30 07:34:34.000000000 -0800
@@ -132,17 +132,11 @@ extern int dump_task_extended_fpu (struc
 #define VSYSCALL_ENTRY	((unsigned long) &__kernel_vsyscall)
 extern void __kernel_vsyscall;
 
-/*
- * Something in pgcl broke vsyscalls. Until that's tracked down,
- * work around it with this:
- */
-#if 0
 #define ARCH_DLINFO						\
 do {								\
 		NEW_AUX_ENT(AT_SYSINFO,	VSYSCALL_ENTRY);	\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR, VSYSCALL_BASE);	\
 } while (0)
-#endif /* 0 */
 
 /*
  * These macros parameterize elf_core_dump in fs/binfmt_elf.c to write out
@@ -152,7 +146,6 @@ do {								\
  * Dumping its extra ELF program headers includes all the other information
  * a debugger needs to easily find how the vsyscall DSO was being used.
  */
-#if 0
 #define ELF_CORE_EXTRA_PHDRS		(VSYSCALL_EHDR->e_phnum)
 #define ELF_CORE_WRITE_EXTRA_PHDRS					      \
 do {									      \
@@ -166,7 +159,7 @@ do {									      \
 		if (phdr.p_type == PT_LOAD) {				      \
 			BUG_ON(ofs != 0);				      \
 			ofs = phdr.p_offset = offset;			      \
-			phdr.p_memsz = PAGE_ALIGN(phdr.p_memsz);	      \
+			phdr.p_memsz = MMUPAGE_ALIGN(phdr.p_memsz);	      \
 			phdr.p_filesz = phdr.p_memsz;			      \
 			offset += phdr.p_filesz;			      \
 		}							      \
@@ -185,10 +178,9 @@ do {									      \
 	for (i = 0; i < VSYSCALL_EHDR->e_phnum; ++i) {			      \
 		if (vsyscall_phdrs[i].p_type == PT_LOAD)		      \
 			DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,	      \
-				   PAGE_ALIGN(vsyscall_phdrs[i].p_memsz));    \
+				   MMUPAGE_ALIGN(vsyscall_phdrs[i].p_memsz)); \
 	}								      \
 } while (0)
-#endif /* 0 */
 
 #endif /* __KERNEL__ */
 
diff -prauN pgcl-2.6.0-test11-5/include/asm-i386/fixmap.h pgcl-2.6.0-test11-6/include/asm-i386/fixmap.h
--- pgcl-2.6.0-test11-5/include/asm-i386/fixmap.h	2003-11-27 21:55:19.000000000 -0800
+++ pgcl-2.6.0-test11-6/include/asm-i386/fixmap.h	2003-11-30 06:39:57.000000000 -0800
@@ -21,6 +21,11 @@
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
+#ifdef CONFIG_HIGHMEM4G
+#include <asm/pgtable-2level.h>
+#else
+#include <asm/pgtable-3level.h>
+#endif
 #endif
 
 /*
@@ -49,6 +54,7 @@
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 #define LAST_PKMAP	1024
 #define LAST_PKMAP_MASK	(LAST_PKMAP-1)
+#define PKMAP_MASK	(~((1 << PMD_SHIFT) - 1))
 
 /*
  * FIXADDR stuff is used by highmem.c for kmapping, and various
@@ -62,7 +68,7 @@
  * and I didn't care enough to conserve PAGE_SIZE - MMUPAGE_SIZE
  * worth of virtualspace.
  */
-#define FIXADDR_TOP	(-PAGE_SIZE)
+#define FIXADDR_TOP	(-MMUPAGE_SIZE)
 #define __FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << MMUPAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - __FIXADDR_SIZE)
 
@@ -70,13 +76,8 @@
 #define __virt_to_fix(x)	((FIXADDR_TOP - ((x) & MMUPAGE_MASK)) >> MMUPAGE_SHIFT)
 
 enum fixed_addresses {
-#ifdef CONFIG_HIGHMEM
 	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_BEGIN = 1,
-	FIX_KMAP_END = FIX_KMAP_BEGIN+((KM_TYPE_NR*NR_CPUS+1)*PAGE_MMUCOUNT)-1,
-	FIX_PKMAP_BEGIN,
-	FIX_PKMAP_END = FIX_PKMAP_BEGIN + (LAST_PKMAP+1)*PAGE_MMUCOUNT - 1,
-#endif
+	FIX_HOLE,
 	FIX_VSYSCALL,
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
@@ -107,6 +108,12 @@ enum fixed_addresses {
 	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
 	FIX_BTMAP_BEGIN = FIX_BTMAP_END + NR_FIX_BTMAPS - 1,
 	FIX_WP_TEST,
+#ifdef CONFIG_HIGHMEM
+	FIX_KMAP_BEGIN = __virt_to_fix(__fix_to_virt(FIX_WP_TEST+1) & PAGE_MASK) - PAGE_MMUCOUNT + 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN+((KM_TYPE_NR*NR_CPUS+1)*PAGE_MMUCOUNT)-1,
+	FIX_PKMAP_BEGIN = __virt_to_fix(__fix_to_virt(FIX_KMAP_END+1) & PKMAP_MASK) - PAGE_MMUCOUNT + 1,
+	FIX_PKMAP_END = FIX_PKMAP_BEGIN + (LAST_PKMAP+1)*PAGE_MMUCOUNT - 1,
+#endif
 	__end_of_fixed_addresses
 };
 
@@ -129,7 +136,7 @@ extern void __set_fixmap (enum fixed_add
  * acting like user mode such as get_user_pages.
  */
 #define FIXADDR_USER_START	(__fix_to_virt(FIX_VSYSCALL))
-#define FIXADDR_USER_END	(FIXADDR_USER_START + PAGE_SIZE)
+#define FIXADDR_USER_END	(FIXADDR_USER_START + MMUPAGE_SIZE)
 
 
 extern void __this_fixmap_does_not_exist(void);

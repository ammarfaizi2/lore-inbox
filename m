Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbULCT1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbULCT1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbULCT1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:27:10 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:6404
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262466AbULCT0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:26:44 -0500
Message-Id: <200412032142.iB3LgeZW004651@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - make vsyscall page into process page tables
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:42:40 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser:

To make the vsyscall-page available for copy_from_user() and
ptrace(), we should use kernel's "gate-vma" mechanism.
Therefore we need a valid page structure. To have this, one
page (or more) is allocated at boot time, the contents of the
vsyscall-page is copied into this page and the page's pte is
inserted in swapper's pagetables.
Now it will be copied into the pagetables of all processes.

Note: this alone doesn't work, since FIXADDR_USER_START and
      FIXADDR_USER_END are not yet defined correctly. Also
      access_ok_skas() does not yet grant read accesses to
      pages not in the normal user area.

Risks:
Please check the first hunk! I don't know, whether this change is OK.
Maybe fixrange_init() is wrong anyway with 3-level-pagetables?

Here access_ok_skas() and FIXADDR_USER_XXXX are fixed.
Now everything should work fine, while the processes are
running. But if a process crashes, the vsyscall-page will
not be dumped.

Signed-off-by: Bodo Stroesser <bodo.stroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/mem.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/mem.c	2004-12-03 12:21:11.000000000 -0500
+++ 2.6.9/arch/um/kernel/mem.c	2004-12-03 12:42:11.000000000 -0500
@@ -174,6 +174,29 @@
 }
 #endif /* CONFIG_HIGHMEM */
 
+static void __init fixaddr_user_init( void)
+{
+	long size = FIXADDR_USER_END - FIXADDR_USER_START;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	unsigned long paddr, vaddr = FIXADDR_USER_START;
+
+	if (  ! size )
+		return;
+
+	fixrange_init( FIXADDR_USER_START, FIXADDR_USER_END, swapper_pg_dir);
+	paddr = (unsigned long)alloc_bootmem_low_pages( size);
+	memcpy( (void *)paddr, (void *)FIXADDR_USER_START, size);
+	paddr = __pa(paddr);
+	for ( ; size > 0; size-=PAGE_SIZE, vaddr+=PAGE_SIZE, paddr+=PAGE_SIZE) {
+		pgd = swapper_pg_dir + pgd_index(vaddr);
+		pmd = pmd_offset(pgd, vaddr);
+		pte = pte_offset_kernel(pmd, vaddr);
+		pte_set_val( (*pte), paddr, PAGE_READONLY);
+	}
+}
+
 void paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES], vaddr;
@@ -194,6 +217,8 @@
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
 	fixrange_init(vaddr, FIXADDR_TOP, swapper_pg_dir);
 
+	fixaddr_user_init();
+
 #ifdef CONFIG_HIGHMEM
 	init_highmem();
 #endif
Index: 2.6.9/arch/um/kernel/skas/include/uaccess-skas.h
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/include/uaccess-skas.h	2004-12-03 12:21:11.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/include/uaccess-skas.h	2004-12-03 12:42:11.000000000 -0500
@@ -7,11 +7,16 @@
 #define __SKAS_UACCESS_H
 
 #include "asm/errno.h"
+#include "asm/fixmap.h"
 
 #define access_ok_skas(type, addr, size) \
 	((segment_eq(get_fs(), KERNEL_DS)) || \
 	 (((unsigned long) (addr) < TASK_SIZE) && \
-	  ((unsigned long) (addr) + (size) <= TASK_SIZE)))
+	  ((unsigned long) (addr) + (size) <= TASK_SIZE)) || \
+	 ((type == VERIFY_READ ) && \
+	  (size <= (FIXADDR_USER_END - FIXADDR_USER_START)) && \
+	  ((unsigned long) (addr) >= FIXADDR_USER_START) && \
+	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END)))
 
 static inline int verify_area_skas(int type, const void * addr,
 				   unsigned long size)
Index: 2.6.9/include/asm-um/fixmap.h
===================================================================
--- 2.6.9.orig/include/asm-um/fixmap.h	2004-12-03 12:21:11.000000000 -0500
+++ 2.6.9/include/asm-um/fixmap.h	2004-12-03 12:23:03.000000000 -0500
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <asm/kmap_types.h>
+#include <asm/archparam.h>
 
 /*
  * Here we define all the compile-time 'special' virtual
@@ -34,7 +35,6 @@
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
-	FIX_VSYSCALL,
 	__end_of_fixed_addresses
 };
 
@@ -68,8 +68,8 @@
  * This is the range that is readable by user mode, and things
  * acting like user mode such as get_user_pages.
  */
-#define FIXADDR_USER_START	(__fix_to_virt(FIX_VSYSCALL))
-#define FIXADDR_USER_END	(FIXADDR_USER_START + PAGE_SIZE)
+#define FIXADDR_USER_START	VSYSCALL_BASE
+#define FIXADDR_USER_END	VSYSCALL_END
 
 extern void __this_fixmap_does_not_exist(void);
 
Index: 2.6.9/include/asm-um/pgtable.h
===================================================================
--- 2.6.9.orig/include/asm-um/pgtable.h	2004-12-01 23:43:12.000000000 -0500
+++ 2.6.9/include/asm-um/pgtable.h	2004-12-03 12:38:49.000000000 -0500
@@ -355,6 +355,8 @@
 
 extern pte_t mk_pte(struct page *page, pgprot_t pgprot);
 
+#define pte_set_val(p, phys, prot) pte_val(p) = (phys | pgprot_val(prot))
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);


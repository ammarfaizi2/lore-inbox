Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264157AbVBDUER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264157AbVBDUER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265616AbVBDUCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:02:36 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:19204 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S266789AbVBDUAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:00:35 -0500
Subject: [patch 6/8] uml: fix broken #ifdef clause causing crashes [before 2.6.11]
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 04 Feb 2005 19:35:53 +0100
Message-Id: <20050204183553.71E3C310C1@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>

The previous ifdef to check whether to use the host's vsyscall page 
was buggy. This bug can cause crashes.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig_i386   |    4 ++++
 linux-2.6.11-paolo/arch/um/Kconfig_x86_64 |    4 ++++
 linux-2.6.11-paolo/arch/um/kernel/mem.c   |   12 ++++++++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff -puN arch/um/Kconfig_i386~uml-vsyscall arch/um/Kconfig_i386
--- linux-2.6.11/arch/um/Kconfig_i386~uml-vsyscall	2005-02-04 06:22:14.731673232 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig_i386	2005-02-04 06:22:14.738672168 +0100
@@ -18,3 +18,7 @@ config 3_LEVEL_PGTABLES
 config ARCH_HAS_SC_SIGNALS
 	bool
 	default y
+
+config ARCH_REUSE_HOST_VSYSCALL_AREA
+	bool
+	default y
diff -puN arch/um/Kconfig_x86_64~uml-vsyscall arch/um/Kconfig_x86_64
--- linux-2.6.11/arch/um/Kconfig_x86_64~uml-vsyscall	2005-02-04 06:22:14.733672928 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig_x86_64	2005-02-04 06:22:14.739672016 +0100
@@ -9,3 +9,7 @@ config 3_LEVEL_PGTABLES
 config ARCH_HAS_SC_SIGNALS
 	bool
 	default n
+
+config ARCH_REUSE_HOST_VSYSCALL_AREA
+	bool
+	default n
diff -puN arch/um/kernel/mem.c~uml-vsyscall arch/um/kernel/mem.c
--- linux-2.6.11/arch/um/kernel/mem.c~uml-vsyscall	2005-02-04 06:22:14.735672624 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/mem.c	2005-02-04 06:22:14.739672016 +0100
@@ -152,6 +152,7 @@ void __init kmap_init(void)
 static void init_highmem(void)
 {
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long vaddr;
@@ -163,7 +164,8 @@ static void init_highmem(void)
 	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, swapper_pg_dir);
 
 	pgd = swapper_pg_dir + pgd_index(vaddr);
-	pmd = pmd_offset(pgd, vaddr);
+	pud = pud_offset(pgd, vaddr);
+	pmd = pmd_offset(pud, vaddr);
 	pte = pte_offset_kernel(pmd, vaddr);
 	pkmap_page_table = pte;
 
@@ -173,9 +175,10 @@ static void init_highmem(void)
 
 static void __init fixaddr_user_init( void)
 {
-#if FIXADDR_USER_START != 0
+#if CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
 	long size = FIXADDR_USER_END - FIXADDR_USER_START;
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long paddr, vaddr = FIXADDR_USER_START;
@@ -187,9 +190,10 @@ static void __init fixaddr_user_init( vo
 	paddr = (unsigned long)alloc_bootmem_low_pages( size);
 	memcpy( (void *)paddr, (void *)FIXADDR_USER_START, size);
 	paddr = __pa(paddr);
-	for ( ; size > 0; size-=PAGE_SIZE, vaddr+=PAGE_SIZE, paddr+=PAGE_SIZE) {
+	for ( ; size > 0; size-=PAGE_SIZE, vaddr+=PAGE_SIZE, paddr+=PAGE_SIZE){
 		pgd = swapper_pg_dir + pgd_index(vaddr);
-		pmd = pmd_offset(pgd, vaddr);
+		pud = pud_offset(pgd, vaddr);
+		pmd = pmd_offset(pud, vaddr);
 		pte = pte_offset_kernel(pmd, vaddr);
 		pte_set_val( (*pte), paddr, PAGE_READONLY);
 	}
_

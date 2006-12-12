Return-Path: <linux-kernel-owner+w=401wt.eu-S932233AbWLLRPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWLLRPx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWLLRPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:15:18 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:34651 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216AbWLLRPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:15:07 -0500
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/4] MIPS: Fix COW D-cache aliasing on fork
Date: Tue, 12 Dec 2006 17:14:56 +0000
Message-Id: <11659437004086-git-send-email-ralf@linux-mips.org>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11659436971966-git-send-email-ralf@linux-mips.org>
References: <11659436971966-git-send-email-ralf@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Provide a custom copy_user_highpage() to deal with aliasing issues on
MIPS.  It uses kmap_coherent() to map an user page for kernel with same
color.  Rewrite copy_to_user_page() and copy_from_user_page() with the
new interfaces to avoid extra cache flushing.

The main part of this patch was originally written by Ralf Baechle;
Atushi Nemoto did the the debugging.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/mm/init.c     |   25 +++++++++++++++++++++++++
 include/asm-mips/page.h |   16 ++++++----------
 2 files changed, 31 insertions(+), 10 deletions(-)

Index: upstream-alias/arch/mips/mm/init.c
===================================================================
--- upstream-alias.orig/arch/mips/mm/init.c
+++ upstream-alias/arch/mips/mm/init.c
@@ -203,6 +203,31 @@ static inline void kunmap_coherent(struc
 	preempt_check_resched();
 }
 
+void copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma)
+{
+	void *vfrom, *vto;
+
+	vto = kmap_atomic(to, KM_USER1);
+	if (cpu_has_dc_aliases) {
+		vfrom = kmap_coherent(from, vaddr);
+		copy_page(vto, vfrom);
+		kunmap_coherent(from);
+	} else {
+		vfrom = kmap_atomic(from, KM_USER0);
+		copy_page(vto, vfrom);
+		kunmap_atomic(vfrom, KM_USER0);
+	}
+	if (((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc) ||
+	    pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))
+		flush_data_cache_page((unsigned long)vto);
+	kunmap_atomic(vto, KM_USER1);
+	/* Make sure this page is cleared on other CPU's too before using it */
+	smp_wmb();
+}
+
+EXPORT_SYMBOL(copy_user_highpage);
+
 void copy_to_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
 	unsigned long len)
Index: upstream-alias/include/asm-mips/page.h
===================================================================
--- upstream-alias.orig/include/asm-mips/page.h
+++ upstream-alias/include/asm-mips/page.h
@@ -35,7 +35,6 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/pfn.h>
-#include <asm/cpu-features.h>
 #include <asm/io.h>
 
 extern void clear_page(void * page);
@@ -61,16 +60,13 @@ static inline void clear_user_page(void 
 		flush_data_cache_page((unsigned long)addr);
 }
 
-static inline void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
-	struct page *to)
-{
-	extern void (*flush_data_cache_page)(unsigned long addr);
+extern void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
+	struct page *to);
+struct vm_area_struct;
+extern void copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma);
 
-	copy_page(vto, vfrom);
-	if (!cpu_has_ic_fills_f_dc ||
-	    pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))
-		flush_data_cache_page((unsigned long)vto);
-}
+#define __HAVE_ARCH_COPY_USER_HIGHPAGE
 
 /*
  * These are used to make use of C type-checking..

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWJVCcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWJVCcj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 22:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWJVCcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 22:32:39 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:44441 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751758AbWJVCci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 22:32:38 -0400
Date: Sun, 22 Oct 2006 03:32:59 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 3/3] MIPS: Fix COW D-cache aliasing on fork
Message-ID: <20061022023259.GA7258@linux-mips.org>
References: <1161275748231-git-send-email-ralf@linux-mips.org> <1161275750378-git-send-email-ralf@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161275750378-git-send-email-ralf@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With parts of the previous patch 3/3 just having been applied this new
patch replaces it.

< ---- snip ---- >

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

MIPS: Fix COW D-cache aliasing on fork

Provide a custom copy_user_highpage() to deal with aliasing issues on
MIPS.  It uses kmap_coherent() to map an user page for kernel with same
color.

The main part of this patch was originally written by Ralf Baechle;
Atushi Nemoto did the the debugging.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/mm/init.c     |   25 +++++++++++++++++++++++++
 include/asm-mips/page.h |   17 ++++++-----------
 2 files changed, 31 insertions(+), 11 deletions(-)

Index: upstream-alias/arch/mips/mm/init.c
===================================================================
--- upstream-alias.orig/arch/mips/mm/init.c	2006-10-22 03:08:41.000000000 +0100
+++ upstream-alias/arch/mips/mm/init.c	2006-10-22 03:08:45.000000000 +0100
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
--- upstream-alias.orig/include/asm-mips/page.h	2006-10-22 03:08:41.000000000 +0100
+++ upstream-alias/include/asm-mips/page.h	2006-10-22 03:08:45.000000000 +0100
@@ -34,8 +34,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <asm/cpu-features.h>
-
 extern void clear_page(void * page);
 extern void copy_page(void * to, void * from);
 
@@ -59,16 +57,13 @@ static inline void clear_user_page(void 
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

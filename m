Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUEKAHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUEKAHJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 20:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUEKAHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 20:07:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17291 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261779AbUEKAHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 20:07:00 -0400
Date: Mon, 10 May 2004 17:05:11 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] PPC32: Fix __flush_dcache_icache_phys() for Book E
Message-ID: <20040510170511.A26495@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements/uses __flush_dcache_icache_page() which
kmaps on a Book E part, but keeps the existing behavior on other
PowerPCs which can disable the MMU. Please apply.
 
-Matt

diff -Nru a/arch/ppc/mm/fault.c b/arch/ppc/mm/fault.c
--- a/arch/ppc/mm/fault.c	Mon May 10 15:25:17 2004
+++ b/arch/ppc/mm/fault.c	Mon May 10 15:25:17 2004
@@ -227,8 +227,7 @@
 			struct page *page = pte_page(*ptep);
 
 			if (! test_bit(PG_arch_1, &page->flags)) {
-				unsigned long phys = page_to_pfn(page) << PAGE_SHIFT;
-				__flush_dcache_icache_phys(phys);
+				flush_dcache_icache_page(page);
 				set_bit(PG_arch_1, &page->flags);
 			}
 			pte_update(ptep, 0, _PAGE_HWEXEC);
diff -Nru a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
--- a/arch/ppc/mm/init.c	Mon May 10 15:25:17 2004
+++ b/arch/ppc/mm/init.c	Mon May 10 15:25:17 2004
@@ -572,6 +572,16 @@
 	clear_bit(PG_arch_1, &page->flags);
 }
 
+void flush_dcache_icache_page(struct page *page)
+{
+#ifdef CONFIG_BOOKE
+	__flush_dcache_icache(kmap(page));
+	kunmap(page);
+#else
+	__flush_dcache_icache_phys(page_to_pfn(page) << PAGE_SHIFT);
+#endif
+
+}
 void clear_user_page(void *page, unsigned long vaddr, struct page *pg)
 {
 	clear_page(page);
@@ -614,7 +624,7 @@
 			if (vma->vm_mm == current->active_mm)
 				__flush_dcache_icache((void *) address);
 			else
-				__flush_dcache_icache_phys(pfn << PAGE_SHIFT);
+				flush_dcache_icache_page(page);
 			set_bit(PG_arch_1, &page->flags);
 		}
 	}
diff -Nru a/include/asm-ppc/cacheflush.h b/include/asm-ppc/cacheflush.h
--- a/include/asm-ppc/cacheflush.h	Mon May 10 15:25:17 2004
+++ b/include/asm-ppc/cacheflush.h	Mon May 10 15:25:17 2004
@@ -41,6 +41,6 @@
 
 extern void __flush_dcache_icache(void *page_va);
 extern void __flush_dcache_icache_phys(unsigned long physaddr);
-
+extern void flush_dcache_icache_page(struct page *page);
 #endif /* _PPC_CACHEFLUSH_H */
 #endif /* __KERNEL__ */

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUEKA36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUEKA36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 20:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUEKA27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 20:28:59 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:1839
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S261862AbUEKA1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 20:27:19 -0400
thread-index: AcQ27yUjzxrCIWJUSbWTskJ/QAH1pQ==
X-Sieve: Server Sieve 2.2
Date: Tue, 11 May 2004 01:30:22 +0100
From: "Matt Porter" <mporter@kernel.crashing.org>
To: <Administrator@vger.kernel.org>
Message-ID: <000001c436ef$252630c0$d100000a@sbs2003.local>
Cc: <paulus@samba.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>
Content-Transfer-Encoding: 7bit
Subject: [PATCH] PPC32: Fix __flush_dcache_icache_phys() for Book E
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
X-Mailer: Microsoft CDO for Exchange 2000
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Envelope-to: paul@sumlocktest.fsnet.co.uk
X-me-spamlevel: not-spam
Content-Class: urn:content-classes:message
Importance: normal
X-me-spamrating: 46.777916
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.132
X-OriginalArrivalTime: 11 May 2004 00:30:22.0359 (UTC) FILETIME=[25452A70:01C436EF]
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

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/



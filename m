Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310809AbSCMQuy>; Wed, 13 Mar 2002 11:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310799AbSCMQuq>; Wed, 13 Mar 2002 11:50:46 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:22535 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S310796AbSCMQug>; Wed, 13 Mar 2002 11:50:36 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 13 Mar 2002 17:51:22 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] vmalloc_to_page() backport for 2.4
Message-ID: <20020313175122.C7949@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a 2.4.x backport of the new 2.5.x vmalloc_to_page() function.
I'd like to see that function in 2.4.x too because it makes driver
maintaining easier.

  Gerd

==============================[ cut here ]==============================
--- linux-2.4.19-pre3/include/linux/mm.h	Tue Mar 12 09:59:02 2002
+++ linux/include/linux/mm.h	Tue Mar 12 18:15:02 2002
@@ -670,6 +670,8 @@
 
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
 
+extern struct page * vmalloc_to_page(void *addr);
+
 #endif /* __KERNEL__ */
 
 #endif
--- linux-2.4.19-pre3/kernel/ksyms.c	Tue Mar 12 10:00:44 2002
+++ linux/kernel/ksyms.c	Tue Mar 12 10:00:44 2002
@@ -108,6 +108,7 @@
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
+EXPORT_SYMBOL_GPL(vmalloc_to_page);
 EXPORT_SYMBOL(mem_map);
 EXPORT_SYMBOL(remap_page_range);
 EXPORT_SYMBOL(max_mapnr);
--- linux-2.4.19-pre3/mm/memory.c	Tue Mar 12 09:59:02 2002
+++ linux/mm/memory.c	Tue Mar 12 10:00:44 2002
@@ -1471,3 +1471,24 @@
 			len, write, 0, NULL, NULL);
 	return ret == len ? 0 : -1;
 }
+
+struct page * vmalloc_to_page(void * vmalloc_addr)
+{
+	unsigned long addr = (unsigned long) vmalloc_addr;
+	struct page *page = NULL;
+	pmd_t *pmd;
+	pte_t *pte;
+	pgd_t *pgd;
+	
+	pgd = pgd_offset_k(addr);
+	if (!pgd_none(*pgd)) {
+		pmd = pmd_offset(pgd, addr);
+		if (!pmd_none(*pmd)) {
+			pte = pte_offset(pmd, addr);
+			if (pte_present(*pte)) {
+				page = pte_page(*pte);
+			}
+		}
+	}
+	return page;
+}

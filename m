Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWBQTNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWBQTNJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWBQTNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:13:09 -0500
Received: from verein.lst.de ([213.95.11.210]:44699 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751311AbWBQTNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:13:08 -0500
Date: Fri, 17 Feb 2006 20:12:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, lethal@linux-sh.org, rc@rc0.org.uk, schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove set_pgdir leftovers
Message-ID: <20060217191248.GA4707@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

set_pgdir isn't needed anymore for a very long time.  Remove the
leftover implementation on sh64 and the stub on s390.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/include/asm-s390/pgalloc.h
===================================================================
--- linux-2.6.orig/include/asm-s390/pgalloc.h	2005-12-27 18:30:34.000000000 +0100
+++ linux-2.6/include/asm-s390/pgalloc.h	2006-02-15 14:02:56.000000000 +0100
@@ -158,11 +158,4 @@
 
 #define __pte_free_tlb(tlb,pte) tlb_remove_page(tlb,pte)
 
-/*
- * This establishes kernel virtual mappings (e.g., as a result of a
- * vmalloc call).  Since s390-esame uses a separate kernel page table,
- * there is nothing to do here... :)
- */
-#define set_pgdir(addr,entry) do { } while(0)
-
 #endif /* _S390_PGALLOC_H */
Index: linux-2.6/include/asm-sh64/pgalloc.h
===================================================================
--- linux-2.6.orig/include/asm-sh64/pgalloc.h	2006-01-10 18:31:33.000000000 +0100
+++ linux-2.6/include/asm-sh64/pgalloc.h	2006-02-15 14:03:02.000000000 +0100
@@ -167,22 +167,6 @@
 
 extern int do_check_pgt_cache(int, int);
 
-static inline void set_pgdir(unsigned long address, pgd_t entry)
-{
-	struct task_struct * p;
-	pgd_t *pgd;
-
-	read_lock(&tasklist_lock);
-	for_each_process(p) {
-		if (!p->mm)
-			continue;
-		*pgd_offset(p->mm,address) = entry;
-	}
-	read_unlock(&tasklist_lock);
-	for (pgd = (pgd_t *)pgd_quicklist; pgd; pgd = (pgd_t *)*(unsigned long *)pgd)
-		pgd[address >> PGDIR_SHIFT] = entry;
-}
-
 #define pmd_populate_kernel(mm, pmd, pte) \
 	set_pmd(pmd, __pmd(_PAGE_TABLE + (unsigned long) (pte)))
 

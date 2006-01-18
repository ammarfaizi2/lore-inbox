Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWARPDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWARPDp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWARPDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:03:44 -0500
Received: from ns1.suse.de ([195.135.220.2]:11703 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030334AbWARPDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:03:44 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
Message-Id: <20060117150316.7411.98772.sendpatchset@linux.site>
In-Reply-To: <20060117150307.7411.94174.sendpatchset@linux.site>
References: <20060117150307.7411.94174.sendpatchset@linux.site>
Subject: [patch 1/2] x86_64: pageattr use single list
Date: Wed, 18 Jan 2006 16:03:40 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use page->lru.next to implement the singly linked list of pages rather
than the struct deferred_page which needs to be allocated and freed for
each page.

Signed-off-by: Nick Piggin <npiggin@suse.de>
Acked-by: Andi Kleen <ak@suse.de>

Index: linux-2.6/arch/x86_64/mm/pageattr.c
===================================================================
--- linux-2.6.orig/arch/x86_64/mm/pageattr.c
+++ linux-2.6/arch/x86_64/mm/pageattr.c
@@ -77,26 +77,12 @@ static inline void flush_map(unsigned lo
 	on_each_cpu(flush_kernel_map, (void *)address, 1, 1);
 }
 
-struct deferred_page { 
-	struct deferred_page *next; 
-	struct page *fpage;
-	unsigned long address;
-}; 
-static struct deferred_page *df_list; /* protected by init_mm.mmap_sem */
+static struct page *deferred_pages; /* protected by init_mm.mmap_sem */
 
-static inline void save_page(unsigned long address, struct page *fpage)
+static inline void save_page(struct page *fpage)
 {
-	struct deferred_page *df;
-	df = kmalloc(sizeof(struct deferred_page), GFP_KERNEL); 
-	if (!df) {
-		flush_map(address);
-		__free_page(fpage);
-	} else { 
-		df->next = df_list;
-		df->fpage = fpage;
-		df->address = address;
-		df_list = df;
-	} 			
+	fpage->lru.next = (struct list_head *)deferred_pages;
+	deferred_pages = fpage;
 }
 
 /* 
@@ -163,7 +149,7 @@ __change_page_attr(unsigned long address
 
 	switch (page_count(kpte_page)) {
  	case 1:
-		save_page(address, kpte_page); 		     
+		save_page(kpte_page);
 		revert_page(address, ref_prot);
 		break;
  	case 0:
@@ -220,17 +206,16 @@ int change_page_attr(struct page *page, 
 
 void global_flush_tlb(void)
 { 
-	struct deferred_page *df, *next_df;
+	struct page *dpage;
 
 	down_read(&init_mm.mmap_sem);
-	df = xchg(&df_list, NULL);
+	dpage = xchg(&deferred_pages, NULL);
 	up_read(&init_mm.mmap_sem);
-	flush_map((df && !df->next) ? df->address : 0);
-	for (; df; df = next_df) { 
-		next_df = df->next;
-		if (df->fpage) 
-			__free_page(df->fpage);
-		kfree(df);
+
+	flush_map((dpage && !dpage->lru.next) ? (unsigned long)page_address(dpage) : 0);
+	while (dpage) {
+		__free_page(dpage);
+		dpage = (struct page *)dpage->lru.next;
 	} 
 } 
 

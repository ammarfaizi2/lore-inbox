Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTEKH4L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 03:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbTEKH4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 03:56:11 -0400
Received: from zero.aec.at ([193.170.194.10]:17925 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262406AbTEKH4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 03:56:09 -0400
Date: Sun, 11 May 2003 10:08:41 +0200
From: Andi Kleen <ak@muc.de>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use correct page protection for put_dirty_page
Message-ID: <20030511080841.GA31266@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


put_page_dirty must use the page protection of the stack VMA, not hardcoded
PAGE_COPY. They can be different e.g. when the stack is set non executable
via VM_STACK_FLAGS.

I added an fallback path for now because I'm not sure if the stack VMA
is always predowngrowed here, if the printk better it may be also needed
to add an stack extension here.

-Andi

--- linux-2.5.69-amd64/fs/exec.c-o	2003-04-20 21:21:50.000000000 +0200
+++ linux-2.5.69-amd64/fs/exec.c	2003-05-11 08:38:35.000000000 +0200
@@ -292,7 +292,9 @@
 	pgd_t * pgd;
 	pmd_t * pmd;
 	pte_t * pte;
+	pgprot_t prot;
 	struct pte_chain *pte_chain;
+	struct vm_area_struct *vma;
 
 	if (page_count(page) != 1)
 		printk(KERN_ERR "mem_map disagrees with %p at %08lx\n", page, address);
@@ -314,7 +316,13 @@
 	}
 	lru_cache_add_active(page);
 	flush_dcache_page(page);
-	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, PAGE_COPY))));
+	vma = find_vma(tsk->mm, address);
+	if (!vma) { 
+		printk("put_dirty_page: stack vma not extended yet %lx?\n",address); 
+		prot = PAGE_COPY;
+	} else
+		prot = vma->vm_page_prot;
+	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(page, prot))));
 	pte_chain = page_add_rmap(page, pte, pte_chain);
 	pte_unmap(pte);
 	tsk->mm->rss++;

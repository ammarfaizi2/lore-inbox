Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbUBBWpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 17:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265846AbUBBWpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 17:45:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:52373 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265843AbUBBWpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 17:45:22 -0500
Date: Mon, 2 Feb 2004 14:46:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore protections after forced fault in
 get_user_pages
Message-Id: <20040202144642.50ea0468.akpm@osdl.org>
In-Reply-To: <200402020729.i127TKG8011009@magilla.sf.frob.com>
References: <200402020729.i127TKG8011009@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> get_user_pages can force a fault to succeed despite the vma's protections.
> This is used in access_process_vm, so that ptrace can write an unwritable
> page, or read an unreadable but present page.

That's a bit ugly, isn't it?  We don't want to modify the pte permissions
in this case.  We just want the page frame.  But we do still want to call
handle_mm_fault() if the page isn't there at all, or to COW it.

One way to handle that would be to give the `write' arg to
handle_mm_fault() a third value which means "give us a writeable page, but
don't make the pte writeable".  Maybe that isn't warranted for this special
case.  But it would be better, really.


> +/*
> + * Reset the page table entry for the given address after faulting in a page.
> + * We restore the protections indicated by its vma.
> + */
> +static void
> +restore_page_prot(struct mm_struct *mm, struct vm_area_struct *vma,
> +		  unsigned long address)
> +{
> +	pgd_t *pgd = pgd_offset(mm, address);
> +	pmd_t *pmd = pmd_alloc(mm, pgd, address);
> +	pte_t *pte;
> +	if (!pmd)
> +		return;
> +	pte = pte_alloc_map(mm, pmd, address);
> +	if (!pte)
> +		return;
> +	flush_cache_page(vma, address);
> +	ptep_establish(vma, address, pte, pte_modify(*pte, vma->vm_page_prot));
> +	update_mmu_cache(vma, address, entry);
> +	pte_unmap(pte);
> +}

This guy forgot to flush the tlb after modifying the pte permissions, and
symbol `entry' is not defined.  We've hit the latter problem multiple
times.  It's a good argument for empty inlines rather than empty macros.

diff -puN mm/memory.c~get_user_pages-restore-protections-fix mm/memory.c
--- 25/mm/memory.c~get_user_pages-restore-protections-fix	Mon Feb  2 14:34:34 2004
+++ 25-akpm/mm/memory.c	Mon Feb  2 14:35:47 2004
@@ -701,6 +701,7 @@ restore_page_prot(struct mm_struct *mm, 
 	pgd_t *pgd = pgd_offset(mm, address);
 	pmd_t *pmd = pmd_alloc(mm, pgd, address);
 	pte_t *pte;
+	pte_t entry;
 
 	if (!pmd)
 		return;
@@ -708,7 +709,9 @@ restore_page_prot(struct mm_struct *mm, 
 	if (!pte)
 		return;
 	flush_cache_page(vma, address);
-	ptep_establish(vma, address, pte, pte_modify(*pte, vma->vm_page_prot));
+	entry = pte_modify(*pte, vma->vm_page_prot);
+	ptep_establish(vma, address, pte, entry);
+	flush_tlb_page(vma, address);
 	update_mmu_cache(vma, address, entry);
 	pte_unmap(pte);
 }

_


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVCCGzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVCCGzl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVCCGxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:53:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17101 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261545AbVCCGOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:14:50 -0500
Date: Wed, 2 Mar 2005 22:13:59 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
In-Reply-To: <20050302205612.451d220b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503022206001.4389@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
 <20050302174507.7991af94.akpm@osdl.org> <Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
 <20050302185508.4cd2f618.akpm@osdl.org> <Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
 <20050302201425.2b994195.akpm@osdl.org> <Pine.LNX.4.58.0503022021150.3816@schroedinger.engr.sgi.com>
 <20050302205612.451d220b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Andrew Morton wrote:

> > Any mmap changes requires the mmapsem.
>
> sys_remap_file_pages() will call install_page() under down_read(mmap_sem).
> It relies upon page_table_lock for pte atomicity.

This is not relevant since it only deals with file pages. ptes are only
installed atomically for anonymous memory (if CONFIG_ATOMIC_OPS
is defined).

do_file_page() does call the populate function which does the right thing
in acquiring the page_table_lock before a pte update. My patch does not
touch that.

/*
 * Install a file pte to a given virtual memory address, release any
 * previously existing mapping.
 */
int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma,
                unsigned long addr, unsigned long pgoff, pgprot_t prot)
{
        int err = -ENOMEM;
        pte_t *pte;
        pmd_t *pmd;
        pud_t *pud;
        pgd_t *pgd;
        pte_t pte_val;

        pgd = pgd_offset(mm, addr);
        spin_lock(&mm->page_table_lock);

        pud = pud_alloc(mm, pgd, addr);
        if (!pud)
                goto err_unlock;

        pmd = pmd_alloc(mm, pud, addr);
        if (!pmd)
                goto err_unlock;

        pte = pte_alloc_map(mm, pmd, addr);
        if (!pte)
                goto err_unlock;

        zap_pte(mm, vma, addr, pte);

        set_pte(pte, pgoff_to_pte(pgoff));
        pte_val = *pte;
        pte_unmap(pte);
        update_mmu_cache(vma, addr, pte_val);
        spin_unlock(&mm->page_table_lock);
        return 0;

err_unlock:
        spin_unlock(&mm->page_table_lock);
        return err;
}




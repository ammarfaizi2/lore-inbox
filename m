Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUJLTJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUJLTJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUJLTJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:09:10 -0400
Received: from cantor.suse.de ([195.135.220.2]:25482 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267591AbUJLTIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:08:47 -0400
Date: Tue, 12 Oct 2004 21:03:46 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm@digeo.com
Subject: Re: 4level page tables for Linux
Message-ID: <20041012190346.GA705@wotan.suse.de>
References: <20041012135919.GB20992@wotan.suse.de> <1097606902.10652.203.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097606902.10652.203.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 11:48:22AM -0700, Dave Hansen wrote:
> @@ -110,13 +115,18 @@ int install_file_pte(struct mm_struct *m
>                 unsigned long addr, unsigned long pgoff, pgprot_t prot)
>  {
> ...
> +       pml4 = pml4_offset(mm, addr);
> +
> +       spin_lock(&mm->page_table_lock);
> +       pgd = pgd_alloc(mm, pml4, addr);
> +       if (!pgd)
> +               goto err_unlock;
> 
> Locking isn't needed for access to the pml4?  This is a wee bit
> different from pgd's and I didn't see any documentation about it
> anywhere.  Could be confusing.

No, the lock is still needed. Thanks for catching this, that was indeed
wrong.

> 
> +++ linux-2.6.9rc4-4level/mm/memory.c 
> ...
> +#undef inline
> +#define inline
> +unsigned long caddr;
> 
> Is this just for debugging?

Yes, that's a leftover I forgot to remove.  Will go in the next 
version.

(btw t here is another leftover in there, I will remove it too) 

> 
> +static inline void free_one_pml4(struct mmu_gather *tlb, pml4_t *pml4,
> +                                unsigned long addr, unsigned long end)
> +{
> ...
> +       do {
> +               caddr = addr;
> +               free_one_pgd(tlb, pgd);
> +               free++;
> +               addr = (addr + PGDIR_SIZE) & PGDIR_MASK;
> +               pgd++;
> +       } while (addr && addr < end);
> 
> If someone attempts to clear an address which is in the top PGDIR_SIZE
> bytes of memory, this will overflow.  Is that an issue?

That is what the addr && is for. Yes, overflows happen and afaik they
are all handled.

> 
> There also seems to be quite a bit of churn in the copy_*_range()
> functions that isn't completely related to the pml4 changes.  Should
> that get broken out?

It's related. The old function just wasn't scalable to 4 level 
page tables at all (i really tried but it was too ugly) so I rewrote it 
completely. Splitting it would be difficult because the 3level version 
would be already very different from the 4level version.

Thanks for the review.

-Andi

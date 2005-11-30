Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVK3N6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVK3N6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 08:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVK3N6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 08:58:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12046 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751233AbVK3N6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 08:58:19 -0500
Date: Wed, 30 Nov 2005 13:58:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2.6.15-rc3] Fix missing pfn variables caused by vm changes
Message-ID: <20051130135812.GA1053@flint.arm.linux.org.uk>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20051129194526.GF6288@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129194526.GF6288@swissdisk.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 11:45:26AM -0800, Ben Collins wrote:
> I image this showed up because of "unused var..." when the changes
> occured, because flush_cache_page() is a noop in most places. This showed
> up for me on parisc however, where flush_cache_page() is a real function.

This also fixes ARM, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> diff --git a/mm/memory.c b/mm/memory.c
> index 6c1eac9..74839b3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1345,7 +1345,7 @@ static int do_wp_page(struct mm_struct *
>  		int reuse = can_share_swap_page(old_page);
>  		unlock_page(old_page);
>  		if (reuse) {
> -			flush_cache_page(vma, address, pfn);
> +			flush_cache_page(vma, address, pte_pfn(orig_pte));
>  			entry = pte_mkyoung(orig_pte);
>  			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  			ptep_set_access_flags(vma, address, page_table, entry, 1);
> @@ -1389,7 +1389,7 @@ gotten:
>  			}
>  		} else
>  			inc_mm_counter(mm, anon_rss);
> -		flush_cache_page(vma, address, pfn);
> +		flush_cache_page(vma, address, pte_pfn(orig_pte));
>  		entry = mk_pte(new_page, vma->vm_page_prot);
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  		ptep_establish(vma, address, page_table, entry);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 491ac35..f853c6d 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -641,7 +641,7 @@ static void try_to_unmap_cluster(unsigne
>  			continue;
>  
>  		/* Nuke the page table entry. */
> -		flush_cache_page(vma, address, pfn);
> +		flush_cache_page(vma, address, pte_pfn(*pte));
>  		pteval = ptep_clear_flush(vma, address, pte);
>  
>  		/* If nonlinear, store the file page offset in the pte. */
> 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

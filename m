Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVCCCAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVCCCAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVCCB6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:58:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:60308 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261407AbVCCBpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:45:36 -0500
Date: Wed, 2 Mar 2005 17:45:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
Message-Id: <20050302174507.7991af94.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> ...
>  static int do_wp_page(struct mm_struct *mm, struct vm_area_struct * vma,
>  	unsigned long address, pte_t *page_table, pmd_t *pmd, pte_t pte)
> @@ -1306,22 +1308,25 @@ static int do_wp_page(struct mm_struct *
>  			flush_cache_page(vma, address);
>  			entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
>  					      vma);
> -			ptep_set_access_flags(vma, address, page_table, entry, 1);
> -			update_mmu_cache(vma, address, entry);
> +			/*
> +			 * If the bits are not updated then another fault
> +			 * will be generated with another chance of updating.
> +			 */
> +			if (ptep_cmpxchg(page_table, pte, entry))
> +				update_mmu_cache(vma, address, entry);
> +			else
> +				inc_page_state(cmpxchg_fail_flag_reuse);
>  			pte_unmap(page_table);
> -			spin_unlock(&mm->page_table_lock);
> +			page_table_atomic_stop(mm);
>  			return VM_FAULT_MINOR;
>  		}
>  	}
>  	pte_unmap(page_table);
> +	page_table_atomic_stop(mm);
> 
>  	/*
>  	 * Ok, we need to copy. Oh, well..
>  	 */
> -	if (!PageReserved(old_page))
> -		page_cache_get(old_page);

hm, this seems to be an unrelated change.  You're saying that this page is
protected from munmap() by munmap()'s down_write(mmap_sem), yes?  What
stops memory reclaim from freeing old_page?

>  static int do_swap_page(struct mm_struct * mm,
>  	struct vm_area_struct * vma, unsigned long address,
> @@ -1727,12 +1733,11 @@ static int do_swap_page(struct mm_struct
>  		grab_swap_token();
>  	}
> 
> -	mark_page_accessed(page);
> +	SetPageReferenced(page);

Another unrelated change.  IIRC, this is indeed equivalent, but I forget
why.  Care to remind me?


Overall, do we know which architectures are capable of using this feature? 
Would ppc64 (and sparc64?) still have a problem with page_table_lock no
longer protecting their internals?

I'd really like to see other architecture maintainers stand up and say
"yes, we need this".

Did you consider doing the locking at the pte page level?  That could be
neater than all those games with atomic pte operattions.

We need to do the big page-table-walker code consolidation/cleanup.  That
might have some overlap.

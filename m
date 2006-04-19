Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWDSAtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWDSAtn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 20:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWDSAtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 20:49:43 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:9641 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750942AbWDSAtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 20:49:42 -0400
Date: Wed, 19 Apr 2006 09:50:44 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       akpm@osdl.org
Subject: Re: Read/Write migration entries: Implement correct behavior in
 copy_one_pte
Message-Id: <20060419095044.d7333b21.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0604181119480.7814@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0604181119480.7814@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2006 11:21:25 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> Note that this is again only a partial solution. mprotect() also has the
> potential of changing the write status to read. 
yes. in change_pte_range(). 

Note:
fork() and mprotect() both requires mm->mmap_sem.
So both of them is not problem when migration holds mm->mmap_sem.
If we does lazy migration or memory hot removing or allows migration from
another process, this will be problem.



> Are there any additional occurrences? Would you check and fix this one as well?
> 
pte_modify() looks to be called only by mprotect(). I checked all mk_pte() but
not found no occurrences now. But I'll have to do more.


> If we cannot get to all the locations or if these fixes get too extensive
> then I think we better drop the preservation of write permissions and
> tolerate the occurrence of some useless COW after migration.
> 
yes. I agree.

-Kame
> 
> 
> Migration entries with write permission must become SWP_MIGRATION_READ
> entries if a COW mapping is processed. The migration entries from which
> the copy is being made must also become SWP_MIGRATION_READ. This mimicks
> the copying of pte for an anonymous page.
> 
> Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.17-rc1-mm3/mm/memory.c
> ===================================================================
> --- linux-2.6.17-rc1-mm3.orig/mm/memory.c	2006-04-18 10:58:33.000000000 -0700
> +++ linux-2.6.17-rc1-mm3/mm/memory.c	2006-04-18 11:09:23.000000000 -0700
> @@ -434,7 +434,9 @@ copy_one_pte(struct mm_struct *dst_mm, s
>  	/* pte contains position in swap or file, so copy. */
>  	if (unlikely(!pte_present(pte))) {
>  		if (!pte_file(pte)) {
> -			swap_duplicate(pte_to_swp_entry(pte));
> +			swp_entry_t entry = pte_to_swp_entry(pte);
> +
> +			swap_duplicate(entry);
>  			/* make sure dst_mm is on swapoff's mmlist. */
>  			if (unlikely(list_empty(&dst_mm->mmlist))) {
>  				spin_lock(&mmlist_lock);
> @@ -443,6 +445,19 @@ copy_one_pte(struct mm_struct *dst_mm, s
>  						 &src_mm->mmlist);
>  				spin_unlock(&mmlist_lock);
>  			}
> +			if (is_migration_entry(entry) &&
> +					is_cow_mapping(vm_flags)) {
> +				page = migration_entry_to_page(entry);
> +
> +				/*
> +				 * COW mappings require pages in both parent
> +				*  and child to be set to read.
> +				 */
> +				entry = make_migration_entry(page,
> +	`					SWP_MIGRATION_READ);
> +				pte = swp_entry_to_pte(entry);
> +				set_pte_at(src_mm, addr, src_pte, pte);
> +			}
>  		}
>  		goto out_set_pte;
>  	}
> 


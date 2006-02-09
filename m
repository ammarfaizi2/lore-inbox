Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWBIXIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWBIXIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWBIXIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:08:34 -0500
Received: from ozlabs.org ([203.10.76.45]:61323 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750783AbWBIXId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:08:33 -0500
Date: Fri, 10 Feb 2006 10:08:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, agl@us.ibm.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: OOM behavior in constrained memory situations
Message-ID: <20060209230803.GA25740@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Christoph Lameter <clameter@engr.sgi.com>,
	Andrew Morton <akpm@osdl.org>, ak@suse.de, agl@us.ibm.com,
	wli@holomorphy.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com> <20060206131026.53dbd8d5.akpm@osdl.org> <200602062222.28630.ak@suse.de> <Pine.LNX.4.62.0602061415560.18919@schroedinger.engr.sgi.com> <20060206143022.37d1781e.akpm@osdl.org> <Pine.LNX.4.62.0602061558290.19350@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0602061558290.19350@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 04:03:53PM -0800, Christoph Lameter wrote:
> On Mon, 6 Feb 2006, Andrew Morton wrote:
> 
> > The oom-killer is invoked from the page allocator.  A hugetlb pagefault
> > won't use the page allocator.  So there shouldn't be an oom-killing on
> > hugepage exhaustion.
> 
> Right..... and the arch specific fault code (at least ia64) does not call 
> the OOM killer.
> 
> > I think this comment is just wrong:
> > 
> > 		/* Logically this is OOM, not a SIGBUS, but an OOM
> > 		 * could cause the kernel to go killing other
> > 		 * processes which won't help the hugepage situation
> > 		 * at all (?) */
> > 
> > A VM_FAULT_OOM from there won't cause the oom-killer to do anything.  We
> > should return VM_FAULT_OOM and let do_page_fault() commit suicide with
> > SIGKILL.
> 
> Drop my patch that adds the comments explaining the bus error and add this 
> fix instead. This will terminate an application with out of memory instead 
> of bus error and remove the comment that you mentioned.

Looks good, except I think a comment should go in there so the next
person to look at it doesn't make the same wrong assumption I did,
that returning VM_FAULT_OOM will trigger the OOM killer.

> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.16-rc2/mm/hugetlb.c
> ===================================================================
> --- linux-2.6.16-rc2.orig/mm/hugetlb.c	2006-02-02 22:03:08.000000000 -0800
> +++ linux-2.6.16-rc2/mm/hugetlb.c	2006-02-06 16:02:53.000000000 -0800
> @@ -391,12 +391,7 @@ static int hugetlb_cow(struct mm_struct 
>  
>  	if (!new_page) {
>  		page_cache_release(old_page);
> -
> -		/* Logically this is OOM, not a SIGBUS, but an OOM
> -		 * could cause the kernel to go killing other
> -		 * processes which won't help the hugepage situation
> -		 * at all (?) */
> -		return VM_FAULT_SIGBUS;
> +		return VM_FAULT_OOM;
>  	}
>  
>  	spin_unlock(&mm->page_table_lock);
> @@ -444,6 +439,7 @@ retry:
>  		page = alloc_huge_page(vma, address);
>  		if (!page) {
>  			hugetlb_put_quota(mapping);
> +			ret = VM_FAULT_OOM;
>  			goto out;
>  		}
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

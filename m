Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTEOImd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 04:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbTEOImd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 04:42:33 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49026
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263871AbTEOImb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 04:42:31 -0400
Date: Thu, 15 May 2003 10:55:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: dmccr@us.ibm.com, mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <20030515085519.GV1429@dualathlon.random>
References: <154080000.1052858685@baldur.austin.ibm.com> <20030513181018.4cbff906.akpm@digeo.com> <18240000.1052924530@baldur.austin.ibm.com> <20030514103421.197f177a.akpm@digeo.com> <82240000.1052934152@baldur.austin.ibm.com> <20030515004915.GR1429@dualathlon.random> <20030515013245.58bcaf8f.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515013245.58bcaf8f.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 01:32:45AM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> >  what do you think of this untested fix?
> > 
> >  I wonder if vm_file is valid for all nopage operations, I think it
> >  should, and the i_mapping as well should always exist, but in the worst
> >  case it shouldn't be too difficult to take care of special cases
> >  (just checking if the new_page is reserved and if the vma is VM_SPECIAL)
> >  would eliminate most issues, shall there be any.
> 
> yes, I think this is a good solution.
> 
> In 2.5 (at least) we can push all the sequence number work into
> filemap_nopage(), and add a new vm_ops->revalidate() thing, so do_no_page()
> doesn't need to know about inodes and such.
> 
> So the mm/memory.c part would look something like:

this is your i_size check idea, and it's still racy (though less racy
than before ;), you will corrupt the user address space again if you get
two truncates under you (the first truncating the page under fault, and
the second extending the file past the page under fault) and since you
only call revalidate after re-taking the spinlock you can't catch the
first truncate that mandates the page to be zeroed out despite the
i_size check.

you could trap this by checking the page->mapping inside the
page_table_lock probably but taking lock_page before page_table_lock in
do_no_page is way overkill compared to my read-lockless patch.

> 
> diff -puN mm/memory.c~a mm/memory.c
> --- 25/mm/memory.c~a	2003-05-15 01:29:21.000000000 -0700
> +++ 25-akpm/mm/memory.c	2003-05-15 01:32:02.000000000 -0700
> @@ -1399,7 +1399,7 @@ do_no_page(struct mm_struct *mm, struct 
>  					pmd, write_access, address);
>  	pte_unmap(page_table);
>  	spin_unlock(&mm->page_table_lock);
> -
> +retry:
>  	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
>  
>  	/* no page was available -- either SIGBUS or OOM */
> @@ -1408,9 +1408,11 @@ do_no_page(struct mm_struct *mm, struct 
>  	if (new_page == NOPAGE_OOM)
>  		return VM_FAULT_OOM;
>  
> -	pte_chain = pte_chain_alloc(GFP_KERNEL);
> -	if (!pte_chain)
> -		goto oom;
> +	if (!pte_chain) {
> +		pte_chain = pte_chain_alloc(GFP_KERNEL);
> +		if (!pte_chain)
> +			goto oom;
> +	}
>  
>  	/*
>  	 * Should we do an early C-O-W break?
> @@ -1428,6 +1430,17 @@ do_no_page(struct mm_struct *mm, struct 
>  	}
>  
>  	spin_lock(&mm->page_table_lock);
> +
> +	/*
> +	 * comment goes here
> +	 */
> +	if (vma->vm_ops && vma->vm_ops->revalidate &&
> +			vma->vm_ops->revalidate(vma, address) {
> +		spin_unlock(&mm->page_table_lock);
> +		put_page(new_page);
> +		goto retry;
> +	}
> +
>  	page_table = pte_offset_map(pmd, address);
>  
>  	/*
> 
> _
> 


Andrea

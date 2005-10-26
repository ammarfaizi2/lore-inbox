Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVJZVqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVJZVqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbVJZVqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:46:33 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:32725 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964950AbVJZVqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:46:32 -0400
Subject: Re: RFC: Cleanup / small fixes to hugetlb fault handling
From: Adam Litke <agl@us.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, hugh@veritas.com,
       William Irwin <wli@holomorphy.com>
In-Reply-To: <20051026024831.GB17191@localhost.localdomain>
References: <20051026020055.GA17191@localhost.localdomain>
	 <20051026024831.GB17191@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Wed, 26 Oct 2005 16:46:16 -0500
Message-Id: <1130363177.2689.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 12:48 +1000, David Gibson wrote:
> On Wed, Oct 26, 2005 at 12:00:55PM +1000, David Gibson wrote:
> > Hi, Adam, Bill, Hugh,
> > 
> > Does this look like a reasonable patch to send to akpm for -mm.
> 
> Ahem.  Or rather this version, which actually compiles.
> 
> This patch makes some slight tweaks / cleanups to the fault handling
> path for huge pages in -mm.  My main motivation is to make it simpler
> to fit COW in, but along the way it addresses a few minor problems
> with the existing code:
> 
> - The check against i_size was duplicated: once in
>   find_lock_huge_page() and again in hugetlb_fault() after taking the
>   page_table_lock.  We only really need the locked one, so remove the
>   other.

Fair enough.

> - find_lock_huge_page() didn't, in fact, lock the page if it newly
>   allocated one, rather than finding it in the page cache already.  As
>   far as I can tell this is a bug, so the patch corrects it.

Thanks.  I was about to post a fix for this too.  It is reproducible in
the case where two threads race in the fault handler and both do
alloc_huge_page().  In that case, the loser will fail to insert his page
into the page cache and will call put_page() which has a
BUG_ON(page_count(page) == 0).

> - find_lock_huge_page() isn't a great name, since it does extra things
>   not analagous to find_lock_page().  Rename it
>   find_or_alloc_huge_page() which is closer to the mark.

I'll agree with the above.  I am not all that committed to the current
layout and what you have here is a little closer to the thinking in my
original patch ;)

<snip>

> +int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> +		  unsigned long address, int write_access)
> +{
> +	pte_t *ptep;
> +	pte_t entry;
> +
> +	ptep = huge_pte_alloc(mm, address);
> +	if (! ptep)
> +		/* OOM */
> +		return VM_FAULT_SIGBUS;
> +
> +	entry = *ptep;
> +
> +	if (pte_none(entry))
> +		return hugetlb_no_page(mm, vma, address, ptep);
> +
> +	/* we could get here if another thread instantiated the pte
> +	 * before the test above */
> +
> +	return VM_FAULT_SIGBUS;
>  }

I'll agree with Ken that the last return should probably still be
VM_FAULT_MINOR.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center


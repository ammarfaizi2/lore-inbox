Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbVHZSHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbVHZSHy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbVHZSHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:07:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965155AbVHZSHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:07:53 -0400
Date: Fri, 26 Aug 2005 11:07:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Rik van Riel <riel@redhat.com>,
       Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.58.0508261052330.3317@g5.osdl.org>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
 <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
 <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
 <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Aug 2005, Hugh Dickins wrote:
> 
> I see some flaws in the various patches posted, including Rik's.
> Here's another version - doing it inside copy_page_range, so this
> kind of vma special-casing is over in mm/ rather than kernel/.

I like this approach better, but I don't understand your particular 
choice of bits.

> +	 * Assume the fork will probably exec: don't waste time copying
> +	 * ptes where a page fault will fill them correctly afterwards.
> +	 */
> +	if ((vma->vm_flags & (VM_MAYSHARE|VM_HUGETLB|VM_NONLINEAR|VM_RESERVED))
> +								== VM_MAYSHARE)
> +		return 0;
> +
>  	if (is_vm_hugetlb_page(vma))
>  		return copy_hugetlb_page_range(dst_mm, src_mm, vma);

First off, if you just did it below the hugetlb check, you'd not need to
check hugetlb again. And while I understand VM_NONLINEAR and VM_RESERVED,
can you please comment on why VM_MAYSHARE is so important, and why no
other information matters.

Now, VM_MAYSHARE is a sign of the mapping being a shared mapping. Fair 
enough. But afaik, a shared anonymous mapping absolutely needs its page 
tables copied, because those page tables contains either the pointers to 
the shared pages, or the swap entries.

So I really think you need to verify that it's a file mapping too.

Also, arguably, there are other cases that may or may not be worth 
worrying about. What about non-shared non-writable file mappings? What 
about private mappings that haven't been COW'ed? 

So I think that in addition to your tests, you should test for
"vma->vm_file", and you could toy with testing for "vma->anon_vma"  being
NULL (the latter will cause a _lot_ of hits, because any read-only private
mapping will trigger, but it's a good stress-test and conceptually
interesting, even if I suspect it will kill any performance gain through
extra minor faults in the child).

			Linus

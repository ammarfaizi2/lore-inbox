Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbVHZSj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbVHZSj5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbVHZSj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:39:57 -0400
Received: from gold.veritas.com ([143.127.12.110]:6063 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S965167AbVHZSj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:39:56 -0400
Date: Fri, 26 Aug 2005 19:41:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Rik van Riel <riel@redhat.com>,
       Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <Pine.LNX.4.58.0508261052330.3317@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0508261917360.8477@goblin.wat.veritas.com>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
 <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
 <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
 <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508261052330.3317@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Aug 2005 18:39:56.0245 (UTC) FILETIME=[8E1E8850:01C5AA6D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, Linus Torvalds wrote:
> On Fri, 26 Aug 2005, Hugh Dickins wrote:
> > 
> > I see some flaws in the various patches posted, including Rik's.
> > Here's another version - doing it inside copy_page_range, so this
> > kind of vma special-casing is over in mm/ rather than kernel/.
> 
> I like this approach better, but I don't understand your particular 
> choice of bits.
> 
> > +	 * Assume the fork will probably exec: don't waste time copying
> > +	 * ptes where a page fault will fill them correctly afterwards.
> > +	 */
> > +	if ((vma->vm_flags & (VM_MAYSHARE|VM_HUGETLB|VM_NONLINEAR|VM_RESERVED))
> > +								== VM_MAYSHARE)
> > +		return 0;
> > +
> >  	if (is_vm_hugetlb_page(vma))
> >  		return copy_hugetlb_page_range(dst_mm, src_mm, vma);
> 
> First off, if you just did it below the hugetlb check, you'd not need to
> check hugetlb again.

Yes: I wanted to include VM_HUGETLB in the list as documentation really;
and it costs nothing to test it along with the other flags - or are there
architectures where the more bits you test, the costlier?

> And while I understand VM_NONLINEAR and VM_RESERVED,
> can you please comment on why VM_MAYSHARE is so important, and why no
> other information matters.

The VM_MAYSHARE one isn't terribly important, there's no correctness
reason to replace VM_SHARED there.   It's just that do_mmap_pgoff takes
VM_SHARED and VM_MAYWRITE off a MAP_SHARED mapping of a file which was
not opened for writing.  We can safely avoid copying the ptes of such a
vma, just as with the writable ones, but the VM_MAYSHARE test catches
them where the VM_SHARED test does not.

> Now, VM_MAYSHARE is a sign of the mapping being a shared mapping. Fair 
> enough. But afaik, a shared anonymous mapping absolutely needs its page 
> tables copied, because those page tables contains either the pointers to 
> the shared pages, or the swap entries.
> 
> So I really think you need to verify that it's a file mapping too.

Either I'm misunderstanding, or you're remembering back to how shared
anonymous was done in 2.2 (perhaps).  In 2.4 and 2.6, shared anonymous
is "backed" by a shared memory object, created by shmem_zero_setup:
which sets vm_file even though we came into do_mmap_pgoff with no file.

> Also, arguably, there are other cases that may or may not be worth 
> worrying about. What about non-shared non-writable file mappings? What 
> about private mappings that haven't been COW'ed? 

Non-shared non-currently-writable file mappings might have been writable
and modified in the past, so we cannot necessarily skip those.

We could, and I did, consider testing whether the vma has an anon_vma:
we always allocate a vma's anon_vma just before first allocating it a
private page, and it's a good test which swapoff uses to narrow its
search.

But partly I thought that a little too tricksy, and hard to explain;
and partly I thought it was liable to catch the executable text,
some of which is most likely to be needed in between fork and exec.

> So I think that in addition to your tests, you should test for
> "vma->vm_file", and you could toy with testing for "vma->anon_vma"  being
> NULL (the latter will cause a _lot_ of hits, because any read-only private
> mapping will trigger, but it's a good stress-test and conceptually
> interesting, even if I suspect it will kill any performance gain through
> extra minor faults in the child).

Ah yes, I wrote the paragraph above before reading this one, honest!

Well, I still don't think we need to test vm_file.  We can add an
anon_vma test if you like, if we really want to minimize the fork
overhead, in favour of later faults.  Do we?

Hugh

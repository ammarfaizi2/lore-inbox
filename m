Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbSLSQxr>; Thu, 19 Dec 2002 11:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265800AbSLSQxr>; Thu, 19 Dec 2002 11:53:47 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:20712 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S265791AbSLSQxo>; Thu, 19 Dec 2002 11:53:44 -0500
Date: Thu, 19 Dec 2002 17:02:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: mremap use-after-free [was Re: 2.5.52-mm2]
In-Reply-To: <3E01943B.4170B911@digeo.com>
Message-ID: <Pine.LNX.4.44.0212191602190.1893-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, Andrew Morton wrote:
> Andrew Morton wrote:
> > ...
> > slab-poisoning.patch
> >   more informative slab poisoning
> 
> This patch has exposed a quite long-standing use-after-free bug in
> mremap().  It make the machine go BUG when starting the X server if
> memory debugging is turned on.

Good catch, shame about the patch!
Please don't apply this, or its 2.4 sister, as is.

> The bug might be present in 2.4 as well..

I doubt that (but may be wrong, I haven't time right now to think as
twistedly as mremap demands).  The code (patently!) expects new_vma
to be good at the end, it certainly wasn't intending to unmap it;
but 2.5 split_vma has been through a couple of convulsions, either
of which might have resulted in the potential for new_vma to be
freed where before it was guaranteed to remain.

Do you know the vmas before and after, and the mremap which did this?
I couldn't reproduce it starting X here, and an example would help to
uncloud my mind.  But you can reasonably answer that one example won't
prove anything, and where there's doubt, the code must be defensive.
(Besides, I'll be offline shortly.)

On to the patch...

> --- 25/mm/mremap.c~move_vma-use-after-free	Thu Dec 19 00:51:49 2002
> +++ 25-akpm/mm/mremap.c	Thu Dec 19 01:08:45 2002
> @@ -183,14 +183,16 @@ static unsigned long move_vma(struct vm_
>  	next = find_vma_prev(mm, new_addr, &prev);
>  	if (next) {
>  		if (prev && prev->vm_end == new_addr &&
> -		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
> +				can_vma_merge(prev, vma->vm_flags) &&
> +				!(vma->vm_flags & VM_SHARED)) {
>  			spin_lock(&mm->page_table_lock);
>  			prev->vm_end = new_addr + new_len;
>  			spin_unlock(&mm->page_table_lock);
>  			new_vma = prev;
>  			if (next != prev->vm_next)
>  				BUG();
> -			if (prev->vm_end == next->vm_start && can_vma_merge(next, prev->vm_flags)) {
> +			if (prev->vm_end == next->vm_start &&
> +					can_vma_merge(next, prev->vm_flags)) {
>  				spin_lock(&mm->page_table_lock);
>  				prev->vm_end = next->vm_end;
>  				__vma_unlink(mm, next, prev);
> @@ -201,7 +203,8 @@ static unsigned long move_vma(struct vm_
>  				kmem_cache_free(vm_area_cachep, next);
>  			}
>  		} else if (next->vm_start == new_addr + new_len &&
> -			   can_vma_merge(next, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
> +					can_vma_merge(next, vma->vm_flags) &&
> +					!(vma->vm_flags & VM_SHARED)) {
>  			spin_lock(&mm->page_table_lock);
>  			next->vm_start = new_addr;
>  			spin_unlock(&mm->page_table_lock);
> @@ -210,7 +213,8 @@ static unsigned long move_vma(struct vm_
>  	} else {
>  		prev = find_vma(mm, new_addr-1);
>  		if (prev && prev->vm_end == new_addr &&
> -		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
> +				can_vma_merge(prev, vma->vm_flags) &&
> +				!(vma->vm_flags & VM_SHARED)) {
>  			spin_lock(&mm->page_table_lock);
>  			prev->vm_end = new_addr + new_len;
>  			spin_unlock(&mm->page_table_lock);

Hmmm.  Am I right to suppose that all the changes above are "cleanup"
which you couldn't resist making while you looked through this code,
but entirely irrelevant to the bug in question?  If those mods above
were right, they should be the subject of a separate patch.

There's certainly room for cleanup there, but my preference would be
to remove "can_vma_merge" completely, or at least its use in mremap.c,
using its explicit tests instead.  It looks like it was originally
quite appropriate for a use or two in mmap.c, but obscurely unhelpful
here - because in itself it is testing a bizarre asymmetric subset of
what's needed (that subset which remained to be tested in its original
use in mmap.c).

The problem with your changes above is, you've removed the !vma->vm_file
tests, presumably because you noticed that can_vma_merge already tests
!vma->vm_file.  But "vma" within can_vma_merge is "prev" or "next" here:
they are distinct tests, and you're now liable to merge an anonymous
mapping with a private file mapping - nice if it's from /dev/zero,
but otherwise not.  Please just cut those hunks out.

(Of course, I wouldn't have spotted this if I hadn't embarked on,
then retreated from, a similar cleanup myself a few months back.)

> @@ -227,12 +231,16 @@ static unsigned long move_vma(struct vm_
>  	}
>  
>  	if (!move_page_tables(vma, new_addr, addr, old_len)) {
> +		unsigned long must_fault_in;
> +		unsigned long fault_in_start;
> +		unsigned long fault_in_end;
> +
>  		if (allocated_vma) {
>  			*new_vma = *vma;
>  			INIT_LIST_HEAD(&new_vma->shared);
>  			new_vma->vm_start = new_addr;
>  			new_vma->vm_end = new_addr+new_len;
> -			new_vma->vm_pgoff += (addr - vma->vm_start) >> PAGE_SHIFT;
> +			new_vma->vm_pgoff += (addr-vma->vm_start) >> PAGE_SHIFT;

Hrrmph.

>  			if (new_vma->vm_file)
>  				get_file(new_vma->vm_file);
>  			if (new_vma->vm_ops && new_vma->vm_ops->open)
> @@ -251,19 +259,25 @@ static unsigned long move_vma(struct vm_
>  		} else
>  			vma = NULL;		/* nothing more to do */
>  
> -		do_munmap(current->mm, addr, old_len);
> -

Anguished cry!  There was careful manipulation of VM_ACCOUNT before and
after do_munmap, now you've for no reason moved do_munmap down outside.

>  		/* Restore VM_ACCOUNT if one or two pieces of vma left */
>  		if (vma) {
>  			vma->vm_flags |= VM_ACCOUNT;
>  			if (split)
>  				vma->vm_next->vm_flags |= VM_ACCOUNT;
>  		}
> +
> +		must_fault_in = new_vma->vm_flags & VM_LOCKED;
> +		fault_in_start = new_vma->vm_start;
> +		fault_in_end = new_vma->vm_end;
> +
> +		do_munmap(current->mm, addr, old_len);
> +
> +		/* new_vma could have been invalidated by do_munmap */
> +
>  		current->mm->total_vm += new_len >> PAGE_SHIFT;
> -		if (new_vma->vm_flags & VM_LOCKED) {
> +		if (must_fault_in) {
>  			current->mm->locked_vm += new_len >> PAGE_SHIFT;
> -			make_pages_present(new_vma->vm_start,
> -					   new_vma->vm_end);
> +			make_pages_present(fault_in_start, fault_in_end);
>  		}
>  		return new_addr;
>  	}

But the bugfix part of it looks good.

Hugh


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSHJOV5>; Sat, 10 Aug 2002 10:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSHJOV5>; Sat, 10 Aug 2002 10:21:57 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:26891 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S316957AbSHJOV4>; Sat, 10 Aug 2002 10:21:56 -0400
Date: Sat, 10 Aug 2002 15:26:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Seth, Rohit" <rohit.seth@intel.com>
cc: "'Andrew Morton'" <akpm@zip.com.au>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: RE: large page patch (fwd) (fwd) ==>hugetlb page patch
In-Reply-To: <25282B06EFB8D31198BF00508B66D4FA03EA570E@fmsmsx114.fm.intel.com>
Message-ID: <Pine.LNX.4.44.0208101406310.3908-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2002, Seth, Rohit wrote:
> Attached is the updated Large Page (now onwards called hugetlb page) patch.
> This is basically the upport from original 2.4.18.  I've tried to
> incorporate some of the comments that have been made on the mailing list so
> far.  
> 
> Though the config option is still named CONFIG_LARGE_PAGE, but there are lot
> of other pieces that I've started renaming as "hugetlb"  Eventually
> CONFIG_LARGE_PAGE will be changed to CONFIG_HUGETLB_PAGE.  Following are the
> fixes/changes from the previous (2.4.18) patch:

"hugepage" is good, does indeed distinguish your work from other variants
of large page; but "hugetlb" is not good - this patch is precisely because
there is not a huge tlb (and no patch can provide one).

> 1) Only two system calls (Instead of 4 that were there in earlier patch).
> These are 
> sys_alloc_hugepages(int key, unsigned long addr, unsigned long len, int
> prot, int flag)
> and
> sys_free_hugepages(unsigned long addr)

Good: fewer special calls and better naming.  You do need to add mmap_sem.
But I still believe it's wrong to be adding any special syscalls for this.

Picky point: the unsigned long *raddr to alloc_hugetlb_pages etc.:
isn't *raddr always the same on successful return as on entry?
so unsigned long addr would be more straightforward.

> Key will be equal to zero if  user wants these huge pages as private.  A
> positive int value will be used for unrelated apps to share the same
> physcial huge pages.

Picky point: wouldn't it be more UNIX-like to use key >= 0
for an actual key, and key -1 for the special private case?

Thanks for clarifying in earlier mail that this key is not a shm key,
just a number for sharing maintained outside the kernel.  But how are
you going to handle permissions?  Seems to me there are two permissions
issues.  One, the precious resource of huge unswappable pages, which
ought to be protected by some capability - no such protection at
present, easily added.

But two, permission to map the shared hugepage object: with keys
maintained outside the kernel, I don't see how such protection will
be added.  Maybe it's not needed for the initial application of this
patch, but I don't like that it'll be messy to add later.  This issue
would, of course, vanish if you integrated more with existing practice,
adding a SHM_HUGEPAGE flag to shm, or working on ramfs-like filesystem.

> 2) munmap skips over the hugetlb regions (that is this function will not
> unmap the huge tlb regions)

Still not enough: see how mmap(MAP_FIXED) or mremap(MREMAP_FIXED) expect
that a successful do_munmap has cleared the address range, you're in
danger of adding a FIXED mapping into the same address range as an
existing hugepage vma.  I say again that the way to fix this is to let
munmap unmap any hugepage vma which falls wholly or partly within its
range, it's already having to recognize and skip them; then you can
scrap the sys_free_hugepages syscall as redundant; but I fear you'll
opt instead to add an error return from touched_by_munmap...

> 3) mprotect and mremap will return error if they happen to be touching
> hugetlb region
> 
> 4) /proc/sys/kernel/numhugepages: A positive value written to this will set
> the configured hugepage pool to that updated value.  Though I have also left
> the provision so that negative values just decrease the current configured
> hugetlb pool by that amount.

To that last sentence, sorry, but a Huge Ugh!

Hugh


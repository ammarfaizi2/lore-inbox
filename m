Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318839AbSHLVxA>; Mon, 12 Aug 2002 17:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318842AbSHLVxA>; Mon, 12 Aug 2002 17:53:00 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:58515 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S318839AbSHLVw6>; Mon, 12 Aug 2002 17:52:58 -0400
Message-ID: <25282B06EFB8D31198BF00508B66D4FA03EA5710@fmsmsx114.fm.intel.com>
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "'Hugh Dickins'" <hugh@veritas.com>, "Seth, Rohit" <rohit.seth@intel.com>
Cc: "'Andrew Morton'" <akpm@zip.com.au>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: RE: large page patch (fwd) (fwd) ==>hugetlb page patch
Date: Mon, 12 Aug 2002 14:56:38 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hugh Dickins [mailto:hugh@veritas.com]
> Sent: Saturday, August 10, 2002 7:26 AM
> To: Seth, Rohit
> Cc: 'Andrew Morton'; Linus Torvalds; linux-kernel@vger.kernel.org
> Subject: RE: large page patch (fwd) (fwd) ==>hugetlb page patch
> 
> 
> On Fri, 9 Aug 2002, Seth, Rohit wrote:
> > Attached is the updated Large Page (now onwards called 
> hugetlb page) patch.
> > This is basically the upport from original 2.4.18.  I've tried to
> > incorporate some of the comments that have been made on the 
> mailing list so
> > far.  
> > 
> > Though the config option is still named CONFIG_LARGE_PAGE, 
> but there are lot
> > of other pieces that I've started renaming as "hugetlb"  Eventually
> > CONFIG_LARGE_PAGE will be changed to CONFIG_HUGETLB_PAGE.  
> Following are the
> > fixes/changes from the previous (2.4.18) patch:
> 
> "hugepage" is good, does indeed distinguish your work from 
> other variants
> of large page; but "hugetlb" is not good - this patch is 
> precisely because
> there is not a huge tlb (and no patch can provide one).
> 
Actually, the essence of this patch is to use larger (I mean huge :-))
translations that are provided by modern architectures.  Physical contiguity
of smaller pages into a huge page also provides the benefit of page coloring
....as a side effect.  This has already been discussed on this list.  But
from user land's view, app only sees huge pages (and not the internal
implementation in kernel).  That is why I'm leaving all the app point of
contacts as hugepages (like /proc etc.), whereas making the kernel internal
implementation do more like hugetlbpages.  Anyways, I'm fine with "hugepage"
everywhere (I sincerely hope we are now settled for this naming part of the
discussion).


> > 1) Only two system calls (Instead of 4 that were there in 
> earlier patch).
> > These are 
> > sys_alloc_hugepages(int key, unsigned long addr, unsigned 
> long len, int
> > prot, int flag)
> > and
> > sys_free_hugepages(unsigned long addr)
> 
> Good: fewer special calls and better naming.  You do need to 
> add mmap_sem.
> But I still believe it's wrong to be adding any special 
> syscalls for this.
Yup, I will add the mmap_sem.  I think it is perfect to add two new system
calls for this new feature in kernel, so as to self contain the semantics of
these new calls (to say the least).

> 
> Picky point: the unsigned long *raddr to alloc_hugetlb_pages etc.:
> isn't *raddr always the same on successful return as on entry?
> so unsigned long addr would be more straightforward.
> 
For IA-32 we are pre-assigning the address, this would be true.  But for
IA-64 architecture it is not mandatory to pre-assign an address.  Arch
specific unmapped area function can get the proper hugepage address (and
then this value gets returned).  But I like your usggestion, it is cleaner
(and risk free even on other archs) to pre-assign the address.  I will make
this change (for both IA-32 and IA-64).


> > Key will be equal to zero if  user wants these huge pages 
> as private.  A
> > positive int value will be used for unrelated apps to share the same
> > physcial huge pages.
> 
> Picky point: wouldn't it be more UNIX-like to use key >= 0
> for an actual key, and key -1 for the special private case?
> 


> Thanks for clarifying in earlier mail that this key is not a shm key,
> just a number for sharing maintained outside the kernel.  But how are
> you going to handle permissions?  Seems to me there are two 
> permissions
> issues.  One, the precious resource of huge unswappable pages, which
> ought to be protected by some capability - no such protection at
> present, easily added.
> 
We will need to add support for controlling the usage of hugepage.  I was
thinking about defining a new constant like RLIMIT_HUGEPAGE (or could
overload RLIMIT_MEMLOCK).  Also, since some of the usage of hugepages will
be in databases kind of environment, so possibly unlimited usage for those
processes that have SYS_ADMIN capability (or root in one of the supplement
groups).

> But two, permission to map the shared hugepage object: with keys
> maintained outside the kernel, I don't see how such protection will
> be added.  Maybe it's not needed for the initial application of this
> patch, but I don't like that it'll be messy to add later.  This issue
> would, of course, vanish if you integrated more with existing 
> practice,
> adding a SHM_HUGEPAGE flag to shm, or working on ramfs-like 
> filesystem.
> 
Currently, the hugepage patch already checks the effective user and group
ids of processes (and size of requested hugepage segment).  Those
credentials need to all match (with the original) before hugepages can be
shared across processes.  The only maintenance part of the keys that user
has to maintain is to keep binding relation of key to specific hugepage
region and share that information across desired processes. 


> > 2) munmap skips over the hugetlb regions (that is this 
> function will not
> > unmap the huge tlb regions)
> 
> Still not enough: see how mmap(MAP_FIXED) or 
> mremap(MREMAP_FIXED) expect
> that a successful do_munmap has cleared the address range, you're in
> danger of adding a FIXED mapping into the same address range as an
> existing hugepage vma.  I say again that the way to fix this is to let
> munmap unmap any hugepage vma which falls wholly or partly within its
> range, it's already having to recognize and skip them; then you can
> scrap the sys_free_hugepages syscall as redundant; but I fear you'll
> opt instead to add an error return from touched_by_munmap...
> 
I'm not worried about munmap being able to do the job of sys_free_hugepages.
As I said in my last mail, there are other examples in kernel. IMO, as the
semantics of creating hugepage segment are different from mmap, so it is
essential to have a call to undo the previously done operations.  
However, the real question is what choice we want to make when a munmap
request falls on hugepage region (and Hugh you have created very good points
that one has to take care of).  There are following three options available
:
1)Unmap the complete hugepage region (even if the request was partially
overlapping a hugepage region).
2)Skip over hugepage regions in munmap region
3)Don't do any unmap operation (return failure) if the unmap request happen
to touch any hugepage region.

Out of these, 2 and 3 will need changes in current munmap related code.
Changes will need to be made in touched_by_unmap so that it somehow returns
the information that the request is touching hugepage region.  And then all
consumers of do_munmap will need changes so as to not follow through with
their normal operation if munmap has returned failure.
Where as option#1 could be easy to implement and more straightforward. The
changes in this case will be in touched_vy_unmap and unmap_region.  In this
case unmap_region will call the hugepage region specific close operation.  I
like the simplicity of this solution.


> > 3) mprotect and mremap will return error if they happen to 
> be touching
> > hugetlb region
> > 
> > 4) /proc/sys/kernel/numhugepages: A positive value written 
> to this will set
> > the configured hugepage pool to that updated value.  Though 
> I have also left
> > the provision so that negative values just decrease the 
> current configured
> > hugetlb pool by that amount.
> 
> To that last sentence, sorry, but a Huge Ugh!
> 
....It will go.  (Consider that being only used for some simple regression
test suite for me for now).

rohit


> Hugh
> 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSHGAHs>; Tue, 6 Aug 2002 20:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSHGAHs>; Tue, 6 Aug 2002 20:07:48 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:42458 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S316580AbSHGAHp>; Tue, 6 Aug 2002 20:07:45 -0400
Message-ID: <25282B06EFB8D31198BF00508B66D4FA03EA56D3@fmsmsx114.fm.intel.com>
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "'Hugh Dickins'" <hugh@veritas.com>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, "Seth, Rohit" <rohit.seth@intel.com>,
       linux-kernel@vger.kernel.org
Subject: RE: large page patch
Date: Tue, 6 Aug 2002 17:11:08 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hugh Dickins [mailto:hugh@veritas.com]
> Sent: Tuesday, August 06, 2002 1:52 PM
> To: Linus Torvalds
> Cc: Andrew Morton; Seth, Rohit; linux-kernel@vger.kernel.org
> Subject: Re: large page patch
> 
> 
> Some comments on Rohit's large page patch (looking at 
> Andrew's version).
> 
Thanks.

> I agree with keeping the actual large page handling separate, 
> per arch.
> 
> I agree that it's sensible to focus upon _large_ pages (e.g. 
> 4MB) here;
> grouping several pages together as superpages (e.g. 64KB), for non-x86
> TLB or other reasons, better handled automatically in another project.
>
I think lately at least we are all converging to this view that there is
place for both large_TLB_pages and superpages.
 
> I agree that large pages be kept right away from swap (VM_RESERVE).
> 
> But I disagree with new interfaces distinct from known mmap/shm/tmpfs
> usage, I think they will cause rather than save trouble.  It's using
> do_mmap_pgoff anyway, why not mmap itself?  Much prefer MAP_LARGEPAGE,
> SHM_LARGEPAGE - or might /dev/ZERO and TMPFS help, each on 
> large pages?
> 
In this design, there are few key differences between large_page related
calls and mmap system call.  Even though they are all eventually using
do_mmap_pgoff (just like shmat and mmap themselves).  Like the way
large_pages may or may not get shared across forks.  Also, don't have any
backing store for these pages (so fd and offset really don't apply, to some
extent that is also true for anonymous mappings).  Their fault behavior and
handling is also quite different. No partial unmaps etc.  .....Can be done
(by overloading something like MAP_LARGEPAGE with all the additional
features/attibutes that are currently embeded with new system calls.)but
would pollute some of the generic code. 

> munmap, mprotect, mremap patches are deficient: they just 
> check whether
> the first vma is VM_LARGEPAGE, but munmap and mprotect (and mremap's
> do_munmap in MREMAP_MAYMOVE|MREMAP_FIXED case) may span several vmas.
> 

Good catch.  See my comments below.

> So, must decide what to do when a VM_LARGEPAGE falls within do_munmap
> span: pre-scan would waste time, we rely on unmap_region to unmap
> at least length specified by user, we're not interested in splitting
> VM_LARGEPAGE areas, so I suggest when a VM_LARGEPAGE area falls partly
> or wholly within do_munmap span, it be wholly unmapped.  In 
> which case,
> no need for sys_free_large_pages and sys_unshare_large_pages.

It is obviously clear that we will have to take care of cases where a single
(for example) munmap request is touching vma that spans large TLBs.  I agree
with Hugh that pre-scan would be costly.  But at the same time, calls like
munmap have no knowlege of large_pages. One could potentially add checks in
these cases and jump effectively to do what sys_free_large pages is doing.
Or it will be nice if we take care of normal cases and skip over the regions
that map large_pages. I think the code in mprotect, mremap already allows
partial services.  It is the munmap where we don't already  have the
error/partial way out.  My preference would be to not touch large_pages and
skip over them.
Also, to some extent see we already have things like munmap and
shmdt....effectively doing the same thing but co-existing (I think mainly
because of the different semantics that have created those segments).
> 
> sys_share_large_pages: I'm having a lot of difficulty with this one,
> and its set_lp_shm_seg.  Share? but it says MAP_PRIVATE (whereas
> sys_get_large_pages forces MAP_SHARED).  Key?  we got that from a
> prior shmget? so already there's a tmpfs inode for this, and now
> we allocate some other inode?  No, I think it would be better off
> integrated a little more within tmpfs (perhaps no SHM_LARGEPAGE
> at all, just ordinary files in a TMPFS?  Rohit mentioned wanting
> ability to execute, straightforward from TMPFS file).
> 
Let me clarify sys_share_large_pages syscall: To start with, the syntax of
this call is sys_share_large_apges(int key, unsigned long addr, unsigned
long len, int prot, int flag) where 
	Key is system wide unique positive number (nothing to do with
shmget's key).  Idea is, user app decides how numbers are choosen (for
sharing data across unrelated processes.)  Though the intent was not to
relate these calls to shm* key, but seems like quite a few people are
reading it that way.  As Andrew once pointed out that we should change this
to something like shared fd.  And users can open a particular file to get an
fd that could be used to get at a particular chunk of large pages.  Sothere
is no connection between these new system calls and normal shm* related
system calls.

The parameters addr, len and prot have their usual meaning.

The parameter flag for sys_share_large_pages can only have 0 or IPC_CREAT.
Flag=IPC_CREAT tells the kernel, if the particular key is not already in use
then go ahead and create large_page segment.  Later references to this will
be done using the same key.  If user does not specify IPC_CREAT in flag and
there is no large_apge segment corresponding to key, the sys_call returns
ENOENT.  

Whereas, the flag parameter of sys_get_large_pages can take the values
MAP_PRIVATE or MAP_SHARED.  Here MAP_PRIVATE will mean that the large pages
will not be copied across forks to new address space (of child).  Where as
MAP_SHARED value means that new child process will share the same (physical)
large_pages with parent. (Intent is not to copy huge data across fork system
call and it is expected that correct design would want child and parent to
share the same data. Also if child really need of making this detached from
the parent will create his own new seg and copy the data.)

> change_large_page_mem_size: wouldn't it be better as
> set_large_page_mem_size, instead of by increments/decrements?
>
Well, I've found specifying the change easier than specifying new size.
This could easily be altered though.
 
> Whitespace offences, would benefit from a pass through Lindent.
> 
Will do that clean up in next update.

> Hugh
> 

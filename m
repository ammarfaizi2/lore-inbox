Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSHFUr3>; Tue, 6 Aug 2002 16:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSHFUr2>; Tue, 6 Aug 2002 16:47:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:61990 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S315783AbSHFUrZ>; Tue, 6 Aug 2002 16:47:25 -0400
Date: Tue, 6 Aug 2002 21:51:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>, "Seth, Rohit" <rohit.seth@intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch
In-Reply-To: <Pine.LNX.4.33.0208012133111.1857-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208062043310.1921-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some comments on Rohit's large page patch (looking at Andrew's version).

I agree with keeping the actual large page handling separate, per arch.

I agree that it's sensible to focus upon _large_ pages (e.g. 4MB) here;
grouping several pages together as superpages (e.g. 64KB), for non-x86
TLB or other reasons, better handled automatically in another project.

I agree that large pages be kept right away from swap (VM_RESERVE).

But I disagree with new interfaces distinct from known mmap/shm/tmpfs
usage, I think they will cause rather than save trouble.  It's using
do_mmap_pgoff anyway, why not mmap itself?  Much prefer MAP_LARGEPAGE,
SHM_LARGEPAGE - or might /dev/ZERO and TMPFS help, each on large pages?

munmap, mprotect, mremap patches are deficient: they just check whether
the first vma is VM_LARGEPAGE, but munmap and mprotect (and mremap's
do_munmap in MREMAP_MAYMOVE|MREMAP_FIXED case) may span several vmas.

So, must decide what to do when a VM_LARGEPAGE falls within do_munmap
span: pre-scan would waste time, we rely on unmap_region to unmap
at least length specified by user, we're not interested in splitting
VM_LARGEPAGE areas, so I suggest when a VM_LARGEPAGE area falls partly
or wholly within do_munmap span, it be wholly unmapped.  In which case,
no need for sys_free_large_pages and sys_unshare_large_pages.

sys_get_large_pages, if retained as a separate syscall,
would be easier to understand if named sys_mmap_large_pages?

sys_share_large_pages: I'm having a lot of difficulty with this one,
and its set_lp_shm_seg.  Share? but it says MAP_PRIVATE (whereas
sys_get_large_pages forces MAP_SHARED).  Key?  we got that from a
prior shmget? so already there's a tmpfs inode for this, and now
we allocate some other inode?  No, I think it would be better off
integrated a little more within tmpfs (perhaps no SHM_LARGEPAGE
at all, just ordinary files in a TMPFS?  Rohit mentioned wanting
ability to execute, straightforward from TMPFS file).

change_large_page_mem_size: wouldn't it be better as
set_large_page_mem_size, instead of by increments/decrements?

Whitespace offences, would benefit from a pass through Lindent.

Hugh


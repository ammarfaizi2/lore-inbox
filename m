Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbVJYGch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbVJYGch (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 02:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbVJYGch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 02:32:37 -0400
Received: from silver.veritas.com ([143.127.12.111]:48267 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751460AbVJYGch
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 02:32:37 -0400
Date: Tue, 25 Oct 2005 07:31:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nicolas Pitre <nico@cam.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
In-Reply-To: <Pine.LNX.4.64.0510241922040.5288@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0510250700360.5884@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com>
 <20051022170240.GA10631@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0510241922040.5288@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Oct 2005 06:32:36.0565 (UTC) FILETIME=[E3A0D050:01C5D92D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2005, Nicolas Pitre wrote:
> On Sat, 22 Oct 2005, Russell King wrote:
> > On Sat, Oct 22, 2005 at 05:22:20PM +0100, Hugh Dickins wrote:
> > > Signal handling's preserve and restore of iwmmxt context currently
> > > involves reading and writing that context to and from user space, while
> > > holding page_table_lock to secure the user page(s) against kswapd.  If
> > > we split the lock, then the structure might span two pages, secured by
> > > different locks.  That would be manageable; but it seems simpler just
> > > to read into and write from a kernel stack buffer, copying that out and
> > > in without locking (the structure is 160 bytes in size, and here we're
> > > near the top of the kernel stack).  Or would the overhead be noticeable?
> > 
> > Please contact Nicolas Pitre about that - that was my suggestion,
> > but ISTR apparantly the overhead is too high.
> 
> Going through a kernel buffer will simply double the overhead.  Let's 
> suppose it should not be a big enough issue to stop the patch from being 
> merged though (and it looks cleaner that way). However I'd like for the 
> WARN_ON((unsigned long)frame & 7) to remain as both the kernel and user 
> buffers should be 64-bit aligned.

Okay, thanks.  I can submit a patch to restore the WARN_ON later
(not today).  Though that seems very odd to me, can you explain?  I can
understand that the original kernel context needs to be 64-bit aligned,
and perhaps the iwmmxt_task_copy copy of it (I explicitly align that
buffer).  But I can't see why the saved copy in userspace would need
to be 64-bit aligned, if it's just __copy_to_user'ed and __copy_from_
user'ed.  Or is it also accessed in some other, direct way?

As to the overhead, let's see if it's serious or not in practice:
let me know if you find it to be a significant slowdown - thanks.

> > > arm_syscall's cmpxchg emulation use pte_offset_map_lock, instead of
> > > pte_offset_map and mm-wide page_table_lock; and strictly, it should now
> > > also take mmap_sem before descending to pmd, to guard against another
> > > thread munmapping, and the page table pulled out beneath this thread.
> > 
> > Now that I look at it, it's probably buggy - if the page isn't already
> > dirty, it will modify without the COW action.  Again, please contact
> > Nicolas about this.
> 
> I don't see how standard COW could not happen.  The only difference with 
> a true write fault as if we used put_user() is that we bypassed the data 
> abort vector and the code to get the FAR value.  Or am I missing 
> something?

It's certainly not buggy in the way that I thought (and I believe rmk
was thinking): you are checking pte_write, correctly within the lock,
so COW shouldn't come into it at all - it'll only work if the page is
already writable by the user.

But then I'm puzzled by your reply, saying you don't see how standard
COW could not happen.

Plus it seems a serious limitation: mightn't this be an area of executable
text that it has to write into, but is most likely readonly?  Or an area
of data made readonly by fork?  And is the alignment assured, that the
long will fit in one page only?

The better way to do it, I think, would be to use ptrace's
access_process_vm (it is our own mm, but that's okay).

Hugh

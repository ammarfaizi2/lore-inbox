Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUJZBTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUJZBTD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbUJZBLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:11:22 -0400
Received: from zeus.kernel.org ([204.152.189.113]:2762 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261899AbUJZBJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:09:21 -0400
Date: Tue, 26 Oct 2004 02:35:16 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-ID: <20041026003516.GP14325@dualathlon.random>
References: <20041021144531.22dd0d54.akpm@osdl.org> <20041021223613.GA8756@dualathlon.random> <20041021160233.68a84971.akpm@osdl.org> <20041021232059.GE8756@dualathlon.random> <20041021164245.4abec5d2.akpm@osdl.org> <20041022003004.GA14325@dualathlon.random> <20041022012211.GD14325@dualathlon.random> <20041021190320.02dccda7.akpm@osdl.org> <20041022161744.GF14325@dualathlon.random> <20041022162433.509341e4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022162433.509341e4.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 04:24:33PM -0700, Andrew Morton wrote:
> This is incorrect for ext3 - we have to go through the a_ops to invalidate
> the buffer_heads.  That's bad news for my (unmerged) 2.4 direct-io-for-ext3
> patch.

BTW, truncate_complete_page also calls into do_flushpage without asking
the fs. truncate_inode_pages does it too (that's probably where it comes
from, however truncate happens when the fs already giveup on the inode
that's probably why it's safe there).

> Only for mmapped pages.  I believe that normal pagecache-vs-directIO is OK
> in 2.6.

yes, as far as try_to_release_page cannot fail on non-mapped pages,
otherwise it would lose coherency. When exactly can try_to_release_page
return failure from the fs?

> And I agree that in that case we should propagate the
> invalidate_complete_page() failure back to the diret-io write() caller.  I wonder
> how - via a short write, or via -EFOO?

can we do a short write at all? The failure would come out of
try_to_release_buffers, we don't know which blocks failed to invalidate
there and in turn which pages would be visible right.  I suspect all we
can do is -EFOO (which sounds safer anyways since this is a fundamental
userspace race condition detection path, a -ERACE would possibly be
appropriate if it existed ;).

> Probably we should sync all the ptes prior to a direct-io read as well.

yes, we should msync all the mappings if you want to truly provide mmap
coherency to O_DIRECT. 

> I want to fix the mmap case too.  We currently have a half-fix for NFS
> which doesn't work at all for (say) ext3.

for nfs it worked good enough because all they care about is that if you
munmap and mmap again the new data is shown. all they care about is that
if they restart the program it sees the new data on the server.

Perfect mmap coherency is impossible with nfs due the stateless
protocol but for ext3 we could provide it (in theory).

But keep in mind 99% of the O_DIRECT userbase seems not to need it, if
you use O_DIRECT by design it means you have no mapping on that data and
you do the caching in userspace (otherwise mmap would be the api to
use). the two things are quite mutually exclusive.  This is why it
always looked an unnecessary slowdown to me, but it looks we might
implement it with little overhead for 2.6.

> It's important for NFS - it will allow mmaps to see server-side updates.

the folks I talked to only cares about munmap/mmap coherency, a
persistent mmap isn't required to see the new data.

> That's in 2.6.9.

ok fine.

> That's in 2.6.9 as well.  I need to think about this a bit more - the first

fine too ;)

> (You're using an rwlock for tree_lock.  It's still unclear to me whether we
> should go that way - it helps big SMP and hurts small SMP.  Did you perform
> an evaluation of this?)

I didn't change anything in that area, I've no clue who changed that.
since it's a spinlock it will most probably be only an overhead to have
rwlock. BTW, I've still to backport the semaphore to spinlock conversion
to 2.6.5 (I'm in the process of backporting the lowmem_reserve patch,
2.6.5 didn't even have the protection new better behaviour of 2.6.8+ so
I'm in the usual rejects procedures.. ;). Then there's Hugh's rss to
backport to 2.6.5 and finally this one patch you posted here for mmap
coherency.

> Sure.  That's why there's a BUG() there ;)

eheh ;)

> I don't think we have a bug here.  After the sync(), ext3_releasepage()
> will be able to release the buffers.  But we should check for failures.

this partly explains the above question (i.e. when exactly releasepage
can fail?).

> The problem we're seeing is with mmapped pages.  In that case, clearing
> PG_uptodate is insufficient and directly invalidating the buffer_heads will
> probably kill ext3 and we're not allowed to assume that page->private
> contains bh's anyway...
>
> Probably it is sufficient to run try_to_release_page() in the page_mapped
> leg of invalidate_inode_pages2(), and to check the return value.

I guess so. I mean ext3 cannot know the page is mapped. Returning
failure sounds more than good enough.

> mmap-vs-direct-IO coherency for both O_DIRECT reads and O_DIRECT writes, but
> permitting the pte shootdown on O_DIRECT reads trivially allows people to nuke
> other people's mapped pagecache.

for O_DIRECT reads you don't need to shootdown the ptes but only to
msync them. That would avoid a performance impact enforceable on
other users and it would leave the cost in the task issuing the msync
and walking the ptes. Since you provided either coherency or -EIO to the
O_DIRECT operation, it probably worth to add the msync as well in the
ptes before the O_DIRECT read hits the disk, no?

BTW, this is still not coherent at the block level, so if I write a
512byte block with O_DIRECT on one side and at the same time I write a
512byte block with mmap (or buffered write) the end result is still
undefined. But if somebody orders the writes, then it should work even
with mmap now (while previously it couldn't work even with
userspace-ordered I/O since the dirty bit in the pte would be simply
ignored by O_DIRECT). Correct?

> NFS also uses invalidate_inode_pages2() for handling server-side modification
> notifications.  But in the NFS case the clear_page_dirty() in
> invalidate_inode_pages2() is sufficient, because NFS doesn't have to worry
> about the "dirty buffers against a clean page" problem.  (I think)

indeed, nfs was the only safe one w.r.t. mappings.

patch looks good but perhaps we can add an msync (not an unmap) for
O_DIRECT reads too to reduce the magic?

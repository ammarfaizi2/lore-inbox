Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751732AbWAKUtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWAKUtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWAKUtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:49:15 -0500
Received: from gold.veritas.com ([143.127.12.110]:12668 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751731AbWAKUtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:49:14 -0500
Date: Wed, 11 Jan 2006 20:49:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
In-Reply-To: <20060111091327.GZ15897@opteron.random>
Message-ID: <Pine.LNX.4.61.0601111949070.6448@goblin.wat.veritas.com>
References: <20051213193735.GE3092@opteron.random> <20051213130227.2efac51e.akpm@osdl.org>
 <20051213211441.GH3092@opteron.random> <20051216135147.GV5270@opteron.random>
 <20060110062425.GA15897@opteron.random> <43C484BF.2030602@yahoo.com.au>
 <20060111082359.GV15897@opteron.random> <20060111005134.3306b69a.akpm@osdl.org>
 <20060111090225.GY15897@opteron.random> <20060111010638.0eb0f783.akpm@osdl.org>
 <20060111091327.GZ15897@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Jan 2006 20:49:14.0176 (UTC) FILETIME=[7B365C00:01C616F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, Andrea Arcangeli wrote:
> On Wed, Jan 11, 2006 at 01:06:38AM -0800, Andrew Morton wrote:
> > 
> > Confused.  do_no_page() doesn't have a page to lock until it has called
> > ->nopage.
> 
> yes, I mean doing lock_page after ->nopage returned it here:
> 
> 	lock_page(page);
> 	if (mapping && !page->mapping)
> 		goto bail_out;
> 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
> [..]
> 			page_add_file_rmap()
> 			unlock_page()

I've rather chosen this mail at random from the thread, and can't
come up with better than a few random remarks on it all, sorry.

Though using lock_page may solve more than one problem, without seeing
a full implementation I'm less sure than the rest of you that it will
really do the job.

And less confident than you and Nick that adding a sleeping lock here
in nopage won't present a scalability issue.  Though it gives me a
special thrill to see Nick arguing in favour of extra locking ;)

Keep in mind that in the truncate case, it's the original shared file
page that needs to be locked and tested, when deciding whether it's
okay to insert a COWed anonymous copy (even COWed areas must SIGBUS).

Don't forget to update mm/fremap.c's install_page, which we forgot
originally when doing the truncate_count business.

But when fixing that (not me who noticed the problem), I found we
didn't really need to rely on truncate_count there, just mapping and
i_size: because in install_page we could be sure it was (or had been)
a page cache page with mapping set.  The need for truncate_count
arises from the uncertainty when do_no_page returns from ->nopage,
whether it was a pagecache kind of nopage (which would set mappping),
or a weird driver kind of nopage (which would not).

If coming here again, I think I'd have a VM_ flag for that: almost
corresponds to VM_RESERVED (as I think you were keying off in your SuSE
tree) but better to make it specific to pagecache, or truncatability -
to say mapping ought to be non-NULL, and if it's found NULL after
grabbing pte_lock, then it must have been truncated/invalidated off.

Didn't examine in detail, but I didn't care for your seqschedlock
implementation.  Partly the overdesign of a new locking scheme for
just one usage (seqschedlock.h missing from your recent send, by
the way, but I assume same as last month's) - fine when more uses
come along later, but seemed premature, and better to concentrate
on the immediate need for now.

And partly that you seemed to be leaving the truncate case handled
by one technique (truncate_count) and the invalidate case handled by
another (seqschedlock): much more satisfying to handle them both in
the same-ish way.

But yes, they do differ significantly: treatment of COW pages,
applicability of i_size, wait rather than error out when invalidate.
Perhaps I underestimate the effect of those differences.

I don't think you'll be able to eliminate truncate_count so easily,
since I put it to further use, with a matching vm_truncate_count,
to handle the latency while unmapping vmas from the prio_tree.

I've never got to grips with invalidate_inode_pages, or its more
exciting sequel "Invalidate Inode Pages II".  Last time I looked
(2.6.10-ish) both looked racy, neither very serious.  Alarmed now
to see that while I was attacking latency below unmap_mapping_range,
Andrew was adding unmap_mapping_range calls into iipages2.

I'd been working on the assumption that i_sem is held across it,
but that seems not to be the case, in NFS uses at least (I've
given up further researches to write this mail).  But miraculously
(or by Andrew's careful checking) it looks to me like it is okay:
if there are concurrent unmappings, i_mmap_lock protects truncate_
count and vm_truncate_count modifications, and unmap_mapping_range_tree
won't do worse than fail to skip vmas it has already dealt with.

But I do not know what guarantees invalidate_inode_pages2 is supposed
to give.  As soon as you emerge from iipages2, its work could be undone:
I suppose it provides a serialization point, ensures that you go down to
filesystem once, rather than being satisfied by the pagecache.

Hugh

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290238AbSAXDJJ>; Wed, 23 Jan 2002 22:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290240AbSAXDI7>; Wed, 23 Jan 2002 22:08:59 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:18280 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290238AbSAXDIo>; Wed, 23 Jan 2002 22:08:44 -0500
Date: Thu, 24 Jan 2002 04:09:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
Message-ID: <20020124040937.C20533@athlon.random>
In-Reply-To: <20020123003449.F1547@athlon.random> <Pine.LNX.4.21.0201230451540.1368-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0201230451540.1368-100000@localhost.localdomain>; from hugh@veritas.com on Wed, Jan 23, 2002 at 05:38:47AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 05:38:47AM +0000, Hugh Dickins wrote:
> On Wed, 23 Jan 2002, Andrea Arcangeli wrote:
> > 
> > page->virtual will remain for all the DEFAULT serie, to avoid breaking
> > the regular kmap pagecache users. But to keep a page->virtual for each
> > serie we'd need a page->virtual[KM_NR_SERIES] array, which is very
> > costly in terms of ram, ....
> 
> Agreed, not an option we'd want to use.
> 
> > correct. I'm convinced the mixture problem invalidates completly the
> > deadlock avoidance using the series, so the only way to fix the
> > deadlocks is to avoid the mixture between the series.
> 
> First half agreed, second half not sure.  Maybe no series at all.
> Could it be worked with just the one serie, and count in task_struct
> of kmaps "raised" by task, only task with count >=1 allowed to take
> the last N kmaps?  I suspect something like that would work if not
> scheduling otherwise, but no good held across allocating another
> resource e.g. memory in fault.  Probably rubbish, not thought out

I can imagine an alternate design to avoid the deadlock without the
series (doesn't sound exactly what you had in mind with count >= 1, but
it's on the same lines about using the task_struct to keep some per-task
information about the kmaps), it has some more overhead though, but it
has the very nice goodness of also invalidating the ordering
requirements.

The only new requirement would become the max number of kmap run by a single
task in sequence (which is not a new requirement, we had the very
requirement before too which was the NR_KMAP_SERIES).

The first kmap run by a task will try to reserve the MAX_NR_TASK_KMAPS
slots (we can keep track if it's the first kmap with some task_structure
field, on the lines of what you suggested), if it fails to reserve all
of them, it will release the ones it tried to allocate in the meantime
and it will go to sleep waiting for the resourced to be released by
somebody else. If it succeed it will use the first reserved entry to
succeed the kmap. The later kmaps will use the other two reserved kmap
slots preallocated at the first kmap. If the kernel tries to allocate
one more kmap entry over MAX_NR_TASK_KMAPS we can BUG().

In short this makes sure if a kmap has to sleep, it will always be the
first one. This ensures the deadlock avoidance.

This would solve not only the deadlock but it also drops the ordering
requirements, plus it will solve the mixture thing as well
(optimizations are possible, if the first kmap maps a page just mapped
we'd need to reserve only MAX_NR_TASK_KMAPS-1 entries, simply doing the
reservation + first kmap atomically, which will be natural). We can
define MAX_NR_TASK_KMAPS (suggestions for a better define name are
welcome) to 3, one for the kmap for the pagecache, one for the first
pagetable, and one for the second pagetable map (mremap). 

Comments? Now I tend to believe this way is simpler after all, mostly
because it doesn't create special cases with special series, and it
makes life simpler for the kmap users, in short it reduces the
anti-deadlock requirement dramatically.

> fully, just mentioned in case it gives you an idea.  Another such
> half-baked idea I've played with a little is using one or two ptes
> of the user address space (e.g. at top of stack) as per-task kmaps.
> 
> > The ordering thing is really simple I think. There are very few places
> > where we kmap and kmap_pagetable at the same time. And I don't see how
> > can could ever kmap before kmap_pagetable. so that part looks fine to me.
> 
> Nice if that's so, but I think you're sadly deluded ;-)
> Imagine sys_read going to file_read_actor (kmap, __copy_to_user, kunmap),
> imagine the __copy_to_user faulting (needs to kmap the pagetable),

I said the reverse, but this is the right path I meant of course. I
didn't see the other way happening anywhere, mostly because it would be
a bug if we would ever kmap during pagefaults because we could deadlock
just now in such a case.

> imagine the place faulted is hole in ???fs file (kmap in
> clear_highpage),

we can't call clear_highpage during page faults (hey, if we would ever
do, that would be just a deadlock condition right now in 2.4.17 too,
without pte-highmem applied :).

> imagine low on memory schedules all over.

schedules really shouldn't matter at all here.

thanks again for the helpful feedback,

Andrea

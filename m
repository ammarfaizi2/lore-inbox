Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288325AbSAXPeC>; Thu, 24 Jan 2002 10:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288377AbSAXPdy>; Thu, 24 Jan 2002 10:33:54 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:48008 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S288325AbSAXPdj>; Thu, 24 Jan 2002 10:33:39 -0500
Date: Thu, 24 Jan 2002 15:35:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: pte-highmem-5
In-Reply-To: <20020124040937.C20533@athlon.random>
Message-ID: <Pine.LNX.4.21.0201241416320.1044-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me reorder the mail (to avoid deadlock:) commenting on last first...

On Thu, 24 Jan 2002, Andrea Arcangeli wrote:
> On Wed, Jan 23, 2002 at 05:38:47AM +0000, Hugh Dickins wrote:
> > On Wed, 23 Jan 2002, Andrea Arcangeli wrote:
> > > The ordering thing is really simple I think. There are very few places
> > > where we kmap and kmap_pagetable at the same time. And I don't see how
> > > can could ever kmap before kmap_pagetable. so that part looks fine to me.
> > 
> > Nice if that's so, but I think you're sadly deluded ;-)
> > Imagine sys_read going to file_read_actor (kmap, __copy_to_user, kunmap),
> > imagine the __copy_to_user faulting (needs to kmap the pagetable),
> 
> I said the reverse, but this is the right path I meant of course. I
> didn't see the other way happening anywhere, mostly because it would be
> a bug if we would ever kmap during pagefaults because we could deadlock
> just now in such a case.
> 
> > imagine the place faulted is hole in ???fs file (kmap in
> > clear_highpage),
> 
> we can't call clear_highpage during page faults (hey, if we would ever
> do, that would be just a deadlock condition right now in 2.4.17 too,
> without pte-highmem applied :).

Does your ";)" mean that you know very well that it's done in
several places?  I may be mistaken, but block_read_full_page,
nfs_readpage_sync, ramfs_readpage and shmem_getpage_locked (latter
a clear_highpage), all look like they use kmap in a place which could
deadlock already.  I bet there are other instances.  So far as I know,
we've not actually seen such deadlocks, the current LAST_PKMAP 1024
appears in practice to be enough to make them very unlikely (so far;
and I feel much safer now you've lifted the 512 limit on HIGHMEM64G).
I've CC'ed Ben: I think he atomicized some kmapping copy macros a
few months back, may have a view on this.

And now to the first part:

> I can imagine an alternate design to avoid the deadlock without the
> series (doesn't sound exactly what you had in mind with count >= 1, but
> it's on the same lines about using the task_struct to keep some per-task
> information about the kmaps), it has some more overhead though, but it
> has the very nice goodness of also invalidating the ordering
> requirements.
> 
> The only new requirement would become the max number of kmap run by a single
> task in sequence (which is not a new requirement, we had the very
> requirement before too which was the NR_KMAP_SERIES).
> 
> The first kmap run by a task will try to reserve the MAX_NR_TASK_KMAPS
> slots (we can keep track if it's the first kmap with some task_structure
> field, on the lines of what you suggested), if it fails to reserve all
> of them, it will release the ones it tried to allocate in the meantime
> and it will go to sleep waiting for the resourced to be released by
> somebody else. If it succeed it will use the first reserved entry to
> succeed the kmap. The later kmaps will use the other two reserved kmap
> slots preallocated at the first kmap. If the kernel tries to allocate
> one more kmap entry over MAX_NR_TASK_KMAPS we can BUG().
> 
> In short this makes sure if a kmap has to sleep, it will always be the
> first one. This ensures the deadlock avoidance.
> 
> This would solve not only the deadlock but it also drops the ordering
> requirements, plus it will solve the mixture thing as well
> (optimizations are possible, if the first kmap maps a page just mapped
> we'd need to reserve only MAX_NR_TASK_KMAPS-1 entries, simply doing the
> reservation + first kmap atomically, which will be natural). We can
> define MAX_NR_TASK_KMAPS (suggestions for a better define name are
> welcome) to 3, one for the kmap for the pagecache, one for the first
> pagetable, and one for the second pagetable map (mremap). 
> 
> Comments? Now I tend to believe this way is simpler after all, mostly
> because it doesn't create special cases with special series, and it
> makes life simpler for the kmap users, in short it reduces the
> anti-deadlock requirement dramatically.

At first I was very enthusiastic about this proposal: it gives solid,
convincing protection against kmap deadlocks.  But I have two doubts.

The first, minor doubt is that I don't believe you can BUG() beyond
MAX_NR_TASK_KMAPS: in 2.5 perhaps, or a 2.4-pre, but I think we have
to live with the fact that there are or may already be potential kmap
deadlocks, and in a release it would be more harmful to BUG on every
entry to that potential, than to hang if it actually deadlocks (but
we must make LAST_PKMAP large enough to make that unlikely enough).

I think your MAX would be 2 not 3, unless you are allowing for the
danger kmaps such as I list above.  Neither mremap nor copy_page_range
is done during a fault, there's no underlying kmap, they can use both.
But what about the loop driver?  Can that raise the max? indefinitely?

The second, major doubt is: I don't see how this could be implemented,
without making kmaps so much more heavyweight than they are at present,
that we'd avoid them wherever possible (going for the atomic alternative
in many places).  Every kmap_high which at present finds page->virtual
set and increments pkmap_count, would in the new scheme have to go and
find MAX_NR_TASK_KMAPS-1 free slots, and increment their pkmap_counts;
yet what proportion of these tasks would go on to use the additional
kmaps?  If you can implement it with little overhead, it'll be great!

I've been thinking less ambitiously.  Not worrying about the existing
potential deadlocks, just making sure that pagetable kmaps won't
increase the possibility of deadlock at all.  I'm sure just doubling
LAST_PKMAP would not be sufficient: the way a pagetable kmap is held
over the page allocation, the system under memory pressure could
degrade to a point where all the kmaps were held by faulting
pagetables.  I'm thinking of limiting the total number of pagetable
kmaps at any one time, and using pte_offset_nowait everywhere(?)
i.e. regetting the mapping, hopefully still cached in page->virtual,
after possibly waiting to allocate page.

Hugh


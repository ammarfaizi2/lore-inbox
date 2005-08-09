Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVHISLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVHISLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 14:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVHISLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 14:11:49 -0400
Received: from silver.veritas.com ([143.127.12.111]:31369 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964906AbVHISLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 14:11:48 -0400
Date: Tue, 9 Aug 2005 19:13:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Roland Dreier <roland@topspin.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
In-Reply-To: <20050726133553.GA22276@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0508091759050.14886@goblin.wat.veritas.com>
References: <20050719165542.GB16028@mellanox.co.il> <20050725171928.GC12206@mellanox.co.il>
 <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com>
 <20050726133553.GA22276@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Aug 2005 18:11:48.0282 (UTC) FILETIME=[CEFE11A0:01C59D0D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for my delay in replying...

On Tue, 26 Jul 2005, Michael S. Tsirkin wrote:
> Quoting Hugh Dickins <hugh@veritas.com>:
> > Subject: Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
> > 
> > On Mon, 25 Jul 2005, Michael S. Tsirkin wrote:
> > > 
> > > This patch adds PROT_DONTCOPY to mmap and mprotect, to set VM_DONTCOPY on vma.
> > > This is needed for infiniband userspace i/o, where we need to protect against
> > >   - the child process accessing the parent hardware page
> > >   - the parent registered address (on which the driver did get_user_pages)
> > >     getting remapped to another page by COW
> > > One can imagine other uses, e.g. combined with mlock for real-time or security.
> > 
> > I don't much like it, but it does solve a real problem in an efficient way.
> > 
> > Partly I don't like it because of "PROT_DONTCOPY" itself: I'm queasy
> > about protection flags which are not protection flags, though I find
> > you're not the first to go down that road.
> 
> Yes. Compare with PROT_GROWSDOWN and such.

Though if you look deeper into that, you find that PROT_GROWSDOWN and
PROT_GROWSUP are all about determining the start or end of the range
when it's the stack: nothing to do with the protection flags set.

Which inclines me the more against using mprotect to set VM_DONTCOPY.

> > Is the patch tested?  I've not tried, but suspect the newflags shift
> > and mask won't work for it.
> 
> I tested this patch. I didnt test all thinkable configurations of
> flags though - what do you mean by "newflags shift and mask"?

My error.  See further down where the code is shown.

> > And I don't look forward to your adding
> > VM_MAYDONTCOPY - ugh!
> 
> We already have VM_DONTCOPY. Why would we need VM_MAYDONTCOPY and what
> would it do?
> 
> > > @@ -246,7 +246,7 @@ sys_mprotect(unsigned long start, size_t
> > >  			goto out;
> > >  		}
> > >  
> > > -		newflags = vm_flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC));
> > > +		newflags = vm_flags | (vma->vm_flags & ~(VM_READ | VM_WRITE | VM_EXEC | VM_DONTCOPY));
> > >  
> > >  		if ((newflags & ~(newflags >> 4)) & 0xf) {
> > >  			error = -EACCES;

That newflags shift and mask is checking VM_READ,VM_WRITE,VM_EXEC against
VM_MAYREAD,VM_MAYWRITE,VM_MAYEXEC (the same bits shifted up/down 4).
It's checking, for example, whether the caller actually has permission
to mprotect the mapping to make writes to the file.

But I was reading it wrongly, sorry: I thought you were going to need a
VM_MAYDONTCOPY bit in order to give permission for you to mprotect the
mapping to VM_DONTCOPY.  No, it's only checking the bottom four bits
(including VM_SHARED against VM_MAYSHARE, but that's never changed).

> > I rather think it would all be more cleanly handled by dropping the mmap
> > and mprotect changes,
> 
> Well, mmap would be much better off if VM_DONTCOPY is set atomically, since
> a process may fork after mmap is called but before madvise.

But it doesn't matter if the process does fork after mmap before madvise.
It only starts to matter when you do get_user_pages (for writing): that
will break COW on the private pages made readonly by a preceding fork,
your problem is when a fork occurs after that to make them readonly.

> > adding an madvise instead.
> 
> I'm not opposed to this, on principle. But see below.
> 
> > Though you may object
> > that madvise is for optional behaviours, and this should be mandatory.
> 
> What about a new system call?
> Or a flag for mprotect that effectively turns it into a new system call?
> Something like PROT_EXTENDED?

PROT_DONTCOPY seems quite enough to signal the extension,
if we were to go the mprotect route.

> > The other reason I dislike the patch is that the problem it fixes is
> > an old one, and I'd much rather have get_user_pages fix it for itself,
> 
> Please note that the problem this attempts to solve is not limited
> to pages locked by get_user_pages: in an infiniband userspace initiator,
> a hardware page is mapped into process memory and must not be inherited
> by a child processes, otherwise hardware protection breaks.

Interesting.

But (correct me if I'm wrong, I know nothing about InfiniBand userspace
initiators) that would be done by a driver, which can set VM_DONTCOPY
on the vma, without us having to extend the mprotect or madvise API

> > than ask the developer to do some additional magic to get around it.
> >
> > But I've failed to work out a simple efficient alternative, which won't
> > burden the vast majority of get_user_pages usages which never hit the
> > issue.
> 
> They dont hit it if they keep the mm semaphore, or if they only lock
> pages for read.

I think the usual case is simply that userspace does not touch those
pages while they are pinned by get_user_pages, and/or it does not fork.
But we have occasionally got bitten by the issue.

> > So your way is probably appropriate, but I'd prefer madvise.
> 
> The difficulty with changing get_user_pages, as I see it, is that
> you wont be able to get away with a single DONTCOPY bit - you'll need
> a full reference count for each page, no less.

Quite possibly: I only thought it through far enough to conclude that
your proposal has the great merit of simplicity in comparison,
despite its dubious interface.

> > (Sorry, I won't be able to discuss further for a couple of days.)

Please correct that to weeks ;)

> Well, madvise currently cant break/merge VMAs, which is required
> for VM_DONTCOPY. And it seems like making madvise do this opens
> a whole cans of worms.

madvise has been splitting vmas forever, and was enhanced to remerge
them 2.6.13-rc.

> Hugh, so the patch is likely to be bigger in the madvise approach.
> Considering this, and the fact that a full solution has to add
> a flag to mmap, anyway, do you still think madvise is really the best way
> to do it?

Has to add a flag to mmap?  I didn't buy your "atomic" argument above,
did I miss something?

I still prefer madvise to mprotect for this, but admit neither is
entirely clean, would rather let someone else decide between them.

Even more I'd prefer one of these two solutions below, which sidestep
that uncleanliness - but both of these would be in mmap only, no clean
way to change afterwards (except by munmap or mmap MAP_FIXED):

1.  Use the standard mmap(NULL, len, PROT_READ|PROT_WRITE,
    MAP_SHARED|MAP_ANONYMOUS, -1, 0) which gives you a memory object
    shared with children, so write-protection and COW won't come into it.

or if there's good reason why that's no good,

2.  Define a MAP_DONTCOPY to mmap: we have a fine tradition of MAP_flags
    to achieve this or that effect, adding one more would be cleaner than
    now corrupting mprotect or madvise.

> Regarding solving the problem automagically by get_user_pages:
> 
> What about a new VM_COPYONFORK flag, to trigger the old unix
> behaviour of copying the vma on fork and a flag for get_user_pages
> that sets it?  Only users that dont keep the mm semaphore around
> the get_user_pages/put_page operation would use this flag, others
> would be unaffected. The flag will stay on until the VMA is destroyed.

(I don't understand why you propose a new flag for the usual behaviour,
but that's just a matter of which way round it's defined, not important.)

Splitting a vma from within get_user_pages is not straightforward,
we need down_write(&mm->mmap_sem) for a start; I think we'd all prefer
to avoid that if we can - as I said, your proposal rather simpler.

Coincidentally, Linus has drawn my attention in the last week to some
uses of get_user_pages which are behaving in a way which I believe
is currently mishandled, and may need splitting the vma.  But I don't
think you should wait around for however we decide to fix that issue.

Hugh

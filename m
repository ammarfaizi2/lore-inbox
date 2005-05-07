Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVEGQai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVEGQai (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 12:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVEGQai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 12:30:38 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:63816 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261339AbVEGQaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 12:30:18 -0400
Date: Sat, 7 May 2005 17:30:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Timur Tabi <timur.tabi@ammasso.com>
cc: Libor Michalek <libor@topspin.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
       implementation
In-Reply-To: <427CD49E.6080300@ammasso.com>
Message-ID: <Pine.LNX.4.61.0505071617470.5718@goblin.wat.veritas.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> 
    <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> 
    <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> 
    <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> 
    <20050411171347.7e05859f.akpm@osdl.org> 
    <20050412180447.E6958@topspin.com> <20050425203110.A9729@topspin.com> 
    <4279142A.8050501@ammasso.com> <427A6A7E.8000604@ammasso.com> 
    <427BF8E1.2080006@ammasso.com> 
    <Pine.LNX.4.61.0505071304010.4713@goblin.wat.veritas.com> 
    <427CD49E.6080300@ammasso.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 07 May 2005 16:30:16.0815 (UTC) 
    FILETIME=[0D5D77F0:01C55322]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2005, Timur Tabi wrote:
> 
> > Oh, well, maybe, but what is the real problem?
> > Are you sure that copy-on-write doesn't come into it?
> 
> No, but I do know that my test case doesn't call fork(), so it's reproducible
> without involving COW.  Of course, I'm sure someone's going to tell me now
> that COW comes into effect even without fork().  If so, please explain.

I'll try.  COW comes into effect whenever you're sharing a page and
then need to make private changes to it.  Fork is one way of sharing
(with ancestor and descendant processes).  Using the empty zero page
is another way of sharing (with all other processes and parts of your
own address space with a readonly page full of zeroes).  Using a file
page from the page cache is another way of sharing.

None of those is actually your case, but our test for whether a page
is shared has been inadequate: oversimplifying, if page_count is more
than 1 then we have to assume it is shared and do the copy-on-write
(if the modifications are to be private).  But there are various places
where the page_count is temporarily raised (e.g. while paging out),
which we cannot distinguish, so occasionally we'll copy on write even
when it's not necessary, but we lack the information to tell us so.

In particular, of course, get_user_pages raises page_count to pin
the page: so making a page appear shared when it's not shared at all.

> The short answer: under "extreme" memory pressure, the data inside a page
> pinned by get_user_pages() is swapped out, moved, or deleted (I'm not sure
> which).  Some other data is placed into that physical location.
> 
> By extreme memory pressure, I mean having the process allocate and touch as
> much memory as possible.  Something like this:
> 
> num_bytes = get_amount_of_physical_ram();
> char *p = malloc(num_bytes);
> for (i=0; i<num_bytes; i+=PAGE_SIZE)
> p[i] = 0;
> 
> The above over-simplified code fails on earlier 2.6 kernels (or earlier
> versions of glibc that accompany most distros the use the earlier 2.6
> kernels).  Either malloc() returns NULL, or the p[i]=0 part causes a segfault.
> I haven't bothered to trace down why.  But when it does work, the page pinned
> by get_user_pages() changes.

Which has to be a bug with get_user_pages, which has no other purpose
than to pin the pages.  I cannot criticize you for working around it
to get your app working on lots of releases, but what _we_ have to do
is fix get_user_pages - and it appears that Andrea did so a year ago.

I'm surprised if it's as simple as you describe (you do say over-
simplified, maybe the critical points have fallen out), since GUP
users would have complained long ago if it wasn't doing the job in
normal cases of memory pressure.  Andrea's case does involve the
process independently trying to touch a page it has pinned for I/O
with get_user_pages.  Or (and I've only just thought of this, suspect
it might be exactly your case) not touch, but apply get_user_pages
again to a page already so pinned (while memory pressure has caused
try_to_unmap_one temporarily to detach it from the user address space
- the aspect of the problem that Andrea's fix attacks).

> My understanding is that mlock() could in theory allow the page to be moved,
> but that currently nothing in the kernel would actually move it.  However,
> that could change in the future to allow hot-swapping of RAM.

That's my understanding too, that nothing currently does so.  Aside from
hot-swapping RAM, there's also a need to be able to migrate pages around
RAM, either to unfragment memory allowing higher-order allocations to
succeed more often, or to get around extreme dmamem/normal-mem/highmem
imbalances without dedicating huge reserves.  Those would more often
succeed if uninhibited by mlock.

> So I need to take into account distro vendors that use an earlier kernel, like
> 2.6.5, and back-port the patch from 2.6.7.  The distro vendor will keep the
> 2.6.5 version number, which is why I can't rely on it.
> 
> I need to know exactly what the fix is, so that when I scan mm/rmap.c, I know
> what to look for.  Currently, I look for this regex:
> 
> try_to_unmap_one.*vm_area_struct
> 
> which seems to work.  However, now I think it's just a coincidence.

Perhaps any release based on 2.6.7 or above, or any release which
mentions "get_user_pages" in its mm/rmap.c or mm/objrmap.c?

> > By the way, please don't be worried when soon the try_to_unmap_one
> > comment and code that you identified above disappear.  When I'm
> > back in patch submission mode, I'll be sending Andrew a patch which
> > removes it, instead reworking can_share_swap_page to rely on the
> > page_mapcount instead of page_count, which avoids the ironical
> > behaviour my comment refers to, and allows an awkward page migration
> > case to proceed (once unpinned).  Andrea and I now both prefer this
> > page_mapcount approach.
> 
> Ugh, that means my regex is probably going to break.  Not only that, but I
> don't understand what you're saying either.  Trying to understand the VM is
> really hard.

Sorry about that, but suiting your regex is low in our priorities for
VM design!  I was tempted to offer to keep a comment on get_user_pages
in mm/rmap.c after the change, but that's really rather babyish: just
assume 2.6.7 and upwards are fixed (or complain if you find not).

Perhaps I'll manage a clearer explanation when I come to write the
change description for the patch, we'll have to see.

> I guess in this specific case, it doesn't really matter, because calling
> mlock() when I should be calling get_user_pages() is not a bad thing.

If you can afford to keep that amount of memory mlocked, and have to
capability to do so, yes, it should do no harm.  We were just upset
to think that mlock was still needed to get around a get_user_pages
bug which was fixed a year ago.

Hugh

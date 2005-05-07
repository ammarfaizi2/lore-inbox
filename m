Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVEGOqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVEGOqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 10:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVEGOqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 10:46:25 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:53739 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261361AbVEGOqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 10:46:06 -0400
Message-ID: <427CD49E.6080300@ammasso.com>
Date: Sat, 07 May 2005 09:45:50 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Libor Michalek <libor@topspin.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
    implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>     <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>     <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com>     <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com>     <20050411171347.7e05859f.akpm@osdl.org>     <20050412180447.E6958@topspin.com> <20050425203110.A9729@topspin.com>     <4279142A.8050501@ammasso.com> <427A6A7E.8000604@ammasso.com>     <427BF8E1.2080006@ammasso.com> <Pine.LNX.4.61.0505071304010.4713@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0505071304010.4713@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> Oh, well, maybe, but what is the real problem?
> Are you sure that copy-on-write doesn't come into it?

No, but I do know that my test case doesn't call fork(), so it's reproducible without 
involving COW.  Of course, I'm sure someone's going to tell me now that COW comes into 
effect even without fork().  If so, please explain.

> I haven't reread through the whole thread, but my recollection is
> that you never quite said what the real problem is: you'd found some
> time ago that get_user_pages sometimes failed to pin the pages for
> your complex app, so were forced to mlock too; but couldn't provide
> any simple test case for the failure (which can indeed be a lot of
> work to devise), so we were all in the dark as to what went wrong.

The short answer: under "extreme" memory pressure, the data inside a page pinned by 
get_user_pages() is swapped out, moved, or deleted (I'm not sure which).  Some other data 
is placed into that physical location.

By extreme memory pressure, I mean having the process allocate and touch as much memory as 
possible.  Something like this:

num_bytes = get_amount_of_physical_ram();
char *p = malloc(num_bytes);
for (i=0; i<num_bytes; i+=PAGE_SIZE)
   p[i] = 0;

The above over-simplified code fails on earlier 2.6 kernels (or earlier versions of glibc 
that accompany most distros the use the earlier 2.6 kernels).  Either malloc() returns 
NULL, or the p[i]=0 part causes a segfault.  I haven't bothered to trace down why.  But 
when it does work, the page pinned by get_user_pages() changes.

> But you've now found that 2.6.7 and later kernels allow your app to
> work correctly without mlock, good.  get_user_pages is certainly the
> right tool to use for such pinning.  (On the question of whether
> mlock guarantees that user virtual addresses map to the same physical
> addresses, I prefer Arjan's view that it does not; but accept that
> there might prove to be difficulties in holding that position.)

My understanding is that mlock() could in theory allow the page to be moved, but that 
currently nothing in the kernel would actually move it.  However, that could change in the 
future to allow hot-swapping of RAM.

> So, it works now, you've exonerated today's get_user_pages, and you've
> identified at least one get_user_pages fix which went in at that time:
> do we really need to chase this further?

My driver needs to support all 2.4 and 2.6 kernel versions.  My makefile scans the kernel 
source tree with 'grep' to identify various characterists, and I use #ifdefs to 
conditionally compile code depending on what features are present in the kernel.  I can't 
use the kernel version number, because that's not reliable - distros will incorporate 
patches from future kernels without changing the version ID.

So I need to take into account distro vendors that use an earlier kernel, like 2.6.5, and 
back-port the patch from 2.6.7.  The distro vendor will keep the 2.6.5 version number, 
which is why I can't rely on it.

I need to know exactly what the fix is, so that when I scan mm/rmap.c, I know what to look 
for.  Currently, I look for this regex:

try_to_unmap_one.*vm_area_struct

which seems to work.  However, now I think it's just a coincidence.

> By the way, please don't be worried when soon the try_to_unmap_one
> comment and code that you identified above disappear.  When I'm
> back in patch submission mode, I'll be sending Andrew a patch which
> removes it, instead reworking can_share_swap_page to rely on the
> page_mapcount instead of page_count, which avoids the ironical
> behaviour my comment refers to, and allows an awkward page migration
> case to proceed (once unpinned).  Andrea and I now both prefer this
> page_mapcount approach.

Ugh, that means my regex is probably going to break.  Not only that, but I don't 
understand what you're saying either.  Trying to understand the VM is really hard.

I guess in this specific case, it doesn't really matter, because calling mlock() when I 
should be calling get_user_pages() is not a bad thing.

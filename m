Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263094AbVEGNRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbVEGNRi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 09:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVEGNRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 09:17:38 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:41671 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263094AbVEGNRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 09:17:32 -0400
Date: Sat, 7 May 2005 14:18:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Timur Tabi <timur.tabi@ammasso.com>
cc: Libor Michalek <libor@topspin.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
    implementation
In-Reply-To: <427BF8E1.2080006@ammasso.com>
Message-ID: <Pine.LNX.4.61.0505071304010.4713@goblin.wat.veritas.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> 
    <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> 
    <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> 
    <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> 
    <20050411171347.7e05859f.akpm@osdl.org> 
    <20050412180447.E6958@topspin.com> <20050425203110.A9729@topspin.com> 
    <4279142A.8050501@ammasso.com> <427A6A7E.8000604@ammasso.com> 
    <427BF8E1.2080006@ammasso.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 07 May 2005 13:17:31.0094 (UTC) 
    FILETIME=[1FA87F60:01C55307]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for not replying earlier (indeed, sorry for not joining in the
wider RDMA pinning discussion), concentrating on other stuff at present.

On Fri, 6 May 2005, Timur Tabi wrote:
> Timur Tabi wrote:
> 
> > I haven't gotten a reply to this question, but I've done my own research,
> > and I think I found the answer.  Using my own test of get_user_pages(),
> > it appears that the fix was placed in 2.6.7.  However, I would like to
> > know specifically what the fix is. Unfortunately, tracking this stuff
> > down is beyond my understanding of the Linux VM.
> 
> I'm also still waiting for a reply to this question. Anyone????
> 
> Upon doing some more research, I think the fix might be those code instead:

I believe you're right this time - I was rather puzzled by your earlier
choice, then unhelpfully forgot to reply and point you a few lines further
down to this comment, which does shout "get_user_pages fix" quite loudly.

> /*
> * Don't pull an anonymous page out from under get_user_pages.
> * GUP carefully breaks COW and raises page count (while holding
> * page_table_lock, as we have here) to make sure that the page
> * cannot be freed.  If we unmap that page here, a user write
> * access to the virtual address will bring back the page, but
> * its raised count will (ironically) be taken to mean it's not
> * an exclusive swap page, do_wp_page will replace it by a copy
> * page, and the user never get to see the data GUP was holding
> * the original page for.
> */
> if (PageSwapCache(page) &&
> page_count(page) != page->mapcount + 2) {
> ret = SWAP_FAIL;
> goto out_unmap;
> }
> 
> Both this change and the other one I mentioned are new to 2.6.7.  I suppose I
> could try applying these patches to the 2.6.6 kernel and see if anything
> improves, but that won't help me understand what's really going on.

There's a lot of change in the rmap area between 2.6.6 and 2.6.7, but
you're right that this is an isolated fix, which could in principle be
applied to earlier releases.  Though I don't see it's worth doing now.

> The above comment makes sounds almost like it's a fix,

Almost?  Sorry if my comment doesn't make it obvious it's a fix for a
get_user_pages issue - I rewrote Andrea Arcangeli's original commment.
The analysis and fix are his.

> but it talks about copy-on-write,
> which is has nothing to do with the real problem.

Oh, well, maybe, but what is the real problem?
Are you sure that copy-on-write doesn't come into it?

I haven't reread through the whole thread, but my recollection is
that you never quite said what the real problem is: you'd found some
time ago that get_user_pages sometimes failed to pin the pages for
your complex app, so were forced to mlock too; but couldn't provide
any simple test case for the failure (which can indeed be a lot of
work to devise), so we were all in the dark as to what went wrong.

But you've now found that 2.6.7 and later kernels allow your app to
work correctly without mlock, good.  get_user_pages is certainly the
right tool to use for such pinning.  (On the question of whether
mlock guarantees that user virtual addresses map to the same physical
addresses, I prefer Arjan's view that it does not; but accept that
there might prove to be difficulties in holding that position.)

So, it works now, you've exonerated today's get_user_pages, and you've
identified at least one get_user_pages fix which went in at that time:
do we really need to chase this further?

Oh, in writing of copy-on-write, I've just remembered another fix
for get_user_pages which I made in 2.6.7 (though I've not heard of
anyone seeing the problem fixed): call to do_wp_page in do_swap_page.
get_user_pages assumes that the write fault it generates will break
copy-on-write i.e. will make a private copy page when necessary,
before returning to the caller; but that wasn't happening in the
do_swap_page case.

By the way, please don't be worried when soon the try_to_unmap_one
comment and code that you identified above disappear.  When I'm
back in patch submission mode, I'll be sending Andrew a patch which
removes it, instead reworking can_share_swap_page to rely on the
page_mapcount instead of page_count, which avoids the ironical
behaviour my comment refers to, and allows an awkward page migration
case to proceed (once unpinned).  Andrea and I now both prefer this
page_mapcount approach.

Hugh

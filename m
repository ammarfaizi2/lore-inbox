Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVKUPqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVKUPqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVKUPqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:46:47 -0500
Received: from silver.veritas.com ([143.127.12.111]:40779 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932326AbVKUPqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:46:47 -0500
Date: Mon, 21 Nov 2005 15:46:50 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Takashi Iwai <tiwai@suse.de>
cc: Lee Revell <rlrevell@joe-job.com>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: 2.6.15-rc1-mm2 -- Bad page state at free_hot_cold_page (in
 process 'aplay', page c18eef30)
In-Reply-To: <s5hlkzinrq5.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.61.0511211507160.15988@goblin.wat.veritas.com>
References: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com>
 <Pine.LNX.4.61.0511200804500.3938@goblin.wat.veritas.com>
 <1132510467.6874.144.camel@mindpipe> <Pine.LNX.4.61.0511201915530.8619@goblin.wat.veritas.com>
 <s5hlkzinrq5.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Nov 2005 15:46:46.0563 (UTC) FILETIME=[C7531F30:01C5EEB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Takashi Iwai wrote:
> 
> Sorry, I still don't figure out how __GFP_COMP solved this problem.
> Could you enlighten me a bit?

The sequence of problems was this.

Nick's core PageReserved removal patch in 2.6.15-rc1 (and -rc2) 
changed VM_RESERVED vmas never to free their pages on unmapping (e.g.
on exit) - fine for remap_pfn_range areas, but a leak where others set
VM_RESERVED; and PageReserved not to inhibit decrementing page count.

In -rc1-mm2 I tried to fix that leak by restoring VM_RESERVED to its
previous behaviour, and using a different flag VM_UNPAGED, set in
remap_pfn_range, for the don't-free-when-unmapping behaviour.

But there's then a problem when the underlying page was allocated
as a high-order page, but the separate individual 0-order constituent
pages are mapped into userspace by nopage: the page count of the first
0-order is raised by allocation, but the following 0-order pages are
left with page count 0.  nopage's get_page raises that to 1,
zap_pte_range (or whatever it uses to actually do the freeing) lowers
that to 0, and hence frees the page, even though it's a constituent of
the not-yet-freed high-order page.  (This had not been a problem while
PageReserved was inhibiting decrementing the page count.)

So another of my patches in -rc1-mm2 made the PageCompound technique
available always, no longer under #ifdef CONFIG_HUGETLB_PAGE: so that
get_page and put_page on the later constituents of the high-order
page get redirected to the first one, and it should work okay again.

Except that I'd missed that you actually have to choose to have your
high-order pages supplied as compound pages, by passing __GFP_COMP.
Since I wasn't passing that, they still weren't allocated as compound
pages, so were still being freed too soon - and the PG_reserved flag
found while freeing gave rise to the "Bad page state" messages seen.

> Isn't it needed for dma_alloc_coherent() (for i386, particularly),
> too?  dma_alloc_coherent() also gets pages with __get_free_pages().

Didn't I deal with that by adding __GFP_COMP in snd_malloc_dev_pages?
And (in a separate patch run past davem and wli first, to be aggregated
with the sound/core/memalloc patch when I sign off and send to Andrew)
in the sparc and sparc64 sbus_alloc_consistent.

It's only an issue when the high-order page might be mapped into
userspace, then its constituents freed up by zap_pte_range; or
locked down with get_user_pages and later released: when constituents
of a high-order page pass through common code designed for 0-order pages.

> Also, I think we can remove all Set/ClearPageReserved() in memalloc.c
> now.  It was there just for mmap...

That is so, but we'd prefer you to hold off for now.  The way it's
proceeding is, for 2.6.15 we're not actually removing the Set/Clear
PageReserved from any of the drivers or from any of the architecture
initialization; but PageReserved is no longer serving any functional
purpose, except where PG_reserved acts as a double-check when the page
is freed, as to whether it's all working right.  Which was useful in
this case, to identify where I'd forgotten all about __GFP_COMP; and
I fear may prove useful in some other cases too.  Retaining this use
of PG_reserved for now, gives greater confidence in our safety when we
later advance to removing all the Set/ClearPageReserved hocus-pocus.

Hugh

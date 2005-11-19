Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVKST46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVKST46 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 14:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVKST46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 14:56:58 -0500
Received: from gold.veritas.com ([143.127.12.110]:38197 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750783AbVKST45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 14:56:57 -0500
Date: Sat, 19 Nov 2005 19:57:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Michael Krufky <mkrufky@m1k.net>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2 0x414 Bad page states
In-Reply-To: <Pine.LNX.4.61.0511182214200.4797@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511191950100.2846@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511182214200.4797@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Nov 2005 19:56:53.0014 (UTC) FILETIME=[630A5360:01C5ED43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005, Hugh Dickins wrote:
> 
> Thanks for the info you've sent so far, implicating
> snd_pcm_mmap_data_nopage.  But I've still not got it.  Will resume
> tomorrow.  If you can, would you please each send me your .config
> and your full startup dmesg (in case they help to focus me on which
> paths to look down in sound).  You needn't spam akpm or lkml with them.

And thanks for the further info you sent, which allowed me to rebuild my
kernel to reproduce the problem easily with artsd.  Though the answer was
staring me in the face from the first info you sent (and did occasionally
flit through my mind without being properly swatted), even in my Subject
line above: why were the page flags 0x414 instead of 0x4414 i.e. what had
happened to the PageCompound flag which I thought one of my patches was
adding?

Whoops, I'd completely missed that now we have to pass __GFP_COMP to
turn on that behaviour, because there are or were a few other places
which get confused by compound page behaviour.  There's an excellent,
illuminating, prescient comment on compound pages by Andrew in
ChangeLog-2.6.6: but though he there foresees sound DMA buffers needing
it, I've a suspicion that DRM and some others might also be needing it.

So I'll go on a trawl through the source before finalizing the fix,
but below is the patch you guys need.  Does this patch deal with your
Bad page states too, Marc?  Does it help your mouse at all somehow?

Hugh

--- 2.6.15-rc1-mm2/sound/core/memalloc.c	2005-11-12 09:01:28.000000000 +0000
+++ linux/sound/core/memalloc.c	2005-11-19 19:03:32.000000000 +0000
@@ -197,6 +197,7 @@ void *snd_malloc_pages(size_t size, gfp_
 
 	snd_assert(size > 0, return NULL);
 	snd_assert(gfp_flags != 0, return NULL);
+	gfp_flags |= __GFP_COMP;	/* compound page lets parts be mapped */
 	pg = get_order(size);
 	if ((res = (void *) __get_free_pages(gfp_flags, pg)) != NULL) {
 		mark_pages(virt_to_page(res), pg);
@@ -241,6 +242,7 @@ static void *snd_malloc_dev_pages(struct
 	snd_assert(dma != NULL, return NULL);
 	pg = get_order(size);
 	gfp_flags = GFP_KERNEL
+		| __GFP_COMP	/* compound page lets parts be mapped */
 		| __GFP_NORETRY /* don't trigger OOM-killer */
 		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
 	res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);

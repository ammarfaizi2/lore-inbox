Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVKTTfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVKTTfv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 14:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVKTTfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 14:35:51 -0500
Received: from gold.veritas.com ([143.127.12.110]:38796 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932077AbVKTTfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 14:35:50 -0500
Date: Sun, 20 Nov 2005 19:35:57 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: 2.6.15-rc1-mm2 -- Bad page state at free_hot_cold_page (in
 process 'aplay', page c18eef30)
In-Reply-To: <1132510467.6874.144.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0511201915530.8619@goblin.wat.veritas.com>
References: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com> 
 <Pine.LNX.4.61.0511200804500.3938@goblin.wat.veritas.com>
 <1132510467.6874.144.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Nov 2005 19:35:50.0071 (UTC) FILETIME=[9CAE4470:01C5EE09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2005, Lee Revell wrote:
> (Added alsa-devel to cc:)
> 
> Will this change have any ill effects on older kernels?

I think not (except 2.6.5 and earlier didn't define __GFP_COMP).

> If not we should fix it in the ALSA tree right?

Probably, but I'm no authority on the ALSA tree.

And suggest you wait a bit, since I haven't yet signed off on the
patch that piece will be a part of.

And what about the patch at the bottom (which I had CC'ed to Karsten
Wiese), is that part of the ALSA tree too?  That case isn't so easy:
the get_page makes a difference, and probably it was right not to do
it before, yet strange it was the only nopage in the tree which didn't
get_page.

Hugh

> Lee
> 
> On Sun, 2005-11-20 at 08:05 +0000, Hugh Dickins wrote:
> > On Sat, 19 Nov 2005, Miles Lane wrote:
> > > [17179671.700000] Bad page state at free_hot_cold_page (in process
> > > 'aplay', page c18eef30)
> > > [17179671.700000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
> > 
> > Please let me know if it's not fixed by:
> > 
> > --- 2.6.15-rc1-mm2/sound/core/memalloc.c	2005-11-12 09:01:28.000000000 +0000
> > +++ linux/sound/core/memalloc.c	2005-11-19 19:03:32.000000000 +0000
> > @@ -197,6 +197,7 @@ void *snd_malloc_pages(size_t size, gfp_
> >  
> >  	snd_assert(size > 0, return NULL);
> >  	snd_assert(gfp_flags != 0, return NULL);
> > +	gfp_flags |= __GFP_COMP;	/* compound page lets parts be mapped */
> >  	pg = get_order(size);
> >  	if ((res = (void *) __get_free_pages(gfp_flags, pg)) != NULL) {
> >  		mark_pages(virt_to_page(res), pg);
> > @@ -241,6 +242,7 @@ static void *snd_malloc_dev_pages(struct
> >  	snd_assert(dma != NULL, return NULL);
> >  	pg = get_order(size);
> >  	gfp_flags = GFP_KERNEL
> > +		| __GFP_COMP	/* compound page lets parts be mapped */
> >  		| __GFP_NORETRY /* don't trigger OOM-killer */
> >  		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
> >  	res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);

Karsten Wiese <annabellesgarden@yahoo.de>
[PATCH 03/11] unpaged: sound nopage get_page

Something noticed when studying use of VM_RESERVED in different drivers:
snd_usX2Y_hwdep_pcm_vm_nopage omitted to get_page: fixed.

And how did this work before?  Aargh!  That nopage is returning a page
from within a buffer allocated by snd_malloc_pages, which allocates a
high-order page, then does SetPageReserved on each 0-order page within.

That would have worked in 2.6.14, because when the area was unmapped,
PageReserved inhibited put_page.  2.6.15-rc1 removed that inhibition
(while leaving ineffective PageReserveds around for now), but it hasn't
caused trouble because.. we've not been freeing from VM_RESERVED at all.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 sound/usb/usx2y/usx2yhwdeppcm.c |    1 +
 1 files changed, 1 insertion(+)

--- unpaged02/sound/usb/usx2y/usx2yhwdeppcm.c	2005-11-12 09:01:30.000000000 +0000
+++ unpaged03/sound/usb/usx2y/usx2yhwdeppcm.c	2005-11-17 15:10:34.000000000 +0000
@@ -691,6 +691,7 @@ static struct page * snd_usX2Y_hwdep_pcm
 	snd_assert((offset % PAGE_SIZE) == 0, return NOPAGE_OOM);
 	vaddr = (char*)((usX2Ydev_t*)area->vm_private_data)->hwdep_pcm_shm + offset;
 	page = virt_to_page(vaddr);
+	get_page(page);
 
 	if (type)
 		*type = VM_FAULT_MINOR;

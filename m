Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVKUHAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVKUHAF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 02:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVKUHAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 02:00:04 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:19366 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750967AbVKUHAC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 02:00:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fv29bAOIxdjemCrVA/Jqpq5x/Yeo8AN1AwOvTJKTWSxCS60DcgbuauEmJBJLbMbEQHzne9L/LvOO/pc1S8i8Y+TI+B2kU8ZHL9gruGTl9E445tvyK1r8lsutxpvglUDk9zxHeLnBdjEmhBRyPb/zUHxeMrO/kwUZ03do2y5RU3M=
Message-ID: <a44ae5cd0511202259q71d2ef1fk294277225f848937@mail.gmail.com>
Date: Sun, 20 Nov 2005 22:59:59 -0800
From: Miles Lane <miles.lane@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-rc1-mm2 -- Bad page state at free_hot_cold_page (in process 'aplay', page c18eef30)
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0511201915530.8619@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com>
	 <Pine.LNX.4.61.0511200804500.3938@goblin.wat.veritas.com>
	 <1132510467.6874.144.camel@mindpipe>
	 <Pine.LNX.4.61.0511201915530.8619@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/05, Hugh Dickins <hugh@veritas.com> wrote:
> On Sun, 20 Nov 2005, Lee Revell wrote:
> > (Added alsa-devel to cc:)
> >
> > Will this change have any ill effects on older kernels?
>
> I think not (except 2.6.5 and earlier didn't define __GFP_COMP).
>
> > If not we should fix it in the ALSA tree right?
>
> Probably, but I'm no authority on the ALSA tree.
>
> And suggest you wait a bit, since I haven't yet signed off on the
> patch that piece will be a part of.
>
> And what about the patch at the bottom (which I had CC'ed to Karsten
> Wiese), is that part of the ALSA tree too?  That case isn't so easy:
> the get_page makes a difference, and probably it was right not to do
> it before, yet strange it was the only nopage in the tree which didn't
> get_page.
>
> Hugh
>
> > Lee
> >
> > On Sun, 2005-11-20 at 08:05 +0000, Hugh Dickins wrote:
> > > On Sat, 19 Nov 2005, Miles Lane wrote:
> > > > [17179671.700000] Bad page state at free_hot_cold_page (in process
> > > > 'aplay', page c18eef30)
> > > > [17179671.700000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
> > >
> > > Please let me know if it's not fixed by:
> > >
> > > --- 2.6.15-rc1-mm2/sound/core/memalloc.c    2005-11-12 09:01:28.000000000 +0000
> > > +++ linux/sound/core/memalloc.c     2005-11-19 19:03:32.000000000 +0000
> > > @@ -197,6 +197,7 @@ void *snd_malloc_pages(size_t size, gfp_
> > >
> > >     snd_assert(size > 0, return NULL);
> > >     snd_assert(gfp_flags != 0, return NULL);
> > > +   gfp_flags |= __GFP_COMP;        /* compound page lets parts be mapped */
> > >     pg = get_order(size);
> > >     if ((res = (void *) __get_free_pages(gfp_flags, pg)) != NULL) {
> > >             mark_pages(virt_to_page(res), pg);
> > > @@ -241,6 +242,7 @@ static void *snd_malloc_dev_pages(struct
> > >     snd_assert(dma != NULL, return NULL);
> > >     pg = get_order(size);
> > >     gfp_flags = GFP_KERNEL
> > > +           | __GFP_COMP    /* compound page lets parts be mapped */
> > >             | __GFP_NORETRY /* don't trigger OOM-killer */
> > >             | __GFP_NOWARN; /* no stack trace print - this call is non-critical */
> > >     res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);

Thanks, this did fix the problem for me.

         Miles

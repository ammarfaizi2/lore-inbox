Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271923AbRH2HaW>; Wed, 29 Aug 2001 03:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271924AbRH2HaL>; Wed, 29 Aug 2001 03:30:11 -0400
Received: from mail.spylog.com ([194.67.35.220]:49376 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S271923AbRH2HaC>;
	Wed, 29 Aug 2001 03:30:02 -0400
Date: Wed, 29 Aug 2001 11:30:12 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P)
Message-ID: <20010829113012.A8300@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <15235.55592.699783.338199@abasin.nj.nec.com> <Pine.LNX.4.21.0108221241040.2202-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0108221241040.2202-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.20i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo Tosatti,

Once you wrote about "Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P)":

 
  May be later, i applied you patch on my server (1.5Gb/DAC960/2CPU/...)
	All test OK (tiobench/NFS - big file - more 2Gb).

	You patch enter to mainline kernel (Linux/Alan) ?



> Aug 20 15:10:33 ps1 kernel: cation failed (gfp=0x30/1). 
> Aug 20 15:10:33 ps1 kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x30/1). 
> Aug 20 15:10:46 ps1 last message repeated 327 times 
> Aug 20 15:10:47 ps1 kernel: cation failed (gfp=0x30/1). 
> Aug 20 15:10:47 ps1 kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x30/1). 
> Aug 20 15:10:56 ps1 last message repeated 294 times 

 
> >  > Could you please try the following patch on top of 2.4.9? 
> >  > 
> >  > diff -Nur --exclude-from=exclude linux.orig/fs/buffer.c linux/fs/buffer.c
> >  > --- linux.orig/fs/buffer.c	Wed Aug 15 18:25:49 2001
> >  > +++ linux/fs/buffer.c	Tue Aug 21 04:54:01 2001
> >  > @@ -2447,7 +2447,8 @@
> >  >  	spin_unlock(&free_list[index].lock);
> >  >  	write_unlock(&hash_table_lock);
> >  >  	spin_unlock(&lru_list_lock);
> >  > -	if (gfp_mask & __GFP_IO) {
> >  > +	if (gfp_mask & __GFP_IO || (gfp_mask & __GFP_NOBOUNCE) 
> >  > +			&& page-zone == &pgdat_list->node_zones[ZONE_HIGHMEM]) {
> >  >  		sync_page_buffers(bh, gfp_mask);
> >  >  		/* We waited synchronously, so we can free the buffers. */
> >  >  		if (gfp_mask & __GFP_WAIT) {
> >  > diff -Nur --exclude-from=exclude linux.orig/include/linux/mm.h linux/include/linux/mm.h
> >  > --- linux.orig/include/linux/mm.h	Wed Aug 15 18:21:11 2001
> >  > +++ linux/include/linux/mm.h	Tue Aug 21 04:52:08 2001
> >  > @@ -538,6 +538,8 @@
> >  >  #define __GFP_HIGH	0x20	/* Should access emergency pools? */
> >  >  #define __GFP_IO	0x40	/* Can start physical IO? */
> >  >  #define __GFP_FS	0x80	/* Can call down to low-level FS? */
> >  > +#define __GFP_NOBOUNCE	0x100	/* Don't do any IO operation which may
> >  > +				   result in IO bouncing */
> >  >  
> >  >  #define GFP_NOIO	(__GFP_HIGH | __GFP_WAIT)
> >  >  #define GFP_NOFS	(__GFP_HIGH | __GFP_WAIT | __GFP_IO)
> >  > diff -Nur --exclude-from=exclude linux.orig/include/linux/slab.h linux/include/linux/slab.h
> >  > --- linux.orig/include/linux/slab.h	Wed Aug 15 18:21:13 2001
> >  > +++ linux/include/linux/slab.h	Tue Aug 21 04:51:20 2001
> >  > @@ -23,7 +23,7 @@
> >  >  #define	SLAB_NFS		GFP_NFS
> >  >  #define	SLAB_DMA		GFP_DMA
> >  >  
> >  > -#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS)
> >  > +#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS|__GFP_NOBOUNCE)
> >  >  #define	SLAB_NO_GROW		0x00001000UL	/* don't grow a cache */
> >  >  
> >  >  /* flags to pass to kmem_cache_create().
> >  > diff -Nur --exclude-from=exclude linux.orig/mm/highmem.c linux/mm/highmem.c
> >  > --- linux.orig/mm/highmem.c	Thu Aug 16 13:42:45 2001
> >  > +++ linux/mm/highmem.c	Tue Aug 21 04:50:08 2001
> >  > @@ -321,7 +321,7 @@
> >  >  	struct page *page;
> >  >  
> >  >  repeat_alloc:
> >  > -	page = alloc_page(GFP_NOIO);
> >  > +	page = alloc_page(GFP_NOIO|__GFP_NOBOUNCE);
> >  >  	if (page)
> >  >  		return page;
> >  >  	/*
> >  > @@ -359,7 +359,7 @@
> >  >  	struct buffer_head *bh;
> >  >  
> >  >  repeat_alloc:
> >  > -	bh = kmem_cache_alloc(bh_cachep, SLAB_NOIO);
> >  > +	bh = kmem_cache_alloc(bh_cachep, SLAB_NOIO|__GFP_NOBOUNCE);
> >  >  	if (bh)
> >  >  		return bh;
> >  >  	/*
> >  > diff -Nur --exclude-from=exclude linux.orig/mm/page_alloc.c linux/mm/page_alloc.c
> >  > --- linux.orig/mm/page_alloc.c	Thu Aug 16 13:43:02 2001
> >  > +++ linux/mm/page_alloc.c	Tue Aug 21 04:51:03 2001
> >  > @@ -398,7 +398,8 @@
> >  >  	 * - we're /really/ tight on memory
> >  >  	 * 	--> try to free pages ourselves with page_launder
> >  >  	 */
> >  > -	if (!(current->flags & PF_MEMALLOC)) {
> >  > +	if (!(current->flags & PF_MEMALLOC) 
> >  > +			|| ((gfp_mask & __GFP_NOBOUNCE) && !order)) {
> >  >  		/*
> >  >  		 * Are we dealing with a higher order allocation?
> >  >  		 *
> >  > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
bye.
Andrey Nekrasov, SpyLOG.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTH2SGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbTH2SGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:06:12 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:15246 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261877AbTH2SF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:05:57 -0400
Date: Fri, 29 Aug 2003 20:05:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k cache
In-Reply-To: <Pine.LNX.4.44.0308291743280.8124-100000@serv>
Message-ID: <Pine.GSO.4.21.0308292003530.4027-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Aug 2003, Roman Zippel wrote:
> On Fri, 29 Aug 2003, Geert Uytterhoeven wrote:
> > M68k icache flush fixes from Roman Zippel:
> >   - uninline flush_icache_range() and rename it to flush_icache_user_range()
> >   - add virt_to_phys_slow() which handles vmalloc()ed space
> >   - add flush_icache_range and flush_icache_user_page
> > 
> > [...]
> > 
> > --- linux-2.4.23-pre1/kernel/ptrace.c	Wed May 28 13:11:52 2003
> > +++ linux-m68k-2.4.23-pre1/kernel/ptrace.c	Fri Jul 25 20:02:39 2003
> > @@ -165,7 +165,7 @@
> >  		if (write) {
> >  			memcpy(maddr + offset, buf, bytes);
> >  			flush_page_to_ram(page);
> > -			flush_icache_user_range(vma, page, addr, len);
> > +			flush_icache_user_page(vma, page, addr, len);
> >  			set_page_dirty(page);
> >  		} else {
> >  			memcpy(buf, maddr + offset, bytes);
> 
> Geert, did you intend to include this part?

Oops, no, I had no intention of changing global code. Thanks for spotting this!

> This part needs an update of all archs includes (to define 
> flush_icache_user_page at least as flush_icache_user_range) and the 
> changes to binfmt_{elf,aout}.c are part of this patch.
> Maybe I should explain the reason behind this patch:
> The actual problem is the usage of flush_icache_range(). In 
> kernel/module.c it's used to flush data from the kernel cache, in 
> binfmt_{elf,aout}.c it's used to flush data from the user cache and in 
> both situations it's called with a user space context, so that 
> flush_icache_range() doesn't know which cache to flush and I'd really 
> like to avoid having to flush both caches.
> So the full patch renames flush_icache_range() in binfmt_{elf,aout}.c into 
> flush_icache_user_range(), but which already exists, so I renamed this 
> into flush_icache_user_page().

I prefer you take care of pushing this change for other archs?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269158AbRH0VfD>; Mon, 27 Aug 2001 17:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269119AbRH0Vey>; Mon, 27 Aug 2001 17:34:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2578 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269174AbRH0Vef>; Mon, 27 Aug 2001 17:34:35 -0400
Date: Mon, 27 Aug 2001 14:31:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: patch-2.4.10-pre1
In-Reply-To: <Pine.LNX.4.21.0108271633140.7059-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0108271421500.7562-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Aug 2001, Marcelo Tosatti wrote:
>
> There have been some reports of x-order allocation failures when you where
> in Finland. They can be triggered by high IO stress on highmem machines.
>
> The following patch avoids that by allowing tasks allocating bounce memory
> (lowmem) to block on low mem IO, thus applying more "IO pressure" to the
> lowmem zone. (the lowmem zone is our "IOable memory" anyway, so...)

I'd much rather set this up by splitting up __GFP_IO into two parts (ie
__GFP_IO and __GFP_IO_BOUNCE), and avoiding have "negative" bits in the
gfp_mask. That way the bits in gfp_mask always end up increasing things we
can do, not ever decreasing them.

Also, your test is really wrong:

	page->zone != &pgdat_list->node_zones[ZONE_HIGHMEM]

is bogus and assumes MUCH too intimate knowledge of there being only one
particular zone that is "highmem" (think NUMA machines where each node may
have its own highmem setup). So it SHOULD be something along the lines of

	#ifdef CONFIG_HIGHMEM
		if (!(gfp_mask & __GFP_HIGHIO) && PageHighMem(page))
			return;
	#endif

inside the write case of sync_page_buffers() (we can, and probably should,
still _wait_ for highmem buffers - but whether we do it inside
sync_page_buffers() or inside try_to_free_buffers() is probably mostly a
matter of taste - I won't argue too much with your choice there).

Other than that, the basic approach looks sane, I would just prefer for
the testing and bits to be done more regularly.

		Linus


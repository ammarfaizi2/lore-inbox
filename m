Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314065AbSEAVjo>; Wed, 1 May 2002 17:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314069AbSEAVjn>; Wed, 1 May 2002 17:39:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58126 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314065AbSEAVjm>; Wed, 1 May 2002 17:39:42 -0400
Date: Wed, 1 May 2002 14:38:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.12: remove VALID_PAGE
In-Reply-To: <Pine.LNX.4.21.0205012136560.23113-100000@serv>
Message-ID: <Pine.LNX.4.33.0205011433040.23138-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 May 2002, Roman Zippel wrote:
> 
> This patch removes VALID_PAGE() and replaces it with pte_valid_page()/
> virt_to_valid_page(). The VALID_PAGE() test is basically always too late
> for configuration with discontinous memory. The real input value (the 
> virtual or physical address) has to be checked. Nice side effect: the
> kernel becomes 1KB smaller.

Can you please do this differently, by splitting up the pte->page 
conversion and explicitly using a physical PFN in between the two?

In other words, I'd much rather have

	unsigned long pfn = pte_pfn(pte);

	if (pfn_valid(pfn)) {
		struct page *page = pfn_to_page(pfn);
		...
	}

and make the physical page address visible.

The reason I'd rather do it that way is that sometimes we right now go to 
"struct page" for no really good reason, other than the fact that we don't 
have any other good "intermediate" representation.

So using a pte_pfn()/pfn_to_page() interface would allow other places to
take advantage of this too, instead of adding two new special-case
functions that aren't useful for anything else.

			Linus


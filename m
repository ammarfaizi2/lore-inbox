Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbRBMJ43>; Tue, 13 Feb 2001 04:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129169AbRBMJ4U>; Tue, 13 Feb 2001 04:56:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64516 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129131AbRBMJ4B>;
	Tue, 13 Feb 2001 04:56:01 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102130950.f1D9ohq01768@flint.arm.linux.org.uk>
Subject: Re: [PATCH] swapin flush cache bug
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Tue, 13 Feb 2001 09:50:42 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), gniibe@m17n.org (NIIBE Yutaka),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.21.0102122107550.29855-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Feb 12, 2001 09:21:55 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:
> If lookup_swap_cache() finds a page in the swap cache, and that page was
> in memory because of the swapin readahead, the cache is not flushed.
> 
> Here is a patch to fix the problem by always flushing the cache including
> for pages in the swap cache:

> -
> -               flush_page_to_ram(page);
> -               flush_icache_page(vma, page);
>         }
>  
>         mm->rss++;
> +
> +       flush_page_to_ram(page);
> +       flush_icache_page(vma, page);

Surely if the page is in the swap cache, we don't need the
flush_page_to_ram() because the data is already written to the page.  Yes,
there may be some reminents of it in the cache due to it being written
to disk via PIO.

Thinking about it some more - we have a process.  It used to contain page
P at address V.  We unmapped the page (and did the right thing with the
caches).  Now, something wants to access address V, so we pull the page
from the swap cache, and place page P back at address V.  We therefore
shouldn't need any cache manipulation at this point.

What was the problem?  The old code seems to behave well on a virtual
address indexed virtual address tagged cache.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


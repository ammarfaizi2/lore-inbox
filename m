Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286179AbSAPSsQ>; Wed, 16 Jan 2002 13:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSAPSr6>; Wed, 16 Jan 2002 13:47:58 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15393 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287134AbSAPSrf>; Wed, 16 Jan 2002 13:47:35 -0500
Date: Wed, 16 Jan 2002 19:48:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pte-highmem-5
Message-ID: <20020116194816.D835@athlon.random>
In-Reply-To: <20020116185814.I22791@athlon.random> <Pine.LNX.4.33.0201161008270.2112-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0201161008270.2112-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 16, 2002 at 10:19:56AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 10:19:56AM -0800, Linus Torvalds wrote:
> 
> Btw, some suggestions:
> 
>  - why have those ugly special cases for bootup defines. kmap() is a no-op
>    on 1:1 pages, so all those "arch/i386/mm/init.c" games are totally
>    unnecessary if you just have the pages in low memory. That gets rid of
>    much of it.

agreed.

>  - do the highmem pte bouncing only for CONFIG_X86_PAE: with less then 4GB
>    of RAM this doesn't seem to matter all that much (rule of thumb: we
>    need about 1% of memory for page tables). Again, this will simplify
>    things, as it will make other architectures not have to worry about the
>    change.

I'm not sure how simpler it will make things and I'd prefer to keep the
pte in highmem also with 4G to be more generic, think 1000 threads
mapping the same 1G of shm each, ok that may sound a bit insane but
it's not that far from some setup that triggered the pte problem.

> 
>    (And it's really CONFIG_X86_PAE that makes page tables twice as big, so
>    PAE increases the lowmem pressure for two independent reasons: twice as
>    much memory in page tables _and_ larger amounts of memory to map).

yes.

>  - please don't do that "pte_offset_atomic_irq()" have special support in
>    the header files: it is _not_ a generic operation, and it is only used
>    by the x86 page fault logic. For that reason, I would suggest moving
>    all that logic out of the header files, and into i386/mm/fault.c,
>    something along the lines of
> 
> 	pte = pte_offset_nokmap(..)
> 	addr = kmap_atomic(pte, KM_VMFAULT);
> 
>    instead of having special magic logic in the header files.

the pte_offset_nokmap will have to return a page actually, I was hiding
the "page" stuff in the header, that's it, but I'm fine to add a nokmap
that returns a page (not a pte) and to call kmap_atomic by hand to get
the pte_t *. Also there are non obvious implications if the pte is not
large as a page, but I'm not aware of any arch where a pte is not large
as a page... in the common code only pte_alloc play with pages as pte so
far.

> Other than that it looks fairly straightforward, I think.

I'm glad to hear :). btw, I don't expect big difference for 2.5, that
area should be pretty much the same. I was a bit sick in the last days,
I'll try to make the above cleanups soon and then to port to 2.5. thanks,

Forget to tell, another bit to cleanup is the pte_quicklist, that has to
be converted to a list_head, doing a kmap_atomic to queue pages into the
quicklist is very stupid at the moment, I just wanted to make it working
first, then to fix this bit, I'll clean it up in one of the next version
(but in the meantime is just usable).

Andrea

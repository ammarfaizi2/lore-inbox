Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132143AbRCYSJD>; Sun, 25 Mar 2001 13:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132142AbRCYSIx>; Sun, 25 Mar 2001 13:08:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47883 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132144AbRCYSIi>; Sun, 25 Mar 2001 13:08:38 -0500
Date: Sun, 25 Mar 2001 10:07:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-mm@kvack.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pae-2.4.3-A4
In-Reply-To: <Pine.LNX.4.30.0103251643070.6469-200000@elte.hu>
Message-ID: <Pine.LNX.4.31.0103251001090.8737-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Mar 2001, Ingo Molnar wrote:
>
> one nontrivial issue was that on PAE the pgd has to be installed with
> 'present' pgd entries, due to a CPU erratum. This means that the
> pgd_present() code in mm/memory.c, while correct theoretically, doesnt
> work with PAE. An equivalent solution is to use !pgd_none(), which also
> works with the PAE workaround.

Note that due to the very same erratum, we really should populate the PGD
from the very beginning. See the other thread about how we currently
fail to properly invalidate the TLB on other CPU's when we add a new PGD
entry, exactly because the other CPU's are caching the "nonexistent" PGD
entry that we just replaced.

So my suggestion for PAE is:

 - populate in gdb_alloc() (ie just do the three "alloc_page()" calls to
   allocate the PMD's immediately)

   NOTE: This makes the race go away, and will actually speed things up as
   we will pretty much in practice always populate the PGD _anyway_, the
   way the VM areas are laid out.

 - make "pgd_present()" always return 1.

   NOTE: This will speed up the page table walkers anyway. It will also
   avoid the problem above.

 - make "free_pmd()" a no-op.

All of the above will (a) simplify things (b) remove special cases and (c)
remove actual and existing bugs.

(In fact, the reason why the PGD populate missing TLB invalidate probably
never happens in practice is exactly the fact that the PGD is always
populated so fast that it's hard to make a test-case that shows this. But
it's still a bug - probably fairly easily triggered by a threaded program
that is statically linked (so that the code loads at 0x40000000 and
doesn't have the loader linked low - so the lowest PGD entry is not
allocated until later).

Does anybody see any problems with the above? It looks like the obvious
fix.

		Linus


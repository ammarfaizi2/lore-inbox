Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVLSBe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVLSBe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbVLSBe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:34:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43527 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030214AbVLSBe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:34:27 -0500
Date: Mon, 19 Dec 2005 02:34:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Neil Brown <neilb@suse.de>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       xfs-masters@oss.sgi.com, nathans@sgi.com, joern@wohnheim.fh-wedel.de
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051219013429.GS23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de> <20051215231538.GF3419@redhat.com> <20051216004740.GV23349@stusta.de> <20051216005056.GG3419@redhat.com> <17314.11514.650036.686071@cse.unsw.edu.au> <20051216121805.GX23349@stusta.de> <17318.676.931250.379882@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17318.676.931250.379882@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 11:45:24AM +1100, Neil Brown wrote:
> On Friday December 16, bunk@stusta.de wrote:
> > 
> > The nfsd code uses inline in too many places.
> 
> Does it?
> Most of the uses are either
>  - truly tiny bits of code

That's OK if they stay tiny and don't grow as time passes by.

>  - code that is used only once which, as you as, will not currently 
>    be auto-inlined on i386, so we do it by hand.

That's OK if it isn't forgotten to un-inline them when they get more 
callers.

Unfortunately, people often don't check whether an "inline" is still 
appropriate when the code evolves.

Unless this is an extreme hot path, it's therefore IMHO not a good idea 
to use "inline" in such cases.

Additionally, it's a medium-term goal for me to re-enable unit-at-a-time 
on i386 for recent gcc's.

> An exception is some of the xdr code.
> If I 
>   #define inline
> in nfs3xdr.c, the nfsd.o changes from 
>    text    data     bss     dec     hex filename
>   76132    3464    2408   82004   14054 ../mm-i386/fs/nfsd/nfsd.o
> to
>    text    data     bss     dec     hex filename
>   72452    3464    2408   78324   131f4 ../mm-i386/fs/nfsd/nfsd.o
> which is probably a win.
> 
> Is that what you were referring to?

I didn't had one specific example in mind, but yes this seems to be an 
example for inline's that might have been reasonable at one time in the 
past, but are no longer today.

> > If this struct is really a problem (which I doubt considering it's 
> > size), I'd prefer it being kmalloc'ed.
> 
> It's hard to *know* if it is a problem, but I am conscious that nfsd
> adds measurably to stack depth for filesystem paths, and probably
> isn't measured nearly as often.
> It's true that 50 bytes out of 4K isn't a lot, but wastage that can be
> avoided, should be avoided.

"make checkstack" tells that nfsd_vfs_write is below 100 bytes of stack 
usage. So even calling 30 such functions would not get you above
3 kB stack usage.

It's also interesting that according to Jörn Engel's static analysis of 
call paths in kernel 2.6.11 [1], the string "nfs" does occur in neither 
any of the functions involved in call paths with > 2 kB stack usage, nor 
in any recursive call paths.

It's OK to use some bytes from the stack, and you haven't yet convinced 
me that the code you are responsible for is using too much stack.  ;-)

> NeilBrown

cu
Adrian

[1] http://wh.fh-wedel.de/~joern/stackcheck.2.6.11

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


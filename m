Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289858AbSBKRSR>; Mon, 11 Feb 2002 12:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289859AbSBKRSF>; Mon, 11 Feb 2002 12:18:05 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:2072 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S289858AbSBKRRz>; Mon, 11 Feb 2002 12:17:55 -0500
Date: Mon, 11 Feb 2002 17:19:31 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C6637F3.9CDA7278@zip.com.au>
Message-ID: <Pine.LNX.4.21.0202111613340.6127-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2002, Andrew Morton wrote:
> > 
> > I think I'm done with this now.
> 
> Famous last words.  There's a slightly updated version at
> http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre9/

Thanks for taking this on, Andrew.  A lot of nice work, but...

1. I'd be sorry to see it go in as is: you haven't noticed how this
   looks to a disassembler: not pretty!  I don't see an alternative
   to wasting some more bytes: putting "push"es in front of line and
   file? or is there one instruction (some "mov"?) to encompass both
   line and file together?

2. Was change from "kernel BUG at %s:%d!\n" to "Kernel BUG at %s:%d\n"
   intentional?  I'd have thought leave it as was.

3. This probably falls right outside your brief, and I do not want
   to stoke a flamewar about .config in kernel, but let me mention:
   the oops info would be significantly more helpful if it showed
   the version of compiler used, and whether CONFIG_SMP e.g. so we
   can quickly see which of the page_cache_releases in shrink_cache
   gave rise to some error, without trying out assorted compilers
   and configs - BUGVERBOSE was a nuisance for that too, now remedied.
   (Personally, I'd also like to know whether NOHIGHMEM, HIGHMEM4G or
   HIGHMEM64G, but that may reflect my own interests too much, and
   open floodgates to endless such requests.)  Of course such info can
   be supplied by reporters, at the time or later, but nice if it were
   there by default like "Tainted".  Ignore me unless you feel the same.

4. In your patch removing BUGs from inlines, I suggest you delete
   bug_in_interrupt: it's only used in asm/highmem.h (hmm, you check
   in_interrupt once before it, and again inside it), and those
   checks are much better moved into mm/highmem.c kmap_high and
   kunmap_high themselves - I already gave Andrea a patch with that
   change, and that part he approved.  And since you're attacking
   skbuff.h, I think you can then remove interrupt.h from highmem.h,
   but include it in skbuff.h: if I remember rightly, skbuff.h is the
   only file which assumes interrupt.h has already been included by
   highmem.h.  But again, ignore all these remarks unless they chime
   with your own desires - I shouldn't be playing backseat janitor
   with your time.

(Aside to Marcelo: if you're hesitant to put Andrew's changes into
2.4.18, please consider my original asm do_BUG version: it would be
a pity if 2.4.18 went out still destroying registers when BUGVERBOSE,
just because a better implementation is on the way.)

Hugh


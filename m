Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290302AbSBKTtk>; Mon, 11 Feb 2002 14:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290297AbSBKTtb>; Mon, 11 Feb 2002 14:49:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54540 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290293AbSBKTtN>;
	Mon, 11 Feb 2002 14:49:13 -0500
Message-ID: <3C68200C.90F7807F@zip.com.au>
Date: Mon, 11 Feb 2002 11:48:28 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C6637F3.9CDA7278@zip.com.au> <Pine.LNX.4.21.0202111613340.6127-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> On Sun, 10 Feb 2002, Andrew Morton wrote:
> > >
> > > I think I'm done with this now.
> >
> > Famous last words.  There's a slightly updated version at
> > http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre9/
> 
> Thanks for taking this on, Andrew.  A lot of nice work, but...
> 
> 1. I'd be sorry to see it go in as is: you haven't noticed how this
>    looks to a disassembler: not pretty!  I don't see an alternative
>    to wasting some more bytes: putting "push"es in front of line and
>    file? or is there one instruction (some "mov"?) to encompass both
>    line and file together?

This will also confound ksymoops when it parses the opcode
dump.  But we know the file-and-line, so that doesn't seem
very important.

If the unpretty disassembler output is a problem, we could go
back to your do_BUG code if CONFIG_DEBUG_BUGVERBOSE=y?

> 2. Was change from "kernel BUG at %s:%d!\n" to "Kernel BUG at %s:%d\n"
>    intentional?  I'd have thought leave it as was.

oops.  Actually I was thinking of licensing the message as advertising
space to Pepsi...   Will fix.
 
> 3. This probably falls right outside your brief, and I do not want
>    to stoke a flamewar about .config in kernel, but let me mention:
>    the oops info would be significantly more helpful if it showed
>    the version of compiler used, and whether CONFIG_SMP e.g. so we
>    can quickly see which of the page_cache_releases in shrink_cache
>    gave rise to some error, without trying out assorted compilers
>    and configs - BUGVERBOSE was a nuisance for that too, now remedied.
>    (Personally, I'd also like to know whether NOHIGHMEM, HIGHMEM4G or
>    HIGHMEM64G, but that may reflect my own interests too much, and
>    open floodgates to endless such requests.)  Of course such info can
>    be supplied by reporters, at the time or later, but nice if it were
>    there by default like "Tainted".  Ignore me unless you feel the same.

mm.  It's hard to know where to stop with this.  My general feeling
is that we just need to pester the reporter for the relevant info.
The one thing I *would* like to see in the oops output is the
text "Please read Documentation/what-to-do-now.txt".  And that
file contains realy simple instructions on what the reporter
should do next.

> 4. In your patch removing BUGs from inlines, I suggest you delete
>    bug_in_interrupt: it's only used in asm/highmem.h (hmm, you check
>    in_interrupt once before it, and again inside it), and those
>    checks are much better moved into mm/highmem.c kmap_high and
>    kunmap_high themselves - I already gave Andrea a patch with that
>    change, and that part he approved.  And since you're attacking
>    skbuff.h, I think you can then remove interrupt.h from highmem.h,
>    but include it in skbuff.h: if I remember rightly, skbuff.h is the
>    only file which assumes interrupt.h has already been included by
>    highmem.h.  But again, ignore all these remarks unless they chime
>    with your own desires - I shouldn't be playing backseat janitor
>    with your time.

OK, I'll scratch my head over this.

> (Aside to Marcelo: if you're hesitant to put Andrew's changes into
> 2.4.18, please consider my original asm do_BUG version: it would be
> a pity if 2.4.18 went out still destroying registers when BUGVERBOSE,
> just because a better implementation is on the way.)
> 

I agree.  The asm do_BUG code can be retained for the "don't confuse the
disassembler" feature (do we really want that?), and I think we'll hold
off on the other stuff until 2.4.19-pre.  I suggest you resend the
original to Marcelo.

-

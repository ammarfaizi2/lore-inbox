Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135793AbRDTRqZ>; Fri, 20 Apr 2001 13:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135805AbRDTRqQ>; Fri, 20 Apr 2001 13:46:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:53515 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135793AbRDTRqI>; Fri, 20 Apr 2001 13:46:08 -0400
Date: Fri, 20 Apr 2001 10:46:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@cambridge.redhat.com>
cc: <dhowells@redhat.com>, "David S. Miller" <davem@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [andrea@suse.de: Re: generic rwsem [Re: Alpha "process table
 hang"]] 
In-Reply-To: <24526.987755027@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.31.0104201037580.5523-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2001, David Howells wrote:
>
> The file should only be used for the 80386 and maybe early 80486's where
> CMPXCHG doesn't work properly, everything above that can use the XADD
> implementation.

Why are those not using the generic files? The generic code is obviously
more maintainable.

> But if you want it totally non-inline, then that can be done. However, whilst
> developing it, I did notice that that slowed things down, hence why I wanted
> it kept in line.

I want to keep the _fast_ case in-line.

I do not care at ALL about the stupid spinlock version. That should be the
_fallback_, and it should be out-of-line. It is always going to be the
slowest implementation, modulo bugs in architecture-specific code.

For i386 and i486, there is no reason to try to maintain a complex fast
case. The machines are unquestionably going away - we should strive to not
burden them unnecessarily, but we should _not_ try to save two cycles.

In short:
 - the only case that _really_ matters for performance is the uncontended
   read-lock for "reasonable" machines. A i386 no longer counts as
   reasonable, and designing for it would be silly. And the write-lock
   case is much less compelling.
 - We should avoid any inlines where the inline code is >2* the
   out-of-line code. Icache issues can overcome any cycle gains, and do
   not show up well in benchmarks (benchmarks tend to have very hot
   icaches). Note that this is less important for the out-of-line code in
   another segment that doesn't get brought into the icache at all for the
   non-contention case, but that should still be taken _somewhat_ into
   account if only because of kernel size issues.

Both of the above rules implies that the generic spin-lock implementation
should be out-of-line.

>   (1) asm-i386/rwsem-spin.h is wrong, and can probably be replaced with the
>       generic spinlock implementation without inconveniencing people much.
>       (though someone has commented that they'd want this to be inline as
>        cycles are precious on the slow 80386).

Icache is also precious on the 386, which has no L2 in 99% of all cases.
Make it out-of-line.

>   (2) "fix up linux/rwsem-spinlock.h": do you want the whole generic spinlock
>       implementation made non-inline then?

Yes. People who care about performance _will_ have architecture-specific
inlines on architectures where they make sense (ie 99% of them).

		Linus


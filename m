Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264414AbUF0Rkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUF0Rkk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 13:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUF0Rkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 13:40:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:43447 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264414AbUF0Rkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 13:40:36 -0400
Date: Sun, 27 Jun 2004 10:39:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: more (insane) jiffies ranting
In-Reply-To: <20040627015501.GA14647@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0406271022430.16079@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
 <20040626221802.GA12296@taniwha.stupidest.org> <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org>
 <20040627015501.GA14647@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jun 2004, Chris Wedgwood wrote:
> 
> On Sat, Jun 26, 2004 at 03:48:34PM -0700, Linus Torvalds wrote:
> 
> > But for most data structures, the way to control access is either
> > with proper locking (at which point they aren't volatile any more)
> > or through proper accessor functions (ie "jiffies_64" should
> > generally only be accessed with something that understands about
> > low/high word and update ordering and re-testing).
> 
> I don't entirely buy this.  Right now x86 code just assumes 32-bit
> loads are atomic and does them blindly in lots of places (ie. every
> user of jiffies just about).
> 
> Without the volatile it seems entirely reasonable gcc will produce
> correct, but wrong code here so I would argue 'volatile' is a property
> of the data in this case.

It's a property of the data _iff_:
 - it is _always_ volatile
 - it is only ever used atomically: this also means that it must be 
   totally independent of _all_ other data structures and have no linkages 
   to anything else.

Snd basically, the above is pretty much never true except possibly for 
real I/O accesses and sometimes things like simple "flags" (ie it's fine 
to use "volatile sigatomic_t flag;" in user programs to have signal 
handlers say "something happened" in a single-threaded environment).

NOTE! The "single-threaded environment" part really is important, and is 
one of the historical reasons for volatile having been more useful than it 
is today. If you are single-threaded and don't have issues like CPU memory 
ordering etc, then you can let the compiler do more of the work, and there 
are a lot of lockless algorithms that you can use that only depend on 
fairly simple semantics for "volatile".

But the fact is, for the kernel none of the above is ever really true. 
A 32-bit-atomic "jiffies" comes the closest, but even there the "always" 
property wasn't true - it wasn't true in the update phase, and we 
literally used to have something like this:

	*((unsigned long *)&jiffies)++;

to update jiffies and still get good code generation (now that we have a
64-bit jiffies and need to do more complex stuff anyway, we don't have
that any more, but you should be able to find it in 2.3.x kernels if I
remember correctly).

And _anything_ that has any data dependencies, "volatile" is totally
useless. Even the (acceptable in single-threaded user-space) "flag" thing 
is not valid usage in the kernel, since for a flag in a multi-threaded 
environment you still need an explicit CPU memory barrier in the code, 
making it impossible for the compiler to do the right thing anyway.

> > I repeat: it is the _code_ that knows about volatile rules, not the
> > data structure.
> 
> Except as I mentioned we have exceptions to this right now.

No we don't. The _only_ accepted exception is the special case of "the low
bits of jiffies", and that's accepted partly because of historical
reasons, and partly because it's fundamentally a data structure we don't
really care that much about. There should be no other ones.

And that special case _literally_ is only for people who don't care that 
much. Anybody who cares about "real time" needs to get xtime_lock and do 
the proper magic to get a real date.

So I don't see your argument. I'm obviously saying that "yes, we have 
_one_ case where we make a data structure volatile", but at the same time, 
that case is very much a "we don't really care too much about precision 
there, and even so people think we should have real accessor functions".

So I stand by the rule: we should make _code_ have the access rules, and
the data itself should never be volatile. And yes, jiffies breaks that
rule, but hey, that's not something I'm proud of.

		Linus

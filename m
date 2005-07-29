Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVG2QbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVG2QbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 12:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVG2QbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 12:31:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262649AbVG2QaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 12:30:13 -0400
Date: Fri, 29 Jul 2005 09:29:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: Steven Rostedt <rostedt@goodmis.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
 the work)
In-Reply-To: <Pine.LNX.4.61L.0507291456540.21257@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58.0507290924140.3307@g5.osdl.org>
References: <1122473595.29823.60.camel@localhost.localdomain> 
 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <1122513928.29823.150.camel@localhost.localdomain> 
 <1122519999.29823.165.camel@localhost.localdomain> 
 <1122521538.29823.177.camel@localhost.localdomain> 
 <1122522328.29823.186.camel@localhost.localdomain>  <42E8564B.9070407@yahoo.com.au>
  <1122551014.29823.205.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>  <1122565640.29823.242.camel@localhost.localdomain>
  <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
 <1122569848.29823.248.camel@localhost.localdomain> <Pine.LNX.4.58.0507281018170.3227@g5.osdl.org>
 <Pine.LNX.4.61L.0507291456540.21257@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Jul 2005, Maciej W. Rozycki wrote:
> 
>  Hmm, that's what's in the GCC info pages for the relevant functions 
> (I've omitted the "l" and "ll" variants):
> 
> "-- Built-in Function: int __builtin_ffs (unsigned int x)
>      Returns one plus the index of the least significant 1-bit of X, or
>      if X is zero, returns zero.

This, for example, clashes with the x86 semantics.

If X is zero, the bsfl instruction will set the ZF flag, and the result is 
undefined (on many, but not all, CPU's it will either be zero _or_ 
unmodified).

We don't care, since we actually test the input for being zero separately
_anyway_, but my point is that if the builtin is badly done (and I
wouldn't be in the least surprised if it was), then it's going to do a
totally unnecessary conditional jump of cmov.

See? __builtin's can generate _worse_ code, exactly because they try to 
have portable semantics that may not even matter.

In contrast, just doing it by hand allows us to avoid all that crap.

Doing it by hand as inline assembly also allows us to do dynamic 
optimizations like instruction rewriting, so inline assembly is a _lot_ 
more powerful than builtins can reasonably ever be.

> If that's not enough, then what would be?  I'm serious -- if you find it 
> inadequate, then perhaps it could be improved.

It's inadequate because IT IS POINTLESS.

The builtin buys you absolutely _nothing_, and the inline asm is simpler, 
potentially faster, and works with every single version of gcc. 

USING THE BUILTIN IS A PESSIMISATION!

It has absolutely _zero_ upsides, and I've named three _major_ downsides.

It has another downside too: it's extra complexity and potential for bugs 
in the compiler. And if you tell me gcc people never have bugs, I will 
laugh in your general direction.

		Linus

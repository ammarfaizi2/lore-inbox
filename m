Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266096AbRGDRXi>; Wed, 4 Jul 2001 13:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbRGDRX3>; Wed, 4 Jul 2001 13:23:29 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:7942 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266093AbRGDRXK>; Wed, 4 Jul 2001 13:23:10 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Why Plan 9 C compilers don't have asm("")
Date: Wed, 4 Jul 2001 17:22:44 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9hvjd4$1ok$1@penguin.transmeta.com>
In-Reply-To: <200107040337.XAA00376@smarty.smart.net> <20010703233605.A1244@zalem.puupuu.org> <20010704002436.C1294@ftsoj.fsmlabs.com>
X-Trace: palladium.transmeta.com 994267371 14359 127.0.0.1 (4 Jul 2001 17:22:51 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 4 Jul 2001 17:22:51 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010704002436.C1294@ftsoj.fsmlabs.com>,
Cort Dougan  <cort@fsmlabs.com> wrote:
>
>There isn't such a crippling difference between straight-line and code with
>unconditional branches in it with modern processors.  In fact, there's very
>little measurable difference.

Oh, the small details get to you eventually.

And it's not just the "call" and "ret" instructions.  They _do_ hurt,
even on modern CPU's, btw.  They tend to break up the prefetching, and
often mean that you cannot do as good of a instruction mix. 

But there's an even more serious problem: a function call in C is a
VERY heavy operation as far as the compiler is concerned. It's a major
sequence point, and the compiler doesn't know what memory locations are
potentially dead etc.

Which means that the compiler has to save everything that might be
relevant to memory, and depending on the calling convention has to
assume that registers are trashed.  And when you come back, you have to
re-load everything again, on the assumption that the function might have
changed state. 

You also often have issues like reloading the gp pointer on many 64-bit
architectures, where functions can be in different "domains", and
returning from an unknown function means that you have to do other nasty
setup in order to get at your global data.

And trust me, it's noticeable. On alpha, a fast function call _should_
be a a simple two-cycle thing - branch and return. But because of
practical linker issues, what the compiler ends up having to generate
for calls to targets that it doesn't know where they are is 

 - load a 64-bit address off the GP area that the linker will have fixed
   up.
 - do an indirect branch to that address
 - the callee re-loads the GP with _its_ copy of the GP if it needs any
   global data or needs to call anybody else.
 - we return to the caller
 - the caller reloads its GP.

Your theoretical two cycles that the CPU could follow in the front end
and speculate around turns into multiple loads, a indirect branch and
about 10 instructions.  And that's without any of the other effects even
being taken into account.  No matter _how_ good the CPU is, that's going
to be slower than not doing it. 

[ And yes, I know there are optimizing linkers for the alpha around that
  improve this and notice when they don't need to change GP and can do a
  straight branch etc.  I don't think GNU ld _still_ does that, but who
  knows. Even the "good" Digital compilers tended to nop out unnecessary
  instructions rather than remove them, causing more icache pressure on
  a CPU that was already famous for needing tons of icache ]

Now, you could get around a bit of this by allowing for special calling
conventions.  Gcc actually has this for some details - namely the
"register arguments" part, which actually makes for much more readable
code (that's my main personal use for it - never mind the fact that it
is probably faster _too_). 

But gcc doesn't have a good "you can re-order this call wrt other stuff"
setup, and gcc lacks the ability to change the calling convention
on-the-fly ("this function will not clobber any registers"). 

Try it and see. There are good reasons for "inline asm", not the least
of which is that it often makes the produced code much more readable.

And if you never look at the produced assembler code, then you'll never
have a fast system. Really. Compilers can do only so much. People who
understand what the end result is makes for a difference.

Now, you could probably argue that instead of inline asms we should have
more flexibility in doing a per-callee calling convention. That would be
good too, no question about it.

			Linus

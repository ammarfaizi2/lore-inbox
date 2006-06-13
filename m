Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932927AbWFMGnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932927AbWFMGnN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 02:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbWFMGnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 02:43:13 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:59795 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932927AbWFMGnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 02:43:13 -0400
Date: Tue, 13 Jun 2006 08:43:11 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Emmanuel Fleury <emmanuel.fleury@labri.fr>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] i386: use C code for current_thread_info()
Message-ID: <20060613064311.GA27543@rhlx01.fht-esslingen.de>
References: <200606122152_MC3-1-C240-D8AE@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606122152_MC3-1-C240-D8AE@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 12, 2006 at 09:50:17PM -0400, Chuck Ebbert wrote:
> In-Reply-To: <20060612184833.GA29177@rhlx01.fht-esslingen.de>
> 
> On Mon, 12 Jun 2006 20:48:33 +0200, Andreas Mohr wrote:
> 
> > > Kernel code starts out ~30K bytes smaller with gcc 4.1 and using C
> > > for current_thread_info() helps even more than with 4.0.  Nice...
> > 
> > Especially since current_thread_info() often has an AGI stall (read:
> > severe pipeline stall) since it often cannot properly intermingle
> > with nearby opcodes due to lack of suitable ones, e.g. at a
> > function prologue.
> > mov    $0xffffe000,%eax
> > and    %esp,%eax
> > are fundamentally incompatible due to having to wait for the address
> > generation before the "and" can be executed.
> > This shows up during profiling quite noticeably (IIRC 8 hits vs. 1 to 2
> > hits on other places), which really hurts since this function is used
> > basically *everywhere*.
> 
> Hmmm.  The compiler does it this way:
> 
>   mov    %esp,%eax
>   and    $0xffffe000,%eax

Well, not here, since mine was a live example of the old asm version
compiled with gcc 3.2.3 (but I doubt the gcc version matters in this case
since a compiler wouldn't decide to create completely different asm
opcodes from a hand-coded asm version...).

> which could be faster because esp can be moved to eax while the mask
> is being fetched.

That might be true, but it could easily happen to not be (an AGI stall
stalls both pipelines, IIRC, so in one case you can have good instruction
parallelism before the 0xffffe000 address and in the other case after it).
It would be very interesting to run some well-known kernel benchmarks,
since given the very wide-spread use of the function this could easily make
a noticeable difference.
Hmm, in fact I'm afraid that your version may be slower since it has the esp
operation first which doesn't mix at all with function prologues due to
heavy esp modification (i.e. waiting for esp to settle down) in the function
stack frame generation. And as said before, current_thread_info() is heavily
used near prologues since in many functions we're basically doing
"which cpu are we on? get cpu data! now get to work...".
This could be so bad as to disallow any and all attempt at making the compiler
guess it since a hand-coded version would account for this (but a compiler
certainly should, too!).
Come to think of it, did you check whether the compiler also did those opcodes
the other way around at some places depending on environment?

Since this important function sucks on x86 (due to braindead lack of registers
on this architecture, to possibly permanently store the calculated stack
base value inside), I'm thinking of investigating it again.

An entirely different way would be to store the stack base value in a
global variable and update that on each context switch, but it would increase
context switch overhead and have >= 2 cycles access time for L1 cache (which
would be the best memory access case!), which would most likely be more
combined overhead than an AGI stall (I was mistaken in declaring the stall
a pipeline flush - it's only a stall for a couple cycles, not a full flush
wasting ~ 15 cycles).
And I wouldn't be too astonished to learn that this has exactly been the
previous solution and then deprecated for modernization or performance
reasons...

Andreas Mohr

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRCCUEV>; Sat, 3 Mar 2001 15:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRCCUEM>; Sat, 3 Mar 2001 15:04:12 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:47882 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129733AbRCCUED>;
	Sat, 3 Mar 2001 15:04:03 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103032004.f23K417447302@saturn.cs.uml.edu>
Subject: Re: RFC: changing precision control setting in initial FPU context
To: buhr@stat.wisc.edu (Kevin Buhr)
Date: Sat, 3 Mar 2001 15:04:01 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <vbar90ftagx.fsf@mozart.stat.wisc.edu> from "Kevin Buhr" at Mar 03, 2001 04:26:06 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Buhr writes:
> "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

>> So you change it to 2... but what about the "float" type? It gets
>> a mixture of 64-bit and 32-bit IEEE arithmetic depending rather
>> unpredictably on compiler register allocations and optimizations???
>
> Well, yes, but I'll try not to cry myself to sleep over it.  I'm
> tempted to say that someone who chooses to use "float"s has given up
> all pretense of caring about the answers they get.  And, if they
> really want to do predictable math with floats they can change the FPU
> control word from whatever its default is to PC==0.

There are algorithms which work fine using 32-bit floating-point,
but which become unstable when you get unpredictable precision.
It is reasonable to use such an algorithm and some 64-bit math in
the same program. So there isn't any correct x86 setting.

>> If a "float" will have excess precision, then a "double" might
>> as well have it too. Usually it helps, but sometimes it hurts.
>> This is life with C on x86.
>
> That's the way I initially felt, and it looks silly when it's written
> down, so I'm glad I changed my mind.
>
> I don't think extra precision that is unpredictable is ever helpful.
> Extra precision that might be gained or lost depending on, say, which
> branch of an if-statement is taken, is of no use to anyone.  It just
> causes confusion.  The excess precision on "float" is a nuisance.  The
> excess precision on "double" is another nuisance.  It would be nice to
> eliminate one of those nuisances, at least by default.

That would be an awful idea. There are two main useful behaviors:

1. Pure IEEE for 32-bit, 64-bit, and 80-bit floating-point values.
   The compiler rounds intermediate values by writing to memory
   or by adjusting the precision control before each operation.

2. Extra precision when it comes free. The precision control is set
   to 80-bit and the compiler tries to keep values in registers.
   This is usually the more useful behavior, and it performs better.

What you are suggesting is a gross hybrid. You claim it has something
to do with IEEE, but it doesn't handle 32-bit math correctly. Your
proposal is NOT true IEEE math.

>> Ugh, more start-up crud.
> 
> The startup crud is already there.  It's used to allow linking with
> "-lieee" to set a new control word value, for example, and it's

Woah, what kind of crap is that???? You can not get true IEEE math
by setting the precision control word at startup. This is a bug.
The compiler must save values to memory or adjust the precision
control as needed.

For example, the precision control could be loaded on function entry.
This may be optimized away for some "static" or "inline" functions.

> To me, a system call (not necessarily a *new* system call, but some
> way to get the desired FPU control word to the kernel) seems like a
> more elegant solution.
>
> On the other hand, I'm not married to the idea.  I'd rather just get
> the default control word changed in the kernel.

Check the archives: the x86 Linux ABI specifies 80-bit precision.
This will never change. The library is supposed to assume this,
rather than try to allow for a change that will never happen.
Linus dished out some nice toasty flames for the libc developers
over this.

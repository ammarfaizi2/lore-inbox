Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269065AbTBXByV>; Sun, 23 Feb 2003 20:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269070AbTBXByV>; Sun, 23 Feb 2003 20:54:21 -0500
Received: from science.horizon.com ([192.35.100.1]:10051 "HELO
	science.horizon.com") by vger.kernel.org with SMTP
	id <S269065AbTBXByT>; Sun, 23 Feb 2003 20:54:19 -0500
Date: 24 Feb 2003 02:04:26 -0000
Message-ID: <20030224020426.1096.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Minutes from Feb 21 LSE Call
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus brought back tablets from the mount on which were graven:
> The x86 is a hell of a lot nicer than the ppc32, for example.  On the
> x86, you get good performance and you can ignore the design mistakes (ie
> segmentation) by just basically turning them off.

Now wait a minute.  I thought you worked at Transmeta.

There were no development and debugging costs associated with getting
all those different kinds of gates working, and all the segmentation
checking right?

Wouldn't it have been easier to build the system, and shift the effort
where it would really do some good, if you didn't have to support
all that crap?

An extra base/bounds check doesn't take any die area?  An extra exception
source doesn't complicate exception handling?

> And the baroque instruction encoding on the x86 is actually a _good_
> thing: it's a rather dense encoding, which means that you win on icache. 
> It's a bit hard to decode, but who cares? Existing chips do well at
> decoding, and thanks to the icache win they tend to perform better - and
> they load faster too (which is important - you can make your CPU have
> big caches, but _nothing_ saves you from the cold-cache costs). 

I *really* thought you worked at Transmeta.

Transmeta's software-decoding is an extreme example of what all modern
x86 processors are doing in their L1 caches, namely predecoding the
instructions and storing them in expanded form.  This varies from
just adding boundary tags (Pentium) and instruction type (K7) through
converting them to uops and cacheing those (P4).

This exactly undoes any L1 cache size benefits.  The win, of course, is
that you don't have as much shifting and aligning on your i-fetch path,
which all the fixed-instruction-size architectures already started with.

So your comments only apply to the L2 cache.

And for the expense of all the instruction predecoding logic betweeen
L2 and L1, don't you think someone could build an instruction compressor
to fit more into the die-size-limited L2 cache?  With the sizes cache likes
are getting to these days, you should be able to do pretty well.
It seems like 6 of one, half dozen of the other, and would save the
compiler writers a lot of pain.

> The low register count isn't an issue when you code in any high-level
> language, and it has actually forced x86 implementors to do a hell of a
> lot better job than the competition when it comes to memory loads and
> stores - which helps in general.  While the RISC people were off trying
> to optimize their compilers to generate loops that used all 32 registers
> efficiently, the x86 implementors instead made the chip run fast on
> varied loads and used tons of register renaming hardware (and looking at
> _memory_ renaming too).

I don't disagree that chip designers have managed to do very well with
the x86, and there's nothing wrong with making a virtue out of a necessity,
but that doesn't make the necessity good.

I was about to raise the same point.  L1 dcache access tends to be a
cycle-limiting bottleneck, and as pearly as the original Pentium, the
x86 had to go to a 2-access-per-cycle L1 dcache to avoid bottlenecking
with only 2 pipes!

The low register count *does* affect you when using a high-level language,
because if you have too many live variables floating around, you start
suffering.  Handling these spills is why you need memory renaming.

It's true that x86 processors have had fancy architectural features
sooner than similar-performance RISCs, but I think there's a fair case
that that's because they've *needed* them.  Why do the P4 and K7/K8 have
such enormous reorder buffers, able to keep around 100 instructions
in flight at a time?  Because they need it to extract parallelism out
of an instruction stream serialized by a miserly register file.

They've developed some great technology to compensate for the weaknesses,
but it's sure nice to dream of an architecture with all that great
technology but with fewer initial warts.  (Alpha seemed like the
best hope, but *sigh*.  Still, however you apportion blame for its
demise, performance was clearly not one of its problems.)


I think the same claim applies much more powerfully to the ppc32's MMU.
It may be stupid, but it is only visible from inside the kernel, and
a fairly small piece of the kernel at that.

It could be scrapped and replaced with something better without any
effect on existing user-level code at all.

Do you think you can replace the x86's register problems as easily?

> The only real major failure of the x86 is the PAE crud.

So you think AMD extended the register file just for fun?

Hell, the "PAE crud" is the *same* problem as the tiny register
file.  Insufficient virtual address space leading to physical > virtual
kludges.

And, as you've noticed, there are limits to the physical/virtual
ratio above which it gets really painful.  And the 64G:4G ratio of PAE
is mirrored in the 128:8 ratio of P4 integer registers.

I wish the original Intel designers could have left a "no heroic measures"
living will, because that design is on more life support than Darth Vader.

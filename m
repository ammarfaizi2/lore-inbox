Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262829AbRFLRtn>; Tue, 12 Jun 2001 13:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262843AbRFLRtY>; Tue, 12 Jun 2001 13:49:24 -0400
Received: from 216-60-128-134.ati.utexas.edu ([216.60.128.134]:33796 "EHLO
	webofficenow.com") by vger.kernel.org with ESMTP id <S262829AbRFLRtT>;
	Tue, 12 Jun 2001 13:49:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, mnelson@dynatec.com (Matt Nelson)
Subject: Re: Any limitations on bigmem usage?
Date: Tue, 12 Jun 2001 08:46:57 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E159r2Z-0001b4-00@the-village.bc.nu>
In-Reply-To: <E159r2Z-0001b4-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01061208465701.00814@webofficenow.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 June 2001 12:29, Alan Cox wrote:

> If your algorithm can work well with say 2Gb windows on the data and only
> change window evey so often (in computing terms) then it should be ok, if
> its access is random you need to look at a 64bit box like an Alpha, Sparc64
> or eventually IA64

No, eventually Sledgehammer.

You know that IA64 will never ship, because the performance will always suck. 
 The design is fundamentally flawed.  The real bottleneck is the memory bus.  
These days they're clock multiplying the inside of the processor by a factor 
of what, twelve?  Fun as long as you're entirely in L1 cache and aren't task 
switching.  But that's basicaly an embedded system.

CISC instructions are effectively compressed.  When you exhaust your cache 
your next 64 bit gulp can get more than 2 instructions, you can get more like 
5 (which still means you're getting about 1/4 the performance of in-cache 
execution, although L2 and L3 caches help here, of course..)

But optimizing for something that isn't actually your bottleneck is just 
dumb, and that's exactly what Intel did with the move to VLIW/EPIC/IA64.  3 
times 64 bit instructions is 192, whereas Pentium can fit more than that in a 
single 64 bit chunk.  Brilliant.  You need what, a 6x larger cache just to 
break even with the amount of time you're running in-cache?  And of course 
the compiler is GOING to put NOPs in that because it won't always be able to 
figure out something for the second and third cores to do this clock, 
regardless of how good a compiler it is.  That's just beautiful.

This is why they were so desperate for RAMBUS.  They KNOW the memory bus is 
killing them, they were grasping at straws to fix it.  (Currently they're 
saying that a future vaporware version of iTanium will fix everything, but 
it's a fundamental design flaw: the new instruction set they've chosen is WAY 
less efficient going across the memory bus, and that's the real limiting 
factor in performance.)

Transmeta at least sucks CISC in from main memory to keep the northbridge 
bottleneck optimized.  And they have a big cache, and they're still using 32 
bit instructions so they only need 96 bytes per chunk (or atom or whatever 
they're calling it these days).

Sledgehammer is the interesting x86 64 bit instruction set.  You still have 
the cisc/risc hybrid that made pentium work.  (And, of course, backwards 
compatability that's inherent in the design rather than bolted onto the side 
with duct tape and crazy glue.)  Yeah the circuitry to make it work is 
probably fairly insane, but at least the Athlon design team made all the racy 
logic go away so they can migrate the design to new manufacturing processes 
without four months of redesign work.  (And no, making insanely long 
pipelines in Pentium 4 is not a major improvement there either.  Cache 
exhaustion still kills you, so does branch misprediction.  Stalling a longer 
pipeline is more expensive.)

I saw an 800 mhz iTanium which benchmarked about the same (running 64 bit 
code) as a Penium III 300 mhz running 32 bit code.  That's just sad.  Go 
ahead and blame the compiler.  That's still just sad.  And a design flaw in 
the new instruction set is not something that can be easily optimized away.

Rob

Return-Path: <linux-kernel-owner+w=401wt.eu-S968833AbWLHTRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968833AbWLHTRC (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968832AbWLHTRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:17:01 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51395 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968831AbWLHTQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:16:59 -0500
Date: Fri, 8 Dec 2006 11:15:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <Pine.LNX.4.64.0612080919220.16029@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0612081101280.3516@woody.osdl.org>
References: <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au>
 <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au>
 <20061208085634.GA25751@flint.arm.linux.org.uk> <4595.1165597017@redhat.com>
 <Pine.LNX.4.64.0612080903370.15959@schroedinger.engr.sgi.com>
 <20061208171816.GG31068@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612080919220.16029@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2006, Christoph Lameter wrote:
> 
> As also shown in this thread: There are restrictions on what you can do 
> between ll/sc

This, btw, is almost certainly true on ARM too.

There are three major reasons for restrictions on ll/sc:

 - bus-cycle induced things (eg variations of "you cannot do a store in 
   between the ll and the sc, because it will touch the cache and clear 
   the bit", where "the store" might be a load too, and "the cache" might
   be just "the bus interface")

 - trap handling usually clears the internal lock bit too, which means 
   that depending on the micro-architecture, even internal microtraps 
   (like even just branch misprediction, but more commonly things like TLB 
   misses etc) can cause a sc to always fail.

 - timing. Livelock in particular.

The last one is the one that hits everybody, regardless of 
microarchitecture. The rule may be that the LL/SC need to be within a 
certain number of cycles (which can be very small - like ten) in order to 
guarantee that the cacheline can't be stolen. 

All of which means that _nobody_ can really do this reliably in C. Even if 
there are no other microarchitectural rules (and it sounds like that might 
be true on ARM), the timing issue means that you can _still_ only use it 
for very specific and simple sequences, and trying to expose it as a 
higher-level thing is not going to work in general for anything even 
remotely complicated.

(The timing may also mean that you end up having to do random back-off 
etc, just to make sure _somebody_ makes progress. Ie it might not be a 
matter of "within ten cycles", but "you need to randomize the timing").

In other words, it's simply not an option to expose LL/SC as an interface. 
It would be VERY convenient to do, since cmpxchg can emulate ll/sc (the 
"ll" part is a normal load, the "sc" part is a "compare that the old value 
still matches, and store the new one if so"). But because you can't expose 
LL/SC anyway in any reasonably portable way, that just doesn't work.

So, you really do end up with three possibilities:

 - do things with TRULY PORTABLE interfaces. And like it or not, cmpxchg 
   is the closest thing you can get to that. It's trivial to do cmpxchg 
   using ll/sc (modulo the "random backoff part" if you need it, which is 
   still pretty simple, but no longer totally trivial), and architectures 
   that have neither ll/sc _nor_ a native cmpxchg can just go screw 
   themselves with spinlocks - they really aren't worth worrying about in 
   SMP. At some point you have to tell hardware designers that their 
   hardware just sucks.

 - have ugly conditional code in generic code. I personally think this is 
   a _much_ worse option in most cases.

 - have a much higher-level interface and make it _all_ architecture- 
   dependent (possibly with a "generic" version for sane architectures). 
   This works, but the more high-level it is, the more you end up having 
   the same thign written in many different ways, and nasty maintenance.

   So we generally set the bar pretty low. Things like semaphore locking 
   primitives are high-level enough already that we prefer to try to make 
   them use common lower-level interfaces (spinlocks, cmpxchg etc). 
   Something like kernel/workqueue.c is _way_ too high a level to do 
   arch-specific.

So right now, I think the "cmpxchg" or the "bitmask set" approach are the 
alternatives. Russell - LL/SC simply isn't on the table as an interface, 
whether you like it or not.

		Linus

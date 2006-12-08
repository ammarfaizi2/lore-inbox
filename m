Return-Path: <linux-kernel-owner+w=401wt.eu-S1426154AbWLHTbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426154AbWLHTbf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426156AbWLHTbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:31:34 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2877 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426154AbWLHTbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:31:33 -0500
Date: Fri, 8 Dec 2006 19:31:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061208193116.GI31068@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Christoph Lameter <clameter@sgi.com>,
	David Howells <dhowells@redhat.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
	linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au> <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au> <20061208085634.GA25751@flint.arm.linux.org.uk> <4595.1165597017@redhat.com> <Pine.LNX.4.64.0612080903370.15959@schroedinger.engr.sgi.com> <20061208171816.GG31068@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612080919220.16029@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612081101280.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612081101280.3516@woody.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 11:15:58AM -0800, Linus Torvalds wrote:
> On Fri, 8 Dec 2006, Christoph Lameter wrote:
> > 
> > As also shown in this thread: There are restrictions on what you can do 
> > between ll/sc
> 
> This, btw, is almost certainly true on ARM too.
> 
> There are three major reasons for restrictions on ll/sc:
> 
>  - bus-cycle induced things (eg variations of "you cannot do a store in 
>    between the ll and the sc, because it will touch the cache and clear 
>    the bit", where "the store" might be a load too, and "the cache" might
>    be just "the bus interface")

No such restriction on ARM.

>  - trap handling usually clears the internal lock bit too, which means 
>    that depending on the micro-architecture, even internal microtraps 
>    (like even just branch misprediction, but more commonly things like TLB 
>    misses etc) can cause a sc to always fail.

Also not true.  The architectural implementation is:

	ldrex: tags the _physical_ address + cpu number,
		transitions to exclusive access.

	strex: if in exclusive access state and matches the previous
		tagged physical address + cpu number pair, store
		succeeds.

This is typically implemented in hardware, and in the case of a SMP
system, external to the CPU cores themselves.  So all it's doing is
looking at the exclusive accesses.  It is not embedded into the CPU
core so that micro-architectural stuff affects it.

>  - timing. Livelock in particular.

That is a problem that we're facing, and the solution is rather simple.
You need to introduce a CPU-number specific number of cycles before
retrying the operation on failure.

> All of which means that _nobody_ can really do this reliably in C.

I utterly disagree.  I could code atomic_add() as:

extern void cpu_specific_delay(void);

static inline int atomic_add_return(int i, atomic_t *v)
{
	do {
		asm("ldrex %0, [%1]" : "=r" (val) : "r" (v));
		val += i;
		asm("strex %0, %1, [%2]" : "=r" (res) : "r" (val), "r" (v));
		if (res)
			cpu_specific_delay();
	} while (res);

	return val;
}

and actually we /are/ going to have to go down this path to break the
livelock problem, like it or not.  Ditto for the ARM bitops operations,
so we might as well have ARM at least implement a generic ll/sc thing.

Coding the cpu specific delays into every strex site is going to make
them far too heavy to put inline.

> So right now, I think the "cmpxchg" or the "bitmask set" approach are the 
> alternatives. Russell - LL/SC simply isn't on the table as an interface, 
> whether you like it or not.

Buggerit then.  cmpxchg sucks as an interface, and I am going to
continue to assert that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:

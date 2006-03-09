Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWCIQdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWCIQdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWCIQdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:33:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5310 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422638AbWCIQdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:33:10 -0500
Date: Thu, 9 Mar 2006 08:32:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
In-Reply-To: <24280.1141904462@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603090814530.18022@g5.osdl.org>
References: <1141855305.10606.6.camel@localhost.localdomain> 
 <20060308161829.GC3669@elf.ucw.cz> <31492.1141753245@warthog.cambridge.redhat.com>
 <24309.1141848971@warthog.cambridge.redhat.com>  <24280.1141904462@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Mar 2006, David Howells wrote:
> 
> So, you're saying that the LOCK and UNLOCK primitives don't actually modify
> memory, but rather simply pin the cacheline into the CPU's cache and refuse to
> let anyone else touch it?
> 
> No... it can't work like that. It *must* make a memory modification - after
> all, the CPU doesn't know that what it's doing is a spin_unlock(), say, rather
> than an atomic_set().

Basically, as long as nobody else is reading the lock, the lock will stay 
in the caches.

Only old and stupid architectures go out to the bus for locking. For 
example, I remember the original alpha "load-locked"/"store-conditional", 
and it was totally _horrible_ for anything that wanted performance, 
because it would do the "pending lock" bit on the bus, so it took hundreds 
of cycles even on UP. Gods, how I hated that. It made it almost totally 
useless for anything that just wanted to be irq-safe - it was cheaper to 
just disable interrupts, iirc. STUPID.

All modern CPU's do atomic operations entirely within the cache coherency 
logic. I think x86 still support the notion of a "locked cycle" on the 
bus, but I think that's entirely relegated to horrible people doing locked 
operations across PCI, and quite frankly, I suspect that it doesn't 
actually mean a thing (ie I'd expect no external hardware to actually 
react to the lock signal). However, nobody really cares, since nobody 
would be crazy enough to do locked cycles over PCI even if they were to 
work.

So in practice, as far as I know, the way _all_ modern CPU's do locked 
cycles is that they do it by getting exclusive ownership on the cacheline 
on the read, and either having logic in place to refuse to do release the 
cacheline until the write is complete (ie "locked cycles to the cache"), 
or to re-try the instruction if the cacheline has been released by the 
time the write is ready (ie "load-locked" + "store-conditional" + 
"potentially loop" to the cache).

NOBODY goes out to the bus for locking any more. That would be insane and 
stupid. 

Yes, many spinlocks see contention, and end up going out to the bus. But 
similarly, many spinlocks do _not_ see any contention at all (or other 
CPU's even looking at them), and may end up staying exclusive in a CPU 
cache for a long time.

The "no contention" case is actually pretty important. Many real loads on 
SMP end up being largely single-threaded, and together with some basic CPU 
affinity, you really _really_ want to make that single-threaded case go as 
fast as possible. And a pretty big part of that is locking: the difference 
between a lock that goes to the bus and one that does not is _huge_.

And lots of trivial code is almost dominated by locking costs. In some 
system calls on an SMP kernel, the locking cost can be (depending on how 
good or bad the CPU is at them) quite noticeable. Just a simple small 
read() will take several locks and/or do atomic ops, even if it was cached 
and it looks "trivial".

			Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132819AbQL1XqI>; Thu, 28 Dec 2000 18:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132817AbQL1Xp6>; Thu, 28 Dec 2000 18:45:58 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31492 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132792AbQL1Xpv>; Thu, 28 Dec 2000 18:45:51 -0500
Date: Thu, 28 Dec 2000 15:15:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
In-Reply-To: <20001228231722.A24875@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.10.10012281459150.995-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000, Andi Kleen wrote:
> 
> BTW..
> 
> The current 2.4 struct page could be already shortened a lot, saving a lot
> of cache.

Not that much, but some.

> (first number for 32bit, second for 64bit) 
> 
> - Do not compile virtual in when the kernel does not support highmem
> (saves 4/8 bytes) 

Even on UP, "virtual" often helps. The conversion from "struct page" to
the linear address is quite common, and if "struct page" isn't a
power-of-two it gets slow.

> - Instead of having a zone pointer mask use a 8 or 16 byte index into a 
> zone table. On a modern CPU it is much cheaper to do the and/shifts than
> to do even a single cache miss during page aging. On a lot of systems 
> that zone index could be hardcoded to 0 anyways, giving better code.
> - Instead of using 4/8 bytes for the age use only 16bit (FreeBSD which
> has the same swapping algorithm even only uses 8bit) 

This would be good, but can be hard.

FreeBSD doesn't try to be portable any more, but Linux does, and there are
architectures where 8- and 16-bit accesses aren't atomic but have to be
done with read-modify-write cycles.

And even for fields like "age", where we don't care whether the age itself
is 100% accurate, we _do_ care that the fields close-by don't get strange
effects from updating "age". We used to have exactly this problem on alpha
back in the 2.1.x timeframe.

This is why a lot of fields are 32-bit, even though we wouldn't need more
than 8 or 16 bits of them.

> - Remove the waitqueue debugging (obvious @)

Not obvious enough. There are magic things that could be done, like hiding
the wait-queue lock bit in the waitqueue lists themselves etc. That could
be done with some per-architecture magic etc.

> - flags can be __u32 on 64bit hosts, sharing 64bit with something that
> is tolerant to async updates (e.g. the zone table index or the index) 
> - index could be probably u32 instead of unsigned long, saving 4 bytes
> on i386

It already _is_ 32-bit on x86. 

Only the LSF patches made it 64-bit. That never made it into the standard
kernel.

Sure, we could make it "u32" and thus force it to be 32-bit even on 64-bit
architectures, but some day somebody will want to have more than 46 bits
of file mappings, and which 46 bits is _huge_ on a 32-bit machine, on a
64-bit one in 5 years it will not be entirely unreasonable. 

Anyway, I don't want to increase "struct page" in size, but I also don't
think it's worth micro-optimizing some of these things if the code gets
harder to maintain (like the partial-word stuff would be).

The biggest win by far would come from increasing the page-size, something
we can do even in software. Having a "kernel page size" of 8kB even on x86
would basically cut the overhead in half. As that would also improve some
other things (like having better throughput due to bigger contiguous
chunks), that's something I'd like to see some day.

(And user space wouldn't ever have to know - we could map in "half pages"
aka "hardware pages" without mappign the whole page).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

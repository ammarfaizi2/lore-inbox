Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271619AbRIOAaA>; Fri, 14 Sep 2001 20:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271620AbRIOA3v>; Fri, 14 Sep 2001 20:29:51 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:2821 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S271619AbRIOA3p>;
	Fri, 14 Sep 2001 20:29:45 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200109150029.f8F0Tig479554@saturn.cs.uml.edu>
Subject: Re: Purpose of the mm/slab.c changes
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 14 Sep 2001 20:29:43 -0400 (EDT)
Cc: manfred@colorfullife.com (Manfred Spraul),
        andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33.0109090925080.14365-100000@penguin.transmeta.com> from "Linus Torvalds" at Sep 09, 2001 09:25:29 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> On Sun, 9 Sep 2001, Manfred Spraul wrote:

>>> it provides lifo allocations from both partial and unused slabs.
>>
>> lifo/fifo for unused slabs is obviously superflous - free is free, it
>> doesn't matter which free page is used first/last.
>
> You're full of crap.
>
> LIFO is obviously superior due to cache re-use.

I think a bit of arch-specific code could do better.

Since I happen to have the MPC7400 manual at hand, I'll use that
for my example. This is the PowerPC "G4" chip.

The L1 cache is 8-way, 32 bytes/block, and has 128 sets. The L1
cache block replacement algorithm will select an invalid block
whenever possible. If an invalid block isn't available, then a
dirty block must go out to L2. The L2 cache is 2-way, as large
as 2 MB, and has FIFO replacement.

Now, considering that allocator:

The LIFO way: likely to suck up memory/L2 bandwidth writing
out dirty data that we don't care about, plus you risk stalling
the CPU to do this while in need of a free cache block.

The alternative: invalidate the cache line. This takes just
one instruction per cache line, and causes an address-only
bus operation at worst. Completely unrelated code may run
faster due to the availability of invalid cache lines.




Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155026AbQAaCYc>; Sun, 30 Jan 2000 21:24:32 -0500
Received: by vger.rutgers.edu id <S154168AbQAaCXa>; Sun, 30 Jan 2000 21:23:30 -0500
Received: from dyn-225.linux.theplanet.co.uk ([195.92.192.225]:2960 "EHLO caramon.arm.linux.org.uk") by vger.rutgers.edu with ESMTP id <S155087AbQAaCVy>; Sun, 30 Jan 2000 21:21:54 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200001302349.XAA03967@raistlin.arm.linux.org.uk>
Subject: Re: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
To: davem@redhat.com (David S. Miller)
Date: Sun, 30 Jan 2000 23:49:17 +0000 (GMT)
Cc: linux-kernel@vger.rutgers.edu
In-Reply-To: <200001302211.OAA03036@pizda.ninka.net> from "David S. Miller" at Jan 30, 2000 02:11:49 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

David S. Miller writes:
> You have no mechanism whatsoever to disable the cache on a per-page
> basis with MMU mappings?  This would very much surprise me.

Please see my later mailing about 1MB mappings.  I do not wish to map
the whole kernel memory in using 4k page tables - that would just too
sick to even consider.  What if I came up with something which required
x86 to map in its kernel memory using ptes?  ie, which prevented the
use of PSEs.  How would that be accepted?  Probably the same way that
I'm reacting to this change, but on a larger scale.

> For the actual transfers, you can do the dma_cache_*() calls in the
> pci_{un,}map_streaming() calls.

That is what I thought, but the problems I see which this introduces
are either:

1. pci_map_* needs to handle the cache *and* pci_unmap_* has to as well,
   thereby expending twice the number of CPU cycles over cache handling
   that the old way did.

2. pci_map_* needs to clean and flush the cache unconditionally, which
   will result in DMA reads needlessly cleaning stale data out of the
   cache (with the associated slow bus cycles).

Both of these suffer from at last a doubling of the non-cache-coherentness
that the old way allowed.

> The only place you could possibly need it is for the IDE scatter list
> tables, and that would only be if you have _no_ mechanism to disable
> the CPU cache in the MMU, which I severely doubt.

Read above.

> Actually, don't be pissed, and instead work with us to get your
> port working again.  The changes were designed so that all of
> the cache flushing hacks could just dissapear and be hidden
> within the new interfaces on ports which needed.

Unfortunately, they are not designed well enough.

> I was completely convinced that if all dma mappings were handled
> explicitly in the manner they are now, none of that crap would be
> needed anymore.

My main bug bear with this is that there was virtually no evidence of
discussion of this method of fixing the problem between concerned people
(ie, architecture maintainers) who would get hit hardest by the change.
If there was, we wouldn't be in this situation we are now.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | |   http://www.arm.linux.org.uk/~rmk/aboutme.html    /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

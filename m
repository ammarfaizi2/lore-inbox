Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156618AbPLAPMR>; Wed, 1 Dec 1999 10:12:17 -0500
Received: by vger.rutgers.edu id <S156491AbPLAPFi>; Wed, 1 Dec 1999 10:05:38 -0500
Received: from chiara.csoma.elte.hu ([157.181.71.18]:3614 "EHLO chiara.csoma.elte.hu") by vger.rutgers.edu with ESMTP id <S156675AbPLAO4x>; Wed, 1 Dec 1999 09:56:53 -0500
Date: Wed, 1 Dec 1999 17:02:09 +0100 (CET)
From: Ingo Molnar <mingo@chiara.csoma.elte.hu>
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: DMA and Cache coherency on machines without hardware enforced cache  coherency.
In-Reply-To: <38452EF2.4539A348@raleigh.ibm.com>
Message-ID: <Pine.LNX.4.10.9912011654400.5533-100000@chiara.csoma.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


On Wed, 1 Dec 1999, Ralph Blach wrote:

> I have to write a device driver for a machine which does not have
> hardware enforced cache coherency between bus master devices and the
> CPU caches.  Is there a way to allocate certain buffers in uncached
> memory.  I know this would lower performance, but it would also solve
> certain problems which seem to be cropping up.

ioremap_nocache(). You can also use ioremap_nocache() on allocated pages
(it's a page granularity thing) via doing something like:

	page = __get_free_pages(whatever, order);
	ptr = ioremap_nocache(virt_to_phys(page), 1 <<
			(order+PAGE_SHIFT));

then use 'ptr' as an uncached alias to your pages. You cannot do the above
in interrupts (obviously), and it's not fast so probably it's worth being
done once, at initization time.

for this to work you also have to modify arch/i386/mm/ioremap.c and
remove the following lines:

        /*
         * Don't allow anybody to remap normal RAM that we're using..
         */
        if (phys_addr < virt_to_phys(high_memory))
                return NULL;

and remove:

        if (addr > high_memory)

from the iounmap() function.

or better, create a new interface (memremap_nocache()) which only remaps
normal RAM pages.

-- mingo


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271945AbRIILGd>; Sun, 9 Sep 2001 07:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271947AbRIILGX>; Sun, 9 Sep 2001 07:06:23 -0400
Received: from colorfullife.com ([216.156.138.34]:39435 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S271945AbRIILGS>;
	Sun, 9 Sep 2001 07:06:18 -0400
Message-ID: <3B9B4CFE.E09D6743@colorfullife.com>
Date: Sun, 09 Sep 2001 13:05:34 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-ac1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com, andrea@suse.de
Subject: Purpose of the mm/slab.c changes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the purpose of the mm/slab.c changes?

Linus, Alan, could you please drop them. Switching from 1 list to 3
lists is just a slowdown.

		2.4.9	2.4.9-ac9
km(1)		0x87	0x89
kf(1)		0xa9	0xa8
kf(cachep, 1)	0xad	0xad
km(4096)	0x7B	0x87	(+24% without overhead!)
kf(4096)	0xcB	0xd1
kf(cachep,4096)	0xcc	0xd3

(cpu ticks on a Duron 700, UP kernel, 100 calls in a tight loop, loop
overhead (0x49) not removed)

Benchmarking with SMP kernel is meaningless, since the actual list
changes are outside of the hot path - I did it, and the differences are
negligable (+-1 cpu tick)

And this is a benchmark with 100 calls in a tight loop - Andrea's patch
adds several additional branches, in real-world there would be an even
larger slowdown.

If there are real performance problems with the slab, then the not-yet
optimized parts should get changed:

* kmalloc(): the loop to find the correct slab is too slow. (the numbers
in the table are without the loop, i.e.
kmem_cache_alloc(kmem_find_general_cache(4096, SLAB_KERNEL),
SLAB_KERNEL);

* finetune the size of the per-cpu caches
* finetune the amount of pages freed during kmem_cache_reap()
* replace the division in kmem_cache_free_one() with a multiplication.
(UP only, on SMP outside of the hot path)
* enable OPTIMIZE - could help on platforms without a fast
virt_addr->struct page lookup.

I have a patch with some optimization, but I tought that would be 2.5
stuff.

--
	Manfred


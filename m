Return-Path: <linux-kernel-owner+w=401wt.eu-S1030288AbWLTT1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWLTT1J (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWLTT1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:27:08 -0500
Received: from alnrmhc13.comcast.net ([204.127.225.93]:60003 "EHLO
	alnrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030362AbWLTT1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:27:06 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 14:27:06 EST
To: linux-kernel@vger.kernel.org
Subject: linux 2.4.32: kernel BUG in slab.c:1582
Date: Wed, 20 Dec 2006 12:21:59 -0700
From: Sebastian Kuzminsky <seb@highlab.com>
Message-Id: <E1Gx70p-0007vV-OZ@highlab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks, I've got an old PC (Pentium 133 MHz, 64 MB RAM, no swap)
running Linux 2.4.32, and lately I've been getting kernel BUGs like this:

    kernel: kernel BUG at slab.c:1582!
    kernel: invalid operand: 0000
    kernel: CPU:    0
    kernel: EIP:    0010:[kmem_cache_free+105/624]    Not tainted
    kernel: EFLAGS: 00010293
    kernel: eax: c10b7354   ebx: 00003ef0   ecx: 0002b450   edx: c100001c
    kernel: esi: 000ad140   edi: c3ef0634   ebp: 00000023   esp: c10c3f4c
    kernel: ds: 0018   es: 0018   ss: 0018
    kernel: Process kswapd (pid: 4, stackpage=c10c3000)
    kernel: Stack: c10b7354 c2c13e3c c3ef0634 c036dd3c 00000023 c01426ca c10b7354 c3ef0634
    kernel:        0000003c 000001d0 00000009 c0232f18 c01429b5 00000379 c012a7b8 00000006
    kernel:        000001d0 00000000 00000000 c0232f18 00000001 c10c2000 00000000 c012a947
    kernel: Call Trace:    [prune_dcache+266/320] [shrink_dcache_memory+37/64] [try_to_free_pages_zone+104/208] [kswapd_balance_pgdat+87/160] [kswapd_balance+22/48]
    kernel:   [kswapd+143/176] [_stext+0/48] [arch_kernel_thread+35/48] [kswapd+0/176]
    kernel:
    kernel: Code: 0f 0b 2e 06 7a c0 20 c0 9c 8f 04 24 fa 3b 1d 20 82 28 c0 89


The system is a bit tight on memory, but /proc/meminfo reports MemFree +
Buffers + Cached > 10 MB.

After kswapd stepped on the BUG, it happened several more times by
different processes and different code paths, but always ending with this:

    Call Trace:    [prune_dcache+266/320] [shrink_dcache_memory+37/64] [try_to_free_pages_zone+104/208] [balance_classzone+76/560] [__alloc_pages+363/624]


The BUG is this one:

    /**
     * kmem_cache_free - Deallocate an object
     * @cachep: The cache the allocation was from.
     * @objp: The previously allocated object.
     *
     * Free an object which was previously allocated from this
     * cache.
     */
    void kmem_cache_free (kmem_cache_t *cachep, void *objp)
    {
            unsigned long flags;
    #if DEBUG
            CHECK_PAGE(virt_to_page(objp));
            if (cachep != GET_PAGE_CACHE(virt_to_page(objp)))
                    BUG();
    #endif

            local_irq_save(flags);
            __kmem_cache_free(cachep, objp);
            local_irq_restore(flags);
    }


So prune_dcache() gets called to free up some memory, but then it hands
kmem_cache_free an inconsistent object to free?  Is this indicative of
memory corruption?


-- 
Sebastian Kuzminsky         There are two kinds of people in this world:
                            Those who finish what they begin.

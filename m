Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132005AbRARVcF>; Thu, 18 Jan 2001 16:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135983AbRARVbz>; Thu, 18 Jan 2001 16:31:55 -0500
Received: from sisley.ri.silicomp.fr ([62.160.165.44]:37386 "EHLO
	sisley.ri.silicomp.fr") by vger.kernel.org with ESMTP
	id <S132005AbRARVbk>; Thu, 18 Jan 2001 16:31:40 -0500
Date: Thu, 18 Jan 2001 22:31:16 +0100 (CET)
From: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
To: <mingo@redhat.com>, <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
cc: Eric Paire <paire@ri.silicomp.fr>
Subject: Re: [BUG] Panic in smp_call_function_interrupt
In-Reply-To: <Pine.LNX.4.31.0101161858340.23569-100000@sisley.ri.silicomp.fr>
Message-ID: <Pine.LNX.4.31.0101181754390.27084-100000@sisley.ri.silicomp.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, I wrote:

> [root@picasso /]# dd if=/dev/sda of=/dev/null

[ causes an oops on our SMP machines ]

> This is a 2.4.0 (release) with kdb 1.7 for 2.4.0. I tried the same on a
> similar machine with 2 CPUs and without kdb, it gave the same result. A
> 2.4.0 without SMP support on these machines has no problem.

I have applied the 2.4.1 pre8 patch, and the oops is still here.

> Can anyone reproduce this ? Or maybe it has already been fixed ?

I have made more tests, and I have also observed (twice) a deadlock
instead of the usual oops. From what I saw, the usual scenario is that the
dd (actually a read of /dev/sda is enough) makes the buffer cache grow
larger and larger, until the system tries to free pages, and that's when
things seem to go wrong. Whether I get a deadlock or an oops, kdb shows me
one processor with a call stack like this :

[1]kdb> bt
    EBP       EIP         Function(args)
0xc1157eac 0xc0110cc3 smp_call_function+0x9f (0xc012a7ac, 0xc1157ef8, 0x1,
0x1, 0xc1157ef8)
0xc1157ed0 0xc012a77f smp_call_function_all_cpus+0x1b (0xc012a7ac,
0xc1157ef8, 0xc111f400)
0xc1157f7c 0xc012a846 drain_cpu_caches+0x52 (0xc111f400)
0xc1157f8c 0xc012a8cd __kmem_cache_shrink+0xd (0xc111f400)
0xc1157f9c 0xc012a97c kmem_cache_shrink+0x54 (0xc111f400, 0x0)
0xc1157fac 0xc0148bc5 shrink_icache_memory+0x2d (0x6, 0x4, 0x6, 0x4)
0xc1157fd0 0xc012d6ba do_try_to_free_pages+0x6a (0x4, 0x0, 0xc1171fa0,
0xc0105000)
0xc1157fec 0xc012d742 kswapd+0x6e

When an oops occurs, it is on another CPU, in smp_call_function_interrupt:
this functions tries to jump to a NULL address. But if I look at the
call_data struct, it seems ok (ie, ptr to func is not NULL).

When it is a deadlock, all CPUs other than the one with the stack above
are in default_idle, and the CPU in smp_call_function() loops forever in:

	while (atomic_read(&data.started) != cpus)
		barrier();

So I guess that there is some sort of race condition, but I don't know
where. Any idea ?


Regards,

-- 
Jean-Marc Saffroy - Research Engineer - Silicomp Research Institute
mailto:saffroy@ri.silicomp.fr

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268117AbUJMAgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268117AbUJMAgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 20:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUJMAgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 20:36:43 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:59274 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268088AbUJMAg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 20:36:29 -0400
Date: Tue, 12 Oct 2004 17:21:41 -0700 (PDT)
From: <akepner@sgi.com>
X-X-Sender: <akepner@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
cc: <akpm@osdl.org>, <jbarnes@sgi.com>
Subject: bug in 2.6.9-rc4-mm1 ia64/mm/init.c 
Message-ID: <Pine.LNX.4.33.0410121705510.31839-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks; 

Tried a kernel built with akpm's 2.6.9-rc4-mm1 patch today (using 
a default sn2 .config file.) It crashes on boot with:

....
SGI SAL version 3.40
Virtual mem_map starts at 0xa0007ffe85938000
Unable to handle kernel paging request at virtual address a0007ffeaf970000
swapper[0]: Oops 8813272891392 [1]
Modules linked in:

Pid: 0, CPU 0, comm:              swapper
psr : 00001010084a2010 ifs : 8000000000000004 ip  : [<a0000001008236c0>]    
Not tainted
ip is at memmap_init_zone+0x80/0x140
unat: 0000000000000000 pfs : 000000000000030a rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 80000000ff5655a5
ldrs: 0000000000000000 ccv : 000000000000001f fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a00000010005d920 b6  : a00000010005d740 b7  : a0000001004b2640
f6  : 1003e000000000001e000 f7  : 1003e6db6db6db6db6db7
f8  : 1003e0000000005407000 f9  : 1003e0000000000000000
f10 : 1003e0000000000000000 f11 : 1003e2492492492492493
r1  : a000000100c53830 r2  : 00000000000f0000 r3  : a000000100a69880
r8  : a000000100a69880 r9  : 0000000006008000 r10 : 0000000000000000
r11 : 0000000000000000 r12 : a000000100863d80 r13 : a00000010085c000
r14 : a0007ffe85938000 r15 : a0007ffeb0000000 r16 : 00000000000d2000
r17 : a0007ffeaf970000 r18 : 0000000000000800 r19 : a0007ffeb0000000
r20 : ffffffffffffffff r21 : 000fffffffffffff r22 : 0000000000000000
r23 : 0000000000000000 r24 : a0007ffeb0000000 r25 : 0000000000000000
r26 : a0007ffeb0003fff r27 : ffffffffffffc000 r28 : a0007ffeb0000000
r29 : a0007ffeaf938000 r30 : 0000000005407000 r31 : 00000000054d9000
POD entered via OS requested halt, using Cac mode
0 000: POD SysCt Cac> POD entered via INIT, using Cac mode

I traced this down to a recent patch (see 
http://marc.theaimsgroup.com/?l=linux-mm&m=109723728329408&w=2) 
which contains:

diff -puN arch/ia64/mm/init.c~ia64_fix arch/ia64/mm/init.c
--- test-kernel/arch/ia64/mm/init.c~ia64_fix    2004-10-08 
18:29:20.510992392 +0900
+++ test-kernel-kamezawa/arch/ia64/mm/init.c    2004-10-08 
18:29:20.515991632 +0900
@@ -410,7 +410,8 @@ virtual_memmap_init (u64 start, u64 end,
        struct page *map_start, *map_end;

        args = (struct memmap_init_callback_data *) arg;
-
+       start = GRANULEROUNDDOWN(start);
+       end = GRANULEROUNDUP(end);
        map_start = vmem_map + (__pa(start) >> PAGE_SHIFT);
        map_end   = vmem_map + (__pa(end) >> PAGE_SHIFT);


Merely commenting out the new lines containting GRANULEROUNDDOWN, and 
GRANULEROUNDUP allowed the system to boot and me to finish the testing 
I needed to do. 

Looks like the above patch needs to be revised. I could test it if 
necessary. Please email me directly as I'm not subscribed to lkml 
or linux-ia64.

--

Arthur


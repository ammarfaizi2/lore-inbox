Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267867AbUHES2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267867AbUHES2W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267876AbUHES1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:27:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15075 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267867AbUHESGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:06:10 -0400
Date: Thu, 5 Aug 2004 20:06:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Gene Heskett <gene.heskett@verizon.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
Message-ID: <20040805180634.GA26732@elte.hu>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408042216.12215.gene.heskett@verizon.net> <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org> <200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Linus Torvalds <torvalds@osdl.org> wrote:

> Anyway, one other thing that makes me worry is the fact that Gene
> apparently has a K7. One of the things AMD has gotten wrong several
> times is prefetching, and it so happens that the dcache code is one of
> the users of the prefetch instruction. prude_dcache() in particular.

hm, i too happen to have an Athlon64 box (running the x86 kernel) where
i can reproduce dcache pruning crashes after a few hours of testing
using a near-vanilla kernel. The crash is triggered by two infinite
loops of:

        while true; do du /; done
        while true;
            dd if=/dev/zero of=/tmp/bigfile bs=1000000 count=500
            sync
            sleep 30
        done

using FC2, stock normal ext3, 1GB of RAM, single-disk IDE and nothing
else.

NOTE: i discovered these crashes while working on the voluntary-preempt
stuff, so it's not a pristine kernel.

But i reproduced it using 2.6.8-rc2 plus voluntary-preempt=1 (i.e. no
softirq or hardirq redirection to process context) - so it does nothing
that CONFIG_PREEMPT wouldnt do. (i had CONFIG_PREEMPT on but
kernel_preemption=0.) I've attached 3 oopses.

this patch does introduce a conditional reschedule in prune_icache:

--- linux/fs/inode.c.orig	
+++ linux/fs/inode.c	
@@ -428,6 +429,8 @@ static void prune_icache(int nr_to_scan)
 	for (nr_scanned = 0; nr_scanned < nr_to_scan; nr_scanned++) {
 		struct inode *inode;
 
+		voluntary_resched_lock(&inode_lock);
+
 		if (list_empty(&inode_unused))
 			break;

but it should be perfectly fine to do that there.

NOTE2: i tried hard but couldnt reproduce the problem using the very
same kernel and the same workload on a PIII box. Once i ran it overnight
to check. Only the Athlon64 box does it. It could also be a hardware
problem - albeit the box withstood days of memtest86.

NOTE3: there's no history of instability on this box otherwise, but i
only started doing this test 1-2 weeks ago.

	Ingo

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=11

Unable to handle kernel paging request at virtual address ffffffd8
 printing eip:
c016a3d0
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c016a3d0>]    Not tainted VLI
EFLAGS: 00010217   (2.6.8-rc2-mm2) 
EIP is at remove_inode_buffers+0x60/0xe0
eax: 00000000   ebx: c03ba9dc   ecx: 00000000   edx: c03ba8d0
esi: c03ba8d0   edi: c0379b2a   ebp: c4115ec4   esp: c4115eac
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 39, threadinfo=c4114000 task=c40aa070)
Stack: c03ba8d0 c0379b76 00000001 c03ba8d8 c03ba8d0 00000000 c4115ef8 c0186c4c 
       c03ba8d0 00000077 c4114000 00000000 0000004d 00000000 c4115ee4 c4115ee4 
       c4114000 c07fd6a0 00004e09 c4115f04 c0186df5 00000080 c4115f38 c014f4b3 
Call Trace:
 [<c01059ff>] show_stack+0x8f/0xb0
 [<c0105bb3>] show_registers+0x163/0x1d0
 [<c0105dc6>] die+0xe6/0x1c0
 [<c0117773>] do_page_fault+0x213/0x6c0
 [<c0105674>] exception_start+0x6/0xe
 [<c0186c4c>] prune_icache+0x20c/0x390
 [<c0186df5>] shrink_icache_memory+0x25/0x50
 [<c014f4b3>] shrink_slab+0x123/0x1d0
 [<c01511ee>] balance_pgdat+0x24e/0x2a0
 [<c015130c>] kswapd+0xcc/0xe0
 [<c0102899>] kernel_thread_helper+0x5/0xc
Code: 00 e0 ff ff 21 e0 ff 40 14 8d 47 4c 89 45 ec 31 c0 86 47 4c 84 c0 0f 8e 79 00 00 00 8b 86 0c 01 00 00 39 d8 74 23 89 c1 8d 76 00 <8b> 41 d8 a8 02 75 5a 8b 01 8b 51 04 89 02 89 09 89 50 04 8b 03 
 <6>note: kswapd0[39] exited with preempt_count 1

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=12

Unable to handle kernel NULL pointer dereference at virtual address 00000104
 printing eip:
c014c0d1
*pde = 36c9c001
*pte = 00000000
Oops: 0002 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c014c0d1>]    Not tainted
EFLAGS: 00010016   (2.6.8-rc2) 
EIP is at free_block+0x51/0xe0
eax: 00000100   ebx: e7d580c8   ecx: e7d58100   edx: e7d58100
esi: c40e5040   edi: 00000014   ebp: c413be38   esp: c413be1c
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 39, threadinfo=c413a000 task=c40a8070)
Stack: c40e5040 eb864100 c40e5068 c40e5078 c4160050 00000282 e61addc0 c413be64 
       c014c1d0 c40e5040 c4160050 0000001b c4160050 c40e50a0 0000001b c4160040 
       00000282 e61addc0 c413be80 c014c792 c40e5040 c4160040 e61ade5c c413bee4 
Call Trace:
 [<c0105a0f>] show_stack+0x8f/0xb0
 [<c0105bc3>] show_registers+0x163/0x1c0
 [<c0105d97>] die+0xb7/0x180
 [<c0116fb3>] do_page_fault+0x213/0x6c9
 [<c0105684>] exception_start+0x6/0xe
 [<c014c1d0>] cache_flusharray+0x70/0x140
 [<c014c792>] kmem_cache_free+0x52/0x60
 [<c01b8094>] ext3_destroy_inode+0x24/0x30
 [<c018713b>] destroy_inode+0x3b/0x60
 [<c0187479>] dispose_list+0x59/0x110
 [<c0187927>] prune_icache+0x127/0x3a0
 [<c0187be8>] shrink_icache_memory+0x48/0x50
 [<c014f4ec>] shrink_slab+0x15c/0x1d0
 [<c0151237>] balance_pgdat+0x217/0x270
 [<c015135c>] kswapd+0xcc/0xe0
 [<c0102859>] kernel_thread_helper+0x5/0xc
Code: 89 50 04 89 02 8b 43 0c 31 d2 c7 03 00 01 10 00 c7 43 04 00 
 <6>note: kswapd0[39] exited with preempt_count 1

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=13

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c019a4e1
*pde = 0ddbe001
*pte = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in:
CPU:    0
EIP:    0060:[<c019a4e1>]    Not tainted
EFLAGS: 00010202   (2.6.8-rc2) 
EIP is at prune_icache+0x431/0x600
eax: 00000008   ebx: c0538b3c   ecx: c0538b44   edx: f1b3d17c
esi: 00000029   edi: c03f0790   ebp: f7ee9f04   esp: f7ee9ec8
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 38, threadinfo=f7ee8000 task=f7eb0670)
Stack: c0538b3c 00000077 f7ee9f10 c01b63a1 c17590a0 c17590c0 c17590e0 f7ee8000 
       00000000 00000029 c0538dc4 c07d6884 00000080 00000000 f7ee8000 f7ee9f10 
       c019a6f8 00000080 f7ee9f44 c015450c 00000080 000000d0 00017a89 9384c800 
Call Trace:
 [<c0105d6f>] show_stack+0x7f/0xa0
 [<c0105f1e>] show_registers+0x15e/0x1c0
 [<c0106127>] die+0xe7/0x240
 [<c0116113>] do_page_fault+0x213/0x6c8
 [<c0105a01>] error_code+0x2d/0x38
 [<c019a6f8>] shrink_icache_memory+0x48/0x50
 [<c015450c>] shrink_slab+0x15c/0x1a0
 [<c015657e>] balance_pgdat+0x1ce/0x210
 [<c015667f>] kswapd+0xbf/0xd0
 [<c0102795>] kernel_thread_helper+0x5/0x10
Code: 89 50 04 c7 03 00 00 00 00 c7 43 04 00 00 00 00 8d 53 08 8b 
 <6>note: kswapd0[38] exited with preempt_count 1

--huq684BweRXVnRxX--

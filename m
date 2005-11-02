Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbVKBOAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVKBOAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbVKBOAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:00:19 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:17605 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965047AbVKBOAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:00:18 -0500
Date: Wed, 2 Nov 2005 15:00:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       netfilter-devel@lists.netfilter.org
Subject: Re: [2.6.14-rt1] slowdown / oops.
Message-ID: <20051102140025.GA17385@elte.hu>
References: <200511021420.28104.pluto@agmk.net> <20051102134723.GB13468@elte.hu> <20051102135516.GA16175@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102135516.GA16175@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> ah, managed to reproduce a crash in the NAT code with your .config 
> (see below). This indeed seems to be some sort of use-after-free bug: 
> 0x6b6b6b6b6b is SLAB_DEBUG's POISON_FREE - use-after-free poison byte.  
> This bug is either caused by and unique to -rt, or possibly present 
> upstream too.

with DEBUG_PAGEALLOC the crash happens almost instantly - it possibly 
catches the bad area very quickly. But there doesnt seem to be any trace 
in the stackdump about what method created the corrupt data-structure, 
what we see is a plain RX interrupt trying to look up existing 
connections and crashing on it.

	Ingo

XT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
*****************************************************************************
*                                                                           *
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_RT_DEADLOCK_DETECT                                          *
*        CONFIG_DEBUG_PREEMPT                                               *
*        CONFIG_DEBUG_SLAB                                                  *
*        CONFIG_DEBUG_PAGEALLOC                                             *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************
Freeing unused kernel memory: 200k freed
BUG: Unable to handle kernel paging request at virtual address f1267fe0
 printing eip:
c03a87a4
*pde = 005cc067
*pte = 31267000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c03a87a4>]    Not tainted VLI
EFLAGS: 00010282   (2.6.14-rt4) 
EIP is at __ip_conntrack_find+0x24/0x110
eax: 00001324   ebx: f1267fe0   ecx: fb5c8c00   edx: f6f59920
esi: f7c55e28   edi: 00009920   ebp: f7c55df4   esp: f7c55de4
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process softirq-net-rx/ (pid: 5, threadinfo=f7c54000 task=f7c538f0 stack_left=7600 worst_left=-1)
Stack: 00000000 00000000 f7c55e28 f7c55ecc f7c55e04 c03a88b4 f131ef64 c03ab0d0 
       f7c55e48 c03a9444 f7c55e28 c0498020 f881d040 00000000 00000000 c0498020 
       f7c55ecc 0101000a c0591600 0701000a 000612c6 00000000 c04975e8 f7c55e8c 
Call Trace:
 [<c0103cd7>] show_stack+0x97/0xd0 (32)
 [<c0103ec2>] show_registers+0x192/0x250 (68)
 [<c010410b>] die+0xeb/0x1a0 (56)
 [<c03f2236>] do_page_fault+0x176/0x57c (72)
 [<c0103943>] error_code+0x4f/0x54 (76)
 [<c03a88b4>] ip_conntrack_find_get+0x24/0x60 (16)
 [<c03a9444>] ip_conntrack_in+0xc4/0x370 (68)
 [<c03c4939>] nf_iterate+0x59/0x90 (36)
 [<c03c49c2>] nf_hook_slow+0x52/0x100 (48)
 [<c03741a2>] ip_rcv+0x182/0x4f0 (64)
 [<c035f95d>] netif_receive_skb+0x15d/0x1e0 (52)
 [<c02f2d97>] rtl8139_rx+0x1b7/0x340 (80)
 [<c02f3108>] rtl8139_poll+0x58/0x110 (40)
 [<c035fb32>] net_rx_action+0x72/0x140 (24)
 [<c011ee09>] ksoftirqd+0xb9/0x140 (40)
 [<c012d7d4>] kthread+0x94/0xa0 (28)
 [<c01010e9>] kernel_thread_helper+0x5/0xc (138059804)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013af6f>] .... add_preempt_count+0xf/0x20
.....[<c0104058>] ..   ( <= die+0x38/0x1a0)

------------------------------
| showing all locks held by: |  (softirq-net-rx//5 [f7c538f0,  98]):
------------------------------

#001:             [f7b50be4] {&tp->rx_lock}
... acquired at:               rtl8139_poll+0x39/0x110

#002:             [c0497bc0] {ip_conntrack_lock}
... acquired at:               ip_conntrack_find_get+0x1b/0x60

Code: 8d b4 26 00 00 00 00 55 89 e5 57 56 89 c6 53 83 ec 04 89 55 f0 e8 1d fa ff ff 8d 3c c5 00 00 00 00 89 fa 03 15 80 2a 59 c0 8b 1a <8b> 03 0f 18 00 90 39 da 75 47 e9 c4 00 00 00 b8 01 00 00 00 e8 

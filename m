Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVKBNzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVKBNzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVKBNy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:54:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:11664 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965045AbVKBNy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:54:59 -0500
Date: Wed, 2 Nov 2005 14:55:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       netfilter-devel@lists.netfilter.org
Subject: Re: [2.6.14-rt1] slowdown / oops.
Message-ID: <20051102135516.GA16175@elte.hu>
References: <200511021420.28104.pluto@agmk.net> <20051102134723.GB13468@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051102134723.GB13468@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,NORMAL_HTTP_TO_IP autolearn=disabled SpamAssassin version=3.0.4
	0.1 NORMAL_HTTP_TO_IP      URI: Uses a dotted-decimal IP address in URL
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Paweł Sikora <pluto@agmk.net> wrote:
> 
> > 2).
> > During `scp bigfile to another machine` I get an oops:
> > http://149.156.124.14/~pluto/tmp/2.6.14-rt2-oops.jpg [796 kB]
> 
> is routing to that other box covered by any of the iptables NAT rules?  
> Does the crash happen if you turn off all firewalling via "iptables 
> -F"?

ah, managed to reproduce a crash in the NAT code with your .config (see 
below). This indeed seems to be some sort of use-after-free bug: 
0x6b6b6b6b6b is SLAB_DEBUG's POISON_FREE - use-after-free poison byte.  
This bug is either caused by and unique to -rt, or possibly present 
upstream too.

	Ingo

BUG: Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c03a859f
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in:
CPU:    0
EIP:    0060:[<c03a859f>]    Not tainted VLI
EFLAGS: 00010246   (2.6.14-rt4) 
EIP is at __ip_conntrack_find+0x5f/0x110
eax: 00000000   ebx: 6b6b6b6b   ecx: c013ae7f   edx: 00000001
esi: c23d7e28   edi: 000018e0   ebp: c23d7df4   esp: c23d7de4
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process softirq-net-rx/ (pid: 5, threadinfo=c23d6000 task=c23d47b0 stack_left=7600 worst_left=-1)
Stack: 00000000 00000000 c23d7e28 c23d7ecc c23d7e04 c03a8674 f490a57c c03aae90 
       c23d7e48 c03a9204 c23d7e28 c0498020 f881d040 00000000 00000000 c0498020 
       c23d7ecc 0101000a c0591600 0701000a 0006c9c2 00000000 c04975e8 c23d7e8c 
Call Trace:
 [<c0103cc7>] show_stack+0x97/0xd0 (32)
 [<c0103eb2>] show_registers+0x192/0x250 (68)
 [<c01040ef>] die+0xdf/0x190 (56)
 [<c03f1ff6>] do_page_fault+0x176/0x57c (72)
 [<c0103933>] error_code+0x4f/0x54 (76)
 [<c03a8674>] ip_conntrack_find_get+0x24/0x60 (16)
 [<c03a9204>] ip_conntrack_in+0xc4/0x370 (68)
 [<c03c46f9>] nf_iterate+0x59/0x90 (36)
 [<c03c4782>] nf_hook_slow+0x52/0x100 (48)
 [<c0373f62>] ip_rcv+0x182/0x4f0 (64)
 [<c035f71d>] netif_receive_skb+0x15d/0x1e0 (52)
 [<c02f2b57>] rtl8139_rx+0x1b7/0x340 (80)
 [<c02f2ec8>] rtl8139_poll+0x58/0x110 (40)
 [<c035f8f2>] net_rx_action+0x72/0x140 (24)
 [<c011ed19>] ksoftirqd+0xb9/0x140 (40)
 [<c012d6e4>] kthread+0x94/0xa0 (28)
 [<c01010d9>] kernel_thread_helper+0x5/0xc (1036156956)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013ae7f>] .... add_preempt_count+0xf/0x20
.....[<c0104048>] ..   ( <= die+0x38/0x190)

------------------------------
| showing all locks held by: |  (softirq-net-rx//5 [c23d47b0,  98]):
------------------------------

#001:             [f7e2c664] {&tp->rx_lock}
... acquired at:               rtl8139_poll+0x39/0x110

#002:             [c0497bc0] {ip_conntrack_lock}
... acquired at:               ip_conntrack_find_get+0x1b/0x60

Code: 01 00 00 00 e8 f3 28 d9 ff ff 05 a0 2a 59 c0 b8 01 00 00 00 e8 83 29 d9 ff a1 08 42 3f c0 8b 40 08 a8 08 0f 85 a6 00 00 00 8b 1b <8b> 03 0f 18 00 90 89 f8 03 05 80 2a 59 c0 39 c3 0f 84 82 00 00 

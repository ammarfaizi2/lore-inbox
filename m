Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbUKKTJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbUKKTJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 14:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbUKKTJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 14:09:29 -0500
Received: from linuxfools.org ([216.107.2.99]:32384 "EHLO loki.linuxfools.org")
	by vger.kernel.org with ESMTP id S262298AbUKKTIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 14:08:38 -0500
Date: Thu, 11 Nov 2004 13:31:11 -0500
From: jhigdon@linuxfools.org
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Stefan Schmidt <zaphodb@zaphods.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.10-rc1-mm4 -1 EAGAIN after allocation failure was: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041111183111.GA23564@linuxfools.org>
References: <20041109235201.GC20754@zaphods.net> <20041110012733.GD20754@zaphods.net> <20041109173920.08746dbd.akpm@osdl.org> <20041110020327.GE20754@zaphods.net> <419197EA.9090809@cyberone.com.au> <20041110102854.GI20754@zaphods.net> <20041110120624.GF28163@zaphods.net> <20041110085831.GB10740@logos.cnet> <20041110124810.GG28163@zaphods.net> <4192BF01.1090509@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4192BF01.1090509@cyberone.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 12:23:13PM +1100, Nick Piggin wrote:
> 
> 
> Stefan Schmidt wrote:
> 
> >On Wed, Nov 10, 2004 at 06:58:31AM -0200, Marcelo Tosatti wrote:
> >
> >>>>>Can you try the following patch, please? It is diffed against 
> >>>>>2.6.10-rc1,
> >>>>>
> >>>I did. No apparent change with mm4 and vm.min_free_kbytes = 8192. I will 
> >>>try
> >>>latest bk next.
> >>>
> >
> >>>>I set it back to CONFIG_PACKET_MMAP=y and if the application does not 
> >>>>freeze
> >>>>for some hours at this load we can blame at least this issue (-1 
> >>>>EAGAIN) on
> >>>>that parameter.
> >>>>
> >>>Nope, that didn't change anything, still getting EAGAIN, checked two 
> >>>times.
> >>>
> >>Its not clear to me - do you have Nick's watermark patch in? 
> >>
> >Yes i have vm.min_free_kbytes=8192 and Nick's patch in mm4. I'll try
> >rc1-bk19 with his restore-atomic-buffer patch in a few minutes.
> >
> >
> 
> You'll actually want to increase min_free_kbytes in order to have the same
> amount of memory free as 2.6.8 did.
> 
> Start by applying my patch and using the default min_free_kbytes. Then 
> increase
> it until the page allocation failures stop, and let us know what the end 
> result
> was.
> 
> BTW we should probably have a message in the page allocation failure path
> to tell people to try increasing /proc/sys/vm/min_free_kbytes...
> 

We are having a similar problem (at least i think).
although I have up'd the min_free_kbytes to what was suggested in this
post and havent seen these messages _yet_. 


Nov  7 13:02:23 aragorn kernel: swapper: page allocation failure.
order:1, mode:0x20
Nov  7 13:02:23 aragorn kernel: [<c01356f2>] __alloc_pages+0x1b3/0x358
Nov  7 13:02:23 aragorn kernel: [<c01358bc>] __get_free_pages+0x25/0x3f
Nov  7 13:02:23 aragorn kernel: [<c01389b0>] kmem_getpages+0x21/0xc9
Nov  7 13:02:23 aragorn kernel: [<c013968f>] cache_grow+0xab/0x14d
Nov  7 13:02:23 aragorn kernel: [<c01398a5>]
cache_alloc_refill+0x174/0x219
Nov  7 13:02:23 aragorn kernel: [<c0139b17>] kmem_cache_alloc+0x4b/0x4d
Nov  7 13:02:23 aragorn kernel: [<c0238118>] sk_alloc+0x34/0xa7
Nov  7 13:02:23 aragorn kernel: [<c026d485>]
tcp_create_openreq_child+0x34/0x558
Nov  7 13:02:23 aragorn kernel: [<c0269d81>]
tcp_v4_syn_recv_sock+0x47/0x2ea
Nov  7 13:02:23 aragorn kernel: [<c026db74>] tcp_check_req+0x1cb/0x4df
Nov  7 13:02:23 aragorn kernel: [<f88b64f0>] tg3_start_xmit+0x3f4/0x4f5
[tg3]
Nov  7 13:02:23 aragorn kernel: [<f88b64f0>] tg3_start_xmit+0x3f4/0x4f5
[tg3]
Nov  7 13:02:23 aragorn kernel: [<c023ec88>] dev_queue_xmit+0x120/0x284
Nov  7 13:02:23 aragorn kernel: [<c0248a0e>] qdisc_restart+0x17/0x1d9
Nov  7 13:02:23 aragorn kernel: [<c023ec88>] dev_queue_xmit+0x120/0x284
Nov  7 13:02:23 aragorn kernel: [<c0252a95>] ip_finish_output+0xbb/0x1b9
Nov  7 13:02:23 aragorn kernel: [<c025310d>] ip_queue_xmit+0x3f1/0x500
Nov  7 13:02:23 aragorn kernel: [<c01122a9>] try_to_wake_up+0x1de/0x26c
Nov  7 13:02:23 aragorn kernel: [<c0111c5c>] recalc_task_prio+0x93/0x188
Nov  7 13:02:23 aragorn kernel: [<c0111de1>] activate_task+0x90/0xa4
Nov  7 13:02:23 aragorn kernel: [<c01122a9>] try_to_wake_up+0x1de/0x26c
Nov  7 13:02:23 aragorn kernel: [<c0113c3d>] __wake_up_common+0x3f/0x5e
Nov  7 13:02:23 aragorn kernel: [<c0113c9c>] __wake_up+0x40/0x56
Nov  7 13:02:23 aragorn kernel: [<c026a08a>] tcp_v4_hnd_req+0x66/0x20a
Nov  7 13:02:23 aragorn kernel: [<c026dedb>] tcp_child_process+0x53/0xc4
Nov  7 13:02:23 aragorn kernel: [<c026a45e>] tcp_v4_do_rcv+0xd7/0x12d
Nov  7 13:02:23 aragorn kernel: [<c026ab8c>] tcp_v4_rcv+0x6d8/0x90f
Nov  7 13:02:23 aragorn kernel: [<c0111c5c>] recalc_task_prio+0x93/0x188
Nov  7 13:02:23 aragorn kernel: [<c024fd92>] ip_local_deliver+0xb5/0x201
Nov  7 13:02:23 aragorn kernel: [<c025021a>] ip_rcv+0x33c/0x47e
Nov  7 13:02:23 aragorn kernel: [<c0112fe8>]
find_busiest_group+0xe4/0x316
Nov  7 13:02:23 aragorn kernel: [<c023f2db>]
netif_receive_skb+0x1ac/0x242
Nov  7 13:02:23 aragorn kernel: [<c0239309>] alloc_skb+0x47/0xe0
Nov  7 13:02:23 aragorn kernel: [<f88b5a66>] tg3_rx+0x2a7/0x3fa [tg3]
Nov  7 13:02:23 aragorn kernel: [<f88b5c46>] tg3_poll+0x8d/0x130 [tg3]
Nov  7 13:02:23 aragorn kernel: [<c023f4f3>] net_rx_action+0x77/0xf6
Nov  7 13:02:23 aragorn kernel: [<c011b9cf>] __do_softirq+0xb7/0xc6
Nov  7 13:02:23 aragorn kernel: [<c011ba0b>] do_softirq+0x2d/0x2f
Nov  7 13:02:23 aragorn kernel: [<c0106adf>] do_IRQ+0x112/0x130
Nov  7 13:02:23 aragorn kernel: [<c010494c>] common_interrupt+0x18/0x20
Nov  7 13:02:23 aragorn kernel: [<c0101f1e>] default_idle+0x0/0x2c
Nov  7 13:02:23 aragorn kernel: [<c0101f47>] default_idle+0x29/0x2c
Nov  7 13:02:23 aragorn kernel: [<c0101fbc>] cpu_idle+0x3f/0x58
Nov  7 13:02:23 aragorn kernel: [<c031e9d5>] start_kernel+0x16e/0x189
Nov  7 13:02:23 aragorn kernel: [<c031e49f>]
unknown_bootoption+0x0/0x15c


Nov  7 13:02:23 aragorn kernel: swapper: page allocation failure.
order:1, mode:0x20
Nov  7 13:02:23 aragorn kernel: [<c01356f2>] __alloc_pages+0x1b3/0x358
Nov  7 13:02:23 aragorn kernel: [<c01358bc>] __get_free_pages+0x25/0x3f
Nov  7 13:02:23 aragorn kernel: [<c01389b0>] kmem_getpages+0x21/0xc9
Nov  7 13:02:23 aragorn syslog-ng[1574]: Error accepting AF_UNIX
connection, opened connections: 100, max: 100
Nov  7 13:02:23 aragorn kernel: [<c013968f>] cache_grow+0xab/0x14d
Nov  7 13:02:23 aragorn kernel: [<c01398a5>]
cache_alloc_refill+0x174/0x219
Nov  7 13:02:23 aragorn kernel: [<c0139b17>] kmem_cache_alloc+0x4b/0x4d
Nov  7 13:02:23 aragorn kernel: [<c0238118>] sk_alloc+0x34/0xa7
Nov  7 13:02:23 aragorn kernel: [<c026d485>]
tcp_create_openreq_child+0x34/0x558
Nov  7 13:02:23 aragorn kernel: [<c0269d81>]
tcp_v4_syn_recv_sock+0x47/0x2ea
Nov  7 13:02:23 aragorn kernel: [<c026db74>] tcp_check_req+0x1cb/0x4df
Nov  7 13:02:23 aragorn kernel: [<f88b64f0>] tg3_start_xmit+0x3f4/0x4f5
[tg3]
Nov  7 13:02:23 aragorn kernel: [<f88b64f0>] tg3_start_xmit+0x3f4/0x4f5
[tg3]
Nov  7 13:02:23 aragorn kernel: [<c023ec88>] dev_queue_xmit+0x120/0x284
Nov  7 13:02:23 aragorn kernel: [<c0248a0e>] qdisc_restart+0x17/0x1d9
Nov  7 13:02:23 aragorn kernel: [<c023ec88>] dev_queue_xmit+0x120/0x284
Nov  7 13:02:23 aragorn kernel: [<c0252a95>] ip_finish_output+0xbb/0x1b9
Nov  7 13:02:23 aragorn kernel: [<c0111c5c>] recalc_task_prio+0x93/0x188
Nov  7 13:02:23 aragorn kernel: [<c0111c5c>] recalc_task_prio+0x93/0x188
Nov  7 13:02:23 aragorn kernel: [<f88b64f0>] tg3_start_xmit+0x3f4/0x4f5
[tg3]
Nov  7 13:02:23 aragorn kernel: [<c027dc75>]
fib_validate_source+0x22c/0x257
Nov  7 13:02:23 aragorn kernel: [<c0248a0e>] qdisc_restart+0x17/0x1d9
Nov  7 13:02:23 aragorn kernel: [<c023ec88>] dev_queue_xmit+0x120/0x284
Nov  7 13:02:23 aragorn kernel: [<c0252a95>] ip_finish_output+0xbb/0x1b9
Nov  7 13:02:23 aragorn kernel: [<c025310d>] ip_queue_xmit+0x3f1/0x500
Nov  7 13:02:23 aragorn kernel: [<c026a08a>] tcp_v4_hnd_req+0x66/0x20a
Nov  7 13:02:23 aragorn kernel: [<c024ea28>]
ip_route_output_flow+0x2f/0x9d
Nov  7 13:02:23 aragorn kernel: [<c026a45e>] tcp_v4_do_rcv+0xd7/0x12d
Nov  7 13:02:23 aragorn kernel: [<c026ab8c>] tcp_v4_rcv+0x6d8/0x90f
Nov  7 13:02:23 aragorn kernel: [<c024fd92>] ip_local_deliver+0xb5/0x201
Nov  7 13:02:23 aragorn kernel: [<c025021a>] ip_rcv+0x33c/0x47e
Nov  7 13:02:23 aragorn kernel: [<c023f2db>]
netif_receive_skb+0x1ac/0x242
Nov  7 13:02:23 aragorn kernel: [<c0239309>] alloc_skb+0x47/0xe0
Nov  7 13:02:23 aragorn kernel: [<f88b5a66>] tg3_rx+0x2a7/0x3fa [tg3]
Nov  7 13:02:23 aragorn kernel: [<f88b5c46>] tg3_poll+0x8d/0x130 [tg3]
Nov  7 13:02:23 aragorn kernel: [<c023f4f3>] net_rx_action+0x77/0xf6
Nov  7 13:02:23 aragorn kernel: [<c011b9cf>] __do_softirq+0xb7/0xc6
Nov  7 13:02:23 aragorn kernel: [<c0106adf>] do_IRQ+0x112/0x130
Nov  7 13:02:23 aragorn kernel: [<c010494c>] common_interrupt+0x18/0x20
Nov  7 13:02:23 aragorn kernel: [<c0101f1e>] default_idle+0x0/0x2c
Nov  7 13:02:23 aragorn kernel: [<c0101f47>] default_idle+0x29/0x2c
Nov  7 13:02:23 aragorn kernel: [<c0101fbc>] cpu_idle+0x3f/0x58
Nov  7 13:02:23 aragorn kernel: [<c031e9d5>] start_kernel+0x16e/0x189
Nov  7 13:02:23 aragorn kernel: [<c031e49f>]
unknown_bootoption+0x0/0x15c

$ lspci
0000:00:00.0 Host bridge: ServerWorks CMIC-LE Host Bridge (GC-LE
chipset) (rev 33)
0000:00:00.1 Host bridge: ServerWorks CMIC-LE Host Bridge (GC-LE
chipset)
0000:00:00.2 Host bridge: ServerWorks CMIC-LE Host Bridge (GC-LE
chipset)
0000:00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)
0000:00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
0000:00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller
(rev 05)
0000:00:0f.3 ISA bridge: ServerWorks CSB5 LPC bridge
0000:00:10.0 Host bridge: ServerWorks CIOB-E I/O Bridge with Gigabit
Ethernet (rev 12)
0000:00:10.2 Host bridge: ServerWorks CIOB-E I/O Bridge with Gigabit
Ethernet (rev 12)
0000:00:11.0 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
0000:00:11.2 Host bridge: ServerWorks CIOB-X2 PCI-X I/O Bridge (rev 05)
0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 02)
0000:02:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 02)
0000:04:03.0 RAID bus controller: Dell PowerEdge Expandable RAID
controller 4/Di (rev 02)


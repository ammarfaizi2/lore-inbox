Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVBJCVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVBJCVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 21:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVBJCVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 21:21:05 -0500
Received: from unused.mind.net ([69.9.134.98]:30668 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262013AbVBJCUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 21:20:45 -0500
Date: Wed, 9 Feb 2005 18:20:31 -0800 (PST)
From: William Weston <weston@lysdexia.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <1107953301.17568.6.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.58.0502091814180.4599@echo.lysdexia.org>
References: <20050204100347.GA13186@elte.hu>  <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org>
 <1107953301.17568.6.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two more of these sel_netif_lookup related BUGs were found with
-RT-2.6.11-rc3-V0.7.38-06:

BUG: sleeping function called from invalid context ksoftirqd/0(2) at 
kernel/rt.c:1448
in_atomic():1 [00000001], irqs_disabled():0
 [<c0104183>] dump_stack+0x23/0x30 (20)
 [<c011be08>] __might_sleep+0xd8/0xf0 (36)
 [<c0139008>] __spin_lock+0x38/0x60 (24)
 [<c013904d>] _spin_lock+0x1d/0x20 (16)
 [<c015089f>] kmem_cache_alloc+0x3f/0x140 (44)
 [<c01ea1e9>] sel_netif_lookup+0x69/0x160 (40)
 [<c01ea3a8>] sel_netif_sids+0x38/0xd0 (40)
 [<c01e6c13>] selinux_socket_sock_rcv_skb+0xc3/0x2a0 (152)
 [<c032da2a>] udp_queue_rcv_skb+0xca/0x2d0 (40)
 [<c032e168>] udp_rcv+0x1c8/0x430 (96)
 [<c030ab3c>] ip_local_deliver+0x6c/0x210 (36)
 [<c030af19>] ip_rcv+0x239/0x430 (56)
 [<c02ed257>] netif_receive_skb+0x147/0x180 (48)
 [<c02ed30f>] process_backlog+0x7f/0x110 (28)
 [<c02ed41c>] net_rx_action+0x7c/0x130 (32)
 [<c0124e37>] ___do_softirq+0x57/0xf0 (40)
 [<c0124f75>] _do_softirq+0x25/0x30 (8)
 [<c0125395>] ksoftirqd+0xa5/0x100 (28)
 [<c0135676>] kthread+0xa6/0xe0 (48)
 [<c0101329>] kernel_thread_helper+0x5/0xc (537116692)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0145d5b>] .... __do_IRQ+0xfb/0x1a0
.....[<c01058df>] ..   ( <= do_IRQ+0x6f/0xb0)
.. [<c013c5eb>] .... print_traces+0x1b/0x60
.....[<c0104183>] ..   ( <= dump_stack+0x23/0x30)

BUG: sleeping function called from invalid context ksoftirqd/0(2) at 
kernel/rt.c:1448
in_atomic():1 [00000001], irqs_disabled():0
 [<c0104183>] dump_stack+0x23/0x30 (20)
 [<c011be08>] __might_sleep+0xd8/0xf0 (36)
 [<c0139008>] __spin_lock+0x38/0x60 (24)
 [<c013904d>] _spin_lock+0x1d/0x20 (16)
 [<c015089f>] kmem_cache_alloc+0x3f/0x140 (44)
 [<c01ea1e9>] sel_netif_lookup+0x69/0x160 (40)
 [<c01ea3a8>] sel_netif_sids+0x38/0xd0 (40)
 [<c01e6c13>] selinux_socket_sock_rcv_skb+0xc3/0x2a0 (152)
 [<c0326c72>] tcp_v4_rcv+0x502/0x950 (76)
 [<c030ab3c>] ip_local_deliver+0x6c/0x210 (36)
 [<c030af19>] ip_rcv+0x239/0x430 (56)
 [<c02ed257>] netif_receive_skb+0x147/0x180 (48)
 [<c02ed30f>] process_backlog+0x7f/0x110 (28)
 [<c02ed41c>] net_rx_action+0x7c/0x130 (32)
 [<c0124e37>] ___do_softirq+0x57/0xf0 (40)
 [<c0124f75>] _do_softirq+0x25/0x30 (8)
 [<c0125395>] ksoftirqd+0xa5/0x100 (28)
 [<c0135676>] kthread+0xa6/0xe0 (48)
 [<c0101329>] kernel_thread_helper+0x5/0xc (537116692)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0145d5b>] .... __do_IRQ+0xfb/0x1a0
.....[<c01058df>] ..   ( <= do_IRQ+0x6f/0xb0)
.. [<c013c5eb>] .... print_traces+0x1b/0x60
.....[<c0104183>] ..   ( <= dump_stack+0x23/0x30)


Additional info about the system/kernel/config can be found at 
http://www.sysex.net/testing/


Best Regards,
--William Weston <weston at sysex.net>


On Wed, 9 Feb 2005, Stephen Smalley wrote:

> On Tue, 2005-02-08 at 16:58, William Weston wrote:
> > Hi Ingo,
> > 
> > Great work on the -RT kernel!  Here's a status report from my Athlon box
> > w/ kernel -RT-2.6.11-rc3-V0.7.38-03, realtime-lsm-0.8.5, jack-0.99.48, 
> > alsa-1.0.8, and latencytest-0.5.5:
> <snip>
> > A couple BUGs are being logged (see below), but without any ill effect
> > other than taking up space on my /var.
> <snip>
> > Network interface (via rhine) startup triggers these two BUGs:
> > 
> > BUG: sleeping function called from invalid context ksoftirqd/0(2) at 
> > kernel/rt.c:1448
> > in_atomic():1 [00000001], irqs_disabled():0
> >  [<c0103e77>] dump_stack+0x17/0x20 (12)
> >  [<c0119f89>] __might_sleep+0xd9/0xf0 (40)
> >  [<c0134816>] __spin_lock+0x36/0x50 (24)
> >  [<c0147914>] kmem_cache_alloc+0x34/0x120 (44)
> >  [<c01d3143>] sel_netif_lookup+0x63/0x150 (28)
> >  [<c01d32cd>] sel_netif_sids+0x2d/0xb0 (28)
> >  [<c01d01bc>] selinux_socket_sock_rcv_skb+0xac/0x230 (144)
> 
> I'm not sure I understand, as sel_netif_lookup passes GFP_ATOMIC to
> kmalloc.
> 
> >  [<c02fd248>] udp_queue_rcv_skb+0xb8/0x280 (28)
> >  [<c02fd8e2>] udp_rcv+0x192/0x3e0 (100)
> >  [<c02dc224>] ip_local_deliver+0x64/0x1c0 (32)
> >  [<c02dc595>] ip_rcv+0x215/0x3f0 (56)
> >  [<c02c201c>] netif_receive_skb+0x12c/0x160 (40)
> >  [<c02c20ce>] process_backlog+0x7e/0x110 (32)
> >  [<c02c21d2>] net_rx_action+0x72/0x130 (24)
> >  [<c0122428>] ___do_softirq+0x48/0xd0 (40)
> >  [<c012254b>] _do_softirq+0x1b/0x30 (8)
> >  [<c0122920>] ksoftirqd+0xa0/0xf0 (28)
> >  [<c01312fb>] kthread+0x8b/0xc0 (36)
> >  [<c01012f5>] kernel_thread_helper+0x5/0x10 (537116692)
> > ---------------------------
> > | preempt count: 00000002 ]
> > | 2-level deep critical section nesting:
> > ----------------------------------------
> > .. [<c013dd3f>] .... __do_IRQ+0xef/0x180
> > .....[<c0105306>] ..   ( <= do_IRQ+0x56/0xa0)
> > .. [<c0135240>] .... print_traces+0x10/0x40
> > .....[<c0103e77>] ..   ( <= dump_stack+0x17/0x20)
> 
> -- 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency

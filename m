Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWF3Gz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWF3Gz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 02:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWF3Gz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 02:55:26 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:29901 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932082AbWF3GzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 02:55:24 -0400
Date: Fri, 30 Jun 2006 08:50:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm3 -- BUG: illegal lock usage -- illegal {softirq-on-W} -> {in-softirq-R} usage.
Message-ID: <20060630065041.GB6572@elte.hu>
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5024]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Miles Lane <miles.lane@gmail.com> wrote:

> [ BUG: illegal lock usage! ]
> ----------------------------
> illegal {softirq-on-W} -> {in-softirq-R} usage.
> java_vm/4418 [HC0[0]:SC1[1]:HE1:SE0] takes:
> (&sk->sk_dst_lock){---?}, at: [<c119d0a9>] sk_dst_check+0x1b/0xe6
> {softirq-on-W} state was registered at:
>  [<c102d1c8>] lock_acquire+0x60/0x80
>  [<c12012d7>] _write_lock+0x23/0x32
>  [<c11ddbe7>] inet_bind+0x16c/0x1cc
>  [<c119ae58>] sys_bind+0x61/0x80
>  [<c119b465>] sys_socketcall+0x7d/0x186
>  [<c1002d6d>] sysenter_past_esp+0x56/0x8d
> irq event stamp: 11052
> hardirqs last  enabled at (11052): [<c105d454>] kmem_cache_alloc+0x89/0xa6
> hardirqs last disabled at (11051): [<c105d405>] kmem_cache_alloc+0x3a/0xa6
> softirqs last  enabled at (11040): [<c11a506d>] dev_queue_xmit+0x224/0x24b
> softirqs last disabled at (11041): [<c1004a64>] do_softirq+0x58/0xbd
> 
> other info that might help us debug this:
> 1 lock held by java_vm/4418:
> #0:  (af_family_keys + (sk)->sk_family#4){-+..}, at: [<f93c9281>]
> tcp_v6_rcv+0x308/0x7b7 [ipv6]
> 
> stack backtrace:
> [<c1003502>] show_trace_log_lvl+0x54/0xfd
> [<c1003b6a>] show_trace+0xd/0x10
> [<c1003c0e>] dump_stack+0x19/0x1b
> [<c102b833>] print_usage_bug+0x1cc/0x1d9
> [<c102bd34>] mark_lock+0x193/0x360
> [<c102c94a>] __lock_acquire+0x3b7/0x970
> [<c102d1c8>] lock_acquire+0x60/0x80
> [<c12013eb>] _read_lock+0x23/0x32
> [<c119d0a9>] sk_dst_check+0x1b/0xe6
> [<f93ae479>] ip6_dst_lookup+0x31/0x172 [ipv6]
> [<f93c7065>] tcp_v6_send_synack+0x10f/0x238 [ipv6]
> [<f93c7dc5>] tcp_v6_conn_request+0x281/0x2c7 [ipv6]
> [<c11cca33>] tcp_rcv_state_process+0x5d/0xbde
> [<f93c7414>] tcp_v6_do_rcv+0x26d/0x384 [ipv6]
> [<f93c96d6>] tcp_v6_rcv+0x75d/0x7b7 [ipv6]
> [<f93afadd>] ip6_input+0x201/0x2d1 [ipv6]
> [<f93b002d>] ipv6_rcv+0x190/0x1bf [ipv6]
> [<c11a3200>] netif_receive_skb+0x2e6/0x37f
> [<c11a4b81>] process_backlog+0x80/0x112
> [<c11a4c9e>] net_rx_action+0x8b/0x1e8
> [<c101a711>] __do_softirq+0x55/0xb0
> [<c1004a64>] do_softirq+0x58/0xbd
> [<c101a978>] local_bh_enable+0xd0/0x107
> [<c11a506d>] dev_queue_xmit+0x224/0x24b
> [<c11a9bb8>] neigh_resolve_output+0x1e2/0x20e
> [<f93add64>] ip6_output2+0x1de/0x1fc [ipv6]
> [<f93ae41e>] ip6_output+0x69c/0x6c6 [ipv6]
> [<f93aeb58>] ip6_xmit+0x22b/0x295 [ipv6]
> [<f93cc893>] inet6_csk_xmit+0x200/0x20e [ipv6]
> [<c11cea04>] tcp_transmit_skb+0x5de/0x60c
> [<c11d0cd7>] tcp_connect+0x2bb/0x31a
> [<f93c894a>] tcp_v6_connect+0x520/0x655 [ipv6]
> [<c11dd889>] inet_stream_connect+0x83/0x20f
> [<c119adda>] sys_connect+0x67/0x84
> [<c119b474>] sys_socketcall+0x8c/0x186
> [<c1002d6d>] sysenter_past_esp+0x56/0x8d

hm, is this all the log output you got? In particular the printouts of 
where various lock-class state changing events happened that are 
important too. Could you send me the whole dmesg?

	Ingo

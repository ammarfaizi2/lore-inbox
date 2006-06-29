Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWF2TCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWF2TCW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWF2TCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:02:21 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:32660 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932237AbWF2TCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:02:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ehG3c2Qv9BlZlFxeYysiyCgTph3YrzhFwH7a0SGEuR8zyI2fP1TrfIispWvEVS4m+DTDuya2L0PXnswDiK+KRb0APvjF1LSQpAFJHsKOX7JOjaO6W6LJ7+Aao4a+QfKTzwM03mbotoOFlxv681OEyuj+2NQDNRPJIBADGyHgNME=
Message-ID: <a44ae5cd0606291202i7671f507pf9ba55192a4846b@mail.gmail.com>
Date: Thu, 29 Jun 2006 12:02:17 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-mm4 -- BUG: illegal lock usage -- illegal {softirq-on-W} -> {in-softirq-R} usage.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I put down the wrong kernel version string in the previous message.

On 6/29/06, Miles Lane <miles.lane@gmail.com> wrote:
> [ BUG: illegal lock usage! ]
> ----------------------------
> illegal {softirq-on-W} -> {in-softirq-R} usage.
> java_vm/4418 [HC0[0]:SC1[1]:HE1:SE0] takes:
>  (&sk->sk_dst_lock){---?}, at: [<c119d0a9>] sk_dst_check+0x1b/0xe6
> {softirq-on-W} state was registered at:
>   [<c102d1c8>] lock_acquire+0x60/0x80
>   [<c12012d7>] _write_lock+0x23/0x32
>   [<c11ddbe7>] inet_bind+0x16c/0x1cc
>   [<c119ae58>] sys_bind+0x61/0x80
>   [<c119b465>] sys_socketcall+0x7d/0x186
>   [<c1002d6d>] sysenter_past_esp+0x56/0x8d
> irq event stamp: 11052
> hardirqs last  enabled at (11052): [<c105d454>] kmem_cache_alloc+0x89/0xa6
> hardirqs last disabled at (11051): [<c105d405>] kmem_cache_alloc+0x3a/0xa6
> softirqs last  enabled at (11040): [<c11a506d>] dev_queue_xmit+0x224/0x24b
> softirqs last disabled at (11041): [<c1004a64>] do_softirq+0x58/0xbd
>
> other info that might help us debug this:
> 1 lock held by java_vm/4418:
>  #0:  (af_family_keys + (sk)->sk_family#4){-+..}, at: [<f93c9281>]
> tcp_v6_rcv+0x308/0x7b7 [ipv6]
>
> stack backtrace:
>  [<c1003502>] show_trace_log_lvl+0x54/0xfd
>  [<c1003b6a>] show_trace+0xd/0x10
>  [<c1003c0e>] dump_stack+0x19/0x1b
>  [<c102b833>] print_usage_bug+0x1cc/0x1d9
>  [<c102bd34>] mark_lock+0x193/0x360
>  [<c102c94a>] __lock_acquire+0x3b7/0x970
>  [<c102d1c8>] lock_acquire+0x60/0x80
>  [<c12013eb>] _read_lock+0x23/0x32
>  [<c119d0a9>] sk_dst_check+0x1b/0xe6
>  [<f93ae479>] ip6_dst_lookup+0x31/0x172 [ipv6]
>  [<f93c7065>] tcp_v6_send_synack+0x10f/0x238 [ipv6]
>  [<f93c7dc5>] tcp_v6_conn_request+0x281/0x2c7 [ipv6]
>  [<c11cca33>] tcp_rcv_state_process+0x5d/0xbde
>  [<f93c7414>] tcp_v6_do_rcv+0x26d/0x384 [ipv6]
>  [<f93c96d6>] tcp_v6_rcv+0x75d/0x7b7 [ipv6]
>  [<f93afadd>] ip6_input+0x201/0x2d1 [ipv6]
>  [<f93b002d>] ipv6_rcv+0x190/0x1bf [ipv6]
>  [<c11a3200>] netif_receive_skb+0x2e6/0x37f
>  [<c11a4b81>] process_backlog+0x80/0x112
>  [<c11a4c9e>] net_rx_action+0x8b/0x1e8
>  [<c101a711>] __do_softirq+0x55/0xb0
>  [<c1004a64>] do_softirq+0x58/0xbd
>  [<c101a978>] local_bh_enable+0xd0/0x107
>  [<c11a506d>] dev_queue_xmit+0x224/0x24b
>  [<c11a9bb8>] neigh_resolve_output+0x1e2/0x20e
>  [<f93add64>] ip6_output2+0x1de/0x1fc [ipv6]
>  [<f93ae41e>] ip6_output+0x69c/0x6c6 [ipv6]
>  [<f93aeb58>] ip6_xmit+0x22b/0x295 [ipv6]
>  [<f93cc893>] inet6_csk_xmit+0x200/0x20e [ipv6]
>  [<c11cea04>] tcp_transmit_skb+0x5de/0x60c
>  [<c11d0cd7>] tcp_connect+0x2bb/0x31a
>  [<f93c894a>] tcp_v6_connect+0x520/0x655 [ipv6]
>  [<c11dd889>] inet_stream_connect+0x83/0x20f
>  [<c119adda>] sys_connect+0x67/0x84
>  [<c119b474>] sys_socketcall+0x8c/0x186
>  [<c1002d6d>] sysenter_past_esp+0x56/0x8d
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWBBKzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWBBKzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWBBKzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:55:51 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:44957 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750704AbWBBKzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:55:51 -0500
Date: Thu, 2 Feb 2006 11:54:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060202105429.GA4895@elte.hu>
References: <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu> <20060131102758.GA31460@gondor.apana.org.au> <20060131.024323.83813817.davem@davemloft.net> <20060201133219.GA1435@elte.hu> <20060201202610.GA13107@gondor.apana.org.au> <20060202074627.GA6805@elte.hu> <20060202084824.GA17299@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202084824.GA17299@gondor.apana.org.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hm, i got a new one:

============================================
[ BUG: circular locking deadlock detected! ]
--------------------------------------------
sshd/28997 is trying to acquire lock:
 (&sk->sk_lock.slock){-+}, at: [<c0c6be28>] packet_rcv+0xbf/0x34b

but task is already holding lock:
 (&dev->xmit_lock){-+}, at: [<c0bb04ec>] qdisc_restart+0x46/0x207

which lock already depends on the new lock,
which could lead to circular deadlocks!

the dependency chain (in reverse order) is:
-> #2 (&dev->xmit_lock){-+}: [<c0bb04ec>] qdisc_restart+0x46/0x207
-> #1 (&dev->queue_lock){-+}: [<c0b98137>] dev_queue_xmit+0xc3/0x21e
-> #0 (&sk->sk_lock.slock){-+}: [<c0c6be28>] packet_rcv+0xbf/0x34b

other info that might help us debug this:

1 locks held by sshd/28997:
 #0:  (&dev->xmit_lock){-+}, at: [<c0bb04ec>] qdisc_restart+0x46/0x207

stack backtrace:
 [<c0103ecd>] show_trace+0xd/0xf
 [<c0103ee4>] dump_stack+0x15/0x17
 [<c014019e>] print_circular_bug_tail+0x42/0x4b
 [<c0141716>] debug_lock_chain+0xb30/0xd58
 [<c014196f>] debug_lock_chain_spin+0x31/0x48
 [<c0415b8c>] _raw_spin_lock+0x34/0x7f
 [<c0d3c12d>] _spin_lock+0x8/0xa
 [<c0c6be28>] packet_rcv+0xbf/0x34b
 [<c0b98052>] dev_queue_xmit_nit+0xbb/0xdd
 [<c0bb05a5>] qdisc_restart+0xff/0x207
 [<c0b9814e>] dev_queue_xmit+0xda/0x21e
 [<c0bde286>] ip_output+0x237/0x2c1
 [<c0bdd9a4>] ip_queue_xmit+0x394/0x417
 [<c0beafb7>] tcp_transmit_skb+0x5d4/0x5f6
 [<c0beca28>] __tcp_push_pending_frames+0x256/0x305
 [<c0be43f1>] tcp_sendmsg+0x8ae/0x975
 [<c0bfabd3>] inet_sendmsg+0x39/0x46
 [<c0b8fd44>] do_sock_write+0xbd/0xc6
 [<c0b8fe7b>] sock_aio_write+0x56/0x64
 [<c016c922>] do_sync_write+0xb1/0xe6
 [<c016cd71>] vfs_write+0xbd/0x155
 [<c016d5db>] sys_write+0x3b/0x60
 [<c0102c39>] syscall_call+0x7/0xb

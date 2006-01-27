Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWA0ARa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWA0ARa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWA0ARa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:17:30 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:21461 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932300AbWA0AR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:17:27 -0500
Date: Fri, 27 Jan 2006 01:18:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [lock validator] net/ipv4/fib_hash.c: illegal {enabled-softirqs} -> {used-in-softirq} usage?
Message-ID: <20060127001807.GA17179@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

the lock validator i'm working on found another item:

  ============================
  [ BUG: illegal lock usage! ]
  ----------------------------
  illegal {enabled-softirqs} -> {used-in-softirq} usage.
  hackbench/8407 [HC0[0]:SC1[2]:HE1:SE0] takes:
   {&state[i].lock} [<c0bf7d08>] wrandom_flush+0x2a/0xb3
  {enabled-softirqs} state was registered at:
   [<c0befc33>] fn_hash_insert+0x565/0x5c3
  hardirqs last enabled at: [<c0d29a36>] _spin_unlock_irq+0xd/0x10
  softirqs last enabled at: [<c012d0a0>] irq_exit+0x36/0x38
  
  other info that might help us debug this:
  locks held by hackbench/8407: <none>
  
  stack backtrace:
   [<c0103e86>] show_trace+0xd/0xf
   [<c0103e9d>] dump_stack+0x15/0x17
   [<c013eb40>] print_usage_bug+0x16d/0x177
   [<c013f130>] mark_lock+0xe3/0x248
   [<c013f65d>] debug_lock_chain+0x3c8/0xb1d
   [<c013fde3>] debug_lock_chain_spin+0x31/0x48
   [<c0410c4e>] _raw_spin_lock+0x34/0x7f
   [<c0d298fd>] _spin_lock+0x8/0xa
   [<c0bf7d08>] wrandom_flush+0x2a/0xb3
   [<c0bc3738>] rt_cache_flush+0x3f/0xd8
   [<c0bc3843>] rt_secret_rebuild+0x11/0x26
   [<c0131165>] run_timer_softirq+0x143/0x19e
   [<c012d384>] __do_softirq+0x84/0xff
   [<c0104d76>] do_softirq+0x52/0xbb
   =======================
   [<c012d0a0>] irq_exit+0x36/0x38
   [<c0118809>] smp_apic_timer_interrupt+0x4e/0x51
   [<c010376f>] apic_timer_interrupt+0x27/0x2c
   [<c01670b2>] kmem_cache_alloc+0x28/0xa6
   [<c0b80be6>] __alloc_skb+0x25/0xee
   [<c0b7f144>] sock_alloc_send_skb+0x5d/0x192
   [<c0c29bdf>] unix_stream_sendmsg+0x131/0x33f
   [<c0b7e30a>] do_sock_write+0xbd/0xc6
   [<c0b7e441>] sock_aio_write+0x56/0x64
   [<c016a9a4>] do_sync_write+0xb1/0xe6
   [<c016adf0>] vfs_write+0xbd/0x155
   [<c016b657>] sys_write+0x3b/0x60
   [<c0102c25>] syscall_call+0x7/0xb

the culprit seems to be:

(gdb) list *0xc0befc33
0xc0befc33 is in fn_hash_insert (net/ipv4/fib_hash.c:527).
522             list_add_tail(&new_fa->fa_list,
523                      (fa ? &fa->fa_list : &f->fn_alias));
524             fib_hash_genid++;
525             write_unlock_bh(&fib_hash_lock);
526
527             if (new_f)
528                     fz->fz_nent++;
529             rt_cache_flush(-1);
530
531             rtmsg_fib(RTM_NEWROUTE, key, new_fa, z, tb->tb_id, n, req);
(gdb)

which enabled softirqs with {&state[i].lock} still held. If the 
rt_secret_rebuild() would hit that codepath at that point then it could 
cause a deadlock, right?

	Ingo

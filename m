Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWAZWmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWAZWmj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWAZWmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:42:39 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:55244 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964952AbWAZWmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:42:38 -0500
Date: Thu, 26 Jan 2006 23:43:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jgarzik@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@redhat.com>
Subject: [lock validator] drivers/net/8139too.c: deadlock?
Message-ID: <20060126224312.GA2779@elte.hu>
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

the lock validator i'm working on found the following scenario in the 
rtl8139 driver, which it flagged as a deadlock:

  ---------------------------------------->
  NETDEV WATCHDOG: eth0: transmit timed out
  eth0: Transmit timeout, status 0d 0000 c07f media 80.
  eth0: Tx queue start entry 164281  dirty entry 164277.
  eth0:  Tx descriptor 0 is 000805ea.
  eth0:  Tx descriptor 1 is 00080042. (queue head)
  eth0:  Tx descriptor 2 is 00080042.
  eth0:  Tx descriptor 3 is 000805ea.
  
  ============================================
  [ BUG: circular locking deadlock detected! ]
  --------------------------------------------
  hackbench/9560 [2] is trying to acquire lock {&tp->rx_lock} at:
   [<c033e460>] rtl8139_tx_timeout+0x110/0x1f0
  but task is already holding lock {&dev->xmit_lock}, acquired at:
   [<c045294b>] dev_watchdog+0x1b/0xc0
  which lock already depends on the new lock,
  which could lead to circular deadlocks!
  
  the dependency chain (in reverse order) is:
  -> #4 {&dev->xmit_lock}: [<c045294b>] dev_watchdog+0x1b/0xc0
  -> #3 {&dev->queue_lock}: [<c0447154>] dev_queue_xmit+0x64/0x290
  -> #2 {&((sk)->sk_lock.slock)}: [<c043eb66>] sk_clone+0x66/0x200
  -> #1 {&((sk)->sk_lock.slock)}: [<c047a116>] tcp_v4_rcv+0x726/0x9d0
  -> #0 {&tp->rx_lock}: [<c033e460>] rtl8139_tx_timeout+0x110/0x1f0
  
  other info that might help us debug this:
  
  locks held by hackbench/9560:
   #0:  {net/unix/af_unix.c:&u->readlock} [<c0490e6f>] unix_stream_recvmsg+0xbf/0x4f0
   #1:  {&dev->xmit_lock} [<c045294b>] dev_watchdog+0x1b/0xc0
  
  stack backtrace:
   [<c010432d>] show_trace+0xd/0x10
   [<c0104347>] dump_stack+0x17/0x20
   [<c0137d60>] print_circular_bug_tail+0x40/0x50
   [<c013922f>] debug_lock_chain+0x74f/0xd40
   [<c013985d>] debug_lock_chain_spin+0x3d/0x60
   [<c0266add>] _raw_spin_lock+0x2d/0x90
   [<c04d9d18>] _spin_lock+0x8/0x10
   [<c033e460>] rtl8139_tx_timeout+0x110/0x1f0
   [<c04529e8>] dev_watchdog+0xb8/0xc0
   [<c0127615>] run_timer_softirq+0xf5/0x1f0
   [<c0122f67>] __do_softirq+0x97/0x130
   [<c0105519>] do_softirq+0x69/0x100
   =======================
   [<c0122c19>] irq_exit+0x39/0x50
   [<c010f4cc>] smp_apic_timer_interrupt+0x4c/0x50
   [<c010393b>] apic_timer_interrupt+0x27/0x2c
   [<c0441829>] skb_release_data+0x59/0xa0
   [<c0441b43>] kfree_skbmem+0x13/0xe0
   [<c0441c58>] __kfree_skb+0x48/0xc0
   [<c0490f7c>] unix_stream_recvmsg+0x1cc/0x4f0
   [<c043d2d5>] do_sock_read+0x95/0xd0
   [<c043d475>] sock_aio_read+0x75/0x80
   [<c016499b>] do_sync_read+0xbb/0x110
   [<c0164e88>] vfs_read+0x148/0x150
   [<c01658bd>] sys_read+0x3d/0x70
   [<c0102df7>] sysenter_past_esp+0x54/0x8d
  eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
  <----------------------------------------------

i'm wondering, is this a genuine deadlock, or a false positive? The 
dependency chain is quite complex, but looks realistic:

  -> #4 {&dev->xmit_lock}: [<c045294b>] dev_watchdog+0x1b/0xc0
  -> #3 {&dev->queue_lock}: [<c0447154>] dev_queue_xmit+0x64/0x290
  -> #2 {&((sk)->sk_lock.slock)}: [<c043eb66>] sk_clone+0x66/0x200
  -> #1 {&((sk)->sk_lock.slock)}: [<c047a116>] tcp_v4_rcv+0x726/0x9d0
  -> #0 {&tp->rx_lock}: [<c033e460>] rtl8139_tx_timeout+0x110/0x1f0

and rtl8139_tx_timeout() is rare enough to not cause real lockups in 
practice all that often.

explanation of the validator output: the above dependency chain does not 
mean it actually occured in one single call sequence - it is a 
comulative (and full) depdency graph the validator is maintaining, to 
prove locking correctness. So it can easily be multiple tasks, at 
distinct points in time, on different CPUs, which built this dependency 
chain. The first (#0) and the last (#4) entry is the current locking 
sequence's fingerprint - so do not understand the above to be an actual 
locking stack - it cannot possibly occur in this order.

	Ingo

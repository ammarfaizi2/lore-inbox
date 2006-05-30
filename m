Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWE3JP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWE3JP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWE3JP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:15:28 -0400
Received: from smtp.irisa.fr ([131.254.254.26]:15753 "EHLO smtp.irisa.fr")
	by vger.kernel.org with ESMTP id S932202AbWE3JP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:15:27 -0400
Date: Tue, 30 May 2006 11:14:15 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, yi.zhu@intel.com,
       jketreno@linux.intel.com
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060530091415.GA13341@ens-lyon.fr>
References: <20060529212109.GA2058@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060529212109.GA2058@elte.hu>
X-Sieve: CMU Sieve 2.2
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/06, Ingo Molnar <mingo@elte.hu> wrote:
> We are pleased to announce the first release of the "lock dependency
> correctness validator" kernel debugging feature, which can be downloaded
> from:
>
>   http://redhat.com/~mingo/lockdep-patches/
> [snip]

I get this right after ipw2200 is loaded (it is quite verbose, I
probably shoudln't post everything...)

ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Detected geography ZZD (13 802.11bg channels, 0 802.11a channels)

======================================================
[ BUG: hard-safe -> hard-unsafe lock order detected! ]
------------------------------------------------------
default.hotplug/3212 [HC0[0]:SC1[1]:HE0:SE0] is trying to acquire:
 (nl_table_lock){-.-±}, at: [<c0301efa>] netlink_broadcast+0x7a/0x360

and this task is already holding:
 (&priv->lock){++..}, at: [<e1cfe588>] ipw_irq_tasklet+0x18/0x500 [ipw2200]
which would create a new lock dependency:
 (&priv->lock){++..} -> (nl_table_lock){-.-±}

but this new dependency connects a hard-irq-safe lock:
 (&priv->lock){++..}
... which became hard-irq-safe at:
  [<c01395da>] lockdep_acquire+0x7a/0xa0
  [<c0352583>] _spin_lock+0x23/0x30
  [<e1cfdbc1>] ipw_isr+0x21/0xd0 [ipw2200]
  [<c01466e3>] handle_IRQ_event+0x33/0x80
  [<c01467e4>] __do_IRQ+0xb4/0x120
  [<c01057c0>] do_IRQ+0x70/0xc0

to a hard-irq-unsafe lock:
 (nl_table_lock){-.-±}
... which became hard-irq-unsafe at:
...  [<c01395da>] lockdep_acquire+0x7a/0xa0
  [<c03520da>] _write_lock_bh+0x2a/0x30
  [<c03017d2>] netlink_table_grab+0x12/0xe0
  [<c0301bcb>] netlink_insert+0x2b/0x180
  [<c030307c>] netlink_kernel_create+0xac/0x140
  [<c048f29a>] rtnetlink_init+0x6a/0xc0
  [<c048f6b9>] netlink_proto_init+0x169/0x180
  [<c010029f>] _stext+0x7f/0x250
  [<c0101005>] kernel_thread_helper+0x5/0xb

which could potentially lead to deadlocks!

other info that might help us debug this:

1 locks held by default.hotplug/3212:
 #0:  (&priv->lock){++..}, at: [<e1cfe588>] ipw_irq_tasklet+0x18/0x500 [ipw2200]

the hard-irq-safe lock's dependencies:
-> (&priv->lock){++..} ops: 102 {
   initial-use  at:
                                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                                       [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                                       [<e1cf6a0c>] ipw_load+0x1fc/0xc90 [ipw2200]
                                       [<e1cf74e8>] ipw_up+0x48/0x520 [ipw2200]
                                       [<e1cfda87>] ipw_net_init+0x27/0x50 [ipw2200]
                                       [<c02eeef1>] register_netdevice+0xd1/0x410
                                       [<c02f0609>] register_netdev+0x59/0x70
                                       [<e1cfe4d6>] ipw_pci_probe+0x806/0x8a0 [ipw2200]
                                       [<c023481e>] pci_device_probe+0x5e/0x80
                                       [<c02a86e4>] driver_probe_device+0x44/0xc0
                                       [<c02a888b>] __driver_attach+0x9b/0xa0
                                       [<c02a8039>] bus_for_each_dev+0x49/0x70
                                       [<c02a8629>] driver_attach+0x19/0x20
                                       [<c02a7c64>] bus_add_driver+0x74/0x140
                                       [<c02a8b06>] driver_register+0x56/0x90
                                       [<c0234a10>] __pci_register_driver+0x50/0x70
                                       [<e18b302e>] 0xe18b302e
                                       [<c014034d>] sys_init_module+0xcd/0x1630
                                       [<c035273b>] sysenter_past_esp+0x54/0x8d
   in-hardirq-W at:
                                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                                       [<c0352583>] _spin_lock+0x23/0x30
                                       [<e1cfdbc1>] ipw_isr+0x21/0xd0 [ipw2200]
                                       [<c01466e3>] handle_IRQ_event+0x33/0x80
                                       [<c01467e4>] __do_IRQ+0xb4/0x120
                                       [<c01057c0>] do_IRQ+0x70/0xc0
   in-softirq-W at:
                                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                                       [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                                       [<e1cfe588>] ipw_irq_tasklet+0x18/0x500 [ipw2200]
                                       [<c0121ea0>] tasklet_action+0x40/0x90
                                       [<c01223b4>] __do_softirq+0x54/0xc0
                                       [<c01056bb>] do_softirq+0x5b/0xf0
 }
 ... key      at: [<e1d0b438>] __key.27363+0x0/0xffff38f6 [ipw2200]
  -> (&q->lock){++..} ops: 33353 {
     initial-use  at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c0352509>] _spin_lock_irq+0x29/0x40
                      [<c034f084>] wait_for_completion+0x24/0x150
                      [<c013160e>] keventd_create_kthread+0x2e/0x70
                      [<c01315d6>] kthread_create+0xe6/0xf0
                      [<c0121b75>] cpu_callback+0x95/0x110
                      [<c0481194>] spawn_ksoftirqd+0x14/0x30
                      [<c010023c>] _stext+0x1c/0x250
                      [<c0101005>] kernel_thread_helper+0x5/0xb
     in-hardirq-W at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                      [<c011794b>] __wake_up+0x1b/0x50
                      [<c012dcdd>] __queue_work+0x4d/0x70
                      [<c012ddaf>] queue_work+0x6f/0x80
                      [<c0269588>] acpi_os_execute+0xcd/0xe9
                      [<c026eea1>] acpi_ev_gpe_dispatch+0xbc/0x122
                      [<c026f106>] acpi_ev_gpe_detect+0x99/0xe0
                      [<c026d90b>] acpi_ev_sci_xrupt_handler+0x15/0x1d
                      [<c0268c55>] acpi_irq+0xe/0x18
                      [<c01466e3>] handle_IRQ_event+0x33/0x80
                      [<c01467e4>] __do_IRQ+0xb4/0x120
                      [<c01057c0>] do_IRQ+0x70/0xc0
     in-softirq-W at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                      [<c011786b>] complete+0x1b/0x60
                      [<c012ef0b>] wakeme_after_rcu+0xb/0x10
                      [<c012f0c9>] __rcu_process_callbacks+0x69/0x1c0
                      [<c012f232>] rcu_process_callbacks+0x12/0x30
                      [<c0121ea0>] tasklet_action+0x40/0x90
                      [<c01223b4>] __do_softirq+0x54/0xc0
                      [<c01056bb>] do_softirq+0x5b/0xf0
   }
   ... key      at: [<c04d47c8>] 0xc04d47c8
    -> (&rq->lock){++..} ops: 68824 {
       initial-use  at:
                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                       [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                       [<c0117bcc>] init_idle+0x4c/0x80
                       [<c0480ad8>] sched_init+0xa8/0xb0
                       [<c0473558>] start_kernel+0x58/0x330
                       [<c0100199>] 0xc0100199
       in-hardirq-W at:
                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                       [<c0352583>] _spin_lock+0x23/0x30
                       [<c0117cc7>] scheduler_tick+0xc7/0x310
                       [<c01270ee>] update_process_times+0x3e/0x70
                       [<c0106c21>] timer_interrupt+0x41/0xa0
                       [<c01466e3>] handle_IRQ_event+0x33/0x80
                       [<c01467e4>] __do_IRQ+0xb4/0x120
                       [<c01057c0>] do_IRQ+0x70/0xc0
       in-softirq-W at:
                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                       [<c0352583>] _spin_lock+0x23/0x30
                       [<c01183e0>] try_to_wake_up+0x30/0x170
                       [<c011854f>] wake_up_process+0xf/0x20
                       [<c0122413>] __do_softirq+0xb3/0xc0
                       [<c01056bb>] do_softirq+0x5b/0xf0
     }
     ... key      at: [<c04c1400>] 0xc04c1400
   ... acquired at:
   [<c01395da>] lockdep_acquire+0x7a/0xa0
   [<c0352583>] _spin_lock+0x23/0x30
   [<c01183e0>] try_to_wake_up+0x30/0x170
   [<c011852b>] default_wake_function+0xb/0x10
   [<c01172d9>] __wake_up_common+0x39/0x70
   [<c011788d>] complete+0x3d/0x60
   [<c01316d4>] kthread+0x84/0xbc
   [<c0101005>] kernel_thread_helper+0x5/0xb

 ... acquired at:
   [<c01395da>] lockdep_acquire+0x7a/0xa0
   [<c03524c0>] _spin_lock_irqsave+0x30/0x50
   [<c011794b>] __wake_up+0x1b/0x50
   [<e1cf6a2e>] ipw_load+0x21e/0xc90 [ipw2200]
   [<e1cf74e8>] ipw_up+0x48/0x520 [ipw2200]
   [<e1cfda87>] ipw_net_init+0x27/0x50 [ipw2200]
   [<c02eeef1>] register_netdevice+0xd1/0x410
   [<c02f0609>] register_netdev+0x59/0x70
   [<e1cfe4d6>] ipw_pci_probe+0x806/0x8a0 [ipw2200]
   [<c023481e>] pci_device_probe+0x5e/0x80
   [<c02a86e4>] driver_probe_device+0x44/0xc0
   [<c02a888b>] __driver_attach+0x9b/0xa0
   [<c02a8039>] bus_for_each_dev+0x49/0x70
   [<c02a8629>] driver_attach+0x19/0x20
   [<c02a7c64>] bus_add_driver+0x74/0x140
   [<c02a8b06>] driver_register+0x56/0x90
   [<c0234a10>] __pci_register_driver+0x50/0x70
   [<e18b302e>] 0xe18b302e
   [<c014034d>] sys_init_module+0xcd/0x1630
   [<c035273b>] sysenter_past_esp+0x54/0x8d

  -> (&rxq->lock){.+..} ops: 40 {
     initial-use  at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                      [<e1cf66d0>] ipw_rx_queue_replenish+0x20/0x120 [ipw2200]
                      [<e1cf72e0>] ipw_load+0xad0/0xc90 [ipw2200]
                      [<e1cf74e8>] ipw_up+0x48/0x520 [ipw2200]
                      [<e1cfda87>] ipw_net_init+0x27/0x50 [ipw2200]
                      [<c02eeef1>] register_netdevice+0xd1/0x410
                      [<c02f0609>] register_netdev+0x59/0x70
                      [<e1cfe4d6>] ipw_pci_probe+0x806/0x8a0 [ipw2200]
                      [<c023481e>] pci_device_probe+0x5e/0x80
                      [<c02a86e4>] driver_probe_device+0x44/0xc0
                      [<c02a888b>] __driver_attach+0x9b/0xa0
                      [<c02a8039>] bus_for_each_dev+0x49/0x70
                      [<c02a8629>] driver_attach+0x19/0x20
                      [<c02a7c64>] bus_add_driver+0x74/0x140
                      [<c02a8b06>] driver_register+0x56/0x90
                      [<c0234a10>] __pci_register_driver+0x50/0x70
                      [<e18b302e>] 0xe18b302e
                      [<c014034d>] sys_init_module+0xcd/0x1630
                      [<c035273b>] sysenter_past_esp+0x54/0x8d
     in-softirq-W at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                      [<e1cf25bf>] ipw_rx_queue_restock+0x1f/0x120 [ipw2200]
                      [<e1cf80d1>] ipw_rx+0x631/0x1bb0 [ipw2200]
                      [<e1cfe6ac>] ipw_irq_tasklet+0x13c/0x500 [ipw2200]
                      [<c0121ea0>] tasklet_action+0x40/0x90
                      [<c01223b4>] __do_softirq+0x54/0xc0
                      [<c01056bb>] do_softirq+0x5b/0xf0
   }
   ... key      at: [<e1d0b440>] __key.23915+0x0/0xffff38ee [ipw2200]
    -> (&parent->list_lock){.+..} ops: 17457 {
       initial-use  at:
                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                       [<c0352583>] _spin_lock+0x23/0x30
                       [<c0166437>] cache_alloc_refill+0x87/0x650
                       [<c0166bae>] kmem_cache_zalloc+0xbe/0xd0
                       [<c01672d4>] kmem_cache_create+0x154/0x540
                       [<c0483ad9>] kmem_cache_init+0x179/0x3d0
                       [<c0473638>] start_kernel+0x138/0x330
                       [<c0100199>] 0xc0100199
       in-softirq-W at:
                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                       [<c0352583>] _spin_lock+0x23/0x30
                       [<c0166073>] free_block+0x183/0x190
                       [<c0165bdf>] __cache_free+0x9f/0x120
                       [<c0165da8>] kmem_cache_free+0x88/0xb0
                       [<c0119e21>] free_task+0x21/0x30
                       [<c011b955>] __put_task_struct+0x95/0x156
                       [<c011db12>] delayed_put_task_struct+0x32/0x60
                       [<c012f0c9>] __rcu_process_callbacks+0x69/0x1c0
                       [<c012f232>] rcu_process_callbacks+0x12/0x30
                       [<c0121ea0>] tasklet_action+0x40/0x90
                       [<c01223b4>] __do_softirq+0x54/0xc0
                       [<c01056bb>] do_softirq+0x5b/0xf0
     }
     ... key      at: [<c060d00c>] 0xc060d00c
   ... acquired at:
   [<c01395da>] lockdep_acquire+0x7a/0xa0
   [<c0352583>] _spin_lock+0x23/0x30
   [<c0166437>] cache_alloc_refill+0x87/0x650
   [<c0166ab8>] __kmalloc+0xb8/0xf0
   [<c02eb3cb>] __alloc_skb+0x4b/0x100
   [<e1cf6769>] ipw_rx_queue_replenish+0xb9/0x120 [ipw2200]
   [<e1cf72e0>] ipw_load+0xad0/0xc90 [ipw2200]
   [<e1cf74e8>] ipw_up+0x48/0x520 [ipw2200]
   [<e1cfda87>] ipw_net_init+0x27/0x50 [ipw2200]
   [<c02eeef1>] register_netdevice+0xd1/0x410
   [<c02f0609>] register_netdev+0x59/0x70
   [<e1cfe4d6>] ipw_pci_probe+0x806/0x8a0 [ipw2200]
   [<c023481e>] pci_device_probe+0x5e/0x80
   [<c02a86e4>] driver_probe_device+0x44/0xc0
   [<c02a888b>] __driver_attach+0x9b/0xa0
   [<c02a8039>] bus_for_each_dev+0x49/0x70
   [<c02a8629>] driver_attach+0x19/0x20
   [<c02a7c64>] bus_add_driver+0x74/0x140
   [<c02a8b06>] driver_register+0x56/0x90
   [<c0234a10>] __pci_register_driver+0x50/0x70
   [<e18b302e>] 0xe18b302e
   [<c014034d>] sys_init_module+0xcd/0x1630
   [<c035273b>] sysenter_past_esp+0x54/0x8d

 ... acquired at:
   [<c01395da>] lockdep_acquire+0x7a/0xa0
   [<c03524c0>] _spin_lock_irqsave+0x30/0x50
   [<e1cf25bf>] ipw_rx_queue_restock+0x1f/0x120 [ipw2200]
   [<e1cf80d1>] ipw_rx+0x631/0x1bb0 [ipw2200]
   [<e1cfe6ac>] ipw_irq_tasklet+0x13c/0x500 [ipw2200]
   [<c0121ea0>] tasklet_action+0x40/0x90
   [<c01223b4>] __do_softirq+0x54/0xc0
   [<c01056bb>] do_softirq+0x5b/0xf0

  -> (&ieee->lock){.+..} ops: 15 {
     initial-use  at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                      [<e1c9d0cf>] ieee80211_process_probe_response+0x1ff/0x790 [ieee80211]
                      [<e1c9d70f>] ieee80211_rx_mgt+0xaf/0x340 [ieee80211]
                      [<e1cf8219>] ipw_rx+0x779/0x1bb0 [ipw2200]
                      [<e1cfe6ac>] ipw_irq_tasklet+0x13c/0x500 [ipw2200]
                      [<c0121ea0>] tasklet_action+0x40/0x90
                      [<c01223b4>] __do_softirq+0x54/0xc0
                      [<c01056bb>] do_softirq+0x5b/0xf0
     in-softirq-W at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                      [<e1c9d0cf>] ieee80211_process_probe_response+0x1ff/0x790 [ieee80211]
                      [<e1c9d70f>] ieee80211_rx_mgt+0xaf/0x340 [ieee80211]
                      [<e1cf8219>] ipw_rx+0x779/0x1bb0 [ipw2200]
                      [<e1cfe6ac>] ipw_irq_tasklet+0x13c/0x500 [ipw2200]
                      [<c0121ea0>] tasklet_action+0x40/0x90
                      [<c01223b4>] __do_softirq+0x54/0xc0
                      [<c01056bb>] do_softirq+0x5b/0xf0
   }
   ... key      at: [<e1ca2781>] __key.22782+0x0/0xffffdc00 [ieee80211]
 ... acquired at:
   [<c01395da>] lockdep_acquire+0x7a/0xa0
   [<c03524c0>] _spin_lock_irqsave+0x30/0x50
   [<e1c9d0cf>] ieee80211_process_probe_response+0x1ff/0x790 [ieee80211]
   [<e1c9d70f>] ieee80211_rx_mgt+0xaf/0x340 [ieee80211]
   [<e1cf8219>] ipw_rx+0x779/0x1bb0 [ipw2200]
   [<e1cfe6ac>] ipw_irq_tasklet+0x13c/0x500 [ipw2200]
   [<c0121ea0>] tasklet_action+0x40/0x90
   [<c01223b4>] __do_softirq+0x54/0xc0
   [<c01056bb>] do_softirq+0x5b/0xf0

  -> (&cwq->lock){++..} ops: 3739 {
     initial-use  at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                      [<c012dca8>] __queue_work+0x18/0x70
                      [<c012ddaf>] queue_work+0x6f/0x80
                      [<c012d949>] call_usermodehelper_keys+0x139/0x160
                      [<c0219a2a>] kobject_uevent+0x7a/0x4a0
                      [<c0219753>] kobject_register+0x43/0x50
                      [<c02a7687>] sysdev_register+0x67/0x100
                      [<c02aa950>] register_cpu+0x30/0x70
                      [<c0108f7a>] arch_register_cpu+0x2a/0x30
                      [<c047850a>] topology_init+0xa/0x10
                      [<c010029f>] _stext+0x7f/0x250
                      [<c0101005>] kernel_thread_helper+0x5/0xb
     in-hardirq-W at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                      [<c012dca8>] __queue_work+0x18/0x70
                      [<c012ddaf>] queue_work+0x6f/0x80
                      [<c0269588>] acpi_os_execute+0xcd/0xe9
                      [<c026eea1>] acpi_ev_gpe_dispatch+0xbc/0x122
                      [<c026f106>] acpi_ev_gpe_detect+0x99/0xe0
                      [<c026d90b>] acpi_ev_sci_xrupt_handler+0x15/0x1d
                      [<c0268c55>] acpi_irq+0xe/0x18
                      [<c01466e3>] handle_IRQ_event+0x33/0x80
                      [<c01467e4>] __do_IRQ+0xb4/0x120
                      [<c01057c0>] do_IRQ+0x70/0xc0
     in-softirq-W at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                      [<c012dca8>] __queue_work+0x18/0x70
                      [<c012dd30>] delayed_work_timer_fn+0x30/0x40
                      [<c012633e>] run_timer_softirq+0x12e/0x180
                      [<c01223b4>] __do_softirq+0x54/0xc0
                      [<c01056bb>] do_softirq+0x5b/0xf0
   }
   ... key      at: [<c04d4334>] 0xc04d4334
    -> (&q->lock){++..} ops: 33353 {
       initial-use  at:
                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                       [<c0352509>] _spin_lock_irq+0x29/0x40
                       [<c034f084>] wait_for_completion+0x24/0x150
                       [<c013160e>] keventd_create_kthread+0x2e/0x70
                       [<c01315d6>] kthread_create+0xe6/0xf0
                       [<c0121b75>] cpu_callback+0x95/0x110
                       [<c0481194>] spawn_ksoftirqd+0x14/0x30
                       [<c010023c>] _stext+0x1c/0x250
                       [<c0101005>] kernel_thread_helper+0x5/0xb
       in-hardirq-W at:
                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                       [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                       [<c011794b>] __wake_up+0x1b/0x50
                       [<c012dcdd>] __queue_work+0x4d/0x70
                       [<c012ddaf>] queue_work+0x6f/0x80
                       [<c0269588>] acpi_os_execute+0xcd/0xe9
                       [<c026eea1>] acpi_ev_gpe_dispatch+0xbc/0x122
                       [<c026f106>] acpi_ev_gpe_detect+0x99/0xe0
                       [<c026d90b>] acpi_ev_sci_xrupt_handler+0x15/0x1d
                       [<c0268c55>] acpi_irq+0xe/0x18
                       [<c01466e3>] handle_IRQ_event+0x33/0x80
                       [<c01467e4>] __do_IRQ+0xb4/0x120
                       [<c01057c0>] do_IRQ+0x70/0xc0
       in-softirq-W at:
                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                       [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                       [<c011786b>] complete+0x1b/0x60
                       [<c012ef0b>] wakeme_after_rcu+0xb/0x10
                       [<c012f0c9>] __rcu_process_callbacks+0x69/0x1c0
                       [<c012f232>] rcu_process_callbacks+0x12/0x30
                       [<c0121ea0>] tasklet_action+0x40/0x90
                       [<c01223b4>] __do_softirq+0x54/0xc0
                       [<c01056bb>] do_softirq+0x5b/0xf0
     }
     ... key      at: [<c04d47c8>] 0xc04d47c8
      -> (&rq->lock){++..} ops: 68824 {
         initial-use  at:
                        [<c01395da>] lockdep_acquire+0x7a/0xa0
                        [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                        [<c0117bcc>] init_idle+0x4c/0x80
                        [<c0480ad8>] sched_init+0xa8/0xb0
                        [<c0473558>] start_kernel+0x58/0x330
                        [<c0100199>] 0xc0100199
         in-hardirq-W at:
                        [<c01395da>] lockdep_acquire+0x7a/0xa0
                        [<c0352583>] _spin_lock+0x23/0x30
                        [<c0117cc7>] scheduler_tick+0xc7/0x310
                        [<c01270ee>] update_process_times+0x3e/0x70
                        [<c0106c21>] timer_interrupt+0x41/0xa0
                        [<c01466e3>] handle_IRQ_event+0x33/0x80
                        [<c01467e4>] __do_IRQ+0xb4/0x120
                        [<c01057c0>] do_IRQ+0x70/0xc0
         in-softirq-W at:
                        [<c01395da>] lockdep_acquire+0x7a/0xa0
                        [<c0352583>] _spin_lock+0x23/0x30
                        [<c01183e0>] try_to_wake_up+0x30/0x170
                        [<c011854f>] wake_up_process+0xf/0x20
                        [<c0122413>] __do_softirq+0xb3/0xc0
                        [<c01056bb>] do_softirq+0x5b/0xf0
       }
       ... key      at: [<c04c1400>] 0xc04c1400
     ... acquired at:
   [<c01395da>] lockdep_acquire+0x7a/0xa0
   [<c0352583>] _spin_lock+0x23/0x30
   [<c01183e0>] try_to_wake_up+0x30/0x170
   [<c011852b>] default_wake_function+0xb/0x10
   [<c01172d9>] __wake_up_common+0x39/0x70
   [<c011788d>] complete+0x3d/0x60
   [<c01316d4>] kthread+0x84/0xbc
   [<c0101005>] kernel_thread_helper+0x5/0xb

   ... acquired at:
   [<c01395da>] lockdep_acquire+0x7a/0xa0
   [<c03524c0>] _spin_lock_irqsave+0x30/0x50
   [<c011794b>] __wake_up+0x1b/0x50
   [<c012dcdd>] __queue_work+0x4d/0x70
   [<c012ddaf>] queue_work+0x6f/0x80
   [<c012d949>] call_usermodehelper_keys+0x139/0x160
   [<c0219a2a>] kobject_uevent+0x7a/0x4a0
   [<c0219753>] kobject_register+0x43/0x50
   [<c02a7687>] sysdev_register+0x67/0x100
   [<c02aa950>] register_cpu+0x30/0x70
   [<c0108f7a>] arch_register_cpu+0x2a/0x30
   [<c047850a>] topology_init+0xa/0x10
   [<c010029f>] _stext+0x7f/0x250
   [<c0101005>] kernel_thread_helper+0x5/0xb

 ... acquired at:
   [<c01395da>] lockdep_acquire+0x7a/0xa0
   [<c03524c0>] _spin_lock_irqsave+0x30/0x50
   [<c012dca8>] __queue_work+0x18/0x70
   [<c012ddaf>] queue_work+0x6f/0x80
   [<e1cf267e>] ipw_rx_queue_restock+0xde/0x120 [ipw2200]
   [<e1cf80d1>] ipw_rx+0x631/0x1bb0 [ipw2200]
   [<e1cfe6ac>] ipw_irq_tasklet+0x13c/0x500 [ipw2200]
   [<c0121ea0>] tasklet_action+0x40/0x90
   [<c01223b4>] __do_softirq+0x54/0xc0
   [<c01056bb>] do_softirq+0x5b/0xf0

  -> (&base->lock){++..} ops: 8140 {
     initial-use  at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                      [<c0126e4a>] lock_timer_base+0x3a/0x60
                      [<c0126f17>] __mod_timer+0x37/0xc0
                      [<c0127036>] mod_timer+0x36/0x50
                      [<c048a2e5>] con_init+0x1b5/0x200
                      [<c0489802>] console_init+0x32/0x40
                      [<c04735ea>] start_kernel+0xea/0x330
                      [<c0100199>] 0xc0100199
     in-hardirq-W at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c03524c0>] _spin_lock_irqsave+0x30/0x50
                      [<c0126e4a>] lock_timer_base+0x3a/0x60
                      [<c0126e9c>] del_timer+0x2c/0x70
                      [<c02bc619>] ide_intr+0x69/0x1f0
                      [<c01466e3>] handle_IRQ_event+0x33/0x80
                      [<c01467e4>] __do_IRQ+0xb4/0x120
                      [<c01057c0>] do_IRQ+0x70/0xc0
     in-softirq-W at:
                      [<c01395da>] lockdep_acquire+0x7a/0xa0
                      [<c0352509>] _spin_lock_irq+0x29/0x40
                      [<c0126239>] run_timer_softirq+0x29/0x180
                      [<c01223b4>] __do_softirq+0x54/0xc0
                      [<c01056bb>] do_softirq+0x5b/0xf0
   }
   ... key      at: [<c04d3af8>] 0xc04d3af8
 ... acquired at:
   [<c01395da>] lockdep_acquire+0x7a/0xa0
   [<c03524c0>] _spin_lock_irqsave+0x30/0x50
   [<c0126e4a>] lock_timer_base+0x3a/0x60
   [<c0126e9c>] del_timer+0x2c/0x70
   [<e1cf83d9>] ipw_rx+0x939/0x1bb0 [ipw2200]
   [<e1cfe6ac>] ipw_irq_tasklet+0x13c/0x500 [ipw2200]
   [<c0121ea0>] tasklet_action+0x40/0x90
   [<c01223b4>] __do_softirq+0x54/0xc0
   [<c01056bb>] do_softirq+0x5b/0xf0


the hard-irq-unsafe lock's dependencies:
-> (nl_table_lock){-.-±} ops: 1585 {
   initial-use  at:
                                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                                       [<c03520da>] _write_lock_bh+0x2a/0x30
                                       [<c03017d2>] netlink_table_grab+0x12/0xe0
                                       [<c0301bcb>] netlink_insert+0x2b/0x180
                                       [<c030307c>] netlink_kernel_create+0xac/0x140
                                       [<c048f29a>] rtnetlink_init+0x6a/0xc0
                                       [<c048f6b9>] netlink_proto_init+0x169/0x180
                                       [<c010029f>] _stext+0x7f/0x250
                                       [<c0101005>] kernel_thread_helper+0x5/0xb
   hardirq-on-W at:
                                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                                       [<c03520da>] _write_lock_bh+0x2a/0x30
                                       [<c03017d2>] netlink_table_grab+0x12/0xe0
                                       [<c0301bcb>] netlink_insert+0x2b/0x180
                                       [<c030307c>] netlink_kernel_create+0xac/0x140
                                       [<c048f29a>] rtnetlink_init+0x6a/0xc0
                                       [<c048f6b9>] netlink_proto_init+0x169/0x180
                                       [<c010029f>] _stext+0x7f/0x250
                                       [<c0101005>] kernel_thread_helper+0x5/0xb
   in-softirq-R at:
                                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                                       [<c0352130>] _read_lock+0x20/0x30
                                       [<c0301efa>] netlink_broadcast+0x7a/0x360
                                       [<c02fb6a4>] wireless_send_event+0x304/0x340
                                       [<e1cf8e11>] ipw_rx+0x1371/0x1bb0 [ipw2200]
                                       [<e1cfe6ac>] ipw_irq_tasklet+0x13c/0x500 [ipw2200]
                                       [<c0121ea0>] tasklet_action+0x40/0x90
                                       [<c01223b4>] __do_softirq+0x54/0xc0
                                       [<c01056bb>] do_softirq+0x5b/0xf0
   softirq-on-R at:
                                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                                       [<c0352130>] _read_lock+0x20/0x30
                                       [<c0301efa>] netlink_broadcast+0x7a/0x360
                                       [<c02199f0>] kobject_uevent+0x40/0x4a0
                                       [<c0219753>] kobject_register+0x43/0x50
                                       [<c02a7687>] sysdev_register+0x67/0x100
                                       [<c02aa950>] register_cpu+0x30/0x70
                                       [<c0108f7a>] arch_register_cpu+0x2a/0x30
                                       [<c047850a>] topology_init+0xa/0x10
                                       [<c010029f>] _stext+0x7f/0x250
                                       [<c0101005>] kernel_thread_helper+0x5/0xb
   hardirq-on-R at:
                                       [<c01395da>] lockdep_acquire+0x7a/0xa0
                                       [<c0352130>] _read_lock+0x20/0x30
                                       [<c0301efa>] netlink_broadcast+0x7a/0x360
                                       [<c02199f0>] kobject_uevent+0x40/0x4a0
                                       [<c0219753>] kobject_register+0x43/0x50
                                       [<c02a7687>] sysdev_register+0x67/0x100
                                       [<c02aa950>] register_cpu+0x30/0x70
                                       [<c0108f7a>] arch_register_cpu+0x2a/0x30
                                       [<c047850a>] topology_init+0xa/0x10
                                       [<c010029f>] _stext+0x7f/0x250
                                       [<c0101005>] kernel_thread_helper+0x5/0xb
 }
 ... key      at: [<c0438908>] 0xc0438908

stack backtrace:
 <c010402d> show_trace+0xd/0x10  <c0104687> dump_stack+0x17/0x20
 <c0137fe3> check_usage+0x263/0x270  <c0138f06> __lockdep_acquire+0xb96/0xd40
 <c01395da> lockdep_acquire+0x7a/0xa0  <c0352130> _read_lock+0x20/0x30
 <c0301efa> netlink_broadcast+0x7a/0x360  <c02fb6a4> wireless_send_event+0x304/0x340
 <e1cf8e11> ipw_rx+0x1371/0x1bb0 [ipw2200]  <e1cfe6ac> ipw_irq_tasklet+0x13c/0x500 [ipw2200]
 <c0121ea0> tasklet_action+0x40/0x90  <c01223b4> __do_softirq+0x54/0xc0
 <c01056bb> do_softirq+0x5b/0xf0 
 =======================
 <c0122455> irq_exit+0x35/0x40  <c01057c7> do_IRQ+0x77/0xc0
 <c0103949> common_interrupt+0x25/0x2c 

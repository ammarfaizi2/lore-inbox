Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWHBV7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWHBV7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWHBV7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:59:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64162 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932255AbWHBV7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:59:41 -0400
Date: Wed, 2 Aug 2006 17:59:32 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org
Subject: orinoco driver causes *lots* of lockdep spew
Message-ID: <20060802215932.GE3639@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow. Nearly 400 lines of debug spew, from a simple 'ifup eth1'.

		Dave


ADDRCONF(NETDEV_UP): eth1: link is not ready
eth1: New link status: Disconnected (0002)

======================================================
[ INFO: hard-safe -> hard-unsafe lock order detected ]
------------------------------------------------------
events/0/5 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (af_callback_keys + sk->sk_family){-.--}, at: [<ffffffff802136b1>] sock_def_readable+0x19/0x6f

and this task is already holding:
 (&priv->lock){++..}, at: [<ffffffff8824f70e>] orinoco_send_wevents+0x28/0x8b [orinoco]
which would create a new lock dependency:
 (&priv->lock){++..} -> (af_callback_keys + sk->sk_family){-.--}

but this new dependency connects a hard-irq-safe lock:
 (&priv->lock){++..}
... which became hard-irq-safe at:
  [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
  [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
  [<ffffffff8824f7be>] orinoco_interrupt+0x4d/0xf49 [orinoco]
  [<ffffffff8021151f>] handle_IRQ_event+0x2b/0x64
  [<ffffffff802c0987>] __do_IRQ+0xae/0x114
  [<ffffffff8026fca8>] do_IRQ+0xf7/0x107
  [<ffffffff802609c4>] common_interrupt+0x64/0x65

to a hard-irq-unsafe lock:
 (af_callback_keys + sk->sk_family){-.--}
... which became hard-irq-unsafe at:
...  [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
  [<ffffffff80267867>] _write_lock_bh+0x29/0x36
  [<ffffffff80433960>] netlink_release+0x139/0x2ca
  [<ffffffff80257903>] sock_release+0x19/0x9b
  [<ffffffff80257b13>] sock_close+0x33/0x3a
  [<ffffffff802130ee>] __fput+0xc6/0x1a8
  [<ffffffff8022effe>] fput+0x13/0x16
  [<ffffffff80225383>] filp_close+0x64/0x70
  [<ffffffff8021eecc>] sys_close+0x93/0xb0
  [<ffffffff8026048d>] system_call+0x7d/0x83

other info that might help us debug this:

1 lock held by events/0/5:
 #0:  (&priv->lock){++..}, at: [<ffffffff8824f70e>] orinoco_send_wevents+0x28/0x8b [orinoco]

the hard-irq-safe lock's dependencies:
-> (&priv->lock){++..} ops: 0 {
   initial-use  at:
                        [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                        [<ffffffff80267a3e>] _spin_lock_irq+0x2a/0x38
                        [<ffffffff8824f102>] orinoco_init+0x934/0x966 [orinoco]
                        [<ffffffff8041e762>] register_netdevice+0xe6/0x375
                        [<ffffffff8041ea4b>] register_netdev+0x5a/0x69
                        [<ffffffff8826155f>] orinoco_cs_probe+0x3d7/0x475 [orinoco_cs]
                        [<ffffffff803daa02>] pcmcia_device_probe+0x7f/0x124
                        [<ffffffff803b5e74>] driver_probe_device+0x5b/0xb1
                        [<ffffffff803b5fde>] __driver_attach+0x88/0xdb
                        [<ffffffff803b5826>] bus_for_each_dev+0x48/0x7a
                        [<ffffffff803b5d9e>] driver_attach+0x1b/0x1e
                        [<ffffffff803b543e>] bus_add_driver+0x88/0x138
                        [<ffffffff803b6289>] driver_register+0x8e/0x93
                        [<ffffffff803da89b>] pcmcia_register_driver+0xd0/0xda
                        [<ffffffff880a9024>] 0xffffffff880a9024
                        [<ffffffff802af420>] sys_init_module+0x16f2/0x18b7
                        [<ffffffff8026048d>] system_call+0x7d/0x83
   in-hardirq-W at:
                        [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                        [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
                        [<ffffffff8824f7be>] orinoco_interrupt+0x4d/0xf49 [orinoco]
                        [<ffffffff8021151f>] handle_IRQ_event+0x2b/0x64
                        [<ffffffff802c0987>] __do_IRQ+0xae/0x114
                        [<ffffffff8026fca8>] do_IRQ+0xf7/0x107
                        [<ffffffff802609c4>] common_interrupt+0x64/0x65
   in-softirq-W at:
                        [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                        [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
                        [<ffffffff8824f7be>] orinoco_interrupt+0x4d/0xf49 [orinoco]
                        [<ffffffff8021151f>] handle_IRQ_event+0x2b/0x64
                        [<ffffffff802c0987>] __do_IRQ+0xae/0x114
                        [<ffffffff8026fca8>] do_IRQ+0xf7/0x107
                        [<ffffffff802609c4>] common_interrupt+0x64/0x65
                        [<ffffffff8028ebce>] scheduler_tick+0xc1/0x362
                        [<ffffffff80261739>] call_softirq+0x1d/0x28
                        [<ffffffff80295edb>] irq_exit+0x56/0x59
                        [<ffffffff8027a67f>] smp_apic_timer_interrupt+0x5c/0x62
                        [<ffffffff802610ad>] apic_timer_interrupt+0x69/0x70
 }
 ... key      at: [<ffffffff8825fd80>] __key.22351+0x0/0xffffffffffff27fa [orinoco]
 -> (&cwq->lock){++..} ops: 0 {
    initial-use  at:
                          [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                          [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
                          [<ffffffff802a0314>] __queue_work+0x17/0x5e
                          [<ffffffff802a03de>] queue_work+0x4d/0x57
                          [<ffffffff8029fdda>] call_usermodehelper_keys+0x119/0x137
                          [<ffffffff8025af79>] kobject_uevent+0x3e5/0x42e
                          [<ffffffff803b6ebf>] class_device_add+0x314/0x471
                          [<ffffffff803b7034>] class_device_register+0x18/0x1d
                          [<ffffffff803b7130>] class_device_create+0xf7/0x129
                          [<ffffffff8097f2ed>] vtconsole_class_init+0x74/0xbb
                          [<ffffffff8026d7fc>] init+0x1fc/0x3cd
                          [<ffffffff802613dd>] child_rip+0x7/0x12
    in-hardirq-W at:
                          [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                          [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
                          [<ffffffff802a0314>] __queue_work+0x17/0x5e
                          [<ffffffff802a03de>] queue_work+0x4d/0x57
                          [<ffffffff8033c786>] kblockd_schedule_work+0x15/0x18
                          [<ffffffff8034493b>] __cfq_slice_expired+0x63/0xe6
                          [<ffffffff80253352>] cfq_completed_request+0x116/0x154
                          [<ffffffff8033bb82>] elv_completed_request+0x38/0x85
                          [<ffffffff8033cca7>] __blk_put_request+0x35/0x9f
                          [<ffffffff8033cdfb>] end_that_request_last+0xea/0xf4
                          [<ffffffff8020b10a>] ide_end_request+0xf2/0x111
                          [<ffffffff8023f4a7>] ide_dma_intr+0x70/0xb5
                          [<ffffffff8020dcd6>] ide_intr+0x169/0x1df
                          [<ffffffff8021151f>] handle_IRQ_event+0x2b/0x64
                          [<ffffffff802c0987>] __do_IRQ+0xae/0x114
                          [<ffffffff8026fca8>] do_IRQ+0xf7/0x107
                          [<ffffffff802609c4>] common_interrupt+0x64/0x65
    in-softirq-W at:
                          [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                          [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
                          [<ffffffff802a0314>] __queue_work+0x17/0x5e
                          [<ffffffff802a03de>] queue_work+0x4d/0x57
                          [<ffffffff802a03fd>] schedule_work+0x15/0x18
                          [<ffffffff803639bb>] cursor_timer_handler+0x1b/0x38
                          [<ffffffff8029a391>] run_timer_softirq+0x14b/0x1d5
                          [<ffffffff80212a1f>] __do_softirq+0x67/0xf5
                          [<ffffffff80261739>] call_softirq+0x1d/0x28
                          [<ffffffff80295edb>] irq_exit+0x56/0x59
                          [<ffffffff8027a67f>] smp_apic_timer_interrupt+0x5c/0x62
                          [<ffffffff802610ad>] apic_timer_interrupt+0x69/0x70
  }
  ... key      at: [<ffffffff806c47a0>] __key.10352+0x0/0x8
  -> (&q->lock){++..} ops: 0 {
     initial-use  at:
                            [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                            [<ffffffff80267a3e>] _spin_lock_irq+0x2a/0x38
                            [<ffffffff80265123>] wait_for_completion+0x2f/0xb3
                            [<ffffffff802a34d4>] keventd_create_kthread+0x35/0x6a
                            [<ffffffff802a35d3>] kthread_create+0xca/0x153
                            [<ffffffff8028e085>] migration_call+0x60/0x44f
                            [<ffffffff80975115>] migration_init+0x27/0x4f
                            [<ffffffff8026d669>] init+0x69/0x3cd
                            [<ffffffff802613dd>] child_rip+0x7/0x12
     in-hardirq-W at:
                            [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                            [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
                            [<ffffffff80230689>] __wake_up+0x21/0x50
                            [<ffffffff8038719b>] acpi_ec_gpe_handler+0x96/0xdb
                            [<ffffffff803734f2>] acpi_ev_gpe_dispatch+0x6e/0x160
                            [<ffffffff80373876>] acpi_ev_gpe_detect+0xae/0xff
                            [<ffffffff80371cf0>] acpi_ev_sci_xrupt_handler+0x19/0x22
                            [<ffffffff8036c543>] acpi_irq+0x10/0x1b
                            [<ffffffff8021151f>] handle_IRQ_event+0x2b/0x64
                            [<ffffffff802c0987>] __do_IRQ+0xae/0x114
                            [<ffffffff8026fca8>] do_IRQ+0xf7/0x107
                            [<ffffffff802609c4>] common_interrupt+0x64/0x65
     in-softirq-W at:
                            [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                            [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
                            [<ffffffff8028d434>] complete+0x1b/0x4c
                            [<ffffffff802a12dc>] wakeme_after_rcu+0xc/0xf
                            [<ffffffff802a1531>] __rcu_process_callbacks+0x154/0x1d9
                            [<ffffffff802a15d8>] rcu_process_callbacks+0x22/0x44
                            [<ffffffff80296014>] tasklet_action+0x6c/0xc5
                            [<ffffffff80212a1f>] __do_softirq+0x67/0xf5
                            [<ffffffff80261739>] call_softirq+0x1d/0x28
                            [<ffffffff80295edb>] irq_exit+0x56/0x59
                            [<ffffffff8027a67f>] smp_apic_timer_interrupt+0x5c/0x62
                            [<ffffffff802610ad>] apic_timer_interrupt+0x69/0x70
   }
   ... key      at: [<ffffffff806c4dd8>] __key.13972+0x0/0x8
   -> (&rq->rq_lock_key){++..} ops: 0 {
      initial-use  at:
                              [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                              [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
                              [<ffffffff8028dd54>] init_idle+0x98/0xc7
                              [<ffffffff8097531d>] sched_init+0x1b8/0x1be
                              [<ffffffff809646e8>] start_kernel+0x7a/0x24c
                              [<ffffffff8096428a>] _sinittext+0x28a/0x292
                              [<ffffffffffffffff>] 0xffffffffffffffff
      in-hardirq-W at:
                              [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                              [<ffffffff802677ca>] _spin_lock+0x24/0x31
                              [<ffffffff8028eb81>] scheduler_tick+0x74/0x362
                              [<ffffffff8029abe0>] update_process_times+0x67/0x79
                              [<ffffffff80279f02>] smp_local_timer_interrupt+0x2a/0x50
                              [<ffffffff80271526>] main_timer_handler+0x202/0x3a5
                              [<ffffffff802716dd>] timer_interrupt+0x14/0x2a
                              [<ffffffff8021151f>] handle_IRQ_event+0x2b/0x64
                              [<ffffffff802c0987>] __do_IRQ+0xae/0x114
                              [<ffffffff8026fca8>] do_IRQ+0xf7/0x107
                              [<ffffffff802609c4>] common_interrupt+0x64/0x65
      in-softirq-W at:
                              [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                              [<ffffffff802677ca>] _spin_lock+0x24/0x31
                              [<ffffffff8028de0c>] task_rq_lock+0x41/0x74
                              [<ffffffff802489a3>] try_to_wake_up+0x26/0x418
                              [<ffffffff8028e022>] wake_up_process+0xf/0x12
                              [<ffffffff8029a593>] process_timeout+0x8/0xb
                              [<ffffffff8029a391>] run_timer_softirq+0x14b/0x1d5
                              [<ffffffff80212a1f>] __do_softirq+0x67/0xf5
                              [<ffffffff80261739>] call_softirq+0x1d/0x28
                              [<ffffffff80295edb>] irq_exit+0x56/0x59
                              [<ffffffff8027a67f>] smp_apic_timer_interrupt+0x5c/0x62
                              [<ffffffff802610ad>] apic_timer_interrupt+0x69/0x70
    }
    ... key      at: [<ffff810002618700>] 0xffff810002618700
   ... acquired at:
   [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
   [<ffffffff802677ca>] _spin_lock+0x24/0x31
   [<ffffffff8028de0c>] task_rq_lock+0x41/0x74
   [<ffffffff802489a3>] try_to_wake_up+0x26/0x418
   [<ffffffff8028e010>] default_wake_function+0xc/0xf
   [<ffffffff8028c310>] __wake_up_common+0x3d/0x68
   [<ffffffff8028d450>] complete+0x37/0x4c
   [<ffffffff80235411>] kthread+0xda/0x136
   [<ffffffff802613dd>] child_rip+0x7/0x12

  ... acquired at:
   [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
   [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
   [<ffffffff80230689>] __wake_up+0x21/0x50
   [<ffffffff802a0347>] __queue_work+0x4a/0x5e
   [<ffffffff802a03de>] queue_work+0x4d/0x57
   [<ffffffff8029fdda>] call_usermodehelper_keys+0x119/0x137
   [<ffffffff8025af79>] kobject_uevent+0x3e5/0x42e
   [<ffffffff803b6ebf>] class_device_add+0x314/0x471
   [<ffffffff803b7034>] class_device_register+0x18/0x1d
   [<ffffffff803b7130>] class_device_create+0xf7/0x129
   [<ffffffff8097f2ed>] vtconsole_class_init+0x74/0xbb
   [<ffffffff8026d7fc>] init+0x1fc/0x3cd
   [<ffffffff802613dd>] child_rip+0x7/0x12

 ... acquired at:
   [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
   [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
   [<ffffffff802a0314>] __queue_work+0x17/0x5e
   [<ffffffff802a03de>] queue_work+0x4d/0x57
   [<ffffffff802a03fd>] schedule_work+0x15/0x18
   [<ffffffff8824fc31>] orinoco_interrupt+0x4c0/0xf49 [orinoco]
   [<ffffffff8021151f>] handle_IRQ_event+0x2b/0x64
   [<ffffffff802c0987>] __do_IRQ+0xae/0x114
   [<ffffffff8026fca8>] do_IRQ+0xf7/0x107
   [<ffffffff802609c4>] common_interrupt+0x64/0x65

 -> (&list->lock){....} ops: 0 {
    initial-use  at:
                          [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                          [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
                          [<ffffffff80258024>] skb_queue_tail+0x1e/0x49
                          [<ffffffff80259ac6>] netlink_broadcast+0x211/0x2e2
                          [<ffffffff8025af3f>] kobject_uevent+0x3ab/0x42e
                          [<ffffffff803b6ebf>] class_device_add+0x314/0x471
                          [<ffffffff803b7034>] class_device_register+0x18/0x1d
                          [<ffffffff803b7130>] class_device_create+0xf7/0x129
                          [<ffffffff803ff248>] evdev_connect+0xfc/0x121
                          [<ffffffff803fd73a>] input_register_device+0x1e8/0x26d
                          [<ffffffff80400ac5>] atkbd_connect+0x23d/0x26d
                          [<ffffffff803f8861>] serio_connect_driver+0x2c/0x41
                          [<ffffffff803f8890>] serio_driver_probe+0x1a/0x1d
                          [<ffffffff803b5e74>] driver_probe_device+0x5b/0xb1
                          [<ffffffff803b5fde>] __driver_attach+0x88/0xdb
                          [<ffffffff803b5826>] bus_for_each_dev+0x48/0x7a
                          [<ffffffff803b5d9e>] driver_attach+0x1b/0x1e
                          [<ffffffff803b543e>] bus_add_driver+0x88/0x138
                          [<ffffffff803b6289>] driver_register+0x8e/0x93
                          [<ffffffff803f942c>] serio_thread+0x14c/0x2a9
                          [<ffffffff80235436>] kthread+0xff/0x136
                          [<ffffffff802613dd>] child_rip+0x7/0x12
  }
  ... key      at: [<ffffffff80919fb0>] __key.17572+0x0/0x8
 ... acquired at:
   [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
   [<ffffffff80267ba2>] _spin_lock_irqsave+0x2b/0x3c
   [<ffffffff80258024>] skb_queue_tail+0x1e/0x49
   [<ffffffff80259ac6>] netlink_broadcast+0x211/0x2e2
   [<ffffffff804287ea>] wireless_send_event+0x2ff/0x317
   [<ffffffff8824f731>] orinoco_send_wevents+0x4b/0x8b [orinoco]
   [<ffffffff8024f99b>] run_workqueue+0xa7/0xfb
   [<ffffffff8024c17f>] worker_thread+0xee/0x122
   [<ffffffff80235436>] kthread+0xff/0x136
   [<ffffffff802613dd>] child_rip+0x7/0x12


the hard-irq-unsafe lock's dependencies:
-> (af_callback_keys + sk->sk_family){-.--} ops: 0 {
   initial-use  at:
                        [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                        [<ffffffff80267947>] _read_lock+0x27/0x34
                        [<ffffffff802136b0>] sock_def_readable+0x18/0x6f
                        [<ffffffff80259ad6>] netlink_broadcast+0x221/0x2e2
                        [<ffffffff8025af3f>] kobject_uevent+0x3ab/0x42e
                        [<ffffffff803b6ebf>] class_device_add+0x314/0x471
                        [<ffffffff803b7034>] class_device_register+0x18/0x1d
                        [<ffffffff803b7130>] class_device_create+0xf7/0x129
                        [<ffffffff803ff248>] evdev_connect+0xfc/0x121
                        [<ffffffff803fd73a>] input_register_device+0x1e8/0x26d
                        [<ffffffff80400ac5>] atkbd_connect+0x23d/0x26d
                        [<ffffffff803f8861>] serio_connect_driver+0x2c/0x41
                        [<ffffffff803f8890>] serio_driver_probe+0x1a/0x1d
                        [<ffffffff803b5e74>] driver_probe_device+0x5b/0xb1
                        [<ffffffff803b5fde>] __driver_attach+0x88/0xdb
                        [<ffffffff803b5826>] bus_for_each_dev+0x48/0x7a
                        [<ffffffff803b5d9e>] driver_attach+0x1b/0x1e
                        [<ffffffff803b543e>] bus_add_driver+0x88/0x138
                        [<ffffffff803b6289>] driver_register+0x8e/0x93
                        [<ffffffff803f942c>] serio_thread+0x14c/0x2a9
                        [<ffffffff80235436>] kthread+0xff/0x136
                        [<ffffffff802613dd>] child_rip+0x7/0x12
   hardirq-on-W at:
                        [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                        [<ffffffff80267867>] _write_lock_bh+0x29/0x36
                        [<ffffffff80433960>] netlink_release+0x139/0x2ca
                        [<ffffffff80257903>] sock_release+0x19/0x9b
                        [<ffffffff80257b13>] sock_close+0x33/0x3a
                        [<ffffffff802130ee>] __fput+0xc6/0x1a8
                        [<ffffffff8022effe>] fput+0x13/0x16
                        [<ffffffff80225383>] filp_close+0x64/0x70
                        [<ffffffff8021eecc>] sys_close+0x93/0xb0
                        [<ffffffff8026048d>] system_call+0x7d/0x83
   softirq-on-R at:
                        [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                        [<ffffffff80267947>] _read_lock+0x27/0x34
                        [<ffffffff802136b0>] sock_def_readable+0x18/0x6f
                        [<ffffffff80259ad6>] netlink_broadcast+0x221/0x2e2
                        [<ffffffff8025af3f>] kobject_uevent+0x3ab/0x42e
                        [<ffffffff803b6ebf>] class_device_add+0x314/0x471
                        [<ffffffff803b7034>] class_device_register+0x18/0x1d
                        [<ffffffff803b7130>] class_device_create+0xf7/0x129
                        [<ffffffff803ff248>] evdev_connect+0xfc/0x121
                        [<ffffffff803fd73a>] input_register_device+0x1e8/0x26d
                        [<ffffffff80400ac5>] atkbd_connect+0x23d/0x26d
                        [<ffffffff803f8861>] serio_connect_driver+0x2c/0x41
                        [<ffffffff803f8890>] serio_driver_probe+0x1a/0x1d
                        [<ffffffff803b5e74>] driver_probe_device+0x5b/0xb1
                        [<ffffffff803b5fde>] __driver_attach+0x88/0xdb
                        [<ffffffff803b5826>] bus_for_each_dev+0x48/0x7a
                        [<ffffffff803b5d9e>] driver_attach+0x1b/0x1e
                        [<ffffffff803b543e>] bus_add_driver+0x88/0x138
                        [<ffffffff803b6289>] driver_register+0x8e/0x93
                        [<ffffffff803f942c>] serio_thread+0x14c/0x2a9
                        [<ffffffff80235436>] kthread+0xff/0x136
                        [<ffffffff802613dd>] child_rip+0x7/0x12
   hardirq-on-R at:
                        [<ffffffff802a8e62>] lock_acquire+0x4a/0x69
                        [<ffffffff80267947>] _read_lock+0x27/0x34
                        [<ffffffff802136b0>] sock_def_readable+0x18/0x6f
                        [<ffffffff80259ad6>] netlink_broadcast+0x221/0x2e2
                        [<ffffffff8025af3f>] kobject_uevent+0x3ab/0x42e
                        [<ffffffff803b6ebf>] class_device_add+0x314/0x471
                        [<ffffffff803b7034>] class_device_register+0x18/0x1d
                        [<ffffffff803b7130>] class_device_create+0xf7/0x129
                        [<ffffffff803ff248>] evdev_connect+0xfc/0x121
                        [<ffffffff803fd73a>] input_register_device+0x1e8/0x26d
                        [<ffffffff80400ac5>] atkbd_connect+0x23d/0x26d
                        [<ffffffff803f8861>] serio_connect_driver+0x2c/0x41
                        [<ffffffff803f8890>] serio_driver_probe+0x1a/0x1d
                        [<ffffffff803b5e74>] driver_probe_device+0x5b/0xb1
                        [<ffffffff803b5fde>] __driver_attach+0x88/0xdb
                        [<ffffffff803b5826>] bus_for_each_dev+0x48/0x7a
                        [<ffffffff803b5d9e>] driver_attach+0x1b/0x1e
                        [<ffffffff803b543e>] bus_add_driver+0x88/0x138
                        [<ffffffff803b6289>] driver_register+0x8e/0x93
                        [<ffffffff803f942c>] serio_thread+0x14c/0x2a9
                        [<ffffffff80235436>] kthread+0xff/0x136
                        [<ffffffff802613dd>] child_rip+0x7/0x12
 }
 ... key      at: [<ffffffff8091a280>] af_callback_keys+0x80/0x100

stack backtrace:

Call Trace:
 [<ffffffff8026e7fd>] show_trace+0xae/0x30e
 [<ffffffff8026ea72>] dump_stack+0x15/0x17
 [<ffffffff802a7dc1>] check_usage+0x27d/0x28e
 [<ffffffff802a86e6>] __lock_acquire+0x878/0xa54
 [<ffffffff802a8e63>] lock_acquire+0x4b/0x69
 [<ffffffff80267948>] _read_lock+0x28/0x34
 [<ffffffff802136b1>] sock_def_readable+0x19/0x6f
 [<ffffffff80259ad7>] netlink_broadcast+0x222/0x2e2
 [<ffffffff804287eb>] wireless_send_event+0x300/0x317
 [<ffffffff8824f732>] :orinoco:orinoco_send_wevents+0x4c/0x8b
 [<ffffffff8024f99c>] run_workqueue+0xa8/0xfb
 [<ffffffff8024c180>] worker_thread+0xef/0x122
 [<ffffffff80235437>] kthread+0x100/0x136
 [<ffffffff802613de>] child_rip+0x8/0x12
DWARF2 unwinder stuck at child_rip+0x8/0x12
Leftover inexact backtrace:
 [<ffffffff80267ab2>] _spin_unlock_irq+0x2b/0x31
 [<ffffffff80260a1b>] restore_args+0x0/0x30
 [<ffffffff80235337>] kthread+0x0/0x136
 [<ffffffff802613d6>] child_rip+0x0/0x12

eth1: New link status: Connected (0001)
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready

-- 
http://www.codemonkey.org.uk

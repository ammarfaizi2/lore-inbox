Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWGMU6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWGMU6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWGMU6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:58:54 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:6620 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030387AbWGMU6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:58:52 -0400
To: linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
Cc: Michael Buesch <mb@bu3sch.de>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: lockdep problem in bcm43xx
From: Peter Osterlund <petero2@telia.com>
Date: 13 Jul 2006 22:58:35 +0200
Message-ID: <m3psg95iis.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When starting wpa_supplicant, I get the following warning from the
lock validator:

bcm43xx: PHY connected
bcm43xx: Radio turned on
bcm43xx: Chip initialized
bcm43xx: DMA initialized
bcm43xx: 80211 cores initialized
bcm43xx: Keys cleared
bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
SoftMAC: Open Authentication completed with 00:16:b6:b7:64:b8

======================================================
[ INFO: hard-safe -> hard-unsafe lock order detected ]
------------------------------------------------------
swapper/0 [HC0[0]:SC1[1]:HE0:SE0] is trying to acquire:
 (af_callback_keys + sk->sk_family){-.-?}, at: [<c02db321>] sock_def_readable+0x19/0x7d

and this task is already holding:
 (&softmac->lock){.+..}, at: [<e08af6ff>] ieee80211softmac_call_events+0x16/0x3f [ieee80211softmac]
which would create a new lock dependency:
 (&softmac->lock){.+..} -> (af_callback_keys + sk->sk_family){-.-?}

but this new dependency connects a hard-irq-safe lock:
 (&bcm->irq_lock){++..}
... which became hard-irq-safe at:
  [<c013535e>] lock_acquire+0x68/0x83
  [<c0340c28>] _spin_lock+0x45/0x53
  [<e08ff2c0>] bcm43xx_interrupt_handler+0x1d/0x1c4 [bcm43xx]
  [<c0142a9d>] handle_IRQ_event+0x31/0x62
  [<c0142b5f>] __do_IRQ+0x91/0x10d
  [<c0105a34>] do_IRQ+0x48/0xa4
  [<c0103ad5>] common_interrupt+0x25/0x2c
  [<e08aedfa>] ieee80211softmac_assoc_work+0x47/0x55f [ieee80211softmac]
  [<c012af5c>] run_workqueue+0x7a/0xf3
  [<c012b693>] worker_thread+0x13b/0x158
  [<c012e132>] kthread+0xe3/0xe7
  [<c0101005>] kernel_thread_helper+0x5/0xb

to a hard-irq-unsafe lock:
 (af_callback_keys + sk->sk_family){-.-?}
... which became hard-irq-unsafe at:
...  [<c013535e>] lock_acquire+0x68/0x83
  [<c0340d2b>] _write_lock_bh+0x4a/0x58
  [<c02f3577>] netlink_release+0xe1/0x30d
  [<c02d7c93>] sock_release+0x1d/0xe3
  [<c02d80d1>] sock_close+0x34/0x50
  [<c0163d59>] __fput+0x62/0x193
  [<c0163ee2>] fput+0x18/0x1a
  [<c01613d0>] filp_close+0x4e/0x74
  [<c016287b>] sys_close+0x73/0x8f
  [<c0103069>] sysenter_past_esp+0x56/0x8d

other info that might help us debug this:

2 locks held by swapper/0:
 #0:  (&bcm->irq_lock){++..}, at: [<e090477e>] bcm43xx_interrupt_tasklet+0x17/0xacc [bcm43xx]
 #1:  (&softmac->lock){.+..}, at: [<e08af6ff>] ieee80211softmac_call_events+0x16/0x3f [ieee80211softmac]

the hard-irq-safe lock's dependencies:
-> (&bcm->irq_lock){++..} ops: 301 {
   initial-use  at:
                        [<c013535e>] lock_acquire+0x68/0x83
                        [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                        [<e0916af2>] bcm43xx_wx_set_mode+0x41/0x96 [bcm43xx]
                        [<c02ed91d>] ioctl_standard_call+0x68/0x2f3
                        [<c02ee1b8>] wireless_process_ioctl+0x36e/0x428
                        [<c02e334b>] dev_ioctl+0x235/0x3b3
                        [<c02d70fb>] sock_ioctl+0x3c/0x24a
                        [<c017542a>] do_ioctl+0x2a/0x80
                        [<c01754d6>] vfs_ioctl+0x56/0x2bc
                        [<c0175777>] sys_ioctl+0x3b/0x58
                        [<c0103069>] sysenter_past_esp+0x56/0x8d
   in-hardirq-W at:
                        [<c013535e>] lock_acquire+0x68/0x83
                        [<c0340c28>] _spin_lock+0x45/0x53
                        [<e08ff2c0>] bcm43xx_interrupt_handler+0x1d/0x1c4 [bcm43xx]
                        [<c0142a9d>] handle_IRQ_event+0x31/0x62
                        [<c0142b5f>] __do_IRQ+0x91/0x10d
                        [<c0105a34>] do_IRQ+0x48/0xa4
                        [<c0103ad5>] common_interrupt+0x25/0x2c
                        [<e08aedfa>] ieee80211softmac_assoc_work+0x47/0x55f [ieee80211softmac]
                        [<c012af5c>] run_workqueue+0x7a/0xf3
                        [<c012b693>] worker_thread+0x13b/0x158
                        [<c012e132>] kthread+0xe3/0xe7
                        [<c0101005>] kernel_thread_helper+0x5/0xb
   in-softirq-W at:
                        [<c013535e>] lock_acquire+0x68/0x83
                        [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                        [<e090477e>] bcm43xx_interrupt_tasklet+0x17/0xacc [bcm43xx]
                        [<c0120390>] tasklet_action+0x48/0x87
                        [<c012029d>] __do_softirq+0x63/0xc1
                        [<c0120346>] do_softirq+0x4b/0x4d
                        [<c01205a7>] irq_exit+0x4c/0x4e
                        [<c0105a39>] do_IRQ+0x4d/0xa4
                        [<c0103ad5>] common_interrupt+0x25/0x2c
                        [<e08aedfa>] ieee80211softmac_assoc_work+0x47/0x55f [ieee80211softmac]
                        [<c012af5c>] run_workqueue+0x7a/0xf3
                        [<c012b693>] worker_thread+0x13b/0x158
                        [<c012e132>] kthread+0xe3/0xe7
                        [<c0101005>] kernel_thread_helper+0x5/0xb
 }
 ... key      at: [<e092a908>] __key.24190+0x0/0xffff3d45 [bcm43xx]
 -> (&rq->rq_lock_key){++..} ops: 146391 {
    initial-use  at:
                          [<c013535e>] lock_acquire+0x68/0x83
                          [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                          [<c0116ba2>] init_idle+0x4b/0x70
                          [<c04b38c3>] sched_init+0xde/0xe6
                          [<c04a650a>] start_kernel+0x62/0x378
                          [<c0100199>] 0xc0100199
    in-hardirq-W at:
                          [<c013535e>] lock_acquire+0x68/0x83
                          [<c0340c28>] _spin_lock+0x45/0x53
                          [<c0116c7e>] scheduler_tick+0xb7/0x300
                          [<c0124c35>] update_process_times+0x52/0x7c
                          [<c0106c1b>] timer_interrupt+0x4a/0xaf
                          [<c0142a9d>] handle_IRQ_event+0x31/0x62
                          [<c0142b5f>] __do_IRQ+0x91/0x10d
                          [<c0105a34>] do_IRQ+0x48/0xa4
                          [<c0103ad5>] common_interrupt+0x25/0x2c
                          [<c0107683>] enable_8259A_irq+0x50/0x53
                          [<c04b245a>] setup_IO_APIC+0xd6c/0x1265
                          [<c04b09d9>] APIC_init_uniprocessor+0x98/0xea
                          [<c0100287>] init+0x2b/0x282
                          [<c0101005>] kernel_thread_helper+0x5/0xb
    in-softirq-W at:
                          [<c013535e>] lock_acquire+0x68/0x83
                          [<c0340c28>] _spin_lock+0x45/0x53
                          [<c01171e2>] task_rq_lock+0x17/0x1e
                          [<c0117304>] try_to_wake_up+0x18/0x118
                          [<c0117435>] wake_up_process+0xf/0x11
                          [<c0123fb2>] process_timeout+0xb/0xd
                          [<c0123e47>] run_timer_softirq+0x149/0x16d
                          [<c012029d>] __do_softirq+0x63/0xc1
                          [<c0120346>] do_softirq+0x4b/0x4d
                          [<c01205a7>] irq_exit+0x4c/0x4e
                          [<c0105a39>] do_IRQ+0x4d/0xa4
                          [<c0103ad5>] common_interrupt+0x25/0x2c
                          [<c0101a8b>] cpu_idle+0x41/0x6a
                          [<c0100523>] rest_init+0x45/0x52
                          [<c04a6777>] start_kernel+0x2cf/0x378
                          [<c0100199>] 0xc0100199
  }
  ... key      at: [<c04ddd54>] per_cpu__runqueues+0x954/0x95c
 ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340c28>] _spin_lock+0x45/0x53
   [<c01171e2>] task_rq_lock+0x17/0x1e
   [<c0117304>] try_to_wake_up+0x18/0x118
   [<c0117435>] wake_up_process+0xf/0x11
   [<c01200c6>] raise_softirq_irqoff+0x44/0x47
   [<c02e1b9c>] __netif_schedule+0x37/0x55
   [<e0905b1d>] bcm43xx_periodic_work_handler+0x326/0x506 [bcm43xx]
   [<c012af5c>] run_workqueue+0x7a/0xf3
   [<c012b693>] worker_thread+0x13b/0x158
   [<c012e132>] kthread+0xe3/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

 -> (&ieee->lock){.+..} ops: 87 {
    initial-use  at:
                          [<c013535e>] lock_acquire+0x68/0x83
                          [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                          [<e08ffd4e>] bcm43xx_set_iwmode+0x21/0x155 [bcm43xx]
                          [<e0900e0b>] bcm43xx_chip_init+0x7eb/0xaf6 [bcm43xx]
                          [<e0902db3>] bcm43xx_init_board+0x164/0xea9 [bcm43xx]
                          [<e0904451>] bcm43xx_net_open+0x10/0x12 [bcm43xx]
                          [<c02e2fcd>] dev_open+0x3c/0x7e
                          [<c02e160c>] dev_change_flags+0x55/0x123
                          [<c0321f65>] devinet_ioctl+0x49d/0x685
                          [<c0322831>] inet_ioctl+0x7b/0x95
                          [<c02d7208>] sock_ioctl+0x149/0x24a
                          [<c017542a>] do_ioctl+0x2a/0x80
                          [<c01754d6>] vfs_ioctl+0x56/0x2bc
                          [<c0175777>] sys_ioctl+0x3b/0x58
                          [<c0103069>] sysenter_past_esp+0x56/0x8d
    in-softirq-W at:
                          [<c013535e>] lock_acquire+0x68/0x83
                          [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                          [<e08a5186>] ieee80211_process_probe_response+0x212/0x736 [ieee80211]
                          [<e08a5750>] ieee80211_rx_mgt+0xa6/0x348 [ieee80211]
                          [<e09191d8>] bcm43xx_rx+0x331/0x949 [bcm43xx]
                          [<e091ca27>] bcm43xx_dma_rx+0x171/0x555 [bcm43xx]
                          [<e0904b85>] bcm43xx_interrupt_tasklet+0x41e/0xacc [bcm43xx]
                          [<c0120390>] tasklet_action+0x48/0x87
                          [<c012029d>] __do_softirq+0x63/0xc1
                          [<c0120346>] do_softirq+0x4b/0x4d
                          [<c01205a7>] irq_exit+0x4c/0x4e
                          [<c0105a39>] do_IRQ+0x4d/0xa4
                          [<c0103ad5>] common_interrupt+0x25/0x2c
                          [<c02382fd>] acpi_processor_idle+0x14c/0x357
                          [<c0101a8b>] cpu_idle+0x41/0x6a
                          [<c0100523>] rest_init+0x45/0x52
                          [<c04a6777>] start_kernel+0x2cf/0x378
                          [<c0100199>] 0xc0100199
  }
  ... key      at: [<e08aa841>] __key.23520+0x0/0xffffdb18 [ieee80211]
  -> (&softmac->lock){.+..} ops: 93 {
     initial-use  at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                            [<e08aede6>] ieee80211softmac_assoc_work+0x33/0x55f [ieee80211softmac]
                            [<c012af5c>] run_workqueue+0x7a/0xf3
                            [<c012b693>] worker_thread+0x13b/0x158
                            [<c012e132>] kthread+0xe3/0xe7
                            [<c0101005>] kernel_thread_helper+0x5/0xb
     in-softirq-W at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                            [<e08ac902>] ieee80211softmac_auth_resp+0x32/0x5e5 [ieee80211softmac]
                            [<e08a57aa>] ieee80211_rx_mgt+0x100/0x348 [ieee80211]
                            [<e09191d8>] bcm43xx_rx+0x331/0x949 [bcm43xx]
                            [<e091ca27>] bcm43xx_dma_rx+0x171/0x555 [bcm43xx]
                            [<e0904b85>] bcm43xx_interrupt_tasklet+0x41e/0xacc [bcm43xx]
                            [<c0120390>] tasklet_action+0x48/0x87
                            [<c012029d>] __do_softirq+0x63/0xc1
                            [<c0120346>] do_softirq+0x4b/0x4d
                            [<c01205a7>] irq_exit+0x4c/0x4e
                            [<c0105a39>] do_IRQ+0x4d/0xa4
                            [<c0103ad5>] common_interrupt+0x25/0x2c
                            [<c0101a8b>] cpu_idle+0x41/0x6a
                            [<c0100523>] rest_init+0x45/0x52
                            [<c04a6777>] start_kernel+0x2cf/0x378
                            [<c0100199>] 0xc0100199
   }
   ... key      at: [<e08b2e00>] __key.19206+0x0/0xffffcac7 [ieee80211softmac]
   -> (&cwq->lock){++..} ops: 3534 {
      initial-use  at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c012ad78>] __queue_work+0x12/0x59
                              [<c012b450>] queue_work+0x55/0x71
                              [<c012aa1b>] call_usermodehelper_keys+0xcb/0xe0
                              [<c01edffe>] kobject_uevent+0x3a1/0x4a3
                              [<c0261ca0>] class_device_add+0x40f/0x4c8
                              [<c0261d73>] class_device_register+0x1a/0x20
                              [<c0261e17>] class_device_create+0x9e/0xc1
                              [<c04bb9ef>] vtconsole_class_init+0x7a/0xe0
                              [<c01002d6>] init+0x7a/0x282
                              [<c0101005>] kernel_thread_helper+0x5/0xb
      in-hardirq-W at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c012ad78>] __queue_work+0x12/0x59
                              [<c012b450>] queue_work+0x55/0x71
                              [<c012b47b>] schedule_work+0xf/0x11
                              [<c024d540>] schedule_console_callback+0xd/0xf
                              [<c024b1e8>] kbd_event+0x47/0x5df
                              [<c028d0fb>] input_event+0xe4/0x497
                              [<c02918e6>] atkbd_interrupt+0x11e/0x698
                              [<c0289d2f>] serio_interrupt+0x44/0x7e
                              [<c028ab37>] i8042_interrupt+0x11a/0x216
                              [<c0142a9d>] handle_IRQ_event+0x31/0x62
                              [<c0142b5f>] __do_IRQ+0x91/0x10d
                              [<c0105a34>] do_IRQ+0x48/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c0101a8b>] cpu_idle+0x41/0x6a
                              [<c0100523>] rest_init+0x45/0x52
                              [<c04a6777>] start_kernel+0x2cf/0x378
                              [<c0100199>] 0xc0100199
      in-softirq-W at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c012ad78>] __queue_work+0x12/0x59
                              [<c012add8>] delayed_work_timer_fn+0x19/0x1d
                              [<c0123e47>] run_timer_softirq+0x149/0x16d
                              [<c012029d>] __do_softirq+0x63/0xc1
                              [<c0120346>] do_softirq+0x4b/0x4d
                              [<c01205a7>] irq_exit+0x4c/0x4e
                              [<c0105a39>] do_IRQ+0x4d/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c0101a8b>] cpu_idle+0x41/0x6a
                              [<c0100523>] rest_init+0x45/0x52
                              [<c04a6777>] start_kernel+0x2cf/0x378
                              [<c0100199>] 0xc0100199
    }
    ... key      at: [<c0500270>] __key.9034+0x0/0x8
    -> (&q->lock){++..} ops: 31205 {
       initial-use  at:
                                [<c013535e>] lock_acquire+0x68/0x83
                                [<c0340ee7>] _spin_lock_irq+0x4b/0x59
                                [<c033e740>] wait_for_completion+0x28/0xae
                                [<c012e007>] keventd_create_kthread+0x31/0x79
                                [<c012e20b>] kthread_create+0xd5/0xd7
                                [<c012002d>] cpu_callback+0x69/0xbe
                                [<c04b3ff0>] spawn_ksoftirqd+0x26/0x46
                                [<c010027d>] init+0x21/0x282
                                [<c0101005>] kernel_thread_helper+0x5/0xb
       in-hardirq-W at:
                                [<c013535e>] lock_acquire+0x68/0x83
                                [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                                [<c01169a9>] __wake_up+0x15/0x42
                                [<c0231c91>] acpi_ec_gpe_handler+0x93/0xd6
                                [<c0212d05>] acpi_ev_gpe_dispatch+0x8e/0x1a1
                                [<c0212ef1>] acpi_ev_gpe_detect+0xd9/0x128
                                [<c0210878>] acpi_ev_sci_xrupt_handler+0x29/0x47
                                [<c0208757>] acpi_irq+0xf/0x1a
                                [<c0142a9d>] handle_IRQ_event+0x31/0x62
                                [<c0142b5f>] __do_IRQ+0x91/0x10d
                                [<c0105a34>] do_IRQ+0x48/0xa4
                                [<c0103ad5>] common_interrupt+0x25/0x2c
                                [<c012c03a>] rcu_process_callbacks+0x12/0x23
                                [<c0120390>] tasklet_action+0x48/0x87
                                [<c012029d>] __do_softirq+0x63/0xc1
                                [<c0120346>] do_softirq+0x4b/0x4d
                                [<c01205a7>] irq_exit+0x4c/0x4e
                                [<c0105a39>] do_IRQ+0x4d/0xa4
                                [<c0103ad5>] common_interrupt+0x25/0x2c
                                [<c0101a8b>] cpu_idle+0x41/0x6a
                                [<c0100523>] rest_init+0x45/0x52
                                [<c04a6777>] start_kernel+0x2cf/0x378
                                [<c0100199>] 0xc0100199
       in-softirq-W at:
                                [<c013535e>] lock_acquire+0x68/0x83
                                [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                                [<c01169a9>] __wake_up+0x15/0x42
                                [<c0231c91>] acpi_ec_gpe_handler+0x93/0xd6
                                [<c0212d05>] acpi_ev_gpe_dispatch+0x8e/0x1a1
                                [<c0212ef1>] acpi_ev_gpe_detect+0xd9/0x128
                                [<c0210878>] acpi_ev_sci_xrupt_handler+0x29/0x47
                                [<c0208757>] acpi_irq+0xf/0x1a
                                [<c0142a9d>] handle_IRQ_event+0x31/0x62
                                [<c0142b5f>] __do_IRQ+0x91/0x10d
                                [<c0105a34>] do_IRQ+0x48/0xa4
                                [<c0103ad5>] common_interrupt+0x25/0x2c
                                [<c012c03a>] rcu_process_callbacks+0x12/0x23
                                [<c0120390>] tasklet_action+0x48/0x87
                                [<c012029d>] __do_softirq+0x63/0xc1
                                [<c0120346>] do_softirq+0x4b/0x4d
                                [<c01205a7>] irq_exit+0x4c/0x4e
                                [<c0105a39>] do_IRQ+0x4d/0xa4
                                [<c0103ad5>] common_interrupt+0x25/0x2c
                                [<c0101a8b>] cpu_idle+0x41/0x6a
                                [<c0100523>] rest_init+0x45/0x52
                                [<c04a6777>] start_kernel+0x2cf/0x378
                                [<c0100199>] 0xc0100199
     }
     ... key      at: [<c050067c>] __key.12788+0x0/0x8
     -> (&rq->rq_lock_key){++..} ops: 146391 {
        initial-use  at:
                                  [<c013535e>] lock_acquire+0x68/0x83
                                  [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                                  [<c0116ba2>] init_idle+0x4b/0x70
                                  [<c04b38c3>] sched_init+0xde/0xe6
                                  [<c04a650a>] start_kernel+0x62/0x378
                                  [<c0100199>] 0xc0100199
        in-hardirq-W at:
                                  [<c013535e>] lock_acquire+0x68/0x83
                                  [<c0340c28>] _spin_lock+0x45/0x53
                                  [<c0116c7e>] scheduler_tick+0xb7/0x300
                                  [<c0124c35>] update_process_times+0x52/0x7c
                                  [<c0106c1b>] timer_interrupt+0x4a/0xaf
                                  [<c0142a9d>] handle_IRQ_event+0x31/0x62
                                  [<c0142b5f>] __do_IRQ+0x91/0x10d
                                  [<c0105a34>] do_IRQ+0x48/0xa4
                                  [<c0103ad5>] common_interrupt+0x25/0x2c
                                  [<c0107683>] enable_8259A_irq+0x50/0x53
                                  [<c04b245a>] setup_IO_APIC+0xd6c/0x1265
                                  [<c04b09d9>] APIC_init_uniprocessor+0x98/0xea
                                  [<c0100287>] init+0x2b/0x282
                                  [<c0101005>] kernel_thread_helper+0x5/0xb
        in-softirq-W at:
                                  [<c013535e>] lock_acquire+0x68/0x83
                                  [<c0340c28>] _spin_lock+0x45/0x53
                                  [<c01171e2>] task_rq_lock+0x17/0x1e
                                  [<c0117304>] try_to_wake_up+0x18/0x118
                                  [<c0117435>] wake_up_process+0xf/0x11
                                  [<c0123fb2>] process_timeout+0xb/0xd
                                  [<c0123e47>] run_timer_softirq+0x149/0x16d
                                  [<c012029d>] __do_softirq+0x63/0xc1
                                  [<c0120346>] do_softirq+0x4b/0x4d
                                  [<c01205a7>] irq_exit+0x4c/0x4e
                                  [<c0105a39>] do_IRQ+0x4d/0xa4
                                  [<c0103ad5>] common_interrupt+0x25/0x2c
                                  [<c0101a8b>] cpu_idle+0x41/0x6a
                                  [<c0100523>] rest_init+0x45/0x52
                                  [<c04a6777>] start_kernel+0x2cf/0x378
                                  [<c0100199>] 0xc0100199
      }
      ... key      at: [<c04ddd54>] per_cpu__runqueues+0x954/0x95c
     ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340c28>] _spin_lock+0x45/0x53
   [<c01171e2>] task_rq_lock+0x17/0x1e
   [<c0117304>] try_to_wake_up+0x18/0x118
   [<c0117418>] default_wake_function+0x14/0x16
   [<c011660a>] __wake_up_common+0x42/0x61
   [<c0116939>] complete+0x3a/0x4b
   [<c012e0f6>] kthread+0xa7/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

    ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c01169a9>] __wake_up+0x15/0x42
   [<c012adae>] __queue_work+0x48/0x59
   [<c012b450>] queue_work+0x55/0x71
   [<c012aa1b>] call_usermodehelper_keys+0xcb/0xe0
   [<c01edffe>] kobject_uevent+0x3a1/0x4a3
   [<c0261ca0>] class_device_add+0x40f/0x4c8
   [<c0261d73>] class_device_register+0x1a/0x20
   [<c0261e17>] class_device_create+0x9e/0xc1
   [<c04bb9ef>] vtconsole_class_init+0x7a/0xe0
   [<c01002d6>] init+0x7a/0x282
   [<c0101005>] kernel_thread_helper+0x5/0xb

   ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c012ad78>] __queue_work+0x12/0x59
   [<c012b450>] queue_work+0x55/0x71
   [<c012b47b>] schedule_work+0xf/0x11
   [<e08ae199>] ieee80211softmac_start_scan_implementation+0xa5/0x125 [ieee80211softmac]
   [<e08ae0bd>] ieee80211softmac_start_scan+0x6d/0xa4 [ieee80211softmac]
   [<e08ae379>] ieee80211softmac_wx_trigger_scan+0x16/0x18 [ieee80211softmac]
   [<c02eda1e>] ioctl_standard_call+0x169/0x2f3
   [<c02ee1b8>] wireless_process_ioctl+0x36e/0x428
   [<c02e334b>] dev_ioctl+0x235/0x3b3
   [<c02d70fb>] sock_ioctl+0x3c/0x24a
   [<c017542a>] do_ioctl+0x2a/0x80
   [<c01754d6>] vfs_ioctl+0x56/0x2bc
   [<c0175777>] sys_ioctl+0x3b/0x58
   [<c0103069>] sysenter_past_esp+0x56/0x8d

   -> (base_lock_keys + cpu){++..} ops: 61512 {
      initial-use  at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c01249ef>] lock_timer_base+0x18/0x33
                              [<c0124a83>] __mod_timer+0x1d/0x9e
                              [<c0124b6b>] mod_timer+0x24/0x3c
                              [<c04bb942>] con_init+0x21c/0x24f
                              [<c04bafe2>] console_init+0x2b/0x3c
                              [<c04a65d0>] start_kernel+0x128/0x378
                              [<c0100199>] 0xc0100199
      in-hardirq-W at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c01249ef>] lock_timer_base+0x18/0x33
                              [<c0124a30>] del_timer+0x26/0x5c
                              [<c026b1c1>] ide_intr+0x72/0x1db
                              [<c0142a9d>] handle_IRQ_event+0x31/0x62
                              [<c0142b5f>] __do_IRQ+0x91/0x10d
                              [<c0105a34>] do_IRQ+0x48/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c0101a8b>] cpu_idle+0x41/0x6a
                              [<c0100523>] rest_init+0x45/0x52
                              [<c04a6777>] start_kernel+0x2cf/0x378
                              [<c0100199>] 0xc0100199
      in-softirq-W at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340ee7>] _spin_lock_irq+0x4b/0x59
                              [<c0123d27>] run_timer_softirq+0x29/0x16d
                              [<c012029d>] __do_softirq+0x63/0xc1
                              [<c0120346>] do_softirq+0x4b/0x4d
                              [<c01205a7>] irq_exit+0x4c/0x4e
                              [<c0105a39>] do_IRQ+0x4d/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c011b69d>] register_console+0xc4/0x1fb
                              [<c04bb8d9>] con_init+0x1b3/0x24f
                              [<c04bafe2>] console_init+0x2b/0x3c
                              [<c04a65d0>] start_kernel+0x128/0x378
                              [<c0100199>] 0xc0100199
    }
    ... key      at: [<c04ffa30>] base_lock_keys+0x0/0x10
   ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c01249ef>] lock_timer_base+0x18/0x33
   [<c0124a83>] __mod_timer+0x1d/0x9e
   [<c012b3bb>] queue_delayed_work+0x5f/0x8c
   [<c012b3f9>] schedule_delayed_work+0x11/0x13
   [<e08adfa2>] ieee80211softmac_scan+0xac/0x15a [ieee80211softmac]
   [<c012af5c>] run_workqueue+0x7a/0xf3
   [<c012b693>] worker_thread+0x13b/0x158
   [<c012e132>] kthread+0xe3/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

   -> (&skb_queue_lock_key){.+..} ops: 1772 {
      initial-use  at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c02dc04a>] skb_queue_tail+0x16/0x35
                              [<c02f201d>] netlink_broadcast+0x290/0x338
                              [<c01edfb7>] kobject_uevent+0x35a/0x4a3
                              [<c01691e2>] bdev_uevent+0x29/0x3c
                              [<c016a242>] get_sb_bdev+0x149/0x16c
                              [<c01a7bd5>] ext3_get_sb+0x35/0x37
                              [<c0169ce7>] vfs_kern_mount+0x42/0x8c
                              [<c0169d95>] do_kern_mount+0x3b/0x4e
                              [<c017fb6c>] do_mount+0x257/0x6a0
                              [<c018004a>] sys_mount+0x95/0xd4
                              [<c01030e7>] syscall_call+0x7/0xb
      in-softirq-W at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c02dc04a>] skb_queue_tail+0x16/0x35
                              [<c02f201d>] netlink_broadcast+0x290/0x338
                              [<c02ed21e>] wireless_send_event+0x2e2/0x343
                              [<e08af660>] ieee80211softmac_call_events_locked+0xa0/0x129 [ieee80211softmac]
                              [<e08af717>] ieee80211softmac_call_events+0x2e/0x3f [ieee80211softmac]
                              [<e08aca7f>] ieee80211softmac_auth_resp+0x1af/0x5e5 [ieee80211softmac]
                              [<e08a57aa>] ieee80211_rx_mgt+0x100/0x348 [ieee80211]
                              [<e09191d8>] bcm43xx_rx+0x331/0x949 [bcm43xx]
                              [<e091ca27>] bcm43xx_dma_rx+0x171/0x555 [bcm43xx]
                              [<e0904b85>] bcm43xx_interrupt_tasklet+0x41e/0xacc [bcm43xx]
                              [<c0120390>] tasklet_action+0x48/0x87
                              [<c012029d>] __do_softirq+0x63/0xc1
                              [<c0120346>] do_softirq+0x4b/0x4d
                              [<c01205a7>] irq_exit+0x4c/0x4e
                              [<c0105a39>] do_IRQ+0x4d/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c0101a8b>] cpu_idle+0x41/0x6a
                              [<c0100523>] rest_init+0x45/0x52
                              [<c04a6777>] start_kernel+0x2cf/0x378
                              [<c0100199>] 0xc0100199
    }
    ... key      at: [<c0644628>] skb_queue_lock_key+0x0/0x18
   ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c02dc04a>] skb_queue_tail+0x16/0x35
   [<c02f201d>] netlink_broadcast+0x290/0x338
   [<c02ed21e>] wireless_send_event+0x2e2/0x343
   [<e08af660>] ieee80211softmac_call_events_locked+0xa0/0x129 [ieee80211softmac]
   [<e08af717>] ieee80211softmac_call_events+0x2e/0x3f [ieee80211softmac]
   [<e08ade62>] ieee80211softmac_scan_finished+0x5a/0x8c [ieee80211softmac]
   [<e08adfe6>] ieee80211softmac_scan+0xf0/0x15a [ieee80211softmac]
   [<c012af5c>] run_workqueue+0x7a/0xf3
   [<c012b693>] worker_thread+0x13b/0x158
   [<c012e132>] kthread+0xe3/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

   -> (&q->lock){++..} ops: 31205 {
      initial-use  at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340ee7>] _spin_lock_irq+0x4b/0x59
                              [<c033e740>] wait_for_completion+0x28/0xae
                              [<c012e007>] keventd_create_kthread+0x31/0x79
                              [<c012e20b>] kthread_create+0xd5/0xd7
                              [<c012002d>] cpu_callback+0x69/0xbe
                              [<c04b3ff0>] spawn_ksoftirqd+0x26/0x46
                              [<c010027d>] init+0x21/0x282
                              [<c0101005>] kernel_thread_helper+0x5/0xb
      in-hardirq-W at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c01169a9>] __wake_up+0x15/0x42
                              [<c0231c91>] acpi_ec_gpe_handler+0x93/0xd6
                              [<c0212d05>] acpi_ev_gpe_dispatch+0x8e/0x1a1
                              [<c0212ef1>] acpi_ev_gpe_detect+0xd9/0x128
                              [<c0210878>] acpi_ev_sci_xrupt_handler+0x29/0x47
                              [<c0208757>] acpi_irq+0xf/0x1a
                              [<c0142a9d>] handle_IRQ_event+0x31/0x62
                              [<c0142b5f>] __do_IRQ+0x91/0x10d
                              [<c0105a34>] do_IRQ+0x48/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c012c03a>] rcu_process_callbacks+0x12/0x23
                              [<c0120390>] tasklet_action+0x48/0x87
                              [<c012029d>] __do_softirq+0x63/0xc1
                              [<c0120346>] do_softirq+0x4b/0x4d
                              [<c01205a7>] irq_exit+0x4c/0x4e
                              [<c0105a39>] do_IRQ+0x4d/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c0101a8b>] cpu_idle+0x41/0x6a
                              [<c0100523>] rest_init+0x45/0x52
                              [<c04a6777>] start_kernel+0x2cf/0x378
                              [<c0100199>] 0xc0100199
      in-softirq-W at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c01169a9>] __wake_up+0x15/0x42
                              [<c0231c91>] acpi_ec_gpe_handler+0x93/0xd6
                              [<c0212d05>] acpi_ev_gpe_dispatch+0x8e/0x1a1
                              [<c0212ef1>] acpi_ev_gpe_detect+0xd9/0x128
                              [<c0210878>] acpi_ev_sci_xrupt_handler+0x29/0x47
                              [<c0208757>] acpi_irq+0xf/0x1a
                              [<c0142a9d>] handle_IRQ_event+0x31/0x62
                              [<c0142b5f>] __do_IRQ+0x91/0x10d
                              [<c0105a34>] do_IRQ+0x48/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c012c03a>] rcu_process_callbacks+0x12/0x23
                              [<c0120390>] tasklet_action+0x48/0x87
                              [<c012029d>] __do_softirq+0x63/0xc1
                              [<c0120346>] do_softirq+0x4b/0x4d
                              [<c01205a7>] irq_exit+0x4c/0x4e
                              [<c0105a39>] do_IRQ+0x4d/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c0101a8b>] cpu_idle+0x41/0x6a
                              [<c0100523>] rest_init+0x45/0x52
                              [<c04a6777>] start_kernel+0x2cf/0x378
                              [<c0100199>] 0xc0100199
    }
    ... key      at: [<c050067c>] __key.12788+0x0/0x8
    -> (&rq->rq_lock_key){++..} ops: 146391 {
       initial-use  at:
                                [<c013535e>] lock_acquire+0x68/0x83
                                [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                                [<c0116ba2>] init_idle+0x4b/0x70
                                [<c04b38c3>] sched_init+0xde/0xe6
                                [<c04a650a>] start_kernel+0x62/0x378
                                [<c0100199>] 0xc0100199
       in-hardirq-W at:
                                [<c013535e>] lock_acquire+0x68/0x83
                                [<c0340c28>] _spin_lock+0x45/0x53
                                [<c0116c7e>] scheduler_tick+0xb7/0x300
                                [<c0124c35>] update_process_times+0x52/0x7c
                                [<c0106c1b>] timer_interrupt+0x4a/0xaf
                                [<c0142a9d>] handle_IRQ_event+0x31/0x62
                                [<c0142b5f>] __do_IRQ+0x91/0x10d
                                [<c0105a34>] do_IRQ+0x48/0xa4
                                [<c0103ad5>] common_interrupt+0x25/0x2c
                                [<c0107683>] enable_8259A_irq+0x50/0x53
                                [<c04b245a>] setup_IO_APIC+0xd6c/0x1265
                                [<c04b09d9>] APIC_init_uniprocessor+0x98/0xea
                                [<c0100287>] init+0x2b/0x282
                                [<c0101005>] kernel_thread_helper+0x5/0xb
       in-softirq-W at:
                                [<c013535e>] lock_acquire+0x68/0x83
                                [<c0340c28>] _spin_lock+0x45/0x53
                                [<c01171e2>] task_rq_lock+0x17/0x1e
                                [<c0117304>] try_to_wake_up+0x18/0x118
                                [<c0117435>] wake_up_process+0xf/0x11
                                [<c0123fb2>] process_timeout+0xb/0xd
                                [<c0123e47>] run_timer_softirq+0x149/0x16d
                                [<c012029d>] __do_softirq+0x63/0xc1
                                [<c0120346>] do_softirq+0x4b/0x4d
                                [<c01205a7>] irq_exit+0x4c/0x4e
                                [<c0105a39>] do_IRQ+0x4d/0xa4
                                [<c0103ad5>] common_interrupt+0x25/0x2c
                                [<c0101a8b>] cpu_idle+0x41/0x6a
                                [<c0100523>] rest_init+0x45/0x52
                                [<c04a6777>] start_kernel+0x2cf/0x378
                                [<c0100199>] 0xc0100199
     }
     ... key      at: [<c04ddd54>] per_cpu__runqueues+0x954/0x95c
    ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340c28>] _spin_lock+0x45/0x53
   [<c01171e2>] task_rq_lock+0x17/0x1e
   [<c0117304>] try_to_wake_up+0x18/0x118
   [<c0117418>] default_wake_function+0x14/0x16
   [<c011660a>] __wake_up_common+0x42/0x61
   [<c0116939>] complete+0x3a/0x4b
   [<c012e0f6>] kthread+0xa7/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

   ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c01169a9>] __wake_up+0x15/0x42
   [<c02db383>] sock_def_readable+0x7b/0x7d
   [<c02f2032>] netlink_broadcast+0x2a5/0x338
   [<c02ed21e>] wireless_send_event+0x2e2/0x343
   [<e08af660>] ieee80211softmac_call_events_locked+0xa0/0x129 [ieee80211softmac]
   [<e08af717>] ieee80211softmac_call_events+0x2e/0x3f [ieee80211softmac]
   [<e08ade62>] ieee80211softmac_scan_finished+0x5a/0x8c [ieee80211softmac]
   [<e08adfe6>] ieee80211softmac_scan+0xf0/0x15a [ieee80211softmac]
   [<c012af5c>] run_workqueue+0x7a/0xf3
   [<c012b693>] worker_thread+0x13b/0x158
   [<c012e132>] kthread+0xe3/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

   -> (nl_table_wait.lock){....} ops: 1711 {
      initial-use  at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c01169a9>] __wake_up+0x15/0x42
                              [<c02f1be6>] netlink_insert+0xe5/0x156
                              [<c02f2dc6>] netlink_kernel_create+0xad/0x143
                              [<c04c0618>] rtnetlink_init+0x70/0xc7
                              [<c04c0844>] netlink_proto_init+0x187/0x192
                              [<c01002d6>] init+0x7a/0x282
                              [<c0101005>] kernel_thread_helper+0x5/0xb
    }
    ... key      at: [<c03d679c>] nl_table_wait+0x1c/0x30
   ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c01169a9>] __wake_up+0x15/0x42
   [<c02f1fa1>] netlink_broadcast+0x214/0x338
   [<c02ed21e>] wireless_send_event+0x2e2/0x343
   [<e08af660>] ieee80211softmac_call_events_locked+0xa0/0x129 [ieee80211softmac]
   [<e08af717>] ieee80211softmac_call_events+0x2e/0x3f [ieee80211softmac]
   [<e08ade62>] ieee80211softmac_scan_finished+0x5a/0x8c [ieee80211softmac]
   [<e08adfe6>] ieee80211softmac_scan+0xf0/0x15a [ieee80211softmac]
   [<c012af5c>] run_workqueue+0x7a/0xf3
   [<c012b693>] worker_thread+0x13b/0x158
   [<c012e132>] kthread+0xe3/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

  ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<e08ad580>] ieee80211softmac_add_network+0x16/0x38 [ieee80211softmac]
   [<e08af125>] ieee80211softmac_assoc_work+0x372/0x55f [ieee80211softmac]
   [<c012af5c>] run_workqueue+0x7a/0xf3
   [<c012b693>] worker_thread+0x13b/0x158
   [<c012e132>] kthread+0xe3/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

 ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<e08a5186>] ieee80211_process_probe_response+0x212/0x736 [ieee80211]
   [<e08a5750>] ieee80211_rx_mgt+0xa6/0x348 [ieee80211]
   [<e09191d8>] bcm43xx_rx+0x331/0x949 [bcm43xx]
   [<e091ca27>] bcm43xx_dma_rx+0x171/0x555 [bcm43xx]
   [<e0904b85>] bcm43xx_interrupt_tasklet+0x41e/0xacc [bcm43xx]
   [<c0120390>] tasklet_action+0x48/0x87
   [<c012029d>] __do_softirq+0x63/0xc1
   [<c0120346>] do_softirq+0x4b/0x4d
   [<c01205a7>] irq_exit+0x4c/0x4e
   [<c0105a39>] do_IRQ+0x4d/0xa4
   [<c0103ad5>] common_interrupt+0x25/0x2c
   [<c02382fd>] acpi_processor_idle+0x14c/0x357
   [<c0101a8b>] cpu_idle+0x41/0x6a
   [<c0100523>] rest_init+0x45/0x52
   [<c04a6777>] start_kernel+0x2cf/0x378
   [<c0100199>] 0xc0100199

 -> (&softmac->lock){.+..} ops: 93 {
    initial-use  at:
                          [<c013535e>] lock_acquire+0x68/0x83
                          [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                          [<e08aede6>] ieee80211softmac_assoc_work+0x33/0x55f [ieee80211softmac]
                          [<c012af5c>] run_workqueue+0x7a/0xf3
                          [<c012b693>] worker_thread+0x13b/0x158
                          [<c012e132>] kthread+0xe3/0xe7
                          [<c0101005>] kernel_thread_helper+0x5/0xb
    in-softirq-W at:
                          [<c013535e>] lock_acquire+0x68/0x83
                          [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                          [<e08ac902>] ieee80211softmac_auth_resp+0x32/0x5e5 [ieee80211softmac]
                          [<e08a57aa>] ieee80211_rx_mgt+0x100/0x348 [ieee80211]
                          [<e09191d8>] bcm43xx_rx+0x331/0x949 [bcm43xx]
                          [<e091ca27>] bcm43xx_dma_rx+0x171/0x555 [bcm43xx]
                          [<e0904b85>] bcm43xx_interrupt_tasklet+0x41e/0xacc [bcm43xx]
                          [<c0120390>] tasklet_action+0x48/0x87
                          [<c012029d>] __do_softirq+0x63/0xc1
                          [<c0120346>] do_softirq+0x4b/0x4d
                          [<c01205a7>] irq_exit+0x4c/0x4e
                          [<c0105a39>] do_IRQ+0x4d/0xa4
                          [<c0103ad5>] common_interrupt+0x25/0x2c
                          [<c0101a8b>] cpu_idle+0x41/0x6a
                          [<c0100523>] rest_init+0x45/0x52
                          [<c04a6777>] start_kernel+0x2cf/0x378
                          [<c0100199>] 0xc0100199
  }
  ... key      at: [<e08b2e00>] __key.19206+0x0/0xffffcac7 [ieee80211softmac]
  -> (&cwq->lock){++..} ops: 3534 {
     initial-use  at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                            [<c012ad78>] __queue_work+0x12/0x59
                            [<c012b450>] queue_work+0x55/0x71
                            [<c012aa1b>] call_usermodehelper_keys+0xcb/0xe0
                            [<c01edffe>] kobject_uevent+0x3a1/0x4a3
                            [<c0261ca0>] class_device_add+0x40f/0x4c8
                            [<c0261d73>] class_device_register+0x1a/0x20
                            [<c0261e17>] class_device_create+0x9e/0xc1
                            [<c04bb9ef>] vtconsole_class_init+0x7a/0xe0
                            [<c01002d6>] init+0x7a/0x282
                            [<c0101005>] kernel_thread_helper+0x5/0xb
     in-hardirq-W at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                            [<c012ad78>] __queue_work+0x12/0x59
                            [<c012b450>] queue_work+0x55/0x71
                            [<c012b47b>] schedule_work+0xf/0x11
                            [<c024d540>] schedule_console_callback+0xd/0xf
                            [<c024b1e8>] kbd_event+0x47/0x5df
                            [<c028d0fb>] input_event+0xe4/0x497
                            [<c02918e6>] atkbd_interrupt+0x11e/0x698
                            [<c0289d2f>] serio_interrupt+0x44/0x7e
                            [<c028ab37>] i8042_interrupt+0x11a/0x216
                            [<c0142a9d>] handle_IRQ_event+0x31/0x62
                            [<c0142b5f>] __do_IRQ+0x91/0x10d
                            [<c0105a34>] do_IRQ+0x48/0xa4
                            [<c0103ad5>] common_interrupt+0x25/0x2c
                            [<c0101a8b>] cpu_idle+0x41/0x6a
                            [<c0100523>] rest_init+0x45/0x52
                            [<c04a6777>] start_kernel+0x2cf/0x378
                            [<c0100199>] 0xc0100199
     in-softirq-W at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                            [<c012ad78>] __queue_work+0x12/0x59
                            [<c012add8>] delayed_work_timer_fn+0x19/0x1d
                            [<c0123e47>] run_timer_softirq+0x149/0x16d
                            [<c012029d>] __do_softirq+0x63/0xc1
                            [<c0120346>] do_softirq+0x4b/0x4d
                            [<c01205a7>] irq_exit+0x4c/0x4e
                            [<c0105a39>] do_IRQ+0x4d/0xa4
                            [<c0103ad5>] common_interrupt+0x25/0x2c
                            [<c0101a8b>] cpu_idle+0x41/0x6a
                            [<c0100523>] rest_init+0x45/0x52
                            [<c04a6777>] start_kernel+0x2cf/0x378
                            [<c0100199>] 0xc0100199
   }
   ... key      at: [<c0500270>] __key.9034+0x0/0x8
   -> (&q->lock){++..} ops: 31205 {
      initial-use  at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340ee7>] _spin_lock_irq+0x4b/0x59
                              [<c033e740>] wait_for_completion+0x28/0xae
                              [<c012e007>] keventd_create_kthread+0x31/0x79
                              [<c012e20b>] kthread_create+0xd5/0xd7
                              [<c012002d>] cpu_callback+0x69/0xbe
                              [<c04b3ff0>] spawn_ksoftirqd+0x26/0x46
                              [<c010027d>] init+0x21/0x282
                              [<c0101005>] kernel_thread_helper+0x5/0xb
      in-hardirq-W at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c01169a9>] __wake_up+0x15/0x42
                              [<c0231c91>] acpi_ec_gpe_handler+0x93/0xd6
                              [<c0212d05>] acpi_ev_gpe_dispatch+0x8e/0x1a1
                              [<c0212ef1>] acpi_ev_gpe_detect+0xd9/0x128
                              [<c0210878>] acpi_ev_sci_xrupt_handler+0x29/0x47
                              [<c0208757>] acpi_irq+0xf/0x1a
                              [<c0142a9d>] handle_IRQ_event+0x31/0x62
                              [<c0142b5f>] __do_IRQ+0x91/0x10d
                              [<c0105a34>] do_IRQ+0x48/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c012c03a>] rcu_process_callbacks+0x12/0x23
                              [<c0120390>] tasklet_action+0x48/0x87
                              [<c012029d>] __do_softirq+0x63/0xc1
                              [<c0120346>] do_softirq+0x4b/0x4d
                              [<c01205a7>] irq_exit+0x4c/0x4e
                              [<c0105a39>] do_IRQ+0x4d/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c0101a8b>] cpu_idle+0x41/0x6a
                              [<c0100523>] rest_init+0x45/0x52
                              [<c04a6777>] start_kernel+0x2cf/0x378
                              [<c0100199>] 0xc0100199
      in-softirq-W at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c01169a9>] __wake_up+0x15/0x42
                              [<c0231c91>] acpi_ec_gpe_handler+0x93/0xd6
                              [<c0212d05>] acpi_ev_gpe_dispatch+0x8e/0x1a1
                              [<c0212ef1>] acpi_ev_gpe_detect+0xd9/0x128
                              [<c0210878>] acpi_ev_sci_xrupt_handler+0x29/0x47
                              [<c0208757>] acpi_irq+0xf/0x1a
                              [<c0142a9d>] handle_IRQ_event+0x31/0x62
                              [<c0142b5f>] __do_IRQ+0x91/0x10d
                              [<c0105a34>] do_IRQ+0x48/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c012c03a>] rcu_process_callbacks+0x12/0x23
                              [<c0120390>] tasklet_action+0x48/0x87
                              [<c012029d>] __do_softirq+0x63/0xc1
                              [<c0120346>] do_softirq+0x4b/0x4d
                              [<c01205a7>] irq_exit+0x4c/0x4e
                              [<c0105a39>] do_IRQ+0x4d/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c0101a8b>] cpu_idle+0x41/0x6a
                              [<c0100523>] rest_init+0x45/0x52
                              [<c04a6777>] start_kernel+0x2cf/0x378
                              [<c0100199>] 0xc0100199
    }
    ... key      at: [<c050067c>] __key.12788+0x0/0x8
    -> (&rq->rq_lock_key){++..} ops: 146391 {
       initial-use  at:
                                [<c013535e>] lock_acquire+0x68/0x83
                                [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                                [<c0116ba2>] init_idle+0x4b/0x70
                                [<c04b38c3>] sched_init+0xde/0xe6
                                [<c04a650a>] start_kernel+0x62/0x378
                                [<c0100199>] 0xc0100199
       in-hardirq-W at:
                                [<c013535e>] lock_acquire+0x68/0x83
                                [<c0340c28>] _spin_lock+0x45/0x53
                                [<c0116c7e>] scheduler_tick+0xb7/0x300
                                [<c0124c35>] update_process_times+0x52/0x7c
                                [<c0106c1b>] timer_interrupt+0x4a/0xaf
                                [<c0142a9d>] handle_IRQ_event+0x31/0x62
                                [<c0142b5f>] __do_IRQ+0x91/0x10d
                                [<c0105a34>] do_IRQ+0x48/0xa4
                                [<c0103ad5>] common_interrupt+0x25/0x2c
                                [<c0107683>] enable_8259A_irq+0x50/0x53
                                [<c04b245a>] setup_IO_APIC+0xd6c/0x1265
                                [<c04b09d9>] APIC_init_uniprocessor+0x98/0xea
                                [<c0100287>] init+0x2b/0x282
                                [<c0101005>] kernel_thread_helper+0x5/0xb
       in-softirq-W at:
                                [<c013535e>] lock_acquire+0x68/0x83
                                [<c0340c28>] _spin_lock+0x45/0x53
                                [<c01171e2>] task_rq_lock+0x17/0x1e
                                [<c0117304>] try_to_wake_up+0x18/0x118
                                [<c0117435>] wake_up_process+0xf/0x11
                                [<c0123fb2>] process_timeout+0xb/0xd
                                [<c0123e47>] run_timer_softirq+0x149/0x16d
                                [<c012029d>] __do_softirq+0x63/0xc1
                                [<c0120346>] do_softirq+0x4b/0x4d
                                [<c01205a7>] irq_exit+0x4c/0x4e
                                [<c0105a39>] do_IRQ+0x4d/0xa4
                                [<c0103ad5>] common_interrupt+0x25/0x2c
                                [<c0101a8b>] cpu_idle+0x41/0x6a
                                [<c0100523>] rest_init+0x45/0x52
                                [<c04a6777>] start_kernel+0x2cf/0x378
                                [<c0100199>] 0xc0100199
     }
     ... key      at: [<c04ddd54>] per_cpu__runqueues+0x954/0x95c
    ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340c28>] _spin_lock+0x45/0x53
   [<c01171e2>] task_rq_lock+0x17/0x1e
   [<c0117304>] try_to_wake_up+0x18/0x118
   [<c0117418>] default_wake_function+0x14/0x16
   [<c011660a>] __wake_up_common+0x42/0x61
   [<c0116939>] complete+0x3a/0x4b
   [<c012e0f6>] kthread+0xa7/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

   ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c01169a9>] __wake_up+0x15/0x42
   [<c012adae>] __queue_work+0x48/0x59
   [<c012b450>] queue_work+0x55/0x71
   [<c012aa1b>] call_usermodehelper_keys+0xcb/0xe0
   [<c01edffe>] kobject_uevent+0x3a1/0x4a3
   [<c0261ca0>] class_device_add+0x40f/0x4c8
   [<c0261d73>] class_device_register+0x1a/0x20
   [<c0261e17>] class_device_create+0x9e/0xc1
   [<c04bb9ef>] vtconsole_class_init+0x7a/0xe0
   [<c01002d6>] init+0x7a/0x282
   [<c0101005>] kernel_thread_helper+0x5/0xb

  ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c012ad78>] __queue_work+0x12/0x59
   [<c012b450>] queue_work+0x55/0x71
   [<c012b47b>] schedule_work+0xf/0x11
   [<e08ae199>] ieee80211softmac_start_scan_implementation+0xa5/0x125 [ieee80211softmac]
   [<e08ae0bd>] ieee80211softmac_start_scan+0x6d/0xa4 [ieee80211softmac]
   [<e08ae379>] ieee80211softmac_wx_trigger_scan+0x16/0x18 [ieee80211softmac]
   [<c02eda1e>] ioctl_standard_call+0x169/0x2f3
   [<c02ee1b8>] wireless_process_ioctl+0x36e/0x428
   [<c02e334b>] dev_ioctl+0x235/0x3b3
   [<c02d70fb>] sock_ioctl+0x3c/0x24a
   [<c017542a>] do_ioctl+0x2a/0x80
   [<c01754d6>] vfs_ioctl+0x56/0x2bc
   [<c0175777>] sys_ioctl+0x3b/0x58
   [<c0103069>] sysenter_past_esp+0x56/0x8d

  -> (base_lock_keys + cpu){++..} ops: 61512 {
     initial-use  at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                            [<c01249ef>] lock_timer_base+0x18/0x33
                            [<c0124a83>] __mod_timer+0x1d/0x9e
                            [<c0124b6b>] mod_timer+0x24/0x3c
                            [<c04bb942>] con_init+0x21c/0x24f
                            [<c04bafe2>] console_init+0x2b/0x3c
                            [<c04a65d0>] start_kernel+0x128/0x378
                            [<c0100199>] 0xc0100199
     in-hardirq-W at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                            [<c01249ef>] lock_timer_base+0x18/0x33
                            [<c0124a30>] del_timer+0x26/0x5c
                            [<c026b1c1>] ide_intr+0x72/0x1db
                            [<c0142a9d>] handle_IRQ_event+0x31/0x62
                            [<c0142b5f>] __do_IRQ+0x91/0x10d
                            [<c0105a34>] do_IRQ+0x48/0xa4
                            [<c0103ad5>] common_interrupt+0x25/0x2c
                            [<c0101a8b>] cpu_idle+0x41/0x6a
                            [<c0100523>] rest_init+0x45/0x52
                            [<c04a6777>] start_kernel+0x2cf/0x378
                            [<c0100199>] 0xc0100199
     in-softirq-W at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340ee7>] _spin_lock_irq+0x4b/0x59
                            [<c0123d27>] run_timer_softirq+0x29/0x16d
                            [<c012029d>] __do_softirq+0x63/0xc1
                            [<c0120346>] do_softirq+0x4b/0x4d
                            [<c01205a7>] irq_exit+0x4c/0x4e
                            [<c0105a39>] do_IRQ+0x4d/0xa4
                            [<c0103ad5>] common_interrupt+0x25/0x2c
                            [<c011b69d>] register_console+0xc4/0x1fb
                            [<c04bb8d9>] con_init+0x1b3/0x24f
                            [<c04bafe2>] console_init+0x2b/0x3c
                            [<c04a65d0>] start_kernel+0x128/0x378
                            [<c0100199>] 0xc0100199
   }
   ... key      at: [<c04ffa30>] base_lock_keys+0x0/0x10
  ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c01249ef>] lock_timer_base+0x18/0x33
   [<c0124a83>] __mod_timer+0x1d/0x9e
   [<c012b3bb>] queue_delayed_work+0x5f/0x8c
   [<c012b3f9>] schedule_delayed_work+0x11/0x13
   [<e08adfa2>] ieee80211softmac_scan+0xac/0x15a [ieee80211softmac]
   [<c012af5c>] run_workqueue+0x7a/0xf3
   [<c012b693>] worker_thread+0x13b/0x158
   [<c012e132>] kthread+0xe3/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

  -> (&skb_queue_lock_key){.+..} ops: 1772 {
     initial-use  at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                            [<c02dc04a>] skb_queue_tail+0x16/0x35
                            [<c02f201d>] netlink_broadcast+0x290/0x338
                            [<c01edfb7>] kobject_uevent+0x35a/0x4a3
                            [<c01691e2>] bdev_uevent+0x29/0x3c
                            [<c016a242>] get_sb_bdev+0x149/0x16c
                            [<c01a7bd5>] ext3_get_sb+0x35/0x37
                            [<c0169ce7>] vfs_kern_mount+0x42/0x8c
                            [<c0169d95>] do_kern_mount+0x3b/0x4e
                            [<c017fb6c>] do_mount+0x257/0x6a0
                            [<c018004a>] sys_mount+0x95/0xd4
                            [<c01030e7>] syscall_call+0x7/0xb
     in-softirq-W at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                            [<c02dc04a>] skb_queue_tail+0x16/0x35
                            [<c02f201d>] netlink_broadcast+0x290/0x338
                            [<c02ed21e>] wireless_send_event+0x2e2/0x343
                            [<e08af660>] ieee80211softmac_call_events_locked+0xa0/0x129 [ieee80211softmac]
                            [<e08af717>] ieee80211softmac_call_events+0x2e/0x3f [ieee80211softmac]
                            [<e08aca7f>] ieee80211softmac_auth_resp+0x1af/0x5e5 [ieee80211softmac]
                            [<e08a57aa>] ieee80211_rx_mgt+0x100/0x348 [ieee80211]
                            [<e09191d8>] bcm43xx_rx+0x331/0x949 [bcm43xx]
                            [<e091ca27>] bcm43xx_dma_rx+0x171/0x555 [bcm43xx]
                            [<e0904b85>] bcm43xx_interrupt_tasklet+0x41e/0xacc [bcm43xx]
                            [<c0120390>] tasklet_action+0x48/0x87
                            [<c012029d>] __do_softirq+0x63/0xc1
                            [<c0120346>] do_softirq+0x4b/0x4d
                            [<c01205a7>] irq_exit+0x4c/0x4e
                            [<c0105a39>] do_IRQ+0x4d/0xa4
                            [<c0103ad5>] common_interrupt+0x25/0x2c
                            [<c0101a8b>] cpu_idle+0x41/0x6a
                            [<c0100523>] rest_init+0x45/0x52
                            [<c04a6777>] start_kernel+0x2cf/0x378
                            [<c0100199>] 0xc0100199
   }
   ... key      at: [<c0644628>] skb_queue_lock_key+0x0/0x18
  ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c02dc04a>] skb_queue_tail+0x16/0x35
   [<c02f201d>] netlink_broadcast+0x290/0x338
   [<c02ed21e>] wireless_send_event+0x2e2/0x343
   [<e08af660>] ieee80211softmac_call_events_locked+0xa0/0x129 [ieee80211softmac]
   [<e08af717>] ieee80211softmac_call_events+0x2e/0x3f [ieee80211softmac]
   [<e08ade62>] ieee80211softmac_scan_finished+0x5a/0x8c [ieee80211softmac]
   [<e08adfe6>] ieee80211softmac_scan+0xf0/0x15a [ieee80211softmac]
   [<c012af5c>] run_workqueue+0x7a/0xf3
   [<c012b693>] worker_thread+0x13b/0x158
   [<c012e132>] kthread+0xe3/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

  -> (&q->lock){++..} ops: 31205 {
     initial-use  at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340ee7>] _spin_lock_irq+0x4b/0x59
                            [<c033e740>] wait_for_completion+0x28/0xae
                            [<c012e007>] keventd_create_kthread+0x31/0x79
                            [<c012e20b>] kthread_create+0xd5/0xd7
                            [<c012002d>] cpu_callback+0x69/0xbe
                            [<c04b3ff0>] spawn_ksoftirqd+0x26/0x46
                            [<c010027d>] init+0x21/0x282
                            [<c0101005>] kernel_thread_helper+0x5/0xb
     in-hardirq-W at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                            [<c01169a9>] __wake_up+0x15/0x42
                            [<c0231c91>] acpi_ec_gpe_handler+0x93/0xd6
                            [<c0212d05>] acpi_ev_gpe_dispatch+0x8e/0x1a1
                            [<c0212ef1>] acpi_ev_gpe_detect+0xd9/0x128
                            [<c0210878>] acpi_ev_sci_xrupt_handler+0x29/0x47
                            [<c0208757>] acpi_irq+0xf/0x1a
                            [<c0142a9d>] handle_IRQ_event+0x31/0x62
                            [<c0142b5f>] __do_IRQ+0x91/0x10d
                            [<c0105a34>] do_IRQ+0x48/0xa4
                            [<c0103ad5>] common_interrupt+0x25/0x2c
                            [<c012c03a>] rcu_process_callbacks+0x12/0x23
                            [<c0120390>] tasklet_action+0x48/0x87
                            [<c012029d>] __do_softirq+0x63/0xc1
                            [<c0120346>] do_softirq+0x4b/0x4d
                            [<c01205a7>] irq_exit+0x4c/0x4e
                            [<c0105a39>] do_IRQ+0x4d/0xa4
                            [<c0103ad5>] common_interrupt+0x25/0x2c
                            [<c0101a8b>] cpu_idle+0x41/0x6a
                            [<c0100523>] rest_init+0x45/0x52
                            [<c04a6777>] start_kernel+0x2cf/0x378
                            [<c0100199>] 0xc0100199
     in-softirq-W at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                            [<c01169a9>] __wake_up+0x15/0x42
                            [<c0231c91>] acpi_ec_gpe_handler+0x93/0xd6
                            [<c0212d05>] acpi_ev_gpe_dispatch+0x8e/0x1a1
                            [<c0212ef1>] acpi_ev_gpe_detect+0xd9/0x128
                            [<c0210878>] acpi_ev_sci_xrupt_handler+0x29/0x47
                            [<c0208757>] acpi_irq+0xf/0x1a
                            [<c0142a9d>] handle_IRQ_event+0x31/0x62
                            [<c0142b5f>] __do_IRQ+0x91/0x10d
                            [<c0105a34>] do_IRQ+0x48/0xa4
                            [<c0103ad5>] common_interrupt+0x25/0x2c
                            [<c012c03a>] rcu_process_callbacks+0x12/0x23
                            [<c0120390>] tasklet_action+0x48/0x87
                            [<c012029d>] __do_softirq+0x63/0xc1
                            [<c0120346>] do_softirq+0x4b/0x4d
                            [<c01205a7>] irq_exit+0x4c/0x4e
                            [<c0105a39>] do_IRQ+0x4d/0xa4
                            [<c0103ad5>] common_interrupt+0x25/0x2c
                            [<c0101a8b>] cpu_idle+0x41/0x6a
                            [<c0100523>] rest_init+0x45/0x52
                            [<c04a6777>] start_kernel+0x2cf/0x378
                            [<c0100199>] 0xc0100199
   }
   ... key      at: [<c050067c>] __key.12788+0x0/0x8
   -> (&rq->rq_lock_key){++..} ops: 146391 {
      initial-use  at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                              [<c0116ba2>] init_idle+0x4b/0x70
                              [<c04b38c3>] sched_init+0xde/0xe6
                              [<c04a650a>] start_kernel+0x62/0x378
                              [<c0100199>] 0xc0100199
      in-hardirq-W at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340c28>] _spin_lock+0x45/0x53
                              [<c0116c7e>] scheduler_tick+0xb7/0x300
                              [<c0124c35>] update_process_times+0x52/0x7c
                              [<c0106c1b>] timer_interrupt+0x4a/0xaf
                              [<c0142a9d>] handle_IRQ_event+0x31/0x62
                              [<c0142b5f>] __do_IRQ+0x91/0x10d
                              [<c0105a34>] do_IRQ+0x48/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c0107683>] enable_8259A_irq+0x50/0x53
                              [<c04b245a>] setup_IO_APIC+0xd6c/0x1265
                              [<c04b09d9>] APIC_init_uniprocessor+0x98/0xea
                              [<c0100287>] init+0x2b/0x282
                              [<c0101005>] kernel_thread_helper+0x5/0xb
      in-softirq-W at:
                              [<c013535e>] lock_acquire+0x68/0x83
                              [<c0340c28>] _spin_lock+0x45/0x53
                              [<c01171e2>] task_rq_lock+0x17/0x1e
                              [<c0117304>] try_to_wake_up+0x18/0x118
                              [<c0117435>] wake_up_process+0xf/0x11
                              [<c0123fb2>] process_timeout+0xb/0xd
                              [<c0123e47>] run_timer_softirq+0x149/0x16d
                              [<c012029d>] __do_softirq+0x63/0xc1
                              [<c0120346>] do_softirq+0x4b/0x4d
                              [<c01205a7>] irq_exit+0x4c/0x4e
                              [<c0105a39>] do_IRQ+0x4d/0xa4
                              [<c0103ad5>] common_interrupt+0x25/0x2c
                              [<c0101a8b>] cpu_idle+0x41/0x6a
                              [<c0100523>] rest_init+0x45/0x52
                              [<c04a6777>] start_kernel+0x2cf/0x378
                              [<c0100199>] 0xc0100199
    }
    ... key      at: [<c04ddd54>] per_cpu__runqueues+0x954/0x95c
   ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340c28>] _spin_lock+0x45/0x53
   [<c01171e2>] task_rq_lock+0x17/0x1e
   [<c0117304>] try_to_wake_up+0x18/0x118
   [<c0117418>] default_wake_function+0x14/0x16
   [<c011660a>] __wake_up_common+0x42/0x61
   [<c0116939>] complete+0x3a/0x4b
   [<c012e0f6>] kthread+0xa7/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

  ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c01169a9>] __wake_up+0x15/0x42
   [<c02db383>] sock_def_readable+0x7b/0x7d
   [<c02f2032>] netlink_broadcast+0x2a5/0x338
   [<c02ed21e>] wireless_send_event+0x2e2/0x343
   [<e08af660>] ieee80211softmac_call_events_locked+0xa0/0x129 [ieee80211softmac]
   [<e08af717>] ieee80211softmac_call_events+0x2e/0x3f [ieee80211softmac]
   [<e08ade62>] ieee80211softmac_scan_finished+0x5a/0x8c [ieee80211softmac]
   [<e08adfe6>] ieee80211softmac_scan+0xf0/0x15a [ieee80211softmac]
   [<c012af5c>] run_workqueue+0x7a/0xf3
   [<c012b693>] worker_thread+0x13b/0x158
   [<c012e132>] kthread+0xe3/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

  -> (nl_table_wait.lock){....} ops: 1711 {
     initial-use  at:
                            [<c013535e>] lock_acquire+0x68/0x83
                            [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                            [<c01169a9>] __wake_up+0x15/0x42
                            [<c02f1be6>] netlink_insert+0xe5/0x156
                            [<c02f2dc6>] netlink_kernel_create+0xad/0x143
                            [<c04c0618>] rtnetlink_init+0x70/0xc7
                            [<c04c0844>] netlink_proto_init+0x187/0x192
                            [<c01002d6>] init+0x7a/0x282
                            [<c0101005>] kernel_thread_helper+0x5/0xb
   }
   ... key      at: [<c03d679c>] nl_table_wait+0x1c/0x30
  ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c01169a9>] __wake_up+0x15/0x42
   [<c02f1fa1>] netlink_broadcast+0x214/0x338
   [<c02ed21e>] wireless_send_event+0x2e2/0x343
   [<e08af660>] ieee80211softmac_call_events_locked+0xa0/0x129 [ieee80211softmac]
   [<e08af717>] ieee80211softmac_call_events+0x2e/0x3f [ieee80211softmac]
   [<e08ade62>] ieee80211softmac_scan_finished+0x5a/0x8c [ieee80211softmac]
   [<e08adfe6>] ieee80211softmac_scan+0xf0/0x15a [ieee80211softmac]
   [<c012af5c>] run_workqueue+0x7a/0xf3
   [<c012b693>] worker_thread+0x13b/0x158
   [<c012e132>] kthread+0xe3/0xe7
   [<c0101005>] kernel_thread_helper+0x5/0xb

 ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<e08ac902>] ieee80211softmac_auth_resp+0x32/0x5e5 [ieee80211softmac]
   [<e08a57aa>] ieee80211_rx_mgt+0x100/0x348 [ieee80211]
   [<e09191d8>] bcm43xx_rx+0x331/0x949 [bcm43xx]
   [<e091ca27>] bcm43xx_dma_rx+0x171/0x555 [bcm43xx]
   [<e0904b85>] bcm43xx_interrupt_tasklet+0x41e/0xacc [bcm43xx]
   [<c0120390>] tasklet_action+0x48/0x87
   [<c012029d>] __do_softirq+0x63/0xc1
   [<c0120346>] do_softirq+0x4b/0x4d
   [<c01205a7>] irq_exit+0x4c/0x4e
   [<c0105a39>] do_IRQ+0x4d/0xa4
   [<c0103ad5>] common_interrupt+0x25/0x2c
   [<c0101a8b>] cpu_idle+0x41/0x6a
   [<c0100523>] rest_init+0x45/0x52
   [<c04a6777>] start_kernel+0x2cf/0x378
   [<c0100199>] 0xc0100199

 -> (ratelimit_lock){.+..} ops: 1 {
    initial-use  at:
                          [<c013535e>] lock_acquire+0x68/0x83
                          [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                          [<c011bcad>] __printk_ratelimit+0x1b/0xb0
                          [<c011bd5e>] printk_ratelimit+0x1c/0x1e
                          [<e08aca5d>] ieee80211softmac_auth_resp+0x18d/0x5e5 [ieee80211softmac]
                          [<e08a57aa>] ieee80211_rx_mgt+0x100/0x348 [ieee80211]
                          [<e09191d8>] bcm43xx_rx+0x331/0x949 [bcm43xx]
                          [<e091ca27>] bcm43xx_dma_rx+0x171/0x555 [bcm43xx]
                          [<e0904b85>] bcm43xx_interrupt_tasklet+0x41e/0xacc [bcm43xx]
                          [<c0120390>] tasklet_action+0x48/0x87
                          [<c012029d>] __do_softirq+0x63/0xc1
                          [<c0120346>] do_softirq+0x4b/0x4d
                          [<c01205a7>] irq_exit+0x4c/0x4e
                          [<c0105a39>] do_IRQ+0x4d/0xa4
                          [<c0103ad5>] common_interrupt+0x25/0x2c
                          [<c0101a8b>] cpu_idle+0x41/0x6a
                          [<c0100523>] rest_init+0x45/0x52
                          [<c04a6777>] start_kernel+0x2cf/0x378
                          [<c0100199>] 0xc0100199
    in-softirq-W at:
                          [<c013535e>] lock_acquire+0x68/0x83
                          [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
                          [<c011bcad>] __printk_ratelimit+0x1b/0xb0
                          [<c011bd5e>] printk_ratelimit+0x1c/0x1e
                          [<e08aca5d>] ieee80211softmac_auth_resp+0x18d/0x5e5 [ieee80211softmac]
                          [<e08a57aa>] ieee80211_rx_mgt+0x100/0x348 [ieee80211]
                          [<e09191d8>] bcm43xx_rx+0x331/0x949 [bcm43xx]
                          [<e091ca27>] bcm43xx_dma_rx+0x171/0x555 [bcm43xx]
                          [<e0904b85>] bcm43xx_interrupt_tasklet+0x41e/0xacc [bcm43xx]
                          [<c0120390>] tasklet_action+0x48/0x87
                          [<c012029d>] __do_softirq+0x63/0xc1
                          [<c0120346>] do_softirq+0x4b/0x4d
                          [<c01205a7>] irq_exit+0x4c/0x4e
                          [<c0105a39>] do_IRQ+0x4d/0xa4
                          [<c0103ad5>] common_interrupt+0x25/0x2c
                          [<c0101a8b>] cpu_idle+0x41/0x6a
                          [<c0100523>] rest_init+0x45/0x52
                          [<c04a6777>] start_kernel+0x2cf/0x378
                          [<c0100199>] 0xc0100199
  }
  ... key      at: [<c03b931c>] ratelimit_lock.17634+0x1c/0x28
 ... acquired at:
   [<c013535e>] lock_acquire+0x68/0x83
   [<c0340f9c>] _spin_lock_irqsave+0x4e/0x5f
   [<c011bcad>] __printk_ratelimit+0x1b/0xb0
   [<c011bd5e>] printk_ratelimit+0x1c/0x1e
   [<e08aca5d>] ieee80211softmac_auth_resp+0x18d/0x5e5 [ieee80211softmac]
   [<e08a57aa>] ieee80211_rx_mgt+0x100/0x348 [ieee80211]
   [<e09191d8>] bcm43xx_rx+0x331/0x949 [bcm43xx]
   [<e091ca27>] bcm43xx_dma_rx+0x171/0x555 [bcm43xx]
   [<e0904b85>] bcm43xx_interrupt_tasklet+0x41e/0xacc [bcm43xx]
   [<c0120390>] tasklet_action+0x48/0x87
   [<c012029d>] __do_softirq+0x63/0xc1
   [<c0120346>] do_softirq+0x4b/0x4d
   [<c01205a7>] irq_exit+0x4c/0x4e
   [<c0105a39>] do_IRQ+0x4d/0xa4
   [<c0103ad5>] common_interrupt+0x25/0x2c
   [<c0101a8b>] cpu_idle+0x41/0x6a
   [<c0100523>] rest_init+0x45/0x52
   [<c04a6777>] start_kernel+0x2cf/0x378
   [<c0100199>] 0xc0100199


the hard-irq-unsafe lock's dependencies:
-> (af_callback_keys + sk->sk_family){-.-?} ops: 877 {
   initial-use  at:
                        [<c013535e>] lock_acquire+0x68/0x83
                        [<c0340e8e>] _read_lock+0x45/0x53
                        [<c02db321>] sock_def_readable+0x19/0x7d
                        [<c02f2032>] netlink_broadcast+0x2a5/0x338
                        [<c01edfb7>] kobject_uevent+0x35a/0x4a3
                        [<c01691e2>] bdev_uevent+0x29/0x3c
                        [<c016a242>] get_sb_bdev+0x149/0x16c
                        [<c01a7bd5>] ext3_get_sb+0x35/0x37
                        [<c0169ce7>] vfs_kern_mount+0x42/0x8c
                        [<c0169d95>] do_kern_mount+0x3b/0x4e
                        [<c017fb6c>] do_mount+0x257/0x6a0
                        [<c018004a>] sys_mount+0x95/0xd4
                        [<c01030e7>] syscall_call+0x7/0xb
   hardirq-on-W at:
                        [<c013535e>] lock_acquire+0x68/0x83
                        [<c0340d2b>] _write_lock_bh+0x4a/0x58
                        [<c02f3577>] netlink_release+0xe1/0x30d
                        [<c02d7c93>] sock_release+0x1d/0xe3
                        [<c02d80d1>] sock_close+0x34/0x50
                        [<c0163d59>] __fput+0x62/0x193
                        [<c0163ee2>] fput+0x18/0x1a
                        [<c01613d0>] filp_close+0x4e/0x74
                        [<c016287b>] sys_close+0x73/0x8f
                        [<c0103069>] sysenter_past_esp+0x56/0x8d
   in-softirq-R at:
                        [<c013535e>] lock_acquire+0x68/0x83
                        [<c0340e8e>] _read_lock+0x45/0x53
                        [<c02db321>] sock_def_readable+0x19/0x7d
                        [<c02f2032>] netlink_broadcast+0x2a5/0x338
                        [<c02ed21e>] wireless_send_event+0x2e2/0x343
                        [<e08af660>] ieee80211softmac_call_events_locked+0xa0/0x129 [ieee80211softmac]
                        [<e08af717>] ieee80211softmac_call_events+0x2e/0x3f [ieee80211softmac]
                        [<e08aca7f>] ieee80211softmac_auth_resp+0x1af/0x5e5 [ieee80211softmac]
                        [<e08a57aa>] ieee80211_rx_mgt+0x100/0x348 [ieee80211]
                        [<e09191d8>] bcm43xx_rx+0x331/0x949 [bcm43xx]
                        [<e091ca27>] bcm43xx_dma_rx+0x171/0x555 [bcm43xx]
                        [<e0904b85>] bcm43xx_interrupt_tasklet+0x41e/0xacc [bcm43xx]
                        [<c0120390>] tasklet_action+0x48/0x87
                        [<c012029d>] __do_softirq+0x63/0xc1
                        [<c0120346>] do_softirq+0x4b/0x4d
                        [<c01205a7>] irq_exit+0x4c/0x4e
                        [<c0105a39>] do_IRQ+0x4d/0xa4
                        [<c0103ad5>] common_interrupt+0x25/0x2c
                        [<c0101a8b>] cpu_idle+0x41/0x6a
                        [<c0100523>] rest_init+0x45/0x52
                        [<c04a6777>] start_kernel+0x2cf/0x378
                        [<c0100199>] 0xc0100199
   softirq-on-R at:
                        [<c013535e>] lock_acquire+0x68/0x83
                        [<c0340e8e>] _read_lock+0x45/0x53
                        [<c02db321>] sock_def_readable+0x19/0x7d
                        [<c02f2032>] netlink_broadcast+0x2a5/0x338
                        [<c01edfb7>] kobject_uevent+0x35a/0x4a3
                        [<c01691e2>] bdev_uevent+0x29/0x3c
                        [<c016a242>] get_sb_bdev+0x149/0x16c
                        [<c01a7bd5>] ext3_get_sb+0x35/0x37
                        [<c0169ce7>] vfs_kern_mount+0x42/0x8c
                        [<c0169d95>] do_kern_mount+0x3b/0x4e
                        [<c017fb6c>] do_mount+0x257/0x6a0
                        [<c018004a>] sys_mount+0x95/0xd4
                        [<c01030e7>] syscall_call+0x7/0xb
   hardirq-on-R at:
                        [<c013535e>] lock_acquire+0x68/0x83
                        [<c0340e8e>] _read_lock+0x45/0x53
                        [<c02db321>] sock_def_readable+0x19/0x7d
                        [<c02f2032>] netlink_broadcast+0x2a5/0x338
                        [<c01edfb7>] kobject_uevent+0x35a/0x4a3
                        [<c01691e2>] bdev_uevent+0x29/0x3c
                        [<c016a242>] get_sb_bdev+0x149/0x16c
                        [<c01a7bd5>] ext3_get_sb+0x35/0x37
                        [<c0169ce7>] vfs_kern_mount+0x42/0x8c
                        [<c0169d95>] do_kern_mount+0x3b/0x4e
                        [<c017fb6c>] do_mount+0x257/0x6a0
                        [<c018004a>] sys_mount+0x95/0xd4
                        [<c01030e7>] syscall_call+0x7/0xb
 }
 ... key      at: [<c06445a0>] af_callback_keys+0x80/0x100

stack backtrace:
 [<c01041bc>] show_trace_log_lvl+0x133/0x14d
 [<c01048e4>] show_trace+0x1b/0x1d
 [<c01049b2>] dump_stack+0x26/0x28
 [<c0133f25>] check_usage+0x261/0x26b
 [<c0134df9>] __lock_acquire+0xb11/0xd29
 [<c013535e>] lock_acquire+0x68/0x83
 [<c0340e8e>] _read_lock+0x45/0x53
 [<c02db321>] sock_def_readable+0x19/0x7d
 [<c02f2032>] netlink_broadcast+0x2a5/0x338
 [<c02ed21e>] wireless_send_event+0x2e2/0x343
 [<e08af660>] ieee80211softmac_call_events_locked+0xa0/0x129 [ieee80211softmac]
 [<e08af717>] ieee80211softmac_call_events+0x2e/0x3f [ieee80211softmac]
 [<e08aca7f>] ieee80211softmac_auth_resp+0x1af/0x5e5 [ieee80211softmac]
 [<e08a57aa>] ieee80211_rx_mgt+0x100/0x348 [ieee80211]
 [<e09191d8>] bcm43xx_rx+0x331/0x949 [bcm43xx]
 [<e091ca27>] bcm43xx_dma_rx+0x171/0x555 [bcm43xx]
 [<e0904b85>] bcm43xx_interrupt_tasklet+0x41e/0xacc [bcm43xx]
 [<c0120390>] tasklet_action+0x48/0x87
 [<c012029d>] __do_softirq+0x63/0xc1
 [<c0120346>] do_softirq+0x4b/0x4d
 [<c01205a7>] irq_exit+0x4c/0x4e
 [<c0105a39>] do_IRQ+0x4d/0xa4
 [<c0103ad5>] common_interrupt+0x25/0x2c
 [<c0238383>] acpi_processor_idle+0x1d2/0x357
 [<c0101a8b>] cpu_idle+0x41/0x6a
 [<c0100523>] rest_init+0x45/0x52
 [<c04a6777>] start_kernel+0x2cf/0x378
 [<c0100199>] 0xc0100199
bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340

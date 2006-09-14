Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWINNNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWINNNq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 09:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWINNNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 09:13:46 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:64482 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932071AbWINNNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 09:13:44 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: "hard-safe -> hard-unsafe lock order detected" on rmmod
Date: Thu, 14 Sep 2006 15:13:52 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1626601.oYr4kK8KYi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609141513.52932.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1626601.oYr4kK8KYi
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I tried to clean up my modules list from all the stuff SuSE loaded on boot:

rmmod dm_snapshot ohci_hcd snd_intel8x0 ide_cd ehci_hcd floppy ip6table_man=
gle=20
iptable_nat iptable_mangle snd_seq snd_seq_device snd_pcm_oss edd

Result was this:

Result of uname -a
Linux siso-rl-i34d 2.6.18-rc6 #38 SMP Tue Sep 5 16:14:22 CEST 2006 i686 i68=
6=20
i386 GNU/Linux


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[ INFO: hard-safe -> hard-unsafe lock order detected ]
=2D-----------------------------------------------------
rmmod/5158 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (proc_subdir_lock){--..}, at: [<c10811fe>] remove_proc_entry+0x40/0x18b

and this task is already holding:
 (ide_lock){++..}, at: [<c115e0c1>] ide_unregister_subdriver+0x38/0xc7
which would create a new lock dependency:
 (ide_lock){++..} -> (proc_subdir_lock){--..}

but this new dependency connects a hard-irq-safe lock:
 (ide_lock){++..}
=2E.. which became hard-irq-safe at:
  [<c102e39c>] lock_acquire+0x4a/0x6a
  [<c120672f>] _spin_lock_irqsave+0x22/0x32
  [<c11608e1>] ide_intr+0x18/0x1a7
  [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
  [<c103cbfb>] __do_IRQ+0x94/0xef
  [<c1004dab>] do_IRQ+0x9e/0xbf

to a hard-irq-unsafe lock:
 (proc_subdir_lock){--..}
=2E.. which became hard-irq-unsafe at:
=2E..  [<c102e39c>] lock_acquire+0x4a/0x6a
  [<c120632a>] _spin_lock+0x19/0x28
  [<c1080fd6>] xlate_proc_name+0x1b/0x99
  [<c108138f>] proc_create+0x46/0xdf
  [<c1081488>] create_proc_entry+0x60/0xa3
  [<c13b6eb6>] proc_misc_init+0x1c/0x1b0
  [<c13b6da0>] proc_root_init+0x4c/0xd1
  [<c13a6649>] start_kernel+0x279/0x391
  [<00000000>] 0x0

other info that might help us debug this:

1 lock held by rmmod/5158:
 #0:  (ide_lock){++..}, at: [<c115e0c1>] ide_unregister_subdriver+0x38/0xc7

the hard-irq-safe lock's dependencies:
=2D> (ide_lock){++..} ops: 0 {
   initial-use  at:
                        [<c102e39c>] lock_acquire+0x4a/0x6a
                        [<c12065da>] _spin_lock_irq+0x1f/0x2e
                        [<c1163d2d>] init_irq+0x2f5/0x43d
                        [<c1163f75>] hwif_init+0x100/0x25e
                        [<c1164217>] probe_hwif_init_with_fixup+0x1d/0x75
                        [<c1165d7d>] ide_setup_pci_device+0x3e/0x71
                        [<f0808612>] amd74xx_probe+0x63/0x6a [amd74xx]
                        [<c10d8b80>] pci_device_probe+0x39/0x59
                        [<c1140ece>] driver_probe_device+0x45/0x98
                        [<c1141001>] __driver_attach+0x68/0x93
                        [<c1140503>] bus_for_each_dev+0x36/0x5b
                        [<c1140db0>] driver_attach+0x14/0x17
                        [<c11407d9>] bus_add_driver+0x64/0xf3
                        [<c11413e6>] driver_register+0x78/0x7d
                        [<c10d8805>] __pci_register_driver+0x4f/0x69
                        [<c1165392>] __ide_pci_register_driver+0x13/0x35
                        [<f080862b>] amd74xx_ide_init+0x12/0x14 [amd74xx]
                        [<c1033937>] sys_init_module+0x16b6/0x17cf
                        [<c1002841>] sysenter_past_esp+0x56/0x8d
   in-hardirq-W at:
                        [<c102e39c>] lock_acquire+0x4a/0x6a
                        [<c120672f>] _spin_lock_irqsave+0x22/0x32
                        [<c11608e1>] ide_intr+0x18/0x1a7
                        [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
                        [<c103cbfb>] __do_IRQ+0x94/0xef
                        [<c1004dab>] do_IRQ+0x9e/0xbf
   in-softirq-W at:
                        [<c102e39c>] lock_acquire+0x4a/0x6a
                        [<c120672f>] _spin_lock_irqsave+0x22/0x32
                        [<c11608e1>] ide_intr+0x18/0x1a7
                        [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
                        [<c103cbfb>] __do_IRQ+0x94/0xef
                        [<c1004dab>] do_IRQ+0x9e/0xbf
 }
 ... key      at: [<c132a190>] ide_lock+0x10/0x80
 -> (base_lock_keys + cpu){++..} ops: 0 {
    initial-use  at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120672f>] _spin_lock_irqsave+0x22/0x32
                          [<c101fa88>] lock_timer_base+0x18/0x33
                          [<c101fe73>] __mod_timer+0x26/0xac
                          [<c101ff1e>] mod_timer+0x25/0x2b
                          [<c13bbca4>] con_init+0xb6/0x1e7
                          [<c13bb3a8>] console_init+0x1e/0x2c
                          [<c13a658d>] start_kernel+0x1bd/0x391
                          [<00000000>] 0x0
    in-hardirq-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120672f>] _spin_lock_irqsave+0x22/0x32
                          [<c101fa88>] lock_timer_base+0x18/0x33
                          [<c101ff3b>] del_timer+0x17/0x49
                          [<c116ad32>] scsi_delete_timer+0xe/0x1f
                          [<c116952e>] scsi_done+0xb/0x19
                          [<c1176cc1>] ata_scsi_qc_complete+0xb0/0xbd
                          [<c1171794>] __ata_qc_complete+0x1b0/0x1b8
                          [<c117183e>] ata_qc_complete+0xa2/0xa9
                          [<c1172e50>] ata_hsm_qc_complete+0x1b8/0x1c7
                          [<c11734ef>] ata_hsm_move+0x690/0x6a6
                          [<c11735b2>] ata_host_intr+0xad/0xc5
                          [<c117acde>] nv_do_interrupt+0x9a/0xdf
                          [<c117ad75>] nv_ck804_interrupt+0x21/0x30
                          [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
                          [<c103cbfb>] __do_IRQ+0x94/0xef
                          [<c1004dab>] do_IRQ+0x9e/0xbf
    in-softirq-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c12065da>] _spin_lock_irq+0x1f/0x2e
                          [<c101fd1c>] run_timer_softirq+0x3d/0x16e
                          [<c101cff8>] __do_softirq+0x76/0xee
                          [<c1004caf>] do_softirq+0x61/0xbf
  }
  ... key      at: [<c1416fc0>] base_lock_keys+0x0/0x40
 ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c120672f>] _spin_lock_irqsave+0x22/0x32
   [<c101fa88>] lock_timer_base+0x18/0x33
   [<c101fe73>] __mod_timer+0x26/0xac
   [<c1161313>] __ide_set_handler+0x59/0x61
   [<c1161344>] ide_set_handler+0x29/0x3e
   [<f099dcd9>] cdrom_transfer_packet_command+0x76/0xcb [ide_cd]
   [<f099de93>] cdrom_do_pc_continuation+0x2e/0x31 [ide_cd]
   [<f099b234>] cdrom_start_packet_command+0x12f/0x137 [ide_cd]
   [<f099d8fb>] ide_do_rw_cdrom+0x455/0x494 [ide_cd]
   [<c116065c>] ide_do_request+0x521/0x682
   [<c1160cf1>] do_ide_request+0x17/0x1a
   [<c10c5e3c>] elv_insert+0x58/0x135
   [<c10c5f9c>] __elv_add_request+0x83/0x88
   [<c116087c>] ide_do_drive_cmd+0xbf/0x10c
   [<f099b27c>] cdrom_queue_packet_command+0x40/0xc6 [ide_cd]
   [<f099b599>] ide_cdrom_packet+0x86/0xa4 [ide_cd]
   [<f0852668>] cdrom_mode_sense+0x58/0x60 [cdrom]
   [<f099bc00>] ide_cdrom_get_capabilities+0x7d/0x8d [ide_cd]
   [<f099c81d>] ide_cd_probe+0x54a/0xa3b [ide_cd]
   [<c115decb>] generic_ide_probe+0x22/0x24
   [<c1140ece>] driver_probe_device+0x45/0x98
   [<c1141001>] __driver_attach+0x68/0x93
   [<c1140503>] bus_for_each_dev+0x36/0x5b
   [<c1140db0>] driver_attach+0x14/0x17
   [<c11407d9>] bus_add_driver+0x64/0xf3
   [<c11413e6>] driver_register+0x78/0x7d
   [<f087d00d>] ____versions+0x42d/0xfffffec3 [ip6_tables]
   [<c1033937>] sys_init_module+0x16b6/0x17cf
   [<c1002841>] sysenter_past_esp+0x56/0x8d

 -> (&input_pool.lock){++..} ops: 0 {
    initial-use  at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120672f>] _spin_lock_irqsave+0x22/0x32
                          [<c111d723>] account+0x35/0xcb
                          [<c111e212>] extract_entropy+0x28/0x83
                          [<c111dfd4>] xfer_secondary_pool+0xc1/0xfa
                          [<c111e202>] extract_entropy+0x18/0x83
                          [<c111e282>] get_random_bytes+0x15/0x19
                          [<c11b77c2>] neigh_table_init_no_netlink+0x103/0x=
1ba
                          [<c11b7885>] neigh_table_init+0xc/0x5f
                          [<c13c145a>] arp_init+0xd/0x62
                          [<c13c16b7>] inet_init+0x101/0x2cb
                          [<c1000409>] init+0x114/0x293
                          [<c1000bb1>] kernel_thread_helper+0x5/0xb
    in-hardirq-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120672f>] _spin_lock_irqsave+0x22/0x32
                          [<c111d58c>] __add_entropy_words+0x4c/0x161
                          [<c111dc6f>] add_timer_randomness+0x6a/0x106
                          [<c111dd31>] add_disk_randomness+0x26/0x28
                          [<c115f8d5>] ide_end_request+0x9e/0xd8
                          [<f099d41e>] cdrom_end_request+0x10e/0x116 [ide_c=
d]
                          [<f099e49c>] cdrom_pc_intr+0xc9/0x1f4 [ide_cd]
                          [<c1160a10>] ide_intr+0x147/0x1a7
                          [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
                          [<c103cbfb>] __do_IRQ+0x94/0xef
                          [<c1004dab>] do_IRQ+0x9e/0xbf
    in-softirq-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120672f>] _spin_lock_irqsave+0x22/0x32
                          [<c111d58c>] __add_entropy_words+0x4c/0x161
                          [<c111dc6f>] add_timer_randomness+0x6a/0x106
                          [<c111dd31>] add_disk_randomness+0x26/0x28
                          [<c116cf13>] scsi_end_request+0x62/0xa9
                          [<c116d04e>] scsi_io_completion+0xf4/0x2bb
                          [<c117b091>] sd_rw_intr+0x1c0/0x1c8
                          [<c1168f3f>] scsi_finish_command+0x42/0x47
                          [<c116dab5>] scsi_softirq_done+0xab/0xb6
                          [<c10c7dd2>] blk_done_softirq+0x5e/0x6d
                          [<c101cff8>] __do_softirq+0x76/0xee
                          [<c1004caf>] do_softirq+0x61/0xbf
  }
  ... key      at: [<c1294010>] input_pool+0x90/0x100
 ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c120672f>] _spin_lock_irqsave+0x22/0x32
   [<c111d58c>] __add_entropy_words+0x4c/0x161
   [<c111dc6f>] add_timer_randomness+0x6a/0x106
   [<c111dd31>] add_disk_randomness+0x26/0x28
   [<c115f8d5>] ide_end_request+0x9e/0xd8
   [<f099d41e>] cdrom_end_request+0x10e/0x116 [ide_cd]
   [<f099e49c>] cdrom_pc_intr+0xc9/0x1f4 [ide_cd]
   [<c1160a10>] ide_intr+0x147/0x1a7
   [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
   [<c103cbfb>] __do_IRQ+0x94/0xef
   [<c1004dab>] do_IRQ+0x9e/0xbf

 -> (random_read_wait.lock){++..} ops: 0 {
    initial-use  at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120672f>] _spin_lock_irqsave+0x22/0x32
                          [<c1011bb2>] __wake_up+0x13/0x39
                          [<c111dd03>] add_timer_randomness+0xfe/0x106
                          [<c111dd31>] add_disk_randomness+0x26/0x28
                          [<c116cf13>] scsi_end_request+0x62/0xa9
                          [<c116d04e>] scsi_io_completion+0xf4/0x2bb
                          [<c117b091>] sd_rw_intr+0x1c0/0x1c8
                          [<c1168f3f>] scsi_finish_command+0x42/0x47
                          [<c116dab5>] scsi_softirq_done+0xab/0xb6
                          [<c10c7dd2>] blk_done_softirq+0x5e/0x6d
                          [<c101cff8>] __do_softirq+0x76/0xee
                          [<c1004caf>] do_softirq+0x61/0xbf
    in-hardirq-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120672f>] _spin_lock_irqsave+0x22/0x32
                          [<c1011bb2>] __wake_up+0x13/0x39
                          [<c111dd03>] add_timer_randomness+0xfe/0x106
                          [<c111dd31>] add_disk_randomness+0x26/0x28
                          [<c115f8d5>] ide_end_request+0x9e/0xd8
                          [<f099d41e>] cdrom_end_request+0x10e/0x116 [ide_c=
d]
                          [<f099e49c>] cdrom_pc_intr+0xc9/0x1f4 [ide_cd]
                          [<c1160a10>] ide_intr+0x147/0x1a7
                          [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
                          [<c103cbfb>] __do_IRQ+0x94/0xef
                          [<c1004dab>] do_IRQ+0x9e/0xbf
    in-softirq-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120672f>] _spin_lock_irqsave+0x22/0x32
                          [<c1011bb2>] __wake_up+0x13/0x39
                          [<c111dd03>] add_timer_randomness+0xfe/0x106
                          [<c111dd31>] add_disk_randomness+0x26/0x28
                          [<c116cf13>] scsi_end_request+0x62/0xa9
                          [<c116d04e>] scsi_io_completion+0xf4/0x2bb
                          [<c117b091>] sd_rw_intr+0x1c0/0x1c8
                          [<c1168f3f>] scsi_finish_command+0x42/0x47
                          [<c116dab5>] scsi_softirq_done+0xab/0xb6
                          [<c10c7dd2>] blk_done_softirq+0x5e/0x6d
                          [<c101cff8>] __do_softirq+0x76/0xee
                          [<c1004caf>] do_softirq+0x61/0xbf
  }
  ... key      at: [<c1294450>] random_read_wait+0x10/0x40
 ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c120672f>] _spin_lock_irqsave+0x22/0x32
   [<c1011bb2>] __wake_up+0x13/0x39
   [<c111dd03>] add_timer_randomness+0xfe/0x106
   [<c111dd31>] add_disk_randomness+0x26/0x28
   [<c115f8d5>] ide_end_request+0x9e/0xd8
   [<f099d41e>] cdrom_end_request+0x10e/0x116 [ide_cd]
   [<f099e49c>] cdrom_pc_intr+0xc9/0x1f4 [ide_cd]
   [<c1160a10>] ide_intr+0x147/0x1a7
   [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
   [<c103cbfb>] __do_IRQ+0x94/0xef
   [<c1004dab>] do_IRQ+0x9e/0xbf

 -> (&q->lock){++..} ops: 0 {
    initial-use  at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c12065da>] _spin_lock_irq+0x1f/0x2e
                          [<c1204a22>] wait_for_completion+0x29/0xb4
                          [<c10287a7>] keventd_create_kthread+0x2b/0x57
                          [<c102890f>] kthread_create+0x7f/0xbc
                          [<c13b33d8>] migration_call+0x2d/0xb0
                          [<c13b347a>] migration_init+0x1f/0x3f
                          [<c1000333>] init+0x3e/0x293
                          [<c1000bb1>] kernel_thread_helper+0x5/0xb
    in-hardirq-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120672f>] _spin_lock_irqsave+0x22/0x32
                          [<c1011c41>] complete+0x12/0x3e
                          [<c117046f>] ata_qc_complete_internal+0xe/0x10
                          [<c1171794>] __ata_qc_complete+0x1b0/0x1b8
                          [<c117183e>] ata_qc_complete+0xa2/0xa9
                          [<c1172e50>] ata_hsm_qc_complete+0x1b8/0x1c7
                          [<c11734ef>] ata_hsm_move+0x690/0x6a6
                          [<c11735b2>] ata_host_intr+0xad/0xc5
                          [<c117acde>] nv_do_interrupt+0x9a/0xdf
                          [<c117ad75>] nv_ck804_interrupt+0x21/0x30
                          [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
                          [<c103cbfb>] __do_IRQ+0x94/0xef
                          [<c1004dab>] do_IRQ+0x9e/0xbf
    in-softirq-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120672f>] _spin_lock_irqsave+0x22/0x32
                          [<c1011c41>] complete+0x12/0x3e
                          [<c1026cbf>] wakeme_after_rcu+0xb/0xd
                          [<c1026c01>] __rcu_process_callbacks+0x113/0x172
                          [<c1026e8e>] rcu_process_callbacks+0x25/0x44
                          [<c101ce53>] tasklet_action+0x65/0xca
                          [<c101cff8>] __do_softirq+0x76/0xee
                          [<c1004caf>] do_softirq+0x61/0xbf
  }
  ... key      at: [<c1417b74>] __key.13301+0x0/0x8
  -> (&rq->rq_lock_key){++..} ops: 0 {
     initial-use  at:
                            [<c102e39c>] lock_acquire+0x4a/0x6a
                            [<c120672f>] _spin_lock_irqsave+0x22/0x32
                            [<c10129dd>] init_idle+0x5c/0x7a
                            [<c13b33a5>] sched_init+0x173/0x179
                            [<c13a64e3>] start_kernel+0x113/0x391
                            [<00000000>] 0x0
     in-hardirq-W at:
                            [<c102e39c>] lock_acquire+0x4a/0x6a
                            [<c120632a>] _spin_lock+0x19/0x28
                            [<c101436d>] scheduler_tick+0x97/0x327
                            [<c101fb76>] update_process_times+0x55/0x61
                            [<c100c409>] smp_local_timer_interrupt+0x2d/0x30
                            [<c10058f5>] timer_interrupt+0x53/0x7b
                            [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
                            [<c103cbfb>] __do_IRQ+0x94/0xef
                            [<c1004dab>] do_IRQ+0x9e/0xbf
     in-softirq-W at:
                            [<c102e39c>] lock_acquire+0x4a/0x6a
                            [<c120632a>] _spin_lock+0x19/0x28
                            [<c10126d2>] task_rq_lock+0x34/0x5b
                            [<c1013c2c>] try_to_wake_up+0x19/0x361
                            [<c1013f9c>] wake_up_process+0xf/0x11
                            [<c101d056>] __do_softirq+0xd4/0xee
                            [<c1004caf>] do_softirq+0x61/0xbf
   }
   ... key      at: [<c49aa7ec>] 0xc49aa7ec
   -> (&rq->rq_lock_key#2){++..} ops: 0 {
      initial-use  at:
                              [<c102e39c>] lock_acquire+0x4a/0x6a
                              [<c120672f>] _spin_lock_irqsave+0x22/0x32
                              [<c10129dd>] init_idle+0x5c/0x7a
                              [<c1017c9e>] fork_idle+0x3f/0x49
                              [<c13ae919>] smp_boot_cpus+0x4e1/0xd21
                              [<c13af17a>] smp_prepare_cpus+0x21/0x23
                              [<c100032e>] init+0x39/0x293
                              [<c1000bb1>] kernel_thread_helper+0x5/0xb
      in-hardirq-W at:
                              [<c102e39c>] lock_acquire+0x4a/0x6a
                              [<c120632a>] _spin_lock+0x19/0x28
                              [<c101436d>] scheduler_tick+0x97/0x327
                              [<c101fb76>] update_process_times+0x55/0x61
                              [<c100cb16>] smp_apic_timer_interrupt+0x60/0x=
68
                              [<c1003422>] apic_timer_interrupt+0x2a/0x30
                              [<c100174c>] cpu_idle+0x61/0x77
                              [<c100c029>] start_secondary+0x3e8/0x3f3
                              [<00000000>] 0x0
                              [<dfd0efb4>] 0xdfd0efb4
      in-softirq-W at:
                              [<c102e39c>] lock_acquire+0x4a/0x6a
                              [<c120632a>] _spin_lock+0x19/0x28
                              [<c10126d2>] task_rq_lock+0x34/0x5b
                              [<c1013c2c>] try_to_wake_up+0x19/0x361
                              [<c1013f9c>] wake_up_process+0xf/0x11
                              [<c101d056>] __do_softirq+0xd4/0xee
                              [<c1004caf>] do_softirq+0x61/0xbf
    }
    ... key      at: [<c49b27ec>] 0xc49b27ec
   ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c120632a>] _spin_lock+0x19/0x28
   [<c1011aec>] double_lock_balance+0x2f/0x33
   [<c1203e9b>] schedule+0x24e/0x900
   [<c1204b32>] schedule_timeout+0x72/0x90
   [<c1204b68>] schedule_timeout_uninterruptible+0x18/0x1a
   [<c1097c56>] journal_stop+0xda/0x1e1
   [<c1098db3>] journal_force_commit+0x1f/0x25
   [<c109160a>] ext3_force_commit+0x22/0x24
   [<c108ba85>] ext3_write_inode+0x38/0x3e
   [<c1074942>] __writeback_single_inode+0x1bb/0x331
   [<c1074ad4>] sync_inode+0x1c/0x2e
   [<c1089bed>] ext3_sync_file+0xa1/0xb8
   [<c1059571>] do_fsync+0x4a/0x7c
   [<c10595c3>] __do_fsync+0x20/0x2f
   [<c10595df>] sys_fsync+0xd/0xf
   [<c1002841>] sysenter_past_esp+0x56/0x8d

  ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c120632a>] _spin_lock+0x19/0x28
   [<c10126d2>] task_rq_lock+0x34/0x5b
   [<c1013c2c>] try_to_wake_up+0x19/0x361
   [<c1013f7f>] default_wake_function+0xb/0xd
   [<c1011b7b>] __wake_up_common+0x2f/0x53
   [<c1011c5a>] complete+0x2b/0x3e
   [<c10289f1>] kthread+0xa5/0xf0
   [<c1000bb1>] kernel_thread_helper+0x5/0xb

  -> (&rq->rq_lock_key#2){++..} ops: 0 {
     initial-use  at:
                            [<c102e39c>] lock_acquire+0x4a/0x6a
                            [<c120672f>] _spin_lock_irqsave+0x22/0x32
                            [<c10129dd>] init_idle+0x5c/0x7a
                            [<c1017c9e>] fork_idle+0x3f/0x49
                            [<c13ae919>] smp_boot_cpus+0x4e1/0xd21
                            [<c13af17a>] smp_prepare_cpus+0x21/0x23
                            [<c100032e>] init+0x39/0x293
                            [<c1000bb1>] kernel_thread_helper+0x5/0xb
     in-hardirq-W at:
                            [<c102e39c>] lock_acquire+0x4a/0x6a
                            [<c120632a>] _spin_lock+0x19/0x28
                            [<c101436d>] scheduler_tick+0x97/0x327
                            [<c101fb76>] update_process_times+0x55/0x61
                            [<c100cb16>] smp_apic_timer_interrupt+0x60/0x68
                            [<c1003422>] apic_timer_interrupt+0x2a/0x30
                            [<c100174c>] cpu_idle+0x61/0x77
                            [<c100c029>] start_secondary+0x3e8/0x3f3
                            [<00000000>] 0x0
                            [<dfd0efb4>] 0xdfd0efb4
     in-softirq-W at:
                            [<c102e39c>] lock_acquire+0x4a/0x6a
                            [<c120632a>] _spin_lock+0x19/0x28
                            [<c10126d2>] task_rq_lock+0x34/0x5b
                            [<c1013c2c>] try_to_wake_up+0x19/0x361
                            [<c1013f9c>] wake_up_process+0xf/0x11
                            [<c101d056>] __do_softirq+0xd4/0xee
                            [<c1004caf>] do_softirq+0x61/0xbf
   }
   ... key      at: [<c49b27ec>] 0xc49b27ec
  ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c120632a>] _spin_lock+0x19/0x28
   [<c10126d2>] task_rq_lock+0x34/0x5b
   [<c1013c2c>] try_to_wake_up+0x19/0x361
   [<c1013f7f>] default_wake_function+0xb/0xd
   [<c1011b7b>] __wake_up_common+0x2f/0x53
   [<c1011c5a>] complete+0x2b/0x3e
   [<c1013ae3>] migration_thread+0x210/0x236
   [<c1028a10>] kthread+0xc4/0xf0
   [<c1000bb1>] kernel_thread_helper+0x5/0xb

 ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c120672f>] _spin_lock_irqsave+0x22/0x32
   [<c1011c41>] complete+0x12/0x3e
   [<c10c8402>] blk_end_sync_rq+0x1f/0x22
   [<c10c83d0>] end_that_request_last+0xba/0xcd
   [<c115f8f6>] ide_end_request+0xbf/0xd8
   [<f099d41e>] cdrom_end_request+0x10e/0x116 [ide_cd]
   [<f099e49c>] cdrom_pc_intr+0xc9/0x1f4 [ide_cd]
   [<c1160a10>] ide_intr+0x147/0x1a7
   [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
   [<c103cbfb>] __do_IRQ+0x94/0xef
   [<c1004dab>] do_IRQ+0x9e/0xbf

 -> (base_lock_keys + cpu#2){++..} ops: 0 {
    initial-use  at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c12065da>] _spin_lock_irq+0x1f/0x2e
                          [<c101fd1c>] run_timer_softirq+0x3d/0x16e
                          [<c101cff8>] __do_softirq+0x76/0xee
                          [<c1004caf>] do_softirq+0x61/0xbf
    in-hardirq-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120672f>] _spin_lock_irqsave+0x22/0x32
                          [<c101fa88>] lock_timer_base+0x18/0x33
                          [<c101ff3b>] del_timer+0x17/0x49
                          [<c116ad32>] scsi_delete_timer+0xe/0x1f
                          [<c116952e>] scsi_done+0xb/0x19
                          [<c1176cc1>] ata_scsi_qc_complete+0xb0/0xbd
                          [<c1171794>] __ata_qc_complete+0x1b0/0x1b8
                          [<c117183e>] ata_qc_complete+0xa2/0xa9
                          [<c1172e50>] ata_hsm_qc_complete+0x1b8/0x1c7
                          [<c11734ef>] ata_hsm_move+0x690/0x6a6
                          [<c11735b2>] ata_host_intr+0xad/0xc5
                          [<c117acde>] nv_do_interrupt+0x9a/0xdf
                          [<c117ad75>] nv_ck804_interrupt+0x21/0x30
                          [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
                          [<c103cbfb>] __do_IRQ+0x94/0xef
                          [<c1004dab>] do_IRQ+0x9e/0xbf
    in-softirq-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c12065da>] _spin_lock_irq+0x1f/0x2e
                          [<c101fd1c>] run_timer_softirq+0x3d/0x16e
                          [<c101cff8>] __do_softirq+0x76/0xee
                          [<c1004caf>] do_softirq+0x61/0xbf
  }
  ... key      at: [<c1416fc8>] base_lock_keys+0x8/0x40
 ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c120632a>] _spin_lock+0x19/0x28
   [<c101fed0>] __mod_timer+0x83/0xac
   [<c1161313>] __ide_set_handler+0x59/0x61
   [<c1161344>] ide_set_handler+0x29/0x3e
   [<f099dcd9>] cdrom_transfer_packet_command+0x76/0xcb [ide_cd]
   [<f099de93>] cdrom_do_pc_continuation+0x2e/0x31 [ide_cd]
   [<f099b234>] cdrom_start_packet_command+0x12f/0x137 [ide_cd]
   [<f099d8fb>] ide_do_rw_cdrom+0x455/0x494 [ide_cd]
   [<c116065c>] ide_do_request+0x521/0x682
   [<c1160cf1>] do_ide_request+0x17/0x1a
   [<c10c5e3c>] elv_insert+0x58/0x135
   [<c10c5f9c>] __elv_add_request+0x83/0x88
   [<c116087c>] ide_do_drive_cmd+0xbf/0x10c
   [<f099b27c>] cdrom_queue_packet_command+0x40/0xc6 [ide_cd]
   [<f099b35a>] cdrom_check_status+0x58/0x63 [ide_cd]
   [<f099b792>] ide_cdrom_check_media_change_real+0x1d/0x39 [ide_cd]
   [<f0851396>] media_changed+0x3b/0x6a [cdrom]
   [<f08513e9>] cdrom_media_changed+0x24/0x2a [cdrom]
   [<f099ba99>] idecd_media_changed+0x10/0x12 [ide_cd]
   [<c105e5cc>] check_disk_change+0x19/0x6a
   [<f0852fb8>] cdrom_open+0x7d1/0x80d [cdrom]
   [<f099b8fe>] idecd_open+0x83/0xa3 [ide_cd]
   [<c105efe8>] do_open+0xa4/0x3ad
   [<c105f310>] blkdev_open+0x1f/0x4c
   [<c1057c30>] __dentry_open+0xc7/0x1aa
   [<c1057d81>] nameidata_to_filp+0x1c/0x2e
   [<c1057dc1>] do_filp_open+0x2e/0x35
   [<c1057ec7>] do_sys_open+0x38/0x68
   [<c1057f23>] sys_open+0x16/0x18
   [<c1002841>] sysenter_past_esp+0x56/0x8d


the hard-irq-unsafe lock's dependencies:
=2D> (proc_subdir_lock){--..} ops: 0 {
   initial-use  at:
                        [<c102e39c>] lock_acquire+0x4a/0x6a
                        [<c120632a>] _spin_lock+0x19/0x28
                        [<c1080fd6>] xlate_proc_name+0x1b/0x99
                        [<c108138f>] proc_create+0x46/0xdf
                        [<c1081488>] create_proc_entry+0x60/0xa3
                        [<c13b6eb6>] proc_misc_init+0x1c/0x1b0
                        [<c13b6da0>] proc_root_init+0x4c/0xd1
                        [<c13a6649>] start_kernel+0x279/0x391
                        [<00000000>] 0x0
   softirq-on-W at:
                        [<c102e39c>] lock_acquire+0x4a/0x6a
                        [<c120632a>] _spin_lock+0x19/0x28
                        [<c1080fd6>] xlate_proc_name+0x1b/0x99
                        [<c108138f>] proc_create+0x46/0xdf
                        [<c1081488>] create_proc_entry+0x60/0xa3
                        [<c13b6eb6>] proc_misc_init+0x1c/0x1b0
                        [<c13b6da0>] proc_root_init+0x4c/0xd1
                        [<c13a6649>] start_kernel+0x279/0x391
                        [<00000000>] 0x0
   hardirq-on-W at:
                        [<c102e39c>] lock_acquire+0x4a/0x6a
                        [<c120632a>] _spin_lock+0x19/0x28
                        [<c1080fd6>] xlate_proc_name+0x1b/0x99
                        [<c108138f>] proc_create+0x46/0xdf
                        [<c1081488>] create_proc_entry+0x60/0xa3
                        [<c13b6eb6>] proc_misc_init+0x1c/0x1b0
                        [<c13b6da0>] proc_root_init+0x4c/0xd1
                        [<c13a6649>] start_kernel+0x279/0x391
                        [<00000000>] 0x0
 }
 ... key      at: [<c1289610>] proc_subdir_lock+0x10/0x1c
 -> (files_lock){--..} ops: 0 {
    initial-use  at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120632a>] _spin_lock+0x19/0x28
                          [<c105905a>] file_move+0x17/0x3b
                          [<c1057c12>] __dentry_open+0xa9/0x1aa
                          [<c1057d81>] nameidata_to_filp+0x1c/0x2e
                          [<c1057dc1>] do_filp_open+0x2e/0x35
                          [<c1057ec7>] do_sys_open+0x38/0x68
                          [<c1057f23>] sys_open+0x16/0x18
                          [<c13a6e12>] do_name+0xc8/0x1d0
                          [<c13a6fa4>] write_buffer+0x1d/0x2c
                          [<c13a7842>] flush_window+0x64/0xb3
                          [<c13a7be8>] inflate_codes+0x357/0x3b3
                          [<c13a82f1>] inflate_dynamic+0x57f/0x5d9
                          [<c13a8a76>] unpack_to_rootfs+0x4d9/0x8d7
                          [<c13a8ec5>] populate_rootfs+0x51/0xfd
                          [<c10003af>] init+0xba/0x293
                          [<c1000bb1>] kernel_thread_helper+0x5/0xb
    softirq-on-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120632a>] _spin_lock+0x19/0x28
                          [<c105905a>] file_move+0x17/0x3b
                          [<c1057c12>] __dentry_open+0xa9/0x1aa
                          [<c1057d81>] nameidata_to_filp+0x1c/0x2e
                          [<c1057dc1>] do_filp_open+0x2e/0x35
                          [<c1057ec7>] do_sys_open+0x38/0x68
                          [<c1057f23>] sys_open+0x16/0x18
                          [<c13a6e12>] do_name+0xc8/0x1d0
                          [<c13a6fa4>] write_buffer+0x1d/0x2c
                          [<c13a7842>] flush_window+0x64/0xb3
                          [<c13a7be8>] inflate_codes+0x357/0x3b3
                          [<c13a82f1>] inflate_dynamic+0x57f/0x5d9
                          [<c13a8a76>] unpack_to_rootfs+0x4d9/0x8d7
                          [<c13a8ec5>] populate_rootfs+0x51/0xfd
                          [<c10003af>] init+0xba/0x293
                          [<c1000bb1>] kernel_thread_helper+0x5/0xb
    hardirq-on-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120632a>] _spin_lock+0x19/0x28
                          [<c105905a>] file_move+0x17/0x3b
                          [<c1057c12>] __dentry_open+0xa9/0x1aa
                          [<c1057d81>] nameidata_to_filp+0x1c/0x2e
                          [<c1057dc1>] do_filp_open+0x2e/0x35
                          [<c1057ec7>] do_sys_open+0x38/0x68
                          [<c1057f23>] sys_open+0x16/0x18
                          [<c13a6e12>] do_name+0xc8/0x1d0
                          [<c13a6fa4>] write_buffer+0x1d/0x2c
                          [<c13a7842>] flush_window+0x64/0xb3
                          [<c13a7be8>] inflate_codes+0x357/0x3b3
                          [<c13a82f1>] inflate_dynamic+0x57f/0x5d9
                          [<c13a8a76>] unpack_to_rootfs+0x4d9/0x8d7
                          [<c13a8ec5>] populate_rootfs+0x51/0xfd
                          [<c10003af>] init+0xba/0x293
                          [<c1000bb1>] kernel_thread_helper+0x5/0xb
  }
  ... key      at: [<c1329e90>] files_lock+0x10/0x80
  -> (fasync_lock){....} ops: 0 {
     initial-use  at:
                            [<c102e39c>] lock_acquire+0x4a/0x6a
                            [<c12063b2>] _write_lock_irq+0x1f/0x2e
                            [<c1066be0>] fasync_helper+0x3a/0xb7
                            [<c111fa7e>] tty_fasync+0x3d/0xb1
                            [<c1121992>] release_dev+0x4b/0x67d
                            [<c11222be>] tty_release+0x12/0x1c
                            [<c105918e>] __fput+0x59/0xf6
                            [<c1059242>] fput+0x17/0x19
                            [<c1056e93>] filp_close+0x51/0x5b
                            [<c10578df>] sys_close+0x79/0x8d
                            [<c1002841>] sysenter_past_esp+0x56/0x8d
   }
   ... key      at: [<c12881e4>] fasync_lock+0x10/0x1c
  ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c12063b2>] _write_lock_irq+0x1f/0x2e
   [<c1066be0>] fasync_helper+0x3a/0xb7
   [<c111fa7e>] tty_fasync+0x3d/0xb1
   [<c111fb9b>] do_tty_hangup+0xa9/0x2d4
   [<c111fdce>] tty_vhangup+0x8/0xa
   [<c1124e95>] pty_close+0x104/0x109
   [<c1121b36>] release_dev+0x1ef/0x67d
   [<c11222be>] tty_release+0x12/0x1c
   [<c105918e>] __fput+0x59/0xf6
   [<c1059242>] fput+0x17/0x19
   [<c1056e93>] filp_close+0x51/0x5b
   [<c10578df>] sys_close+0x79/0x8d
   [<c1002841>] sysenter_past_esp+0x56/0x8d

 ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c120632a>] _spin_lock+0x19/0x28
   [<c1081255>] remove_proc_entry+0x97/0x18b
   [<c103e305>] unregister_handler_proc+0x1b/0x1d
   [<c103d2b3>] free_irq+0xb7/0xe7
   [<c118b6e9>] i8042_probe+0x144/0x540
   [<c11426d6>] platform_drv_probe+0xf/0x11
   [<c1140ece>] driver_probe_device+0x45/0x98
   [<c1140f29>] __device_attach+0x8/0xa
   [<c11405c4>] bus_for_each_drv+0x38/0x63
   [<c1140f84>] device_attach+0x59/0x6e
   [<c11406cf>] bus_attach_device+0x16/0x2b
   [<c113fa39>] device_add+0x1f9/0x2e7
   [<c11425e5>] platform_device_add+0xdc/0x10c
   [<c13be1b1>] i8042_init+0x2b5/0x2dd
   [<c1000409>] init+0x114/0x293
   [<c1000bb1>] kernel_thread_helper+0x5/0xb

 -> (proc_inum_lock){--..} ops: 0 {
    initial-use  at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120632a>] _spin_lock+0x19/0x28
                          [<c108108a>] proc_register+0x2c/0xfe
                          [<c10814b5>] create_proc_entry+0x8d/0xa3
                          [<c13b6eb6>] proc_misc_init+0x1c/0x1b0
                          [<c13b6da0>] proc_root_init+0x4c/0xd1
                          [<c13a6649>] start_kernel+0x279/0x391
                          [<00000000>] 0x0
    softirq-on-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120632a>] _spin_lock+0x19/0x28
                          [<c108108a>] proc_register+0x2c/0xfe
                          [<c10814b5>] create_proc_entry+0x8d/0xa3
                          [<c13b6eb6>] proc_misc_init+0x1c/0x1b0
                          [<c13b6da0>] proc_root_init+0x4c/0xd1
                          [<c13a6649>] start_kernel+0x279/0x391
                          [<00000000>] 0x0
    hardirq-on-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120632a>] _spin_lock+0x19/0x28
                          [<c108108a>] proc_register+0x2c/0xfe
                          [<c10814b5>] create_proc_entry+0x8d/0xa3
                          [<c13b6eb6>] proc_misc_init+0x1c/0x1b0
                          [<c13b6da0>] proc_root_init+0x4c/0xd1
                          [<c13a6649>] start_kernel+0x279/0x391
                          [<00000000>] 0x0
  }
  ... key      at: [<c128967c>] proc_inum_lock+0x10/0x34
  -> (proc_inum_idr.lock){....} ops: 0 {
     initial-use  at:
                            [<c102e39c>] lock_acquire+0x4a/0x6a
                            [<c120672f>] _spin_lock_irqsave+0x22/0x32
                            [<c10cf68d>] free_layer+0x14/0x2e
                            [<c10cf6cb>] idr_pre_get+0x24/0x33
                            [<c1081078>] proc_register+0x1a/0xfe
                            [<c10814b5>] create_proc_entry+0x8d/0xa3
                            [<c13b6eb6>] proc_misc_init+0x1c/0x1b0
                            [<c13b6da0>] proc_root_init+0x4c/0xd1
                            [<c13a6649>] start_kernel+0x279/0x391
                            [<00000000>] 0x0
   }
   ... key      at: [<c1289660>] proc_inum_idr+0x20/0x2c
  ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c120672f>] _spin_lock_irqsave+0x22/0x32
   [<c10cf652>] alloc_layer+0x12/0x39
   [<c10cf9ae>] idr_get_new_above_int+0x2e/0x1fe
   [<c10cfb8b>] idr_get_new+0xd/0x2a
   [<c1081099>] proc_register+0x3b/0xfe
   [<c10814b5>] create_proc_entry+0x8d/0xa3
   [<c13b6eb6>] proc_misc_init+0x1c/0x1b0
   [<c13b6da0>] proc_root_init+0x4c/0xd1
   [<c13a6649>] start_kernel+0x279/0x391
   [<00000000>] 0x0

 ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c120632a>] _spin_lock+0x19/0x28
   [<c1081177>] free_proc_entry+0x1b/0x62
   [<c1081305>] remove_proc_entry+0x147/0x18b
   [<c103e305>] unregister_handler_proc+0x1b/0x1d
   [<c103d2b3>] free_irq+0xb7/0xe7
   [<c118b6e9>] i8042_probe+0x144/0x540
   [<c11426d6>] platform_drv_probe+0xf/0x11
   [<c1140ece>] driver_probe_device+0x45/0x98
   [<c1140f29>] __device_attach+0x8/0xa
   [<c11405c4>] bus_for_each_drv+0x38/0x63
   [<c1140f84>] device_attach+0x59/0x6e
   [<c11406cf>] bus_attach_device+0x16/0x2b
   [<c113fa39>] device_add+0x1f9/0x2e7
   [<c11425e5>] platform_device_add+0xdc/0x10c
   [<c13be1b1>] i8042_init+0x2b5/0x2dd
   [<c1000409>] init+0x114/0x293
   [<c1000bb1>] kernel_thread_helper+0x5/0xb

 -> (&ptr->list_lock){++..} ops: 0 {
    initial-use  at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120632a>] _spin_lock+0x19/0x28
                          [<c1055b00>] cache_alloc_refill+0x72/0x483
                          [<c1055f8e>] __kmalloc+0x7d/0xa0
                          [<c1055fcc>] alloc_arraycache+0x1b/0x4d
                          [<c105625e>] do_tune_cpucache+0x36/0x20f
                          [<c10565ae>] enable_cpucache+0x59/0x87
                          [<c13b63f4>] kmem_cache_init+0x303/0x33e
                          [<c13a65ee>] start_kernel+0x21e/0x391
                          [<00000000>] 0x0
    in-hardirq-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120632a>] _spin_lock+0x19/0x28
                          [<c1055b00>] cache_alloc_refill+0x72/0x483
                          [<c1055a69>] kmem_cache_alloc+0x57/0x7c
                          [<c1055db4>] cache_alloc_refill+0x326/0x483
                          [<c1055f8e>] __kmalloc+0x7d/0xa0
                          [<c11ae719>] __alloc_skb+0x47/0xf2
                          [<f09bf343>] nv_alloc_rx+0x51/0x16c [forcedeth]
                          [<f09c1892>] nv_nic_irq+0x83/0x196 [forcedeth]
                          [<c103cb3a>] handle_IRQ_event+0x1f/0x4c
                          [<c103cbfb>] __do_IRQ+0x94/0xef
                          [<c1004dab>] do_IRQ+0x9e/0xbf
    in-softirq-W at:
                          [<c102e39c>] lock_acquire+0x4a/0x6a
                          [<c120632a>] _spin_lock+0x19/0x28
                          [<c105551c>] cache_flusharray+0x22/0xa1
                          [<c105560a>] kfree+0x6f/0x9b
                          [<c106e604>] free_fdtable_rcu+0x73/0xd8
                          [<c1026c01>] __rcu_process_callbacks+0x113/0x172
                          [<c1026e8e>] rcu_process_callbacks+0x25/0x44
                          [<c101ce53>] tasklet_action+0x65/0xca
                          [<c101cff8>] __do_softirq+0x76/0xee
                          [<c1004caf>] do_softirq+0x61/0xbf
  }
  ... key      at: [<c15520fc>] __key.15818+0x0/0x8
 ... acquired at:
   [<c102e39c>] lock_acquire+0x4a/0x6a
   [<c120632a>] _spin_lock+0x19/0x28
   [<c105551c>] cache_flusharray+0x22/0xa1
   [<c105560a>] kfree+0x6f/0x9b
   [<c10811ba>] free_proc_entry+0x5e/0x62
   [<c1081305>] remove_proc_entry+0x147/0x18b
   [<c11a2977>] snd_remove_proc_entry+0x13/0x15
   [<c11a2dc7>] snd_info_unregister+0x31/0x48
   [<f0866606>] snd_pcm_free_stream+0x70/0xeb [snd_pcm]
   [<f08666a5>] snd_pcm_free+0x24/0x3b [snd_pcm]
   [<f0866ee9>] snd_pcm_dev_unregister+0xbb/0xc1 [snd_pcm]
   [<c11a5189>] snd_device_free+0x40/0x90
   [<c11a5209>] snd_device_free_all+0x30/0x4f
   [<c11a259b>] snd_card_free+0xd5/0x17e
   [<f09d0689>] 0xf09d0689
   [<c10d88ec>] pci_device_remove+0x19/0x2c
   [<c1140e16>] __device_release_driver+0x63/0x79
   [<c114111c>] driver_detach+0xb2/0xe2
   [<c11408c5>] bus_remove_driver+0x5d/0x79
   [<c11413f6>] driver_unregister+0xb/0x18
   [<c10d882f>] pci_unregister_driver+0x10/0x5f
   [<f09d1841>] 0xf09d1841
   [<c1033fd2>] sys_delete_module+0x195/0x1c5
   [<c1002841>] sysenter_past_esp+0x56/0x8d


stack backtrace:
 [<c1003aa9>] show_trace_log_lvl+0x58/0x16f
 [<c100496f>] show_trace+0xd/0x10
 [<c1004989>] dump_stack+0x17/0x1a
 [<c102ce5a>] check_usage+0x1eb/0x1f8
 [<c102df98>] __lock_acquire+0x81a/0x99c
 [<c102e39c>] lock_acquire+0x4a/0x6a
 [<c120632a>] _spin_lock+0x19/0x28
 [<c10811fe>] remove_proc_entry+0x40/0x18b
 [<c11670c1>] ide_remove_proc_entries+0x20/0x2d
 [<c115e0d2>] ide_unregister_subdriver+0x49/0xc7
 [<f099b7dc>] ide_cd_remove+0xf/0x21 [ide_cd]
 [<c115deea>] generic_ide_remove+0x1d/0x21
 [<c1140e16>] __device_release_driver+0x63/0x79
 [<c114111c>] driver_detach+0xb2/0xe2
 [<c11408c5>] bus_remove_driver+0x5d/0x79
 [<c11413f6>] driver_unregister+0xb/0x18
 [<f099e8b5>] ide_cdrom_exit+0xd/0xf [ide_cd]
 [<c1033fd2>] sys_delete_module+0x195/0x1c5
 [<c1002841>] sysenter_past_esp+0x56/0x8d
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
Leftover inexact backtrace:
 [<c100496f>] show_trace+0xd/0x10
 [<c1004989>] dump_stack+0x17/0x1a
 [<c102ce5a>] check_usage+0x1eb/0x1f8
 [<c102df98>] __lock_acquire+0x81a/0x99c
 [<c102e39c>] lock_acquire+0x4a/0x6a
 [<c120632a>] _spin_lock+0x19/0x28
 [<c10811fe>] remove_proc_entry+0x40/0x18b
 [<c11670c1>] ide_remove_proc_entries+0x20/0x2d
 [<c115e0d2>] ide_unregister_subdriver+0x49/0xc7
 [<f099b7dc>] ide_cd_remove+0xf/0x21 [ide_cd]
 [<c115deea>] generic_ide_remove+0x1d/0x21
 [<c1140e16>] __device_release_driver+0x63/0x79
 [<c114111c>] driver_detach+0xb2/0xe2
 [<c11408c5>] bus_remove_driver+0x5d/0x79
 [<c11413f6>] driver_unregister+0xb/0x18
 [<f099e8b5>] ide_cdrom_exit+0xd/0xf [ide_cd]
 [<c1033fd2>] sys_delete_module+0x195/0x1c5
 [<c1002841>] sysenter_past_esp+0x56/0x8d

--nextPart1626601.oYr4kK8KYi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFCVWQXKSJPmm5/E4RAn0eAKCoBTuRTJBp/4IaJWYMcQ1W5E0hzwCgpw/c
agyiwqcFSi7pekTbbbJ0otg=
=JK54
-----END PGP SIGNATURE-----

--nextPart1626601.oYr4kK8KYi--

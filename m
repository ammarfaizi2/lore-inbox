Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWGAFuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWGAFuT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 01:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWGAFuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 01:50:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:22841 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932939AbWGAFuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 01:50:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nJHS72vgvBKF7TBVlKNByZCX930aLiPo0Abrsi8H390xW7MwbS9QMkjY+SEIOS+lkpf8EO0iw0JuHeqF3cn7f/aV21TGOsRiZTeZnqNRWa3Rg3gluagc2Wk1l6JOWSUFHkmvIqDrqQiJY2tTC6Tt2/kkClC2XD8APOkA4JCl1lA=
Message-ID: <20f65d530606302250q79c485b9y8dfc4d032e4dc091@mail.gmail.com>
Date: Sat, 1 Jul 2006 17:50:15 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: rwlock bad magic, spinlock recursion, spinlock lockup on CPU#0 &
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Previously, we were constantly getting hard freezes on kernel
2.6.14.2. After upgrading to 2.6.16.18, things were very stable (no
crashes for days instead of hours). But today we managed to catch a
hard freeze via serial console. Can anone help us track this one
please?

=========================================
[4705837.744000] BUG: rwlock bad magic on CPU#0, kswapd0/148, cbc6dbcc
[4705837.744000]  [<c01038aa>] show_trace+0x13/0x15
[4705837.744000]  [<c0103984>] dump_stack+0x16/0x18
[4705837.744000]  [<c01be6cf>] rwlock_bug+0x3c/0x41
[4705837.744000]  [<c01be7f5>] _raw_write_lock+0x1b/0x5e
[4705837.744000]  [<c02dee39>] _write_lock_irq+0xa/0xc
[4705837.744000]  [<c013d68a>] remove_mapping+0x1c/0x7f
[4705837.744000]  [<c013d988>] shrink_list+0x29b/0x34c
[4705837.744000]  [<c013db69>] shrink_cache+0x98/0x268
[4705837.744000]  [<c013e16d>] shrink_zone+0xab/0xc2
[4705837.744000]  [<c013e557>] balance_pgdat+0x1e4/0x31a
[4705837.744000]  [<c013e777>] kswapd+0xea/0xef
[4705837.744000]  [<c01012d1>] kernel_thread_helper+0x5/0xb
[4705837.810000] rtc: lost some interrupts at 1024Hz.
[4705863.671000] Unable to handle kernel paging request at virtual
address 1af964c1
[4705863.679000]  printing eip:
[4705863.682000] 1af964c1
[4705863.684000] *pde = 00000000
[4705863.687000] Oops: 0000 [#1]
[4705863.687000] Modules linked in: rt2570 zd1211 autofs4 video button battery a
c uhci_hcd bt878 tuner tvaudio bttv video_buf compat_ioctl32 i2c_algo_bit v4l2_c
ommon btcx_risc ir_common tveeprom videodev i2c_i801 i2c_core snd_intel8x0 snd_a
c97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
 snd_page_alloc e100 mii dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod
[4705863.687000] CPU:    0
[4705863.687000] EIP:    0060:[<1af964c1>]    Not tainted VLI
[4705863.687000] EFLAGS: 00210202   (2.6.16.18 #3)
[4705863.687000] EIP is at 0x1af964c1
[4705863.687000] eax: c19d88af   ebx: f553fda8   ecx: c122b2a0   edx: cbc6dbac
[4705863.687000] esi: 00000000   edi: c17c5490   ebp: f553fd48   esp: f553fd3c
[4705863.687000] ds: 007b   es: 007b   ss: 0068
[4705863.687000] Process mplayer (pid: 7205, threadinfo=f553e000 task=f77f6030)
[4705863.687000] Stack: <0>c0154210 c19d88af c122b2a0 f553fd54 c0136303 c122b2a0
 f553fd70 c02dddc9
[4705863.687000]        c122b2a0 c01362d2 f553fda8 c122b2a0 f553fda4 f553fdd4 c0
1368eb 00000002
[4705863.687000]        f553fda8 f553fd88 0000001c c122b2a0 00000000 00000000 f7
7f6030 c0129991
[4705863.687000] Call Trace:
[4705863.687000]  [<c0103951>] show_stack_log_lvl+0xa5/0xad
[4705863.687000]  [<c0103a8c>] show_registers+0x106/0x16f
[4705863.687000]  [<c0103c2e>] die+0xc1/0x13c
[4705863.687000]  [<c02dfd39>] do_page_fault+0x366/0x50e
[4705863.687000]  [<c01035ef>] error_code+0x4f/0x54
[4705863.687000]  [<c0136303>] sync_page+0x31/0x3b
[4705863.687000]  [<c02dddc9>] __wait_on_bit_lock+0x2f/0x58
[4705863.687000]  [<c01368eb>] __lock_page+0x66/0x6e
[4705863.687000]  [<c0136d4d>] do_generic_mapping_read+0x181/0x386
[4705863.687000]  [<c01371a6>] __generic_file_aio_read+0x161/0x18f
[4705863.687000]  [<c0137216>] generic_file_aio_read+0x42/0x49
[4705863.687000]  [<c014ffc1>] do_sync_read+0xa2/0xd3
[4705863.687000]  [<c0150095>] vfs_read+0xa3/0x143
[4705863.687000]  [<c0150385>] sys_read+0x3a/0x61
[4705863.687000]  [<c0102a87>] sysenter_past_esp+0x54/0x75
[4705863.687000] Code:  Bad EIP value.
[4705863.687000]  <4>rtc: lost some interrupts at 1024Hz.
[4705863.883000] bttv2: timeout: drop=0 irq=30351121/30351121, risc=37bd101c, bi
ts: FMTCHG VSYNC HSYNC RISCI
[4705863.897000] bttv2: reset, reinitialize
[4705863.901000] bttv2: PLL: 28636363 => 35468950 . ok
[4705863.966000] Unable to handle kernel NULL pointer dereference at virtual add
ress 00000000
[4705863.966000]  printing eip:
[4705863.966000] 00000000
[4705863.966000] *pde = 00000000
[4705863.966000] Oops: 0000 [#2]
[4705863.966000] Modules linked in: rt2570 zd1211 autofs4 video button battery a
c uhci_hcd bt878 tuner tvaudio bttv video_buf compat_ioctl32 i2c_algo_bit v4l2_c
ommon btcx_risc ir_common tveeprom videodev i2c_i801 i2c_core snd_intel8x0 snd_a
c97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
 snd_page_alloc e100 mii dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod
[4705863.966000] CPU:    0
[4705863.966000] EIP:    0060:[<00000000>]    Not tainted VLI
[4705863.966000] EFLAGS: 00210002   (2.6.16.18 #3)
[4705863.966000] EIP is at rest_init+0x3feffde0/0x23
[4705863.966000] eax: f553fdb0   ebx: 00000001   ecx: 00000001   edx: f553fdbc
[4705863.966000] esi: 00000000   edi: c17c5490   ebp: eaa07e9c   esp: eaa07e78
[4705863.966000] ds: 007b   es: 007b   ss: 0068
[4705863.966000] Process java (pid: 26272, threadinfo=eaa06000 task=e54bf030)
[4705863.966000] Stack: <0>c0116042 f553fdb0 00000003 00000000 eaa07ed4 00000000
 c17c5490 00000001
[4705863.966000]        00200202 eaa07ec8 c0116082 c17c5490 00000003 00000001 00
000000 eaa07ed4
[4705863.966000]        00000003 c17c5490 e6025c34 e6025c34 eaa07ee0 c01299f7 ea
a07ed4 c105a380
[4705863.966000] Call Trace:
[4705863.966000]  [<c0103951>] show_stack_log_lvl+0xa5/0xad
[4705863.966000]  [<c0103a8c>] show_registers+0x106/0x16f
[4705863.966000]  [<c0103c2e>] die+0xc1/0x13c
[4705863.966000]  [<c02dfd39>] do_page_fault+0x366/0x50e
[4705863.966000]  [<c01035ef>] error_code+0x4f/0x54
[4705863.966000]  [<c0116082>] __wake_up+0x24/0x35
[4705863.966000]  [<c01299f7>] __wake_up_bit+0x2b/0x31
[4705863.966000]  [<c0136839>] unlock_page+0x28/0x2d
[4705863.966000]  [<c014107a>] do_wp_page+0x53/0x2c4
[4705863.966000]  [<c0141f63>] __handle_mm_fault+0x151/0x1b0
[4705863.966000]  [<c02dfb55>] do_page_fault+0x182/0x50e
[4705863.966000]  [<c01035ef>] error_code+0x4f/0x54
[4705863.966000] Code:  Bad EIP value.
[4705863.966000]  <6>note: java[26272] exited with preempt_count 1
[4705863.966000] Debug: sleeping function called from invalid context at include
/linux/rwsem.h:43
[4705863.966000] in_atomic():1, irqs_disabled():1
[4705863.966000]  [<c01038aa>] show_trace+0x13/0x15
[4705863.966000]  [<c0103984>] dump_stack+0x16/0x18
[4705863.966000]  [<c0116dd3>] __might_sleep+0x8b/0x93
[4705863.966000]  [<c012d324>] futex_wake+0x24/0xbe
[4705863.966000]  [<c012df08>] do_futex+0x3c/0x73
[4705863.966000]  [<c012dffa>] sys_futex+0xbb/0xc7
[4705863.966000]  [<c01172d2>] mm_release+0x5b/0x65
[4705863.966000]  [<c011afc4>] exit_mm+0x13/0x104
[4705863.966000]  [<c011b73a>] do_exit+0x178/0x338
[4705863.966000]  [<c0103ca9>] do_divide_error+0x0/0x97
[4705863.966000]  [<c02dfd39>] do_page_fault+0x366/0x50e
[4705863.966000]  [<c01035ef>] error_code+0x4f/0x54
[4705863.966000]  [<c0116082>] __wake_up+0x24/0x35
[4705863.966000]  [<c01299f7>] __wake_up_bit+0x2b/0x31
[4705863.966000]  [<c0136839>] unlock_page+0x28/0x2d
[4705863.966000]  [<c014107a>] do_wp_page+0x53/0x2c4
[4705863.966000]  [<c0141f63>] __handle_mm_fault+0x151/0x1b0
[4705863.966000]  [<c02dfb55>] do_page_fault+0x182/0x50e
[4705863.966000]  [<c01035ef>] error_code+0x4f/0x54
[4705864.268000] BUG: spinlock recursion on CPU#0, java/26272
[4705864.268000]  lock: c17c5490, .magic: dead4ead, .owner: java/26272, .owner_c
pu: 0
[4705864.268000]  [<c01038aa>] show_trace+0x13/0x15
[4705864.268000]  [<c0103984>] dump_stack+0x16/0x18
[4705864.268000]  [<c01be4cb>] spin_bug+0x7f/0x86
[4705864.268000]  [<c01be59e>] _raw_spin_lock+0x37/0x72
[4705864.268000]  [<c02dedb6>] _spin_lock_irqsave+0xd/0x14
[4705864.268000]  [<c0116071>] __wake_up+0x13/0x35
[4705864.268000]  [<c01299f7>] __wake_up_bit+0x2b/0x31
[4705864.268000]  [<c0136839>] unlock_page+0x28/0x2d
[4705864.268000]  [<c016ee5c>] mpage_end_io_read+0x50/0x65
[4705864.268000]  [<c0155204>] bio_endio+0x50/0x5a
[4705864.268000]  [<f883024e>] dec_pending+0x4c/0x64 [dm_mod]
[4705864.268000]  [<f88302f0>] clone_endio+0x8a/0x9b [dm_mod]
[4705864.268000]  [<c0155204>] bio_endio+0x50/0x5a
[4705864.268000]  [<c01b1339>] __end_that_request_first+0x15c/0x28e
[4705864.268000]  [<c01b1480>] end_that_request_first+0x15/0x17
[4705864.268000]  [<c0240b1e>] __ide_end_request+0x7e/0xc2
[4705864.268000]  [<c0240b95>] ide_end_request+0x33/0x4b
[4705864.268000]  [<c0247a37>] ide_dma_intr+0x5a/0x96
[4705864.268000]  [<c0242319>] ide_intr+0xc6/0x126
[4705864.268000]  [<c01357a5>] handle_IRQ_event+0x26/0x56
[4705864.268000]  [<c013584e>] __do_IRQ+0x79/0xcf
[4705864.268000]  [<c0104811>] do_IRQ+0x45/0x56
[4705864.268000]  [<c0103526>] common_interrupt+0x1a/0x20
[4705864.268000]  [<c011d79d>] do_softirq+0x25/0x2a
[4705864.268000]  [<c011d82e>] irq_exit+0x2c/0x2e
[4705864.268000]  [<c0104816>] do_IRQ+0x4a/0x56
[4705864.268000]  [<c0103526>] common_interrupt+0x1a/0x20
[4705864.268000]  [<c011b585>] exit_notify+0x224/0x261
[4705864.268000]  [<c011b8ce>] do_exit+0x30c/0x338
[4705864.268000]  [<c0103ca9>] do_divide_error+0x0/0x97
[4705864.268000]  [<c02dfd39>] do_page_fault+0x366/0x50e
[4705864.268000]  [<c01035ef>] error_code+0x4f/0x54
[4705864.268000]  [<c0116082>] __wake_up+0x24/0x35
[4705864.268000]  [<c01299f7>] __wake_up_bit+0x2b/0x31
[4705864.268000]  [<c0136839>] unlock_page+0x28/0x2d
[4705864.268000]  [<c014107a>] do_wp_page+0x53/0x2c4
[4705864.268000]  [<c0141f63>] __handle_mm_fault+0x151/0x1b0
[4705864.268000]  [<c02dfb55>] do_page_fault+0x182/0x50e
[4705864.268000]  [<c01035ef>] error_code+0x4f/0x54
[4705864.268000] BUG: spinlock lockup on CPU#0, java/26272, c17c5490
[4705864.268000]  [<c01038aa>] show_trace+0x13/0x15
[4705864.268000]  [<c0103984>] dump_stack+0x16/0x18
[4705864.268000]  [<c01be55a>] __spin_lock_debug+0x88/0x95
[4705864.268000]  [<c01be5c5>] _raw_spin_lock+0x5e/0x72
[4705864.268000]  [<c02dedb6>] _spin_lock_irqsave+0xd/0x14
[4705864.268000]  [<c0116071>] __wake_up+0x13/0x35
[4705864.268000]  [<c01299f7>] __wake_up_bit+0x2b/0x31
[4705864.268000]  [<c0136839>] unlock_page+0x28/0x2d
[4705864.268000]  [<c016ee5c>] mpage_end_io_read+0x50/0x65
[4705864.268000]  [<c0155204>] bio_endio+0x50/0x5a
[4705864.268000]  [<f883024e>] dec_pending+0x4c/0x64 [dm_mod]
[4705864.268000]  [<f88302f0>] clone_endio+0x8a/0x9b [dm_mod]
[4705864.268000]  [<c0155204>] bio_endio+0x50/0x5a
[4705864.268000]  [<c01b1339>] __end_that_request_first+0x15c/0x28e
[4705864.268000]  [<c01b1480>] end_that_request_first+0x15/0x17
[4705864.268000]  [<c0240b1e>] __ide_end_request+0x7e/0xc2
[4705864.268000]  [<c0240b95>] ide_end_request+0x33/0x4b
[4705864.268000]  [<c0247a37>] ide_dma_intr+0x5a/0x96
[4705864.268000]  [<c0242319>] ide_intr+0xc6/0x126
[4705864.268000]  [<c01357a5>] handle_IRQ_event+0x26/0x56
[4705864.268000]  [<c013584e>] __do_IRQ+0x79/0xcf
[4705864.268000]  [<c0104811>] do_IRQ+0x45/0x56
[4705864.268000]  [<c0103526>] common_interrupt+0x1a/0x20
[4705864.268000]  [<c011d79d>] do_softirq+0x25/0x2a
[4705864.268000]  [<c011d82e>] irq_exit+0x2c/0x2e
[4705864.268000]  [<c0104816>] do_IRQ+0x4a/0x56
[4705864.268000]  [<c0103526>] common_interrupt+0x1a/0x20
[4705864.268000]  [<c011b585>] exit_notify+0x224/0x261
[4705864.268000]  [<c011b8ce>] do_exit+0x30c/0x338
[4705864.268000]  [<c0103ca9>] do_divide_error+0x0/0x97
[4705864.268000]  [<c02dfd39>] do_page_fault+0x366/0x50e
[4705864.268000]  [<c01035ef>] error_code+0x4f/0x54
[4705864.268000]  [<c0116082>] __wake_up+0x24/0x35
[4705864.268000]  [<c01299f7>] __wake_up_bit+0x2b/0x31
[4705864.268000]  [<c0136839>] unlock_page+0x28/0x2d
[4705864.268000]  [<c014107a>] do_wp_page+0x53/0x2c4
[4705864.268000]  [<c0141f63>] __handle_mm_fault+0x151/0x1b0
[4705864.268000]  [<c02dfb55>] do_page_fault+0x182/0x50e
[4705864.268000]  [<c01035ef>] error_code+0x4f/0x54
=========================================

Regards
Keith

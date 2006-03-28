Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWC1AvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWC1AvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWC1AvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:51:09 -0500
Received: from rtr.ca ([64.26.128.89]:7327 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932122AbWC1AvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:51:08 -0500
Message-ID: <44288882.4020809@rtr.ca>
Date: Mon, 27 Mar 2006 19:51:14 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.16-git4: kernel BUG at block/ll_rw_blk.c:3497
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This popped up during heavy RAID5 testing today (2.6.16-git4).
The SATA drives are being run by a modified sata_mv that I'm testing,
and it seems to be behaving now, except for the BUG below:

Cheers

------------[ cut here ]------------
kernel BUG at block/ll_rw_blk.c:3497!
invalid opcode: 0000 [#1]
PREEMPT SMP
Modules linked in: sata_mv libata raid5 xor snd_pcm_oss snd_pcm snd_timer 
snd_page_alloc snd_mixer_oss snd soundcore edd pl2303 usbserial usblp usbhid 
evdev joydev sg sr_mod ide_cd cdrom af_packet ohci_hcd sworks_agp agpgart e100 
mii i2c_piix4 i2c_core usbcore sd_mod dm_mod scsi_mod
CPU:    1
EIP:    0060:[<b0209e76>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16-git4 #1)
EIP is at put_io_context+0x66/0x80
eax: 00000000   ebx: b1ac096c   ecx: e3ced12c   edx: ef25b798
esi: ed72a570   edi: ed72aa20   ebp: 00000000   esp: d2619f78
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 16399, threadinfo=d2618000 task=ed72a570)
Stack: <0>b19acba0 b0124ea5 00000004 d2619fbc d2619fbc b035c26b 00000001 00000000
        e043b660 d2618000 00000000 b0125097 00000000 3abf1f04 3abf1f04 d2618000
        b0102e1b 00000000 00000000 00000000 3abf1f04 3abf1f04 aff1e8d8 000000fc
Call Trace:
  [<b0124ea5>] do_exit+0x295/0x410
  [<b0125097>] do_group_exit+0x37/0xa0
  [<b0102e1b>] sysenter_past_esp+0x54/0x75
Code: 75 22 b8 00 e0 ff ff 21 e0 ff 48 14 8b 40 08 a8 08 75 24 89 da 5b a1 44 b8 
46 b0 e9 65 6a f5 ff ff d2 eb d0 90 ff d2 eb d9 5b c3 <0f> 0b a9 0d 2c ac 36 b0 
89 f6 eb 9b e8 79 f2 12 00 eb d5 8d b4
  <1>Fixing recursive fault but reboot is needed!

... later on ...

Unable to handle kernel paging request at virtual address 00100104
  printing eip:
b0212078
*pde = 00000000
Oops: 0002 [#2]
PREEMPT SMP
Modules linked in: sata_mv libata raid5 xor snd_pcm_oss snd_pcm snd_timer 
snd_page_alloc snd_mixer_oss snd soundcore edd pl2303 usbserial usblp usbhid 
evdev joydev sg sr_mod ide_cd cdrom af_packet ohci_hcd sworks_agp agpgart e100 
mii i2c_piix4 i2c_core usbcore sd_mod dm_mod scsi_mod
CPU:    1
EIP:    0060:[<b0212078>]    Not tainted VLI
EFLAGS: 00010206   (2.6.16-git4 #1)
EIP is at cfq_get_io_context+0xd8/0x1a0
eax: 00100100   ebx: ef25b7e4   ecx: efce7a80   edx: 00200200
esi: ef25b208   edi: e3ced000   ebp: b1ac0480   esp: efd01a08
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 64, threadinfo=efd00000 task=efcb5590)
Stack: <0>00000010 b03a9508 efcb5590 e3ced000 00000000 b02129c4 00011200 00000000
        b01464aa 00000001 ef25b76c cbf9e094 ee47e7fc b03a9508 ee47e7fc 00000001
        ee47e80c b020526c 00000010 cbf9e094 ee47e7fc b0208277 00000010 00000001
Call Trace:
  [<b02129c4>] cfq_set_request+0x54/0x1f0
  [<b01464aa>] mempool_alloc+0x2a/0xe0
  [<b020526c>] elv_set_request+0x3c/0x50
  [<b0208277>] get_request+0x247/0x2b0
  [<b02082fb>] get_request_wait+0x1b/0x120
  [<b0208f4d>] __make_request+0x9d/0x420
  [<f0ba08f5>] xor_block+0xc5/0xe0 [xor]
  [<b0209437>] generic_make_request+0xe7/0x160
  [<f0baee96>] handle_stripe+0x12c6/0x1470 [raid5]
  [<f0bacc79>] raid5_build_block+0x29/0x90 [raid5]
  [<f0bac3f5>] init_stripe+0x125/0x150 [raid5]
  [<f0baf67f>] make_request+0x28f/0x300 [raid5]
  [<b01366c0>] autoremove_wake_function+0x0/0x50
  [<b01366c0>] autoremove_wake_function+0x0/0x50
  [<b0209437>] generic_make_request+0xe7/0x160
  [<b01604ba>] cache_alloc_refill+0x1da/0x240
  [<b0209500>] submit_bio+0x50/0xe0
  [<b0168f29>] bio_alloc_bioset+0x89/0x170
  [<b01687ce>] submit_bh+0x13e/0x190
  [<b0166cb4>] __block_write_full_page+0x204/0x370
  [<b01c09f0>] ext2_get_block+0x0/0x370
  [<b01685f9>] block_write_full_page+0xe9/0x100
  [<b01c09f0>] ext2_get_block+0x0/0x370
  [<b014c0f1>] pageout+0xc1/0x140
  [<b014c1fe>] remove_mapping+0x8e/0xb0
  [<b014c411>] shrink_list+0x1f1/0x410
  [<b014b075>] __pagevec_release+0x15/0x20
  [<b014cd6d>] refill_inactive_zone+0x39d/0x420
  [<b014c7a3>] shrink_cache+0xb3/0x2e0
  [<b014bdf9>] shrink_slab+0x99/0x1e0
  [<b0149475>] throttle_vm_writeout+0x35/0x70
  [<b014ce94>] shrink_zone+0xa4/0xd0
  [<b014d39f>] balance_pgdat+0x28f/0x3e0
  [<b014d5cd>] kswapd+0xdd/0x130
  [<b01366c0>] autoremove_wake_function+0x0/0x50
  [<b0102d52>] ret_from_fork+0x6/0x14
  [<b01366c0>] autoremove_wake_function+0x0/0x50
  [<b014d4f0>] kswapd+0x0/0x130
  [<b01011fd>] kernel_thread_helper+0x5/0x18
Code: e8 93 3a b0 89 4a 04 89 97 2c 01 00 00 e8 41 8a 12 00 89 de 89 f0 5a 5b 5e 
5f 5d c3 b8 e8 93 3a b0 e8 7d 87 12 00 8b 53 04 8b 03 <89> 50 04 89 02 b8 e8 93 
3a b0 c7 03 00 01 10 00 c7 43 04 00 02
  <6>note: kswapd0[64] exited with preempt_count 1

Unable to handle kernel paging request at virtual address 00100100
  printing eip:
b0211ac9
*pde = 00000000
Oops: 0000 [#3]
PREEMPT SMP
Modules linked in: sata_mv libata raid5 xor snd_pcm_oss snd_pcm snd_timer 
snd_page_alloc snd_mixer_oss snd soundcore edd pl2303 usbserial usblp usbhid 
evdev joydev sg sr_mod ide_cd cdrom af_packet ohci_hcd sworks_agp agpgart e100 
mii i2c_piix4 i2c_core usbcore sd_mod dm_mod scsi_mod
CPU:    1
EIP:    0060:[<b0211ac9>]    Not tainted VLI
EFLAGS: 00010096   (2.6.16-git4 #1)
EIP is at cfq_exit_io_context+0x29/0x50
eax: ef25b7e4   ebx: 00100100   ecx: ef25b540   edx: ef25b48c
esi: ef25b208   edi: 00000286   ebp: 0000000b   esp: efd018f4
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 64, threadinfo=efd00000 task=efcb5590)
Stack: <0>efd00000 00000292 b1ac0480 b0209f16 b19acba0 efcb5590 efcb5a40 b0124ea5
        b035d520 efcb5734 00000040 00000001 00000001 efd00000 00000000 ffffffff
        0000000b b01041b3 b037494a b035c2cd 00000002 00000002 00000202 efd019d4
Call Trace:
  [<b0209f16>] exit_io_context+0x86/0xa0
  [<b0124ea5>] do_exit+0x295/0x410
  [<b01041b3>] die+0x193/0x1a0
  [<b01185e0>] do_page_fault+0x0/0x527
  [<b01185e0>] do_page_fault+0x0/0x527
  [<b0118973>] do_page_fault+0x393/0x527
  [<b01185e0>] do_page_fault+0x0/0x527
  [<b010399b>] error_code+0x4f/0x54
  [<b0212078>] cfq_get_io_context+0xd8/0x1a0
  [<b02129c4>] cfq_set_request+0x54/0x1f0
  [<b01464aa>] mempool_alloc+0x2a/0xe0
  [<b020526c>] elv_set_request+0x3c/0x50
  [<b0208277>] get_request+0x247/0x2b0
  [<b02082fb>] get_request_wait+0x1b/0x120
  [<b0208f4d>] __make_request+0x9d/0x420
  [<f0ba08f5>] xor_block+0xc5/0xe0 [xor]
  [<b0209437>] generic_make_request+0xe7/0x160
  [<f0baee96>] handle_stripe+0x12c6/0x1470 [raid5]
  [<f0bacc79>] raid5_build_block+0x29/0x90 [raid5]
  [<f0bac3f5>] init_stripe+0x125/0x150 [raid5]
  [<f0baf67f>] make_request+0x28f/0x300 [raid5]
  [<b01366c0>] autoremove_wake_function+0x0/0x50
  [<b01366c0>] autoremove_wake_function+0x0/0x50
  [<b0209437>] generic_make_request+0xe7/0x160
  [<b01604ba>] cache_alloc_refill+0x1da/0x240
  [<b0209500>] submit_bio+0x50/0xe0
  [<b0168f29>] bio_alloc_bioset+0x89/0x170
  [<b01687ce>] submit_bh+0x13e/0x190
  [<b0166cb4>] __block_write_full_page+0x204/0x370
  [<b01c09f0>] ext2_get_block+0x0/0x370
  [<b01685f9>] block_write_full_page+0xe9/0x100
  [<b01c09f0>] ext2_get_block+0x0/0x370
  [<b014c0f1>] pageout+0xc1/0x140
  [<b014c1fe>] remove_mapping+0x8e/0xb0
  [<b014c411>] shrink_list+0x1f1/0x410
  [<b014b075>] __pagevec_release+0x15/0x20
  [<b014cd6d>] refill_inactive_zone+0x39d/0x420
  [<b014c7a3>] shrink_cache+0xb3/0x2e0
  [<b014bdf9>] shrink_slab+0x99/0x1e0
  [<b0149475>] throttle_vm_writeout+0x35/0x70
  [<b014ce94>] shrink_zone+0xa4/0xd0
  [<b014d39f>] balance_pgdat+0x28f/0x3e0
  [<b014d5cd>] kswapd+0xdd/0x130
  [<b01366c0>] autoremove_wake_function+0x0/0x50
  [<b0102d52>] ret_from_fork+0x6/0x14
  [<b01366c0>] autoremove_wake_function+0x0/0x50
  [<b014d4f0>] kswapd+0x0/0x130
  [<b01011fd>] kernel_thread_helper+0x5/0x18
Code: 00 00 57 56 89 c6 53 9c 5f fa b8 e8 93 3a b0 e8 3e 8d 12 00 8b 1e 8b 03 0f 
18 00 90 39 f3 74 15 89 f6 89 d8 e8 b9 fe ff ff 8b 1b <8b> 03 0f 18 00 90 39 f3 
75 ed 89 f0 e8 a6 fe ff ff b8 e8 93 3a
  <1>Fixing recursive fault but reboot is needed!

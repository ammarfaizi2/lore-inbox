Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVFTNIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVFTNIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 09:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVFTNIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 09:08:41 -0400
Received: from alog0472.analogic.com ([208.224.222.248]:693 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261228AbVFTNHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 09:07:49 -0400
Date: Mon, 20 Jun 2005 09:07:34 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux-2.6.12
Message-ID: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Attempts to run a driver that worked up to 2.6.11.9 shows that
it aparently is no longer possible to nest calls to `down`.
In other words, a procedure that has taken a semaphore can't
then take another semaphore.

 	down(&first_resource);
 	down(&second_resource);
 	...
 	...
 	up(&second_resource);
 	up(&first_resource);


The error is 'sleeping function called from invalid context....'

------------[ cut here ]------------
kernel BUG at mm/memory.c:1112!
invalid operand: 0000 [#1]
PREEMPT SMP 
Modules linked in: HeavyLink parport_pc lp parport autofs4 rfcomm l2cap bluetooth nfsd exportfs lockd sunrpc e100 mii ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables floppy sg sr_mod microcode nls_cp437 msdos fat dm_mod uhci_hcd ehci_hcd video container button battery ac rtc ipv6 ext3 jbd ata_piix libata aic7xxx scsi_transport_spi sd_mod scsi_mod
CPU:    0
EIP:    0060:[<c01577f0>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12) 
EIP is at remap_pte_range+0x70/0x80
eax: ff000000   ebx: 00034484   ecx: 0000000c   edx: ddcff204
esi: 24481000   edi: 24001fe0   ebp: 00000027   esp: e02e1ea0
ds: 007b   es: 007b   ss: 0068
Process ftest (pid: 5159, threadinfo=e02e0000 task=eebc4550)
Stack: 24000000 e0a33240 24001fe0 24001fe0 c01578b4 ee37d800 e0a33240 24000000
        24001fe0 00034003 00000027 24001fdf fffffff4 ee37d840 ee37d800 00000000
        eea9ee34 dfd98000 04001fe0 f0ab6561 eea9ee34 20000000 00010003 04001fe0 
Call Trace:
  [<c01578b4>] remap_pfn_range+0xb4/0x100
  [<f0ab6561>] dma_buffer+0x35729/0x36c50 [HeavyLink]
  [<c015ade6>] get_unmapped_area+0x56/0xb0
  [<c015a707>] do_mmap_pgoff+0x3a7/0x7f0
  [<c017bb37>] do_ioctl+0x77/0xa0
  [<c010aa8e>] sys_mmap2+0x9e/0xe0
  [<c01043cb>] sysenter_past_esp+0x54/0x75
Code: d8 c1 e0 05 01 c8 8b 00 f6 c4 08 74 09 89 d8 c1 e0 0c 09 e8 89 02 81 c6 00 10 00 00 43 83 c2 04 39 fe 75 c7 31 c0 5b 5e 5f 5d c3 <0f> 0b 58 04 07 37 35 c0 eb bc 8d b6 00 00 00 00 55 57 56 53 83
  <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
  [<c011f417>] __might_sleep+0xa7/0xb0
  [<c0122b31>] profile_task_exit+0x21/0x60
  [<c0124c7a>] do_exit+0x1a/0x3a0
  [<c012007b>] copy_files+0xb/0x320
  [<c0105728>] die+0x188/0x190
  [<c0105b00>] do_invalid_op+0x0/0xd0
  [<c0105bb2>] do_invalid_op+0xb2/0xd0
  [<c0104f3b>] error_code+0x4f/0x54
  [<c01577f0>] remap_pte_range+0x70/0x80
  [<c014c760>] prep_new_page+0x60/0x70
  [<c014cd49>] buffered_rmqueue+0x119/0x270
  [<c014d243>] __alloc_pages+0x2f3/0x4a0
  [<c0104f3b>] error_code+0x4f/0x54
  [<c01577f0>] remap_pte_range+0x70/0x80
  [<c01578b4>] remap_pfn_range+0xb4/0x100
  [<f0ab6561>] dma_buffer+0x35729/0x36c50 [HeavyLink]
  [<c015ade6>] get_unmapped_area+0x56/0xb0
  [<c015a707>] do_mmap_pgoff+0x3a7/0x7f0
  [<c017bb37>] do_ioctl+0x77/0xa0
  [<c010aa8e>] sys_mmap2+0x9e/0xe0
  [<c01043cb>] sysenter_past_esp+0x54/0x75
note: ftest[5159] exited with preempt_count 1
scheduling while atomic: ftest/0x00000001/5159
  [<c033af54>] schedule+0xcc4/0xcd0
  [<c012259e>] release_console_sem+0x7e/0xc0
  [<c01223cd>] vprintk+0x19d/0x250
  [<c033bc7d>] rwsem_down_read_failed+0xad/0x1a0
  [<c01043cb>] sysenter_past_esp+0x54/0x75
  [<c0126060>] .text.lock.exit+0x27/0x87
  [<c0124d27>] do_exit+0xc7/0x3a0
  [<c0105728>] die+0x188/0x190
  [<c0105b00>] do_invalid_op+0x0/0xd0
  [<c0105bb2>] do_invalid_op+0xb2/0xd0
  [<c0104f3b>] error_code+0x4f/0x54
  [<c01577f0>] remap_pte_range+0x70/0x80
  [<c014c760>] prep_new_page+0x60/0x70
  [<c014cd49>] buffered_rmqueue+0x119/0x270
  [<c014d243>] __alloc_pages+0x2f3/0x4a0
  [<c0104f3b>] error_code+0x4f/0x54
  [<c01577f0>] remap_pte_range+0x70/0x80
  [<c01578b4>] remap_pfn_range+0xb4/0x100
  [<f0ab6561>] dma_buffer+0x35729/0x36c50 [HeavyLink]
  [<c015ade6>] get_unmapped_area+0x56/0xb0
  [<c015a707>] do_mmap_pgoff+0x3a7/0x7f0
  [<c017bb37>] do_ioctl+0x77/0xa0
  [<c010aa8e>] sys_mmap2+0x9e/0xe0
  [<c01043cb>] sysenter_past_esp+0x54/0x75


Is this new rule permanent or just a bug?




Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

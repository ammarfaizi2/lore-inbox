Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVLOQV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVLOQV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVLOQV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:21:59 -0500
Received: from L8R.net ([216.58.41.32]:4516 "EHLO l8r.net")
	by vger.kernel.org with ESMTP id S1750746AbVLOQV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:21:59 -0500
Date: Thu, 15 Dec 2005 11:21:55 -0500
From: Brad Barnett <lists@l8r.net>
To: linux-kernel@vger.kernel.org
Subject: ahci + software raid (intel E7221, supermicro P8SCT) causes kernel
 BUG at drivers/scsi/scsi.c:295
Message-ID: <20051215112155.57a2a0bb@be.back.l8r.net>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any additional information anyone would like?  Any suggestions on
this bug?  I currently have a reproducible problem, on a system I can
monkey with for the next week or two.

After that, it will have to move into production, and I won't be able to
do much with it. :/  

Thanks


-------------------------------


Supermicro P8SCT:

http://supermicro.com/products/motherboard/P4/E7221/P8SCT.cfm

(uses intel E7221/ahci for SATA controller).  Hot-swap raid cage.  Three
SATA ports in use.  Also have two MegaRAID SATA 150-6 onboard, one in
PCI-X slot.

This box will run stable, but at inconsistent times lock up.  After
hooking up serial console, we discovered the problem.

FYI, we have three different motherboards from Supermicro, and they all
exhibit the same issue... it is unlikely a fault with our specific
hardware.

It is easiest to trigger this bug (not certain if this is the only way)
when running software raid, two drives, in stripe mode.  Many times this
configuration will cause no isses, other times I get this:

  ata2: handling error/timeout
ata2: port reset, p_is 0 is 0 pis 0 cmd 4017 tf d0 ss 113 se 0
ata2: status=0x50 { DriveReady SeekComplete }
sdb: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
Assertion failed! qc->flags &
ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=351
3
------------[ cut here ]------------
kernel BUG at drivers/scsi/scsi.c:295!
invalid operand: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c02d54c1>]    Not tainted VLI
EFLAGS: 00010046   (2.6.15-rc2)
EIP is at scsi_put_command+0x8b/0x95
eax: f7f69d90   ebx: f7f98680   ecx: f7f9868c   edx: f7f9868c
esi: f7f8c000   edi: 00000296   ebp: f7f69c00   esp: f7ff7c0c
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_3 (pid: 858, threadinfo=f7ff6000 task=f7ea9030)
Stack: f7f69df8 c0225720 f7f98680 f7f69d90 f7f62dfc f7f62dfc c02d9cdf
f7f98680       efadda7c f7f98680 00000282 c02d9e05 f7f98680 00000001
00000000 efadda7c       f7f98680 00000000 f7f98680 c02da0df f7f98680
00000001 00000000 00000001 Call Trace:
 [<c0225720>] kobject_get+0x1a/0x24
 [<c02d9cdf>] scsi_next_command+0x2f/0x4f
 [<c02d9e05>] scsi_end_request+0xc4/0xd6
 [<c02da0df>] scsi_io_completion+0x19a/0x41e
 [<c036448e>] sd_rw_intr+0xc6/0x26d
 [<c02d5bc7>] scsi_finish_command+0x82/0xa2
 [<c035b708>] ata_scsi_qc_complete+0x47/0x8d
 [<c0358eb0>] ata_qc_complete+0x40/0xc6
 [<c035cfd9>] ahci_interrupt+0x107/0x1e3
 [<c0112089>] activate_task+0x6d/0x80
 [<c01321d1>] handle_IRQ_event+0x2e/0x64
 [<c013225a>] __do_IRQ+0x53/0xa5
 [<c011d606>] update_process_times+0x7b/0x106
 [<c010455c>] do_IRQ+0x19/0x24
 [<c0102fda>] common_interrupt+0x1a/0x20
 [<c0119bc3>] __do_softirq+0x2f/0x8a
 [<c0119c44>] do_softirq+0x26/0x28
 [<c0104561>] do_IRQ+0x1e/0x24
 [<c0102fda>] common_interrupt+0x1a/0x20
 [<c02daa73>] scsi_request_fn+0x1a9/0x2c2
 [<c0218c27>] blk_run_queue+0x3a/0x3c
 [<c02d9ce7>] scsi_next_command+0x37/0x4f
 [<c02d9e05>] scsi_end_request+0xc4/0xd6
 [<c02da0df>] scsi_io_completion+0x19a/0x41e
 [<c036448e>] sd_rw_intr+0xc6/0x26d
 [<c02d5bc7>] scsi_finish_command+0x82/0xa2
 [<c035b708>] ata_scsi_qc_complete+0x47/0x8d
 [<c0358eb0>] ata_qc_complete+0x40/0xc6
 [<c035cea6>] ahci_eng_timeout+0x85/0xb0
 [<c02d91fb>] scsi_error_handler+0x0/0x99
 [<c035af32>] ata_scsi_error+0x1a/0x31
 [<c02d925a>] scsi_error_handler+0x5f/0x99
 [<c012706d>] kthread+0xb1/0xb7
 [<c0126fbc>] kthread+0x0/0xb7
 [<c0101329>] kernel_thread_helper+0x5/0xb
Code: 5c 24 08 8b 74 24 0c 89 44 24 1c 8b 7c 24 10 8b 6c 24 14 83 c4 18 e9
cd b1 fc ff 89 43 0c 89 48 04 31 db 89 51 04 89 4e 14 eb b7 <0f> 0b 27 01
3f ce 47 c0 eb 95 57
 <0>Kernel panic - not syncing: Fatal exception in interrupt




Put another way, I can setup, prep and create a software raid.. format
it.. and start to move data onto it.  I can even use it for quite some
time.  However, once the above happens once, I can not use that software
raid again until I wipe out the raid and start fresh.  Merely booting with
the raid in causes the above problem on bootup...


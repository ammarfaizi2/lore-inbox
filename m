Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTFXIgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 04:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTFXIgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 04:36:14 -0400
Received: from mail.consultit.no ([213.239.74.125]:26349 "EHLO
	kosat.consultit.no") by vger.kernel.org with ESMTP id S261153AbTFXIgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 04:36:10 -0400
Date: Tue, 24 Jun 2003 10:50:16 +0200
From: Eivind Tagseth <eivindt@multinet.no>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA Compact Flash adapter in 2.5.72
Message-ID: <20030624085016.GA1989@tagseth-trd.consultit.no>
References: <20030620081846.GB2451@tagseth-trd.consultit.no> <20030620211640.B913@flint.arm.linux.org.uk> <20030622114642.GB1785@tagseth-trd.consultit.no> <20030622141541.B16537@flint.arm.linux.org.uk> <20030622182838.GA6970@tagseth-trd.consultit.no> <20030622191626.GA1811@tagseth-trd.consultit.no> <20030623102941.D23411@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623102941.D23411@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King <rmk@arm.linux.org.uk> [030623 11:32]:
> On Sun, Jun 22, 2003 at 09:16:27PM +0200, Eivind Tagseth wrote:
> > However, removing the card causes a kernel panic, and everything completely
> > freezes.  This also happened with 2.5.69, so it's not caused by a recent
> > change.
> 
> ide-cs currently calls ide_unregister from interrupt context, which is
> a big nono.  Can you try the following patch please (which is completely
> untested)?

Ok, I tried it (with 2.5.73), with slightly better success.  I still
get oopses, but the system doesn't hang completely anymore.  But the pcmcia
system (and probably more) is unstable afterwards.  There are oopses
when shutting down as well...

Console output when inserting the card:

hdc: SanDisk SDCFB-32, CFA DISK drive
ide1 at 0x140-0x147,0x14e on irq 9
hdc: max request size: 128KiB
hdc: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: task_no_data_intr: error=0x04 { DriveStatusError }
hdc: 62720 sectors (32 MB) w/1KiB Cache, CHS=490/4/32
 /dev/ide/host1/bus0/target0/lun0: p1
 /dev/ide/host1/bus0/target0/lun0: p1
devfs_mk_bdev: could not append to parent for ide/host1/bus0/target0/lun0/part1
kobject_register failed for hdc1 (-17)
Call Trace:
 [<c0213560>] kobject_register+0x50/0x60
 [<c0186ff7>] register_disk+0x147/0x180
 [<c0245e20>] add_disk+0x50/0x60
 [<c0245da0>] exact_match+0x0/0x10
 [<c0245db0>] exact_lock+0x0/0x20
 [<c0264789>] idedisk_attach+0x129/0x1b0
 [<c02606af>] ata_attach+0x9f/0x1c0
 [<c0259a23>] ideprobe_init+0xe3/0xff
 [<c025ebb3>] ide_probe_module+0x13/0x20
 [<c025f7ff>] ide_register_hw+0x15f/0x190
 [<d0aa3246>] idecs_register+0x66/0x80 [ide_cs]
 [<d0a912a5>] CardServices+0x215/0x362 [pcmcia_core]
 [<d0aa3798>] ide_config+0x538/0x8a0 [ide_cs]
 [<d0a890bc>] set_cis_map+0x3c/0x120 [pcmcia_core]
 [<d0a892cc>] read_cis_mem+0x12c/0x1a0 [pcmcia_core]
 [<d0a89596>] read_cis_cache+0xe6/0x170 [pcmcia_core]
 [<d0a89f1b>] pcmcia_get_tuple_data+0x9b/0xa0 [pcmcia_core]
 [<d0a8b25f>] pcmcia_parse_tuple+0x10f/0x180 [pcmcia_core]
 [<d0a8b373>] read_tuple+0xa3/0xb0 [pcmcia_core]
 [<d0a577c3>] yenta_set_mem_map+0x1c3/0x220 [yenta_socket]
 [<c0119105>] __ioremap+0xe5/0x120
 [<d0a89e30>] pcmcia_get_next_tuple+0x240/0x290 [pcmcia_core]
 [<d0a89955>] pcmcia_get_first_tuple+0xb5/0x160 [pcmcia_core]
 [<d0a577c3>] yenta_set_mem_map+0x1c3/0x220 [yenta_socket]
 [<d0a577c3>] yenta_set_mem_map+0x1c3/0x220 [yenta_socket]
 [<d0a890bc>] set_cis_map+0x3c/0x120 [pcmcia_core]
 [<d0a892cc>] read_cis_mem+0x12c/0x1a0 [pcmcia_core]
 [<d0a89596>] read_cis_cache+0xe6/0x170 [pcmcia_core]
 [<d0a89f1b>] pcmcia_get_tuple_data+0x9b/0xa0 [pcmcia_core]
 [<d0a8b25f>] pcmcia_parse_tuple+0x10f/0x180 [pcmcia_core]
 [<d0a8b373>] read_tuple+0xa3/0xb0 [pcmcia_core]
 [<d0a577c3>] yenta_set_mem_map+0x1c3/0x220 [yenta_socket]
 [<c0119105>] __ioremap+0xe5/0x120
 [<d0a89e30>] pcmcia_get_next_tuple+0x240/0x290 [pcmcia_core]
 [<d0a89955>] pcmcia_get_first_tuple+0xb5/0x160 [pcmcia_core]
 [<d0a89596>] read_cis_cache+0xe6/0x170 [pcmcia_core]
 [<d0a89e30>] pcmcia_get_next_tuple+0x240/0x290 [pcmcia_core]
 [<d0a8b4b3>] pcmcia_validate_cis+0x133/0x210 [pcmcia_core]
 [<c0157662>] __find_get_block+0x92/0xf0
 [<c01f1ca1>] create_virtual_node+0x361/0x540
 [<c01fdfd3>] pathrelse_and_restore+0x43/0x50
 [<d0aa3c88>] ide_event+0x58/0xe0 [ide_cs]
 [<d0a8fd03>] pcmcia_register_client+0x213/0x280 [pcmcia_core]
 [<d0a577c3>] yenta_set_mem_map+0x1c3/0x220 [yenta_socket]
 [<d0a9123e>] CardServices+0x1ae/0x362 [pcmcia_core]
 [<d0aa30f3>] +0xf3/0x130 [ide_cs]
 [<d0aa4960>] dev_info+0x0/0x20 [ide_cs]
 [<d0aa3c30>] ide_event+0x0/0xe0 [ide_cs]
 [<d0aa3d65>] +0x1c/0x37 [ide_cs]
 [<d0a634bf>] get_pcmcia_driver+0x3f/0x50 [ds]
 [<d0aa49a0>] ide_cs_driver+0x0/0x80 [ide_cs]
 [<d0a62536>] bind_request+0x186/0x220 [ds]
 [<d0aa3d65>] +0x1c/0x37 [ide_cs]
 [<d0a63141>] ds_ioctl+0x601/0x700 [ds]
 [<c011ae76>] preempt_schedule+0x36/0x50
 [<c02de8a7>] unix_dgram_sendmsg+0x377/0x580
 [<c013c2e0>] __alloc_pages+0xa0/0x330
 [<c028705e>] sock_sendmsg+0x9e/0xd0
 [<c0118b6c>] do_page_fault+0x23c/0x456
 [<c016f32f>] wake_up_inode+0xf/0x30
 [<c0180871>] proc_get_inode+0x161/0x190
 [<c013c16e>] buffered_rmqueue+0xce/0x1a0
 [<c014486b>] zap_pmd_range+0x4b/0x70
 [<c01448db>] unmap_page_range+0x4b/0x90
 [<c01449ef>] unmap_vmas+0xcf/0x240
 [<c0148815>] unmap_region+0x95/0xe0
 [<c0148712>] unmap_vma+0x42/0x80
 [<c014876f>] unmap_vma_list+0x1f/0x30
 [<c0148b5d>] do_munmap+0x15d/0x1c0
 [<c0167050>] sys_ioctl+0x100/0x290
 [<c010931b>] syscall_call+0x7/0xb

Module ide_cs cannot be unloaded due to unsafe usage in include/linux/module.h:479
ide-cs: hdc: Vcc = 3.3, Vpp = 0.0


(this also happens without your patch.  I reported it earlier for 2.5.72, but
I said that it didn't happen after I rebooted.  With 2.5.73 (without your
patch) it happens every time.

The device still works though, even with this not very encouraging message.


Console messages when physically removing the card (I haven't mounted
it or done anything with it since inserting the card):

devfs_remove: ide/host1/bus0/target0/lun0/disc not found, cannot remove
Call Trace:
 [<c01b014d>] devfs_remove+0xad/0xb0
 [<c0245d91>] blk_unregister_region+0x21/0x30
 [<c01876ce>] devfs_remove_disk+0x4e/0x95
 [<c0187327>] del_gendisk+0x87/0xe0
 [<c02643e8>] idedisk_cleanup+0x48/0x60
 [<c025f613>] ide_unregister+0x863/0x890
 [<c011ac2b>] schedule+0x1bb/0x3d0
 [<c0126629>] schedule_timeout+0x69/0xc0
 [<d0aa3b94>] ide_release+0x94/0x130 [ide_cs]
 [<d0aa3c7a>] ide_event+0x4a/0xe0 [ide_cs]
 [<d0a8e361>] send_event+0x61/0x70 [pcmcia_core]
 [<d0a8e3e0>] socket_remove_drivers+0x20/0x50 [pcmcia_core]
 [<d0a8e423>] socket_shutdown+0x13/0x60 [pcmcia_core]
 [<d0a8e9a3>] pccardd+0x143/0x210 [pcmcia_core]
 [<c011ae90>] default_wake_function+0x0/0x30
 [<c01091f2>] ret_from_fork+0x6/0x14
 [<c011ae90>] default_wake_function+0x0/0x30
 [<d0a8e860>] pccardd+0x0/0x210 [pcmcia_core]
 [<c01071e5>] kernel_thread_helper+0x5/0x10


There are some weird messages about devices.

This is what it looks like when the card is in:

brw-------    1 eivindt  root      22,   1 Jan  1  1970 /dev/ide/host1/bus0/target0/lun0/part1

This is what it looks like when it's been removed:

drwxr-xr-x    1 root     root            0 Jan  1  1970 /dev/ide/host1/bus0/target0/

There is not /dev/ide/host1 when the card has not been inserted at all.


Hope this helps,  Eivind

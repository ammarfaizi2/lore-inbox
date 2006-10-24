Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752114AbWJXHxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbWJXHxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 03:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbWJXHxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 03:53:53 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:7843 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752110AbWJXHxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 03:53:51 -0400
Message-ID: <453DC65C.8000408@sw.ru>
Date: Tue, 24 Oct 2006 11:53:00 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, devel@openvz.org
Subject: Re: [Q] ide cdrom in native mode leads to irq storm?
References: <453DC2A9.8000507@sw.ru>
In-Reply-To: <453DC2A9.8000507@sw.ru>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin wrote:
> there is node with Intel 7520-based motherboard (MSI-9136), IDE cdrom (hda) and
> SATA disc and 2.6.19-rc3 linux kernel.
> 
> When I set IDE controller into the native mode, I get irq storm on the node and
> this interrupt is disabled. If this interrupt is shared, the other subsystems
> are stop working too.
> 
> When I switch the IDE controller into legacy mode, all works correctly.
> 
> I've tried to use noapic, acpi=off, pci=routeirq, irqpoll options but it does
> not help.

When I use irqpoll option I get the following oops in create_empty_buffers():
it is not expected that alloc_page_buffers(page, blocksize, 1) can return NULL,
but it does it because of requested blocksize is more than PAGE_SIZE.

Unfortunately I have not any ideas how to fix this issue correctly.

thank you,
	Vasily Averin

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0191790
*pde = 37b31001
Oops: 0002 [#1]
SMP
Modules linked in: thermal processor fan button battery asus_acpi ac lp
parport_pc parport floppy ehci_hcd uhci_hcd sg e1000 i2c_i801 i2c_core ide_cd
cdrom shpchp usbcore
CPU:    0
EIP:    0060:[<c0191790>]    Not tainted VLI
EFLAGS: 00010296   (2.6.19-rc3 #1)
EIP is at create_empty_buffers+0x30/0xb0
eax: 00000000   ebx: c16e1360   ecx: c16e1360   edx: 00000000
esi: 00000000   edi: 00000000   ebp: f7a720ac   esp: f7f3bc5c
ds: 007b   es: 007b   ss: 0068
Process lvm.static (pid: 2249, ti=f7f3a000 task=f7bce550 task.ti=f7f3a000)
Stack: c16e1360 00010000 00000001 00010000 00000000 f7a72150 c0192491 c16e1360
       00010000 00000000 00000011 f7f3bcb8 c01059fe 00000000 00000000 00000001
       00000440 00010000 00000003 c16e0740 f7a72150 00000004 c0103ace 00000000
Call Trace:
 [<c0192491>] block_read_full_page+0x251/0x3a0
 [<c01059fe>] do_IRQ+0x6e/0xd0
 [<c0103ace>] common_interrupt+0x1a/0x20
 [<c0147cac>] add_to_page_cache+0x9c/0xc0
 [<c014f515>] read_pages+0x45/0x100
 [<c0195a10>] blkdev_get_block+0x0/0x80
 [<c014d035>] __alloc_pages+0x55/0x320
 [<c014f73d>] __do_page_cache_readahead+0x16d/0x180
 [<c014f8b9>] blockable_page_cache_readahead+0x59/0xd0
 [<c014fb3e>] page_cache_readahead+0x13e/0x1f0
 [<c0148980>] do_generic_mapping_read+0x4c0/0x600
 [<c0148de4>] generic_file_aio_read+0x214/0x250
 [<c0148ac0>] file_read_actor+0x0/0x110
 [<c016bbee>] do_sync_read+0xde/0x130
 [<c0136e60>] autoremove_wake_function+0x0/0x60
 [<f8846d08>] usb_hcd_irq+0x28/0x70 [usbcore]
 [<c0145e48>] misrouted_irq+0xd8/0x150
 [<c0146016>] note_interrupt+0x96/0xe0
 [<c016bcfe>] vfs_read+0xbe/0x1a0
 [<c016c101>] sys_read+0x51/0x80
 [<c0103147>] syscall_call+0x7/0xb
 =======================
Code: 00 00 53 83 ec 0c 8b 5c 24 1c 89 74 24 08 8b 44 24 20 8b 7c 24 24 89 1c 24
89 44 24 04 e8 69 f4 ff ff 89 c6 89 c2 90 8d 74 26 00 <09> 3a 89 d0 8b 52 04 85
d2 75 f5 89 70 04 8b 43 10 83 c0 44 e8
EIP: [<c0191790>] create_empty_buffers+0x30/0xb0 SS:ESP 0068:f7f3bc5c
 <3>irq 17: nobody cared (try booting with the "irqpoll" option)
 [<c0145eea>] __report_bad_irq+0x2a/0xa0
 [<c014602f>] note_interrupt+0xaf/0xe0
 [<c0146888>] handle_fasteoi_irq+0xc8/0xe0
 [<c01059f9>] do_IRQ+0x69/0xd0
 [<c0103ace>] common_interrupt+0x1a/0x20
 [<c0101082>] mwait_idle_with_hints+0x32/0x40
 [<c01010a8>] mwait_idle+0x18/0x30
 [<c0100ef3>] cpu_idle+0x73/0x90
 [<c0552a5a>] start_kernel+0x1ca/0x220
 [<c0552370>] unknown_bootoption+0x0/0x1e0
 =======================
handlers:
[<c02b30c0>] (ide_intr+0x0/0x170)
Disabling IRQ #17

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264411AbUFSSGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUFSSGg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 14:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUFSSGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 14:06:36 -0400
Received: from port760.ds1-suoe.adsl.cybercity.dk ([212.242.163.7]:12115 "EHLO
	mha.dyndns.dk") by vger.kernel.org with ESMTP id S264411AbUFSSG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 14:06:29 -0400
Subject: Corruption and crashes with SIL3112A SATA chipset
From: Martin Alexander Hammer <mha@mha.dyndns.dk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1087668387.1972.72.camel@idoru>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 19 Jun 2004 20:06:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experiencing both data corruption and crashes when using an SATA
controller with the SIL3112A chipset. The controller itself is a "Syba"
PCI adapter with two SATA-150 connectors:
 
http://www.syba.com/us/en/product/43/02/03/index.html

Two 200GB Seagate disks are connected to the adapter, and I have tested
it in two different machines, by trying to store 180GB of data on each
drive. Here's a list of the combinations of kernels and drivers, that I
have tried, and what the outcome was:


*** Machine 1: Pentium 4, VIA P4X266A chipset
Kernel: 2.6.5 and 2.6.7
Driver: siimage and sata_sil

Files copied to any of the two Seagate disks are instantly corrupted.
Md5sum returns a different checksum each time it is ran on the same
file. I have also tried using only one of the disks at a time, and using
another brand of SATA cables, but no luck.


*** Machine 2: Pentium 3, Intel i815 chipset
Kernel: 2.4.27-pre6 and 2.6.7
Driver: sata_sil

At first all seems fine, but each time any of the disks get filled to
around 80-85GB, something crashes and takes the entire system down with
it. No errors are logged, but it manages to write af few lines to the
console, among others:

"lost page write due to I/O error"

... and some SCSI errors. Unfortunately, I didn't write it all down, but
I can easily crash it again, if anyone needs it.


*** Machine 2: Pentium 3, Intel i815 chipset
Kernel: 2.6.7
Driver: siimage

This one is a little slower than the sata_sil driver, but in the
beginning everything seemed fine again. About 50GB into the copying, the
transfer rate slows down to a couple of megabytes pr. second, and the
following appears in the log several times:

Jun 19 18:41:38 debian kernel: hde: sata_error = 0x00090000, watchdog =
1, siimage_mmio_ide_dma_test_irq
Jun 19 18:41:58 debian kernel: hde: dma_timer_expiry: dma status == 0x21
Jun 19 18:42:08 debian kernel: hde: DMA timeout error
Jun 19 18:42:08 debian kernel: hde: dma timeout error: status=0x50 {
DriveReady SeekComplete }
Jun 19 19:04:50 debian kernel: hde: sata_error = 0x00090000, watchdog =
1, siimage_mmio_ide_dma_test_irq
Jun 19 19:04:50 debian kernel: hde: sata_error = 0x00090000, watchdog =
1, siimage_mmio_ide_dma_test_irq
Jun 19 19:05:10 debian kernel: hde: dma_timer_expiry: dma status == 0x21
Jun 19 19:05:20 debian kernel: hde: DMA timeout error
Jun 19 19:05:20 debian kernel: hde: dma timeout error: status=0x50 {
DriveReady SeekComplete }
Jun 19 19:05:20 debian kernel:

But then it starts to get really bad, and it spews out this several
times:

Jun 19 19:30:43 debian kernel:  [<c01081ea>] __report_bad_irq+0x2a/0x90
Jun 19 19:30:43 debian kernel:  [<c01082e0>] note_interrupt+0x70/0xb0
Jun 19 19:30:43 debian kernel:  [<c0108520>] do_IRQ+0xe0/0xf0
Jun 19 19:30:43 debian kernel:  [<c01068ac>] common_interrupt+0x18/0x20
Jun 19 19:30:43 debian kernel:
Jun 19 19:31:12 debian kernel: hde: lost interrupt
Jun 19 19:31:12 debian kernel: hde: task_out_intr: status=0x50 {
DriveReady SeekComplete }
Jun 19 19:31:12 debian kernel:
Jun 19 19:31:12 debian kernel: hde: status timeout: status=0xd0 { Busy }
Jun 19 19:31:12 debian kernel:
Jun 19 19:31:12 debian kernel: ide2: reset phy, status=0x00000113,
siimage_reset
Jun 19 19:31:12 debian kernel: ide2: reset: success
Jun 19 19:31:14 debian kernel:  [<c01081ea>] __report_bad_irq+0x2a/0x90
Jun 19 19:31:14 debian kernel:  [<c01082e0>] note_interrupt+0x70/0xb0
Jun 19 19:31:14 debian kernel:  [<c0108520>] do_IRQ+0xe0/0xf0
Jun 19 19:31:14 debian kernel:  [<c01068ac>] common_interrupt+0x18/0x20
Jun 19 19:31:14 debian kernel:  [<c0104053>] default_idle+0x23/0x40
Jun 19 19:31:45 debian kernel:  [<c01040e4>] cpu_idle+0x34/0x40
Jun 19 19:31:45 debian kernel:  [<c0480778>] start_kernel+0x148/0x170
Jun 19 19:31:45 debian kernel:  [<c04804d0>]
unknown_bootoption+0x0/0x120

... and this:

Jun 19 19:34:22 debian kernel:  [<c01081ea>] __report_bad_irq+0x2a/0x90
Jun 19 19:34:22 debian kernel:  [<c01082e0>] note_interrupt+0x70/0xb0
Jun 19 19:34:22 debian kernel:  [<c0108520>] do_IRQ+0xe0/0xf0
Jun 19 19:34:22 debian kernel:  [<c01068ac>] common_interrupt+0x18/0x20
Jun 19 19:34:22 debian kernel:  [<c0187135>] inode2sd+0x35/0x160
Jun 19 19:34:22 debian kernel:  [<c014dd13>] wake_up_buffer+0x13/0x40
Jun 19 19:34:22 debian kernel:  [<c0187629>]
reiserfs_update_sd_size+0x159/0x230
Jun 19 19:34:22 debian kernel:  [<c01919b0>]
reiserfs_dirty_inode+0x0/0x90
Jun 19 19:34:22 debian kernel:  [<c0191a23>]
reiserfs_dirty_inode+0x73/0x90
Jun 19 19:34:22 debian kernel:  [<c016949d>]
__mark_inode_dirty+0x1ad/0x1c0
Jun 19 19:34:22 debian kernel:  [<c0164200>] inode_update_time+0xd0/0xe0
Jun 19 19:34:22 debian kernel:  [<c018c90f>]
reiserfs_file_write+0x24f/0x690
Jun 19 19:34:22 debian kernel:  [<c027f34b>] linvfs_read+0x8b/0xa0
Jun 19 19:34:22 debian kernel:  [<c014ca49>] do_sync_read+0x89/0xc0
Jun 19 19:34:22 debian kernel:  [<c0108189>] handle_IRQ_event+0x49/0x80
Jun 19 19:34:22 debian kernel:  [<c01084cc>] do_IRQ+0x8c/0xf0
Jun 19 19:34:22 debian kernel:  [<c01068ac>] common_interrupt+0x18/0x20
Jun 19 19:34:22 debian kernel:  [<c014cd28>] vfs_write+0xb8/0x130
Jun 19 19:34:22 debian kernel:  [<c014ce52>] sys_write+0x42/0x70
Jun 19 19:34:22 debian kernel:  [<c0105f3f>] syscall_call+0x7/0xb

And this is written to the console several times:

debian kernel: Disabling IRQ #18
(IRQ 18 belongs to the sata adapter).


Have I got a bad SATA controller, or what is going on here?

-- 
Med venlig hilsen

Martin Alexander Hammer
http://mha.dyndns.dk


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTJCXPC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbTJCXPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:15:01 -0400
Received: from p5081715A.dip.t-dialin.net ([80.129.113.90]:5504 "EHLO
	linux.tuxnetwork.de") by vger.kernel.org with ESMTP id S261437AbTJCXO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:14:56 -0400
Message-ID: <3F7DE6CD.5020505@tuxnetwork.de>
Date: Fri, 03 Oct 2003 23:14:53 +0200
From: Bjoern Brauel <bjoern@tuxnetwork.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030723 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6.0-testX] Problems in EXT3/DM as well as OSST with ide tape in
 ide-scsi
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the 2.6-test series I have so far hit 2 (for me) quite serious
problems that Im unforunately not able to track down for myself:

1. Using a raid-5 volume under evms2.1.1 (thus not using any evms kernel
code) will cause the kernel to spit out the following after a couple of
days of load on the box:

EXT3-fs error (device dm-19) in start_transaction: Journal has aborted

Volume will switch to ro after that. There's nothing particular that I
can trigger the problem with except that there is always quite a bit of
i/o load once the problem occurrs.

2. Using an Onstream DI-30 in ide-scsi mode with the osst module always
causes the following after writing to the tape (erase/rewind works though):

---cut---
Oct  4 00:45:56 linux kernel: hdc: irq timeout: status=0xd8 { Busy }
Oct  4 00:45:56 linux kernel: hdc: DMA disabled
Oct  4 00:45:56 linux kernel: hdc: ATAPI reset complete
Oct  4 00:45:56 linux kernel: hdc: irq timeout: status=0xd0 { Busy }
Oct  4 00:45:56 linux kernel: hdc: ATAPI reset complete
Oct  4 00:45:56 linux kernel: hdc: irq timeout: status=0xd0 { Busy }
Oct  4 00:45:56 linux kernel: hdc: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Oct  4 00:45:56 linux kernel: hdc: drive not ready for command
Oct  4 00:45:56 linux kernel: hdc: status error: status=0x01 { Error }
Oct  4 00:45:56 linux kernel: hdc: status error: error=0x04
Oct  4 00:45:56 linux kernel: ide-scsi: Strange, packet command
initiated yet DRQ isn't asserted
Oct  4 00:45:56 linux kernel: hdc: status timeout: status=0xd1 { Busy }
Oct  4 00:45:56 linux kernel: ide-scsi: Strange, packet command
initiated yet DRQ isn't asserted
Oct  4 00:45:56 linux kernel: hdc: ATAPI reset complete
Oct  4 00:45:56 linux kernel: ide-scsi: reset called for 0
Oct  4 00:45:56 linux kernel: ------------[ cut here ]------------
Oct  4 00:45:56 linux kernel: kernel BUG at drivers/scsi/ide-scsi.c:493!
Oct  4 00:45:56 linux kernel: invalid operand: 0000 [#1]
Oct  4 00:45:56 linux kernel: CPU:    0
Oct  4 00:45:56 linux kernel: EIP:    0060:[<c031aca0>]    Tainted: PF
Oct  4 00:45:56 linux kernel: EFLAGS: 00010286
Oct  4 00:45:56 linux kernel: EIP is at idescsi_transfer_pc+0x9c/0x121
Oct  4 00:45:56 linux kernel: eax: c02ff75a   ebx: c05aa17c   ecx:
9d875382   edx: 00000172 Oct  4 00:45:56 linux kernel: esi: f5aa9600
edi: f78cafcc   ebp: f7d33dd4   esp: f7d33db0
Oct  4 00:45:56 linux kernel: ds: 007b   es: 007b   ss: 0068 Oct  4
00:45:56 linux kernel: Process scsi_eh_0 (pid: 36, threadinfo=f7d32000
task=f7ade080) Oct  4 00:45:56 linux kernel: Stack: 00000172 c05aa17c
00000008 00000080 0000001e f78cafcc c05aa17c c387b480
Oct  4 00:45:56 linux kernel:        00000000 f7d33e00 c02fbccf c05aa17c
f5aa9600 00000000 00000000 0000001e
Oct  4 00:45:56 linux kernel:        0000000f c387b480 c05aa17c c05aa0d0
f7d33e30 c02fbfd0 c05aa17c c387b480
Oct  4 00:45:56 linux kernel: Call Trace:
Oct  4 00:45:56 linux kernel:  [<c02fbccf>] start_request+0x179/0x27b
Oct  4 00:45:56 linux kernel:  [<c02fbfd0>] ide_do_request+0x1dc/0x362
Oct  4 00:45:56 linux kernel:  [<c02dd4ce>] __elv_add_request+0x27/0x38
Oct  4 00:45:56 linux kernel:  [<c02fc82d>] ide_do_drive_cmd+0xe4/0x14d
Oct  4 00:45:56 linux kernel:  [<c031b53a>] idescsi_queue+0x1f1/0x657
Oct  4 00:45:56 linux kernel:  [<c031454e>] scsi_send_eh_cmnd+0xc0/0x1cd
Oct  4 00:45:56 linux kernel:  [<c0314443>] scsi_eh_done+0x0/0x4b
Oct  4 00:45:56 linux kernel:  [<c0314421>] scsi_eh_times_out+0x0/0x22
Oct  4 00:45:56 linux kernel:  [<c0314994>] scsi_eh_tur+0x94/0xcb
Oct  4 00:45:56 linux kernel:  [<c0314c36>]
scsi_eh_bus_device_reset+0x145/0x177Oct  4 00:45:56 linux kernel:
[<c031474f>] scsi_request_sense+0xf4/0x122
Oct  4 00:45:56 linux kernel:  [<c031533d>] scsi_eh_ready_devs+0x28/0x74
Oct  4 00:45:56 linux kernel:  [<c03154cf>] scsi_unjam_host+0xd6/0xdf
Oct  4 00:45:56 linux kernel:  [<c03155e2>] scsi_error_handler+0x10a/0x157
Oct  4 00:45:56 linux kernel:  [<c03154d8>] scsi_error_handler+0x0/0x157
Oct  4 00:45:56 linux kernel:  [<c01092b9>] kernel_thread_helper+0x5/0xb
Oct  4 00:45:56 linux kernel:
Oct  4 00:45:56 linux kernel: Code: 0f 0b ed 01 be 3f 47 c0 8b 56 38 a1
80 ef 4a c0 89 d1 29 c1
Oct  4 00:45:56 linux kernel:  hdc: ATAPI reset complete
Oct  4 00:45:56 linux kernel: hdc: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
---cut---

cheers .. Bjorn




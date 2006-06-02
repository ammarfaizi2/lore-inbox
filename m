Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWFBVft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWFBVft (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWFBVft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:35:49 -0400
Received: from basillia.speedxs.net ([83.98.255.13]:33490 "EHLO
	basillia.speedxs.net") by vger.kernel.org with ESMTP
	id S1751489AbWFBVfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:35:48 -0400
Date: Fri, 2 Jun 2006 23:35:44 +0200
From: Tom Wirschell <lkml@wirschell.nl>
To: linux-kernel@vger.kernel.org
Subject: Oops when creating software RAID device (2.6.16.14).
Message-ID: <20060602233544.11d46664@localhost>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to set up a Linux software RAID over 12 disks. As mdadm is
creating the array it appears that a drive is flaking out (if anybody
can provide a layman's explanation for what is being complained about,
I'd very much appreciate it). Now, since this is a RAID device I would
expect the md driver to simply discard this device, add the remainder
and leave me with a degraded array. No such luck, though.

Full log: http://www.wirschell.nl/boot.log
Relevant section with oops:

ATA: abnormal status 0x58 on port 0xF88A211C
ata7: PIO error
ATA: abnormal status 0x58 on port 0xF88A211C
ata7: translated ATA stat/err 0x58/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata7: status=0x58 { DriveReady SeekComplete DataRequest }
ATA: abnormal status 0x58 on port 0xF88A211C
ATA: abnormal status 0x58 on port 0xF88A211C
ATA: abnormal status 0x58 on port 0xF88A211C
ATA: abnormal status 0x58 on port 0xF88A211C
ata7: Entering mv_eng_timeout
mmio_base f8880000 ap dfe942a4 qc dfe94770 scsi_cmnd f7741080 &cmnd
f77410c4 ata7: status=0x50 { DriveReady SeekComplete }
ata7: error=0x01 { AddrMarkNotFound }
sdc: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
Assertion failed! qc !=
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=3017 Assertion
failed! qc != NULL,drivers/scsi/libata-core.c,ata_pio_block,line=3474
Unable to handle kernel NULL pointer dereference at virtual address
00000014 printing eip: c02e47b7
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: raid5 md_mod xor e1000 intel_agp agpgart
CPU:    0
EIP:    0060:[<c02e47b7>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16.14 #1)
EIP is at ata_pio_task+0xf2/0x6a1
eax: 00000053   ebx: 00000050   ecx: 00000010   edx: 00000050
esi: 00000002   edi: 00000000   ebp: 00000212   esp: c1a8df34
ds: 007b   es: 007b   ss: 0068
Process ata/0 (pid: 389, threadinfo=c1a8c000 task=dff1c580)
Stack: <0>00000000 dff1c6a8 dff1c580 c0424100 c1807560 c7562b80
0098966b 00000000 dfe94850 dfe94850 dfe94854 dfd84c40 00000212 c0125ff4
dfe942a4 c02e46c5 dfe942a4 dfd84c4c dfd84c40 dfd84c54 c01260bb c012619b
00000001 00000000 Call Trace:
 [<c0125ff4>] run_workqueue+0x78/0xb6
 [<c02e46c5>] ata_pio_task+0x0/0x6a1
 [<c01260bb>] worker_thread+0x0/0x111
 [<c012619b>] worker_thread+0xe0/0x111
 [<c01152a3>] default_wake_function+0x0/0x15
 [<c0128bcb>] kthread+0xa5/0xd2
 [<c0128b26>] kthread+0x0/0xd2
 [<c0100bf5>] kernel_thread_helper+0x5/0xb
Code: 56 e3 ff 83 c4 14 0f b6 d3 f6 c2 21 74 1a 83 8f 8c 00 00 00 02 8b
54 24 38 c7 82 dc 05 00 00 07 00 00 00 e9 18 ff ff ff 8d 4f 10 <8a> 41
04 83 e8 05 3c 02 0f 87 c0 01 00 00 80 e2 08 75 13 8b 4c <3>md: invalid
raid superblock magic on sdc2 md: sdc2 has invalid sb, not importing!
md: md_import_device returned -22

Interestingly enough, this problem is entirely reproducable, however so
far each time a different disk was being complained about. Is there
something I should know about the WD200JB drives?

Hardware this is happening on:
 Intel P4 3.0GHz CPU
 ASUS PSCH-L Mobo (E7210 + 6300ESB)
 Promise FastTrak S150 TX4 onboard, unused.
 SuperMicro AOC-SAT2-MV8 SATA controller card (Marvell 88SX6081 chip)
 2x Western Digital WD2000JB 200 GB PATA drives
 9x Western Digital WD2000JD 200 GB SATA drives

If anybody has any insights at so what I can or should do now to
resolve this issue, I'm all ears.

I'm not subscribed to LKML, so please CC me in any replies.

Thank you.

Kind regards,

Tom Wirschell

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbTIDUlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbTIDUlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:41:23 -0400
Received: from postino4.prima.com.ar ([200.42.0.162]:59152 "HELO
	postino4.prima.com.ar") by vger.kernel.org with SMTP
	id S264933AbTIDUlC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:41:02 -0400
Subject: [PATCH] ide_cs w/TCQ
From: MAtias Alejo Garcia <kernel@matiu.com.ar>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1062710823.1794.30.camel@runner>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Sep 2003 17:27:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Bart,

I reported I problem (Unable to handle kernel NULL pointer...) when
inserting a CF card in a PCMCIA adapter in 2.6.0test1. The problem
continues in test4 (log below, when inserting a card).

The problem only is present when  BLK_DEV_TCQ_DEFAULT is enabled. It
seems that ide_cs (or ide, don't know) does not correctly initialize
hwif->ide_dma_queued_on() ...I don't know how this should be fixed if
the driver doesn't use DMA:

1) Not calling ide_dma_queued_on
or
2) Initializind ide_dma_queued_on to a dummy function

I tried 1) and it works...

Here is the patch...be gentle is my first contribution :-)

Thanks!
matias 

-- 
matías <-> http://matiu.com.ar



--- linux-2.6.0-test4/drivers/ide/ide-disk.c.orig	2003-09-04
16:45:40.000000000 -0400
+++ linux-2.6.0-test4/drivers/ide/ide-disk.c	2003-09-04
15:41:25.000000000 -0400
@@ -1689,6 +1689,7 @@
 		write_cache(drive, (id->cfs_enable_2 & 0x3000));
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+	if (drive->using_dma)
 		HWIF(drive)->ide_dma_queued_on(drive);
 #endif
 }



-----------
Sep  4 05:01:28 runner cardmgr[793]: socket 0: ATA/IDE Fixed Disk
Sep  4 05:01:28 runner cardmgr[793]: executing: 'modprobe ide-cs'
Sep  4 05:01:31 runner kernel: hde: SanDisk SDCFB-32, CFA DISK drive
Sep  4 05:01:31 runner kernel: ide2 at 0x140-0x147,0x14e on irq 5
Sep  4 05:01:31 runner kernel: hde: max request size: 128KiB
Sep  4 05:01:31 runner kernel: hde: 62720 sectors (32 MB) w/1KiB Cache,
CHS=490/4/32
Sep  4 05:01:31 runner kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Sep  4 05:01:31 runner kernel:  printing
eip:                                      Sep  4 05:01:31 runner kernel:
00000000
Sep  4 05:01:31 runner kernel: *pde = 00000000
Sep  4 05:01:31 runner kernel: Oops: 0000 [#1]
Sep  4 05:01:31 runner kernel: CPU:    0
Sep  4 05:01:31 runner kernel: EIP:    0060:[<00000000>]    Tainted:
P             Sep  4 05:01:31 runner kernel: EFLAGS: 00010246
Sep  4 05:01:31 runner kernel: EIP is at
0x0                                       Sep  4 05:01:31 runner kernel:
eax: c0427668   ebx: 00000020   ecx: de365400   edx:
00000000                                                                          Sep  4 05:01:31 runner kernel: esi: c0427714   edi: 0000f500   ebp: 00000000   esp: dbaf55a0
Sep  4 05:01:31 runner kernel: ds: 007b   es: 007b   ss:
0068                      Sep  4 05:01:31 runner kernel: Process cardmgr
(pid: 793, threadinfo=dbaf4000 task=dbdaac80)
Sep  4 05:01:31 runner kernel: Stack: c024eb95 c0427714 000001ea
00000004 00000020 00000020 00000000 0000f500
Sep  4 05:01:31 runner kernel:        04000000 de365400 c0427714
c03b2844 dbaf4000 dfb82280 c024efa4 c0427714
Sep  4 05:01:31 runner kernel:        c03b2780 00000001 00000001
c03b2844 dbaf4000 c03b2780 c024aa22 c0427714
Sep  4 05:01:32 runner kernel: Call
Trace:                                         Sep  4 05:01:32 runner
kernel:  [<c024eb95>] idedisk_setup+0x33b/0x412
Sep  4 05:01:32 runner kernel:  [<c024efa4>]
idedisk_attach+0xae/0x1a4             Sep  4 05:01:32 runner kernel: 
[<c024aa22>] ata_attach+0x96/0x1b2
Sep  4 05:01:32 runner kernel:  [<c02446c4>]
ideprobe_init+0xe0/0xfc               Sep  4 05:01:32 runner kernel: 
[<c0248ec3>] ide_probe_module+0xd/0x10
Sep  4 05:01:32 runner kernel:  [<c0249cbb>] ide_register_hw+0x155/0x186
Sep  4 05:01:32 runner kernel:  [<e0845224>] idecs_register+0x5e/0x70
[ide_cs]


[bla bla bla]

Sep  4 05:01:33 runner kernel: Code:  Bad EIP value.



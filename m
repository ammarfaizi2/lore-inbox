Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270322AbTGMRjk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 13:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270327AbTGMRjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 13:39:39 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:8869 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S270322AbTGMRje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 13:39:34 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: <B.Zolnierkiewicz@elka.pw.edu.pl>, <axboe@suse.de>
Subject: 2.5.75 - BUG in ide-iops.c, TCQ, AS, drive standby and i/o lockup
Date: Sun, 13 Jul 2003 12:03:33 -0400
User-Agent: KMail/1.5.2
Cc: LKML <linux-kernel@vger.kernel.org>, <lista1@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307131203.33270.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In thread "2.5.75 does not boot - TCQ oops,"
I applied Jens Axboe's patch to boot a TCQ-enabled kernel.
That resulted in massive filesystem corruption for me, and as I further 
discovered it only occurs 8-depth tcq queue (versus 32 when it works).
Elevator choice does not seem to matter for the bug.

The following occurs with a 32-depth tcq queue (tested my new xfs root)
with AS:

I noticed machine lockups on screensaver activation, and got an oops while 
working with kmail, but did not write down. Machine froze. 
Tried to reproduce with heavy i/o, but the kernel worked fine for a long time 
and I was not successful. I decided the bug must be triggered by the 20 
minute machine standby, and reduced it to 5 seconds. After attempted wake up 
and disk read/write activity (may take several tries), I get either:

- Input/Output error on any shell command
- I/O freezes, but things like dmesg, ls on current directory (cached?)
	reports of:  hda: invalidating tag queue...ide_tcq_intr_timeout: timeout 
waiting for completion interrupt

OR

The errors and oops (written by hand - disk was dead):
=========================================
hda: alt stat timeout
hda: rw queued: status=0xc0
hda: invalidating tag queue (1 commands)
hda: status_timeout: status=0xc0 { Busy }

hda: drive not ready for command
hda: status_timeout: status=0xc0

hda: DMA disabled
hda: drive not ready for command
hda: status_timeout: status=0x80

kernel BUG at drivers/ide/ide-iops.c: 1246!
CPU:0
EIP: 0060: [<c02bc2de>] 	Tainted: PF (my Nvidia module)
....
EIP is at do_reset1+0x2e/02x250
Process pdflush...
Call trace:
	ide_do_reset + 0x17/0x20
	idedisk_error+0x156/0x230
	common_interrupt+0x18/0x20
	ide_wait_stat+0xcc/0x130
	start_request+0xc9/0x280
	ide_do_request+0x26e/0x470
	as_next_request+0x33/0x40
	do_ide_request+0x1d/0x30
	generic_unplug_device+0x78/0x80
	blk_run_queues+0x7a/0xb0
	xfs_iflush+0x1fd/0x510
	xfs_inode_flush+0x298/0x2c0
	generic_unplug_device+0x75/0x80
	linvfs_writepage+0x0/0x110
	linvfs_write_inode+0x32/0x40
	write_inode+0x46/0x50
	__sync_single_inode+0x1f9/0x230
	writeback_inodes+0x4d/0xa0
	wb_kupdate+0x9c/0x120
	__pdflush+0xd2/0x1d0
	pdflush+0x0/0x20
	pdflush+0xf/0x20
	wb_kupdate+0x0/0x120
	kernel_thread_helper+0x0/0x10
	kernel_thread_helper+0x5/0x1(?)
	
	Code: 0f 0b de 04 73 90 3a c0 80 bf 3d 02 00 00 20 74 0c 8b 44 24
	
	<3> ide_tcq_intr_timeout: timeout waiting for completion interrupt

hda: invalidating tag queue (0 commands)
hda: status_timeout: status=0x80 { Busy }

hda: invalidating tag queue (0 commands)
hda: status_timeout: status=0x80 { Busy }

end_request: I/O error, dev hda, sector 26387519
hda: drive not ready for command
hda: status_timeout: status=0x80 { Busy }
	
hda: drive not ready for command
note: pdflush[7] exited with preempt_count 1

ide_tcq_intr_timeout: timeout waiting for completion interrupt
hda: invalidating tag queue (0 commands)
hda: status_timeout: status=0x80 { Busy }

hda: drive not ready
hda: status_timeout: status=0x80 { Busy }

etc.......




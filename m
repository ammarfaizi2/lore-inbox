Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283269AbRLRAmb>; Mon, 17 Dec 2001 19:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283272AbRLRAmW>; Mon, 17 Dec 2001 19:42:22 -0500
Received: from web14909.mail.yahoo.com ([216.136.225.61]:17420 "HELO
	web14909.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283269AbRLRAmG>; Mon, 17 Dec 2001 19:42:06 -0500
Message-ID: <20011218004205.1877.qmail@web14909.mail.yahoo.com>
Date: Tue, 18 Dec 2001 13:42:05 +1300 (NZDT)
From: =?iso-8859-1?q?Kirk=20Alexander?= <kirkalx@yahoo.co.nz>
Subject: Report - fixes needed
To: linux-kernel@vger.kernel.org
In-Reply-To: <20011218162715.A1015@pazke.ipt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done some grep'ing for some possible fixes required in 2.5.1 (final).
The problems are:
 - changing of member cmd in 'struct request' to a char array from int
 - changing of blk_init_queue() to take 3 args not 2
 - use of the removed member b_reqnext in 'struct buffer_head'

Note there are probably some files I have missed due to not thinking generally
enough and there will be false matches also. As you can probably tell from the
below I'm definitely not a grep wizard so if someone can think of a way to
search for code like

	printk(" ...  %d  ... ", ..., rq->cmd, ...);

that will turn up more things in need of fixing.

Sorry if this info has already been found - I couldn't find an overall report
like this in the archives.


1)
Look for possible invalid use of altered member cmd from struct request
- search for this kind of thing

		switch (rq->cmd)
		{
			case READ:
		...

grep "switch[[:space:]]*([a-zA-Z0-9_]*->cmd[[:space:]]*)"
grep "switch[[:space:]]*([a-zA-Z0-9_]*\.cmd[[:space:]]*)"
 then filter on
grep "struct[[:space:]]*request[[:space:]]"

drivers/block/cpqarray.c
drivers/ide/ide-floppy.c
drivers/ide/ide-tape.c
drivers/s390/block/xpram.c
drivers/mtd/mtdblock.c
drivers/mtd/mtdblock_ro.c

----------
2)
Look for possible invalid use of altered member cmd from struct request
- search for this kind of thing

	if (rq->cmd == READ) {
		...

  and

	rq->cmd = READ;

grep -- "->cmd[[:space:]]*="
 then filter on
grep "struct[[:space:]]*request[[:space:]]"

include/linux/ide.h : Documentation change
drivers/block/nbd.c
drivers/sbus/char/jsflash.c
drivers/ide/icside.c
drivers/ide/ide-cd.c
drivers/ide/ide-floppy.c
drivers/ide/ide-tape.c
drivers/ide/pdc4030.c
drivers/acorn/block/mfmhd.c
drivers/s390/block/dasd.c
drivers/s390/block/dasd_diag.c
drivers/s390/block/dasd_eckd.c
drivers/s390/block/dasd_fba.c
drivers/mtd/nftlcore.c
drivers/message/i2o/i2o_block.c

--------------
3)
Search for use of blk_init_queue() with only two args.

grep -l blk_init_queue[[:space:]]*([^,]*,[^,)]*)

drivers/s390/char/tapedefs.h : OK - compatibility with older kernels.
arch/m68k/atari/stram.c
drivers/block/DAC960.c
drivers/cdrom/aztcd.c
drivers/cdrom/cm206.c
drivers/cdrom/gscd.c
drivers/cdrom/mcd.c
drivers/cdrom/mcdx.c
drivers/cdrom/optcd.c
drivers/cdrom/sbpcd.c
drivers/cdrom/sjcd.c
drivers/cdrom/sonycd535.c
drivers/sbus/char/jsflash.c
drivers/acorn/block/fd1772.c
drivers/acorn/block/mfmhd.c
drivers/s390/block/dasd.c
drivers/s390/block/xpram.c
drivers/s390/char/tapeblock.c
drivers/mtd/ftl.c
drivers/mtd/mtdblock.c
drivers/mtd/mtdblock_ro.c
drivers/mtd/nftlcore.c
drivers/message/i2o/i2o_block.c

-------
4)
Search for use of removed member b_reqnext in struct buffer_head.

fgrep "b_reqnext"

include/linux/raid/raid5.h : documentation change
arch/cris/drivers/ide.c
drivers/block/acsi.c
drivers/scsi/scsi_debug.c
drivers/ide/icside.c
drivers/ide/ide-pmac.c
drivers/ide/ide-tape.c
drivers/s390/block/dasd_diag.c
drivers/s390/block/dasd_eckd.c
drivers/s390/block/dasd_fba.c
drivers/s390/char/tape34xx.c
drivers/s390/char/tapeblock.c
drivers/md/raid5.c





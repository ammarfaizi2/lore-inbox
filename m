Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317280AbSFGMqM>; Fri, 7 Jun 2002 08:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317279AbSFGMqL>; Fri, 7 Jun 2002 08:46:11 -0400
Received: from h-64-105-137-63.SNVACAID.covad.net ([64.105.137.63]:37838 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317276AbSFGMqJ>; Fri, 7 Jun 2002 08:46:09 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 7 Jun 2002 05:46:02 -0700
Message-Id: <200206071246.FAA06400@adam.yggdrasil.com>
To: akpm@zip.com.au
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's bigger than queue could handle
Cc: axboe@suse.de, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> wrote:
>mpage stuff looks good.

	Great!  (Actually, I think should change one PAGE_SIZE to
PAGE_CACHE_SIZE in my patch before a final version goes to Linus.)

	Regarding q->max_sectors == 0, it looks like some real
hardware devices use it.  blk_init_queue does not set it, and some
drivers that call blk_init_queue do not set it, although I assume that
they initialize their queue structures to zero.  Examples of this
include the proprietary interface CDROM drives (I mention this example
because I was looking at that code, not because people actually use
those drives anymore).

	Regarding "stacked" devices like /dev/loop and raid,
blk_queue_make_request sets q->max_sectors to 255 (MAX_SECTORS in
include/linux/blkdev.h, only used here and as a readahead setting in
md.c).  This limits a single bio on a stacked device that keeps this
default to 31 4kB pages, as opposed to the previous limit of 128
sectors == 16 4kB pages.  So the only new problem should be with
making a loop or raid device out of could handle a request of 16 4kB
pages but could not handle a request of 31 4kB pages.  The only driver
that I could find that would be effected would be a SCSI disk on an
ips SCSI controller (see table below), although my search was
incomplete.

	I have have verified that, under my patch, I was able to make
a loop device from an IDE disk partition, make a ext2 file system on
it, mount it, copy the shell to it, and run that shell binary.

	I could change MAX_SECTORS to 128, which will give you the
previous limit, which should support everything that I've checked
except a SCSI disk on a QLogic controller, which would not have worked
before either To support QLogic SCSI, it looks like q->max_sectors
might have to be 32 or less (because I think it's max_hw_segments
could be as little as four).

	The correct solution for /dev/loop is to create separate
queues for /dev/loop/0, /dev/loop/1, etc., and set the various queue
parameters when each queue is bound to its underlying device or file.
I think I can readily impliment this and remove references to minor
device numbers from loop.c in the process, but I don't want to create
a big dependency chain for getting my current patch into the kernel.

	Likewise, the device mapper (or the specialized raid, logical
volume management and disk partition code which the device mapper
depricates) should also do something like the following whenever an
underlying device is added or removed:

	int max_phys = parent->childqueue[0].max_phys_segments;
	int max_hw = parent->childqueue[0].max_hw_segments;
	int max_sec = parent->childqueue[0].max_sectors;
	for (i = 1; i < parent->num_children; i++) {
	   max_phys = min(max_phys, parent->childqueue[0].max_phys_segments);
	   max_hw = min(max_hw, parent->childqueue[0].max_hw_segments);
	   max_sec = min(max_sec, parent->childqueue[0].max_sectors);
	}
	blk_queue_max_phys_segments(&parent->queue, max_phys);
	blk_queue_max_hw_segments(&parent->queue, max_hw);
	blk_queue_max_sectors(&parent->queue, max_sec);


	Anyhow, what I would like to do is to first proceed with my
patch without these moderately involved changes to loop.c and md.c
(the only other stacked device that compiles under 2.5 I believe), but
with the simple change to loop.c and md.c of setting their
q->max_sectors to 16.  I'll cc the maintainers of loop.c and md.c, and
I'll also email whoever is developing the device mapper that they
should add a similar line to their initialization.  Does that sound
good to you or would you recomment proceeding proceed in some other


>We need to wake Jens up before going any further.  (The test
>for ->max_sectors != 0 look funny).

	Jens has been cc'ed on all of this.  I think I should proceed
as I described in the above paragraph.  After that, I'll email Jens
directly and see if that triggers a response.  Beyond that, I don't
know what else to do.  So, if we don't hear from him within a day or
two after that, I think we should take silence as at least begrudging
consent and submit the change to Linus.




P.S. I've attached a table of the request_queue_t settings of I noted
from a few greps through the kernel sources.  Some of the scsi settings
are inferred from #define names rather than from walking through to the
code that actually sets the values.

device			max_sectors	max_hw_segments	max_phys_segments
cciss			512		31		31
ps2esdi			128		(128)		(128)
xd			1 or 64		(128)		(128)
ide disk		256		256*		256*
pdc4030 IDE		127		256*		256*
IOmega zip 100 atapi	64		256*		256*	
blk_init_queue		0		128		128
blk_queue_make_request	255		128		128
i2o_block		does not compile, weird formula
scsi (just from grepping files):
     3w-xxxx		256		62		128
     aic7xxx_old	512
     atari_scsi				255		128
     cpqfcTS				360		128
     eata				64 or 252	128
     gdth				32		128
     ips		128		17		128
     mac_scsi				0 (?)		128
     osst (tape drive?)			2		128
     qla1280		1024		
     qlogicisp		64		4 + ?		128
     qlogicpti		64
     tmscsim				16		128
     ultrastor 14F			16		128
     ultrastor 24F			33		128
     scsi disk		1024
     scsi tape				16		128
     scsi default	1024

[*] PRD_ENTRIES = PAGE_SIZE/16 = 256 using 4kB pages

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbTDWR1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264150AbTDWRZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:25:51 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30928 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264145AbTDWRZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:25:26 -0400
Date: Wed, 23 Apr 2003 19:37:19 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (0/4)
Message-ID: <Pine.SOL.4.30.0304231933360.10502-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

Another bunch of patches:

(1) Enhance bio_(un)map_user() and add blk_rq_bio_prep().
(2) Pass bdev to IDE ioctl handlers.
(3) Add support for rq->bio based taskfile.
(4) Use direct-IO in ide_taskfile_ioctl() and in ide_cmd_ioctl().

[ more detailed changelogs inside patches ]

They are incremental to 2.5.67-ac1/2 and previously posted tf-ioctls patches,
you can find all patches at:
	http://home.elka.pw.edu.pl/~bzolnier/patches/2.5.67-ac2/


Now HDIO_DRIVE_TASKFILE and HDIO_DRIVE_CMD (taskfile version) ioctls
use direct-IO to user memory if it is possible (user memory buffer address
and transfer length must be both aligned to hardsector size = 512).

As a result ioctl generated IO request with aligned user buffer use
the same code path as fs generated IO request, which gives possibility
of testing IDE code used for fs-requests from user space.

These patches also make possible to use taskfile ioctl for up to 32 MB big
lba48 requests, since now we don't need to allocate kernel buffer for them.
[ There may be still some small glitches to fix. ]

Alignment of user buffer address is a limitation to removing code using
kernel buffer approach. If user buffer is not aligned it can can happen
that one hardware sector is mapped to diffirent bio-s.
[ However I have an idea how to deal with this issue. :-) ]


I have tested HDIO_DRIVE_TASKFILE ioctl after changes and both direct-IO
and normal transfers are working fine, here are results from DiskPerf:

# with direct-IO
./DiskPerf /dev/hda

Device: WDC WD800JB-00CRA1 Serial Number: WD-WMAxxxxxxxxx
LBA 0 DMA Read Test                      = 78.34 MB/Sec (3.19 Seconds)
Outer Diameter Sequential DMA Read Test  = 45.52 MB/Sec (5.49 Seconds)
Inner Diameter Sequential DMA Read Test  = 25.91 MB/Sec (9.65 Seconds)

# with kernel buffer
./DiskPerf /dev/hda

Device: WDC WD800JB-00CRA1 Serial Number: WD-WMAxxxxxxxxx
LBA 0 DMA Read Test                      = 69.81 MB/Sec (3.58 Seconds)
Outer Diameter Sequential DMA Read Test  = 44.83 MB/Sec (5.58 Seconds)
Inner Diameter Sequential DMA Read Test  = 25.94 MB/Sec (9.64 Seconds)


Example how to align user buffer for HDIO_DRIVE_TASKFILE and direct-IO:

with kernel buffer:
	ide_task_request_t reqtask;
	unsigned char task[sizeof(reqtask)+reqtask.out_size+reqtask.in_size];

	and &task were used as ioctl argument
direct-IO:
	#define HARDSECTOR_SIZE	512
	#define ALIGN(x,a)	(((x)+(a)-1)&~((a)-1))
	#define TASK_ALIGN(x)	(ALIGN((unsigned long)(x), HARDSECTOR_SIZE) \
				 +HARDSECTOR_SIZE-sizeof(ide_task_request_t))

	ide_task_request_t reqtask;
	unsigned char task[sizeof(reqtask)+reqtask.out_size+reqtask.in_size
			   +2*HARDSECTOR_SIZE];
	unsigned char *taskptr = (unsigned char *)TASK_ALIGN(task);

	and use taskptr as ioctl argument

	[ Yes, I know it is ugly ]

--
Bartlomiej Zolnierkiewicz



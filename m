Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVBJIit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVBJIit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 03:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVBJIit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 03:38:49 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:19411 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262051AbVBJIiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:38:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:message-id:date;
        b=Q8P0AlrUZliMeq1tPMVfyU6Eeq4eXKP10HeJC3g/kFH/tpQAsqsTJ/rozCpb9e1AwjtOSIirku17XI7alD4l6UZUXUMGGs6P0qlu2oy2GCKqF+hDUENLiYGMs/MlR1Mcc9Q9GZ91MwXwr6jBUJyNQYd4CxwIOUXzPihV8B+4p4g=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.6.11-rc3 00/11] ide: ide driver updates series 2, round 2
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
Message-ID: <20050210083808.48E9DD1A@htj.dyndns.org>
Date: Thu, 10 Feb 2005 17:38:08 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello, Bartlomiej.

 This is the second round of series 2 patches.  This series focuses
mainly on removing CMD and TASK drive commands.  Patches are against
the latest ide-dev-2.6 bk tree.  Newly added are #01, #04 and #05.

 #01 was #20 in the first posting of 29 patches.  I pushed it back for
later merging but this bug combined with the recent update "[ide] get
driver from rq->rq_disk->private_data" breaks taskfile transport, so I
pulled it back on top (as all drive commands are going to be using
taskfile transport).

 #04 is your ATA_TFLAG_LBA48 patch.  The patch message should contain
proper Signed-off-by line, if my script is finally working correctly.

 #05 adds ATA_TFLAG_IO_16BIT handling for taskfile ioctl.  So, the
race condition involving drive->io_32bit is gone now.

 Other patches are modified as you requested.

[ Start of patch descriptions ]

01_ide_task_end_request_fix.patch
	: task_end_request() fix

	task_end_request() modified to always call ide_end_drive_cmd()
	for taskfile requests.  Previously, ide_end_drive_cmd() was
	called only when task->tf_out_flags.all was set.  Also,
	ide_dma_intr() is modified to use task_end_request().

	* fixes taskfile ioctl oops bug which was caused by referencing
	  NULL rq->rq_disk of taskfile requests.
	* enables TASKFILE ioctls to get valid register outputs on
	  successful completion.

02_ide_taskfile_init_drive_cmd.patch
	: ide_init_drive_cmd() now defaults to REQ_DRIVE_TASKFILE

	ide_init_drive_cmd() now initializes rq->flags to
	REQ_DRIVE_TASKFILE instead of REQ_DRIVE_CMD.  This is
	preparation for removal of REQ_DRIVE_CMD.

03_ide_diag_taskfile_use_init_drive_cmd.patch
	: ide_diag_taskfile() rq initialization fix

	In ide_diag_taskfile(), taskfile rq was initialized using
	memset().  Use init_drive_cmd() instead.

04_ide_ATA_TFLAG_LBA48.patch
	: removes unneeded HOB access using ATA_TFLAG_LBA48 flag

	This small patch fixes unneeded writes/reads to LBA48 taskfile
	registers on LBA48 capable disks for following cases:

	* Power Management requests
	  (WIN_FLUSH_CACHE[_EXT], WIN_STANDBYNOW1, WIN_IDLEIMMEDIATE commands)
	* special commands (WIN_SPECIFY, WIN_RESTORE, WIN_SETMULT)
	* Host Protected Area support (WIN_READ_NATIVE_MAX, WIN_SET_MAX)
	* /proc/ide/ SMART support (WIN_SMART with SMART_ENABLE,
	  SMART_READ_VALUES and SMART_READ_THRESHOLDS subcommands)
	* write cache enabling/disabling in ide-disk
	  (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_WCACHE)
	* write cache flushing in ide-disk (WIN_FLUSH_CACHE[_EXT])
	* acoustic management in ide-disk
	  (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_AAM)
	* door (un)locking in ide-disk (WIN_DOORLOCK, WIN_DOORUNLOCK)
	* /proc/ide/hd?/identify support (WIN_IDENTIFY)

	Patch adds 'unsinged long flags' to ide_task_t and uses
	ATA_TFLAG_LBA48 flag (from <linux/ata.h>) to indicate need of
	accessing LBA48 taskfile registers.

	Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

05_ide_ATA_TFLAG_IO_16BIT.patch
	: fixes io_32bit race in ide_taskfile_ioctl()

	In ide_taskfile_ioctl(), there was a race condition involving
	drive->io_32bit.  It was cleared and restored during ioctl
	requests but there was no synchronization with other requests.
	So, other requests could execute with the altered io_32bit
	setting or updated drive->io_32bit could be overwritten by
	ide_taskfile_ioctl().

	This patch adds ATA_TFLAG_IO_16BIT flag to indicate to
	ide_pio_datablock() that 16bit IO is needed regardless of
	drive->io_32bit settting.

06_ide_taskfile_flush.patch
	: make disk flush functions use TASKFILE instead of TASK

	* idedisk_issue_flush() converted to use REQ_DRIVE_TASKFILE.
	   This and the changes in ide_get_error_location() remove a
	   possible race condition between ide_get_error_location()
	   and other requests.
	* ide_queue_flush_cmd() converted to use REQ_DRIVE_TASKFILE.

	By this change, when WIN_FLUSH_CACHE_EXT is used, full HOB
	registers are written and read.  This isn't optimal but
	shouldn't be noticeable either.

07_ide_taskfile_task_ioctl.patch
	: make ide_task_ioctl() use TASKFILE

	ide_task_ioctl() rewritten to use taskfile transport.  This is
	the last user of REQ_DRIVE_TASK.

08_ide_remove_task.patch
	: remove REQ_DRIVE_TASK handling

	Unused REQ_DRIVE_TASK handling removed.

09_ide_taskfile_cmd.patch
	: convert uses of REQ_DRIVE_CMD to REQ_DRIVE_TASKFILE

	All in-kernel REQ_DRIVE_CMD users except for ide_cmd_ioctl()
	converted to use REQ_DRIVE_TASKFILE.

10_ide_taskfile_cmd_ioctl.patch
	: make ide_cmd_ioctl() use TASKFILE

	ide_cmd_ioctl() rewritten to use taskfile transport.  This is
	the last user of REQ_DRIVE_CMD.

11_ide_remove_cmd.patch
	: remove REQ_DRIVE_CMD handling

	Unused REQ_DRIVE_CMD handling removed.

[ End of patch descriptions ]

 Thanks.

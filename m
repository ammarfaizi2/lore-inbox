Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbVCECXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbVCECXL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbVCECPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 21:15:03 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:10387 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263597AbVCEBsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:48:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:user-agent:content-type:message-id:date;
        b=I+lHA0eIVCVK8B4BSNpJPfHTKxgmi3hfoEuYvklttVLTbCNl4TxWwVAsRn7ntQrWOdenul4DgiyP5/wDWeIhsr+054eJCSrk+EuHi8uGsHzISU42Cf6AhFVWFA88R3VxiT8JPgCdAtyM8pX55iY3ZLG7gwXzFDX/5IZrdliW0mU=
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.6.11-rc3 00/08] ide: taskfile cleanup
From: Tejun Heo <htejun@gmail.com>
User-Agent: lksp 0.1
Content-Type: text/plain; charset=US-ASCII
Message-ID: <20050305014758.4EDB4992@htj.dyndns.org>
Date: Sat,  5 Mar 2005 10:47:58 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello, Bartlomiej.
 Hello, Jeff.

 These eight patches

 * define ATA_TFLAG_{OUT|IN}_* flags
 * unify/generalize taskfile transport
 * cleanup ide driver accordingly

 For behavior changes by #03.  I don't think defining a special flag
to handle the TASKFILE case is necessary.  The change isn't
user-visible.  And for the TASK ioctl, I think we should modify all
ioctls to disallow changing the upper nibble of the DEVICE register
except for the LBA bit.  What do you think?

 I tried hard not to break things and tested changes but I'm pretty
sure that I've missed something.  So, please comment.  :-)

[ Start of patch descriptions ]

01_ide_TFLAG_OUT_IN.patch
	: add individual ATA_TFLAG_{OUT|IN}_* flags

	This patch replaces ide_task_t->tf_{out|in}_flags handling
	with newly defined individual ATA_TFLAG_{OUT|IN}_* flags and
	helper functions ide_{load|read}_taskfile().  To ease
	transition of the IDE code, temporary flags
	ATA_TFLAG_IDE_FLAGGED and ATA_TFLAG_IDE_LBA48 are defined.
	This patch is tit-for-tat and shouldn't change any behavior.

02_ide_use_load_taskfile_in_do_rw_disk.patch
	: convert __ide_do_rw_disk() to use ide_load_taskfile()

	Reimplements __ide_do_rw_disk() using ide_load_taskfile().
	While at it, clean up the function a little bit.

03_ide_remove_flagged_taskfile.patch
	: remove flagged_taskfile() and unify taskfile paths

	This patch removes flagged_taskfile().  All taskfile command
	issuing goes through do_rw_taskfile().  do_rw_taskfile()
	doesn't modify mangle with load flags anymore.  It's now
	caller's responsibility to set appropriate flags.  Likewise,
	ide_end_drive_cmd() is modified not to mangle with read flags,
	and ide_dma_intr() now also finishes commands with
	task_end_request().  Above changes make taskfile path unified
	& generic.

	As all ioctl subtleties are now responsibility of respective
	ioctl functions.  TASKFILE and TASK ioctl functions are
	updated to set flags according to old behaviors.  The
	following two behavior changes occur.

	* TASKFILE ioctl: taskfile registers are read back whether or
	  not the command fails.  As copying back to user doesn't
	  happen in cases where reading back didn't occur before, this
	  change isn't user-visible.  Defining & using a flag like
	  ATA_TFLAG_READ_ON_ERROR will remove this issue.
	* TASK ioctl: drive->select.all & ~ATA_LBA is OR'd to device
	  value.  Previously, only ATA_DEV bit was OR'd.

	Also, all ide_{raw|diag}_taskfile(), do_rw_taskfile() users
	are converted to use the new individual OUT/IN flags.  As
	results, the following behavior changes occur.

	* idedisk_read_native_max_address(): ADDR/LBA48 regs are not
	  loaded.  LBA48/DEVICE registers are not read back unless
	  necessary.
	* idedisk_set_max_address(): DEVICE register is not read
	  unless necessary.
	* smart_enable(): DEVICE register is not loaded.  Registers
	  are not read back.
	* smart_disable(): ditto
	* get_smart_threshold(): DEVICE register is not loaded.
	* ide_task_init_flush(): ADDR/LBA48/DEVICE registers are not
	  loaded.
	* ide_init_specify_cmd(): Register aren't read back.
	* ide_init_restore_cmd(): DEVICE register not loaded.  No read back.
	* ide_init_setmult_cmd(): ditto

04_ide_remove_unused_fields.patch
	: remove unused fields ide_drive_t->rq and ide_task_t->special

	Remove unused fields ide_drive_t->rq and ide_task_t->special

05_ide_use_protocol.patch
	: use ide_task_t->tf.protocol instead of ide_task_t->data_phase

	Remove ide_task_t->{data_phase,command_type,prehandler,rq} and
	use tf->protocol instead.  Now the protocol value wholey
	defines how to drive a taskfile except for NODATA cases where
	a caller can optionally specify handler (for special
	commands).  The following behavior changes occur.

	* ide_taskfile_ioctl(): req_task->command_type is ignored.
	  This doesn't make any difference except for error/crash
	  cases in the original code.

06_ide_taskfile_set_xfer_rate.patch
	: convert set_xfer_rate() to use taskfile ioctl

	Convert set_xfer_rate() to use taskfile ioctl.

07_ide_taskfile_cmd_ioctl.patch
	: reimplement ide_cmd_ioctl() using taskfile

	Reimplement ide_cmd_ioctl() using taskfile.

08_ide_remove_REQ_DRIVE_CMD.patch
	: remove REQ_DRIVE_CMD handling

	Remove REQ_DRIVE_CMD handling.  ide_init_drive_cmd() now
	defaults to REQ_DRIVE_TASKFILE (now the only drive command :-).

[ End of patch descriptions ]

 Thanks.

--
tejun

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVBBClI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVBBClI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 21:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVBBClI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 21:41:08 -0500
Received: from [211.58.254.17] ([211.58.254.17]:64392 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262213AbVBBCkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:40:22 -0500
Date: Wed, 2 Feb 2005 11:40:17 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: [PATCH 2.6.11-rc2 0/29] ide: driver updates
Message-ID: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, B. Zolnierkiewicz.

 These patches are various fixes/improvements to the ide driver.  They
are against the 2.6 bk tree as of today (20050202).

01_ide_remove_adma100.patch

	Removes drivers/ide/pci/adma100.[hc].  The driver isn't
	compilable (missing functions) and no Kconfig actually enables
	CONFIG_BLK_DEV_ADMA100.

02_ide_cleanup_it8172.patch

	In drivers/ide/pci/it8172.h, it8172_ratefilter() and
	init_setup_it8172() are declared and the latter is referenced
	in it8172_chipsets.  Both functions are not defined or used
	anywhere.  This patch removes the prototypes and reference.
	it8172 should be compilable now.

03_ide_cleanup_opti621.patch

	In drivers/ide/pci/opti612.[hc], init_setup_opt621() is
	declared, defined and referenced but never actullay used.
	Thie patch removes the function.

04_ide_cleanup_piix.patch

	In drivers/ide/pci/piix.[hc], init_setup_piix() is defined and
	used but only one init_setup function is defined and no
	demultiplexing is done using init_setup callback.  As other
	drivers call ide_setup_pci_device() directly in such cases,
	this patch removes init_setup_piix() and makes piix_init_one()
	call ide_setup_pci_device() directly.

05_ide_merge_pci_driver_hc.patch

	Merges drivers/ide/pci/*.h files into their corresponding *.c
	files.  Rationales are
	1. There's no reason to separate pci drivers into header and
	   body.  No header file is shared and they're simple enough.
	2. struct pde_pci_device_t *_chipsets[] are _defined_ in the
	   header files.  That isn't the custom and there's no good
	   reason to do differently in these drivers.
	3. Tracking changelogs shows that the bugs fixed by 00 and 01
	   are introduced during mass-updating ide pci drivers by
	   forgetting to update *.h files.

06_ide_start_request_IDE_CONTROL_REG.patch

	Replaced HWIF(drive)->io_ports[IDE_CONTROL_OFFSET] with
	equivalent IDE_CONTROL_REG in ide-io.c.

07_ide_reg_valid_t_endian_fix.patch

	ide_reg_valid_t contains bitfield flags but doesn't reverse
	bit orders using __*_ENDIAN_BITFIELD macros.  And constants
	for ide_reg_valid_t, IDE_{TASKFILE|HOB}_STD_{IN|OUT}_FLAGS,
	are defined as byte values which are correct only on
	little-endian machines.  This patch defines reversed constants
	and .h byte union structure to make things correct on big
	endian machines.  The only code which uses above macros is in
	flagged_taskfile() and the code is currently unused, so this
	patch doesn't change any behavior.  (The code will get used in
	later patches.)

08_ide_do_identify_model_string_termination.patch

	Terminates id->model string before invoking strstr() in
	do_identify().

09_ide_do_rw_disk_lba48_dma_check_fix.patch

	In __ide_do_rw_disk(), the shifted block, instead of the
	original rq->sector, should be used when checking range for
	lba48 dma.

10_ide_do_rw_disk_pre_task_out_intr_return_fix.patch

	In __ide_do_rw_disk(), ide_started used to be returned blindly
	after issusing PIO write.  This can cause hang if
	pre_task_out_intr() returns ide_stopped due to failed
	ide_wait_stat() test.  Fixed to pass the return value of
	pre_task_out_intr().

11_ide_drive_sleeping_fix.patch

	ide_drive_t.sleeping field added.  0 in sleep field used to
	indicate inactive sleeping but because 0 is a valid jiffy
	value, though slim, there's a chance that something can go
	weird.  And while at it, explicit jiffy comparisons are
	converted to use time_{after|before} macros.

12_ide_hwgroup_t_polling.patch

	ide_hwgroup_t.polling field added.  0 in poll_timeout field
	used to indicate inactive polling but because 0 is a valid
	jiffy value, though slim, there's a chance that something
	weird can happen.

13_ide_tape_time_after.patch

	Explicit jiffy comparision converted to time_after() macro.

14_ide_error_remove_NULL_test.patch

	In ide_error(), drive cannot be NULL.  ide_dump_status() can't
	handle NULL drive.

15_ide_flagged_taskfile_data_byte_order_fix.patch

	In flagged_taskfile(), when writing data register,
	taskfile->data goes to the lower byte and hobfile->data goes
	to the upper byte on little endian machines and the opposite
	happens on big endian machines.  This patch make
	taskfile->data always go to the lower byte regardless of
	endianess.

16_ide_flagged_taskfile_select_dev_bit_masking.patch

	In flagged_taskfile(), make off DEV bit before OR'ing it with
	drive->select.all when writing to IDE_SELECT_REG.

17_ide_flagged_taskfile_select_check.patch

	In flagged_taskfile(), tf_out_flags.b.select should be checked
	before using bits inside taskfile->device_head.  When user
	haven't specified the select register, the default
	drive->select.all value should be used.

18_ide_comment_fixes.patch

	Comment fixes.

19_ide_diag_taskfile_use_init_drive_cmd.patch

	In ide_diag_taskfile(), when initializing taskfile rq,
	ref_count wasn't initialized properly.  Modified to use
	ide_init_drive_cmd().  This doesn't really change any behavior
	as the request isn't managed via the block layer.

20_ide_task_end_request_fix.patch

	task_end_request() modified and made global.  ide_dma_intr()
	modified to use task_end_request().  These changes enable
	TASKFILE ioctls to get valid register outputs on successful
	completion.  No in-kernel usage should be affected.

21_ide_do_taskfile.patch

	Merged do_rw_taskfile() and flagged_taskfile() into
	do_taskfile().  During the merge, the following changes took
	place.
	1. flagged taskfile now honors HOB feature register.
	   (do_rw_taskfile() did write to HOB feature.)
	2. No do_rw_taskfile() HIHI check on select register.  Except
	   for the DEV bit, all bits are honored.
	3. Uses taskfile->data_phase to determine if dma trasfer is
	   requested.  (do_rw_taskfile() directly switched on
	   taskfile->command for all dma commands)

22_ide_taskfile_flush.patch

	All REQ_DRIVE_TASK users except ide_task_ioctl() converted
	to use REQ_DRIVE_TASKFILE.
	1. idedisk_issue_flush() converted to use REQ_DRIVE_TASKFILE.
	   This and the changes in ide_get_error_location() remove a
	   possible race condition between ide_get_error_location()
	   and other requests.
	2. ide_queue_flush_cmd() converted to use REQ_DRIVE_TASKFILE.

23_ide_taskfile_task_ioctl.patch

	ide_task_ioctl() modified to map to ide_taskfile_ioctl().
	This is the last user of REQ_DRIVE_TASK.

24_ide_remove_task.patch

	Unused REQ_DRIVE_TASK handling removed.

25_ide_taskfile_cmd.patch

	All in-kernel REQ_DRIVE_CMD users except for ide_cmd_ioctl()
	converted to use REQ_DRIVE_TASKFILE.

26_ide_taskfile_cmd_ioctl.patch

	ide_cmd_ioctl() converted to use ide_taskfile_ioctl().  This
	is the last user of REQ_DRIVE_CMD.

27_ide_remove_cmd.patch

	Removed unused REQ_DRIVE_CMD handling.

28_ide_taskfile_init_drive_cmd.patch

	ide_init_drive_cmd() now initializes rq->flags to
	REQ_DRIVE_TASKFILE.

29_ide_explicit_TASKFILE_NO_DATA.patch

	Make data_phase explicit in NO_DATA cases.

 Thanks.

-- 
tejun


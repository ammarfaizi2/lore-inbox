Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVBBIdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVBBIdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 03:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVBBIdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 03:33:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63428 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262090AbVBBIcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 03:32:23 -0500
Message-ID: <42008FFF.1080904@pobox.com>
Date: Wed, 02 Feb 2005 03:31:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <tj@home-tj.org>
CC: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.11-rc2 0/29] ide: driver updates
References: <20050202024017.GA621@htj.dyndns.org>
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
>  Hello, B. Zolnierkiewicz.
> 
>  These patches are various fixes/improvements to the ide driver.  They
> are against the 2.6 bk tree as of today (20050202).
> 
> 01_ide_remove_adma100.patch
> 
> 	Removes drivers/ide/pci/adma100.[hc].  The driver isn't
> 	compilable (missing functions) and no Kconfig actually enables
> 	CONFIG_BLK_DEV_ADMA100.

Also, the libata-dev-2.6 tree has an "ata_adma" driver which is 
complete, but needs some testing (and I have h/w).

> 05_ide_merge_pci_driver_hc.patch
> 
> 	Merges drivers/ide/pci/*.h files into their corresponding *.c
> 	files.  Rationales are
> 	1. There's no reason to separate pci drivers into header and
> 	   body.  No header file is shared and they're simple enough.
> 	2. struct pde_pci_device_t *_chipsets[] are _defined_ in the
> 	   header files.  That isn't the custom and there's no good
> 	   reason to do differently in these drivers.
> 	3. Tracking changelogs shows that the bugs fixed by 00 and 01
> 	   are introduced during mass-updating ide pci drivers by
> 	   forgetting to update *.h files.

Personally, I agree.  However, I would ask Alan for his rationale before 
applying this...


> 07_ide_reg_valid_t_endian_fix.patch
> 
> 	ide_reg_valid_t contains bitfield flags but doesn't reverse
> 	bit orders using __*_ENDIAN_BITFIELD macros.  And constants
> 	for ide_reg_valid_t, IDE_{TASKFILE|HOB}_STD_{IN|OUT}_FLAGS,
> 	are defined as byte values which are correct only on
> 	little-endian machines.  This patch defines reversed constants
> 	and .h byte union structure to make things correct on big
> 	endian machines.  The only code which uses above macros is in
> 	flagged_taskfile() and the code is currently unused, so this
> 	patch doesn't change any behavior.  (The code will get used in
> 	later patches.)

doesn't this "fix" change behavior on existing big endian machines?


> 15_ide_flagged_taskfile_data_byte_order_fix.patch
> 
> 	In flagged_taskfile(), when writing data register,
> 	taskfile->data goes to the lower byte and hobfile->data goes
> 	to the upper byte on little endian machines and the opposite
> 	happens on big endian machines.  This patch make
> 	taskfile->data always go to the lower byte regardless of
> 	endianess.

ditto


> 16_ide_flagged_taskfile_select_dev_bit_masking.patch
> 
> 	In flagged_taskfile(), make off DEV bit before OR'ing it with
> 	drive->select.all when writing to IDE_SELECT_REG.

Probably the right thing to do, but be very very careful you have 
audited all uses...


> 21_ide_do_taskfile.patch
> 
> 	Merged do_rw_taskfile() and flagged_taskfile() into
> 	do_taskfile().  During the merge, the following changes took
> 	place.
> 	1. flagged taskfile now honors HOB feature register.
> 	   (do_rw_taskfile() did write to HOB feature.)
> 	2. No do_rw_taskfile() HIHI check on select register.  Except
> 	   for the DEV bit, all bits are honored.
> 	3. Uses taskfile->data_phase to determine if dma trasfer is
> 	   requested.  (do_rw_taskfile() directly switched on
> 	   taskfile->command for all dma commands)

I think Bart already had plans for this (similar to your patch)?


> 22_ide_taskfile_flush.patch
> 
> 	All REQ_DRIVE_TASK users except ide_task_ioctl() converted
> 	to use REQ_DRIVE_TASKFILE.

Rationale?


> 24_ide_remove_task.patch
> 
> 	Unused REQ_DRIVE_TASK handling removed.

this series is nice.


> 25_ide_taskfile_cmd.patch
> 
> 	All in-kernel REQ_DRIVE_CMD users except for ide_cmd_ioctl()
> 	converted to use REQ_DRIVE_TASKFILE.
> 26_ide_taskfile_cmd_ioctl.patch
> 
> 	ide_cmd_ioctl() converted to use ide_taskfile_ioctl().  This
> 	is the last user of REQ_DRIVE_CMD.

ditto


> 27_ide_remove_cmd.patch
> 
> 	Removed unused REQ_DRIVE_CMD handling.
> 
> 28_ide_taskfile_init_drive_cmd.patch
> 
> 	ide_init_drive_cmd() now initializes rq->flags to
> 	REQ_DRIVE_TASKFILE.
> 
> 29_ide_explicit_TASKFILE_NO_DATA.patch
> 
> 	Make data_phase explicit in NO_DATA cases.

I would make sure this series gets some amount of testing in -mm before 
pushing upstream, though...

	Jeff



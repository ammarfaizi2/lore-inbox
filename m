Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVBGJOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVBGJOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 04:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVBGJOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 04:14:44 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:49588 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261376AbVBGJOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 04:14:34 -0500
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [rfc][patch] ide: fix unneeded LBA48 taskfile registers access
Date: Mon, 7 Feb 2005 09:59:54 +0100
User-Agent: KMail/1.7.1
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <tj@home-tj.org>
References: <Pine.GSO.4.58.0502062348200.2763@mion.elka.pw.edu.pl> <4206F2E5.7020501@gmail.com>
In-Reply-To: <4206F2E5.7020501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502070959.54973.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 February 2005 05:47, Tejun Heo wrote:
> Hello, Bartlomiej.
> 
> Bartlomiej Zolnierkiewicz wrote:
> > [ against ide-dev-2.6 tree, boot tested on LBA48 drive ]
> > 
> > This small patch fixes unneeded writes/reads to LBA48 taskfile registers
> > on LBA48 capable disks for following cases:
> > 
> > * Power Management requests
> >   (WIN_FLUSH_CACHE[_EXT], WIN_STANDBYNOW1, WIN_IDLEIMMEDIATE commands)
> > * special commands (WIN_SPECIFY, WIN_RESTORE, WIN_SETMULT)
> > * Host Protected Area support (WIN_READ_NATIVE_MAX, WIN_SET_MAX)
> > * /proc/ide/ SMART support (WIN_SMART with SMART_ENABLE,
> >   SMART_READ_VALUES and SMART_READ_THRESHOLDS subcommands)
> > * write cache enabling/disabling in ide-disk
> >   (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_WCACHE)
> > * write cache flushing in ide-disk (WIN_FLUSH_CACHE[_EXT])
> > * acoustic management in ide-disk
> >   (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_AAM)
> > * door (un)locking in ide-disk (WIN_DOORLOCK, WIN_DOORUNLOCK)
> > * /proc/ide/hd?/identify support (WIN_IDENTIFY)
> > 
> > Patch adds 'unsinged long flags' to ide_task_t and uses ATA_TFLAG_LBA48
> > flag (from <linux/ata.h>) to indicate need of accessing LBA48 taskfile
> > registers.
> 
>   ide_task_t already has fields to enable/disable writing/reading of 
> taskfile and hob registers (tf_in_flags and tf_out_flags).  How about 
> adding the following two helpers.
> 
> static inline ide_init_task[_std](ide_task_t *task)
> {
>  memset(task, 0, sizeof(*task));
>  task->tf_out_flags = IDE_TASKFILE_STD_OUT_FLAGS;
>  task->tf_in_flags = IDE_TASKFILE_STD_IN_FLAGS;
> }
> 
> static inline ide_init_task_lba48(ide_task_t *task)
> {
>  memset(task, 0, sizeof(*task));
>  task->tf_out_flags = IDE_TASKFILE_STD_OUT_FLAGS
>    | (IDE_HOB_STD_OUT_FLAGS << 8);
>  task->tf_in_flags = IDE_TASKFILE_STD_IN_FLAGS
>    | (IDE_HOB_STD_IN_FLAGS << 8);
> }
> 
>   And, when writing taskfile,
> 
> if (task->tf_out_flags & 0xf == IDE_TASKFILE_STD_OUT_FLAGS) {
>  /* Write taskfile regs without testing flags */
> } else {
>  /* Flagged taskfile */
> }
> 
> if (task->tf_out_flags & 0xf0 == IDE_TASKFILE_HOB_OUT_FLAGS) {
>  /* Write hob regs without testing flags */
> } else {
>  /* Flagged hob */
> }
> 
>   And, when reading taskfile back,
> 
> if (task->tf_in_flags & 0xf0) {
>  /* Read all hob regs */
> }
> 
> /* Read all taskfile regs */
> 
>   And, we need to check if any of in/out flags is zero in ioctl 
> functions and set STD flags appropriately.  So, basically, in kernel, 
> tf_{in|out}_flags == 0 now means 0, not default.
> 
>   By doing like above,
> 
>   1. Virtually the same effect
>   2. No need to add new field to ide_task_t
>   3. Cleaner semantics (ATA_TFLAG_LBA48 and tf_{in|out}_flags carry
>      duplicate information.)

I would prefer to not teach do_rw_taskfile() about ->tf_{in,out}_flags
(and convert all users to use helpers) - it is much simpler this way,

->flags field in ide_task_t is needed anyway (32-bit I/O flag).

>   Thanks.
> 
> -- 
> tejun
> 
> 

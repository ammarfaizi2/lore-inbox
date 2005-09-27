Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVI0N7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVI0N7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVI0N7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:59:16 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:39196 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964944AbVI0N7P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:59:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ch9qrY3IriPCJV7xlF1nCfRWN7PZjVrrkihPSRpqgH0VhdMJlFFXpL7ghLYYkCU4pYtNNnX55W2k/hvu50FGhJR+PPEuQm6bBQxsuJNyh3yRk4bykfD1zSrAy1rIoeZmluDxZUZNguzifWoKfSRRh71kQVW96+wi/m21vEjKzFY=
Message-ID: <58cb370e0509270659aa52eac@mail.gmail.com>
Date: Tue, 27 Sep 2005 15:59:14 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tushar Adeshara <adesharatushar@gmail.com>
Subject: Re: Potential concurrency bug in ide-disk.c ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e8ac1af10509020438c71133d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e8ac1af10509020438c71133d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/05, Tushar Adeshara <adesharatushar@gmail.com> wrote:
> Hi,
> The way file ide-disk.c handles usage count, it seems to me that its
> concurrency bug.
> In open method and release, it uses code as follows
>
>
> static int idedisk_open(struct inode *inode, struct file *filp)
> {
>         ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
>         drive->usage++;
>         if (drive->removable && drive->usage == 1) {
>                 ide_task_t args;
>                 memset(&args, 0, sizeof(ide_task_t));
>                 args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
>                 args.command_type = IDE_DRIVE_TASK_NO_DATA;
>                 args.handler      = &task_no_data_intr;
>                 check_disk_change(inode->i_bdev);
>                 /*
>                  * Ignore the return code from door_lock,
>                  * since the open() has already succeeded,
>                  * and the door_lock is irrelevant at this point.
>                  */
>                 if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
>                         drive->doorlocking = 0;
>         }
>         return 0;
> }
>
>
> Here, if drive->usage=0 initially and two process concurrently executes
> drive->usage++, then drive->usage will become 2.  Both of them will
> think that drive is already initialized. Something similar can happen
> in case of release.
>                       I think a semaphore need to be added in
> ide_drive_t structure and method should be modified as
>
> static int idedisk_open(struct inode *inode, struct file *filp)
> {
>         ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
>         if(down_interruptible(&drive->sem)){
>                     /*error handling code*/
>         }
>         drive->usage++;
>         if (drive->removable && drive->usage == 1) {
>                 ide_task_t args;
>                 memset(&args, 0, sizeof(ide_task_t));
>                 args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
>                 args.command_type = IDE_DRIVE_TASK_NO_DATA;
>                 args.handler      = &task_no_data_intr;
>                 check_disk_change(inode->i_bdev);
>                 /*
>                  * Ignore the return code from door_lock,
>                  * since the open() has already succeeded,
>                  * and the door_lock is irrelevant at this point.
>                  */
>                 if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
>                         drive->doorlocking = 0;
>         }
>          up(&drive->sem);
>         return 0;
> }
> Similar modifications are also required in release.

Not a problem in practice as idedisk_open() and idedisk_release()
are only used in fs/block_dev.c (grep for fops->open and fops->release)
and are protected against concurrent execution by bdev->bd_sem.

Bartlomiej

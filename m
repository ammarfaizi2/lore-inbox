Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUEFIGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUEFIGQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 04:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUEFIGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 04:06:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15528 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261606AbUEFIGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 04:06:01 -0400
Date: Thu, 6 May 2004 10:05:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       akpm@osdl.org
Subject: Re: Force IDE cache flush on shutdown
Message-ID: <20040506080556.GD2009@suse.de>
References: <20040506070449.GA12862@devserv.devel.redhat.com> <20040506075809.GB2009@suse.de> <20040506080411.GD12862@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506080411.GD12862@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06 2004, Arjan van de Ven wrote:
> 
> On Thu, May 06, 2004 at 09:58:10AM +0200, Jens Axboe wrote:> On Thu, May 06 2004, Arjan van de Ven wrote:
> > > Hi,
> > > 
> > > Alan discovered the hard way that the current 2.6 IDE code doesn't do a
> > > cache-flush on shutdown. The patch below forward ports this from 2.4. In
> > > addition it fixes a bug where the ->wcache value only got determined for
> > > removable disks not all disks. (that fix is from Alan, all other bugs are
> > > mine ;)
> > 
> > Yeah that's a dumb bug, I fixed that in the barrier patches as well (but
> > forgot to send it in).
> > 
> > Maybe you could send that in seperately first, it needs to go in
> > regardless.
> 
> 
> ok below are the uncontended bits
> 1) calculate wcache for non-removable disks too
> 2) flush the cache BEFORE unlocking the door on removable media,
>    otherwise you have a small race with the human..
> 
> it makes sense for these to go in separate; I'm working on the shutdown hook
> now (and testing which is the fun part ;)
> 
> diff -urNp linux-1110/drivers/ide/ide-disk.c linux-1120/drivers/ide/ide-disk.c
> --- linux-1110/drivers/ide/ide-disk.c
> +++ linux-1120/drivers/ide/ide-disk.c
> @@ -1729,11 +1733,11 @@ static ide_driver_t idedisk_driver = {
>  
>  static int idedisk_open(struct inode *inode, struct file *filp)
>  {
> +	u8 cf;
>  	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
>  	drive->usage++;
>  	if (drive->removable && drive->usage == 1) {
>  		ide_task_t args;
> -		u8 cf;
>  		memset(&args, 0, sizeof(ide_task_t));
>  		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
>  		args.command_type = IDE_DRIVE_TASK_NO_DATA;
> @@ -1746,18 +1750,18 @@ static int idedisk_open(struct inode *in
>  		 */
>  		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
>  			drive->doorlocking = 0;
> -		drive->wcache = 0;
> -		/* Cache enabled ? */
> -		if (drive->id->csfo & 1)
> -		drive->wcache = 1;
> -		/* Cache command set available ? */
> -		if (drive->id->cfs_enable_1 & (1<<5))
> -			drive->wcache = 1;
> -		/* ATA6 cache extended commands */
> -		cf = drive->id->command_set_2 >> 24;
> -		if((cf & 0xC0) == 0x40 && (cf & 0x30) != 0)
> -			drive->wcache = 1;
>  	}
> +	drive->wcache = 0;
> +	/* Cache enabled ? */
> +	if (drive->id->csfo & 1)
> +		drive->wcache = 1;
> +	/* Cache command set available ? */
> +	if (drive->id->cfs_enable_1 & (1<<5))
> +		drive->wcache = 1;
> +	/* ATA6 cache extended commands */
> +	cf = drive->id->command_set_2 >> 24;
> +	if((cf & 0xC0) == 0x40 && (cf & 0x30) != 0)
> +		drive->wcache = 1;
>  	return 0;
>  }
>  
> @@ -1779,6 +1783,7 @@ static int ide_cacheflush_p(ide_drive_t 
>  static int idedisk_release(struct inode *inode, struct file *filp)
>  {
>  	ide_drive_t *drive = inode->i_bdev->bd_disk->private_data;
> +	ide_cacheflush_p(drive);
>  	if (drive->removable && drive->usage == 1) {
>  		ide_task_t args;
>  		memset(&args, 0, sizeof(ide_task_t));
> @@ -1788,7 +1793,6 @@ static int idedisk_release(struct inode 
>  		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
>  			drive->doorlocking = 0;
>  	}
> -	ide_cacheflush_p(drive);
>  	drive->usage--;
>  	return 0;
>  }

Looks good to me.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVB0E5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVB0E5m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 23:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVB0E5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 23:57:42 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:63506 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261350AbVB0Eyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 23:54:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=YDHMXYHvllkoQNJX/rLVwCiLIfOA+0/DAOUBK5Q4lzxM+jdCLWdQC8om5wvtgEBB7Tqlp125iFsZd7K4HGw6p8F3c1KxyCUrxwY/Igb1VDT+qHcxYgg/tUJ2FgdRqOvVKtqpub/cYNvA4i9y0F6OG4DsqvmpoXSgbbAwWc40Rrk=
Date: Sun, 27 Feb 2005 13:54:39 +0900
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>
Subject: Re: [patch ide-dev 1/9] use struct ata_taskfile in ide_task_t
Message-ID: <20050227045439.GB25723@htj.dyndns.org>
References: <Pine.GSO.4.58.0502241535240.13534@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0502241535240.13534@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.5.6+20040907i
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Bartlomiej.

 Neat patch.  Codes look much better now. :-)

On Thu, Feb 24, 2005 at 03:36:44PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> * use struct ata_taskfile instead of .flags,
>   .tfRegister[] and .hobRegister[] in ide_task_t
> * add #ifndef __KERNEL__ around definitions of {task,hob}_struct_t
> * don't set write-only .hobRegister[6] and .hobRegister[7]
>   in idedisk_set_max_address_ext()
> * remove no longer needed IDE_CONTROL_OFFSET_HOB define
> 
> diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> --- a/drivers/ide/ide-disk.c	2005-02-17 23:38:30 +01:00
> +++ b/drivers/ide/ide-disk.c	2005-02-17 23:38:30 +01:00
> @@ -328,23 +328,24 @@
>  static unsigned long idedisk_read_native_max_address(ide_drive_t *drive)
>  {
>  	ide_task_t args;
> +	struct ata_taskfile *tf = &args.tf;
>  	unsigned long addr = 0;
> 
>  	/* Create IDE/ATA command request structure */
>  	memset(&args, 0, sizeof(ide_task_t));
> -	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
> -	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX;
> +
> +	tf->device	= 0x40;

 Wouldn't ATA_LBA be clearer?

> +	tf->command	= WIN_READ_NATIVE_MAX;
> +
>  	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
>  	args.handler				= &task_no_data_intr;
>  	/* submit command request */
>  	ide_raw_taskfile(drive, &args, NULL);
> 
>  	/* if OK, compute maximum address value */
> -	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
> -		addr = ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
> -		     | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
> -		     | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
> -		     | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
> +	if ((tf->command & 1) == 0) {
> +		addr = ((tf->device & 0xf) << 24) |
> +		       (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
>  		addr++;	/* since the return value is (maxlba - 1), we add 1 */
>  	}
>  	return addr;
> @@ -353,29 +354,27 @@
>  static unsigned long long idedisk_read_native_max_address_ext(ide_drive_t *drive)
>  {
>  	ide_task_t args;
> +	struct ata_taskfile *tf = &args.tf;
>  	unsigned long long addr = 0;
> 
>  	/* Create IDE/ATA command request structure */
>  	memset(&args, 0, sizeof(ide_task_t));
> 
> -	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
> -	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX_EXT;
> +	tf->device	= 0x40;

 Ditto.

> +	tf->command	= WIN_READ_NATIVE_MAX_EXT;
> +
>  	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
>  	args.handler				= &task_no_data_intr;
> 
> -	args.flags |= ATA_TFLAG_LBA48;
> +	tf->flags |= ATA_TFLAG_LBA48;
> 
>          /* submit command request */
>          ide_raw_taskfile(drive, &args, NULL);
> 
>  	/* if OK, compute maximum address value */
> -	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
> -		u32 high = (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
> -			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
> -			    args.hobRegister[IDE_SECTOR_OFFSET];
> -		u32 low  = ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
> -			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
> -			    (args.tfRegister[IDE_SECTOR_OFFSET]);
> +	if ((tf->command & 1) == 0) {
> +		u32 high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
> +		u32 low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
>  		addr = ((__u64)high << 24) | low;
>  		addr++;	/* since the return value is (maxlba - 1), we add 1 */
>  	}
> @@ -389,26 +388,27 @@
>  static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
>  {
>  	ide_task_t args;
> +	struct ata_taskfile *tf = &args.tf;
>  	unsigned long addr_set = 0;
> 
>  	addr_req--;
>  	/* Create IDE/ATA command request structure */
>  	memset(&args, 0, sizeof(ide_task_t));
> -	args.tfRegister[IDE_SECTOR_OFFSET]	= ((addr_req >>  0) & 0xff);
> -	args.tfRegister[IDE_LCYL_OFFSET]	= ((addr_req >>  8) & 0xff);
> -	args.tfRegister[IDE_HCYL_OFFSET]	= ((addr_req >> 16) & 0xff);
> -	args.tfRegister[IDE_SELECT_OFFSET]	= ((addr_req >> 24) & 0x0f) | 0x40;
> -	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SET_MAX;
> +
> +	tf->lbal	= addr_req;
> +	tf->lbam	= addr_req >> 8;
> +	tf->lbah	= addr_req >> 16;
> +	tf->device	= ((addr_req >> 24) & 0xf) | 0x40;

 Ditto.

> +	tf->command	= WIN_SET_MAX;
> +
>  	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
>  	args.handler				= &task_no_data_intr;
>  	/* submit command request */
>  	ide_raw_taskfile(drive, &args, NULL);
>  	/* if OK, read new maximum address value */
> -	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
> -		addr_set = ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
> -			 | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
> -			 | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
> -			 | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
> +	if ((tf->command & 1) == 0) {
> +		addr_set = ((tf->device & 0xf) << 24) |
> +			   (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
>  		addr_set++;
>  	}
>  	return addr_set;
> @@ -417,36 +417,33 @@
>  static unsigned long long idedisk_set_max_address_ext(ide_drive_t *drive, unsigned long long addr_req)
>  {
>  	ide_task_t args;
> +	struct ata_taskfile *tf = &args.tf;
>  	unsigned long long addr_set = 0;
> 
>  	addr_req--;
>  	/* Create IDE/ATA command request structure */
>  	memset(&args, 0, sizeof(ide_task_t));
> -	args.tfRegister[IDE_SECTOR_OFFSET]	= ((addr_req >>  0) & 0xff);
> -	args.tfRegister[IDE_LCYL_OFFSET]	= ((addr_req >>= 8) & 0xff);
> -	args.tfRegister[IDE_HCYL_OFFSET]	= ((addr_req >>= 8) & 0xff);
> -	args.tfRegister[IDE_SELECT_OFFSET]      = 0x40;
> -	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SET_MAX_EXT;
> -	args.hobRegister[IDE_SECTOR_OFFSET]	= (addr_req >>= 8) & 0xff;
> -	args.hobRegister[IDE_LCYL_OFFSET]	= (addr_req >>= 8) & 0xff;
> -	args.hobRegister[IDE_HCYL_OFFSET]	= (addr_req >>= 8) & 0xff;
> -	args.hobRegister[IDE_SELECT_OFFSET]	= 0x40;
> -	args.hobRegister[IDE_CONTROL_OFFSET_HOB]= (drive->ctl|0x80);
> +
> +	tf->lbal	= addr_req;
> +	tf->lbam	= addr_req >> 8;
> +	tf->lbah	= addr_req >> 16;
> +	tf->device	= 0x40;

 Ditto.

> +	tf->command	= WIN_SET_MAX_EXT;
> +	tf->hob_lbal	= addr_req >> 24;
> +	tf->hob_lbam	= addr_req >> 32;
> +	tf->hob_lbah	= addr_req >> 40;
> +
>  	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
>  	args.handler				= &task_no_data_intr;
> 
> -	args.flags |= ATA_TFLAG_LBA48;
> +	tf->flags |= ATA_TFLAG_LBA48;
> 
>  	/* submit command request */
>  	ide_raw_taskfile(drive, &args, NULL);
>  	/* if OK, compute maximum address value */
> -	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
> -		u32 high = (args.hobRegister[IDE_HCYL_OFFSET] << 16) |
> -			   (args.hobRegister[IDE_LCYL_OFFSET] <<  8) |
> -			    args.hobRegister[IDE_SECTOR_OFFSET];
> -		u32 low  = ((args.tfRegister[IDE_HCYL_OFFSET])<<16) |
> -			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
> -			    (args.tfRegister[IDE_SECTOR_OFFSET]);
> +	if ((tf->command & 1) == 0) {
> +		u32 high = (tf->hob_lbah << 16) | (tf->hob_lbam << 8) | tf->hob_lbal;
> +		u32 low  = (tf->lbah << 16) | (tf->lbam << 8) | tf->lbal;
>  		addr_set = ((__u64)high << 24) | low;
>  		addr_set++;
>  	}
> @@ -562,12 +559,15 @@
>  static int smart_enable(ide_drive_t *drive)
>  {
>  	ide_task_t args;
> +	struct ata_taskfile *tf = &args.tf;
> 
>  	memset(&args, 0, sizeof(ide_task_t));
> -	args.tfRegister[IDE_FEATURE_OFFSET]	= SMART_ENABLE;
> -	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
> -	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
> -	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
> +
> +	tf->feature	= SMART_ENABLE;
> +	tf->lbam	= SMART_LCYL_PASS;
> +	tf->lbah	= SMART_HCYL_PASS;
> +	tf->command	= WIN_SMART;
> +
>  	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
>  	args.handler				= &task_no_data_intr;
>  	return ide_raw_taskfile(drive, &args, NULL);
> @@ -576,13 +576,16 @@
>  static int get_smart_values(ide_drive_t *drive, u8 *buf)
>  {
>  	ide_task_t args;
> +	struct ata_taskfile *tf = &args.tf;
> 
>  	memset(&args, 0, sizeof(ide_task_t));
> -	args.tfRegister[IDE_FEATURE_OFFSET]	= SMART_READ_VALUES;
> -	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
> -	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
> -	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
> -	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
> +
> +	tf->feature	= SMART_READ_VALUES;
> +	tf->nsect	= 1;
> +	tf->lbam	= SMART_LCYL_PASS;
> +	tf->lbah	= SMART_HCYL_PASS;
> +	tf->command	= WIN_SMART;
> +
>  	args.command_type			= IDE_DRIVE_TASK_IN;
>  	args.data_phase				= TASKFILE_IN;
>  	args.handler				= &task_in_intr;
> @@ -593,12 +596,16 @@
>  static int get_smart_thresholds(ide_drive_t *drive, u8 *buf)
>  {
>  	ide_task_t args;
> +	struct ata_taskfile *tf = &args.tf;
> +
>  	memset(&args, 0, sizeof(ide_task_t));
> -	args.tfRegister[IDE_FEATURE_OFFSET]	= SMART_READ_THRESHOLDS;
> -	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
> -	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
> -	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
> -	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
> +
> +	tf->feature	= SMART_READ_THRESHOLDS;
> +	tf->nsect	= 1;
> +	tf->lbam	= SMART_LCYL_PASS;
> +	tf->lbah	= SMART_HCYL_PASS;
> +	tf->command	= WIN_SMART;
> +
>  	args.command_type			= IDE_DRIVE_TASK_IN;
>  	args.data_phase				= TASKFILE_IN;
>  	args.handler				= &task_in_intr;
> @@ -750,15 +757,17 @@
>  static int write_cache(ide_drive_t *drive, int arg)
>  {
>  	ide_task_t args;
> +	struct ata_taskfile *tf = &args.tf;
>  	int err;
> 
>  	if (!ide_id_has_flush_cache(drive->id))
>  		return 1;
> 
>  	memset(&args, 0, sizeof(ide_task_t));
> -	args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ?
> -			SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
> -	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
> +
> +	tf->feature = arg ? SETFEATURES_EN_WCACHE : SETFEATURES_DIS_WCACHE;
> +	tf->command = WIN_SETFEATURES;
> +
>  	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
>  	args.handler				= &task_no_data_intr;
> 
> @@ -773,13 +782,16 @@
>  static int do_idedisk_flushcache (ide_drive_t *drive)
>  {
>  	ide_task_t args;
> +	struct ata_taskfile *tf = &args.tf;
> 
>  	memset(&args, 0, sizeof(ide_task_t));
> +
>  	if (ide_id_has_flush_cache_ext(drive->id)) {
> -		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE_EXT;
> -		args.flags |= ATA_TFLAG_LBA48;
> +		tf->command = WIN_FLUSH_CACHE_EXT;
> +		tf->flags |= ATA_TFLAG_LBA48;
>  	} else
> -		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_FLUSH_CACHE;
> +		tf->command = WIN_FLUSH_CACHE;
> +
>  	args.command_type			= IDE_DRIVE_TASK_NO_DATA;
>  	args.handler				= &task_no_data_intr;
>  	return ide_raw_taskfile(drive, &args, NULL);
> @@ -788,12 +800,14 @@
>  static int set_acoustic (ide_drive_t *drive, int arg)
>  {
>  	ide_task_t args;
> +	struct ata_taskfile *tf = &args.tf;
> 
>  	memset(&args, 0, sizeof(ide_task_t));
> -	args.tfRegister[IDE_FEATURE_OFFSET]	= (arg) ? SETFEATURES_EN_AAM :
> -							  SETFEATURES_DIS_AAM;
> -	args.tfRegister[IDE_NSECTOR_OFFSET]	= arg;
> -	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SETFEATURES;
> +
> +	tf->feature	= arg ? SETFEATURES_EN_AAM : SETFEATURES_DIS_AAM;
> +	tf->nsect	= arg;
> +	tf->command	= WIN_SETFEATURES;
> +
>  	args.command_type = IDE_DRIVE_TASK_NO_DATA;
>  	args.handler	  = &task_no_data_intr;
>  	ide_raw_taskfile(drive, &args, NULL);
> @@ -1076,7 +1090,7 @@
>  	if (drive->removable && drive->usage == 1) {
>  		ide_task_t args;
>  		memset(&args, 0, sizeof(ide_task_t));
> -		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORLOCK;
> +		args.tf.command = WIN_DOORLOCK;
>  		args.command_type = IDE_DRIVE_TASK_NO_DATA;
>  		args.handler	  = &task_no_data_intr;
>  		check_disk_change(inode->i_bdev);
> @@ -1102,7 +1116,7 @@
>  	if (drive->removable && drive->usage == 1) {
>  		ide_task_t args;
>  		memset(&args, 0, sizeof(ide_task_t));
> -		args.tfRegister[IDE_COMMAND_OFFSET] = WIN_DOORUNLOCK;
> +		args.tf.command = WIN_DOORUNLOCK;
>  		args.command_type = IDE_DRIVE_TASK_NO_DATA;
>  		args.handler	  = &task_no_data_intr;
>  		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
> diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> --- a/drivers/ide/ide-io.c	2005-02-17 23:38:30 +01:00
> +++ b/drivers/ide/ide-io.c	2005-02-17 23:38:30 +01:00
> @@ -227,6 +227,7 @@
>  static ide_startstop_t ide_start_power_step(ide_drive_t *drive, struct request *rq)
>  {
>  	ide_task_t *args = rq->special;
> +	struct ata_taskfile *tf = &args->tf;
> 
>  	memset(args, 0, sizeof(*args));
> 
> @@ -245,23 +246,27 @@
>  			ide_complete_power_step(drive, rq, 0, 0);
>  			return ide_stopped;
>  		}
> +
>  		if (ide_id_has_flush_cache_ext(drive->id)) {
> -			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
> -			args->flags |= ATA_TFLAG_LBA48;
> +			tf->command = WIN_FLUSH_CACHE_EXT;
> +			tf->flags |= ATA_TFLAG_LBA48;
>  		} else
> -			args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
> +			tf->command = WIN_FLUSH_CACHE;
> +
>  		args->command_type = IDE_DRIVE_TASK_NO_DATA;
>  		args->handler	   = &task_no_data_intr;
>  		return do_rw_taskfile(drive, args);
> 
>  	case idedisk_pm_standby:	/* Suspend step 2 (standby) */
> -		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_STANDBYNOW1;
> +		tf->command = WIN_STANDBYNOW1;
> +
>  		args->command_type = IDE_DRIVE_TASK_NO_DATA;
>  		args->handler	   = &task_no_data_intr;
>  		return do_rw_taskfile(drive, args);
> 
>  	case idedisk_pm_idle:		/* Resume step 1 (idle) */
> -		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
> +		tf->command = WIN_IDLEIMMEDIATE;
> +
>  		args->command_type = IDE_DRIVE_TASK_NO_DATA;
>  		args->handler = task_no_data_intr;
>  		return do_rw_taskfile(drive, args);
> @@ -473,28 +478,31 @@
>  			rq->errors = !OK_STAT(stat,READY_STAT,BAD_STAT);
> 
>  		if (args) {
> -			if (args->tf_in_flags.b.data) {
> -				u16 data				= hwif->INW(IDE_DATA_REG);
> -				args->tfRegister[IDE_DATA_OFFSET]	= (data) & 0xFF;
> -				args->hobRegister[IDE_DATA_OFFSET]	= (data >> 8) & 0xFF;
> -			}
> -			args->tfRegister[IDE_ERROR_OFFSET]   = err;
> +			struct ata_taskfile *tf = &args->tf;
> +
> +			if (args->tf_in_flags.b.data)
> +				args->data = hwif->INW(IDE_DATA_REG);
> +
> +			tf->feature	= err;
> +
>  			/* be sure we're looking at the low order bits */
>  			hwif->OUTB(drive->ctl & ~0x80, IDE_CONTROL_REG);
> -			args->tfRegister[IDE_NSECTOR_OFFSET] = hwif->INB(IDE_NSECTOR_REG);
> -			args->tfRegister[IDE_SECTOR_OFFSET]  = hwif->INB(IDE_SECTOR_REG);
> -			args->tfRegister[IDE_LCYL_OFFSET]    = hwif->INB(IDE_LCYL_REG);
> -			args->tfRegister[IDE_HCYL_OFFSET]    = hwif->INB(IDE_HCYL_REG);
> -			args->tfRegister[IDE_SELECT_OFFSET]  = hwif->INB(IDE_SELECT_REG);
> -			args->tfRegister[IDE_STATUS_OFFSET]  = stat;
> 
> -			if (args->flags & ATA_TFLAG_LBA48) {
> +			tf->nsect	= hwif->INB(IDE_NSECTOR_REG);
> +			tf->lbal	= hwif->INB(IDE_SECTOR_REG);
> +			tf->lbam	= hwif->INB(IDE_LCYL_REG);
> +			tf->lbah	= hwif->INB(IDE_HCYL_REG);
> +			tf->device	= hwif->INB(IDE_SELECT_REG);
> +			tf->command	= stat;
> +
> +			if (tf->flags & ATA_TFLAG_LBA48) {
>  				hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
> -				args->hobRegister[IDE_FEATURE_OFFSET]	= hwif->INB(IDE_FEATURE_REG);
> -				args->hobRegister[IDE_NSECTOR_OFFSET]	= hwif->INB(IDE_NSECTOR_REG);
> -				args->hobRegister[IDE_SECTOR_OFFSET]	= hwif->INB(IDE_SECTOR_REG);
> -				args->hobRegister[IDE_LCYL_OFFSET]	= hwif->INB(IDE_LCYL_REG);
> -				args->hobRegister[IDE_HCYL_OFFSET]	= hwif->INB(IDE_HCYL_REG);
> +
> +				tf->hob_feature	= hwif->INB(IDE_FEATURE_REG);
> +				tf->hob_nsect	= hwif->INB(IDE_NSECTOR_REG);
> +				tf->hob_lbal	= hwif->INB(IDE_SECTOR_REG);
> +				tf->hob_lbam	= hwif->INB(IDE_LCYL_REG);
> +				tf->hob_lbah	= hwif->INB(IDE_HCYL_REG);
>  			}
>  		}
>  	} else if (blk_pm_request(rq)) {
> @@ -791,28 +799,34 @@
> 
>  static void ide_init_specify_cmd(ide_drive_t *drive, ide_task_t *task)
>  {
> -	task->tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
> -	task->tfRegister[IDE_SECTOR_OFFSET]  = drive->sect;
> -	task->tfRegister[IDE_LCYL_OFFSET]    = drive->cyl;
> -	task->tfRegister[IDE_HCYL_OFFSET]    = drive->cyl>>8;
> -	task->tfRegister[IDE_SELECT_OFFSET]  = ((drive->head-1)|drive->select.all)&0xBF;
> -	task->tfRegister[IDE_COMMAND_OFFSET] = WIN_SPECIFY;
> +	struct ata_taskfile *tf = &task->tf;
> +
> +	tf->nsect	= drive->sect;
> +	tf->lbal	= drive->sect;
> +	tf->lbam	= drive->cyl;
> +	tf->lbah	= drive->cyl >> 8;
> +	tf->device	= ((drive->head - 1) | drive->select.all) & 0xBF;
> +	tf->command	= WIN_SPECIFY;
> 
>  	task->handler = &set_geometry_intr;
>  }
> 
>  static void ide_init_restore_cmd(ide_drive_t *drive, ide_task_t *task)
>  {
> -	task->tfRegister[IDE_NSECTOR_OFFSET] = drive->sect;
> -	task->tfRegister[IDE_COMMAND_OFFSET] = WIN_RESTORE;
> +	struct ata_taskfile *tf = &task->tf;
> +
> +	tf->nsect	= drive->sect;
> +	tf->command	= WIN_RESTORE;
> 
>  	task->handler = &recal_intr;
>  }
> 
>  static void ide_init_setmult_cmd(ide_drive_t *drive, ide_task_t *task)
>  {
> -	task->tfRegister[IDE_NSECTOR_OFFSET] = drive->mult_req;
> -	task->tfRegister[IDE_COMMAND_OFFSET] = WIN_SETMULT;
> +	struct ata_taskfile *tf = &task->tf;
> +
> +	tf->nsect	= drive->mult_req;
> +	tf->command	= WIN_SETMULT;
> 
>  	task->handler = &set_multmode_intr;
>  }
> diff -Nru a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
> --- a/drivers/ide/ide-iops.c	2005-02-17 23:38:30 +01:00
> +++ b/drivers/ide/ide-iops.c	2005-02-17 23:38:30 +01:00
> @@ -645,9 +645,9 @@
> 
>  int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
>  {
> -	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> -	    (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
> -	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
> +	if (args->tf.command == WIN_SETFEATURES &&
> +	    args->tf.lbal > XFER_UDMA_2 &&
> +	    args->tf.feature == SETFEATURES_XFER) {
>  #ifndef CONFIG_IDEDMA_IVB
>  		if ((drive->id->hw_config & 0x6000) == 0) {
>  #else /* !CONFIG_IDEDMA_IVB */
> @@ -675,9 +675,9 @@
>   */
>  int set_transfer (ide_drive_t *drive, ide_task_t *args)
>  {
> -	if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> -	    (args->tfRegister[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
> -	    (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
> +	if (args->tf.command == WIN_SETFEATURES &&
> +	    args->tf.lbal >= XFER_SW_DMA_0 &&
> +	    args->tf.feature == SETFEATURES_XFER &&
>  	    (drive->id->dma_ultra ||
>  	     drive->id->dma_mword ||
>  	     drive->id->dma_1word))
> diff -Nru a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
> --- a/drivers/ide/ide-lib.c	2005-02-17 23:38:30 +01:00
> +++ b/drivers/ide/ide-lib.c	2005-02-17 23:38:30 +01:00
> @@ -467,8 +467,7 @@
>  	} else if (rq->flags & REQ_DRIVE_TASKFILE) {
>  		ide_task_t *args = rq->special;
>  		if (args) {
> -			task_struct_t *tf = (task_struct_t *) args->tfRegister;
> -			opcode = tf->command;
> +			opcode = args->tf.command;
>  			found = 1;
>  		}
>  	}
> diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
> --- a/drivers/ide/ide-taskfile.c	2005-02-17 23:38:30 +01:00
> +++ b/drivers/ide/ide-taskfile.c	2005-02-17 23:38:30 +01:00
> @@ -84,12 +84,16 @@
>  int taskfile_lib_get_identify (ide_drive_t *drive, u8 *buf)
>  {
>  	ide_task_t args;
> +	struct ata_taskfile *tf = &args.tf;
> +
>  	memset(&args, 0, sizeof(ide_task_t));
> -	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
> +
> +	tf->nsect = 1;
>  	if (drive->media == ide_disk)
> -		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_IDENTIFY;
> +		tf->command = WIN_IDENTIFY;
>  	else
> -		args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_PIDENTIFY;
> +		tf->command = WIN_PIDENTIFY;
> +
>  	args.command_type = IDE_DRIVE_TASK_IN;
>  	args.data_phase   = TASKFILE_IN;
>  	args.handler	  = &task_in_intr;
> @@ -99,9 +103,8 @@
>  ide_startstop_t do_rw_taskfile (ide_drive_t *drive, ide_task_t *task)
>  {
>  	ide_hwif_t *hwif	= HWIF(drive);
> -	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
> -	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
> -	u8 HIHI			= (task->flags & ATA_TFLAG_LBA48) ? 0xE0 : 0xEF;
> +	struct ata_taskfile *tf = &task->tf;
> +	u8 HIHI			= (tf->flags & ATA_TFLAG_LBA48) ? 0xE0 : 0xEF;
> 
>  	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
>  	if (IDE_CONTROL_REG) {
> @@ -110,36 +113,36 @@
>  	}
>  	SELECT_MASK(drive, 0);
> 
> -	if (task->flags & ATA_TFLAG_LBA48) {
> -		hwif->OUTB(hobfile->feature, IDE_FEATURE_REG);
> -		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
> -		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
> -		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
> -		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
> +	if (tf->flags & ATA_TFLAG_LBA48) {
> +		hwif->OUTB(tf->hob_feature, IDE_FEATURE_REG);
> +		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
> +		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
> +		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
> +		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
>  	}
> 
> -	hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
> -	hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
> -	hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
> -	hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
> -	hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
> +	hwif->OUTB(tf->feature, IDE_FEATURE_REG);
> +	hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
> +	hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
> +	hwif->OUTB(tf->lbam, IDE_LCYL_REG);
> +	hwif->OUTB(tf->lbah, IDE_HCYL_REG);
> 
> -	hwif->OUTB((taskfile->device_head & HIHI) | drive->select.all, IDE_SELECT_REG);
> +	hwif->OUTB((tf->device & HIHI) | drive->select.all, IDE_SELECT_REG);
> 
>  	if (task->handler != NULL) {
>  		if (task->prehandler != NULL) {
> -			hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
> +			hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
>  			ndelay(400);	/* FIXME */
>  			return task->prehandler(drive, task->rq);
>  		}
> -		ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
> +		ide_execute_command(drive, tf->command, task->handler, WAIT_WORSTCASE, NULL);
>  		return ide_started;
>  	}
> 
>  	if (!drive->using_dma)
>  		return ide_stopped;
> 
> -	switch (taskfile->command) {
> +	switch (tf->command) {
>  		case WIN_WRITEDMA_ONCE:
>  		case WIN_WRITEDMA:
>  		case WIN_WRITEDMA_EXT:
> @@ -148,7 +151,7 @@
>  		case WIN_READDMA_EXT:
>  		case WIN_IDENTIFY_DMA:
>  			if (!hwif->dma_setup(drive)) {
> -				hwif->dma_exec_cmd(drive, taskfile->command);
> +				hwif->dma_exec_cmd(drive, tf->command);
>  				hwif->dma_start(drive);
>  				return ide_started;
>  			}
> @@ -323,7 +326,7 @@
>  	if (rq->flags & REQ_DRIVE_TASKFILE) {
>  		ide_task_t *task = rq->special;
> 
> -		if (task->flags & ATA_TFLAG_IO_16BIT)
> +		if (task->tf.flags & ATA_TFLAG_IO_16BIT)
>  			drive->io_32bit = 0;
>  	}
> 
> @@ -493,7 +496,7 @@
>  	 */
>  	if (args->command_type != IDE_DRIVE_TASK_NO_DATA) {
>  		if (data_size == 0)
> -			rq.nr_sectors = (args->hobRegister[IDE_NSECTOR_OFFSET] << 8) | args->tfRegister[IDE_NSECTOR_OFFSET];
> +			rq.nr_sectors = (args->tf.hob_nsect << 8) | args->tf.nsect;
>  		else
>  			rq.nr_sectors = data_size / SECTOR_SIZE;
> 
> @@ -525,10 +528,9 @@
>  {
>  	ide_task_request_t	*req_task;
>  	ide_task_t		args;
> +	struct ata_taskfile *tf = &args.tf;
>  	u8 *outbuf		= NULL;
>  	u8 *inbuf		= NULL;
> -	task_ioreg_t *argsptr	= args.tfRegister;
> -	task_ioreg_t *hobsptr	= args.hobRegister;
>  	int err			= 0;
>  	int tasksize		= sizeof(struct ide_task_request_s);
>  	int taskin		= 0;
> @@ -577,17 +579,31 @@
>  	}
> 
>  	memset(&args, 0, sizeof(ide_task_t));
> -	memcpy(argsptr, req_task->io_ports, HDIO_DRIVE_TASK_HDR_SIZE);
> -	memcpy(hobsptr, req_task->hob_ports, HDIO_DRIVE_HOB_HDR_SIZE);
> +
> +	args.data = req_task->io_ports[0] | (req_task->hob_ports[0] << 8);
> +
> +	tf->hob_feature	= req_task->hob_ports[1];
> +	tf->hob_nsect	= req_task->hob_ports[2];
> +	tf->hob_lbal	= req_task->hob_ports[3];
> +	tf->hob_lbam	= req_task->hob_ports[4];
> +	tf->hob_lbah	= req_task->hob_ports[5];
> +
> +	tf->feature	= req_task->io_ports[1];
> +	tf->nsect	= req_task->io_ports[2];
> +	tf->lbal	= req_task->io_ports[3];
> +	tf->lbam	= req_task->io_ports[4];
> +	tf->lbah	= req_task->io_ports[5];
> +	tf->device	= req_task->io_ports[6];
> +	tf->command	= req_task->io_ports[7];
> 
>  	args.tf_in_flags  = req_task->in_flags;
>  	args.tf_out_flags = req_task->out_flags;
>  	args.data_phase   = req_task->data_phase;
>  	args.command_type = req_task->req_cmd;
> 
> -	args.flags = ATA_TFLAG_IO_16BIT;
> +	tf->flags = ATA_TFLAG_IO_16BIT;
>  	if (drive->addressing == 1)
> -		args.flags |= ATA_TFLAG_LBA48;
> +		tf->flags |= ATA_TFLAG_LBA48;
> 
>  	switch(req_task->data_phase) {
>  		case TASKFILE_OUT_DMAQ:
> @@ -636,8 +652,23 @@
>  			goto abort;
>  	}
> 
> -	memcpy(req_task->io_ports, &(args.tfRegister), HDIO_DRIVE_TASK_HDR_SIZE);
> -	memcpy(req_task->hob_ports, &(args.hobRegister), HDIO_DRIVE_HOB_HDR_SIZE);
> +	req_task->io_ports[0]	= args.data;
> +	req_task->hob_ports[0]	= args.data << 8;
> +
> +	req_task->hob_ports[1] = tf->hob_feature;
> +	req_task->hob_ports[2] = tf->hob_nsect;
> +	req_task->hob_ports[3] = tf->hob_lbal;
> +	req_task->hob_ports[4] = tf->hob_lbam;
> +	req_task->hob_ports[5] = tf->hob_lbah;
> +
> +	req_task->io_ports[1] = tf->feature;
> +	req_task->io_ports[2] = tf->nsect;
> +	req_task->io_ports[3] = tf->lbal;
> +	req_task->io_ports[4] = tf->lbam;
> +	req_task->io_ports[5] = tf->lbah;
> +	req_task->io_ports[6] = tf->device;
> +	req_task->io_ports[7] = tf->command;
> +
>  	req_task->in_flags  = args.tf_in_flags;
>  	req_task->out_flags = args.tf_out_flags;
> 
> @@ -698,6 +729,7 @@
>  	u8 xfer_rate = 0;
>  	int argsize = 4;
>  	ide_task_t tfargs;
> +	struct ata_taskfile *tf = &tfargs.tf;
> 
>  	if (NULL == (void *) arg) {
>  		struct request rq;
> @@ -709,13 +741,10 @@
>  		return -EFAULT;
> 
>  	memset(&tfargs, 0, sizeof(ide_task_t));
> -	tfargs.tfRegister[IDE_FEATURE_OFFSET] = args[2];
> -	tfargs.tfRegister[IDE_NSECTOR_OFFSET] = args[3];
> -	tfargs.tfRegister[IDE_SECTOR_OFFSET]  = args[1];
> -	tfargs.tfRegister[IDE_LCYL_OFFSET]    = 0x00;
> -	tfargs.tfRegister[IDE_HCYL_OFFSET]    = 0x00;
> -	tfargs.tfRegister[IDE_SELECT_OFFSET]  = 0x00;
> -	tfargs.tfRegister[IDE_COMMAND_OFFSET] = args[0];
> +	tf->feature	= args[2];
> +	tf->nsect	= args[3];
> +	tf->lbal	= args[1];
> +	tf->command	= args[0];
> 
>  	if (args[3]) {
>  		argsize = 4 + (SECTOR_WORDS * 4 * args[3]);
> @@ -781,8 +810,7 @@
>  ide_startstop_t flagged_taskfile (ide_drive_t *drive, ide_task_t *task)
>  {
>  	ide_hwif_t *hwif	= HWIF(drive);
> -	task_struct_t *taskfile	= (task_struct_t *) task->tfRegister;
> -	hob_struct_t *hobfile	= (hob_struct_t *) task->hobRegister;
> +	struct ata_taskfile *tf = &task->tf;
>  #if DEBUG_TASKFILE
>  	u8 status;
>  #endif
> @@ -831,34 +859,32 @@
>  	}
>  #endif
> 
> -	if (task->tf_out_flags.b.data) {
> -		u16 data =  taskfile->data + (hobfile->data << 8);
> -		hwif->OUTW(data, IDE_DATA_REG);
> -	}
> +	if (task->tf_out_flags.b.data)
> +		hwif->OUTW(task->data, IDE_DATA_REG);
> 
>  	/* (ks) send hob registers first */
>  	if (task->tf_out_flags.b.nsector_hob)
> -		hwif->OUTB(hobfile->sector_count, IDE_NSECTOR_REG);
> +		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
>  	if (task->tf_out_flags.b.sector_hob)
> -		hwif->OUTB(hobfile->sector_number, IDE_SECTOR_REG);
> +		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
>  	if (task->tf_out_flags.b.lcyl_hob)
> -		hwif->OUTB(hobfile->low_cylinder, IDE_LCYL_REG);
> +		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
>  	if (task->tf_out_flags.b.hcyl_hob)
> -		hwif->OUTB(hobfile->high_cylinder, IDE_HCYL_REG);
> +		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
> 
>  	/* (ks) Send now the standard registers */
>  	if (task->tf_out_flags.b.error_feature)
> -		hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
> +		hwif->OUTB(tf->feature, IDE_FEATURE_REG);
>  	/* refers to number of sectors to transfer */
>  	if (task->tf_out_flags.b.nsector)
> -		hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
> +		hwif->OUTB(tf->nsect, IDE_NSECTOR_REG);
>  	/* refers to sector offset or start sector */
>  	if (task->tf_out_flags.b.sector)
> -		hwif->OUTB(taskfile->sector_number, IDE_SECTOR_REG);
> +		hwif->OUTB(tf->lbal, IDE_SECTOR_REG);
>  	if (task->tf_out_flags.b.lcyl)
> -		hwif->OUTB(taskfile->low_cylinder, IDE_LCYL_REG);
> +		hwif->OUTB(tf->lbam, IDE_LCYL_REG);
>  	if (task->tf_out_flags.b.hcyl)
> -		hwif->OUTB(taskfile->high_cylinder, IDE_HCYL_REG);
> +		hwif->OUTB(tf->lbah, IDE_HCYL_REG);
> 
>          /*
>  	 * (ks) In the flagged taskfile approch, we will use all specified
> @@ -866,7 +892,7 @@
>  	 * select bit (master/slave) in the drive_head register. We must make
>  	 * sure that the desired drive is selected.
>  	 */
> -	hwif->OUTB(taskfile->device_head | drive->select.all, IDE_SELECT_REG);
> +	hwif->OUTB(tf->device | drive->select.all, IDE_SELECT_REG);
>  	switch(task->data_phase) {
> 
>     	        case TASKFILE_OUT_DMAQ:
> @@ -874,7 +900,7 @@
>  		case TASKFILE_IN_DMAQ:
>  		case TASKFILE_IN_DMA:
>  			hwif->dma_setup(drive);
> -			hwif->dma_exec_cmd(drive, taskfile->command);
> +			hwif->dma_exec_cmd(drive, tf->command);
>  			hwif->dma_start(drive);
>  			break;
> 
> @@ -884,11 +910,11 @@
> 
>  			/* Issue the command */
>  			if (task->prehandler) {
> -				hwif->OUTBSYNC(drive, taskfile->command, IDE_COMMAND_REG);
> +				hwif->OUTBSYNC(drive, tf->command, IDE_COMMAND_REG);
>  				ndelay(400);	/* FIXME */
>  				return task->prehandler(drive, task->rq);
>  			}
> -			ide_execute_command(drive, taskfile->command, task->handler, WAIT_WORSTCASE, NULL);
> +			ide_execute_command(drive, tf->command, task->handler, WAIT_WORSTCASE, NULL);
>  	}
> 
>  	return ide_started;
> diff -Nru a/include/linux/ata.h b/include/linux/ata.h
> --- a/include/linux/ata.h	2005-02-17 23:38:30 +01:00
> +++ b/include/linux/ata.h	2005-02-17 23:38:30 +01:00
> @@ -211,15 +211,16 @@
>  	u8			hob_lbam;
>  	u8			hob_lbah;
> 
> -	u8			feature;
> +	u8			feature;	/* error on read */
>  	u8			nsect;
> -	u8			lbal;
> -	u8			lbam;
> -	u8			lbah;
> +	u8			lbal;		/* sector in CHS */
> +	u8			lbam;		/* low cylinder in CHS */
> +	u8			lbah;		/* high cylinder in CHS */
> 
> -	u8			device;
> +	u8			device;		/* select */
> 
>  	u8			command;	/* IO operation */
> +						/* status on read */
>  };
> 
>  #define ata_id_is_ata(id)	(((id)[0] & (1 << 15)) == 0)
> diff -Nru a/include/linux/hdreg.h b/include/linux/hdreg.h
> --- a/include/linux/hdreg.h	2005-02-17 23:38:30 +01:00
> +++ b/include/linux/hdreg.h	2005-02-17 23:38:30 +01:00
> @@ -113,7 +113,7 @@
> 
>  typedef struct ide_task_request_s {
>  	task_ioreg_t	io_ports[8];
> -	task_ioreg_t	hob_ports[8];
> +	task_ioreg_t	hob_ports[8]; /* bytes 6 and 7 are unused */
>  	ide_reg_valid_t	out_flags;
>  	ide_reg_valid_t	in_flags;
>  	int		data_phase;
> @@ -135,6 +135,7 @@
>  	task_ioreg_t sector_count;
>  };
> 
> +#ifndef __KERNEL__
>  typedef struct hd_drive_task_hdr {
>  	task_ioreg_t data;
>  	task_ioreg_t feature;
> @@ -156,6 +157,7 @@
>  	task_ioreg_t device_head;
>  	task_ioreg_t control;
>  } hob_struct_t;
> +#endif
> 
>  #define TASKFILE_INVALID		0x7fff
>  #define TASKFILE_48			0x8000
> diff -Nru a/include/linux/ide.h b/include/linux/ide.h
> --- a/include/linux/ide.h	2005-02-17 23:38:30 +01:00
> +++ b/include/linux/ide.h	2005-02-17 23:38:30 +01:00
> @@ -110,8 +110,6 @@
>  #define IDE_FEATURE_OFFSET	IDE_ERROR_OFFSET
>  #define IDE_COMMAND_OFFSET	IDE_STATUS_OFFSET
> 
> -#define IDE_CONTROL_OFFSET_HOB	(7)
> -
>  #define IDE_DATA_REG		(HWIF(drive)->io_ports[IDE_DATA_OFFSET])
>  #define IDE_ERROR_REG		(HWIF(drive)->io_ports[IDE_ERROR_OFFSET])
>  #define IDE_NSECTOR_REG		(HWIF(drive)->io_ports[IDE_NSECTOR_OFFSET])
> @@ -1252,15 +1250,8 @@
>  extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
> 
>  typedef struct ide_task_s {
> -/*
> - *	struct hd_drive_task_hdr	tf;
> - *	task_struct_t		tf;
> - *	struct hd_drive_hob_hdr		hobf;
> - *	hob_struct_t		hobf;
> - */
> -	unsigned long		flags;		/* ATA_TFLAG_xxx */
> -	task_ioreg_t		tfRegister[8];
> -	task_ioreg_t		hobRegister[8];
> +	struct ata_taskfile	tf;
> +	u16			data;
>  	ide_reg_valid_t		tf_out_flags;
>  	ide_reg_valid_t		tf_in_flags;
>  	int			data_phase;

-- 
tejun


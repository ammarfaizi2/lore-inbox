Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRCGBK4>; Tue, 6 Mar 2001 20:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbRCGBKr>; Tue, 6 Mar 2001 20:10:47 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:39436
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129826AbRCGBKh>; Tue, 6 Mar 2001 20:10:37 -0500
Date: Tue, 6 Mar 2001 17:09:32 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Chip Salzenberg <chip@valinux.com>
cc: Camm Maguire <camm@enhanced.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <20010306163421.C21468@valinux.com>
Message-ID: <Pine.LNX.4.10.10103061709160.13719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chip,

I thought O grabbed that from you...

On Tue, 6 Mar 2001, Chip Salzenberg wrote:

> With Andre's IDE subsystem, I found the below patch necessary to use
> my IDE tape drive (Exabyte Eagle TR-4).  Frankly, it's been so long
> since I created this patch that I can't remember the detailed reasons
> for the changes.  But I knew them once.  :-)  And it works for me.
> 
> Reminder, this is against Andre Hedrick's 2.2 IDE subsystem.
> 
> Index: drivers/block/ide-tape.c
> --- drivers/block/ide-tape.c.prev
> +++ drivers/block/ide-tape.c	Tue Dec  5 01:17:32 2000
> @@ -3096,7 +3096,10 @@ static int idetape_queue_pc_tail (ide_dr
>  static int idetape_flush_tape_buffers (ide_drive_t *drive)
>  {
> +	idetape_tape_t *tape = drive->driver_data;
>  	idetape_pc_t pc;
>  	int rc;
>  
> +	if (tape->chrdev_direction != idetape_direction_write)
> +		return 0;
>  	idetape_create_write_filemark_cmd(drive, &pc, 0);
>  	if ((rc = idetape_queue_pc_tail (drive,&pc)))
> @@ -5199,12 +5202,15 @@ static int idetape_chrdev_open (struct i
>  	if (tape->chrdev_direction == idetape_direction_none) {
>  		MOD_INC_USE_COUNT;
> +		if (tape->onstream) {
>  #if ONSTREAM_DEBUG
> -		if (tape->debug_level >= 6)
> -			printk(KERN_INFO "ide-tape: MOD_INC_USE_COUNT in idetape_chrdev_open-2\n");
> +			if (tape->debug_level >= 6)
> +				printk(KERN_INFO "ide-tape: MOD_INC_USE_COUNT"
> +				       " in idetape_chrdev_open-2\n");
>  #endif
> -		idetape_create_prevent_cmd(drive, &pc, 1);
> -		if (!idetape_queue_pc_tail (drive,&pc)) {
> -			if (tape->door_locked != DOOR_EXPLICITLY_LOCKED)
> -				tape->door_locked = DOOR_LOCKED;
> +			idetape_create_prevent_cmd(drive, &pc, 1);
> +			if (!idetape_queue_pc_tail (drive,&pc)) {
> +				if (tape->door_locked != DOOR_EXPLICITLY_LOCKED)
> +					tape->door_locked = DOOR_LOCKED;
> +			}
>  		}
>  		idetape_analyze_headers(drive);
> @@ -5258,14 +5264,17 @@ static int idetape_chrdev_release (struc
>  		(void) idetape_rewind_tape (drive);
>  	if (tape->chrdev_direction == idetape_direction_none) {
> -		if (tape->door_locked != DOOR_EXPLICITLY_LOCKED) {
> -			idetape_create_prevent_cmd(drive, &pc, 0);
> -			if (!idetape_queue_pc_tail (drive,&pc))
> -				tape->door_locked = DOOR_UNLOCKED;
> -		}
> -		MOD_DEC_USE_COUNT;
> +		if (tape->onstream) {
> +			if (tape->door_locked != DOOR_EXPLICITLY_LOCKED) {
> +				idetape_create_prevent_cmd(drive, &pc, 0);
> +				if (!idetape_queue_pc_tail (drive,&pc))
> +					tape->door_locked = DOOR_UNLOCKED;
> +			}
>  #if ONSTREAM_DEBUG
> -		if (tape->debug_level >= 6)
> -			printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT in idetape_chrdev_release\n");
> +			if (tape->debug_level >= 6)
> +				printk(KERN_INFO "ide-tape: MOD_DEC_USE_COUNT"
> +				       " in idetape_chrdev_release\n");
>  #endif
> +		}
> +		MOD_DEC_USE_COUNT;
>  	}
>  	clear_bit (IDETAPE_BUSY, &tape->flags);
> 
> -- 
> Chip Salzenberg              - a.k.a. -             <chip@valinux.com>
>  "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com


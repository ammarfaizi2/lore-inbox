Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293379AbSBYME7>; Mon, 25 Feb 2002 07:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293382AbSBYMEt>; Mon, 25 Feb 2002 07:04:49 -0500
Received: from [195.63.194.11] ([195.63.194.11]:17421 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293379AbSBYMEk>; Mon, 25 Feb 2002 07:04:40 -0500
Message-ID: <3C7A282B.6010208@evision-ventures.com>
Date: Mon, 25 Feb 2002 13:03:55 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Paul Gortmaker <p_gortmaker@yahoo.com>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [PATCH] IDE clean 12 3rd attempt
In-Reply-To: <UTC200202241352.g1ODqeb08003.aeb@apps.cwi.nl> <3C7A23E4.5EF118D1@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker wrote:
> Andries.Brouwer@cwi.nl wrote:
> 
> 
>>There is something else one might do.
>>In ide-geometry.c there is the routine probe_cmos_for_drives().
>>Long ago I already wrote "Eventually the entire routine below
>>should be removed". I think this is the proper time to do this.
>>
> 
> Yes, I saw this & looked over my mail - we had similar discussion
> & similar conclusion back in May 2000.  (Others may also find aeb's
> notes from this old discussion useful - check the archives)
> 
> 
>>So, it is good to rip this out and push the inconvenience to
>>people with ancient hardware. (People with MFM disks may need
>>boot parameters now.)
>>
> 
> As a matter of fact, they would have needed to do so even since
> 2.3.28, when drive->present was no longer set.  Also from that
> 2 year old discussion is this patch to set capacity for non-IDE
> drives. Fact is that ST-506 would even to this day not work with 
> the ide driver without this patch. (Of course using hd.c on ST-506
> era machines makes a lot more sense anyways, so this is pretty
> much moot.)
> 
> Paul.

I have already applied the CMOS probe removal patch to my personal tree
and it turns out any obvious things. However I still don't see how it 
may simplify the ide.c code further...

to indeed not break

> 
> diff -u linux-r/drivers/ide-old/ide-disk.c linux-r/drivers/ide/ide-disk.c
> --- linux-r/drivers/ide-old/ide-disk.c	Fri May 26 16:37:43 2000
> +++ linux-r/drivers/ide/ide-disk.c	Sat May 27 14:33:27 2000
> @@ -519,7 +519,6 @@
>  
>  /*
>   * Compute drive->capacity, the full capacity of the drive
> - * Called with drive->id != NULL.
>   */
>  static void init_idedisk_capacity (ide_drive_t  *drive)
>  {
> @@ -529,7 +528,7 @@
>  	drive->select.b.lba = 0;
>  
>  	/* Determine capacity, and use LBA if the drive properly supports it */
> -	if ((id->capability & 2) && lba_capacity_is_ok(id)) {
> +	if (id != NULL && (id->capability & 2) && lba_capacity_is_ok(id)) {
>  		capacity = id->lba_capacity;
>  		drive->cyl = capacity / (drive->head * drive->sect);
>  		drive->select.b.lba = 1;
> @@ -759,8 +758,10 @@
>  	
>  	idedisk_add_settings(drive);
>  
> -	if (id == NULL)
> +	if (id == NULL) {	/* Old, non-IDE drive */
> +		init_idedisk_capacity(drive);
>  		return;
> +	}
>  
>  	/*
>  	 * CompactFlash cards and their brethern look just like hard drives
> 
> 
> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R


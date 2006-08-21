Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWHUAoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWHUAoc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWHUAoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:44:32 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:22638 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932488AbWHUAob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:44:31 -0400
Date: Sun, 20 Aug 2006 20:44:03 -0400
From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: Merging libata PATA support into the base kernel
In-reply-to: <44E6C916.2030907@PicturesInMotion.net>
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Jason Lunz <lunz@falooley.org>,
       Jens Axboe <axboe@suse.de>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Stefan Seyfried <seife@suse.de>
Message-id: <44E901D3.4000902@PicturesInMotion.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex>
 <200608102140.36733.rjw@sisk.pl> <44E3E1E6.9090908@PicturesInMotion.net>
 <20060817091842.GC17899@elf.ucw.cz>
 <1155808348.15195.55.camel@localhost.localdomain>
 <20060817094512.GD17899@elf.ucw.cz>
 <1155815491.15195.75.camel@localhost.localdomain>
 <44E53635.3080702@PicturesInMotion.net>
 <44E53A9B.6080701@PicturesInMotion.net>
 <1155916869.28764.20.camel@localhost.localdomain>
 <44E6137B.9090103@PicturesInMotion.net>
 <1155934254.31543.1.camel@localhost.localdomain>
 <44E6C916.2030907@PicturesInMotion.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060731)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Trager wrote:
> Alan Cox wrote:
>   
>> Ar Gwe, 2006-08-18 am 15:22 -0400, ysgrifennodd Lee Trager:
>>   
>>     
>>> Well where in the kernel is the code that disabled HPA on startup? Im
>>> new to kernel hacking so if you could point me in the right direction I
>>> could try to patch it myself.
>>>     
>>>       
>> drivers/ide/ide-disk.c
>>
>> Particularly:
>> 	idedisk_check_hpa()
>>
>> which if you call at the end of the resume sequence for disks ought to
>> do the right thing for you
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>   
>>     
> Well I tried to do exactly what you said. All that happens now is that
> it does not come out of resume. Below is a patch of the code I tried to
> do in case you could like to look at it. Basically I called
> idedisk_check_hpa at the end of generic_ide_resume() in drivers/ide/ide.c
>
> diff -Naur linux-2.6.18-rc4-old/drivers/ide/ide-disk.c
> linux-2.6.18-rc4/drivers/ide/ide-disk.c
> --- linux-2.6.18-rc4-old/drivers/ide/ide-disk.c    2006-08-19
> 03:49:03.000000000 -0400
> +++ linux-2.6.18-rc4/drivers/ide/ide-disk.c    2006-08-19
> 03:41:33.000000000 -0400
> @@ -464,16 +464,6 @@
>  }
>  
>  /*
> - * Bits 10 of command_set_1 and cfs_enable_1 must be equal,
> - * so on non-buggy drives we need test only one.
> - * However, we should also check whether these fields are valid.
> - */
> -static inline int idedisk_supports_hpa(const struct hd_driveid *id)
> -{
> -    return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
> -}
> -
> -/*
>   * The same here.
>   */
>  static inline int idedisk_supports_lba48(const struct hd_driveid *id)
> @@ -482,7 +472,7 @@
>             && id->lba_capacity_2;
>  }
>  
> -static void idedisk_check_hpa(ide_drive_t *drive)
> +void idedisk_check_hpa(ide_drive_t *drive)
>  {
>      unsigned long long capacity, set_max;
>      int lba48 = idedisk_supports_lba48(drive->id);
> @@ -514,6 +504,8 @@
>      }
>  }
>  
> +EXPORT_SYMBOL(idedisk_check_hpa);
> +
>  /*
>   * Compute drive->capacity, the full capacity of the drive
>   * Called with drive->id != NULL.
> diff -Naur linux-2.6.18-rc4-old/drivers/ide/ide.c
> linux-2.6.18-rc4/drivers/ide/ide.c
> --- linux-2.6.18-rc4-old/drivers/ide/ide.c    2006-08-19
> 03:49:03.000000000 -0400
> +++ linux-2.6.18-rc4/drivers/ide/ide.c    2006-08-19 03:41:33.000000000
> -0400
> @@ -1242,6 +1242,13 @@
>      rqpm.pm_step = ide_pm_state_start_resume;
>      rqpm.pm_state = PM_EVENT_ON;
>  
> +    /* check to see if this is a hard drive
> +     * if it is then checkhpa needs to be
> +     * disabled */
> +    if(drive->media == ide_disk)
> +        if(idedisk_supports_hpa(drive->id))
> +            idedisk_check_hpa(drive);
> +
>      return ide_do_drive_cmd(drive, &rq, ide_head_wait);
>  }
> diff -Naur linux-2.6.18-rc4-old/include/linux/ide.h
> linux-2.6.18-rc4/include/linux/ide.h
> --- linux-2.6.18-rc4-old/include/linux/ide.h    2006-08-19
> 03:49:03.000000000 -0400
> +++ linux-2.6.18-rc4/include/linux/ide.h    2006-08-19
> 03:42:53.000000000 -0400
> @@ -1377,4 +1377,16 @@
>      return dev ? pcibus_to_node(dev->bus) : -1;
>  }
>  
> +extern void idedisk_check_hpa(ide_drive_t *drive);
> +
> +/*
> + *  * Bits 10 of command_set_1 and cfs_enable_1 must be equal,
> + *   * so on non-buggy drives we need test only one.
> + *    * However, we should also check whether these fields are valid.
> + *     */
> +static inline int idedisk_supports_hpa(const struct hd_driveid *id)
> +{
> +        return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
> +}
> +
>  #endif /* _IDE_H */
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   
Ok I have it working now. The problem was that I had to call
ide_do_drive_cmd() first and then I had to call init_idedisk_capacity()
instead of idedisk_check_hpa(). Anyway im submitting the patch on the list.

Thanks,


Lee Trager

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWH2JKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWH2JKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWH2JKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:10:15 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:16806 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751351AbWH2JKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:10:12 -0400
Date: Tue, 29 Aug 2006 05:10:12 -0400
From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: HPA Resume patch
In-reply-to: <20060828210053.f0b58058.rdunlap@xenotime.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@ucw.cz>,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, seife@suse.de
Message-id: <44F40474.9090907@PicturesInMotion.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
References: <44F15ADB.5040609@PicturesInMotion.net>
 <20060827150608.GA4534@ucw.cz> <20060827170501.GD30609@kernel.dk>
 <44F3A30A.3090509@PicturesInMotion.net>
 <20060828210053.f0b58058.rdunlap@xenotime.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060731)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Mon, 28 Aug 2006 22:14:34 -0400 Lee Trager wrote:
>
>   
>> Jens Axboe wrote:
>>     
>>> On Sun, Aug 27 2006, Pavel Machek wrote:
>>>   
>>>       
>>>> Hi!
>>>>
>>>>     
>>>>         
>>>>> This patch fixes a problem with computers that have HPA on their hard
>>>>> drive and not being able to come out of resume from RAM or disk. I've
>>>>> tested this patch on 2.6.17.x and 2.6.18-rc4 and it works great on both
>>>>> of these. This patch also fixes the bug #6840. This is my first patch to
>>>>> the kernel and I was told to e-mail the above people to get my patch
>>>>> into the kernel.
>>>>>       
>>>>>           
>>>> Congratulations for a first patch.
>>>>
>>>>     
>>>>         
>>>>> If I made a mistake please be gentle and correct me ;)
>>>>>       
>>>>>           
>>>> We'll need signed-off-by: line next time.
>>>>
>>>> Stefan, can we get this some testing? Or anyone else with thinkpad
>>>> with host-protected area still enabled?
>>>>     
>>>>         
>>> It has design issues, at someone else already noticed. hpa restore needs
>>> to be a driver private step, included in the resume state machine. The
>>> current patch is a gross layering violation.
>>>
>>> But thanks to Lee for taking a stab at this, I hope he'll continue and
>>> get it polished :-)
>>>
>>>   
>>>       
>> Ok I redid the patch following exactly what Sergey and Randy said. This
>> problem happens on any computer that has HPA on their drive when they
>> come back from resume so I don't think you have to only test this with
>> Thinkpad users. Anyway my only question is how to I get my patched
>> signed off by someone?
>>     
>
> You do that :) after you read Documentation/SubmittingPatches and can "sign off"
> on the patch.
>
>
>   
>> Thanks for all your help!
>>
>> --- linux-2.6.18-rc4-old/include/linux/ide.h	2006-08-19 03:49:03.000000000 -0400
>> +++ linux-2.6.18-rc4/include/linux/ide.h	2006-08-28 05:45:06.000000000 -0400
>> @@ -987,6 +987,7 @@ typedef struct ide_driver_s {
>>  	int		(*probe)(ide_drive_t *);
>>  	void		(*remove)(ide_drive_t *);
>>  	void		(*shutdown)(ide_drive_t *);
>> +	void		(*resume)(ide_drive_t *);
>>  } ide_driver_t;
>>  
>>  #define to_ide_driver(drv) container_of(drv, ide_driver_t, gen_driver)
>> --- linux-2.6.18-rc4-old/drivers/ide/ide.c	2006-08-19 03:49:03.000000000 -0400
>> +++ linux-2.6.18-rc4/drivers/ide/ide.c	2006-08-28 21:38:50.000000000 -0400
>> @@ -1229,9 +1229,11 @@ static int generic_ide_suspend(struct de
>>  static int generic_ide_resume(struct device *dev)
>>  {
>>  	ide_drive_t *drive = dev->driver_data;
>> +	ide_driver_t *drv = to_ide_driver(dev->driver);
>>  	struct request rq;
>>  	struct request_pm_state rqpm;
>>  	ide_task_t args;
>> +	int err;
>>  
>>  	memset(&rq, 0, sizeof(rq));
>>  	memset(&rqpm, 0, sizeof(rqpm));
>> @@ -1242,7 +1244,12 @@ static int generic_ide_resume(struct dev
>>  	rqpm.pm_step = ide_pm_state_start_resume;
>>  	rqpm.pm_state = PM_EVENT_ON;
>>  
>> -	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
>> +	err = ide_do_drive_cmd(drive, &rq, ide_head_wait);
>> +
>> +	if (err == 0 && drv->resume)
>> +		drv->resume(drive);
>> +
>> +	return err;
>>  }
>>  
>>  int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,
>> --- linux-2.6.18-rc4-old/drivers/ide/ide-disk.c	2006-08-19 03:49:03.000000000 -0400
>> +++ linux-2.6.18-rc4/drivers/ide/ide-disk.c	2006-08-28 21:54:17.000000000 -0400
>> @@ -1024,6 +1024,17 @@ static void ide_disk_release(struct kref
>>  
>>  static int ide_disk_probe(ide_drive_t *drive);
>>  
>> +/*
>> + * On HPA drives the capacity needs to be
>> + * reinitilized on resume otherwise the disk
>> + * can not be used and a hard reset is required
>> + */
>> +static void ide_disk_resume(ide_drive_t *drive)
>> +{
>> +	if (idedisk_supports_hpa(drive->id))
>> +		init_idedisk_capacity(drive);
>> +}
>> +
>>  static void ide_device_shutdown(ide_drive_t *drive)
>>  {
>>  #ifdef	CONFIG_ALPHA
>> @@ -1067,6 +1078,7 @@ static ide_driver_t idedisk_driver = {
>>  	.error			= __ide_error,
>>  	.abort			= __ide_abort,
>>  	.proc			= idedisk_proc,
>> +	.resume			= ide_disk_resume,
>>  };
>>  
>>  static int idedisk_open(struct inode *inode, struct file *filp)
>>     
>
>
> ---
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   
Ok I read the docs on submitting patches and coding style, I'll resubmit.

Thanks!

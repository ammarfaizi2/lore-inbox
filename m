Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVKRPZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVKRPZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVKRPZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:25:59 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:44853 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932072AbVKRPZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:25:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UY1MA+iMNEVTwS8gakqTFkvWztH9nCxrdI4osL7wJM0EENDSEKwZMCimc0f1HrWMGInmWZAwTPaB8P6t8iyzMXvNvtcli5SHjMEnpQoz4JZ8AVRSCV4u3OqpLPMTx19vbkRVjGSyZu2Ms885hGhHEh/gkPSMB0oXxJBq2cnEcWU=
Message-ID: <437DF271.6050702@gmail.com>
Date: Sat, 19 Nov 2005 00:25:37 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 09/10] blk: add FUA support
 to IDE
References: <20051117153509.B89B4777@htj.dyndns.org>	 <20051117153509.5A77ED53@htj.dyndns.org> <58cb370e0511171239i16e0aaffr237ef7af68ece946@mail.gmail.com>
In-Reply-To: <58cb370e0511171239i16e0aaffr237ef7af68ece946@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bartlomiej.

Bartlomiej Zolnierkiewicz wrote:
> On 11/17/05, Tejun Heo <htejun@gmail.com> wrote:
> 
> What does happen for fua && drive->vdma case?
> 

Thanks for pointing out, wasn't thinking about that.  Hmmm... When using 
vdma, single-sector PIO commands are issued instead but there's no 
single-sector FUA PIO command.  Would issuing 
ATA_CMD_WRITE_MULTI_FUA_EXT instead of ATA_CMD_WRITE_FUA_EXT work?  Or 
should I just disable FUA on vdma case?

> 
>>                        } else {
>>                                command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
>>                                if (drive->vdma)
>>@@ -284,8 +298,20 @@ static ide_startstop_t __ide_do_rw_disk(
>>        } else {
>>                if (drive->mult_count) {
>>                        hwif->data_phase = TASKFILE_MULTI_OUT;
>>-                       command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
>>+                       if (!fua)
>>+                               command = lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
>>+                       else
>>+                               command = ATA_CMD_WRITE_MULTI_FUA_EXT;
>>                } else {
>>+                       if (unlikely(fua)) {
>>+                               /*
>>+                                * This happens if multisector PIO is
>>+                                * turned off during operation.
>>+                                */
>>+                               printk(KERN_ERR "%s: FUA write but in single "
>>+                                      "sector PIO mode\n", drive->name);
>>+                               goto fail;
>>+                       }
> 
> 
> Wouldn't it be better to do the following check at the beginning
> of __ide_do_rw_disk() (after checking for dma vs lba48):
> 
>         if (fua) {
>                 if (!lba48 || ((!dma || drive->vdma) && !drive->mult_count))
>                         goto fail_fua;
>         }
> 
> ...
> 
> and fail the request if needed *before* actually touching any
> hardware registers?
> 
> fail_fua:
>         printk(KERN_ERR "%s: FUA write unsupported (lba48=%u dma=%u"
>                                        " vdma=%u mult_count=%u)\n", drive->name,
>                                        lba48, dma, drive->vdma,
> drive->mult_count);
>         ide_end_request(drive, 0, 0);
>         return ide_stopped;
> 

Hmmm... The thing is that those failure cases will happen extremely 
rarely if at all.  Remember this post?

http://marc.theaimsgroup.com/?l=linux-kernel&m=111798102108338&w=3

It's mostly guaranteed that those failure cases don't occur, so I 
thought avoiding IO on failure case wasn't that helpful.

> 
>>                        hwif->data_phase = TASKFILE_OUT;
>>                        command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
>>                }
>>@@ -295,6 +321,10 @@ static ide_startstop_t __ide_do_rw_disk(
>>
>>                return pre_task_out_intr(drive, rq);
>>        }
>>+
>>+ fail:
>>+       ide_end_request(drive, 0, 0);
>>+       return ide_stopped;
>> }
>>
>> /*
>>@@ -846,7 +876,7 @@ static void idedisk_setup (ide_drive_t *
>> {
>>        struct hd_driveid *id = drive->id;
>>        unsigned long long capacity;
>>-       int barrier;
>>+       int barrier, fua;
>>
>>        idedisk_add_settings(drive);
>>
>>@@ -967,10 +997,19 @@ static void idedisk_setup (ide_drive_t *
>>                        barrier = 0;
>>        }
>>
>>-       printk(KERN_INFO "%s: cache flushes %ssupported\n",
>>-               drive->name, barrier ? "" : "not ");
>>+       fua = barrier && idedisk_supports_lba48(id) && ide_id_has_fua(id);
>>+       /* When using PIO, FUA needs multisector. */
>>+       if ((!drive->using_dma || drive->hwif->no_lba48_dma) &&
>>+           drive->mult_count == 0)
>>+               fua = 0;
> 
> 
> Shouldn't this check also for drive->vdma?
> 

Yes, it does.  Thanks for pointing out.  One question though.  FUA 
support should be changed if using_dma/mult_count settings are changed. 
  As using_dma configuration is handled by IDE midlayer, we might need 
to add a callback there.  What do you think?

-- 
tejun

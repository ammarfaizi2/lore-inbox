Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313661AbSDPMqe>; Tue, 16 Apr 2002 08:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313664AbSDPMqd>; Tue, 16 Apr 2002 08:46:33 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26122 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313661AbSDPMqc>; Tue, 16 Apr 2002 08:46:32 -0400
Message-ID: <3CBC0E97.4000606@evision-ventures.com>
Date: Tue, 16 Apr 2002 13:44:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <27670700DF5@vcnet.vc.cvut.cz> <20020416102501.GG17043@suse.de> <3CBC04A5.1040201@evision-ventures.com> <20020416122801.GB1097@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Apr 16 2002, Martin Dalecki wrote:
> 
>>Jens Axboe wrote:
>>
>>
>>
>>>yes this looks like a silly problem. the fix should be to have
>>>ata_ar_get() set ATA_AR_RETURN in ar_flags:
>>>
>>>       if (!list_empty(&drive->free_req)) {
>>>               ar = list_ata_entry(drive->free_req.next);
>>>               list_del(&ar->ar_queue);
>>>               ata_ar_init(drive, ar);
>>>               ar->ar_flags |= ATA_AR_RETURN;
>>>       }
>>>
>>>and then only have ata_ar_put() readd it to the list when it is set:
>>>
>>>static inline void ata_ar_put(ide_drive_t *drive, struct ata_request
>>>*ar)
>>>{
>>>       if (ar->ar_flags & ATA_AR_RETURN)
>>>               list_add(&ar->ar_queue, &drive->free_req);
>>>	...
>>>
>>>Then you can also remove the ata_ar_put() conditional in
>>>ide_end_drive_cmd(), just call ata_ar_put() unconditionally.
>>
>>Well something similar is already in IDE 37... I have just
>>invented a flag ATA_AR_STATIC which get's set in ide_raw_taskfile
>>ata_ar_put ich then checking for if (!(ar->ar_flags & ATA_AR_STATIC))...
>>
>>It has the desired effect in practice.
> 
> 
> sure, just used ATA_AR_RETURN since it was there already. I'm not
> particularly fond of that name though, and ATA_AR_STATIC isn't too good
> either imo. how about ATA_AR_POOL? with the same semantics as
> ATA_AR_RETURN, ie return to pool if flag is set.

ATA_AR_POOL sounds good. It indicates where it's comming from and
where it is going to remain. BTW.> Have you noticed the tactile steps
forward I did in conversion of ide-cd.c to the new command submission in IDE 37?
Any suggestions? It isn't really that abvious how to get finally rid
of struct packt_command... but I think that I'm not far away now.
The only thing that has to be done is to move the sense data and failed
command used in ide-cd away from the packet command structure.
I will not pass it as pointer around but just copy it directly to struct
ata_devices driver_data field... I think.


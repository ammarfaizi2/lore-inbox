Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312690AbSDONlo>; Mon, 15 Apr 2002 09:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312691AbSDONln>; Mon, 15 Apr 2002 09:41:43 -0400
Received: from [195.63.194.11] ([195.63.194.11]:11278 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312690AbSDONlm>; Mon, 15 Apr 2002 09:41:42 -0400
Message-ID: <3CBACA07.5050609@evision-ventures.com>
Date: Mon, 15 Apr 2002 14:39:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <20020415125606.GR12608@suse.de> <3CBAC690.8090908@evision-ventures.com> <20020415133326.GT12608@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>>>-		memset(ar, 0, sizeof(*ar));
>>>+		memset(ar, 0, sizeof(ar));
>>
>>Please look closer - I'm quite convinced that sizeof(ar) == sizeof(void *)
>>which gives not the desired effect. I have fixed this during the last
>>merge...

No problem here - you see I'm quite good at catching cr*ap like this ;-).

> Irk, where did that come from?! Had you done the incremental patches
> this would not have slipped through! My mistake.


>>>
>>>		__set_bit(i, &tag_mask);
>>>		len += sprintf(out+len, "%d, ", i);
>>>-		if (ar->ar_time > max_jif)
>>>-			max_jif = ar->ar_time;
>>>+		if (cur_jif - ar->ar_time > max_jif)
>>>+			max_jif = cur_jif - ar->ar_time;
>>
>>I disgust timer calculartions...- will have to look at a way
>>how to nap in a similar way eth drivers do.
> 
> 
> ? This is just statistics. There absolutely nothing wrong with the
> above.

Please don't take me wrong - I don't think that there is something
wrong with it... It was more out of the stommach about how it looks...

>>>diff -urN -X /home/axboe/cdrom/exclude 
>>>/opt/kernel/linux-2.5.8/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
>>>--- /opt/kernel/linux-2.5.8/drivers/ide/ide-dma.c	2002-04-15 
>>>07:59:53.000000000 +0200
>>>+++ linux/drivers/ide/ide-dma.c	2002-04-15 09:17:55.000000000 +0200
>>>
>>>+#endif /* CONFIG_BLK_DEV_IDE_TCQ */
>>>
>>>		case ide_dma_read:
>>>			reading = 1 << 3;
>>>		case ide_dma_write:
>>>-			ar = HWGROUP(drive)->rq->special;
>>>+			ar = IDE_CUR_AR(drive);
>>
>>Ahhh!!! I'm gald to see this.
> 
> 
> :-)
> 
> 
>>>static inline void drive_ctl_nien(ide_drive_t *drive, int clear)
>>>{
>>>#ifdef IDE_TCQ_NIEN
>>>-	int mask = clear ? 0 : 2;
>>>+	int mask = clear ? 0 : 1 << 1;
>>
>>????

> Just more readable that we are setting bit 2.

0x02 is for me always a hint that one should read it binary...
You memmorazied the bit patterns corresopnding to hex digits propably
as well already a long time ago. Didn't you? :-).

> 
> 
>>>-#define IDE_CUR_AR(drive)	\
>>>-	((drive)->using_tcq ? IDE_CUR_TAG((drive)) : 
>>>HWGROUP((drive))->rq->special)
>>>+#define IDE_CUR_AR(drive)	(HWGROUP((drive))->rq->special)
>>
>>Ahh that's nice :-). Let's look further down how this coexists with 
>>ide-cd.c...
>>
>>
>>
>>>-extern inline int ide_get_tag(ide_drive_t *drive)
>>>+static inline int ide_get_tag(ide_drive_t *drive)
>>
>>OK. I have missed this one apparently.
>>
>>ar_timer will make it at least esier to finish the ide-cd.c transition
>>to this data transport base.
>>
>>Should I just quickly remerge this, so we can work further from
>>the same code base to ease the merging pain?
> 
> 
> Sure, go ahead. And do the changes they way we discussed earlier today,
> ok? :)

OK... agreed First - "raw" merge (and fixes already discuesed here) and
then go on...


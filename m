Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316373AbSEOKps>; Wed, 15 May 2002 06:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316374AbSEOKpr>; Wed, 15 May 2002 06:45:47 -0400
Received: from [195.63.194.11] ([195.63.194.11]:45319 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316373AbSEOKpp>; Wed, 15 May 2002 06:45:45 -0400
Message-ID: <3CE22D8B.3000602@evision-ventures.com>
Date: Wed, 15 May 2002 11:42:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Conway <nconway.list@ukaea.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <5.1.0.14.2.20020514202811.01fcc1d0@pop.cus.cam.ac.uk> <E177dYp-00083c-00@the-village.bc.nu> <5.1.0.14.2.20020514202811.01fcc1d0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020515085358.01fd8580@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Anton Altaparmakov napisa?:
> At 07:16 15/05/02, Jens Axboe wrote:
> 
>> On Tue, May 14 2002, Anton Altaparmakov wrote:
>> > instead of having per channel queue, you could have per device 
>> queue, but
>> > use the same lock for both, i.e. don't make the lock part of "struct 
>> queue"
>> > (or whatever it is called) but instead make the address of the lock be
>> > attached to "struct queue".
>>
>> See request_queue_t, the lock can already be shared.
> 
> 
> /me looks.
> 
> So it can. And I thought I had come up with a clever idea... (-;
> 
>> And in fact the ide layer used a global ide_lock shared between all 
>> queues until just
>> recently.
>>
>> > Further if a controller is truly broken and you need to synchronize
>> > multiple channels you could share the lock among those.
>>
>> Again, this is not enough! The lock will only, at best, serialize direct
>> queue actions. So I can share a lock between queue A and B and only one
>> of them will start a request at any given time, but as soon as request X
>> is started for queue A, then we can happily start request Y for queue B.
>>
>> This is what the hwgroup busy flag protects right now, only one queue is
>> allowed to mark the hwgroup busy naturally. So only when request X for
>> queue A completes will the hwgroup busy flag be cleared, and queue B can
>> start request Y.
> 
> 
> Yes, I understand that, could you not extend the shared lock idea to a 
> shared flags idea? The two could even be in the same memory allocated 
> block as both the lock and the flags would always be shared by the same 
> users. That would just now contain only QUEUE_SHARED_FLAG_BUSY but could 
> be extended later if the need arises.
> 
>  From what I gather from the posts on this topic, this would be entirely 
> sufficient to fully lock both request queue handling and request 
> submission to the hardware while maintaining per-device queues.

The clean solution whould be to make it possible to be able to use
multiple hardsect and friend on a single queue. Becouse then
one could just use the same queue for all operations.

But... wait a minute. The only really problematic case where the queue
properties differ is the case where we have a disk and ATAPI device
mixed on the same channel. Hmm what about using two distinguished queues
on a channel - one for ATAPI and the second for ATA requests then?
In esp. since it's quite easy to identify ATAPI request as
beeing in flight. Hmm... the longer I think about it the more
apeal this solution has to me.

> I may be way off base but I would think that per-device queues are 
> desirable to improve the request merging abilities of the elevator. 
> (Again, code I haven't looked at so it may well be intelligent enough to 
> resort/merge requests with different destinations on the same queue but 
> I am sure you will tell me if this is the case. (-;)
> 
> Best regards,
> 
>         Anton
> 
> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R


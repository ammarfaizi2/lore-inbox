Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314327AbSEMREA>; Mon, 13 May 2002 13:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314328AbSEMRD7>; Mon, 13 May 2002 13:03:59 -0400
Received: from [195.63.194.11] ([195.63.194.11]:24083 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314327AbSEMRD4>; Mon, 13 May 2002 13:03:56 -0400
Message-ID: <3CDFE333.3030801@evision-ventures.com>
Date: Mon, 13 May 2002 18:00:51 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
In-Reply-To: <3CDFDF8D.1050204@evision-ventures.com> <Pine.LNX.4.44.0205130950350.19524-100000@home.transmeta.com> <20020513165544.GA30516@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jens Axboe napisa?:
> On Mon, May 13 2002, Linus Torvalds wrote:
> 
>>>Well on the channel level they are safe modulo cmd640 and rz1000.
>>>We can handle them by serializing them on the global lock
>>>in do_ide_request. Like:
>>>
>>>if (ch->drive[0].serialized|| ch->drive[1].serialized)
>>>    then
>>>    spin_lock(serialize_lock);
>>
>>NO.
>>
>>The whole point of having a per-queue lock pointer is that this should be
>>initialized at queue creation time. Don't add more crud to the IDE
>>locking, we want to get _rid_ of the locking that IDE has thought
>>(traditionally incorrectly) that it could do better than the higher
>>levels.
>>
>>So when you create the queue, you should decide at THAT point whether you
>>just want to pass in the same lock or not.
>>
>>For a cmd640, you make sure that both queues get created with the same
>>lock. And for non-broken chipsets, you use per-queue locks.
>>
>>And then you make sure that nobody EVER uses any other lock than the queue
>>lock.
> 
> 
> Completely agreed. And when we finally use the queue as the
> serialization point for "everything", then it all falls into place
> nicely.


Well actually I came to the same conclusion regarding the dealing
with broken chipsets. However please note that:

1. queues are per device, since we have to deal with
the fact that the code flow can be different whatever:

1.1. The drive is doing DMA transfers.

1.2. The drive is doing TCQ. (could and should be unifyed with 1.1.)

1.3. The drive is doing ATAPI.

2. Operations are per channel and not per queue.

Therefore the queue locking and basic serialization
has to be on the channel level, with the "lock recycling trick"
for the two interface chips, which can't distingish properly
between primary and secondary channel.

OK?



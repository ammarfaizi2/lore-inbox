Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSENPfZ>; Tue, 14 May 2002 11:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSENPfY>; Tue, 14 May 2002 11:35:24 -0400
Received: from [195.63.194.11] ([195.63.194.11]:61966 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315783AbSENPfW>; Tue, 14 May 2002 11:35:22 -0400
Message-ID: <3CE11F90.5070701@evision-ventures.com>
Date: Tue, 14 May 2002 16:30:40 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Neil Conway <nconway.list@ukaea.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>I think you're wrong Alan.  Take a good IDE chipset as an example: both
>>channels can be active at the same time, but you still can't talk to one
>>drive while the other drive on the same channel is DMAing.
> 
> 
> Sure.
> 
> 
>>I'm not a block layer expert, but it appears to me that the block layer
>>only synchronises requests by use of the spinlock.  If I'm right, then
>>the block layer has no way of knowing that hda is DMAing when a request
>>is initiated for hdb.  This was the whole reason (as I see it) that
>>hwgroup->busy existed: to prevent attempts to use the same IDE cable for
>>two things at the same time.
> 
> 
> The newer block code has queues. Its up to the block layer to deal with
> the queue locking.
> 
> 
>>It doesn't matter how you perform the queue abstraction in this case:
>>the fact that the device+channel+cable is busy in an asynchronous manner
>>makes it impossible for the block layer to deal with this.  [[Or am I
>>way off base?!]]
> 
> 
> I think you are way off base. If you have a single queue for both hda and
> hdb then requests will get dumped into that in a way that processing that
> queue implicitly does the ordering you require.
> 
>>From an abstract hardware point of view each ide controller is a queue not
> each device. Not following that is I think the cause of much of the existing
> pain and suffering.


Yes thinking about it longer and longer I tend to the same conclusion,
that we just shouldn't have per device queue but per channel queues instead.
The only problem here is the fact that some device properties
are attached to the queue right now. Like for example sector size and friends.

I didn't have a too deep look in to the generic blk layer. But I would
rather expect that since the lower layers are allowed to pass
an spin lock up to the queue intialization, sharing a spin lock
between two request queues should just serialize them with respect to
each other. And this is precisely what 63 does.

BTW> FreeBSD does simple use per channel queues.



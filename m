Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316368AbSEOKgD>; Wed, 15 May 2002 06:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316369AbSEOKgC>; Wed, 15 May 2002 06:36:02 -0400
Received: from [195.63.194.11] ([195.63.194.11]:38151 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316368AbSEOKgB>; Wed, 15 May 2002 06:36:01 -0400
Message-ID: <3CE22B2B.5080506@evision-ventures.com>
Date: Wed, 15 May 2002 11:32:27 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Conway <nconway.list@ukaea.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <5.1.0.14.2.20020514202811.01fcc1d0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Anton Altaparmakov napisa?:
> At 15:30 14/05/02, Martin Dalecki wrote:
> 
>> Uz.ytkownik Alan Cox napisa?:
>>
>>> I think you are way off base. If you have a single queue for both hda 
>>> and
>>> hdb then requests will get dumped into that in a way that processing 
>>> that
>>> queue implicitly does the ordering you require.
>>> From an abstract hardware point of view each ide controller is a 
>>> queue not
>>> each device. Not following that is I think the cause of much of the 
>>> existing
>>> pain and suffering.
>>
>>
>> Yes thinking about it longer and longer I tend to the same conclusion,
>> that we just shouldn't have per device queue but per channel queues 
>> instead.
>> The only problem here is the fact that some device properties
>> are attached to the queue right now. Like for example sector size and 
>> friends.
>>
>> I didn't have a too deep look in to the generic blk layer. But I would
>> rather expect that since the lower layers are allowed to pass
>> an spin lock up to the queue intialization, sharing a spin lock
>> between two request queues should just serialize them with respect to
>> each other. And this is precisely what 63 does.
> 
> 
> Hi Martin,
> 
> instead of having per channel queue, you could have per device queue, 
> but use the same lock for both, i.e. don't make the lock part of "struct 
> queue" (or whatever it is called) but instead make the address of the 
> lock be attached to "struct queue".

In 63 we have:

	blk_init_queue(q, do_ide_request, drive->channel->lock);

struct ata_channel {
	struct device	dev;		/* device handle */
	int		unit;		/* channel number */

	/* This lock is used to serialize requests on the same device queue or
	 * between differen queues sharing the same irq line.
	 */
	spinlock_t *lock;

+ The whole glory of lock sharing for IRQ sharing and serialization.

Pretty much what you describe.

> That allows you on "good" controllers to use individual locks for 
> individual drives and also allows you to share the same lock (multiple 
> "struct queue" point to same lock) among _any_ number of devices on same 
> channel.
> 
> Further if a controller is truly broken and you need to synchronize 
> multiple channels you could share the lock among those.
> 
> I know that means allocating a lock, etc, but heck you can make a slab 
> cache for spinlocks or semaphores or whatever locking primite you use if 
> you consider that important.

Not worth the trouble for the 2 or 4 allocations at initialization.

> I don't know much about the IDE or block layers but it strikes me as the 
> simplest approach to control the level of "lock sharing".

The only problem is that having a shared lock between two queues apparently
doesn't imply that the queues are behaving atomic on the request level
among each others. The lock is just only making sure that access to the
lists and stragety routines is atomic between them.

However 63 doesn't really change the previous behaviour of the driver,
since we are simply using the lock pointer instead of the
custom hwgroup structure as our "serialization token" between channels
and the busy flag is preserved, since it's only used to protect reentrancy
bfore request completion (the long while(test_bit loop). It doesn't have
to be shared between channels, since in every case we hve to
look up the channel anyway.

Apparenty the "sublimation" of the hwgroup and overall cleanup of
data structures, just made many people awake and be aware of problems which
where there already for a very very long time...


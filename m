Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSEURih>; Tue, 21 May 2002 13:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSEURig>; Tue, 21 May 2002 13:38:36 -0400
Received: from [195.63.194.11] ([195.63.194.11]:64008 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315266AbSEURic> convert rfc822-to-8bit; Tue, 21 May 2002 13:38:32 -0400
Message-ID: <3CEA7740.7060204@evision-ventures.com>
Date: Tue, 21 May 2002 18:35:12 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 65
In-Reply-To: <Pine.LNX.4.44.0205210954210.2471-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Linus Torvalds napisa³:
> 
> On Tue, 21 May 2002, Martin Dalecki wrote:
> 
> 
>>- Make the synchronization token active resident on the same level as the
>>   spin lock. They interact with each other until the generic queue handling
>>   gets sanitized to not attach hardware properties like the hard sector size
>>   to the queue entities. This is a design mistake in ll_rw_blk biting everybody
>>   out there.
> 
> This does not parse. It is _not_ a design mistake in ll_rw_blk - if it
> bites you, you're doing something wrong.
> 
> The queue should be a per-device thing. If you have multiple devices with
> different hard-sector-sizes (or other queue attributes) on the same queue,
> that's _your_ problem, not the problem of ll_rw_block.

I didn't change the behaviour with respect to this.

But please consider the following points:

1. Layered devices. md. lvm raid  and so on, over mutliple physical
disks with possible different properties. Due to they nature
they have to handle the case of multiple block sizes.
The only reason this isn't biting us here right now is the
simple fact that most disks just stick with the dreaded 512 byte sector 
addressing, but there are people out there esp. from Maxtor
complaining about this... which would love to expand the smallest
transfer unit. It's just natural that this will be a subject
to change. Please note that most file systems out there are
already acting on expanded sector sizes indeed.

2. Removable media like CD-ROM contain already somehow inherently
the property of needing to deal with different sector sizes.
There are for example 1024 and 2048 byte modes for CD-ROMs.

3. I would love it to handle multiple sector transfers just as
big hard-sector sizes :-). Not quite perfectsolution ins some
corner cases but it would simplify many things inside the driver.
However this is just an idea I'm thinking about it and I didn't
came to any final conclusion about this.

> Sure, ll_rw_block _allows_ you to use the same queue for multiple devices,
> but if you do that you only have yourself to blame, and you get:

Linus - recycling the same request queue would simplify the
serialization issues by a significant amount. We have already
a mechanism for passing the spin lock to use to the upper
layer (blk_init_queue()). It would be just natural if it was
acting as kind of a true semaphore for overall request serialization. But
currently it's just used to serialize the access to the corresponding
queue lists, which doesn't buy us *anything*,
since request finish ACK happens asynchronously. And therefore
it doesn't make much sense indeed. It would really make only sense
if it would be kind of a semaphore-token shared between the queues in
question - which it isn't right now.

>  - shared values (like the hardsector-size above)
>  - worse elevator performance (longer queues to traverse)
>  - worse elevator schedules (mixing devices will caused mixed queue
>    contents, which makes it basically impossible to do a good ordering)

This wouldn't happen, since the intention would be to use
them only in case of the devices which need to be serialized
with each other.

> I thought the IDE layer already did the "one queue per device" thing, is
> there somewhere where this isn't true?

Yes it does it this way and this isn't subject to change
any time soon on sane hardware. After looking at the ll_rw_blk
code close enough I have already dropped the idea of different
queues for ATA and ATAPI reuqests. The point which I'm spinning
around are just the few "insane" cases where total
request serialization between different devices would help
to assert physical register access requirements.
A case where the above performance issues are not
prohibitive in my opinnion.

> In short, I think whatever synchronization token problem there is is
> completely an internal IDE problem, and no blame should be laid at anybody
> else.

Well if you are looking at it. Please have a look at the following
struct request memebers as well:

[root@kozaczek linux]# find ./ -name "*.[ch]" -exec grep hard_nr_sectors 
/dev/null {} \;

./include/linux/blkdev.h:       unsigned long hard_nr_sectors;
./drivers/ide/ide-cd.c: rq->hard_nr_sectors = rq->nr_sectors;
./drivers/ide/ide-taskfile.c:           __ide_end_request(drive, rq, 1, 
rq->hard_nr_sectors);
./drivers/block/ll_rw_blk.c:    unsigned long blocks = rq->hard_nr_sectors / 
(hard_sect >> 9);
./drivers/block/ll_rw_blk.c:            req->nr_sectors = req->hard_nr_sectors 
+= next->hard_nr_sectors;
./drivers/block/ll_rw_blk.c:                    req->nr_sectors = 
req->hard_nr_sectors += nr_sectors;
./drivers/block/ll_rw_blk.c:                    req->nr_sectors = 
req->hard_nr_sectors += nr_sectors;
./drivers/block/ll_rw_blk.c:    req->hard_nr_sectors = req->nr_sectors = nr_sectors;
./drivers/block/ll_rw_blk.c:            rq->hard_nr_sectors -= nsect;
./drivers/block/ll_rw_blk.c:            rq->nr_sectors = rq->hard_nr_sectors;

You will notice that the "other" hard_blah members are used
inside the IDE layer only as well for the running request and much
in pair with the normal members of struct request...
I'm planing right now how to push them down to the only
palce where they are used - namely the IDE layer next.
But I see that this has to be done *very carefully*.

The other things which ll_rw_blk.c doesn't get right is the
fact that the current merge functions don't respect hard sector
sizes, despite of attaching them to every single request out there.
Since we have the requests in device context you can hardly
argue that this is at least smelling funny since this information
is already accessible through the device context and shouldn't
be duplicated...

*Those* are the (minor) things which did lead me to the conclusion
that something isn't (quite) right there. OK?


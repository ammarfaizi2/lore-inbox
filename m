Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSEARZe>; Wed, 1 May 2002 13:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313715AbSEARZd>; Wed, 1 May 2002 13:25:33 -0400
Received: from [195.63.194.11] ([195.63.194.11]:30227 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313698AbSEARZd>; Wed, 1 May 2002 13:25:33 -0400
Message-ID: <3CD0165D.6090901@evision-ventures.com>
Date: Wed, 01 May 2002 18:22:53 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reworked IDE/general tagged command queueing
In-Reply-To: <20020501123705.GI837@suse.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Jens Axboe napisa³:
> Hi,
> 
> I've rewritten parts of the IDE TCQ stuff to be, well, a lot better in
> my oppinion. I had to accept that the ata_request and rq->special usage
> sucked, it was just one big mess.
> 
> So following a suggestion from Martin and Linus, I implemented some
> basic tagged command queueing back end in the block layer. This is what
> the new IDE TCQ core is build on, and what potentially others can use as
> well. I'll start by describing the new API:


Looking at the IDE part we can now see that pushing the
generic functions one level up the impact on the code flow
on the IDE side is now:

1. Low (most of stuff is due to the ugly /proc special-ide-interface.

2. Nicely isolated.

Great work Jens! (just my humble opinnion).
However I see a note about the need
to unify the DMA parts, so I will se what can be done on this
side becouse I have always planned to get rid of the
silly switch(ide_dma_function_t) on the dmaproc-path.

May I ask you as well to just call ide-tcq.c simple tcq.c?
The ide- is entierly redundant and I see no need to stick
to the previous "convention" here. It is just a leftover from
the days where the IDE stuff didn't sit in his own directory.
In general  I rather prefer the prefix ata_ instead of ide_ becouse
we are on the command level and on the host here -
ide resides on the disk and the whole world
outside linux calls it ata_. Finally ata_ is far better
grep-able overall becouse the ide letter combination is very
common :-) But that's a minor nit of course.

My convention is to prefix functions with the module specific prefix
only if they are exported, which means:

1. They are directly external.

2. They are hiddenly exported by setting some methods in structs to them.

Otherwise I stick to the most convenient semantically related
name without the fear that it could sound too generic...
so queue_data() is meant to be local for example and it doesn't
clash with the generic bio_queue_data() or whatever.

For me this convention turned out to help narrowing the focus
during reading code...


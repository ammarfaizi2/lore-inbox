Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314290AbSEMQ7E>; Mon, 13 May 2002 12:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314282AbSEMQ7C>; Mon, 13 May 2002 12:59:02 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19731 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314327AbSEMQ6e>; Mon, 13 May 2002 12:58:34 -0400
Message-ID: <3CDFE1EE.3050800@evision-ventures.com>
Date: Mon, 13 May 2002 17:55:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: benh@kernel.crashing.org
CC: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
In-Reply-To: <20020513153802.GB17509@suse.de> <20020513175218.8550@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik benh@kernel.crashing.org napisa?:
>>>So I think we should have per channel locks on this level
>>>right? This is anyway our unit for serialization.
>>>(I'm just surprised that blk_init_queue() doesn't
>>>provide queue specific locking and relies on exported
>>>locks from the drivers...)
>>
>>Sure go ahead and fine grain it, I had no time to go that much into
>>detail when ripping out io_request_lock. A drive->lock passed to
>>blk_init_queue would do nicely.
>>
>>But beware that ide locking is a lot nastier than you think. I saw other
>>irq changes earlier, I just want to make sure that you are _absolutely_
>>certain that these changes are safe??
> 
> 
> You'll probably need a per-host lock (but that one can be safely
> hidden in the host controller driver I beleive) since some hosts
> share some registers for their 2 channels (timings can be bitfields
> in a single register controlling 2 channels, I'm not too sure about
> legacy DMA).

Just to clarify it... From the host view it's not the chipset
it's a channel we have to deal with. And there are typically two
channels on a host. For the serialized parts, we have to
possiblities:

1. Preserve the current behaviour of using additionally a global
lock.

2. "Cheat" and reuse the lock from the primary channel during
the initialization of the secondary channel.

Hmmm.... Thinking a bit about it I'm now conviced that 2. is more
elegant then 1. And finally this will
just allow us to make the hwgroup_t go entierly away.


The only thing that worries me are the checks for hwgroupt_t's
only remaining member -> handler use to determine whatever some
IRQ is pending or not.



Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314051AbSEMOFq>; Mon, 13 May 2002 10:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314052AbSEMOFp>; Mon, 13 May 2002 10:05:45 -0400
Received: from [195.63.194.11] ([195.63.194.11]:6417 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314051AbSEMOFo>;
	Mon, 13 May 2002 10:05:44 -0400
Message-ID: <3CDFB962.5070600@evision-ventures.com>
Date: Mon, 13 May 2002 15:02:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <3CDFAEC0.6050403@evision-ventures.com> <20020513134832.GV1106@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jens Axboe napisa?:
> On Mon, May 13 2002, Martin Dalecki wrote:
> 
>>Mon May 13 12:38:11 CEST 2002 ide-clean-62
>>
>>- Add missing locking around ide_do_request in do_ide_request().
> 
> 
> This is broken, do_ide_request() is already called with the request lock
> held. tq_disk run -> generic_unplug_device (grab lock) ->
> __generic_unplug_device -> do_ide_request(). You just introduced a
> deadlock.
> 
> This code would have caused hangs or massive corruption immediately if
> ide_lock wasn't ready held there. Not to mention instant spin_unlock
> BUG() triggers in queue_command()
> 

Oops. Indeed I see now that the ide_lock is exported to
the upper layers above it in ide-probe.c

blk_init_queue(q, do_ide_request, &ide_lock);

But this is problematic in itself, since it means that
we are basically serialiazing between *all* requests
on all channels.

So I think we should have per channel locks on this level
right? This is anyway our unit for serialization.
(I'm just surprised that blk_init_queue() doesn't
provide queue specific locking and relies on exported
locks from the drivers...)


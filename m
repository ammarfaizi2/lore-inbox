Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbTFVOBu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 10:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265728AbTFVOBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 10:01:50 -0400
Received: from dm1-25.slc.aros.net ([66.219.220.25]:17589 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S265670AbTFVOBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 10:01:46 -0400
Message-ID: <3EF5BA13.6020301@aros.net>
Date: Sun, 22 Jun 2003 08:15:47 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, Steven Whitehouse <steve@chygwyn.com>,
       akpm@digeo.com
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
References: <3EF3F08B.5060305@aros.net> <20030621073224.GJ6754@parcelfarce.linux.theplanet.co.uk> <3EF48A30.3010203@aros.net> <20030621193124.GK6754@parcelfarce.linux.theplanet.co.uk> <3EF4BEC5.1060301@aros.net> <20030622103002.GK608@suse.de>
In-Reply-To: <20030622103002.GK608@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Sat, Jun 21 2003, Lou Langholtz wrote:
>  
>
>>>Because often that lock protects driver-internal objects that are used
>>>by all queues.
>>>
>>>      
>>>
>>Not sure I understand what you're saying... I was going by the kernel 
>>blk_init_queue(q, rfn, lock) . . .
>>
>. . . One example of such is IDE, which has two drives on one
>channel and the channel is the syncronization point. So it actually
>makes sense to have one lock per channel, and have that lock be shared
>by the two queues (drives) on that channel.
>
>Seems to me, you are suffering somewhat from the 'more locks is just
>faster' disease. This is often not the case. ->queue_lock being a
>pointer is just more powerful than having the lock embedded, because it
>gives you the option to make your locking hierachy the way you want it.
>
>So please, leave the single global nbd_lock and just use that for all
>queues until you have anything close to resembling real evidence that
>splitting it up is worth it. I do guarentee you that for X busy queues,
>the patch you sent will be _slower_ than maintaining one single lock due
>to dirty cache line bouncing.
>
IDE seems like a great example, thanks. In this sense each NIC on the 
host then (more especially slower ones like 100Mbps NICs) is something 
of a sync point relative to the IDE channel. Very good image indeed!!! I 
will redo the patch shortly with just a single lock. Most hosts have 
just a single NIC anyway and the argument for saving space is compelling 
too!! I suppose based on the NIC being the sync point it could be argued 
that I should check and then use literally a lock per NIC, but I'm not 
going to make this argument. Simpler (especially to start with) is just 
better by me. :-) As is saving space. :-)

As for the disease... personally I just didn't even begin to understand 
what you've explained until now. I suspect others who're suffering were 
just thinking - as I did - that these were in simplistic terms just 
logically independent queues and so deserved logically independent 
locks. The cache line problem seems like an entirely seperate problem 
that has its very own merits (ie. is arguably reason enough to have just 
the single lock).

Maybe there's a good place to add some cautionary comments about this if 
it's not somewhere already (like under 
Documentation/block/request_queue.txt)??? That's just a thought 
though... I'd like to just focus on NBD myself. ;-)


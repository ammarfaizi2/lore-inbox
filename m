Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262056AbSI1PrR>; Sat, 28 Sep 2002 11:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbSI1PrR>; Sat, 28 Sep 2002 11:47:17 -0400
Received: from host194.steeleye.com ([66.206.164.34]:25604 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262056AbSI1PrP>; Sat, 28 Sep 2002 11:47:15 -0400
Message-Id: <200209281552.g8SFqKS04855@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
In-Reply-To: Message from "Justin T. Gibbs" <gibbs@scsiguy.com> 
   of "Fri, 27 Sep 2002 15:28:47 MDT." <2645346224.1033162127@aslan.btc.adaptec.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Sep 2002 11:52:19 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gibbs@scsiguy.com said:
> 1) Device returns queue full with no outstanding commands from us
>    (usually occurs in multi-initiator environments). 

That's another manifestation of the problem I referred to.

> 2) No delay after busy status so devices that will continually
>    report BUSY if you hammer them with commands never come ready. 

I think Eric did that because the spec makes BUSY look less severe than QUEUE 
FULL.  We can easily treat busy as QUEUE FULL.  That will cause a short delay 
as the cmd goes back into the block queue and gets reissued.

> 3) Queue is restarted as soon as any command completes even if
>    you really need to throttle down the number of tags supported
>    by the device. 

That's a valid flow control response.  Given the variability of queue depths, 
particularly in multi-initiator/FC environments, it's not clear that 
attempting to implement high/low water marks would buy anything.

> 4) No tag throttling.  If tag throttling is in 2.5, does it ever
>    increment the tag depth to handle devices that report temporary
>    resource shortages (Atlas II and III do this all the time, other
>    devices usually do this only in multi-initiator environments). 

That depends on the tag philosophy, which is partly what this thread is all 
about.  If you regard tags as simply a transport engine to the device and tend 
to keep the number of tags much less than the number the device could accept, 
then this isn't necessary.

Since this feature is one you particularly want for the aic, send us some code 
and it can probably go in the mid-layer. (or actually, if you want to talk to 
Jens about it, the block layer).

> 5) Proper transaction ordering across a queue full.  The aic7xxx
>    driver "requeues" all transactions that have not yet been sent
>    to the device replacing the transaction that experienced the queue
>    full back at the head so that ordering is maintained. 

I'm lost here.  We currently implement TCQ with simple tags which have no 
guarantee of execution order in the drive I/O scheduler.  Why would we want to 
bother preserving the order of what will become essentially an unordered queue?

This will become an issue when (or more likely if) journalled fs rely on the 
barrier being implemented down to the medium, and the mid layer does do 
reqeueing in the correct order in that case, except for the tiny race where 
the command following the queue full could be accepted by the device before 
the queue is blocked.

> No thought was put into any of these issues in 2.4, so I decided not
> to even think about trusting the mid-layer for this functionality. 

Apart from the TCQ pieces, these are all edge cases which are rarely (if ever) 
seen.  They afflict all drivers and the only one that causes any problems is 
the mid-layer assumption that all devices can accept at least one command.

By not using any of the mid-layer queueing, you've got into a catch-22 
situation where we don't have any bug reports for these problems and you don't 
see them because you don't use the generic infrastructure.

How about I look at fixing the above and you look at using the generic 
infrastructure?

I might even think about how to do dynamic tags in the blk code...

James




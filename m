Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132875AbRDKSrO>; Wed, 11 Apr 2001 14:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRDKSrG>; Wed, 11 Apr 2001 14:47:06 -0400
Received: from anarchy.io.com ([199.170.88.101]:46409 "EHLO anarchy.io.com")
	by vger.kernel.org with ESMTP id <S132875AbRDKSqs>;
	Wed, 11 Apr 2001 14:46:48 -0400
Date: Wed, 11 Apr 2001 12:56:43 -0500 (CDT)
From: Bret Indrelee <bret@io.com>
To: Linux Kernel Mailing List <linux-kernel@vger.rutgers.edu>
Subject: Re: No 100 HZ timer!
Message-ID: <Pine.LNX.4.21.0104111242150.16730-100000@fnord.io.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka (mikulas@artax.karlin.mff.cuni.cz) wrote:
> Adding and removing timers happens much more frequently than PIT tick,
> so 
> comparing these times is pointless. 
>
> If you have some device and timer protecting it from lockup on buggy 
> hardware, you actually 
>
> send request to device 
> add timer 
>
> receive interrupt and read reply 
> remove timer 
>
> With the curent timer semantics, the cost of add timer and del timer is 
> nearly zero. If you had to reprogram the PIT on each request and reply,
> it 
> would slow things down. 
>
> Note that you call mod_timer also on each packet received - and in worst 
> case (which may happen), you end up reprogramming the PIT on each
> packet. 

You can still have nearly zero cost for the normal case. Avoiding worst
case behaviour is also pretty easy.

You only reprogram the PIT if you have to change the interval.

Keep all timers in a sorted double-linked list. Do the insert
intelligently, adding it from the back or front of the list depending on
where it is in relation to existing entries.

You only need to reprogram the interval timer when:
1. You've got a new entry at the head of the list
AND
2. You've reprogrammed the interval to something larger than the time to 
the new head of list.

In the case of a device timeout, it is usually not going to be inserted at
the head of the list. It is very seldom going to actually timeout.

Choose your interval wisely, only increasing it when you know it will pay
off. The best way of doing this would probably be to track some sort
of LCD for timeouts.

The real trick is to do a lot less processing on every tick than is
currently done. Current generation PCs can easily handle 1000s of
interrupts a second if you keep the overhead small.

-Bret

------------------------------------------------------------------------------
Bret Indrelee |  Sometimes, to be deep, we must act shallow!
bret@io.com   |  -Riff in The Quatrix



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278424AbRJXA0Z>; Tue, 23 Oct 2001 20:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278423AbRJXA0G>; Tue, 23 Oct 2001 20:26:06 -0400
Received: from smtp-rt-7.wanadoo.fr ([193.252.19.161]:29592 "EHLO
	embelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278422AbRJXA0B>; Tue, 23 Oct 2001 20:26:01 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Wed, 24 Oct 2001 02:26:02 +0200
Message-Id: <20011024002602.3310@smtp.wanadoo.fr>
In-Reply-To: <E15w8Z6-00010E-00@the-village.bc.nu>
In-Reply-To: <E15w8Z6-00010E-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Some driver already handle queues. In the case of network driver, just
>> stop your network queue and stop accepting incoming packets. If your
>> driver is too simple to have queues, a simple semaphore on entry points
>> can often be enough. You shouldn't deadlock as you are not supposed to
>> re-enter a sleeping driver in step 2.
>
>Stop accepting new requests is not simple. To complete existing requests you
>might need an arbitary other module to complete a new request you submit
>as part of your shutdown. 

That mean you have an ordering dependency, the driver you rely
upon must be stopped after you. That's the point of having a
tree here. Patrick and Linus feel the bus tree is enough to handle
that dependency, which might well be the case for 99% of drivers.

I have a couple of cases where that's not completely true on pmacs,
but nothing that can't worked around simply I beleive.

If you feel more drivers will be affected, then we will probably
need to separate the power-tree from the device-tree and provide
some hooks so that ordering can be tweaked.

All this assumes you don't have circular dependencies of course ;)

I see a lot of cases where this "block IOs" is easily dealt with
in the drivers I maintain on pmac, that might not be that easy on
other archs, I can't tell.

Basically, simple drivers can just use a semaphore. I do that for
our sound driver for example, I block any app doing an ioctl while
the driver is sleeping. (This happens late enough in the sleep
process so that userland using /dev/apm_bios already got
notified and acked the suspend, letting properly written apps to
have stopped themselves already).

Drivers using a request queue usually already have a way to mark
themselves busy (they use that to decide if they have to kick
the HW or not when getting a new request). In cases where a mid-layer
enters the scene, like SCSI, that wants to do timeouts, then well...
we can let it timeout (just stop processing requests), or we can
have the midlayer go to sleep as well :) That later solution
may cause some interesting ordering issues however...

Network drivers can stop their queue or just drop packets... I'd
like if they waited for packets received from the network stack
before the callback is called are waited to be sent. Those packets
may contain the request to a server to send a wake-on-lan magic
packet to your machine ;) For now, I just block the output
queue and flush the rings on pmac, but I also dont support WOL yet.

For fbdevs, I simply switch them to dummy functions when asleep.
This appear to work well. (Well, I do some additional state save
and PM, but all I do for "blocking IOs" is to drop them...)
Any printk done after they are suspended isn't displayed, but that's
not a real issue.

So yes, "blocking IOs" can actually mean "dropping new IOs",
that depends very much on the driver.

For USB, for example, we can consider that when a device driver
(not a controller driver) suspend has been done, any URB it submits
can just be dropped (returned immediately with an error). We don't
need blocking here neither. Of course, that means we have the
framework to call devices' suspend/resume callbacks when the
controller is about to go to sleep.

There might be other examples. I agree it's not a 2 lines fix
per driver, but that's the better I could imagine so far to have
something reliable. 

If you have other ideas, please share.

Ben.



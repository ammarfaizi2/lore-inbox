Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264411AbRFNGhx>; Thu, 14 Jun 2001 02:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264408AbRFNGhn>; Thu, 14 Jun 2001 02:37:43 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:64004 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264407AbRFNGhb>; Thu, 14 Jun 2001 02:37:31 -0400
Date: Wed, 13 Jun 2001 23:39:49 -0700 (PDT)
From: Patrick Mochel <mochel@transmeta.com>
To: Jeff Golds <jgolds@resilience.com>
cc: Keith Owens <kaos@ocs.com.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.6-pre3
In-Reply-To: <3B27DE0E.84025F41@resilience.com>
Message-ID: <Pine.LNX.4.10.10106132305450.1433-100000@nobelium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Jun 2001, Jeff Golds wrote:

> Patrick Mochel wrote:
> > 
> > On Wed, 13 Jun 2001, Keith Owens wrote:
> > 
> > > tulip_core.c:1756: warning: initialization from incompatible pointer type
> > > tulip_core.c:1757: warning: initialization from incompatible pointer type
> > 
> > This is likely due to the updates to struct pci_driver.
> > 
> > The suspend callback was changed to take another parameter (the state it
> > is to enter) and to return an int.
> > 
> > The resume callback was changed to return an int.
> > 
> > Since these callbacks are rarely, if ever used, and since they don't
> > cause an actual compile error, the changes were considered benign.
> > 
> 
> No offense, but that kind of attitude is harmful to the progression of making Linux a good operating system.
> 
> Our products NEED suspend/resume to work properly.  PERIOD.  I just spent a few days fixing some bugs in the Tulip driver with suspend/resume, and now your telling me that it's ok to change the API because no one is using it?  So if people ARE using the suspend/resume calls they are just SOL?  Sorry, I don't think things work well that way.
> 
> These sort of changes should either wait until 2.5 OR wait until EVERYONE has time to change ALL the drivers so that things don't get broken when you change the API.
> 
> 2.4.x is supposed to be a "stable" series of kernels.  Thus far, I have NOT been impressed with its stability.

First off, the patch went into a pre-release of the kernel. Never would I
trust a pre-release to be stable. Other issues with stability should be
addressed through appropriate channels, not piggy-backing on another rant.

Second of all, if you look at the big picture, you may see the benefit in
the change that was made. There is an effort to make Linux support power
management, both at the system-wide level and at the driver level, in a
much better way than it ever has. These changes are a manifestation of
that effort. 

You want to know what power state the device has been requested to go in.
And, you want to be able to return some sort of error code from that
operation. And, you want to be able to do the same from resume. The
infrastructure is not there to take note of it yet; but it will be.

Thirdly, these functions are rarely used. There are 1609 .c files in the
drivers directory. Of these, 68 of these have a "struct pci_driver" in
them. Of those, 15 actually define a suspend callback. It is a fairly
trivial task to add the parameter and the proper return values to each of
those affected. Would it make you feel better if I promised that each one
would be free of compile warnings before 2.4.6 (final)?

It wouldn't me, because I know there is a lot of work to be done still.
How many of those drivers properly suspend and resume? With comments
like:

	/* I'm absolutely uncertain if this part of code may work.
	...

it doesn't give me much confidence. Nor do the several completely empty
suspend/resume implementations.

(Btw, 3 of these were updated to support the API changes in -pre3)

Next, since you know the tulip code so well, then you shouldn't have much
of a problem making sure that it can suspend to all of the states that it
supports, and that it can incrementally do so. See a previous post about
the possible state transitions. Also, make sure that it can handle
completely reinitialization on a D3->D0 transition. 

Also, there will be another function added to the callback - save_state,
which will the routine that handles both saving the device's state and
actually failing to notify the system that it can't enter a global suspend
state if the device can't make the transition for some reason. (This will
of course all be documented in pci.txt)

Lastly, politics is a game that cannot be won. Someone could have said
"We will change the suspend/resume API; please update drivers
accordingly." Someone else would have complained, unless the operation
happened completely atomically. And, I'm sure someone would have
complained even then. 

This change was relatively minor, and easy to remedy the warnings before
the next _stable_ version of the kernel was released. Plus, it will 
benefit everyone, anyway, in the end (hopefully).

	-pat


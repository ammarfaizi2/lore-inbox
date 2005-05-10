Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVEJPpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVEJPpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVEJPoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:44:30 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:46798 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261695AbVEJPmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:42:23 -0400
Date: Tue, 10 May 2005 19:41:28 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number
 next.
Message-ID: <20050510194128.075abb67@zanzibar.2ka.mipt.ru>
In-Reply-To: <d120d500050510075671efe331@mail.gmail.com>
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	<200505100118.48027.dtor_core@ameritech.net>
	<20050510140445.36cc15cb@zanzibar.2ka.mipt.ru>
	<d120d500050510075671efe331@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 10 May 2005 19:41:36 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005 09:56:45 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On 5/10/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > On Tue, 10 May 2005 01:18:46 -0500
> > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > 
> > > - drop cn_dev - there is only one connector;
> > 
> > There may be several connectors with different socket types.
> > I use it in my environment for tests.
> > 
> 
> Why do you need that? u32 ID space is not enough?

They use different netlink sockets.
One of them can fail during initialisation, for example...

> > > - simplify cn_notify_request to carry only one range - it simplifies code
> > >   quite a bit - nothing stops clientd from sending several notification
> > >   requests;
> > 
> > ? Nothing stops clients from sending several notification requests now.
> > I do not see how it simplifies the things?
> > Feel free to set idx_num and val_num to 1 and you will have the same.
> 
> Compare the implementaion - without variable-length notification
> requests the code is much simplier and flexible.

Hmm, old request had a length, new one - does not.
But instead of atomically addition of the whole set, one need to send
couple of events.
I do not see any profit here.

> > > - implement internal queuefor callbacks so we are not at mercy of scheduler;
> > 
> > Current implementation has big warning about such theoretical behaviour,
> > if it will be triggered, I will fix that behaviour,
> > more likely not by naive work allocation - there might be
> > at least cache/memory pool or something...
> 
> What is the average expected rate for such messages? Not particularly
> high I think. We just need to sustain sudden bursts, naive work
> allocation will work just fine here.

Probably - I still think it is theoretical "misbehaviour" [dropping 
input messages under the high load] that can not be 
triggered, if it will - I will fix it.

> > > - admit that SKBs are message medium and do not mess up with passing around
> > >   destructor functions.
> > 
> > You mess up layers.
> > I do not see why you want it.
> 
> What layers? Connector core is not an onion, with my patch it is 481
> line .c file(down from 900+), comments probably take 1/3 of it. We
> just need to keep it simple, that's all.

There is low-level medium layer - skbs.
There is middle-level layer - logical handling attached data and appropriate callback invocation.
There is high-level layer - various protocols over connector.

Why any of them should know that others exist?
Your changes with destructor removing only saved < 10 lines of code, btw.

> > Connector with your changes just does not work.
> 
> As in "I tried to run it and adjusted the application for the new
> cn_notify_req size and it does not work" or "I am saying it does not
> work"?

Second, i.e. "I am saing it does not work".
With your changes userspace just does not see any message being sent by kernelspace.

> > Dmitry, I do not understand why do you change things in so radical manner,
> > especially when there are no 1. new interesting features, 2. no performance
> > improvements, 3. no right design changes.
> 
> There is a right design change - it keeps the code simple. It peels
> all the layers you invented for something that does not really need
> layers - connector is just a simple wrapper over raw netlink.

That is your opinion.

Code is already as simple as possible, since it is layered and each 
piece of code is separated from different logical entities.

> When I look at the code I see the mess of unneeded refcounting, wrong
> kinds of locking, over-engineering. Of course I want to change it.

There are no unneded reference counting now.
Locking was not wrong - you only placed semaphore instead of notify BH lock
just to have ability to sleep under the lock and send callback addition/removing
notification with GFP_KERNEL mask, 
and it is probably right change from the first view, as I said, 
but it can be implemented in a different way.

> Keep it simple. Except for your testing environment why do you need to
> have separate netlink sockets? You have an ample ID space. Why do you
> need separate cn_dev and cn_queue_dev (and in the end have them at
> all)? Why do you need "input" handler, do you expect to use different
> handlers? If so which? And why? Do you expect to use other transports?
> If so which? And why? You need to have justifiction for every
> additional layer you putting on.

Sigh.
It was already answered so many times, as far as I remember...
Ok, let's do it again.

Several netlink sockets - if you can see, connector uses NETLINK_ULOG
for it's notification, you can not use the same socket twice, so you
may have new device with new socket, or several of them, and system
may work if one initialisation failed.
cn_dev is connector device structure, cn_queue_dev - it's queueing part.
input handler is needed for ability to receive messages.
Couple of next questions can be answered in one reply:
original connector's idea was to implement notification based
not on top of netlink protocol, but using ioctls of char device,
so there could be different connector device, input method, 
transport and so on. Probably I will not implement it thought.


Over-engineering? I can not call it so... :)


> > > BTW, I do not think that "All rights reserved" statement is applicable/
> > > compatible with GPL this software is supposedly released under, I have
> > > taken liberty of removing this statement.
> > 
> > You substitute license agreements with copyright.
> > "All rights reserved" is targeted to copyright
> > (avtorskoe pravo, zakon N 5351/1-1) of the code
> > and has nothing with license.
> 
> Yes, you are probably right, sorry for the noise...
> 
> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt

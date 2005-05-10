Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVEJRvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVEJRvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 13:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVEJRvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 13:51:08 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:58082 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261713AbVEJRu4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 13:50:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=txyRjWDfG9LtuXYp8/JYH6gaWx/O7qGX8rzpiwn7eqAi7DSAjlV5HSLDWXyegS3miIaAT0UvMg85v+bbKdMCWhdvMQXgVJrEKxgzE2UE08QXCAnAASOCaDsXXPJHtvVpoLpr+wpmFoG9F6iplArT76N5Qhs+j3rR6kG+qeIhN00=
Message-ID: <d120d500050510105012d4ba8b@mail.gmail.com>
Date: Tue, 10 May 2005 12:50:55 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number next.
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <20050510194128.075abb67@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	 <200505100118.48027.dtor_core@ameritech.net>
	 <20050510140445.36cc15cb@zanzibar.2ka.mipt.ru>
	 <d120d500050510075671efe331@mail.gmail.com>
	 <20050510194128.075abb67@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Tue, 10 May 2005 09:56:45 -0500
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On 5/10/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > On Tue, 10 May 2005 01:18:46 -0500
> > > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > >
> > > > - drop cn_dev - there is only one connector;
> > >
> > > There may be several connectors with different socket types.
> > > I use it in my environment for tests.
> > >
> >
> > Why do you need that? u32 ID space is not enough?
> 
> They use different netlink sockets.
> One of them can fail during initialisation, for example...

Are you saying that there more chances successfully allocating 2
netlink sockets than one?

> 
> > > > - simplify cn_notify_request to carry only one range - it simplifies code
> > > >   quite a bit - nothing stops clientd from sending several notification
> > > >   requests;
> > >
> > > ? Nothing stops clients from sending several notification requests now.
> > > I do not see how it simplifies the things?
> > > Feel free to set idx_num and val_num to 1 and you will have the same.
> >
> > Compare the implementaion - without variable-length notification
> > requests the code is much simplier and flexible.
> 
> Hmm, old request had a length, new one - does not.
> But instead of atomically addition of the whole set, one need to send
> couple of events.
> I do not see any profit here.

Smaller kernel code, simpler notification structure, ability to stop
listenig to a certain events without re-registering the rest of the
block.

> > > > - admit that SKBs are message medium and do not mess up with passing around
> > > >   destructor functions.
> > >
> > > You mess up layers.
> > > I do not see why you want it.
> >
> > What layers? Connector core is not an onion, with my patch it is 481
> > line .c file(down from 900+), comments probably take 1/3 of it. We
> > just need to keep it simple, that's all.
> 
> There is low-level medium layer - skbs.
> There is middle-level layer - logical handling attached data and appropriate callback invocation.
> There is high-level layer - various protocols over connector.
> 
> Why any of them should know that others exist?
> Your changes with destructor removing only saved < 10 lines of code, btw.

Yes, line here and line there - all in all couple hundred lines.

> > > Connector with your changes just does not work.
> >
> > As in "I tried to run it and adjusted the application for the new
> > cn_notify_req size and it does not work" or "I am saying it does not
> > work"?
> 
> Second, i.e. "I am saing it does not work".
> With your changes userspace just does not see any message being sent by kernelspace.

Would you care to elaborate on this please. As far as I know
kernel->userspace path was not changed at all.

> 
> > > Dmitry, I do not understand why do you change things in so radical manner,
> > > especially when there are no 1. new interesting features, 2. no performance
> > > improvements, 3. no right design changes.
> >
> > There is a right design change - it keeps the code simple. It peels
> > all the layers you invented for something that does not really need
> > layers - connector is just a simple wrapper over raw netlink.
> 
> That is your opinion.
> 
> Code is already as simple as possible, since it is layered and each
> piece of code is separated from different logical entities.
> 
> > When I look at the code I see the mess of unneeded refcounting, wrong
> > kinds of locking, over-engineering. Of course I want to change it.
> 
> There are no unneded reference counting now.
> Locking was not wrong - you only placed semaphore instead of notify BH lock
> just to have ability to sleep under the lock and send callback addition/removing
> notification with GFP_KERNEL mask,
> and it is probably right change from the first view, as I said,
> but it can be implemented in a different way.

That's what I was referring to as "wring locking". Notifications do
not need to stop bottom handlers, a spinlock or semaphore willl work
just fine. SInce I wanted to allocate memory only after I determined
that it is a new  notify request a semaphore was a better choise.

> > Keep it simple. Except for your testing environment why do you need to
> > have separate netlink sockets? You have an ample ID space. Why do you
> > need separate cn_dev and cn_queue_dev (and in the end have them at
> > all)? Why do you need "input" handler, do you expect to use different
> > handlers? If so which? And why? Do you expect to use other transports?
> > If so which? And why? You need to have justifiction for every
> > additional layer you putting on.
> 
> Sigh.
> It was already answered so many times, as far as I remember...
> Ok, let's do it again.
> 
> Several netlink sockets - if you can see, connector uses NETLINK_ULOG
> for it's notification, you can not use the same socket twice, so you
> may have new device with new socket, or several of them, and system
> may work if one initialisation failed.

Or it may not. Why do you think that having several sockets is safer
than using one? After all, it is just a matter of setting it up and
finally allocating a separate socket number for connector.

> cn_dev is connector device structure, cn_queue_dev - it's queueing part.
> input handler is needed for ability to receive messages.

You chose not to understand my question. Why do you need to have is as
a pointer? Do you expect to have different input handler?

> Couple of next questions can be answered in one reply:
> original connector's idea was to implement notification based
> not on top of netlink protocol, but using ioctls of char device,
> so there could be different connector device, input method,
> transport and so on. Probably I will not implement it thought.

IOW this all is remnants of an older design. You have no plans to
utilize the framework and therefore it is not needed anymore and can
be dropped.

-- 
Dmitry

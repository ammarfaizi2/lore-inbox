Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276535AbRJCQyQ>; Wed, 3 Oct 2001 12:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276527AbRJCQyH>; Wed, 3 Oct 2001 12:54:07 -0400
Received: from chiara.elte.hu ([157.181.150.200]:54280 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276535AbRJCQxv>;
	Wed, 3 Oct 2001 12:53:51 -0400
Date: Wed, 3 Oct 2001 18:51:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110031138150.4833-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0110031828060.8633-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, jamal wrote:

> this code was added by Robert to check something; cant remember the
> details on that specific date. [...]

ok.

> > +         while (!list_empty(&queue->poll_list)) {
> > +                 struct net_device *dev;
> > [...]
> > +                 if (dev->quota <= 0 || dev->poll(dev, &budget)) {
> > +                         local_irq_disable();
> > +                         list_del(&dev->poll_list);
> > +                         list_add_tail(&dev->poll_list, &queue->poll_list);

> You misunderstood. This is to enforce fairness. [...]

(i did not criticize the list_add/list_del in any way, it's obviously
correct to cycle the polled devices. I highlited that code only to show
that the current patch as-is polls too agressively for generic server
load.)

> Read the paper.

(i prefer source code. Can i assume the 'authorative' patch to be the one
with the "goto not_done;" line removed, correct?)

> > In a generic computing environment i want to spend cycles doing useful
> > work, not polling. Even the quick kpolld hack [which i dropped, so please
> > dont regard it as a 'competitor' patch] i consider superior to this, as i
> > can renice kpolld to reduce polling. (plus kpolld sucks up available idle
> > cycles as well.) Unless i royally misunderstand it, i cannot stop the
> > above code from wasting my cycles, and if that is true i do not want to
> > see it in the kernel proper in this form.

> The interupt just flags "i, netdev, have work to do"; [...]

(and the only thing i pointed out was that the patch as-is did not limit
the amount of polling done.)

> > *if* you can make polling a success in ~90% of the time we enter
> > tulip_poll() under non-specific server load (ie. not routing), then i
> > think you have really good metrics.
>
> we can make it 100% successful; i mentioned that we only do work, if
> there is work to be done.

can you really make it 100% successful for rx? Ie. do you only ever call
the ->poll() function if there is a new packet waiting? How do you know
with a 100% probability that someone on the network just sent a new packet
waiting? (without receiving an interrupt to begin with that is.)

	Ingo


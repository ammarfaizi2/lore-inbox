Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276430AbRJCP7T>; Wed, 3 Oct 2001 11:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276426AbRJCP7J>; Wed, 3 Oct 2001 11:59:09 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:2232 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S276424AbRJCP6u>;
	Wed, 3 Oct 2001 11:58:50 -0400
Date: Wed, 3 Oct 2001 11:56:25 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110031702280.7221-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.30.0110031138150.4833-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Ingo Molnar wrote:

>
> On Wed, 3 Oct 2001, jamal wrote:
>
> > No. NAPI is for any type of network activities not just for routers or
> > sniffers. It works just fine with servers. What do you see in there
> > that will make it not work with servers?
>
> eg. such solutions in tulip-NAPI-010910:
>
>          /* For now we do this to avoid getting into
>             IRQ mode too quickly */
>
>          if( jiffies - dev->last_rx  == 0 ) goto not_done;
>          [...]
>  not_done:
>          [...]
>          return 1;

this code was added by Robert to check something; cant remember the
details on that specific date. The goal is to test variuos workloads and
conditions before reaching  conclusions; so it might have been valid on
that day only
Take it out and things should work just fine.

> combined with this code in the net_rx_action softirq handler:
>
> +         while (!list_empty(&queue->poll_list)) {
> +                 struct net_device *dev;
> [...]
> +                 if (dev->quota <= 0 || dev->poll(dev, &budget)) {
> +                         local_irq_disable();
> +                         list_del(&dev->poll_list);
> +                         list_add_tail(&dev->poll_list, &queue->poll_list);
>
> while the stated goal of NAPI is to do 'intelligent, feedback based
> polling', apparently the code is not trusting its own metrics, and is
> forcing the interface into polling mode if we are still within the same 10
> msec period of time, or if we have looped 300 times (default
> netdev_max_backlog value). Not very intelligent IMO.
>

You misunderstood. This is to enforce fairness. Read the paper. When
you have one device sending 100Kpps and another sending 1pps to the stack,
you wanna make sure that the 1pps doesnt get starved -- thats what the
purpose of the above code is (hence the Round  robin scheduling and the
quota per device).

> In a generic computing environment i want to spend cycles doing useful
> work, not polling. Even the quick kpolld hack [which i dropped, so please
> dont regard it as a 'competitor' patch] i consider superior to this, as i
> can renice kpolld to reduce polling. (plus kpolld sucks up available idle
> cycles as well.) Unless i royally misunderstand it, i cannot stop the
> above code from wasting my cycles, and if that is true i do not want to
> see it in the kernel proper in this form.
>

Again, you misunderstood. Please spend a few more minutes reading the code
and i should insist you read the paper ;->
The interupt just flags "i, netdev, have work to do"; the the poll thread
grabs packets off it when the softirq gets scheduled. So we dont do
unecessary polling; we only poll when  there is work to be done.
In the low-load case this solution reduces to the same as interupt driven
system and scales to the system/CPU capacity.

> if the only thing done by a system is processing network packets, then
> polling is a very nice solution for high loads. So do not take my comments
> as an attack against polling.
>

The poll thread is run as softirq, just as the other half of networking is
today. And as should be because networking is extremely important as a
subsyestem.

> *if* you can make polling a success in ~90% of the time we enter
> tulip_poll() under non-specific server load (ie. not routing), then i
> think you have really good metrics.

we can make it 100% successful; i mentioned that we only do work, if there
is work to be done.

cheers,
jamal


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269212AbTCBOBo>; Sun, 2 Mar 2003 09:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269214AbTCBOBn>; Sun, 2 Mar 2003 09:01:43 -0500
Received: from mx03.cyberus.ca ([216.191.240.24]:60422 "EHLO mx03.cyberus.ca")
	by vger.kernel.org with ESMTP id <S269212AbTCBOBk>;
	Sun, 2 Mar 2003 09:01:40 -0500
Date: Sun, 2 Mar 2003 09:11:39 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org, "" <netdev@oss.sgi.com>,
       "" <linux-net@vger.kernel.org>
Subject: Re: anyone ever done multicast AF_UNIX sockets?
In-Reply-To: <3E619E97.8010508@nortelnetworks.com>
Message-ID: <20030302081916.S61365@shell.cyberus.ca>
References: <3E5E7081.6020704@nortelnetworks.com> <20030228083009.Y53276@shell.cyberus.ca>
 <3E5F748E.2080605@nortelnetworks.com> <20030228212309.C57212@shell.cyberus.ca>
 <3E619E97.8010508@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Mar 2003, Chris Friesen wrote:

> jamal wrote:
> > Did you also measure throughput?
>
> No.  lmbench doesn't appear to test UDP socket local throughput.

I think you need to collect all data if you are trying to show
improvements.

>
> > You are overlooking the flexibility that already exists in IP based
> > transports as an advantage; the fact that you can make them
> > distributed instead of localized with a simple addressing change
> > is a very powerful abstraction.
>
> True.  On the other hand, the same could be said about unicast IP
> sockets vs unix sockets.  Unix sockets exist for a reason, and I'm
> simply proposing to extend them.
>

You are treading into areas where unix sockets make less sense compared to
sockets. Good design rules (should actually read "lazy design
rules") ometimes you gotta move to a round peg instead of trying to make
the square one round.

> > You could implement the abstraction in user space as a library today by
> > having some server that muxes to several registered clients.
>
> This is what we have now, though with a suboptimal solution (we
> inherited it from another group).  The disadvantage with this is that it
> adds a send/schedule/receive iteration.  If you have a small number of
> listeners this can have a large effect percentage-wise on your messaging
> cost.  The kernel approach also cuts the number of syscalls required by
> a factor of two compared to the server-based approach.
>

Ok, so its only a problem when you have a few listeners i.e user space
scheme scales just fine as you keep adding listeners.
In your tests what was the break-even point?

> > So whats the addressing scheme for multicast unix? Would it be a
> > reserved path?
>
> Actually I was thinking it could be arbitrary, with a flag in the unix
> part of struct sock saying that it was actually a multicast address.
> The api would be something like the IP multicast one, where you get and
> bind a normal socket and then use setsockopt to attach yourself to one
> or more of multicast addresses.  A given address could be multicast or
> not, but they would reside in the same namespace and would collide as
> currently happens.  The only way to create a multicast address would be
> the setsockopt call--if the address doesn't already exist a socket would
> be created by the kernel and bound to the desired address.
>

Addressing has to be backwared compatible i.e not affecting any other
program.

> To see if its feasable I've actually coded up a proof-of-concept that
> seems to do fairly well. I tested it with a process sending an 8-byte
> packet containing a timestamp to three listeners, who checked the time
> on receipt and printed out the difference.
>
> For comparison I have two different userspace implementations, one with
> a server process (very simple for test purposes) and the other using an
> mmap'd file to store which process is listening to what messages.
>
> The timings (in usec) for the delays to each of the listeners were as
> follows on my duron 750:
>
> userspace server:     104 133 153
> userspace no server:   72 111 138
> kernelspace:           60  91 113
>
> As you can see, the kernelspace code is the fastest and since its in the
> kernel it can be written to avoid being scheduled out while holding
> locks which is hard to avoid with the no-server userspace option.
>

Actually, the difference between user space server and kernel doesnt
appear that big. What you need to do is collect more data.
repeat with incrementing number of listeners.

> If this sounds at all interesting I would be glad to post a patch so you
> could shoot holes in it, otherwise I'll continue working on it privately.
>

no rush, lets see your test data first and then you gotta do a better
sales job on the cost/benefit/flexibilty ratios.

cheers,
jamal

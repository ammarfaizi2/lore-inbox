Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268948AbRG0T4J>; Fri, 27 Jul 2001 15:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268946AbRG0T4A>; Fri, 27 Jul 2001 15:56:00 -0400
Received: from e22.nc.us.ibm.com ([32.97.136.228]:39052 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268944AbRG0Tzv>; Fri, 27 Jul 2001 15:55:51 -0400
Date: Fri, 27 Jul 2001 12:55:25 -0700 (PDT)
From: Sridhar Samudrala <samudrala@us.ibm.com>
To: kuznet@ms2.inr.ac.ru
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, samudrala@us.ibm.com,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        lartc@mailman.ds9a.nl, diffserv-general@lists.sourceforge.net,
        rusty@rustcorp.com.au
Subject: Re: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
In-Reply-To: <200107271804.WAA22016@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.21.0107271140330.14328-100000@w-sridhar2.des.sequent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
> 
> > How is this different from having a single userspace thread in your
> > application which accepts connections as they come in and then hands them
> > out in an order it chooses, if need be erorring and closing some ?
> 
> Seems, I can answer. Because closing some would break the service.
> 
> The idea is that when kernel accept queue is full we stop to
> move open requests to established state and hence spurious
> aborts are not generated. So, accepting cannot be artificially
> speed up and extension of accept queue to user space is impossible.
> The similar problem was open with TUX, which relays requests
> to slow path. I do not know how Ingo solved it, by the way,
> but it looked terrible: either massive socket leak (no limit on accept queue)
> or massive aborts. :-)
> 
> 
> Another question to author: missing prioritization of drops.
> "Low priority" connections will clog accept queue, so that no room
> for high priority connections remains. It is not good.
> Any scheme with priority reserves some room for each high priority band
> or does dropping based on priority.

Low priority connections can clog the accept queue only when there are no
high priority connection requests coming along. As soon as a slot becomes empty
in the accept queue, it becomes available for a high priority connection. This
should work fine when we are receiving a steady flow of low priority and high
priority connections. But as you said, we may have a problem when there is a
burst of low priority connections filling the accept queue followed by a burst of
high priority connections. 

In our testing, we did not notice any starvation of higher priority connection
requests due to clogging of accept queue by low priority connections, 
If that happens, TCP SYN policing can be employed to limit the rate of low 
priority connections getting into accept queue. 

Reserving room in the accept queue for each priority class may help higher
priority connections, but this may cause lower priority connections to get 
dropped simply because there is no room for that class although there is room 
for higher priority classes and there are no incoming higher priority 
connections. 

-Sridhar

> 
> Alexey
> 


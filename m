Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUAZDKg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 22:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbUAZDKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 22:10:36 -0500
Received: from mail.cyberus.ca ([209.197.145.21]:55478 "EHLO mail.cyberus.ca")
	by vger.kernel.org with ESMTP id S265431AbUAZDK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 22:10:29 -0500
Subject: Re: [RFC/PATCH] IMQ port to 2.6
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20040126001102.GA12303@usr.lcm.msu.ru>
References: <20040125152419.GA3208@penguin.localdomain>
	 <20040125164431.GA31548@louise.pinerecords.com>
	 <1075058539.1747.92.camel@jzny.localdomain>
	 <20040125202148.GA10599@usr.lcm.msu.ru>
	 <1075074316.1747.115.camel@jzny.localdomain>
	 <20040126001102.GA12303@usr.lcm.msu.ru>
Content-Type: text/plain
Organization: jamalopolis
Message-Id: <1075086588.1732.221.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Jan 2004 22:09:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-25 at 19:11, Vladimir B. Savkin wrote:
> On Sun, Jan 25, 2004 at 06:45:16PM -0500, jamal wrote:
[..]
> 
> With typical internet traffic patterns, policing will drop many packets,
> and shaping will not.

What is typical internet traffic? I guess you mean TCP (thats what 90%
of the traffic is)
In that case, the effect of dropping or delaying on throughput is
similar. Studies i have seen indicate that throughput is directly
proportional to the square root of the drop probability
(drop is what you get when you police).
It is also influenced by the delay (which is what you introduce when you
shape). I have not seen anything in favor of shaping; i could be wrong
(so if you know of something or have experimented pass the data).
For detailed analysis at least fro RENO, this would be a good reference:
http://citeseer.nj.nec.com/padhye98modeling.html

> 
> > OR
> > b) Why cant you achieve the same results by marking on ingress and
> > shaping on egress? 
> 
> Well, as I understand it, there's no "real" ingress and "real" egress.

There is essentially only egress.

> Look at this:
> Any forwarded packet
>   1) comes from one interface
>   2) receives some treatment (filtering, routing decision, maybe
>     delaying if we shape, mangling etc.)
>   and
>   3) goes away via some other interface
>
> step (1) is "ingress"

There is no ingress perse. Separation of ingress and egress is typically
a switch fabric or even a bus. So in this case, since you already
have crossed the bus you are in ingress teritory.
There is an ingress qdisc, but it is fake. The major value it adds
is to drop early when there is need to (no point in making forwarding
decision when you know you will drop the packet i.e no point in wasting
those processor cycles)- and therefore the ingress qdisc act as a 
holder of filters.

> step (3) is "egress"
> qdiscs work at step (2), so all of them are intermediate in this sense
> 
>
>
> Well, ok, if a qdisc receives a feedback from egress interface
> on when to dequeue a packet (when interface is ready to send),
> we can say that it is an egress qdisc.
> 

Look at my explanation above. 

> But in my case, PPP connections are really PPTP or PPPoE.
> Internal network bandwidth is not a premium, so all internal
> interfaces are always ready to send.
> 
> So, I don't shape at ingress or at egress, I shape passing-through
> traffic.
> 

The noun is not important. You crossed the bus already, you are in
processor land. 
The value is being able to drop as early as possible when you need to.
If you are not dropping and desire only to delay the packets, then do it
at the proper egress device.

> > > htb class, so using qdisc on each ppp interface is out of
> > > question. It seems to me that IMQ is the only way to achieve my goals.
> > 
> > By multiple clients i believe you mean you want to say "-i ppp+"?
> > We had a long discussion on this a while back (search netdev) 
> > and i think it is a valid point for dynamic devices like ppp. 
> 
> Well, I don't really care whether those interfaces are dynamic or
> static. They could be multiple vlans, and nothing would
> change in marking or shaping. I use clients' IPs for marking,
> and routing table cares about interfaces.
> 

Maybe i am misunderstanding what you are after.
couldnt you use -i ppp+ -j mark --set-mark x in the ingress/prerouting
and use the fwmark to shape on the egress?
Post your script examples. 

> > We need to rethink how we do things. Theres a lot of valu in having per
> > device tables (scalability being one).
> > IMO, this alone does not justify the existence of IMQ. 
> 
> I just can't think of a better abstraction that would handle my case.

I think it is time we came with a single solution for how packets are
managed. Your needs should be met, the problem is we may be having too
many cooks creating the same meal.

cheers,
jamal


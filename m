Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273385AbRIWLWz>; Sun, 23 Sep 2001 07:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273406AbRIWLWq>; Sun, 23 Sep 2001 07:22:46 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:26117 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S273385AbRIWLWh>;
	Sun, 23 Sep 2001 07:22:37 -0400
Date: Sun, 23 Sep 2001 14:23:06 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: Allen Lau <pflau@us.ibm.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict interface arp patch for Linux 2.4.2
In-Reply-To: <OFF8C7D800.364E6389-ON85256AD0.00046061@raleigh.ibm.com >
Message-ID: <Pine.LNX.4.33.0109231138130.828-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sat, 22 Sep 2001, Allen Lau wrote:

> > > In this example, 1.1.1.11 2.2.2.22 are virtual ip's which can float
> between
> > > boxes and interfaces.
> > > I want virtual ip 1.1.1.11 to be known to clients through eth0 node1
> > > (2.2.2.22 eth1 node2). Node1 can redirect 1.1.1.11 traffic to eth0
> node2.
> > >               node1                              node2
> > >           lo:1 1.1.1.11                       lo:1 1.1.1.11
> > >           lo:2 2.2.2.22                       lo:2 2.2.2.22
> > >
> > >   eth0   1.1.1.1    eth1 2.2.2.1      eth0 1.1.1.2    eth1 2.2.2.2
> > >   eth0:1 1.1.1.11                                   eth1:1 2.2.2.22
> > >
>
> arp_filter is not enough:
>    with arp_filter enabled, both node 1 and 2 will answer to "who is 1.1.1.11?".

	Agreed, arp_filter is not a solution for shared addresses.
I have never said such thing. You should assume that there is a reason
both hidden and arp_filter to exist in 2.2.14+ - they do different
things. You need only to mark {all,lo}/hidden on the both nodes. This is
enough, no matter what is the value of arp_filter and rp_filter.

> hidden patch + arp_filter:
>    If the hidden and arp_filter patches can be applied on top of each other(?),

	Yes, starting from hidden-2.4.5-1.diff (2.4.5 was the first 2.4
kernel with arp_filter support), may be your assumptions are based on
2.4.2 :)

>    one still has to be careful configuring the system.  In the example with
>    loopback hidden, you'll notice that no one will answer "who is 1.1.1.11?".

	May be because you have configured 1.1.1.11 both on lo:1 and
eth0:1. Agreed, it is dangerous. At least, the users have the power to
do advanced things without restrictions.

>    Further, arp_filter (which is based on routing) may have side effects from
>    asymmetric routing, multiple nic's on same subnet, and default routes.

	My opinion about all these flags and problems is that there
are many possible setups that need different solutions. All these flags
play different roles. The missing part from 2.4 (that you don't see in
distributions) is the solution for the ARP behavior when many hosts
share same addresses. All other problems you see can be solved from
the existing device flags and may be with route's noarp flag (plus changes
in arp_solicit).

	I already mentioned where the strict_interface_arp flag is
not good for clusters (may be it is good for other things but there
are already other flags for this):

- you make the assumption that all primary local IP addresses are
configured on ARP devices. By this way you can't combine virtual
network (with netsize < 32 bits on device lo) with your need for
strict traffic paths. To allow this you have to clear the strict
arp flag from the ARP devices. We don't talk about solutions where
one host needs both primary and secondary network from shared
addresses (both on device lo). This can be solved only with the
route's noarp flag (ip addr add NET1/24 dev lo hidden,
ip addr add NET2/24 dev lo), even hidden can't help here.

- something new: should the strict arp flag stop the "arp race" caused
from the proxy_arp feature (i.e. to stop the proxy_arp feature)?

> This example illustrates the problem and that the distributions does not have
> enough to solve. In addition, I need something simpler for field deployment.
> Strict_interface_arp I hope will provide the needed simplicity and control.

	Same with rp_filter+hidden

> >    The question is why you want 2.2.2.1 to be advertised as source
> > through eth0 ? May be your question is wrong and should contain eth1?
> > inet_select_addr() obviously selects source IP from the device you
> > request.
>
> That's the "arp flux" problem which strict_interface_arp solves.
> In Linux arp requests, it is possible for 2.2.2.1 eth1 node1 to be advertised
> as source by eth0 node1. For illustration, eth0 is 10/100M and eth1 is gigabit.
> It'll cause clients to redirect traffic for the gigabit to the 10/100M port.
> It does not appear rp_filter can solve this.

	Well, you are talking about the case where someone binds to
2.2.2.1 and talks to 1.1.1.2. What to say, IMO the right solution is
arp_solicit always to select the preferred source address from a new
[0 -> target, neigh->dev] output route call. We know that the remote
host should be able to receive our probes from many devices (if the
IP traffic is also received there) but it helps to solve the "arp flux"
problem and helps not to announce shared addresses in our probes.
Then the filtering of the remote probes can be done in different ways.
I don't know what the maintainers have against it. IMO, the route's
noarp flag + arp_solicit always to use the prefsrc is the best we can
do for 2.4.

> Regards
> Allen Lau


Regards

--
Julian Anastasov <ja@ssi.bg>


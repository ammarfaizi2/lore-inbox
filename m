Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbRAXWTS>; Wed, 24 Jan 2001 17:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130030AbRAXWTC>; Wed, 24 Jan 2001 17:19:02 -0500
Received: from ja.ssi.bg ([193.68.177.189]:29444 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S129664AbRAXWSs>;
	Wed, 24 Jan 2001 17:18:48 -0500
Date: Thu, 25 Jan 2001 00:19:30 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Bernd Eckenfels <inka-user@lina.inka.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off ARP in linux-2.4.0
Message-ID: <Pine.LNX.4.30.0101242303310.956-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On 24 Jan 2001, Bernd Eckenfels wrote:

> > The problem is complex and can't be solved with ifconfig -arp
>
> why?

Search for "arp" in the LVS mailing list:

http://marc.theaimsgroup.com/?l=linux-virtual-server&r=1&w=2

This problem is analyzed from many perspectives. The solution is
in production from 2.2.14+ and 2.3.41+

> > The needs for clusters with shared addresses include:
>
> > 1. block ARP replies for such addresses
>
> -arp will do that

	Not in Linux 2.2+, all addresses are replied. -arp only
means "don't talk ARP", in our case we talk through eth0, so we don't
want to stop it, right? Nobody talks ARP through "lo", why we need to
set -arp in lo, it is -arp by default. lo is only an interface where
we add the shared addresses and it is perfect because we can add
not only shared addresses but also shared networks:

ip addr add VIP_NET/24 dev lo scope host

> > 2. don't announce these addresses in the ARP probes (can be achieved
> > using ip addr add IP brd + dev lo scope host)
>
> i guess -arp will disable neighbour alive probes, too?

	They come/go from/through eth0. We don't use ifconfig eth0 -arp

> > 3. don't autoselect such addresses (for source addresses)
>
> This is not done if you do not use a route through that ip

	Run ifconfig eth0 0.0.0.0 up and you will create connections
with saddr=shared_address (hidden=0), even when it is configured
on loopback device.

> So where is the problem with -arp?
>
> Well.. another solution would be to use the ipip system instead of the arp
> redirection, right?

	No. Forget about the ARP flag. This is not Linux 2.0. The
hidden flag emulates Linux 2.0. In Linux 2.2+ all addresses are reported,
with some exceptions: LOOPBACK and MULTICAST. The device type and
its ARP flag are not involved in the decision. hidden=1 returns the
behaviour to Linux 2.0 for the users that need it but only to specific
devices, i.e. there is control over this feature.

	Here is the ARP problem for shared addresses, described in
all its aspects.

	The setup (think about a web cluster):

- one uplink router
- one director (the only host that advertises the shared address)
- many internal (real servers) that have the same shared address but
it is not advertised (hidden=1)
- one NIC on each host (director, real servers)

	The addresses:

A.B.C.D		client address (CIP), somewhere deeply in 0.0.0.0/0
		or on the same LAN, for example 10.0.0.4
10.0.0.1	uplink router (GIP)
10.0.0.2	director IP (DIP)
10.0.0.3	one of the real servers (RIP)
10.0.0.100	The virtual (shared) IP

	The events:

1.1 the uplink sends ARP probe (when the client is external)

	who-has 10.0.0.100 tell 10.0.0.1

	- only the director replies:

	10.0.0.100 is-at DIP_MAC

	- the real servers ignore/don't reply when the broadcasted
	probes are for VIP (hidden=1)

1.2 the LAN client performs the same actions as the uplink router

2. director forwards (after scheduling) the packet to one of the
real servers without changing it (this is not a NAT forwarding method)

3. the real server delivers locally the traffic with daddr=VIP

4. the real server wants to reply to the client address CIP, so it
resolves its next hop (the uplink router):

	- the wrong ARP probe (hidden=0)
	who-has 10.0.0.1 tell 10.0.0.100
			      ^^^^^^^^^^

	Where is the problem:

	this ARP probe replaces the entry in the uplink router's
	neighbour cache for VIP. So, the uplink router will send
	the next packets not to the director but to the real server.

	- the right ARP probe (hidden=1)
	who-has 10.0.0.1 tell 10.0.0.3
			      ^^^^^^^^

	This probe replaces only the entry for 10.0.0.3 in the uplink
	router (if any exists). It is unique, so there is no problem.

	What we have done: we announced unique address in our ARP
	probe because we don't want to replace the entry for the
	shared address in the receiver.

These were the events that occur in one cluster with shared addresses.

	About the autoselection. Sometimes it can happen! Addresses
even from lo can be selected as source addresses in the outgoing
connections, for example. Are there any restriction for this?
ppp0 is -arp too, why its addresses can be autoselected? The hidden
flag forbids such addresses to be "autoselected" because you can
raise unexpected problems when creating connections from these
addresses. If the other connection end uses ARP probes to resolve
the shared address our connection will be replied through the
director (the host that advertises the shared address). But the
director does not know anything about this newly initiated connection
and the result is only troubles. If you know what are you doing you
can bind to such address, so the restriction is not fatal (should be
if some "smart" applications walk the list with the addresses and
decide to bind to a shared address).

	Complex enough?

So, the "ARP problem" in environment with shared IP addresses can be
formulated in this way:

- block the ARP replies in the hosts that don't advertise the shared
address (the real servers in the cluster). "There must be only one".

- the same hosts can't announce the shared addresses as source for
the ARP probes

- the same hosts better not to allow selecting shared addresses for
innocent outgoing connections


All possibles setups and the problems are explained in the LVS web site:

http://www.linuxvirtualserver.org/

I will not enter in more details here because, I repeat, the setups
can be very complex. The LVS mailing list is open for such discussions.
I know that the net gurus understand the problem and we can't talk
more on this issue. We have an agreement why the hidden feature can't
go so easy in 2.4 as in 2.2.

> Greetings
> Bernd


Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

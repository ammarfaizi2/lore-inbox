Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310470AbSCBWVO>; Sat, 2 Mar 2002 17:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310471AbSCBWVE>; Sat, 2 Mar 2002 17:21:04 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:2569 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S310470AbSCBWUw>;
	Sat, 2 Mar 2002 17:20:52 -0500
Date: Sun, 3 Mar 2002 00:20:15 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: erich@uruk.org, Szekeres Bela <szekeres@lhsystems.hu>,
        Daniel Gryniewicz <dang@fprintf.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network Security hole (was -> Re: arp bug )
In-Reply-To: <E16hG2i-0008Kq-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0203022217120.7823-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sat, 2 Mar 2002, Alan Cox wrote:

> > 	As for (2) I don't see how this can be remotely
> > exploited but my opinion is that it should be fixed.
>
> "Fixed" ? How do you fix standards compliant behaviour ?

	I still didn't found a good reason to keep any relation
between the iph->saddr and the address announced in the ARP probe.
Announcing the prefsrc should work for any setup while the current
behavior causes some problems for setups with rp_filter protection
and interfaces attached to same hub. If you want to find the reason
for this, here it is:

	By definining local IP and direct route through one device
with rp_filter protection we apply the following policy:

1. we can receive traffic from this directly attached network
only from this device (rp_filter=1)

2. we can receive traffic to our local IPs through all interfaces
where (1) is OK (according to the used different remote source IPs),
i.e. we can receive traffic to this local IP from different
remote hosts, part from different subnets.

	Do you see the assymetry?

	So, here comes the restriction:

	We have restrictions according to the remote IPs in one direction
but don't have them in the reverse one. In short, one local IP
can receive traffic from one remote IP only from one device with
rp_filter protection while at the same time ARP can announce the
local IP through many devices by using different routes (we resolve
different targets with same local IP). Put this on shared medium - the
other end does not know what MAC on what device is in our end.

	The solution:

	Bind the ARP probes strictly to the route, no variations for
the announced IPs, something like to deduce the local_ip that
works for ip route get from target to local_ip iif outdev.
Which local_ip works? Of course, the prefsrc to target is one of
the possibilities.

	Simple/Stupid example where the plain kernel fails:

	Cross-subnet talks (the anti-spoofing is not considered
	a problem), we just want BOX1 to use the both NICs, so
	we use the rp_filter

		    .---eth0 --.   .------eth0-BOX2
		BOX1            HUB
		    `---eth1 --'   `------eth0-BOX3

BOX1:
ifconfig eth0 192.168.0.1, rp_filter on eth0
ifconfig eth1 192.168.1.1, rp_filter on eth1

BOX2:
ifconfig eth0 192.168.0.2

BOX3:
ifconfig eth0 192.168.1.3

	0.2 talks with 0.1 and has 0.1 in its ARP cache.

	Start the first talks from 192.168.0.1 to 192.168.1.3
or from 1.3 to 0.1 and boom, 0.1 is announced through eth1. BOX2
updates its ARP cache with new MAC for 0.1. BOX2 later will send
traffic 0.2->0.1 to the eth1's MAC on BOX1 where the rp_filter
drops it. The stupid app that uses bind() to addr does not work.
The standards don't explain it, right? :) We can
search the word "hub" in RFCs such as: ARP, VRRP. We will
not find this word there. So, that was how comes the problem
with these features when used with many devices attached to
same hub.

	So, what changes the patch:

instead of announcing 0.1 when resolving 1.3 we should announce
1.1 because this is the prefsrc when talking to 1.0/24. We know
that we can send to 1.3 traffic with any local IP but we better
to use the best IP for ARP according to the used device - don't
announce one local IP through many devices attached to same
medium - that is. The problems can come if we use same prefsrc for
routes on different devices but it is not recommended without
adding alternative link routes to the kernel, so there is no
problem with this patch. Uh, long explanation :)

Regards

--
Julian Anastasov <ja@ssi.bg>


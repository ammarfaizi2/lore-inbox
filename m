Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132170AbRAXA14>; Tue, 23 Jan 2001 19:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132168AbRAXA1j>; Tue, 23 Jan 2001 19:27:39 -0500
Received: from tech1.nameservers.com ([216.46.160.19]:35847 "EHLO
	tech1.nameservers.com") by vger.kernel.org with ESMTP
	id <S132006AbRAXA1V>; Tue, 23 Jan 2001 19:27:21 -0500
Message-Id: <200101240027.QAA14665@tech1.nameservers.com>
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>
Subject: Re: Turning off ARP in linux-2.4.0 
In-Reply-To: Your message of "Wed, 24 Jan 2001 01:10:11 +0100."
             <20010124011011.A12252@gruyere.muc.suse.de> 
Date: Tue, 23 Jan 2001 16:27:21 -0800
From: Pete Elton <elton@iqs.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 23, 2001 at 03:50:36PM -0800, Pete Elton wrote:
> The snippet you posted doesn't describe what ClusterThingy exactly wants
> to do with ARPs. 

Well I think the main difference in what you implemented and 
what the cluster server thing is doing (I think) is it sounds
like you can arp on a specific interface, but for the cluster server
software to work, the node cannot arp at all since a separate machine
is acting as a redirector and all incoming request go to that server
first and are then pasted to a node. (how's that for a run on sentence)

Here is what their documentation says about that explicitly.  It appears
just before the other section I quoted:
	Creating an alias has one problem: when another system on the network 
	wants to send a packet to the IP address 10.0.0.99 on the same subnet, 
	it sends an ARP broadcast to determine which computer has that IP address. 
	The machine with that IP address is supposed to answer back with its IP 
	address and corresponding MAC (hardware) address. But if all the nodes 
	in the cluster have the same IP address, they are all going to answer 
	this broadcast ARP message. So we have to tell all of the systems except 
	for the primary ATM not to reply to those ARP requests. We want all 
	traffic destined for the cluster to go through the primary ATM first.

	Part of the solution to this is to create the alias on the loopback 
	interface instead of the Ethernet interface. The loopback interface 
	is a network interface that has no hardware or physical network 
	associated with it. So instead of creating the alias on eth0:1, you 
	would add the alias to the loopback interface (lo) using the following 
	command:

		# ifconfig lo:1 10.0.0.99 netmask 255.255.255.255 up


So in the setup I have, we have an ATM which gets all incoming requests
for the web site.  And then we have 7 other machines that get the
requests passed onto them by the ATM.  So only the ATM can ARP for 
the ip address of the web site.  The 7 other servers cannot.  So for
the 2.2.18 kernel, I have the ipaddress aliased to the lo interface
with the hidden sysctrl option set to 1 and everything works.  When I 
try and bring one of the nodes up on the 2.4.0 kernel, I cannot keep
it from ARPing so it fights with the ATM for all of the traffic and
that causes problems.

I hope that this makes more sense.

Any ideas on how I can turn off the arping?  I guess the thing that I 
am most curious about is how it ending up being removed from the kernel
in the first place.  It must have been a decision that someone made.
Either, we don't need that any more since we can do it this way, or
we'll take it out since nobody uses it.

Pete


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

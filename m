Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131133AbRAYLDW>; Thu, 25 Jan 2001 06:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAYLDF>; Thu, 25 Jan 2001 06:03:05 -0500
Received: from unamed.infotel.bg ([212.39.68.18]:51462 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S129413AbRAYLCn>;
	Thu, 25 Jan 2001 06:02:43 -0500
Date: Thu, 25 Jan 2001 13:02:32 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Bernd Eckenfels <inka-user@lina.inka.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off ARP in linux-2.4.0
Message-ID: <Pine.LNX.4.10.10101251202520.3810-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On 24 Jan 2001, Bernd Eckenfels wrote:

> > Not in Linux 2.2+, all addresses are replied. -arp only
> > means "don't talk ARP", in our case we talk through eth0, so we don't
> > want to stop it, right?
>
> why not? if you hard wire the MAC Address of your web servers to all other
> hosts (i dont asume you have a lot of them on the high speed cluster
> interconnect network, that would defeat the purpose totally). After all, thats
> what /etc/ethers is for (for ages).

	In the uplink router too if you control it. Don't forget one thing.
We are talking about high availability setups where the director is not
one. There are backup servers too. On failover the VIP is moved. And we
can't always control the uplink router. And very often the incoming traffic
is replied through the same router from the real servers.

> > They come/go from/through eth0. We don't use ifconfig eth0 -arp
>
> why not?

	If you don't like ARP and can alter /etc/ethers on you hosts
you are lucky. I know that you can build working setup in this way ...
until something is broken and you have to change the MAC-IP tables
on failover.

> > Run ifconfig eth0 0.0.0.0 up and you will create connections
> > with saddr=shared_address (hidden=0), even when it is configured
> > on loopback device.
>
> Yes, but why dont you simply assign an ip address to eth0? It wont change the
> situation if you turn ARP off. And the answer to an incoming packet will
> always use the destination from the request as the source of the response.
> After all you do not open outgoing connections in the cluster mode.

	Hey, the world is not only Linux. Sometimes the people build
clusters using different hardware and software. If your solution works
for your setup we can't claim it is universal.

> >> Well.. another solution would be to use the ipip system instead of the arp
> >> redirection, right?
>
> > No. Forget about the ARP flag. This is not Linux 2.0. The
>
> I was talking about IPIP targeting instead of MAC targeting as an alternative.

	When you send the IPIP datagram again to real server in the
LAN you have the same problem. If you send it to the end of the world
you don't have problems. I was talking about the 1st case. For which
case your are talking about?

> > hidden flag emulates Linux 2.0. In Linux 2.2+ all addresses are reported,
> > with some exceptions: LOOPBACK and MULTICAST. The device type and
> > its ARP flag are not involved in the decision.
>
> We are talking about Linux 2.4 which has the problem not to support that
> stupid hidden stuff. And it is, as i tried to explain not needed if you can do
> -arp. Hey, this was quoted in the manual in the first post.

	You can't always use -arp!!! Read above. Fix the manual! BTW
in this thread I don't see wrong docs. Which ones claim this?

> > The setup (think about a web cluster):
>
> As i described a few posts ago to andi it works with -arp on eth0 instead of
> hidden (after all the original question was a solution to avoid the missing
> hidden syscall)

	-arp can work if you maintain a fresh copy in /etc/ethers and
when you don't use ARP. But then you don't need to set -arp flag. The
setup will work without setting -arp to lo or eth, right? If you don't
use ARP why to stop it in the interface? In theory we will not see any
ARP packets, even from the uplink router.

> > - the real servers ignore/don't reply when the broadcasted
> > probes are for VIP (hidden=1)
> or they dont replay because arp is turned off... see.. its the same solution

	Here is the problem. If the real servers see broadcast ARP
request for a shared address they reply. The ARP flag can't help you.
Send a patch to the docs you read about this solution. It is not working
in Linux 2.2+. You have to stop the ARP probes for shared addresses in all
uplink routers and in all clients on the LAN that can connect to the
cluster VIP, for example for DataBase healthchecks. You can do it with
/etc/ethers analog or using routes.

> > 2. director forwards (after scheduling) the packet to one of the
> > real servers without changing it (this is not a NAT forwarding method)
>
> it is changing the packets MAC destination address (or using an IPIP tunnel).

	Tunnel to where? To real server in the LAN or to another
real server?

> > - the wrong ARP probe (hidden=0)
> > who-has 10.0.0.1 tell 10.0.0.100
>
> it wont. it has turned arp off and it has the address of 10.0.0.1 in the arp
> table (by /etc/ethers).

	Agreed, if you use /etc/ethers

> > Where is the problem:
>
> There is less problems in my setup than in yours.

	You are lucky to use Linux on all hosts. May be you have one
extra uplink router (a Linux box)?

> > About the autoselection. Sometimes it can happen! Addresses
>
> I dont know which auto selection you arer talking about. A tcp socket will
> auto seect the source address if there was no local bind. In that case it will
> ALWAYS use the local address of the device the route to the target is locked
> at. Normally thats the first address of the ethernet card which is connected
> to the default gateway.

	Don't rely on this. Are you sure how the devices are ordered?
Just add a dummy interface and you will see. Put there a shared address
and the fun begins. But again, this is risky but is not fatal. As you
said, you always have eth0 up. Just don't rmmod it.

> > Complex enough?
>
> i think you make yourself problems.

	This is a solution for most of the users. Others, like you, have
simpler solutions. It depends on the setup. If your setup does not require
the hidden feature, very good. But the other users require it.

> > I will not enter in more details here because, I repeat, the setups
> > can be very complex.
>
> I wonder why they get so complicated in the last few month. Somebody is
> overcomplicating it. And as I said and as you can read on your own web page,

	They are not complicated more in 2.4. The current handling in 2.4
is same. I already said that the net maintainers are planning other
features for 2.4 and the hidden feature is not considered. Until then
there is no difference between the kernels and the hidden feature can
be used even in 2.4.

> IPIP is alays available.

	Read this page again. This method has the same problems:

http://www.linuxvirtualserver.org/arp.html

It is named "ARP problem in LVS/TUN and LVS/DR"

> Greetings
> Bernd

BTW, please CC to me!

Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269549AbRHHVKC>; Wed, 8 Aug 2001 17:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269542AbRHHVJ6>; Wed, 8 Aug 2001 17:09:58 -0400
Received: from imladris.infradead.org ([194.205.184.45]:43785 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S269545AbRHHVJm>;
	Wed, 8 Aug 2001 17:09:42 -0400
Date: Wed, 8 Aug 2001 22:09:37 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
cc: Mark Atwood <mra@pobox.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <200108080841.KAA26569@sunrise.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0108082128250.12565-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej.

 >>> If I build a system with several identical (other than MAC)
 >>> FooCorp PCI ethernics, they will number up in order of
 >>> ascending MAC address.
 >>>
 >>> I take the same system, replace the FooCorp cards with BarInc
 >>> NICs, they will number up in reverse MAC address.
 >>>
 >>> Replace them instead with Baz Systems NICs, and I get them in
 >>> bus scan order (at which point I'm dependent on the firmware
 >>> version of my PCI bridge too!).
 >>>
 >>> And if I elect to use Frob Networking NICs, I instead get them
 >>> in the *random* order that their oncard processors won the race
 >>> to power up.
 >>>
 >>> Gods and demons help me if I try putting several of all four
 >>> brands in one box, or the firmware on my NICs or in my PCI
 >>> bridges changes!

 >> I dealt with this problem in a previous email, but will repeat it
 >> for your benefit. The ONLY provisos I will use are the following
 >> two:
 >>
 >>  1. All ethernet interfaces in your machine have distinct MAC's.
 >>
 >>  2. If the firmware in your NIC's changes, the MAC's do not.
 >>
 >> Providing both of these are met, the enclosed BASH SHELL SCRIPT
 >> implements the `ifconfig` command with the port name replaced by
 >> its MAC address.

 > 1. NFS-root needs to have RARP/NFS servers on eth0.

I have to admit that I've never actually used NFS root, although I
have read documents on it. I also have to say that my understanding
was that it broadcast RARP packets on ALL configured network ports,
and used the lowest numbered one for the rest of the boot process. If
this isn't the case, then the documentation needs to be changed to
reflect what it actually does - or, better still, the behaviour needs
to be changed to match the documentation, as the documented behaviour
would kill this problem completely.

 > How can you deal with it if you have two boards supported by a
 > single driver and, unfortunately, the one you need is detected
 > as eth1 ? Assume that you cannot switch them as they use
 > different media type...

Assuming your claim is correct, then the behaviour needs to be changed
to comform to the documeted behaviour, so this should be reported as a
bug - IMHO, that is.

 >> With this change, it doesn't actually matter what port name a
 >> particular interface is given, because ALL of the other network
 >> config tools refer to the interface by its assigned IP address,
 >> not its port name. As a result, if its port name changes between
 >> boots, the routing automatically changes with it.

 > 2. ipfwadm / ipchains / iptables may use interface names,

I've yet to use iptables, so can't comment on that. With both ipfwadm
and ipchains, the ONLY ports I've ever had reason to explicitly name
have always been either ppp+ to refer to the PPP link across the
modem, or sl0 to refer to the AX.25 link to my ham radio stuff. As a
result, I've never actually experienced a situation that would be
affected by this.

However, it's not hard to write code to translate. How about hw2eth
which is a BASH script to convert from a stated MAC address to the
port that MAC is mapped to:

 Q> ifconfig | grep ^eth | fgrep "HWaddr $1" | cut -d ' ' -f 1

How about ip2eth which is a BASH script to convert from the local IP
address of the port the interface in question maps to to its port
name:

 Q> ifconfig | grep -B1 "inet addr:$1" | grep ^eth | cut -d ' ' -f 1

The other option, route2eth (a program to convert a particular remote
IP address to the port name of the interface we would use to connect
to it) involves analysing the output of `route -n` so would be rather
better suited to a C (or other) compiled program. However, even this
shouldn't be that hard for a competent programmer to produce.

 > 3. dhcpd may need interface names to be provided,

I have to admit that I've never used dhcpd, so am somewhat
disadvantaged here. However, I would imagine that the scripts above
would provide the necessary translations.

 > 4. you may want to pass an interface name argument to tcpdump.

Whenever I use tcpdump on a system with multiple NIC's, I always have
to use `ifconfig` to remember which interface attaches to which
network, and then use the interface determined from that. I would
assume that others would tend to do the same, and in this case, this
problem case vanishes.

Even if this wasn't the case, the scripts above should help to
minimise the problems.

 > In 2.2+ you can deal with 2.-4. changing interface names using
 > ip from iproute2. But I doubt whether ifconfig based scripts
 > would work properly then.

You shouldn't need to fudge the issue like that anyway, and if you do,
then the various tools need to be redesigned to provide simple ways
round the problem.

 > And problem 1. is still valid ...

So is the solution above.

Best wishes from Riley.


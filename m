Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315357AbSDWWVu>; Tue, 23 Apr 2002 18:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSDWWVt>; Tue, 23 Apr 2002 18:21:49 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35595 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315357AbSDWWVs>; Tue, 23 Apr 2002 18:21:48 -0400
Date: Tue, 23 Apr 2002 18:18:21 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Frank Louwers <frank@openminds.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
In-Reply-To: <20020423113935.A30329@openminds.be>
Message-ID: <Pine.LNX.3.96.1020423181523.31248A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2002, Frank Louwers wrote:

> We recently stummed across a rather annoying bug when 2 nics are on
> the same network.
> 
> Our situation is this: we have a server with 2 nics, each with a
> different IP on the same network, connected to the same switch. Let's
> assume eth0 has ip 1.2.3.1 and eth1 has 1.2.3.2, with a both with a
> netmask of 255.255.255.0.
> 
> Now the strange thing is that traffic for 1.2.3.2 arrives at eth0 no
> matter what!
> 
> Even if we disconnect the cable for eth1, 1.2.3.2 still replies to
> pings, ssh, web, ...
> 
> We tested this on IA32 architecture, different 2.4.x kernels and
> different nics ...
> 
> Is this a bug or a known issue? If it is not a bug, how can it be
> solved?

Let me say that this is not a kernel question, but a networking
question, there's no bug, you just have several configuration issues.
However, having been beaten to death and the corpe dragged through the
street, hopefully this might help.

The primary issue is that you are responding to arp and sending out the
wrong MAC address. Don't wait for the router to ask, tell it where the
MAC is for that IP.

  ifconfig eth0 10.8.0.5
  ifconfig eth1 10.8.0.6
  route add www.favorite.com dev eth1
  ping -c2 www.favorite.com

The last two lines are the charm... force the route to any host which
goes via the router to use the "other" IP address. Good, now the router
knows that the IP amd MAC belong together. BTW: if you do an IP takeover
(add an alias IP for a server which fails) you also want to do this, or
the router will send packets to the old MAC until the ARP tables
timeout.

This takes care of incoming connections, the traffic should go to the
right NIC and be sent back through the right NIC. To balance outgoing
connections you can try this instead of defining a default route:

  route add -net 0.0.0.0 netmask 0.0.0.1 dev eth0
  route add -net 0.0.0.1 netmask 0.0.0.1 dev eth1

which used to work to send odd IP destinations out one NIC and even out
the other. If that fails and you care, just get iproute2 and claw your
way up the learning curve.

If you just want to use this for backup, when the machine detects that
the NIC has failed (blessedly unusual, I have 15 dual NIC machines in
four timezones) it can just ifconfig the first down, the second up, and
send out a ping, or better yet use one which allows the MAC address to
be set.

Some of this should get you going, or at least looking in the right
place.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130347AbRCCGET>; Sat, 3 Mar 2001 01:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130419AbRCCGEJ>; Sat, 3 Mar 2001 01:04:09 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:44094 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130347AbRCCGDz>; Sat, 3 Mar 2001 01:03:55 -0500
Message-ID: <3AA08903.9050602@blue-labs.org>
Date: Fri, 02 Mar 2001 22:02:43 -0800
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac3 i686; en-US; 0.9) Gecko/20010302
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Linux Advanced Routing and Trafic Control <lartc@mailman.ds9a.nl>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [LARTC] 1 adsl + 1 sdsl + masq + simultaneous incomming routes]
In-Reply-To: <3AA06720.77D94BFE@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
>>> The problem: I am able to have the web server use one or the other dsl, but not
>>> both at the same time.
>>> 
>>> If I have web set to sdsl, replies to queries that came from adsl go out on the
>>> sdsl link. Also since masq is involved, it also responds with the sdsl ip.
>>> 
>>> How can I have replies go back on the correct internet link?  OH, btw, the web
>>> server is NT, so I won't be able to modify any packets there...
>> 
>> What I've done is to put two IPs on the server (your web server, in this
>> case). You would then have the gateway send one IP out via ADSL, and the
>> out via SDSL.
> 
> There has to be a better way.  I'm forwarding this to LKML.  Maybe they have a
> better idea...
> 
> I know the kernel keeps a route cache, is there something like a reverse MASQ
> feature somewhere.  Storing which incoming route + port number and keeping a
> dynamic list...


It all looks very easy if the web server has two IPs.  Making it simple, 
use the following example after modifying the necessary information:

Web server public IPs: 99.0.0.5/32(ADSL), 100.0.0.5/32(SDSL), and set 
default via 10.0.0.1
Gateway: 10.0.0.1 on all interfaces, no default unless you choose to 
have one
ADSL: 99.0.0.1/24, SDSL: 100.0.0.1/24

Routing setup on web server is to point to the default gateway, nothing 
special needed.
Routing on *DSL isn't under your control.
All control is handled on the gateway. (web/eth2, SDSL/eth1, ADSL/eth0)

Gateway:
(establish interfaces)
ip a a 10.0.0.1/32 brd + dev eth0; ip link set eth0 up
ip a a 10.0.0.1/32 brd + dev eth1; ip link set eth1 up
ip a a 10.0.0.1/32 brd + dev eth2; ip link set eth2 up

(add routing for the web server IPs - inbound traffic)
ip route add 99.0.0.5 dev eth2
ip route add 100.0.0.5 dev eth2

(make packet matching rules, tie them to given tables)
ip rule add from 99.0.0.5/32 to 0.0.0.0/0 table 99 prio 99
ip rule add from 100.0.0.5/32 to 0.0.0.0/0 table 100 prio 100

(add the routing based on the table - outbound traffic)
ip route add via 99.0.0.1 table 99 dev eth0 onlink
ip route add via 100.0.0.1 table 100 dev eth1 onlink

This is off the top of my head but it should work fine.

Of course if the *DSL arrives on the gateway via a hub, simply combine 
the interfaces as appropriate.

-d
p.s. those in the know, feel free to correct me


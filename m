Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUAZNjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 08:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUAZNjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 08:39:13 -0500
Received: from mail.cyberus.ca ([209.197.145.21]:30182 "EHLO mail.cyberus.ca")
	by vger.kernel.org with ESMTP id S262355AbUAZNjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 08:39:07 -0500
Subject: Re: [RFC/PATCH] IMQ port to 2.6
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20040126093230.GA17811@usr.lcm.msu.ru>
References: <20040125152419.GA3208@penguin.localdomain>
	 <20040125164431.GA31548@louise.pinerecords.com>
	 <1075058539.1747.92.camel@jzny.localdomain>
	 <20040125202148.GA10599@usr.lcm.msu.ru>
	 <1075074316.1747.115.camel@jzny.localdomain>
	 <20040126001102.GA12303@usr.lcm.msu.ru>
	 <1075086588.1732.221.camel@jzny.localdomain>
	 <20040126093230.GA17811@usr.lcm.msu.ru>
Content-Type: text/plain
Organization: jamalopolis
Message-Id: <1075124312.1732.292.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Jan 2004 08:38:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-26 at 04:32, Vladimir B. Savkin wrote:

> On Sun, Jan 25, 2004 at 10:09:48PM -0500, jamal wrote:
[..]
> > shape). I have not seen anything in favor of shaping; i could be wrong
> > (so if you know of something or have experimented pass the data).
> 
> Yes, I have experimented. Shaping works much better:
> much less packets dropped, much better donwload rates for clients.
> 

I cant say i doubt you, but your word alone is insufficient data ;->

The important point is the eventual effective throughput and fairness
amongst the flows. Whether it is induced by an increased RTT from
shaping or a single packet retransmit on some misbehaving flows because
of policing is less important. i.e it is not evil for packets to
be dropped.
When you analyse something like this you should look at the aggregate
throughput instead of a single client with better downloads (probably at
the expense of another poor client download).

> I want to shape traffic that comes from upstream to clients connected
> via PPTP.

So if i understand correctly and was to draw this: 
you have clients on the left side coming in through ethx and that need
to be tunneled to some pppoe/pptp before going out ethy on the right
hand side. The right handside represents "upstream" in your terminology.
Is this correct? I hate it when people ask me for a diagram for
something that looks obvious;-> but bear with me and supply me with a
diagram if i didnt understand you.

> 
> Here is a part of my scripts:
> 
> DEVICE=imq0
> /sbin/tc qidisc add dev $DEVICE root handle 10: htb r2q 1 default 100
> /sbin/tc class add dev $DEVICE parent 10:0 classid 10:1 est 1sec 8sec htb \
>         rate 10Mbit burst 400k
> /sbin/tc class add dev $DEVICE parent 10:1 classid 10:2 est 1sec 8sec htb \
>         rate 180kbps ceil 180kbps burst 3000
> # default class for users
> /sbin/tc class add dev $DEVICE parent 10:2 classid 10:101 est 1sec 8sec htb \
>         rate 20kbps burst 1k ceil 50kbps cburst 1k
> /sbin/tc qdisc add dev $DEVICE parent 10:101 wrr \
>         dest ip 128 1 wmode1=1 wmode2=1
> /sbin/tc filter add dev $DEVICE protocol ip parent 10:0 \
>         prio 100 handle 1 fw flowid 10:101
> # more classes to follow ...
> 

So why not have the above attached to ethy? Why does it have to be done
at some other device?

> 
> The limit 50kbps is artificial, so there's no bottleneck in
> connection from upstream to this router. I cannot allocate all
> the channel bandwidth to clients for some political reasons.
> Then, I mark packets I want to go to this default user class with mark "1",
> like this:
> 
> iptables -t mangle -A FORWARD -i $UPLINK_DEV -d $CLIENTS_NET \
> 	-j IMQ --todev 0 # traffic from internet to clients
> iptables -t mangle -A FORWARD -i $UPLINK_DEV -d $CLIENTS_NET \
> 	-j MARK --set-mark 1 # default class


Why do you need the redirect to IMQ?
If you can selectively mark packets here (or at any other netfilter
hook) you could use the fwmark classifier to attach to different
10:x classes on the ethy interface. I feel i am missing something.

> So, I shape traffic destined to clients, and I use "wrr" to
> divide bandwidth fairly. I cannot attach qdisc to an egress device
> because there's no single one, each client has its own ppp interface.
> 

I mean the ethy interface not the ppp* interfaces. Mark the packets;
use fwmark classifier.

> Well, I could move this shaping upstream, but what if upstream router was
> some dumb cisco with no "wrr" qdisc? 

You dont have to.
Give me the diagram.

cheers,
jamal


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUAZJcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 04:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUAZJcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 04:32:42 -0500
Received: from usr.lcm.msu.ru ([193.232.113.217]:56015 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S261411AbUAZJck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 04:32:40 -0500
Date: Mon, 26 Jan 2004 12:32:30 +0300
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC/PATCH] IMQ port to 2.6
Message-ID: <20040126093230.GA17811@usr.lcm.msu.ru>
References: <20040125152419.GA3208@penguin.localdomain> <20040125164431.GA31548@louise.pinerecords.com> <1075058539.1747.92.camel@jzny.localdomain> <20040125202148.GA10599@usr.lcm.msu.ru> <1075074316.1747.115.camel@jzny.localdomain> <20040126001102.GA12303@usr.lcm.msu.ru> <1075086588.1732.221.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1075086588.1732.221.camel@jzny.localdomain>
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.4.24
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 10:09:48PM -0500, jamal wrote:
> On Sun, 2004-01-25 at 19:11, Vladimir B. Savkin wrote:
> > On Sun, Jan 25, 2004 at 06:45:16PM -0500, jamal wrote:
> [..]
> > 
> > With typical internet traffic patterns, policing will drop many packets,
> > and shaping will not.
> 
> What is typical internet traffic? I guess you mean TCP (thats what 90%
> of the traffic is)
> In that case, the effect of dropping or delaying on throughput is
> similar. Studies i have seen indicate that throughput is directly
> proportional to the square root of the drop probability
> (drop is what you get when you police).
> It is also influenced by the delay (which is what you introduce when you
> shape). I have not seen anything in favor of shaping; i could be wrong
> (so if you know of something or have experimented pass the data).

Yes, I have experimented. Shaping works much better:
much less packets dropped, much better donwload rates for clients.

> For detailed analysis at least fro RENO, this would be a good reference:
> http://citeseer.nj.nec.com/padhye98modeling.html
> 
[snip]
> Maybe i am misunderstanding what you are after.
> couldnt you use -i ppp+ -j mark --set-mark x in the ingress/prerouting
> and use the fwmark to shape on the egress?
> Post your script examples. 
> 

I want to shape traffic that comes from upstream to clients connected
via PPTP.

Here is a part of my scripts:

DEVICE=imq0
/sbin/tc qidisc add dev $DEVICE root handle 10: htb r2q 1 default 100
/sbin/tc class add dev $DEVICE parent 10:0 classid 10:1 est 1sec 8sec htb \
        rate 10Mbit burst 400k
/sbin/tc class add dev $DEVICE parent 10:1 classid 10:2 est 1sec 8sec htb \
        rate 180kbps ceil 180kbps burst 3000
# default class for users
/sbin/tc class add dev $DEVICE parent 10:2 classid 10:101 est 1sec 8sec htb \
        rate 20kbps burst 1k ceil 50kbps cburst 1k
/sbin/tc qdisc add dev $DEVICE parent 10:101 wrr \
        dest ip 128 1 wmode1=1 wmode2=1
/sbin/tc filter add dev $DEVICE protocol ip parent 10:0 \
        prio 100 handle 1 fw flowid 10:101
# more classes to follow ...


The limit 50kbps is artificial, so there's no bottleneck in
connection from upstream to this router. I cannot allocate all
the channel bandwidth to clients for some political reasons.
Then, I mark packets I want to go to this default user class with mark "1",
like this:

iptables -t mangle -A FORWARD -i $UPLINK_DEV -d $CLIENTS_NET \
	-j IMQ --todev 0 # traffic from internet to clients
iptables -t mangle -A FORWARD -i $UPLINK_DEV -d $CLIENTS_NET \
	-j MARK --set-mark 1 # default class
# here I can change fwmark for packets that deserve 
# some special treatment

So, I shape traffic destined to clients, and I use "wrr" to
divide bandwidth fairly. I cannot attach qdisc to an egress device
because there's no single one, each client has its own ppp interface.

Well, I could move this shaping upstream, but what if upstream router was
some dumb cisco with no "wrr" qdisc? 


~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 


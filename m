Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275734AbRJQMKG>; Wed, 17 Oct 2001 08:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275758AbRJQMJ5>; Wed, 17 Oct 2001 08:09:57 -0400
Received: from zero.aec.at ([195.3.98.22]:42766 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S275734AbRJQMJk>;
	Wed, 17 Oct 2001 08:09:40 -0400
To: Katsuyuki Yumoto <yumoto@jpn.hp.com>
cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: New virtual ethernet driver submitting...
In-Reply-To: <200110170417.f9H4H9g23739@hpujffg8.jpn.hp.com>
From: Andi Kleen <ak@muc.de>
Date: 17 Oct 2001 14:10:11 +0200
In-Reply-To: Katsuyuki Yumoto's message of "Wed, 17 Oct 2001 13:17:09 +0900"
Message-ID: <k2k7xuii1o.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200110170417.f9H4H9g23739@hpujffg8.jpn.hp.com>,
Katsuyuki Yumoto <yumoto@jpn.hp.com> writes:
>>>>>> "David" == David S Miller <davem@redhat.com> writes:

>> From: Katsuyuki Yumoto <yumoto@jpn.hp.com>
>> Date: Wed, 17 Oct 2001 11:47:07 +0900
   
>> I've already written new two drivers of virtual ethernet. These
>> aggregate(bundle) plural physical or virtual ethernet devices to
>> single.

>> How is this different to, or more beneficial than, what
>> drivers/net/bonding.c is doing?

> Yes. I think what to want to do is same between bonding.c and veth
> (link aggregation).  But veth has link aggretation maintenance
> functionality(LACP) and TCP/UDP port number based distributing
> algorithm. Of course, such things are optional features...

This is the fifth link bundling implementation for linux now
(TEQL, bonding, EQL, multipath routing are all in tree and do similar things)

TEQL, EQL do not know about streams, so they're not too useful. There
are some patches for the bonding device to add probalistic stream balancing,
which will likely make it equivalent to your code.

I personally prefer the fourth because it is the cleanest and most flexible.

> On the other hand, purpose of lr(link redundancy) is different of
> yours and veth. It's a new link redundant technology rather than
> aggregation.

> By the way, it seems that your code don't have incoming packet handler
> code, right? My drivers contains packet handler for incoming
> packets. If your incoming packet handling method is better than mine,
> I'd like to follow it. (I'm not sure its method yet.)

multipath routing supports load balancing for incoming connections using
the arp filter. Basically it'll filter arp responses based on the outgoing
filter and this leads to an automatic distribution of incoming traffic.

It distributes routes (IP<->IP,TOS) pairs, not L3 streams however; but that
seems to be sufficient for most usages. It's also very easy to do 802.3ad on 
top of it.

If you wanted to do it for streams I think it would be better to use
the existing infrastructure for it -- this is netfilter connection
tracking -- and make it generate multiple routes.
It also provides failover BTW with some support from user space (e.g. an
OSPF daemon) 

-Andi


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSLFKmR>; Fri, 6 Dec 2002 05:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSLFKmR>; Fri, 6 Dec 2002 05:42:17 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:11229 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S262303AbSLFKmP>; Fri, 6 Dec 2002 05:42:15 -0500
Date: Fri, 06 Dec 2002 22:06:07 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Ben Greear <greearb@candelatech.com>, root@chaos.analogic.com
cc: Tomas Szepe <szepe@pinerecords.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ipv4: how to choose src ip?
Message-ID: <44180000.1039165567@localhost.localdomain>
In-Reply-To: <3DF026A4.5010801@candelatech.com>
References: <Pine.LNX.3.95.1021205152058.18105A-100000@chaos.analogic.com>
 <3DF026A4.5010801@candelatech.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, December 05, 2002 20:25:08 -0800 Ben Greear 
<greearb@candelatech.com> wrote:

> Richard B. Johnson wrote:
>> On Thu, 5 Dec 2002, Tomas Szepe wrote:
>
>>> I'm not interested in rewriting the source address with netfilter based
>>> on destination and/or service;  What I'm looking for is rather a way to
>>> initiate two connections to the same destination host using the two
>>> different source IP addresses.
>>>
>>
>>
>> The simple answer is that if you need a specific IP address
>> associated with a "multi-honed" host, that has only one interface,
>> then something is broken. And you get to keep the pieces.

Not always so.  I'm writing an app (userspace HIP, see www.hip4inter.net) 
that needs this too.  And it would be nice if there were a simple way to do 
it.  VoIP apps need this sometimes too.

>> The IP addresses assigned to a multi-honed host are the addresses
>> to which it will respond during ARP. The ARP (Address Resolution
>> Protocol) you remember, is the protocol used to get the "hardware"
>> or IEEE station address of the interface.
>>
>> Any IP protocol will properly work with any IP address embedded in
>> the packet from the interface that responded to the ARP.

Um. No, this isn't right.  The interface in question could be PPP, or 
something wierd like IP over FireWire, neither of which do ARP.  ARP is 
specifically for IPv4 over ethernet or something which emulates ethernet. 
IPv6 doesn't use ARP even on ethernet, yet source address selection is even 
more important in that case.  Nearly every IPv6 application will need to do 
it, or trust the kernel to do it right.  Random is not an option.

And applications *do not* necessarily work with any old address in the 
header; otherwise NAT would never be a problem.

>> However, the IP address inside the data-gram will usually be
>> the IP address of the interface that first sent that packet.
>> The IP address used is the address of the interface that met
>> the necessary criteria for getting the data-gram onto the wire.
>> In other words, the net-mask and the network address are the
>> determining factors. If you have two or more IP addresses that
>> are capable of putting the data-gram on the wire, the first one,
>> i.e., the address used to initialize the interface first, will
>> be the one that is used in out-going packets.

This just describes the usual behaviour of unix-like systems.  But the most 
recently configured address would be just as correct a default.

> You may be able to influence this with policy-based routing and
> the arp-filter code.

You can select what you want this way, yes.  But there should be a way to 
select source addresses from among those already configured without having 
to have the ability to change the routing table or firewall rules!  Hence:

> You certainly can bind to a specific IP and/or port when initiating
> a connection.  You can use the local IP to do source-based routing.

> I have not done exactly the thing described here, but I have done
> similar things, certainly binding to ports & ips on both server
> and initiator side of an IP connection.
>
>
>> There is no RightWay(tm) because any attempt to choose a specific
>> IP to on the wire from a machine that has only one interface, but
>> is multi-honed, is broken at the start. However, you can chose where
>
> I think you presume too much about what other people might consider
> broken or not. :)

What's more, the specs actually say otherwise.  That's something you MUST 
be able to do (see the sockets API RFC).  And in IPv6 sometimes only the 
application can know what to do.

Andrew



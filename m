Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290001AbSAKQ3V>; Fri, 11 Jan 2002 11:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290002AbSAKQ3M>; Fri, 11 Jan 2002 11:29:12 -0500
Received: from pilot15.cl.msu.edu ([35.9.5.35]:41165 "EHLO pilot15.cl.msu.edu")
	by vger.kernel.org with ESMTP id <S290001AbSAKQ3F>;
	Fri, 11 Jan 2002 11:29:05 -0500
Reply-To: <zhengpei@msu.edu>
From: "Pei Zheng" <zhengpei@pilot.msu.edu>
To: <timothy.covell@ashavan.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: strange kernel message when hacking the NIC driver
Date: Fri, 11 Jan 2002 11:33:06 -0800
Message-ID: <NFBBKBJCMLCOCPOBGFECKEKNCCAA.zhengpei@pilot.msu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <200201110524.g0B5OeSr000566@svr3.applink.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply. Sorry for bring confusion.
Let me clarify what I am trying to do. I am now using same MAC for two NICs.
Each NIC has a unique MAC in the context of my work.

To put it simple, routing simulation,ie.
to simulate(or emulate) 2 "routers" in one kernel. For example, 6 NICs exist
on a machine, 3 of them(eth1-eth3) consist "router A", the others(eth4-eth6)
"router B". Each router has a routing table associated with it. We are
trying to
set a route like entering eth1->kernel->out from eth2->ethernet switch->back
to eth4->kernel->out from eth5. We cannot setup a route directly like this
because the kernel will not send out packets whose nexthop is one of its
network
interfaces. So "ip route add from host_a to host_b via ip_of_eth4 dev eth2"
does
not work, packets never get out of the box before sending out from eth5.

Using iproutes, we can configure that packets entering eth1 is routed to
sending out from eth2 in "router A", and packets entering eth4 is routed to
sending out from eth5 in "router B". No next hop is specified here. Now
packets entering the box through eth2 first go through "router A", then
physically
get out of the box from eth2. We need to redirect them back to eth4 to go
through "router B".  That is why I forcibly modify each packet's ethernet
frame
header and change the destination MAC addr to be the other end of NIC of
the link. For example, the dest_MAC_addr of a packet sending out from eth2
is set to MAC of eth4. This hack works. We can see packets come and go
like what we want. But I got some errors in system log like what i post
before.
It seems to be that some of the packets are "wrong" from the kernel's point
of view.

Please correct me if i misunderstand some points of ethernet, the kernel
and IP stack. Any comment to this approach, and how to do "router simulation
in one kernel" are highly appreciated. Thank you!

-Pei

> -----Original Message-----
> From: Timothy Covell [mailto:timothy.covell@ashavan.org]
> Sent: Thursday, January 10, 2002 9:21 PM
> To: Pei Zheng; linux-kernel@vger.kernel.org
> Subject: Re: strange kernel message when hacking the NIC driver
>
>
> On Thursday 10 January 2002 22:19, Pei Zheng wrote:
> > Hi,
> >
> > I've done some simple hackings to the network device driver. Basically
> > i want to connect two NICs as a point-to-point link,ie, packets sending
> > out from one NIC will be redirected to another NIC, sort of direct-link
> > cable between these two NICs.
> > So in the drivers of these two NICs, before hart_start_xmit(), the skb's
> > header will be forcibly set to its peer's MAC address, thus each packey
> > sending out from one NIC will be directly diverted to its peer NIC. This
> > works fine most of the case since tcpdump shows that packets traverse in
> > this way. However, i found errors in system log:
> >
> > Jan 10 18:02:40 em2 kernel: 1130: 09 => cb
> > Jan 10 18:02:40 em2 kernel: 388: f4 => 45
> > Jan 10 18:02:40 em2 kernel: 26: c0 => 7d
> > Jan 10 18:02:40 em2 kernel: 149: 1f => 98
> > Jan 10 18:02:40 em2 kernel: After error applied:
> > Jan 10 18:02:40 em2 kernel: 00 80 c8 b9 6b b6 00 80 c8 b9 6b b6 08 00
> > 45 00
> > Jan 10 18:02:40 em2 kernel: 05 dc 73 cd 20 b9 3f 11 44 26 7d a8 0c 0a
> > c0 a8
> > Jan 10 18:02:40 em2 kernel: 10 0a e3 c1 4c 1f 6f 83 61 dc fc 5e 5c f4
> > 66 17
> > Jan 10 18:02:40 em2 kernel: 2c 73 19 ce cc 2d 69 69 bd 43 33 6d 82 de
> > 4a 87
> > Jan 10 18:02:40 em2 kernel: 8d 9d 81 f6 2e b2 8c 6a d5 e4 f2 e6 bc ab
> > 5a 01
> > Jan 10 18:02:40 em2 kernel: 34 d5 39 f8 d9 5b 16 bc dc 95 bd b4 08 a9
> > 5e 11
> > Jan 10 18:02:40 em2 kernel: df 38 80 8a ca d8 1c 53 65 97 91 4c 84 5a
> > a1 0e
> > Jan 10 18:02:40 em2 kernel: c2 5f d4 02 a1 9e 1c 35 d4 95 08 44 81 16
> > a3 e0
> >
> > there are many this kind of messages. Don't understand what it is. the
> > beginning part of the data seems to be an icmp packet(00 80 c8 b9 6b
> > b6 is the MAC of one NIC). For some reason kernel thinks that this
> > packet is not correct. Any idea about this? If i want to modify a
> > packet's header before it goes to hard_strat_xmit(), what else should
> > i do except setting the skb header to the MAC of the NIC's peer only?
> > checksum stuff?
> >
> > Any helps will be highly appreciated.
> >
> > -Pei
>
>
> You have me confused about whether your trying to build some kind of
> ethernet bridge or some kind of secret packet sniffer or some other
> such thing.   It looks like you're mixing up TCP/IP and Ethernet.
>
> Ethernet is the link level protocol that addresses NICs by the MAC
> address.    There can only be one NIC on the network with the same
> MAC address.   TCP/IP uses IP addresses, not MAC addresses.  And you
> cannot have two IP addresses on the same link if they have the same
> network and broadcast address unless you do multipathing.
>
>
> I guess that I don't understand what you are trying to achieve.
>
>
>
> --
> timothy.covell@ashavan.org.


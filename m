Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSGPTcR>; Tue, 16 Jul 2002 15:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317948AbSGPTcQ>; Tue, 16 Jul 2002 15:32:16 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:25860 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S317947AbSGPTcP>;
	Tue, 16 Jul 2002 15:32:15 -0400
Date: Tue, 16 Jul 2002 22:32:43 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Bill Davidsen <davidsen@tmr.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
Message-ID: <Pine.LNX.4.44.0207162148040.1484-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Bill Davidsen wrote:

> Um, many people who are being probed from the Internet would like very
> much to NOT have it there, certainly by default. And would like to send an
> arp request and in return get a valid mac address.

	It seems you don't like the way ARP is replied in Linux. But
note that ARP follows IP, i.e. Linux replies on each device where it
is willing to accept IP for the same path. Such behaviour is caused by
the way IP is set by default in RFC1812: Source Address Validation
is disabled (rp_filter=0).

> I totally miss why anyone would consider this behaviouracceptable, much
> less desirable. Perhaps you or someone could explain why either accepting
> source routing or sending out invalid arp responses are desirable at all,
> much less as default behaviour. One is a security hole, the other brings
> the network group to the door with arpwatch output.

	What security, you are running without rp_filter set. Set it
and your Linux box will reply only through one interface without
using arp_filter.

> After some hours of reading the google results I see lots of questions, a
> few dubious workarounds, and zero people claiming that it's a good thing
> to work that way.

	Why? Do += 1 for me. What is wrong? In the URL I posted
you can find many solutions that additionally allow tuning of the
ARP behaviour because such fine grained control is used for
different setups. What was last discussed about the ARP and
rp_filter can stick in the following list of recommendations:

- use arp_filter=0 and rp_filter=0 where you don't care what
devices are used for the ARP/IP traffic. The DEFAULT behaviour!

- use arp_filter=1 and rp_filter=0 where you prefer each subnet
to use one interface but the IP traffic still can use many
devices (very useful for cross-subnet talks)

- use arp_filter=1 and rp_filter=1 where you want to restrict
both ARP and IP to same interface. This can break cross-subnet
talks if used. Here rp_filter=1 overrides the arp_filter
value.

- use arp_filter=1, rp_filter=1 and tune the rp_filter to
know about where each device is attached (you can see my
unofficial patch named "rp_filter_mask"). Such setting gives
you the ability to attach multiple interfaces to one hub and
to treat these interfaces as attached to "same security zone".
It is extension to rp_filter, we are not restricted to allow
traffic from one device. By this way you can use safely
rp_filter=1 for all devices attached to this hub and still to
allow cross-subnet talks when using these devices. This is the
difference from the previous example, i.e. arp_filter RECOMMENDS
each subnet to use one device but still to allow secure talks
for IP between hosts from different subnets.

Hope that answers much of your questions regarding Linux ARP.
If you still want to learn more about Linux ARP please switch
to linux-net or linux-netdev mlist.

Regards

--
Julian Anastasov <ja@ssi.bg>


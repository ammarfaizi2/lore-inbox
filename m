Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132625AbRDQONf>; Tue, 17 Apr 2001 10:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132655AbRDQON0>; Tue, 17 Apr 2001 10:13:26 -0400
Received: from netsonic.fi ([194.29.192.20]:46346 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id <S132625AbRDQONR>;
	Tue, 17 Apr 2001 10:13:17 -0400
Date: Tue, 17 Apr 2001 17:12:46 +0300 (EEST)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-net@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zebra@zebra.org>
cc: Eric Weigle <ehw@lanl.gov>,
        "Bingner Sam J. Contractor RSIS" <Sam.Bingner@hickam.af.mil>
Subject: Broken ARP (was Re: ARP responses broken!)
In-Reply-To: <3ADB637B.13E4F1AD@lanl.gov>
Message-ID: <Pine.LNX.4.33.0104171649480.21178-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2001, Eric Weigle wrote:

> Hello-
>
> This is a known 'feature' of the Linux kernel, and can help with load sharing
> and fault tolerance. However, it can also cause problems (such as when one nic
> in a multi-nic machine fails and you don't know right away).

I tought this for a while and this does not help load sharing neighter or
fault tolerance. Causes problem with router environment. I use different
cards to load the problem by assigning different addresses to these and by
pointing these addresses with routes so I use the IP to mark a device.

Only case where this would help with "fault tolerance" is if I
assign address to other device that is not marked as up, it would still
be possible to see the address via other device, and this goes way off.

> There are three 'solutions' I know of:
>
>   * In recent 2.2 kernels, it was possible to fix this by doing the following as
>     but 2.4 doesn't have that option, for technical reasons.

I don't see good valid reasons, I implemented this by myself to the kernel
with  very little effort, only thing is that my patch makes it not
possible to have the same address on multible interfaces, this is
altought very easy to fix. FIB code lacks a way to detect if there are
multible interfaces for a single IP.

>    * Use 'ifconfig -arp ...' to force an interface not to respond to ARP
> requests. Hosts which want to send to that interface may need to manually add
> the proper mac address to their ARP tables with 'arp -s'.

Manual ARP, uh, sounds as nasty as can be.

>    * Use a packet filtering tool (iptables arp filter module, for example) and
> just filter the ARP requests and ARP replies so that only the proper set get
> through, i.e. when an arp request for the mac address of an interface arrives,
> filter out arp replies from all the other interfaces.

There is no ARP module for netfilter and this is such low level issue that
would see requires another way to be solved by all means.

It is not working correctly if there are two ARP replies for a ARP query,
another one from interface that DOES NOT have the address assigned to it.
Basically I should have a firewall rule that would instantly DROP all
packets that come to the interface with address that it does not have if I
don't have forwarding enabled.

> There have been a few threads on this on the linux-kernel mailing list. Search
> your favorite archive for them.

Well, this is not solved so we probaply need one more.

The code I used to do the trick at my network was as simple as this,
in function arp_rcv, the problem is ip_dev_find that does know if there
are other devices with same IP address.

--- job/arp.c   Tue Apr 17 17:05:48 2001
+++ arp.c       Tue Apr 17 17:05:24 2001
@@ -571,6 +571,7 @@
        int addr_type;
        struct in_device *in_dev = in_dev_get(dev);
        struct neighbour *n;
+       struct net_device *devx = NULL;

 /*
  *     The hardware length of the packet should match the hardware length
@@ -728,8 +729,10 @@

                rt = (struct rtable*)skb->dst;
                addr_type = rt->rt_type;

-               if (addr_type == RTN_LOCAL) {
+               devx = ip_dev_find(tip);
+               if (addr_type == RTN_LOCAL &&
+                   devx == dev) {
                        n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
                        if (n) {
                                arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);


 - Sampsa Ranta
   sampsa@netsonic.fi



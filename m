Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbTAJOZw>; Fri, 10 Jan 2003 09:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbTAJOZw>; Fri, 10 Jan 2003 09:25:52 -0500
Received: from cnxt10002.conexant.com ([198.62.10.2]:18522 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S265177AbTAJOZu>; Fri, 10 Jan 2003 09:25:50 -0500
Date: Fri, 10 Jan 2003 15:34:29 +0100 (CET)
From: Rui Sousa <rui.sousa@laposte.net>
X-X-Sender: rsousa@sophia-sousar2.nice.mindspeed.com
To: Joshua Stewart <joshua.stewart@comcast.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux network development <netdev@oss.sgi.com>
Subject: Re: Pushing a stray sk_buff to the NIC
In-Reply-To: <1042161058.6107.18.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301101512140.2312-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003, Joshua Stewart wrote:

Hi,

> I'm trying to take "hand-built" sk_buffs with little more than some data
> and a dev member and push them to the NIC for transmission.  I would
> like to simply give them to dev_queue_xmit.  Does anybody know what
> state I should have them in before handing them to dev_queue_xmit? 

In a driver I wrote I setup (for a newly allocated skb and a 2.4 kernel):

	some_header = (struct some_header *) skb_push(skb, sizeof(struct some_header));

	skb->nh.raw = (unsigned char *) some_header;

	this_eth_hdr = (struct ethhdr *) skb_push(skb, ETH_HLEN);

	this_eth_hdr->h_proto = __constant_htons(ETH_P_SOME_HEADER);
	memcpy(this_eth_hdr->h_source, dev->dev_addr, ETH_ALEN);

	skb->dev = dev;
        skb->protocol = __constant_htons(ETH_P_CSM_ENCAPS);

	dev_queue_xmit(skb);

where some_header for you is probably an IP header and dev is the "struct 
net_device" of the device you are using to send the packet out on the 
wire.

> Should skb->data point to the start of a MAC header or an IP header?

MAC
 
> Also, given an IP address in skb->nh.iph->daddr, what's the easiest way
> to get the appropriate MAC address?

First you need to get the device, then the MAC address is easy. This 
should be what normal IP routing code does...

> J
> 
> 

Rui

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVCQRQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVCQRQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 12:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVCQRQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 12:16:18 -0500
Received: from moritz.faps.uni-erlangen.de ([131.188.113.15]:32716 "EHLO
	moritz.faps.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261973AbVCQRQK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 12:16:10 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Subject: Getting ethernet dest hw_addr
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Thu, 17 Mar 2005 18:16:08 +0100
Message-ID: <09766A6E64A068419B362367800D50C0B58A96@moritz.faps.uni-erlangen.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Getting ethernet dest hw_addr
thread-index: AcUrFQJuhqlje1jTR5WS5Dj1GS8T+A==
From: "Weber Matthias" <weber@faps.uni-erlangen.de>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i want to write a packet handler for redirecting ethernet packets from an input device to an output device. actually my problem is to get the dest hw addr from the computer physically connected to mine.
the only way seems to restrict on ip packets since it seems that routing and arp needs to be used. so i tried to use ip_route_output_key which fills skb->dst. Unfortunately i don't have any idea how to get the needed addr from there. Below is a piece of code showing what i want to do.

Can anyone help me, please?
The favorite way would be to get the addr without limiting to ip...

Thanks and bye
Matthias

static int ip_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt) {
    struct sk_buff *o_skb = skb_clone(skb, GFP_ATOMIC);
    struct iphdr *iph = o_skb->nh.iph;
    struct tcphdr *th = (struct tcphdr *) ((char *) o_skb->h.th + (iph->ihl << 2));

    //prevent OS for handling packet
    skb->pkt_type = PACKET_OTHERHOST;

    if (iph->saddr == ext_addr) { //out->in
        //modify header
        iph->saddr = gw_int_addr;
        iph->daddr = int_addr;
        o_skb->dev = devs[2];
    } else if (iph->saddr == int_addr) { //in->out
        //modify header
        iph->saddr = gw_ext_addr;
        iph->daddr = ext_addr;
        o_skb->dev = devs[1];
    } else {
        return 0;
    }
    
    //route packet
    struct flowi flow = { 
        .nl_u = { 
            .ip4_u = {
                .saddr = iph->saddr,
                .daddr = iph->daddr,
                .tos = RT_TOS(iph->tos) 
            } 
        },
        .proto = iph->protocol
    };
    struct rtable *rt;
    ip_route_output_key(&rt, &flow);
    o_skb->dst = &(rt->u.dst);

    //ip checksum
    ...works

    //broadcast paket to dev -> no dest ethernet addr needed
    o_skb->dev->hard_header(
        o_skb,
        o_skb->dev,
        ntohs(o_skb->protocol),
o_skb->dst->neighbour->ha,          //destination hw addr needed - seems to be wrong!
        o_skb->dev->dev_addr,
        o_skb->len
    );
    
    //send packet
    o_skb->pkt_type = PACKET_OUTGOING;
    dev_queue_xmit(o_skb);

    kfree_skb(o_skb);
    
    return 0;
}

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131035AbRAXECf>; Tue, 23 Jan 2001 23:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131990AbRAXECZ>; Tue, 23 Jan 2001 23:02:25 -0500
Received: from quechua.inka.de ([212.227.14.2]:11811 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131035AbRAXECS>;
	Tue, 23 Jan 2001 23:02:18 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Turning off ARP in linux-2.4.0
Message-Id: <E14LH8T-00033R-00@sites.inka.de>
Date: Wed, 24 Jan 2001 05:02:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010124011011.A12252@gruyere.muc.suse.de> you wrote:
> The snippet you posted doesn't describe what ClusterThingy exactly wants
> to do with ARPs. 

Andi, it is simple. There are 3 machines on one net with the same IP Address.
Two of them run a web server and one of them a packet redirector. The packet
redirector will ARP for the address. Receive the packet from the Border router
and put it back on the wire destinated to one of the both other systems. The
other systems will receive it and process it with the OS stack, respond back
to the server. That way the load balancer only needs to pass 2-3 packets for
each http request in usermode to the load balanced servers.

/usr/src/linux-2.4.0/net/ipv4/arp.c

void arp_send(int type, int ptype, u32 dest_ip, 
              struct net_device *dev, u32 src_ip, 
              unsigned char *dest_hw, unsigned char *src_hw,
              unsigned char *target_hw)
{
        struct sk_buff *skb;
        struct arphdr *arp;
        unsigned char *arp_ptr;

        /*
         *      No arp on this interface.
         */
        
        if (dev->flags&IFF_NOARP)
                return;

and


/*
 *      The hardware length of the packet should match the hardware length
 *      of the device.  Similarly, the hardware types should match.  The
 *      device should be ARP-able.  Also, if pln is not 4, then the lookup
 *      is not from an IP number.  We can't currently handle this, so toss
 *      it. 
 */  
        if (in_dev == NULL ||
            arp->ar_hln != dev->addr_len    || 
            dev->flags & IFF_NOARP ||
            skb->pkt_type == PACKET_OTHERHOST ||
            skb->pkt_type == PACKET_LOOPBACK ||
            arp->ar_pln != 4)
                goto out;

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129243AbRBTB1T>; Mon, 19 Feb 2001 20:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129400AbRBTB1J>; Mon, 19 Feb 2001 20:27:09 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:10759 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S129243AbRBTB1E>;
	Mon, 19 Feb 2001 20:27:04 -0500
To: <linux-kernel@vger.kernel.org>
Subject: net packet queue scheduler, packet_type and proto handlers
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 20 Feb 2001 02:25:10 +0100
Message-ID: <m3itm65eo9.fsf@intrepid.pm.waw.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What do you think about the following change?
We currently have the following structure used for registering protocol
handlers as well as bridges, wiretaps etc. (include/linux/netdevice.h):

struct packet_type 
{
unsigned short     type; /* This is really htons(ether_type). */
struct net_device  *dev; /* NULL is wildcarded here           */
int                (*func) (struct sk_buff *, struct net_device *,
                            struct packet_type *);
void               *data;/* Private to the packet type */
struct packet_type *next;
};

The func() is the protocol handler. It's required to free an skb or
to pass it elsewhere. Its return value is "int", but it's in fact unused,
and the handlers return values at random.


OTOH we have stacked protocol handlers which effectively strip headers
from an skb, retrieve protocol# and pass it to the next protocol handler
- either using netif_rx (which cause problems with a packet being sent
to taps twice, and other problems) or doing things like this
(net/ax25/ax25_in.c):

        switch (skb->data[1]) {
#ifdef CONFIG_INET
                case AX25_P_IP:
                skb_pull(skb,2);                /* drop PID/CTRL */
                        skb->h.raw    = skb->data;
                        skb->nh.raw   = skb->data;
                        skb->dev      = dev;
                        skb->pkt_type = PACKET_HOST;
                        skb->protocol = htons(ETH_P_IP);
                        ip_rcv(skb, dev, ptype);
                        break;

                case AX25_P_ARP:
                        skb_pull(skb,2);
                        skb->h.raw    = skb->data;
                        skb->nh.raw   = skb->data;
                        skb->dev      = dev;
                        skb->pkt_type = PACKET_HOST;
                        skb->protocol = htons(ETH_P_ARP);
                        arp_rcv(skb, dev, ptype);
                ...

As the number of protocols grow and some of them can be modular it
doesn't seem wise to hardcode every protocol handler name in all such
stacked handlers, especially when we have the same info in ptype_base[]
table (net/core/dev.c).


What I think would be better is we should make the handler (func())
return a meaningful value: 0 if the skb has been freed/accepted and
non-0 if the handler has stripped a header from it and it should be

would read:

        switch (skb->data[1]) {
#ifdef CONFIG_INET
                case AX25_P_IP:
                skb_pull(skb,2);                /* drop PID/CTRL */
                        skb->protocol = htons(ETH_P_IP);
			break;

                case AX25_P_ARP:
                        skb_pull(skb,2);
                        skb->protocol = htons(ETH_P_ARP);
			break;
                        
                ...
        }

        skb->h.raw    = skb->data;
        skb->nh.raw   = skb->data;
        skb->dev      = dev;
        skb->pkt_type = PACKET_HOST;
        return 1;       /* skb changed, returned to upper layer for
                           re-inspection */


Of course, taps and bridges wouldn't be allowed to ask for re-inspection :-)


What do you think about this change? Does anything depend on the current
behavior?
-- 
Krzysztof Halasa
Network Administrator

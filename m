Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFDSF>; Fri, 5 Jan 2001 22:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAFDR4>; Fri, 5 Jan 2001 22:17:56 -0500
Received: from www0i.netaddress.usa.net ([204.68.24.38]:28326 "HELO
	www0i.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S129324AbRAFDRr> convert rfc822-to-8bit; Fri, 5 Jan 2001 22:17:47 -0500
Message-ID: <20010106031746.15171.qmail@www0i.netaddress.usa.net>
Date: 5 Jan 01 19:17:45 PST
From: Sunny So <sunnyso@netscape.net>
To: linux-kernel@vger.kernel.org
Subject: Create and Send Packet from Scratch
X-Mailer: USANET web-mailer (34WB1.4A.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In my schoool project (kernel 2.2.X), I would like to pass some data attached
immediately above IP. (i.e. w/o UDP and TCP) I have assigned an arbitrary
protocol # in the IP header field so that the received data is passed on to my
protocol stack.

There is no problem on reception but I got stuck at all the transmission and
forwarding operations:
1, How can I transmit data by using a sk_buff that is created from scratch?
2, How can I forward data from the sk_buff of a received packet.

I have run some trial codes (attached below) but the kernel crashes.

Is my description clear? I surely have missed out something but I have no 
clue. Could anyone point out what is missing from my code?

Thanks in advance. :)

======================================
Transmit Data from Scratch (version 1)
======================================
/* this is how I try the thing out */

struct sk_buff *skb=alloc_skb(sizeof(struct iphdr)+15,GFP_ATOMIC)

skb_put(skb,data_len);
memcpy(skb->data,data_ptr,data_len);

ip_route_output(&rt, [some dst addr in __u32] , 0, RT_TOS(0), 0);

iph = (struct iphdr*) skb->nh.iph;
iph->version = 4;
iph->ihl = sizeof(struct iphdr) >> 2;
iph->tos = 0;
iph->tot_len = htons(skb->len);
iph->id = htons(ip_id_count++);   
iph->frag_off = 0;
iph->ttl = 64;
iph->protocol = [some self-defined #];
iph->saddr = rt->rt_src;
iph->daddr = rt->rt_dst;
ip_send_check(iph);

skb->dst = &rt->u.dst;
skb->dst->output(skb);

======================================
Transmit Data from Scratch (version 2)
======================================
/* code that I find somewhere else */

/* my comment */
[original comment]

skb->dev = [put device here]; /* = ip_dev_find(daddr); ? */
               
skb->nh.iph->saddr = [alter the saddress to this m/c]

/* Is there a "raddr" in "include/linux/ip.h"? */
skb->nh.iph->raddr = [alter the router address]
                
if(!skb->dst)
   [allocate dst_entry stucture]  /* how can I do this? :p */
                 
rt = (struct rtable *) skb->dst;
ip_route_output(&rt, skb->nh.iph->raddr, skb->nh.iph->saddr, 1, 0 )
hdr = (struct ethhdr *)skb_push( skb, ETH_HLEN);
memcpy(hdr->h_source, skb->dev->dev_addr, skb->dev->addr_len);
hdr->h_proto = __constant_htons(ETH_P_IP);
arp_find(skb->dev->h_dest, skb);
dev_queue_xmit(skb);


===============================
Forward Data of Received Packet
===============================
/* just alter the destination IP address */
/* or may add some data as well */
/* and then send it out */

/* outgoing device may be different from incoming device */
/* skb is the received skb */

struct rtable *rt;
struct iphdr *iph;
struct sk_buff *skb2;

skb2 = skb_copy(skb, GFP_KERNEL);
iph = (struct iphdr*) skb2->nh.iph;
ip_route_output(&rt, [some dst addr in __u32] , 0, RT_TOS(0), 0);
iph->daddr = [some dst addr in __u32];

/* // if I add 4 bytes of data as well 
iph->tot_len = htons(ntohs(iph->tot_len) + 4);
skb->tail += 4;
skb->len += 4;
*/

ip_send_check(iph);
skb2->dst = &rt->u.dst;
skb2->dst->output(skb2);


____________________________________________________________________
Get your own FREE, personal Netscape WebMail account today at http://home.netscape.com/webmail
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129274AbRB1VT5>; Wed, 28 Feb 2001 16:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129276AbRB1VTr>; Wed, 28 Feb 2001 16:19:47 -0500
Received: from ns.dkik.dk ([194.234.39.2]:2318 "HELO dkik.dk")
	by vger.kernel.org with SMTP id <S129274AbRB1VT2> convert rfc822-to-8bit;
	Wed, 28 Feb 2001 16:19:28 -0500
Message-ID: <01a001c0a1cc$22bd5e50$5f01a8c0@worm>
From: "Christian Worm Mortensen" <worm@dkik.dk>
To: <linux-kernel@vger.kernel.org>
Subject: Networking on 2.4: Finding source of a masqgraded packet and source/destination MAC address
Date: Wed, 28 Feb 2001 22:19:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am the author of the WRR (http://wipl-wrr.dkik.dk/wrr) qdisc, an extension to the 2.2 kernels which is supposed to run on a router/bridge/firewall and do Weighted Round Robin scheduling with a class for each local machine.

Now, I want to port this scheduler to 2.4. One of the problems is that sometimes I have an outgoing (to the world) packet which has been masqgraded. I want to account this packet to the local machine which has originally generated it. On 2.2. I used the following code to get the IP address of the local machine:

#ifdef CONFIG_IP_MASQUERADE
    // iph:      // The ip header from the sk_buff
    // dport:   // Destination port of packet
    // sport:   // Source port of packet
    // ipaddr: // We update this with the IP address of the local machine
    {
      struct ip_masq* src;

      // HACK!:
      //   ip_masq_in_get must be called for packets comming from the outside
      //   to the firewall. We have a a packet which is comming from the firewall
      //   to the outside - so we switch the parameters:
      if(src=ip_masq_in_get(
            iph->protocol,
            iph->daddr,dport,
            iph->saddr,sport))) {
        // Use masqgraded address:
        ipaddr=src->saddr;

        // It seems like we must put it back:
        ip_masq_put(src);
      }
    }
#endif

What should I use on 2.4?

And a second question:

When used on a bridge I also want to get the MAC source and destionation address of packets to be able to classify local machines based on these addresses (I suppose this cannot be combinated with masqgrading or routing for to-the-world packets). The ipt_mac.c file seems to do the same thing in the following code:
 
    /* Is mac pointer valid? */
    return (skb->mac.raw >= skb->head
            && skb->mac.raw < skb->head + skb->len - ETH_HLEN
            /* If so, compare... */
            && ((memcmp(skb->mac.ethernet->h_source, info->srcaddr, ETH_ALEN)
                == 0) ^ info->invert));
 
Now, as far as I can see it would be more correct to use skb->data instead of skb->head? Isn't data where the data starts and head where the sk_buff is actually allocated? I might very well have missunderstood something, but I have not succeeded in finding any usefull documenation on the sk_buff structure. And another thing - will the above check ensure that what we read is actually valid or will it just ensure that we do not read from a place in memory that would generate an exception? And if it doesn't ensure it is valid, is there any way to ensure that it is? In 2.2 I used the pkt_isbridged flag of the sk_buff which seems to have disappeared.
 
 
Christian


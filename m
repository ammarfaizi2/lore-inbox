Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265624AbRF1J5e>; Thu, 28 Jun 2001 05:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265621AbRF1J5Y>; Thu, 28 Jun 2001 05:57:24 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:4883 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id <S265618AbRF1J5M>;
	Thu, 28 Jun 2001 05:57:12 -0400
Message-ID: <3B3AFFDE.2763D18F@qosmos.net>
Date: Thu, 28 Jun 2001 11:58:54 +0200
From: Gautier Harmel <Gautier.Harmel@qosmos.net>
Reply-To: Gautier.Harmel@qosmos.net
Organization: QOSMOS.NET
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to pass packets up to protocols layer ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing a module on Kernel 2.4. A part of this module can be view as
a firewall.
My module is logically located between the IP layer and the link layer.
In fact, the binding is done on NF_IP_POST_ROUTING for packets outgoing,
and on NF_IP_PRE_ROUTING for packets incoming.

I'd like my firewall to respond by an TCP/RST packet when a packet is
forbidden.

There is no problem with that when I send this packet over the network.
To do that :
    - I created a new skbuff, that I properly fill with TCP/IP headers.

    - I find the route by calling something like :
             if (ip_route_output(&rt, iph->daddr, iph->saddr,
RT_TOS(iph->tos), 0) != 0)
                  return NULL;
             dev = rt->u.dst.dev;

    -Then I fill properly my sk_buff,

    -Later I send the packet with a code  like that:
            static inline int output_maybe_reroute(struct sk_buff *skb)
{
                 return  skb->dst->output(skb);
            }

            NF_HOOK(PF_INET, NF_IP_LOCAL_OUT,  skb,  NULL, skb->dev,
output_maybe_reroute);

There is no problem with that, it work fine in that way !

My problem is that sometimes, I'd like to pass those RST packets UP to
the protocol layer.
Instead of sending packets on the network, I'd like to pass them up.
As it works for the sending way, I'm trying to do the same and just
modifying the last step by something like :

    - Pass my packet up to the protocol layer
            static inline int input_maybe_reroute(struct sk_buff *skb) {

                 return  skb->dst->input(skb);
            }

            NF_HOOK(PF_INET, NF_IP_LOCAL_IN  skb,  skb->dev, NULL,
input_maybe_reroute);

But of course it fails, (in fact I don't even know what should do the
skb->dst->input() function) !
Anyone has an idea on how to do something like that or where to find
doc. ?
When do we have to call ip_route_input() ?

Thank you for help

Gautier Harmel

PS : As I've not subscribe to the mailing list, could you, please, put
my email adress in CC
Gautier.Harmel@qosmos.net



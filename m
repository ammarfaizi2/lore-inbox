Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVF0QaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVF0QaR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVF0Q32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 12:29:28 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:3797 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261342AbVF0QYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 12:24:38 -0400
Date: Mon, 27 Jun 2005 18:24:16 +0200
From: Michael Becker <michbec@t-online.de>
X-Mailer: The Bat! (v1.62r) Personal
Reply-To: Michael Becker <michbec@t-online.de>
Organization: Privat
X-Priority: 3 (Normal)
Message-ID: <506243806.20050627182416@t-online.de>
To: k8 s <uint32@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IPSec Inbound Processing Basic Doubt
In-Reply-To: <699a19ea050623105516cd5eb8@mail.gmail.com>
References: <699a19ea050623105516cd5eb8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ID: bLKAosZdgeINkYLdKNcHJ7Oxs-3161a4YHu-jNWtlcgV66nMoyYfQL
X-TOI-MSGID: b687beb9-a1d6-4dc9-821b-b0fa50e19879
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ks> I have a basic doubt regarding ipsec inbound packet processing.
ks> I have idea about the stackable destination.If I am not wrong it is like this.
ks>  /* Output packet to network from transport.  */
ks> static inline int dst_output(struct sk_buff *skb)
ks> {
ks>         int err;

ks>         for (;;) {
ks>                 err = skb->dst->output(skb);

ks>                 if (likely(err == 0))
ks>                         return err;
ks>                 if (unlikely(err != NET_XMIT_BYPASS))
ks>                         return err;
ks>         }
ks> }

Most of the skb's travel from transport layer to IP layer via
ip_queue_xmit (ip_output.c).

Within this function ip_route_output_flow is the central entry point into
routing and xfrm (by means of xfrm_lookup, xfrm_find_bundle,
xfrm_bundle_create).

xfrm_bundle_create does create the destination stack. The last
dst_entry of the destination stack is the final routing entry, with
it's output function pointer (->output) set to ip_output
The other dst_entry's on top (up to nx transformations, see
the for-loop in __xfrm4_bundle_create) have set xfrm4_output, or
xfrm6_output, e.g.)

As ip_route_output_flow returns to ip_queue_xmit, the last function
call made is NF_HOOK (a macro actually), which sets dst_output as the
packets further processing function in case it traverses the hook
without being dropped.

So far you are right with your assumptions, I hope my explanation just
made it a bit clearer.

ks> All methods return non zero for the dst_output for loop to continue
ks> except ip_queue_xmit   (I Think) which returns 0 and the for loop
ks> exits. Error reporting by any member in the chain is through returning
ks> XMIT_BYPASS or similar

The return values are behave a little different.

xfrm4_output calls the appropriate transformation function (e.g. esp_output)
esp_output returns 0 on success, else an error occurred.

xfrm4_output itself returns NET_XMIT_BYPASS in case of no error.
If xfrm4_output would return 0, the for-loop in dst_ouput is left
immediately with a return statement, after the output function was
called.

So NET_XMIT_BYPASS keeps the destination stack running until
the final call to ip_output makes it return to ip_queue_xmit, which
returns with the result.


ks> I hope Its the way

You were very close to it :-)



ks> My doubt regarding Inbound processing is
ks>  dst_input()
ks> {
ks>     for(;;)
ks>    {
ks>         err = skb->dst->input()
ks>    }
ks> }
ks> hope that it calls rxfrm4_rcv (ipv4)  calls
ks>                                 xfrm4_rcv_encap()
ks>                                    {
ks>                                         x->type->input()
ks>                                         dst_release(skb->dst);

ks>                                           //also there is a
ks> netif_rx(skb) in the same method
ks>                                     }
ks>  and  x->type->input() calling ah_input | esp_input()

ks> Now is it that 
ks> a) inbound is similar to outbound stackable destination calls except
ks> that the calls are in                                              
ks> reverse direction

No it's not similiar. dst_input is not used for xfrm transformations.
Have a look at ip_local_deliver_finish. The packet enters as ESP or AH
and thus the protocol handler is xfrm4_rcv which is called via
ipprot->handler(skb)

xfrm4_rcv calls xfrm4_rcv_encap, which does all decapsulating
transformations in a do-while-loop, calling x->type-input.

When all transfromation processing is done the naked ip paket is put
back into the CPU specific packet queue by netif-rx.

ks> b)Does netif_rx call in xfrm4_rcv_encap mean one of the many xfrms of
ks> ipsec gets processed first and the packet is fed back to the ipstack
ks> through netif_rx() and the whole game starts again with ip_rcv
ks> checking protocol finding 50 0r 51 and calling xfrm4_rcv

The whole decapsulation is done in xfrm4_rcv_encap, except in case of
nat-traversal, where udp_rcv comes into play.
After the whole xfrm processing is done the packet is put back into the
network stack as it would look like without being ever processed by IPSec
(almost :-).

Best regards
  Michael Becker


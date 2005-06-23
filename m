Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVFWR4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVFWR4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 13:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVFWR4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 13:56:17 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:5294 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262650AbVFWRzg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 13:55:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Q+MWxg8d5pOI7mhGzUxQf9mPTzX/9ReqIr6TtbelQsIqp5UQRzztrnT0kdqaBgji+rYBlAiIZL2ARR2TYqpq0CxzboqDFDrkySnvBkYXHYDRu1t3ItWW55yDdxPoDe1B+3oHQVAyW05aQLyFZKCQCAomV9jh458QbDL6Nuv4rrs=
Message-ID: <699a19ea050623105516cd5eb8@mail.gmail.com>
Date: Thu, 23 Jun 2005 23:25:34 +0530
From: k8 s <uint32@gmail.com>
Reply-To: k8 s <uint32@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: IPSec Inbound Processing Basic Doubt
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a basic doubt regarding ipsec inbound packet processing.
I have idea about the stackable destination.If I am not wrong it is like this.
 /* Output packet to network from transport.  */
static inline int dst_output(struct sk_buff *skb)
{
        int err;

        for (;;) {
                err = skb->dst->output(skb);

                if (likely(err == 0))
                        return err;
                if (unlikely(err != NET_XMIT_BYPASS))
                        return err;
        }
}

here skb->dst->oututput(skb)
               xfrm4_output(skb) 
                     {
                                x->type->output(skb)
                                skb->dst = dst_pop(skb);
                      }
                                            
And x->type->output(skb) calls ah_output | esp_output and the skb->dst
value is reset during dst_pop(skb)

All methods return non zero for the dst_output for loop to continue
except ip_queue_xmit   (I Think) which returns 0 and the for loop
exits. Error reporting by any member in the chain is through returning
XMIT_BYPASS or similar

I hope Its the way

My doubt regarding Inbound processing is
 dst_input()
{
    for(;;)
   {
        err = skb->dst->input()
   }
}
hope that it calls rxfrm4_rcv (ipv4)  calls
                                xfrm4_rcv_encap()
                                   {
                                        x->type->input()
                                        dst_release(skb->dst);

                                          //also there is a
netif_rx(skb) in the same method
                                    }
 and  x->type->input() calling ah_input | esp_input()

Now is it that 
a) inbound is similar to outbound stackable destination calls except
that the calls are in                                              
reverse direction
b)Does netif_rx call in xfrm4_rcv_encap mean one of the many xfrms of
ipsec gets processed first and the packet is fed back to the ipstack
through netif_rx() and the whole game starts again with ip_rcv
checking protocol finding 50 0r 51 and calling xfrm4_rcv

So is it a call chain 
or 
packet looping between ipsec and ip continuosly using  netif_rx and
ip_rcv and xfrm4_rcv




S Kartikeyan

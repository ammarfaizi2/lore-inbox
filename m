Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265059AbSKNRGD>; Thu, 14 Nov 2002 12:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSKNRFn>; Thu, 14 Nov 2002 12:05:43 -0500
Received: from home.deeptown.org ([205.150.192.50]:5250 "HELO deeptown.org")
	by vger.kernel.org with SMTP id <S265059AbSKNRFQ> convert rfc822-to-8bit;
	Thu, 14 Nov 2002 12:05:16 -0500
Message-ID: <015301c28c00$f6287390$34c096cd@toybox>
From: "Serge Kuznetsov" <sk@deeptown.org>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-net@vger.kernel.org>
Subject: [NET] Possible bug in netif_receive_skb
Date: Thu, 14 Nov 2002 12:12:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LeavesHi guys,

I think code for netif_receive_skb have a bug:

int netif_receive_skb(struct sk_buff *skb)
{
        struct packet_type *ptype, *pt_prev;
        int ret = NET_RX_DROP;
        unsigned short type = skb->protocol;

/* some code skipped */

        pt_prev = NULL;
        for (ptype = ptype_all; ptype; ptype = ptype->next) {
                if (!ptype->dev || ptype->dev == skb->dev) {
                        if (pt_prev) {
                                if (!pt_prev->data) {
                                        ret = deliver_to_old_ones(pt_prev,
                                                                  skb, 0);
                                } else {
                                        atomic_inc(&skb->users);
                                        ret = pt_prev->func(skb, skb->dev,
                                                            pt_prev);
                                }
/* Would be great to add this check here */
                                if ( ( ret == NET_RX_DROP ) || ( ret == NET_RX_BAD ) )
                                {
                                       /* Check here if skb was freed in pt_prev_>func(), if not - free it */
                                       ...
                                      return ret;
                                 }
                        }
                        pt_prev = ptype;
                }
        }


First of all, just imagine if we have only on TAP attached to ptype_all.

In this case this TAP won't be called, because of pt_prev. ( BTW, why pt_prev, why we shouldn't call the function of first chain-link? )

In second case, imagine if we have three TAPs attached to ptype_all, and second TAP desided to be an universal firewall ( third one is just ordinar TAP ). If that second TAP will call kfree_skb ( skb ), and will return the code NET_RX_DROP or NET_RX_BAD, that return code will be overwritten by third TAP, which will get freed skb, and possible panic.

The same issue for the bottom half of the function ( for ptype_base ).

what if we will add the check for it? Like I added above.


PS: BTW, how to check if skb has been freed ? I didn't found any function for it. Is it possible to add the flag, like skb->freed ?


All the Best!
Serge.

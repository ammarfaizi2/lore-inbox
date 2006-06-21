Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWFUQ2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWFUQ2k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWFUQ2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:28:40 -0400
Received: from mail.gmx.net ([213.165.64.21]:47747 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932229AbWFUQ2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:28:40 -0400
X-Authenticated: #704063
Subject: Possible leaks in network drivers
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 21 Jun 2006 18:28:37 +0200
Message-Id: <1150907317.8320.0.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

Coverity complains about several pretty similar resource leaks
inside the net drivers, and i am not sure if those are real

name				coverity #id

drivers/net/8390.c		623
drivers/net/pcmcia/xirc2ps_cs.c	627
drivers/net/sis190.c		628
drivers/net/wireless/wavelan.c	634
drivers/net/wireless/orinoco.c	661
drivers/net/depca.c		1246
drivers/net/hp100.c		1247
drivers/net/smc9194.c		1248
drivers/net/skge.c		1249

Its always in the hard_start_xmit() function
of the driver. Where we call skb=skb_padto(skb, ETH_ZLEN),
and dont free the skb later when something goes wrong.

Here is the output from the sis190.c case:

------------snip--8<-------------
1158 		if (unlikely(skb->len < ETH_ZLEN)) {

Event alloc_fn: Called allocation function "skb_padto" [model]
Event var_assign: Assigned variable "skb" to storage returned from "skb_padto"
Also see events: [var_assign][leaked_storage]

1159 			skb = skb_padto(skb, ETH_ZLEN);

At conditional (1): "skb == 0" taking false path

1160 			if (!skb) {
1161 				tp->stats.tx_dropped++;
1162 				goto out;
1163 			}
1164 			len = ETH_ZLEN;
1165 		} else {
1166 			len = skb->len;
1167 		}
1168 	
1169 		entry = tp->cur_tx % NUM_TX_DESC;
1170 		desc = tp->TxDescRing + entry;
1171 	

At conditional (2): "(desc)->status & 2147483648 != 0" taking true path

1172 		if (unlikely(le32_to_cpu(desc->status) & OWNbit)) {
1173 			netif_stop_queue(dev);

At conditional (3): "(tp)->msg_enable & 128 != 0" taking true path

1174 			net_tx_err(tp, KERN_ERR PFX
1175 				   "%s: BUG! Tx Ring full when queue awake!\n",
1176 				   dev->name);

Event leaked_storage: Returned without freeing storage "skb"
Also see events: [alloc_fn][var_assign]

1177 			return NETDEV_TX_BUSY;
1178 		}

------------snip--8<-------------

As far as i can see, skb_put() might return a fresh allocated skb, 
so adding a kfree_skb() here should fix these, or am i missing
something?

Thanks Eric


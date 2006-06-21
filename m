Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWFURCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWFURCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWFURCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:02:40 -0400
Received: from xenotime.net ([66.160.160.81]:19687 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750860AbWFURCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:02:39 -0400
Date: Wed, 21 Jun 2006 10:05:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible leaks in network drivers
Message-Id: <20060621100525.bb4f76f4.rdunlap@xenotime.net>
In-Reply-To: <1150907317.8320.0.camel@alice>
References: <1150907317.8320.0.camel@alice>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 18:28:37 +0200 Eric Sesterhenn wrote:

> hi,
> 
> Coverity complains about several pretty similar resource leaks
> inside the net drivers, and i am not sure if those are real

Linux network driver development is done on the netdev
mailing list (netdev@vger.kernel.org).
You'll find a larger pool of the right people there...


> name				coverity #id
> 
> drivers/net/8390.c		623
> drivers/net/pcmcia/xirc2ps_cs.c	627
> drivers/net/sis190.c		628
> drivers/net/wireless/wavelan.c	634
> drivers/net/wireless/orinoco.c	661
> drivers/net/depca.c		1246
> drivers/net/hp100.c		1247
> drivers/net/smc9194.c		1248
> drivers/net/skge.c		1249
> 
> Its always in the hard_start_xmit() function
> of the driver. Where we call skb=skb_padto(skb, ETH_ZLEN),
> and dont free the skb later when something goes wrong.
> 
> Here is the output from the sis190.c case:
> 
> ------------snip--8<-------------
> 1158 		if (unlikely(skb->len < ETH_ZLEN)) {
> 
> Event alloc_fn: Called allocation function "skb_padto" [model]
> Event var_assign: Assigned variable "skb" to storage returned from "skb_padto"
> Also see events: [var_assign][leaked_storage]
> 
> 1159 			skb = skb_padto(skb, ETH_ZLEN);
> 
> At conditional (1): "skb == 0" taking false path
> 
> 1160 			if (!skb) {
> 1161 				tp->stats.tx_dropped++;
> 1162 				goto out;
> 1163 			}
> 1164 			len = ETH_ZLEN;
> 1165 		} else {
> 1166 			len = skb->len;
> 1167 		}
> 1168 	
> 1169 		entry = tp->cur_tx % NUM_TX_DESC;
> 1170 		desc = tp->TxDescRing + entry;
> 1171 	
> 
> At conditional (2): "(desc)->status & 2147483648 != 0" taking true path
> 
> 1172 		if (unlikely(le32_to_cpu(desc->status) & OWNbit)) {
> 1173 			netif_stop_queue(dev);
> 
> At conditional (3): "(tp)->msg_enable & 128 != 0" taking true path
> 
> 1174 			net_tx_err(tp, KERN_ERR PFX
> 1175 				   "%s: BUG! Tx Ring full when queue awake!\n",
> 1176 				   dev->name);
> 
> Event leaked_storage: Returned without freeing storage "skb"
> Also see events: [alloc_fn][var_assign]
> 
> 1177 			return NETDEV_TX_BUSY;
> 1178 		}
> 
> ------------snip--8<-------------
> 
> As far as i can see, skb_put() might return a fresh allocated skb, 
> so adding a kfree_skb() here should fix these, or am i missing
> something?
> 
> Thanks Eric

---
~Randy

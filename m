Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVALW7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVALW7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVALW7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:59:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:34200 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261543AbVALW4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:56:51 -0500
Date: Wed, 12 Jan 2005 15:01:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [BK] TUN/TAP driver update and fixes for 2.6.BK
Message-Id: <20050112150129.09601d64.akpm@osdl.org>
In-Reply-To: <41E5A5DA.1010301@qualcomm.com>
References: <41E5A5DA.1010301@qualcomm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Krasnyansky <maxk@qualcomm.com> wrote:
>
> Could one of you please pull TUN/TAP driver updates from my tree

That would be Dave.

Did you see this fly past on netdev?


From: Tommy Christensen <tommy.christensen@tpack.net>

But as stated in bonding.txt, the ARP monitor requires the underlying
driver to update dev->trans_start and dev->last_rx.

The patch below adds the required functionality to the TUN/TAP driver.
Please test if this helps in your case.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/net/tun.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/net/tun.c~tun-tan-arp-monitor-support drivers/net/tun.c
--- 25/drivers/net/tun.c~tun-tan-arp-monitor-support	Wed Jan 12 14:56:05 2005
+++ 25-akpm/drivers/net/tun.c	Wed Jan 12 14:56:05 2005
@@ -92,6 +92,7 @@ static int tun_net_xmit(struct sk_buff *
 			goto drop;
 	}
 	skb_queue_tail(&tun->readq, skb);
+	dev->trans_start = jiffies;
 
 	/* Notify and wake up reader process */
 	if (tun->flags & TUN_FASYNC)
@@ -240,6 +241,7 @@ static __inline__ ssize_t tun_get_user(s
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
  
 	netif_rx_ni(skb);
+	tun->dev->last_rx = jiffies;
    
 	tun->stats.rx_packets++;
 	tun->stats.rx_bytes += len;
_


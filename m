Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWATTX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWATTX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWATTX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:23:56 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51858 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751041AbWATTXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:23:54 -0500
Date: Fri, 20 Jan 2006 20:24:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt6: network driver disabled interrupts: skge_xmit_frame
Message-ID: <20060120192422.GA12856@elte.hu>
References: <1137781510.18253.3.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137781510.18253.3.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Tons of these messages when I try out the skge network driver under
> 2.6.15-rt6 (instead of the sk98lin driver):
> 
>   network driver disabled interrupts: skge_xmit_frame+0x0/0x330 [skge]
> 
> Any fixes I could try?

could you try the one below ontop of -rt8?

	Ingo

Index: linux-rt.q/drivers/net/skge.c
===================================================================
--- linux-rt.q.orig/drivers/net/skge.c
+++ linux-rt.q/drivers/net/skge.c
@@ -2272,12 +2272,9 @@ static int skge_xmit_frame(struct sk_buf
 	if (!skb)
 		return NETDEV_TX_OK;
 
-	local_irq_save(flags);
-	if (!spin_trylock(&skge->tx_lock)) {
+	if (!spin_trylock_irqsave(&skge->tx_lock))
  		/* Collision - tell upper layer to requeue */
- 		local_irq_restore(flags);
  		return NETDEV_TX_LOCKED;
- 	}
 
 	if (unlikely(skge->tx_avail < skb_shinfo(skb)->nr_frags +1)) {
 		if (!netif_queue_stopped(dev)) {

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752080AbWJXGD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbWJXGD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 02:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbWJXGD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 02:03:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16270
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752080AbWJXGD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 02:03:57 -0400
Date: Mon, 23 Oct 2006 23:03:50 -0700 (PDT)
Message-Id: <20061023.230350.05157566.davem@davemloft.net>
To: shemminger@osdl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] netpoll: use sk_buff_head for txq
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061023120253.5dd146d2@dxpl.pdx.osdl.net>
References: <20061020153027.3bed8c86@dxpl.pdx.osdl.net>
	<20061022.204220.78710782.davem@davemloft.net>
	<20061023120253.5dd146d2@dxpl.pdx.osdl.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Mon, 23 Oct 2006 12:02:53 -0700

> +	spin_lock_irqsave(&netpoll_txq.lock, flags);
> +	for (skb = (struct sk_buff *)netpoll_txq.next;
> +	     skb != (struct sk_buff *)&netpoll_txq; skb = next) {
> +		next = skb->next;
> +		if (skb->dev == dev) {
> +			skb_unlink(skb, &netpoll_txq);
> +			kfree_skb(skb);
> +		}
>  	}
> +	spin_unlock_irqrestore(&netpoll_txq.lock, flags);

IRQ's are disabled, I think we can't call kfree_skb() in such a
context.

That's why zap_completion_queue() has all of these funny
skb->destructor checks and such, all of this stuff potentially runs in
IRQ context.

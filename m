Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWJXOvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWJXOvi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWJXOvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:51:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932295AbWJXOvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:51:37 -0400
Date: Tue, 24 Oct 2006 07:51:30 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] netpoll: use sk_buff_head for txq
Message-ID: <20061024075130.6e4cf8d2@dads-laptop>
In-Reply-To: <20061023.230350.05157566.davem@davemloft.net>
References: <20061020153027.3bed8c86@dxpl.pdx.osdl.net>
	<20061022.204220.78710782.davem@davemloft.net>
	<20061023120253.5dd146d2@dxpl.pdx.osdl.net>
	<20061023.230350.05157566.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006 23:03:50 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Mon, 23 Oct 2006 12:02:53 -0700
> 
> > +	spin_lock_irqsave(&netpoll_txq.lock, flags);
> > +	for (skb = (struct sk_buff *)netpoll_txq.next;
> > +	     skb != (struct sk_buff *)&netpoll_txq; skb = next) {
> > +		next = skb->next;
> > +		if (skb->dev == dev) {
> > +			skb_unlink(skb, &netpoll_txq);
> > +			kfree_skb(skb);
> > +		}
> >  	}
> > +	spin_unlock_irqrestore(&netpoll_txq.lock, flags);
> 
> IRQ's are disabled, I think we can't call kfree_skb() in such a
> context.

It is save since the skb's only come from this code (no destructors).

> 
> That's why zap_completion_queue() has all of these funny
> skb->destructor checks and such, all of this stuff potentially runs in
> IRQ context.

It should use __kfree_skb in the purge routine (like other places).

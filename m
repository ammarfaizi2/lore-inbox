Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTL3GF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 01:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264410AbTL3GF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 01:05:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5323 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264379AbTL3GFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 01:05:55 -0500
Date: Mon, 29 Dec 2003 22:01:22 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
Message-Id: <20031229220122.30078657.davem@redhat.com>
In-Reply-To: <20031230051519.GA6916@gtf.org>
References: <1072567054.4112.14.camel@gaston>
	<20031227170755.4990419b.davem@redhat.com>
	<3FF0FA6A.8000904@pobox.com>
	<20031229205157.4c631f28.davem@redhat.com>
	<20031230051519.GA6916@gtf.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003 00:15:19 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> OK, agreed.  But fixing it in the driver is still incorrect, also.
> 
> We need a single solution in the net stack, not a per-driver solution.

I totally disagree.

Let's quickly review, this is illegal:

	local_irq_disable();
	{
		local_bh_disable();
		... do kfree_skb work ...
		local_bh_enable();
	}
	local_irq_enable();

as is this:

	local_irq_disable();
	{
		... queue to softirq TX work ...
	}
	local_irq_enable();
	... oops this won't make softirq TX work get run ...

The driver must therefore recognize that it may only free packets
in it's IRQ handler or in situations where BH protection has occurred
at a higher level or BH protection is the only protection it uses
from base context.

This is similar to how the driver must be aware that
netif_receive_skb() can cause it's ->hard_start_xmit() method to run
and therefore it must prevent deadlocks that might occur as a result
of locks held during the netif_receive_skb() call.

So let's fix the drivers. :)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTL1BIE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 20:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbTL1BIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 20:08:04 -0500
Received: from rth.ninka.net ([216.101.162.244]:24704 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264899AbTL1BH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 20:07:59 -0500
Date: Sat, 27 Dec 2003 17:07:55 -0800
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
Message-Id: <20031227170755.4990419b.davem@redhat.com>
In-Reply-To: <1072567054.4112.14.camel@gaston>
References: <1072567054.4112.14.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Dec 2003 10:17:34 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> We should probably fix dev_kfree_skb_any() ? Still ugly imho though...
> 
> -        if (in_irq())
> +        if (in_irq() || irqs_disabled())
> 

That's not the right fix, the sungem PM code path TX queue
packet freeing should be instead done outside of IRQ spinlocks.

The easiest and safest way to do this is to have a local stack
SKB list whose pointer gets passed down into the chip reset and
thus the TX queue liberation code, the TX queue liberation code
works inside the lock but does not actually free the SKBs, instead
it tacks the SKBs onto the SKB list, then at the top level when the
IRQ lock is released the SKBs on the list are actually freed.

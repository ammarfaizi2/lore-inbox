Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbTL1FpJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 00:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbTL1FpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 00:45:09 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:57799 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264511AbTL1FpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 00:45:04 -0500
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031227170755.4990419b.davem@redhat.com>
References: <1072567054.4112.14.camel@gaston>
	 <20031227170755.4990419b.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1072590269.741.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 28 Dec 2003 16:44:29 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-12-28 at 12:07, David S. Miller wrote:
> On Sun, 28 Dec 2003 10:17:34 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > We should probably fix dev_kfree_skb_any() ? Still ugly imho though...
> > 
> > -        if (in_irq())
> > +        if (in_irq() || irqs_disabled())
> > 
> 
> That's not the right fix, the sungem PM code path TX queue
> packet freeing should be instead done outside of IRQ spinlocks.
>
> .../...

The "workaround" is a bit complicated, but I'll look into it,
I could probably get the whole clean ring thing out of the
spinlock instead (I need to reduce time spent in those locks
anyway).

Though it's really inconsistent imho, to have that routine that
can be called at task time, interrupt time, but not task time with
a spinlock held... especially since it's called *kfree*, I would
have expected kfree-like semantics...

Note that among the drivers broken with that same bug (typically
in the close() path) are :

 - sunhme
 - b44
 - tg3
 - ...

Almost all drivers calling dev_kfree_skb_any() do that within a
spinlock_irq ...

Ben.



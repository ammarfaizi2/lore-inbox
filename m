Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269392AbUI3Sds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269392AbUI3Sds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269400AbUI3Sdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:33:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:22405 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269392AbUI3Sdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:33:43 -0400
Date: Thu, 30 Sep 2004 11:33:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Franz Pletz <franz_pletz@t-online.de>, Michal Rokos <michal@rokos.info>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2.6] Natsemi - remove compilation warnings
In-Reply-To: <415C4EC5.4040603@pobox.com>
Message-ID: <Pine.LNX.4.58.0409301129540.2403@ppc970.osdl.org>
References: <200409230958.31758.michal@rokos.info> <200409231618.56861.michal@rokos.info>
 <415C37D8.20203@t-online.de> <Pine.LNX.4.58.0409300951150.2403@ppc970.osdl.org>
 <415C4EC5.4040603@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Sep 2004, Jeff Garzik wrote:
> >  
> > +static inline void __iomem *ns_ioaddr(struct net_device *dev)
> > +{
> > +	return (void __iomem *) dev->base_addr;
> > +}
> > +
> 
> hmmmm.  Since dev->base_addr gets exported to userspace, I don't think 
> it's that quick/easy to change.

Hmm? This maintains the _exact_ old semantics, ie we do exactly what it 
used to do before. The inline function doesn't save the value off 
anywhere, it's really just a nicer way to do a cast in _one_ place rather 
than all over the world. Also, it ends up resulting in just _one_ place 
that knows where to get the base address, instead of several places in 
pretty much every function in the whole driver ;-P

> Wouldn't it be better to just phase out the base of dev->base_addr 
> completely?  I tend to prefer adding a "void __iomem *regs" to struct 
> netdev_private, and ignore dev->base_addr completely.

Yes. I didn't want to change actual behaviour in a driver that I can't 
even test, so I went for the semantically 100% equivalent cleanup patch 
instead that just changes the syntax and gets rid of the warnings.

But that's the other advantage of the ns_ioaddr() accessor function:  
somebody who does have the hw can now phase out "base_addr", and just
change that one one-liner function, and you can now get the base address
from anywhere you like ;)

		Linus

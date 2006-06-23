Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWFWOCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWFWOCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWFWN5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:57:53 -0400
Received: from es335.com ([67.65.19.105]:7738 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S1750705AbWFWNow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:44:52 -0400
Subject: Re: [PATCH v3 1/7] AMSO1100 Low Level Driver.
From: Steve Wise <swise@opengridcomputing.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: rdreier@cisco.com, mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1150836226.2891.231.camel@laptopd505.fenrus.org>
References: <20060620203050.31536.5341.stgit@stevo-desktop>
	 <20060620203055.31536.15131.stgit@stevo-desktop>
	 <1150836226.2891.231.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 08:44:50 -0500
Message-Id: <1151070290.7808.33.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Also on a related note, have you checked the driver for the needed PCI
> posting flushes?
> 
> > +
> > +	/* Disable IRQs by clearing the interrupt mask */
> > +	writel(1, c2dev->regs + C2_IDIS);
> > +	writel(0, c2dev->regs + C2_NIMR0);
> 
> like here...

This code is followed by a call to c2_reset(), which interacts with the
firmware on the adapter to quiesce the hardware.  So I don't think we
need to wait here for the posted writes to flush...

> > +
> > +	elem = tx_ring->to_use;
> > +	elem->skb = skb;
> > +	elem->mapaddr = mapaddr;
> > +	elem->maplen = maplen;
> > +
> > +	/* Tell HW to xmit */
> > +	__raw_writeq(cpu_to_be64(mapaddr), elem->hw_desc + C2_TXP_ADDR);
> > +	__raw_writew(cpu_to_be16(maplen), elem->hw_desc + C2_TXP_LEN);
> > +	__raw_writew(cpu_to_be16(TXP_HTXD_READY), elem->hw_desc + C2_TXP_FLAGS);
> 
> or here
> 

No need here.  This logic submits the packet for transmission.  We don't
assume it is transmitted until we (after a completion interrupt usually)
read back the HTXD entry and see the TXP_HTXD_DONE bit set (see
c2_tx_interrupt()). 


Steve.



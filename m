Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbULOSNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbULOSNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbULOSNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:13:04 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:65156 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S262428AbULOSM7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:12:59 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 15 Dec 2004 11:12:58 -0700
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mv643xx_eth: fix hw checksum generation on transmit
Message-ID: <20041215181258.GB17904@xyzzy>
References: <20041213220949.GA19609@xyzzy> <20041213221541.GC19951@xyzzy> <20041214231555.GB11617@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214231555.GB11617@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 11:15:55PM +0000, Christoph Hellwig wrote:
> > +			dev_kfree_skb_irq((struct sk_buff *)
> > +                                                  pkt_info.return_info);
> 
> pkt_info.return_info already is a pointer to struct sk_buff

Yep.  This line was moved, but not changed by my patch.  I'll remove the
cast.

> > +			/* CPU already calculated pseudo header checksum. */
> > +			if (skb->nh.iph->protocol == IPPROTO_UDP) {
> > +				pkt_info.cmd_sts |= ETH_UDP_FRAME;
> > +				pkt_info.l4i_chk = skb->h.uh->check;
> > +			}
> > +			else if (skb->nh.iph->protocol == IPPROTO_TCP)
> > +				pkt_info.l4i_chk = skb->h.th->check;
> > +			else {
> 
> 			} else if (skb->nh.iph->protocol == IPPROTO_TCP) {
> 				pkt_info.l4i_chk = skb->h.th->check;
> 			} else {
> 
> > +	pkt_info.buf_ptr = pci_map_single(0, skb->data, skb->len,
> > +							PCI_DMA_TODEVICE);
> 
> s/0/NULL/ to avoid sparse warnings

Another line that was moved but not changed.  In patch 4/6 I changed it
to dma_map_single(NULL, ...

> > +	/*
> > +	 * The hardware requires that each buffer that is <= 8 bytes
> > +	 * in length must be aligned on an 8 byte boundary.
> > +	 */
> > +        if (p_pkt_info->byte_cnt <= 8 && p_pkt_info->buf_ptr & 0x7) {
> 
> please use tabs, not spaces for indentation.

Again, I didn't change the indentation on this line.  The driver is
replete with whitespace problems.  I don't want to address them now,
but as soon as it's confirmed that these patches are "in the queue",
I'll submit several cosmetic patches:  white space cleanup, rename
from 64340 to 643xx, rename MV_READ/MV_WRITE to mv_read/mv_write,
and a few localized code simplifications.

> >  #ifdef MV64340_CHECKSUM_OFFLOAD_TX
> > -        int tx_first_desc;
> > +        int tx_busy_desc = mp->tx_first_desc_q;
> 
> Again.

Thanks,
-Dale

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753381AbWKCQ7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbWKCQ7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbWKCQ7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:59:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33955 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753381AbWKCQ7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:59:01 -0500
Date: Fri, 3 Nov 2006 16:58:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>, akpm@osdl.org,
       jens.axboe@oracle.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 5/8] resend cciss: disable DMA prefetch on P600
Message-ID: <20061103165856.GA9716@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	"Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>,
	akpm@osdl.org, jens.axboe@oracle.com, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20061103155412.GA1657@beardog.cca.cpqcorp.net> <1162572135.3160.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162572135.3160.2.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 05:42:15PM +0100, Arjan van de Ven wrote:
> On Fri, 2006-11-03 at 09:54 -0600, Mike Miller (OS Dev) wrote:
> > PATCH 5 of 8 resend
> > 
> > This patch unconditionally disables DMA prefetch on the P600 controller. A
> > bug in the ASIC may result in prefetching either beyond the end of memory
> > or to fall off into a memory hole.
> > Please consider this for inclusion.
> > 
> > Thanks,
> > mikem
> > 
> > Signed-off-by: Mike Miller <mike.miller@hp.com>
> > 
> >  cciss.c     |   13 +++++++++++++
> >  cciss_cmd.h |    1 +
> >  2 files changed, 14 insertions(+)
> > --------------------------------------------------------------------------------
> > diff -urNp linux-2.6-p00004/drivers/block/cciss.c linux-2.6-p00005/drivers/block/cciss.c
> > --- linux-2.6-p00004/drivers/block/cciss.c	2006-10-31 15:20:25.000000000 -0600
> > +++ linux-2.6-p00005/drivers/block/cciss.c	2006-11-03 09:43:55.000000000 -0600
> > @@ -2997,6 +2997,19 @@ static int cciss_pci_init(ctlr_info_t *c
> >  	}
> >  #endif
> >  
> > +	{
> > +		/* Disabling DMA prefetch for the P600
> > +		 * An ASIC bug may result in a prefetch beyond
> > +		 * physical memory.
> > +		 */
> > +		__u32 dma_prefetch
> > +		if(board_id == 0x3225103C) {
> > +			dma_prefetch = readl(c->vaddr + I2O_DMA1_CFG);
> > +			dma_prefetch |= 0x8000;
> > +			writel(dma_prefetch, c->vaddr + I2O_DMA1_CFG);
> > +		}
> > +	}
> > +
> 
> if you remove the if() you might as well also remove the {}'s ;)

And fix the spaces around the if() while we're at it, aka:

	/*
	 * Disable DMA prefetch for the P600.
	 * An ASIC bug may result in a prefetch beyond
	 * physical memory.
	 */
	if (board_id == 0x3225103C) {
		u32 dma_prefetch = readl(c->vaddr + I2O_DMA1_CFG);
		writel(dma_prefetch | 0x8000, c->vaddr + I2O_DMA1_CFG);
	}

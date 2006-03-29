Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWC2RFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWC2RFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 12:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWC2RFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 12:05:25 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:21598 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1750858AbWC2RFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 12:05:24 -0500
Date: Wed, 29 Mar 2006 19:06:28 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Mark Lord <lkml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Jeff Garzik <jgarzik@pobox.com>, sander@humilis.net, dror@xiv.co.il
Subject: Re: [PATCH 2.6.16] sata_mv.c :: three bug fixes
Message-ID: <20060329170628.GA25640@localdomain>
References: <200603290950.32219.lkml@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603290950.32219.lkml@rtr.ca>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 09:50:31AM -0500, Mark Lord wrote:
> This patch is against 2.6.16, and fixes three serious bugs in sata_mv.c.
> The same fixes are applicable to 2.6.16-git*.
> 
> (1) A DMA transfer size of 0x10000 was not being written
> as 0x0000 in the PRDs.  Fixed.
> 
> (1) The DEV_IRQ interrupt cause bit happens spuriously
> during EDMA operation, and was not being ignored by the driver. 
> This led to various "drive busy" errors being reported,
> with associated unpredictable behaviour.  Fixed.

I saw that happening too, thanks for the fix.
 
> (2) If a SATA or PCI interrupt was received with no outstanding
> command, the interrupt handler still attempted to invoke
> ata_qc_complete(), triggering assert()/BUG_ON() behaviour
> elsewhere in libata.  Fixed.

Dito. Thanks again.

> The driver still has issues with confusion after error-recovery,
> but should now  be reliable in the absence of drive errors.
> I will be looking more into the error-handling bugs next.
> 
> Signed-Off-By: Mark Lord <mlord@pobox.com>
> ---
>[...]
>  	/* we'll need the HC success int register in most cases */
>  	hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
>  	if (hc_irq_cause) {
>  		writelfl(~hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
>  	}
>  
>  	VPRINTK("ENTER, hc%u relevant=0x%08x HC IRQ cause=0x%08x\n",
>  		hc,relevant,hc_irq_cause);
>  
>  	for (port = port0; port < port0 + MV_PORTS_PER_HC; port++) {
> -		ap = host_set->ports[port];
> +		struct ata_port *ap = host_set->ports[port];
> +		struct mv_port_priv *pp = ap->private_data;

The original code checks ap for NULL, are you sure it is safe to
remove this?

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbVIAOlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbVIAOlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbVIAOlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:41:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5301 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965148AbVIAOlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:41:31 -0400
Date: Thu, 1 Sep 2005 15:40:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Brett Russ <russb@emc.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
Message-ID: <20050901144038.GA25830@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Brett Russ <russb@emc.com>, Jeff Garzik <jgarzik@pobox.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901142754.B93BF27137@lns1058.lss.emc.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/init.h>
> +#include <linux/blkdev.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched.h>
> +#include <linux/dma-mapping.h>
> +#include "scsi.h"

pleaese don't include "scsi.h" in new drivers.  It will go away soon.
Use the <scsi/*.h> headers and get rid of usage of obsolete constucts
in your driver.

> +static inline void writelfl(unsigned long data, void __iomem *addr)
> +{
> +	writel(data, addr);
> +	(void) readl(addr);	/* flush */

no need for the (void) case.

> +static void mv_irq_clear(struct ata_port *ap)
> +{
> +	return;
> +}

no need for the return

> +	return (ofs);

please remove the braces around the return value

> +		if (ap && 
> +		    (NULL != (qc = ata_qc_from_tag(ap, ap->active_tag)))) {
> +			VPRINTK("port %u IRQ found for qc, ata_status 0x%x\n",
> +				port,ata_status);
> +			BUG_ON(0xffU == ata_status);
> +			/* mark qc status appropriately */
> +			ata_qc_complete(qc, ata_status);
> +		}

the formatting looks rather odd.  What about;

		if (ap) {
			qc = ata_qc_from_tag(ap, ap->active_tag);
			if (qc) {
				VPRINTK("port %u IRQ found for qc, "
					"ata_status 0x%x\n",
					port, ata_status);
				BUG_ON(0xffU == ata_status);
				/* mark qc status appropriately */
				ata_qc_complete(qc, ata_status);
			}
		}

> +      err_out_hpriv:

rather odd placement of the goto labels.  If you look at kernel code it's
always either not indented at all, or indented a single space.


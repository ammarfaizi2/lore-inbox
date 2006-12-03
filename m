Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758607AbWLCNAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758607AbWLCNAu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758606AbWLCNAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:00:50 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:29855 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1758591AbWLCNAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:00:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=kg1KZjt4CJH8NWN40hqdwuOMCzz7EHneCYn2+XBPgBHtQSqYWcMa4KZrvt5P/cut+XNL7NLV/37ffPmHBivFW22GTgwnkv+eBO4eZZFjjWYoOiEzXabb9YxN1G7Fy4WxhUpvR1Uc+FyJwlmgR7G2OIG6pFQDsgybsURyHT50vQQ=
Message-ID: <4572CA7A.6010103@gmail.com>
Date: Sun, 03 Dec 2006 22:00:42 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
References: <200612010958.kB19wGbg002454@alkaid.it.uu.se>
In-Reply-To: <200612010958.kB19wGbg002454@alkaid.it.uu.se>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Mikael.

Thanks for doing this.

Mikael Pettersson wrote:
[--snip--]
> +static void pdc_freeze(struct ata_port *ap)
> +{
> +	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
> +	u32 tmp;
> +
> +	tmp = readl(mmio + PDC_CTLSTAT);
> +	tmp |= PDC_IRQ_DISABLE;
> +	tmp &= ~PDC_DMA_ENABLE;
> +	writel(tmp, mmio + PDC_CTLSTAT);
> +	readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? sata_sil does this */

Just drop the above line.

> +}
> +
> +static void pdc_thaw(struct ata_port *ap)
> +{
> +	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
> +	u32 tmp;
> +
> +	/* clear IRQ */
> +	readl(mmio + PDC_INT_SEQMASK);
> +
> +	/* turn IRQ back on */
> +	tmp = readl(mmio + PDC_CTLSTAT);
> +	tmp &= ~PDC_IRQ_DISABLE;
> +	writel(tmp, mmio + PDC_CTLSTAT);
> +	readl(mmio + PDC_CTLSTAT); /* flush *//* XXX: needed? */

Ditto.

> +}
> +
> +static void pdc_error_handler(struct ata_port *ap)
> +{
> +	struct ata_eh_context *ehc = &ap->eh_context;
> +	ata_reset_fn_t hardreset;
> +
> +	/* stop DMA, mask IRQ, don't clobber anything else */
> +	ata_eh_freeze_port(ap);

Don't freeze port unconditionally.  You'll end up hardresetting on every
error.  Just make sure DMA engine is stopped and the controller is in a
sane state.  If that fails, then, the port should be frozen.

> +	hardreset = NULL;
> +	if (sata_scr_valid(ap)) {
> +		ehc->i.action |= ATA_EH_HARDRESET;

Why always force HARDRESET?

> +		hardreset = sata_std_hardreset;
> +	}

-- 
tejun

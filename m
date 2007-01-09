Return-Path: <linux-kernel-owner+w=401wt.eu-S1751275AbXAIKQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbXAIKQM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbXAIKQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:16:11 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33346 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbXAIKQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:16:10 -0500
Message-ID: <45A36B68.1080204@garzik.org>
Date: Tue, 09 Jan 2007 05:16:08 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc4 1/2] sata_promise: TX2plus PATA support
References: <200701090950.l099oRPU011573@harpo.it.uu.se>
In-Reply-To: <200701090950.l099oRPU011573@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> @@ -271,6 +272,11 @@ static int pdc_port_start(struct ata_por
>  	struct pdc_port_priv *pp;
>  	int rc;
>  
> +	/* fix up port flags and cable type for SATA+PATA chips */
> +	ap->flags |= hp->port_flags[ap->port_no];
> +	if (ap->flags & ATA_FLAG_SATA)
> +		ap->cbl = ATA_CBL_SATA;
> +
>  	rc = ata_port_start(ap);
>  	if (rc)
>  		return rc;
> @@ -377,7 +383,7 @@ static void pdc_pata_phy_reset(struct at
>  
>  static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
>  {
> -	if (sc_reg > SCR_CONTROL)
> +	if (sc_reg > SCR_CONTROL || ap->cbl != ATA_CBL_SATA)
>  		return 0xffffffffU;
>  	return readl((void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
>  }
> @@ -386,7 +392,7 @@ static u32 pdc_sata_scr_read (struct ata
>  static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
>  			       u32 val)
>  {
> -	if (sc_reg > SCR_CONTROL)
> +	if (sc_reg > SCR_CONTROL || ap->cbl != ATA_CBL_SATA)
>  		return;
>  	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
>  }


It would be nice to see a [tested] follow-up patch that separates SATA 
and PATA into two separate sets of ata_port_operations hooks.  That 
should eliminate these 'ap->cbl' tests, and some other tests.

You should be able to set ap->ops in the same manner as you are setting 
the flags now.

	Jeff



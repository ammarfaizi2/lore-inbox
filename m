Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWAaPKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWAaPKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWAaPKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:10:55 -0500
Received: from [85.8.13.51] ([85.8.13.51]:48354 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750873AbWAaPKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:10:54 -0500
Message-ID: <43DF7E01.9030204@drzeus.cx>
Date: Tue, 31 Jan 2006 16:10:57 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: linux-kernel@vger.kernel.org,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 4/5] MMC OMAP driver
References: <43DF683C.4080301@indt.org.br>
In-Reply-To: <43DF683C.4080301@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
> Some MMC cards don't set the R1_READY_FOR_DATA bit if EOFB
> interrupt comes first. In this case we need to mask R1_READY_FOR_DATA
> to avoid polling card status forever.
> This patch needs to be discussed as it requires interface change.
> This interface change is done here only for omap for now.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 

> @@ -336,6 +342,7 @@ static struct mmc_blk_data *mmc_blk_allo
> 
>  	card_ready:
> 
> +card_ready:
>  		/*
>  		 * As discussed on lkml, GENHD_FL_REMOVABLE should:
>  		 *

This chunk seems incorrect.

> @@ -542,10 +547,19 @@ static irqreturn_t mmc_omap_irq(int irq,
>  		    (!(status & OMAP_MMC_STAT_A_EMPTY))) {
>  			end_command = 1;
>  		}
> +		/* Some cards produce EOFB interrupt and never
> +		 * raise R1_READY_FOR_DATA bit after that.
> +		 * To avoid infinite card status polling loop,
> +		 * we must fake that bit to MMC layer.
> +		 */
> +		if ((status & OMAP_MMC_STAT_END_OF_CMD) &&
> +				(status & OMAP_MMC_STAT_END_BUSY)) {
> +			card_ready = 1;
> +		}
>  	}
> 
>  	if (end_command) {
> -		mmc_omap_cmd_done(host, host->cmd);
> +		mmc_omap_cmd_done(host, host->cmd, card_ready);
>  	}
>  	if (transfer_error)
>  		mmc_omap_xfer_done(host, host->data);

This sounds highly suspicious. Have you tried the card on another
controller? I do not like this mix of fixing it both in the driver and
in the MMC layer. Either it's a hardware issue and should be fixed in
the driver, or it's a generic problem and should be fixed in the MMC layer.

Rgds
Pierre


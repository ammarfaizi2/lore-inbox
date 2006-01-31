Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWAaPDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWAaPDD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWAaPDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:03:03 -0500
Received: from [85.8.13.51] ([85.8.13.51]:46050 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750920AbWAaPDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:03:02 -0500
Message-ID: <43DF7C1F.8020304@drzeus.cx>
Date: Tue, 31 Jan 2006 16:02:55 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: linux-kernel@vger.kernel.org,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 3/5] MMC OMAP driver
References: <43DF6807.9020907@indt.org.br>
In-Reply-To: <43DF6807.9020907@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
> Here are some misc fixes we've had in the OMAP tree. Might be worth
> testing them on other platforms too.
> 
> Index: linux-2.6.15-mmc_omap/drivers/mmc/mmc.c
> ===================================================================
> --- linux-2.6.15-mmc_omap.orig/drivers/mmc/mmc.c	2006-01-30 10:24:50.000000000 -0400
> +++ linux-2.6.15-mmc_omap/drivers/mmc/mmc.c	2006-01-30 10:25:19.000000000 -0400
> @@ -704,6 +704,7 @@ static void mmc_power_up(struct mmc_host
>  	int bit = fls(host->ocr_avail) - 1;
> 
>  	host->ios.vdd = bit;
> +	host->ios.clock = host->f_min;
>  	host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
>  	host->ios.chip_select = MMC_CS_DONTCARE;
>  	host->ios.power_mode = MMC_POWER_UP;
> @@ -712,7 +713,6 @@ static void mmc_power_up(struct mmc_host
> 
>  	mmc_delay(1);
> 
> -	host->ios.clock = host->f_min;
>  	host->ios.power_mode = MMC_POWER_ON;
>  	host->ops->set_ios(host, &host->ios);
> 

Why? What you're doing there is enable the clock at the same time as the
 power, instead of just the power first. To me, that seems less safe.

> @@ -747,6 +747,7 @@ static int mmc_send_op_cond(struct mmc_h
>  		if (cmd.resp[0] & MMC_CARD_BUSY || ocr == 0)
>  			break;
> 
> +		mmc_delay(1);
>  		err = MMC_ERR_TIMEOUT;
> 
>  		mmc_delay(10);

This seems particularly useless. Probably just a remnant from a separate
mmc_delay() addition to the one that's in mainline now.

Rgds
Pierre


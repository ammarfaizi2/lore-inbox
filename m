Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWJVJzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWJVJzS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 05:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWJVJzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 05:55:18 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:60305 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932318AbWJVJzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 05:55:16 -0400
Message-ID: <453B4005.8080501@drzeus.cx>
Date: Sun, 22 Oct 2006 11:55:17 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Timo Teras <timo.teras@solidboot.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: MMC: When rescanning cards check existing cards after mmc_setup()
References: <20061016090609.GB17596@mail.solidboot.com>
In-Reply-To: <20061016090609.GB17596@mail.solidboot.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about not responding sooner. I've been a bit swamped.

Timo Teras wrote:
> Some broken cards seem to process CMD1 even in stand-by state. The result is
> that the card replies with ILLEGAL_COMMAND error for the next command sent
> after rescanning. Currently the next command is select card, which would
> return the error. But the CMD7 does actually succeed and retries of the
> command will timeout. The solution is to poll card status after the CMD1
> which clears the cached error.
>
> Signed-off-by: Timo Teras <timo.teras@solidboot.com>
>
>   

I take it these cards do not reply to CMD2?

> ---
>
>  drivers/mmc/mmc.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> 97675ada7049d12523aa9e9908d4613dfd333641
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index ee8863c..3324b6e 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -1178,14 +1178,17 @@ static void mmc_rescan(void *data)
>  {
>  	struct mmc_host *host = data;
>  	struct list_head *l, *n;
> +	unsigned char power_mode;
>  
>  	mmc_claim_host(host);
>  
> -	if (host->ios.power_mode == MMC_POWER_ON)
> -		mmc_check_cards(host);
> +	power_mode = host->ios.power_mode;
>  
>  	mmc_setup(host);
>  
> +	if (power_mode == MMC_POWER_ON)
> +		mmc_check_cards(host);
> +
>  	if (!list_empty(&host->cards)) {
>  		/*
>  		 * (Re-)calculate the fastest clock rate which the
>   

This change is ok right now, but might come back to bite us in the
future if we implement more intelligent voltage selection (right now new
cards will have to make due with what's already selected).

If we check cards on both sides of mmc_setup(), then we should be covered.

Also, please add some comments about why we do this. Otherwise it will
run the risk of getting removed in the future.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org


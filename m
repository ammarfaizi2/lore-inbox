Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWAIW3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWAIW3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWAIW3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:29:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39698 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751573AbWAIW3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:29:16 -0500
Date: Mon, 9 Jan 2006 22:29:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
Subject: Re: [patch 1/5] Add MMC password protection (lock/unlock) support V3
Message-ID: <20060109222902.GF19131@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	linux-kernel@vger.kernel.org,
	"Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>,
	linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
	Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
	"Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
	"Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
References: <43C2E064.90500@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C2E064.90500@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please send patches as text/plain - it makes it difficult to reply to
them otherwise.

On Mon, Jan 09, 2006 at 06:15:00PM -0400, Anderson Briglia wrote:
> When a card is locked, only commands from the "basic" and "lock card" classes
> are accepted. To be able to use the other commands, the card must be unlocked
> first.

I don't think this works as you intend.

When a card is initially inserted, we discover the cards via mmc_setup()
and mmc_discover_cards().  This means that we'll never set the locked
status for newly inserted cards.

> ===================================================================
> --- linux-2.6.15-rc4.orig/drivers/mmc/mmc.c	2005-12-15 14:06:52.000000000 -0400
> +++ linux-2.6.15-rc4/drivers/mmc/mmc.c	2005-12-15 17:00:37.000000000 -0400
> @@ -986,10 +986,15 @@ static void mmc_check_cards(struct mmc_h
>  		cmd.flags = MMC_RSP_R1;
>  
>  		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
> -		if (err == MMC_ERR_NONE)
> +		if (err != MMC_ERR_NONE) {
> +			mmc_card_set_dead(card);
>  			continue;
> +		}
>  
> -		mmc_card_set_dead(card);
> +		if (cmd.resp[0] & R1_CARD_IS_LOCKED)
> +			mmc_card_set_locked(card);
> +		else
> +			card->state &= ~MMC_STATE_LOCKED;

We need a mmc_card_clear_locked() here.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

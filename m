Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWJJGR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWJJGR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWJJGR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:17:27 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:65167 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S964969AbWJJGR0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:17:26 -0400
Message-ID: <452B3B00.5080209@drzeus.cx>
Date: Tue, 10 Oct 2006 08:17:36 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: philipl@overt.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 1/1] mmc: Add support for mmc v4 high speed mode
References: <21173.67.169.45.37.1159940502.squirrel@overt.org>
In-Reply-To: <21173.67.169.45.37.1159940502.squirrel@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

philipl@overt.org wrote:
> Hi Pierre,
>
> I couldn't wait to do this, so here's the updated diff :-)
>
> I've taken your previous comments to heart and I believe that
> this can probably just be a single diff, but if you want me to
> split it out, just ask.
>   

This patch is small and self contained, so it will do just fine.

> This adds support for the high-speed modes defined by mmc v4
> (assuming the host controller is up to it). On a TI sdhci controller,
> it improves read speed from 1.3MBps to 2.3MBps. The TI controller can
> only go up to 24MHz, but everything helps. Another person has taken
> this basic patch and used it on a Nokia 770 to get a bigger boost
> because that controller can run at 48MHZ.
>
> Thanks,
>
> --phil
>
> Signed-off-by: Philip Langdale <philipl@overt.org>
> ---
>
>  drivers/mmc/mmc.c            |  110 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mmc/card.h     |    8 +++
>  include/linux/mmc/protocol.h |   16 +++++-
>  3 files changed, 129 insertions(+), 5 deletions(-)
>
> diff -urN /usr/src/linux-2.6.18/drivers/mmc/mmc.c linux-2.6.18-mmc4/drivers/mmc/mmc.c
> --- /usr/src/linux-2.6.18/drivers/mmc/mmc.c	2006-09-19 20:42:06.000000000 -0700
> +++ linux-2.6.18-mmc4/drivers/mmc/mmc.c	2006-10-03 22:14:05.000000000 -0700
> @@ -4,6 +4,7 @@
>   *  Copyright (C) 2003-2004 Russell King, All Rights Reserved.
>   *  SD support Copyright (C) 2004 Ian Molton, All Rights Reserved.
>   *  SD support Copyright (C) 2005 Pierre Ossman, All Rights Reserved.
> + *  MMCv4 support Copyright (C) 2006 Philip Langdale, All Rights Reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -427,6 +428,30 @@
>  		}
>  	}
>
> +	/* Activate highspeed MMC v4 support. */
> +	if (card->csd.mmca_vsn == CSD_SPEC_VER_4) {
> +		struct mmc_command cmd;
> +
> +                /*
> +                 * Arg breakdown:
> +                 * [31:26] Set to 0
> +                 * [25:24] Access: Write Byte (0x03)
> +                 * [23:16] Index: HS_TIMING (0xB9)
> +                 * [15:08] Value: True (0x01)
> +                 * [07:03] Set to 0
> +                 * [02:00] Cmd Set: Standard (0x00)
> +                 */
> +		cmd.opcode = MMC_SWITCH;
> +	 	cmd.arg = 0x03B90100;
>   

I'd prefer some defines and shifts here. Also, this should be done at
init, not at select. The reason SD does it is that the spec says it
drops out of wide mode when it gets unselected.

> @@ -1032,8 +1125,19 @@
>  	unsigned int max_dtr = host->f_max;
>
>  	list_for_each_entry(card, &host->cards, node)
> -		if (!mmc_card_dead(card) && max_dtr > card->csd.max_dtr)
> -			max_dtr = card->csd.max_dtr;
> +		if (!mmc_card_dead(card)) {
> +			if (mmc_card_highspeed(card))
> +				if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_52) &&
> +				    max_dtr > 52000000)
> +					max_dtr = 52000000;
> +				else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_26) &&
> +					 max_dtr > 26000000)
> +					max_dtr = 26000000;
> +				else /* mmc v4 spec says this cannot happen */
> +					BUG_ON(card->ext_csd.card_type == 0);
> +			else if (max_dtr > card->csd.max_dtr)
> +				max_dtr = card->csd.max_dtr;
> +		}
>
>  	pr_debug("%s: selected %d.%03dMHz transfer rate\n",
>  		 mmc_hostname(host),
>   

A "max_dtr" int the mmc_ext_csd structure would be nicer here. And you
cannot do a kernel BUG because the card is broken. You should mark it as
dead.

Rgds
Pierre


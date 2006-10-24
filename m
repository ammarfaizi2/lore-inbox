Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161186AbWJXTFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbWJXTFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbWJXTFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:05:52 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:19602 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1161186AbWJXTFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:05:52 -0400
Message-ID: <453E6410.4050002@drzeus.cx>
Date: Tue, 24 Oct 2006 21:05:52 +0200
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: philipl@overt.org
CC: linux-kernel@vger.kernel.org, Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: Re: [PATCH 2.6.18 RFC] mmc: Add support for mmc v4 wide-bus modes
References: <21572.67.169.45.37.1160853308.squirrel@overt.org>
In-Reply-To: <21572.67.169.45.37.1160853308.squirrel@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

philipl@overt.org wrote:
> Hi Pierre, Jarkko,
> 

Hi Philip,

I've finally gotten around to reviewing this patch. :)

> Here's the next change to add support for switching into the wide-bus
> modes. It obviously builds on top of the previous high-speed patch.
> 
> Wide-bus is a more confusing situation for two reasons that I've
> mentioned in passing before, but which I now need to go into more
> detail about:
> 
> 1) Bus testing:

Problems aside, from what I can see in the application note (in
particular the flow charts), this part is optional. So I'd like to see
this as a separate feature.

> 
> 2) Power classes: The mmc v4 spec allows a card to indicate that it would
> like to draw more current than normal when running in wide-bus modes. It
> defines separate power classes for each combination of 26/52MHZ and 4/8bit.
> We currently don't have the infrastructure to query whether a higher power
> level is safe, and I suspect we don't even have that information for some
> of the support controllers. eg: the SDHCI spec doesn't say anything about
> current draw.

Actually, SDHCI controller state how much power they can supply at
different voltages. So the information is there in that case. But I
think we'll see how much of a problem it is in practice first.

> 
> Theoretically, those numbers should be 1.5, 3 and 12 MBps respectively, so there's
> some overhead in there growing faster than the theoretical transfer rate - but that's
> a separate problem. :-)
> 

oprofile to the rescue ;)

> +
> +	cmd.opcode = MMC_BUSTEST_W;
> +	cmd.arg = 0;
> +	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> +

The application note seemed to indicate that it's R1b here.

> +	data.blksz_bits = 1;

blksz_bits is no more. What tree are you doing your development against? :)

> @@ -1029,10 +1136,9 @@
>  			       "any high-speed modes.\n",
>  				mmc_hostname(card->host));
>  			mmc_card_set_bad(card);
> -			/* printk a warning */
>  			continue;
>  		}
> -
> +
>  		/* Activate highspeed support. */
>  		cmd.opcode = MMC_SWITCH;
>  		cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |

Huh?

> @@ -1050,6 +1156,56 @@
>  		}
> 
>  		mmc_card_set_highspeed(card);
> +
> +		/* Check for host support for wide-bus modes. */
> +		if (host->caps & MMC_CAP_8_BIT_DATA) {
> +			host_bus_width = MMC_BUS_WIDTH_8;
> +			card_bus_width = EXT_CSD_BUS_WIDTH_8;
> +		} else if (host->caps & MMC_CAP_4_BIT_DATA) {
> +			host_bus_width = MMC_BUS_WIDTH_4;
> +			card_bus_width = EXT_CSD_BUS_WIDTH_4;
> +		} else {
> +			continue;
> +		}
> +

A bit of premature optimisation. Do the if:s when needed instead. It
keeps the code readable.

> +#if 0

Never acceptable. Keep such stuff in your development tree.

> +
> +		/*
> +		 * MMC v4 cards can indicate they would like to draw more
> +		 * than the default amount of current in wide-bus modes.
> +		 * We currently don't have an infrastructure to query the host
> +		 * as to whether these higher levels are safe - so we will
> +		 * never switch the card into a higher draw mode.
> +		 * Supposedly, allowing the card to draw more current will
> +		 * let it perform better, but the specs seem to indicate that
> +		 * the card will function correctly without the mode change.
> +		 * Empirical testing supports this interpretation.
> +		 */

It's sufficient to have this in the commit message.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

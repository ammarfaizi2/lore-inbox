Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWJCRuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWJCRuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbWJCRuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:50:25 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:25743 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1030376AbWJCRuY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:50:24 -0400
Message-ID: <4522A2DD.9080803@drzeus.cx>
Date: Tue, 03 Oct 2006 19:50:21 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: philipl@overt.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 2/2] mmc: Read mmc v4 EXT_CSD
References: <15151.67.169.45.37.1159744878.squirrel@overt.org>
In-Reply-To: <15151.67.169.45.37.1159744878.squirrel@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

philipl@overt.org wrote:
> +	list_for_each_entry(card, &host->cards, node) {
> +		if (card->state & (MMC_STATE_DEAD|MMC_STATE_PRESENT))
> +			continue;
>   

Please use the macros.

> +		if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
> +			continue;
> +
>   

You need to check that the card isn't SD before you can look at that
part of the csd structure. BUG_ON or similar is acceptable if you
consider it an error to call this function if SD cards are present.

> +		err = mmc_select_card(host, card);
> +		if (err != MMC_ERR_NONE) {
> +			mmc_card_set_dead(card);
> +			continue;
> +		}
> +
> +		memset(&cmd, 0, sizeof(struct mmc_command));
> +
> +		cmd.opcode = MMC_SEND_EXT_CSD;
> +		cmd.arg = 0;
> +		cmd.flags = MMC_RSP_R1;
> +
> +		memset(&data, 0, sizeof(struct mmc_data));
> +
> +		data.timeout_ns = card->csd.tacc_ns * 10;
> +		data.timeout_clks = card->csd.tacc_clks * 10;
>   

We have a new function for setting timeouts that you should use called
mmc_set_data_timeout().

Rgds
Pierre


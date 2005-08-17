Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVHQWy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVHQWy1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 18:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVHQWy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 18:54:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8082 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751309AbVHQWy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 18:54:26 -0400
Date: Wed, 17 Aug 2005 15:56:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Multi-sector writes
Message-Id: <20050817155641.12bb20fc.akpm@osdl.org>
In-Reply-To: <42FF3C05.70606@drzeus.cx>
References: <42FF3C05.70606@drzeus.cx>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>
> Adds support for writing multiple sectors at once. This allows
> back-to-back transfers of sectors giving roughly double write throughput.
> 
> To be able to detect which sector is causing problems the system falls
> back to single sector writes if a failure is detected.
> 
> ...
> --- linux-wbsd/drivers/mmc/mmc_block.c	(revision 77)
> +++ linux-wbsd/drivers/mmc/mmc_block.c	(working copy)
> @@ -166,9 +166,25 @@
>  	struct mmc_blk_data *md = mq->data;
>  	struct mmc_card *card = md->queue.card;
>  	int ret;
> +	
> +#ifdef CONFIG_MMC_BULKTRANSFER
> +	int failsafe;
> +#endif
>  
>  	if (mmc_card_claim_host(card))
>  		goto cmd_err;
> +	
> +#ifdef CONFIG_MMC_BULKTRANSFER
> +	/*
> +	 * We first try transfering multiple blocks. If this fails
> +	 * we fall back to single block transfers.
> +	 *
> +	 * This gives us good performance when all is well and the
> +	 * possibility to determine which sector fails when all
> +	 * is not well.
> +	 */
> +	failsafe = 0;
> +#endif
> 

The fact that this is enabled under the experimental
CONFIG_MMC_BULKTRANSFER seems unfortunate.  I mean, if the code works OK
then we should just enable it unconditionally, no?

I'm thinking that it would be better to not have the config option there
and then re-add it late in the 2.6.14 cycle if someone reports problems
which cannot be fixed.  Or at least make it default to 'y' so we get more
testing coverage, then remove the config option later.  Or something.

Thoughts?

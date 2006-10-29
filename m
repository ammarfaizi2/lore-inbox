Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWJ2JtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWJ2JtM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 04:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWJ2JtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 04:49:12 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:13459 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932140AbWJ2JtK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 04:49:10 -0500
Message-ID: <45447914.7070101@drzeus.cx>
Date: Sun, 29 Oct 2006 10:49:08 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
CC: linux-kernel@vger.kernel.org, linux-omap-open-source@linux.omap.com,
       David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, ilias.biris@indt.org.br
Subject: Re: [patch 3/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V5
References: <20061020164914.012378000@localhost.localdomain> <20061020165135.162482000@localhost.localdomain>
In-Reply-To: <20061020165135.162482000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Aguiar wrote:
> @@ -1071,10 +1074,10 @@ static void mmc_check_cards(struct mmc_h
>  		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>  
>  		err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
> -		if (err == MMC_ERR_NONE)
> +		if (err != MMC_ERR_NONE) {
> +			mmc_card_set_dead(card);
>  			continue;
> -
> -		mmc_card_set_dead(card);
> +		}
>  	}
>  }
>  
>   

This seems like a pointless change.

> @@ -1160,6 +1163,139 @@ static void mmc_setup(struct mmc_host *h
>  		mmc_read_scrs(host);
>  }
>  
> +/* Calculate the minimal blksz_bits to hold x bytes. */
> +static inline int blksz_bits(unsigned x)
> +{
> +	return fls(x-1);
> +}
> +
>   

blksz_bits is gone, so this is superfluous. Note Russell's comment about
looking at the MMC_CAP_BYTEBLOCK capability, something you do not do
right now.

> +/**
> + *	mmc_lock_unlock - send LOCK_UNLOCK command to a specific card.
> + *	@card: card to which the LOCK_UNLOCK command should be sent
> + *	@key: key containing the MMC password
> + *	@mode: LOCK_UNLOCK mode
> + *
> + */
> +int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode)
> +{
> +	struct mmc_request mrq;
> +	struct mmc_command cmd;
> +	struct mmc_data data;
> +	struct scatterlist sg;
> +	struct mmc_key_payload *mpayload;
> +	unsigned long erase_timeout;
> +	int err, data_size;
> +	u8 *data_buf;
> +
> +	mpayload = NULL;
> +	data_size = 1;
> +	if (mode != MMC_LOCK_MODE_ERASE) {
> +		mpayload = rcu_dereference(key->payload.data);
> +		data_size = 2 + mpayload->datalen;
> +	}
> +
> +	data_buf = kmalloc(data_size, GFP_KERNEL);
>   

For something that can be at most 34 bytes, a kmalloc seems excessive.
Put it on the stack. Just remember to have checks so we do not overflow.

> +	if (!data_buf)
> +		return -ENOMEM;
> +	memset(data_buf, 0, data_size);
> +
> +	data_buf[0] = mode;
> +	if (mode != MMC_LOCK_MODE_ERASE) {
> +		data_buf[1] = mpayload->datalen;
> +		memcpy(data_buf + 2, mpayload->data, mpayload->datalen);
> +	}
> +
> +	err = mmc_card_claim_host(card);
> +	if (err != MMC_ERR_NONE) {
> +		mmc_card_set_dead(card);
> +		goto out;
> +	}
>   

Locking should be done outside this function to avoid races.

Also, why mark the card as dead because you cannot select it? It might
just be a temporary failure.

> +
> +	memset(&cmd, 0, sizeof(struct mmc_command));
> +
> +	cmd.opcode = MMC_SET_BLOCKLEN;
> +	cmd.arg = data_size;
> +	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> +	err = mmc_wait_for_cmd(card->host, &cmd, CMD_RETRIES);
> +	if (err != MMC_ERR_NONE) {
> +		mmc_card_set_dead(card);
> +		goto error;
> +	}
>   

Same here.

> +
> +	sg_init_one(&sg, data_buf, data_size);
> +	err = mmc_wait_for_req(card->host, &mrq);
> +	if (err != MMC_ERR_NONE) {
> +		if(err != MMC_ERR_INVALID)
> +			mmc_card_set_dead(card);
> +		goto error;
> +	}
>   

Dito.

> +
> +EXPORT_SYMBOL(mmc_lock_unlock);
>   

Why would anything but mmc_core need to use this?

>  
>  /**
>   *	mmc_detect_change - process change of state on a MMC socket
> Index: linux-2.6.18/include/linux/mmc/card.h
> ===================================================================
> --- linux-2.6.18.orig/include/linux/mmc/card.h	2006-10-20 12:37:42.000000000 -0400
> +++ linux-2.6.18/include/linux/mmc/card.h	2006-10-20 12:38:18.000000000 -0400
> @@ -117,4 +117,8 @@ static inline int mmc_card_claim_host(st
>  
>  #define mmc_card_release_host(c)	mmc_release_host((c)->host)
>  
> +struct key;
> +
> +extern int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode);
> +
>  #endif
>   

Which means this should go away (and put in drivers/mmc/mmc.h).

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org


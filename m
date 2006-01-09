Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWAIWdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWAIWdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWAIWdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:33:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16396 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751580AbWAIWdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:33:02 -0500
Date: Mon, 9 Jan 2006 22:32:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
Subject: Re: [patch 2/5] Add MMC password protection (lock/unlock) support V3
Message-ID: <20060109223255.GG19131@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	linux-kernel@vger.kernel.org,
	"Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>,
	linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
	Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
	"Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
	"Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
References: <43C2E087.1090608@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C2E087.1090608@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 06:15:35PM -0400, Anderson Briglia wrote:
> +	cmd.opcode = MMC_LOCK_UNLOCK;
> +	cmd.arg = 0;
> +	cmd.flags = MMC_RSP_R1B;
> +
> +	memset(&data, 0, sizeof(struct mmc_data));
> +
> +	data.timeout_ns = card->csd.tacc_ns * 10;
> +	data.timeout_clks = card->csd.tacc_clks * 10;
> +	data.blksz_bits = blksz_bits(data_size);
> +	data.blocks = 1;
> +	data.flags = MMC_DATA_WRITE;
> +	data.sg = &sg;
> +	data.sg_len = 1;
> +
> +	memset(&mrq, 0, sizeof(struct mmc_request));
> +
> +	mrq.cmd = &cmd;
> +	mrq.data = &data;
> +
> +	sg_init_one(&sg, data_buf, data_size);
> +	err = mmc_wait_for_req(card->host, &mrq);
> +	if (err != MMC_ERR_NONE) {
> +		mmc_card_set_dead(card);
> +		goto error;
> +	}

If the command error is MMC_ERR_INVALID, this means the host doesn't
support this operation, so we shouldn't set the card "dead".

> +        memset(&cmd, 0, sizeof(struct mmc_command));

The ugly formatting monster makes an appearance.  Tabs please.

> Index: linux-2.6.15-rc4/include/linux/mmc/host.h
> ===================================================================
> --- linux-2.6.15-rc4.orig/include/linux/mmc/host.h	2006-01-08 07:35:39.069715192 -0400
> +++ linux-2.6.15-rc4/include/linux/mmc/host.h	2006-01-08 07:49:40.763758248 -0400
> @@ -83,6 +83,7 @@
>  	u32			ocr_avail;
>  
>  	unsigned long		caps;		/* Host capabilities */
> +	int                     pwd_support;    /* MMC password support */
>  
>  #define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers */
>  

And this means we don't need the "pwd_support" thing here.  Even
if we did, it should be a host capability, not an "int".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

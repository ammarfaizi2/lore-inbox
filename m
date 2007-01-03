Return-Path: <linux-kernel-owner+w=401wt.eu-S932128AbXACVGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbXACVGA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbXACVGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:06:00 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40147 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128AbXACVF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:05:58 -0500
Message-ID: <459C1ABB.3090500@drzeus.cx>
Date: Wed, 03 Jan 2007 22:06:03 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Philip Langdale <philipl@overt.org>
CC: linux-kernel@vger.kernel.org, John Gilmore <gnu@toad.com>
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards (Take 2)
References: <459928F3.9010804@overt.org>
In-Reply-To: <459928F3.9010804@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Langdale wrote:
> @@ -1386,10 +1420,37 @@
>  	 * all get the idea that they should be ready for CMD2.
>  	 * (My SanDisk card seems to need this.)
>  	 */
> -	if (host->mode == MMC_MODE_SD)
> -		mmc_send_app_op_cond(host, host->ocr, NULL);
> -	else
> +	if (host->mode == MMC_MODE_SD) {
> +		struct mmc_command cmd;
> +		int err, ocr = host->ocr;
> +		static const u8 test_pattern = 0xAA;
> +	
> +		/*
> +	 	* To support SD 2.0 cards, we must always invoke SD_SEND_IF_COND
> +	 	* before SD_APP_OP_COND. This command will harmlessly fail for
> +	 	* SD 1.0 cards.
> +	 	*/
> +		cmd.opcode = SD_SEND_IF_COND;
> +		cmd.arg = ((host->ocr & 0xFF8000) != 0) << 8 | test_pattern;
> +		cmd.flags = MMC_RSP_R7 | MMC_CMD_BCR;
> +	
> +		err = mmc_wait_for_cmd(host, &cmd, 0);
> +		if (err != MMC_ERR_NONE ||
> +		    (cmd.resp[0] & 0xFF) == test_pattern) {
> +			if (err == MMC_ERR_NONE) {
> +				/*
> +				 * If SD_SEND_IF_COND succeeded, we are dealing
> +				 * with an SD 2.0 compliant card and we should
> +				 * set bit 30 of the ocr to indicate that we
> +				 * can handle block-addressed SDHC cards.
> +				 */
> +				ocr |= 1 << 30;
> +			}
> +			mmc_send_app_op_cond(host, ocr, NULL);
> +		}
> +	} else {
>  		mmc_send_op_cond(host, host->ocr, NULL);
> +	}
>
>  	mmc_discover_cards(host);
>
>   

Nah... I think a mmc_send_if_cond() would be cleaner. The setup routine
should contain the sequence of events needed, while we abstract the
really low level grunt work into functions.

(more on that subject as soon as kernel.org has finished mirroring ;))

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org


Return-Path: <linux-kernel-owner+w=401wt.eu-S933135AbWLaLqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933135AbWLaLqt (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 06:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933136AbWLaLqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 06:46:49 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40005 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933135AbWLaLqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 06:46:48 -0500
Message-ID: <4597A327.8030408@drzeus.cx>
Date: Sun, 31 Dec 2006 12:46:47 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Philip Langdale <plangdale@vmware.com>
CC: linux-kernel@vger.kernel.org, John Gilmore <gnu@toad.com>
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards
References: <458C22C0.1080307@vmware.com>
In-Reply-To: <458C22C0.1080307@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Langdale wrote:
> Hi all,
>
>
>   

*snip*

> Signed-off-by: Philipl Langdale <philipl@overt.org>
>   

When you have a commit message larger than the patch, you know there is
something wrong. ;)

Please skip the part about MMC at least.

> @@ -588,12 +591,15 @@
>
>  	if (mmc_card_sd(card)) {
>  		csd_struct = UNSTUFF_BITS(resp, 126, 2);
> -		if (csd_struct != 0) {
> +		if (csd_struct != 0 && csd_struct != 1) {
>  			printk("%s: unrecognised CSD structure version %d\n",
>  				mmc_hostname(card->host), csd_struct);
>  			mmc_card_set_bad(card);
>  			return;
>  		}
> +		if (csd_struct == 1) {
> +			mmc_card_set_blockaddr(card);
> +		}
>
>  		m = UNSTUFF_BITS(resp, 115, 4);
>  		e = UNSTUFF_BITS(resp, 112, 3);
>   

Actually, the way the spec describes version 2.0 of the CSD leaves my
stomach a bit upset. I think we will find cards that put bogus values in
the fields, expecting most hosts to use the well defined values. So I'd
prefer a switch statement here, where csd_struct == 1 results in hard
coded values for many fields.

> @@ -824,6 +835,25 @@
>  {
>  	struct mmc_command cmd;
>  	int i, err = 0;
> +	static const u8 test_pattern = 0xAA;
> +
> +	/*
> +	 * To support SD 2.0 cards, we must always invoke SD_SEND_IF_COND
> +	 * before SD_APP_OP_COND. This command will harmlessly fail for
> +	 * SD 1.0 and MMC cards (fortunately including MMC 4 cards).
> +	 */
> +	cmd.opcode = SD_SEND_IF_COND;
> +	cmd.arg = ((host->ocr_avail & 0xFF8000) != 0) << 8 | test_pattern;
> +	cmd.flags = MMC_RSP_R7 | MMC_CMD_BCR;
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err == MMC_ERR_NONE) {
> +		if ((cmd.resp[0] & 0xFF) != test_pattern) {
> +			return MMC_ERR_FAILED;
> +		} else if (ocr != 0) {
> +			ocr |= 1 << 30;
> +		}
> +	}
>
>  	cmd.opcode = SD_APP_OP_COND;
>  	cmd.arg = ocr;
>   

Put this in mmc_setup() with the rest of the initialisation. Hiding in
here just confuses things.

Also, please add a comment about why you manipulate the ocr.

> @@ -43,6 +43,7 @@
>  #define MMC_RSP_R2	(MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC)
>  #define MMC_RSP_R3	(MMC_RSP_PRESENT)
>  #define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC)
> +#define MMC_RSP_R7	(MMC_RSP_PRESENT|MMC_RSP_CRC)
>
>  #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
>
>   

Wrong. R7 is defined as MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE.

(So is R6 btw, wonder why that is...)

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org


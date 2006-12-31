Return-Path: <linux-kernel-owner+w=401wt.eu-S933156AbWLaMcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156AbWLaMcP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 07:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933157AbWLaMcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 07:32:15 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40016 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933156AbWLaMcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 07:32:14 -0500
Message-ID: <4597ADD2.90700@drzeus.cx>
Date: Sun, 31 Dec 2006 13:32:18 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       dwmw2@infradead.org
Subject: Re: [RFC] MTD driver for MMC cards
References: <200612281418.20643.arnd@arndb.de>
In-Reply-To: <200612281418.20643.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> This is an experiment on how an SD/MMC card could be used in the MTD layer.
> I don't currently have a system set up to test this, so this driver is
> completely _untested_ and therefore you should consider it _broken_.
> 
> You can get similar functionality by using the mmc_block driver together
> with block2mtd, so you may wonder what the point of another driver is.
> IMHO, there are two separate advantages from using a special driver:
> 
> * better use of low-level interfaces: the MTD driver can detect the
>   erase block size of the card and erase sectors in advance instead of
>   blocking in the write path. The MTD file systems also expect the
>   underlying interface to be synchronous, so there is little point
>   in using extra kernel threads to operate on the card in the background.
> 

I'm a complete MTD noob, but what uses does the MTD layer have besides JFFS2. If it's none, than this advantage isn't that big of a deal.

> * It becomes possible to use MMC cards with jffs2 even with CONFIG_BLOCK
>   disabled, which can save a significant amount of kernel memory on
>   small machines that have an MMC slot but no other block device.
> 

>From what I've heard, JFFS2 is close to unusuable on the sizes of modern SD/MMC cards. So I'd like to see some more use cases before I'm ready to let this in.

> I still want to be sure that I'm on the right track with this driver
> and did not make a conceptual mistake.
> 

I can comment it from a MMC perspective, but the MTD stuff I will have to assume is correct.

> @@ -616,6 +616,8 @@ static void mmc_decode_csd(struct mmc_ca
>  		csd->r2w_factor = UNSTUFF_BITS(resp, 26, 3);
>  		csd->write_blkbits = UNSTUFF_BITS(resp, 22, 4);
>  		csd->write_partial = UNSTUFF_BITS(resp, 21, 1);
> +		csd->erase_blksize = (UNSTUFF_BITS(resp, 37, 5) + 1) *
> +					(UNSTUFF_BITS(resp, 42, 5) + 1);
>  	} else {
>  		/*
>  		 * We only understand CSD structure v1.1 and v1.2.

NAK. SD uses another format for erase blocks. See the simplified physical spec.

> +/*
> + * transfer a block to/from the card. The block needs to be aligned
> + * to mtd->writesize. If we want to implement an mtd_writev method,
> + * this needs to use stream operations with an appropriate stop
> + * command as well.
> + */
> +static int mmc_mtd_transfer_low(struct mmc_card *card, loff_t off, size_t len,
> +			size_t *retlen, u_char *buf, int write)
> +{
> +	struct scatterlist sg;
> +	struct mmc_data data = {
> +		.blksz = 1 << card->csd.read_blkbits,
> +		.blocks = len >> card->csd.read_blkbits,

First of all, you cannot assume that read_blkbits is a valid block size when doing writes.

Secondly, the cards default in a block size of 512 bytes, so you need to tell the card your desired block size during probe.

> +		.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ,
> +		.sg = &sg,
> +		.sg_len = 1,
> +	};
> +	struct mmc_command cmd = {
> +		.arg = off,
> +		.data = &data,
> +		.flags = MMC_RSP_R1 | MMC_CMD_ADTC,
> +		.opcode = write ? MMC_WRITE_BLOCK : MMC_READ_SINGLE_BLOCK,

You set .blocks above, so I have to assume it can be more than 1. So you need to change the opcodes accordingly.

> +	};
> +	struct mmc_request mrq = {
> +		.cmd = &cmd,
> +		.data = &data,
> +	};

And it also means you need a stop command.

> +
> +	/* copied from the block driver, don't understand why this is needed */

Now this gives me a bad feeling. Have you read any spec about the MMC protocol or are you just winging it?

It is needed because the card goes into programming state after a write, where it is very unresponsive to other commands.

> +
> +	ret = mmc_card_claim_host(card);
> +	if (ret) {
> +		dev_warn(&card->dev, "%s: mmc_card_claim_host returned %d\n",
> +			__FUNCTION__, ret);
> +		ret = -EIO;
> +		goto error;
> +	}

mmc_card_claim_host() is currently very stupid in that it requires you to call mmc_card_release_host() on error. I intend to fix that some time in the future.

> +/*
> + * Initialize an mmc card. We create a new MTD device for each
> + * MMC card we find. The operations are rather straightforward,
> + * so we don't even need our own data structure to contain the
> + * mtd_info.
> + */
> +static int mmc_mtd_probe(struct mmc_card *card)
> +{
> +	struct mtd_info *mtd;
> +	int ret;
> +
> +	if (!(card->csd.cmdclass & CCC_ERASE))
> +		return -ENODEV;
> +

You should probably check for CCC_BLOCK_READ here.

And your driver needs to check if the card support writes (both by mmc_card_readonly() and CCC_BLOCK_WRITE).

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

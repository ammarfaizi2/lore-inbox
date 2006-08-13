Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWHMKEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWHMKEl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 06:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWHMKEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 06:04:41 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:41104 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750874AbWHMKEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 06:04:40 -0400
Message-ID: <44DEFBA1.6060500@reactivated.net>
Date: Sun, 13 Aug 2006 11:14:57 +0100
From: Daniel Drake <dan@reactivated.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060811)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: Matt Reimer <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org,
       rmk+lkml@arm.linux.org.uk
Subject: Re: 2GB MMC/SD cards
References: <447AFE7A.3070401@drzeus.cx> <20060603141548.GA31182@flint.arm.linux.org.uk> <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com> <4481FB80.40709@drzeus.cx> <4484B5AE.8060404@drzeus.cx> <44869794.9080906@drzeus.cx> <20060607165837.GE13165@flint.arm.linux.org.uk> <448738CD.8030907@drzeus.cx> <4488AC57.7050201@drzeus.cx>
In-Reply-To: <4488AC57.7050201@drzeus.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

Pierre Ossman wrote:
> Suggested patch included.

What's the status on this patch? A Gentoo user at 
http://bugs.gentoo.org/142172 reports that it is required for him to be 
able to access his card, so it definitely works in some form.

> 
> [MMC] Always use a sector size of 512 bytes
> 
> Both MMC and SD specifications specify (although a bit unclearly in the MMC
> case) that a sector size of 512 bytes must always be supported by the card.
> 
> Cards can report larger "native" size than this, and cards >= 2 GB even
> must do so. Most other readers use 512 bytes even for these cards. We should
> do the same to be compatible.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> ---
> 
>  drivers/mmc/mmc_block.c |   49 ++++-------------------------------------------
>  1 files changed, 4 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
> index 587458b..96049e2 100644
> --- a/drivers/mmc/mmc_block.c
> +++ b/drivers/mmc/mmc_block.c
> @@ -325,52 +325,11 @@ static struct mmc_blk_data *mmc_blk_allo
>  	md->read_only = mmc_blk_readonly(card);
>  
>  	/*
> -	 * Figure out a workable block size.  MMC cards have:
> -	 *  - two block sizes, one for read and one for write.
> -	 *  - may support partial reads and/or writes
> -	 *    (allows block sizes smaller than specified)
> +	 * Both SD and MMC specifications state (although a bit
> +	 * unclearly in the MMC case) that a block size of 512
> +	 * bytes must always be supported by the card.
>  	 */
> -	md->block_bits = card->csd.read_blkbits;
> -	if (card->csd.write_blkbits != card->csd.read_blkbits) {
> -		if (card->csd.write_blkbits < card->csd.read_blkbits &&
> -		    card->csd.read_partial) {
> -			/*
> -			 * write block size is smaller than read block
> -			 * size, but we support partial reads, so choose
> -			 * the smaller write block size.
> -			 */
> -			md->block_bits = card->csd.write_blkbits;
> -		} else if (card->csd.write_blkbits > card->csd.read_blkbits &&
> -			   card->csd.write_partial) {
> -			/*
> -			 * read block size is smaller than write block
> -			 * size, but we support partial writes.  Use read
> -			 * block size.
> -			 */
> -		} else {
> -			/*
> -			 * We don't support this configuration for writes.
> -			 */
> -			printk(KERN_ERR "%s: unable to select block size for "
> -				"writing (rb%u wb%u rp%u wp%u)\n",
> -				mmc_card_id(card),
> -				1 << card->csd.read_blkbits,
> -				1 << card->csd.write_blkbits,
> -				card->csd.read_partial,
> -				card->csd.write_partial);
> -			md->read_only = 1;
> -		}
> -	}
> -
> -	/*
> -	 * Refuse to allow block sizes smaller than 512 bytes.
> -	 */
> -	if (md->block_bits < 9) {
> -		printk(KERN_ERR "%s: unable to support block size %u\n",
> -			mmc_card_id(card), 1 << md->block_bits);
> -		ret = -EINVAL;
> -		goto err_kfree;
> -	}
> +	md->block_bits = 9;
>  
>  	md->disk = alloc_disk(1 << MMC_SHIFT);
>  	if (md->disk == NULL) {


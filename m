Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbVJ1UPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbVJ1UPE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbVJ1UPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:15:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13331 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030297AbVJ1UPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:15:01 -0400
Date: Fri, 28 Oct 2005 21:14:55 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use command class to determine read-only status.
Message-ID: <20051028201455.GI4464@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <20051028073605.4108.41408.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028073605.4108.41408.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 09:36:05AM +0200, Pierre Ossman wrote:
> If a card doesn't support the "write block" command class then
> any attempts to open the device should reflect this by denying
> write access.

I'd rather we kept printk messages as one printk if at all possible.
How about encapsulating both of these conditions into an inline
function:

static inline int mmc_blk_readonly(struct mmc_card *card)
{
	return mmc_card_readonly(card) ||
	       !(card->csd.cmdclass & CCC_BLOCK_WRITE);
}

> diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
> --- a/drivers/mmc/mmc_block.c
> +++ b/drivers/mmc/mmc_block.c
> @@ -97,7 +97,8 @@ static int mmc_blk_open(struct inode *in
>  		ret = 0;
>  
>  		if ((filp->f_mode & FMODE_WRITE) &&
> -			mmc_card_readonly(md->queue.card))

+		     mmc_blk_readonly(md->queue.card))

>  	printk(KERN_INFO "%s: %s %s %dKiB %s\n",
>  		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
> -		(card->csd.capacity << card->csd.read_blkbits) / 1024,
> -		mmc_card_readonly(card)?"(ro)":"");

+		mmc_blk_readonly(card) ? "(ro)" : "");

As a bonus, I think this makes the code a lot more readable... but
then I am biased. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

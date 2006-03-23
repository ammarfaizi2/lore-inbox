Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWCWPpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWCWPpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 10:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWCWPpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 10:45:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34576 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030252AbWCWPpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 10:45:03 -0500
Date: Thu, 23 Mar 2006 15:44:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Vrabel <dvrabel@cantab.net>
Cc: Pavel Machek <pavel@suse.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ucb1x00 audio & zaurus touchscreen
Message-ID: <20060323154456.GB25849@flint.arm.linux.org.uk>
Mail-Followup-To: David Vrabel <dvrabel@cantab.net>,
	Pavel Machek <pavel@suse.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
	kernel list <linux-kernel@vger.kernel.org>
References: <20060322122052.GN14075@elf.ucw.cz> <4422B370.8010606@cantab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4422B370.8010606@cantab.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 02:40:48PM +0000, David Vrabel wrote:
> @@ -58,9 +65,9 @@
>  	spin_lock_irqsave(&ucb->io_lock, flags);
>  	ucb->io_dir |= out;
>  	ucb->io_dir &= ~in;
> +	spin_unlock_irqrestore(&ucb->io_lock, flags);
>  
>  	ucb1x00_reg_write(ucb, UCB_IO_DIR, ucb->io_dir);
> -	spin_unlock_irqrestore(&ucb->io_lock, flags);

Racy.

> @@ -86,9 +93,9 @@
>  	spin_lock_irqsave(&ucb->io_lock, flags);
>  	ucb->io_out |= set;
>  	ucb->io_out &= ~clear;
> +	spin_unlock_irqrestore(&ucb->io_lock, flags);
>  
>  	ucb1x00_reg_write(ucb, UCB_IO_DATA, ucb->io_out);
> -	spin_unlock_irqrestore(&ucb->io_lock, flags);

Racy.

> @@ -301,22 +305,23 @@
>   */
>  void ucb1x00_disable_irq(struct ucb1x00 *ucb, unsigned int idx, int edges)
>  {
> -	unsigned long flags;
> -
>  	if (idx < 16) {
> -		spin_lock_irqsave(&ucb->lock, flags);
> -
> -		ucb1x00_enable(ucb);
> -		if (edges & UCB_RISING) {
> +		down(&ucb->lock);
> +		/* This can't be right. Can it? */
> +		if (edges & UCB_RISING)
> +			ucb->irq_ris_enbl |= 1 << idx;
> +		if (edges & UCB_FALLING)
> +			ucb->irq_fal_enbl |= 1 << idx;
> +		if (edges & UCB_RISING)
>  			ucb->irq_ris_enbl &= ~(1 << idx);
> -			ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
> -		}
> -		if (edges & UCB_FALLING) {
> +		if (edges & UCB_FALLING)
>  			ucb->irq_fal_enbl &= ~(1 << idx);
> -			ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);
> -		}
> +		up(&ucb->lock);
> +
> +		ucb1x00_enable(ucb);
> +		ucb1x00_reg_write(ucb, UCB_IE_RIS, ucb->irq_ris_enbl);
> +		ucb1x00_reg_write(ucb, UCB_IE_FAL, ucb->irq_fal_enbl);

Racy.

I'm very much of the opinion that while UCB1400 may appear to be vaguely
register compatible with the UCB1200 and UCB1300 devices, it has
sufficiently different requirements which make any attempt at merging
drivers for both devices either racy or hard to read with additional
unnecessary complexity for the 1200 and 1300 devices.

Hence why I've been very reluctant to consider putting the UCB1400
stuff in - because it changes the existing UCB1x00 code in ways I just
don't like.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

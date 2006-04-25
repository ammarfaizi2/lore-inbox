Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWDYNWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWDYNWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 09:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWDYNWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 09:22:00 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:11788 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932218AbWDYNV7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 09:21:59 -0400
Date: Tue, 25 Apr 2006 15:22:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I2C-MPC: Fix up error handling
Message-Id: <20060425152202.ad8f16c8.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.44.0604181122360.15940-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0604181122360.15940-100000@gate.crashing.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kumar,

Is there a datasheet available for this chip?

> * If we have an Unfinished (MCF) or Arbitration Lost (MAL) error and
>   the bus is still busy reset the controller.  This prevents the
>   controller from getting in a hung state for transactions for other
>   devices.

What "other devices" are you talking about? If the _bus_ is busy, it
might be caused by any chip on the bus. Resetting the controller may or
may not help. But it's hard for me to say more without technical
documentation. Can you explain what the CSR_MBB bit means exactly?
Please also explain the scenario you are trying to address here.

> * Fixed up propogating the errors from i2c_wait.

Yes, I like this.

> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -115,11 +115,20 @@ static int i2c_wait(struct mpc_i2c *i2c,
>  
>  	if (!(x & CSR_MCF)) {
>  		pr_debug("I2C: unfinished\n");
> +
> +		/* reset the controller if the bus is still busy */
> +		if (x & CSR_MBB)
> +			writeccr(i2c, 0);
> +
>  		return -EIO;
>  	}
>  
>  	if (x & CSR_MAL) {
>  		pr_debug("I2C: MAL\n");
> +
> +		/* reset the controller if the bus is still busy */
> +		if (x & CSR_MBB)
> +			writeccr(i2c, 0);
>  		return -EIO;
>  	}
>  

Please try being consistent with your blank lines.

> @@ -246,8 +259,13 @@ static int mpc_xfer(struct i2c_adapter *
>  			return -EINTR;
>  		}
>  		if (time_after(jiffies, orig_jiffies + HZ)) {
> -			pr_debug("I2C: timeout\n");
> -			return -EIO;
> +			writeccr(i2c, 0);
> +
> +			/* try one more time before we error */
> +			if (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
> +				pr_debug("I2C: timeout\n");
> +				return -EIO;
> +			}
>  		}
>  		schedule();
>  	}
> @@ -325,6 +343,7 @@ static int fsl_i2c_probe(struct platform
>  			goto fail_irq;
>  		}
>  
> +	writeccr(i2c, 0);
>  	mpc_i2c_setclock(i2c);
>  	platform_set_drvdata(pdev, i2c);

These last two changes are not mentioned in your header comment. What
are they? Why are they needed? They look like hacks to me.

Thanks,
-- 
Jean Delvare

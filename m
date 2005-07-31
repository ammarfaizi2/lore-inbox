Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVGaPmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVGaPmy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 11:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVGaPmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 11:42:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55307 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261793AbVGaPmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 11:42:53 -0400
Date: Sun, 31 Jul 2005 16:42:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix ucb1x00 support on collie
Message-ID: <20050731164245.B20106@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
References: <20050731134617.GA25906@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050731134617.GA25906@elf.ucw.cz>; from pavel@ucw.cz on Sun, Jul 31, 2005 at 03:46:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 03:46:17PM +0200, Pavel Machek wrote:
> Collie is slightly strange; it does not seem to have proper ucb1x00
> ID. With this patch, basic ucb support seems to work and I can get
> interrupts from battery.

Out of interest, what ID does it appear to have?

> diff --git a/drivers/misc/mcp-sa1100.c b/drivers/misc/mcp-sa1100.c
> --- a/drivers/misc/mcp-sa1100.c
> +++ b/drivers/misc/mcp-sa1100.c
> @@ -149,7 +149,7 @@ static int mcp_sa1100_probe(struct devic
>  	    !machine_is_graphicsmaster() && !machine_is_lart()           &&
>  	    !machine_is_omnimeter()      && !machine_is_pfs168()         &&
>  	    !machine_is_shannon()        && !machine_is_simpad()         &&
> -	    !machine_is_yopy())
> +	    !machine_is_yopy()		 && !machine_is_collie())

I think it's about time we did something better with this, like only
registering the platform device on those which use it.

> @@ -181,7 +187,10 @@ static int mcp_sa1100_probe(struct devic
>  
>  	Ser4MCSR = -1;
>  	Ser4MCCR1 = 0;
> -	Ser4MCCR0 = 0x00007f7f | MCCR0_ADM;
> +	if (machine_is_collie()) 
> +		Ser4MCCR0 = MCCR0_ADM | MCCR0_ExtClk;
> +	else
> +		Ser4MCCR0 = 0x00007f7f | MCCR0_ADM;

And this setup should probably be passed as part of the platform device
data.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWC2JOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWC2JOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 04:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWC2JOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 04:14:36 -0500
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:46754 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S1750942AbWC2JOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 04:14:35 -0500
Date: Wed, 29 Mar 2006 11:14:33 +0200
From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Pete Clements <clem@clem.clem-digital.net>,
       klassert@mathematik.tu-chemnitz.de, linux-kernel@vger.kernel.org
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
Message-ID: <20060329091433.GB8237@bayes.mathematik.tu-chemnitz.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Pete Clements <clem@clem.clem-digital.net>,
	klassert@mathematik.tu-chemnitz.de, linux-kernel@vger.kernel.org
References: <20060328141443.GB8455@gareth.mathematik.tu-chemnitz.de> <200603290250.k2T2od8d001585@clem.clem-digital.net> <20060328224308.23cac292.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328224308.23cac292.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Spam-Score: -1.4 (-)
X-Spam-Report: --- Start der SpamAssassin 3.1.1 Textanalyse (-1.4 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	-1.4 ALL_TRUSTED            Nachricht wurde nur ueber vertrauenswuerdige Rechner
	weitergeleitet
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 652e4af5a5c207f483e6e71f7e96832f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 10:43:08PM -0800, Andrew Morton wrote:
> Pete Clements <clem@clem.clem-digital.net> wrote:
> >
> > Quoting Steffen Klassert
> >   > >   Had several of these with git11
> >   > >   NETDEV WATCHDOG: eth0: transmit timed out
> >   > 
> >   > Is this for sure that these messages occured first time with git11?
> >   > There were no changes in the 3c59x driver between git10 and git11.
> >   > 
> > Tried 2.6.15 and could not get a timed out condition.  Looks like
> > that defect is between 15 and 16 in my case.  
> > 
> > Be glad to do any testing that I can.
> > 

I will try to borrow a coax cable and see whats up with 10base2.

> 
> Well here's one.  Steffen, please confirm.
> 
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> The pre-2.6.16 patch "3c59x collision statistics fix" accidentally caused
> vortex_error() to not run iowrite16(TxEnable, ioaddr + EL3_CMD) if we got a
> maxCollisions interrupt but MAX_COLLISION_RESET is not set.

True, this can explain the transmit timed out messages.

Acked-by: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>


> 
> Cc: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
> Cc: Pete Clements <clem@clem.clem-digital.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/net/3c59x.c |   12 +++++-------
>  1 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff -puN drivers/net/3c59x.c~3c59x-collision-statistics-fix-fix drivers/net/3c59x.c
> --- devel/drivers/net/3c59x.c~3c59x-collision-statistics-fix-fix	2006-03-28 22:36:48.000000000 -0800
> +++ devel-akpm/drivers/net/3c59x.c	2006-03-28 22:40:01.000000000 -0800
> @@ -2085,16 +2085,14 @@ vortex_error(struct net_device *dev, int
>  		}
>  		if (tx_status & 0x14)  vp->stats.tx_fifo_errors++;
>  		if (tx_status & 0x38)  vp->stats.tx_aborted_errors++;
> +		if (tx_status & 0x08)  vp->xstats.tx_max_collisions++;
>  		iowrite8(0, ioaddr + TxStatus);
>  		if (tx_status & 0x30) {			/* txJabber or txUnderrun */
>  			do_tx_reset = 1;
> -		} else if (tx_status & 0x08) {	/* maxCollisions */
> -			vp->xstats.tx_max_collisions++;
> -			if (vp->drv_flags & MAX_COLLISION_RESET) {
> -				do_tx_reset = 1;
> -				reset_mask = 0x0108;		/* Reset interface logic, but not download logic */
> -			}
> -		} else {						/* Merely re-enable the transmitter. */
> +		} else if ((tx_status & 0x08) && (vp->drv_flags & MAX_COLLISION_RESET))  {	/* maxCollisions */
> +			do_tx_reset = 1;
> +			reset_mask = 0x0108;		/* Reset interface logic, but not download logic */
> +		} else {				/* Merely re-enable the transmitter. */
>  			iowrite16(TxEnable, ioaddr + EL3_CMD);
>  		}
>  	}
> _

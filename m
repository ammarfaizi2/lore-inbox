Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVAJOwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVAJOwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 09:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVAJOwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 09:52:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23219 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262280AbVAJOwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 09:52:36 -0500
Date: Mon, 10 Jan 2005 09:56:07 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: James Nelson <james4765@cwazy.co.uk>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
       Dan Malek <dan@embeddededge.com>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [RESEND] [PATCH 3/7] ppc: remove cli()/sti() in arch/ppc/8xx_io/fec.c
Message-ID: <20050110115607.GG14098@logos.cnet>
References: <20050108170406.32690.36989.11853@localhost.localdomain> <20050108170433.32690.82747.72350@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108170433.32690.82747.72350@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks OK to me.

 Dan, Tom, this should be applied to the linuxppc-2.5 IMO.

On Sat, Jan 08, 2005 at 11:04:15AM -0600, James Nelson wrote:
> Replace save_flags()/resore_flags() with spin_lock_irqsave()/spin_unlock_irqrestore()
> and document reasons for locking.
> 
> Signed-off-by: James Nelson <james4765@gmail.com>
> 
> diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/8xx_io/fec.c linux-2.6.10-mm1/arch/ppc/8xx_io/fec.c
> --- linux-2.6.10-mm1-original/arch/ppc/8xx_io/fec.c	2004-12-24 16:35:28.000000000 -0500
> +++ linux-2.6.10-mm1/arch/ppc/8xx_io/fec.c	2005-01-07 19:58:55.806516338 -0500
> @@ -389,6 +389,7 @@
>  	flush_dcache_range((unsigned long)skb->data,
>  			   (unsigned long)skb->data + skb->len);
>  
> +	/* disable interrupts while triggering transmit */
>  	spin_lock_irq(&fep->lock);
>  
>  	/* Send it on its way.  Tell FEC its ready, interrupt when done,
> @@ -539,6 +540,7 @@
>  	struct	sk_buff	*skb;
>  
>  	fep = dev->priv;
> +	/* lock while transmitting */
>  	spin_lock(&fep->lock);
>  	bdp = fep->dirty_tx;
>  
> @@ -799,6 +801,7 @@
>  
>  	if ((mip = mii_head) != NULL) {
>  		ep->fec_mii_data = mip->mii_regval;
> +
>  	}
>  }
>  
> @@ -817,8 +820,8 @@
>  
>  	retval = 0;
>  
> -	save_flags(flags);
> -	cli();
> +	/* lock while modifying mii_list */
> +	spin_lock_irqsave(&fep->lock, flags);
>  
>  	if ((mip = mii_free) != NULL) {
>  		mii_free = mip->mii_next;
> @@ -836,7 +839,7 @@
>  		retval = 1;
>  	}
>  
> -	restore_flags(flags);
> +	spin_unlock_irqrestore(&fep->lock, flags);
>  
>  	return(retval);
>  }

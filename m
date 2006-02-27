Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWB0MIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWB0MIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 07:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWB0MIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 07:08:34 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:55617 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751347AbWB0MId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 07:08:33 -0500
Date: Mon, 27 Feb 2006 13:08:29 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Marc Zyngier <maz@misterjones.org>
Cc: R.E.Wolff@BitWizard.nl, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Fix Specialix SX corruption
Message-ID: <20060227120828.GC14296@bitwizard.nl>
References: <wrpk6bh9i0f.fsf@wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrpk6bh9i0f.fsf@wild-wind.fr.eu.org>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 12:08:00PM +0100, Marc Zyngier wrote:
> Roger,
> 
> With the latest kernels, I experienced some strange corruption, some
> '*****' being randomly inserted in the character flow, like this:
> 
> ashes:~#
> ashes:~#
> a*******shes:~#
> ashes:~#
> ashes:~#
> 
> Further investigation shows that the problem was introduced during
> Alan's "TTY layer buffering revamp" patch, the amount of data to be
> copied being reduced after buffer allocation. Moving the count fixup
> around solves the problem.
> 
> Patch against v2.6.16-rc5.
> 
> Signed-off-by: Marc Zyngier <maz@misterjones.org>
> 
> diff --git a/drivers/char/sx.c b/drivers/char/sx.c
> index 588e75e..a6b4f02 100644
> --- a/drivers/char/sx.c
> +++ b/drivers/char/sx.c
> @@ -1095,17 +1095,17 @@ static inline void sx_receive_chars (str
>  
>  		sx_dprintk (SX_DEBUG_RECEIVE, "rxop=%d, c = %d.\n", rx_op, c); 
>  
> +		/* Don't copy past the end of the hardware receive buffer */
> +		if (rx_op + c > 0x100) c = 0x100 - rx_op;
> +
> +		sx_dprintk (SX_DEBUG_RECEIVE, "c = %d.\n", c);
> +
>  		/* Don't copy more bytes than there is room for in the buffer */
>  
>  		c = tty_prepare_flip_string(tty, &rp, c);
>  
>  		sx_dprintk (SX_DEBUG_RECEIVE, "c = %d.\n", c); 
>  
> -		/* Don't copy past the end of the hardware receive buffer */
> -		if (rx_op + c > 0x100) c = 0x100 - rx_op;
> -
> -		sx_dprintk (SX_DEBUG_RECEIVE, "c = %d.\n", c);
> -


The idea behind this code is that we start out with the maximum amount of 
data we'd want to copy, and then reduce it to prevent copying more data
than we should for any other reason we can think of. 

The reason I do it this way is that the hardware for instance may increase 
the number of bytes that can be copied, just because another byte came in. 
The rest of the system may INCREASE the number of bytes we can put in the buffer
because someone copied bytes out of the buffer or something like that 
(probably doesn't happen like that because it's called a flip-buffer, but 
whatever).  

Both of these "races" are not really races: We'd end up copying less data this 
time, and we'd copy the rest the next time. 

So, if the modern flip buffer stuff expects us to provide the exact number
of bytes we prepared the flip buffer for we shouldn't adjust the number of chars
copied after preparing the flip buffer. 

So indeed the check for the end of the hardware buffer needs to go before the
prepare flip string. 

Approved!

	Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ

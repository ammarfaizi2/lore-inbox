Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbUJWOGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUJWOGI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbUJWOGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:06:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6049 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261194AbUJWOF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:05:57 -0400
Date: Sat, 23 Oct 2004 09:39:38 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.28-rc1
Message-ID: <20041023113938.GB8206@logos.cnet>
References: <20041022185953.GA4886@logos.cnet> <1098538220.5960.2.camel@at2.pipehead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098538220.5960.2.camel@at2.pipehead.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 08:30:20AM -0500, Paul Fulghum wrote:
> On Fri, 2004-10-22 at 13:59, Marcelo Tosatti wrote:
> > Here goes the first release candidate of v2.4.28.
> 
> Any chance of getting this in?

Oh I missed that, sorry (I've seen it and thought I had
applied).

Well, there it is.

> 
> -- 
> Paul Fulghum
> paulkf@microgate.com
> 
> >From paulkf@microgate.com Fri Oct  8 13:20:56 2004
> Subject: [PATCH] serial receive lockup fix
> From: Paul Fulghum <paulkf@microgate.com>
> To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>
> 
> Fix lockup caused by serial driver not clearing
> receive interrupt if flip buffer becomes full.
> 
> Signed-off-by: Paul Fulghum <paulkf@microgate.com>
> 
> 
> 
> --- a/drivers/char/serial.c	2004-09-29 09:08:35.000000000 -0500
> +++ b/drivers/char/serial.c	2004-09-29 09:09:07.000000000 -0500
> @@ -573,8 +573,19 @@
>  	do {
>  		if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
>  			tty->flip.tqueue.routine((void *) tty);
> -			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
> +			if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
> +				/* no room in flip buffer, discard rx FIFO contents to clear IRQ
> +				 * *FIXME* Hardware with auto flow control
> +				 * would benefit from leaving the data in the FIFO and
> +				 * disabling the rx IRQ until space becomes available.
> +				 */
> +				do {
> +					serial_inp(info, UART_RX);
> +					icount->overrun++;
> +					*status = serial_inp(info, UART_LSR);
> +				} while ((*status & UART_LSR_DR) && (max_count-- > 0));
>  				return;		// if TTY_DONT_FLIP is set
> +			}
>  		}
>  		ch = serial_inp(info, UART_RX);
>  		*tty->flip.char_buf_ptr = ch;
> 
> 

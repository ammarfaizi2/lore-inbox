Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUHWNH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUHWNH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 09:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUHWNH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 09:07:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27318 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263971AbUHWNHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 09:07:23 -0400
Date: Mon, 23 Aug 2004 08:49:11 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [2/10]
Message-ID: <20040823114911.GB4569@logos.cnet>
References: <412220D5.2020403@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412220D5.2020403@ttnet.net.tr>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ozkan,

mxser_interrupt() is not inline, why are messing around with it?

On Tue, Aug 17, 2004 at 06:14:29PM +0300, O.Sezer wrote:

> --- 28p1/drivers/char/mxser.c~	2004-08-16 20:12:59.000000000 +0300
> +++ 28p1/drivers/char/mxser.c	2004-08-16 21:17:23.000000000 +0300
> @@ -1385,66 +1385,6 @@
>  	wake_up_interruptible(&info->open_wait);
>  }
>  
> -/*
> - * This is the serial driver's generic interrupt routine
> - */
> -static void mxser_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> -{
> -	int status, i;
> -	struct mxser_struct *info;
> -	struct mxser_struct *port;
> -	int max, irqbits, bits, msr;
> -	int pass_counter = 0;
> -
> -	port = 0;
> -	for (i = 0; i < MXSER_BOARDS; i++) {
> -		if (dev_id == &(mxvar_table[i * MXSER_PORTS_PER_BOARD])) {
> -			port = dev_id;
> -			break;
> -		}
> -	}
> -
> -	if (i == MXSER_BOARDS)
> -		return;
> -	if (port == 0)
> -		return;
> -	max = mxser_numports[mxsercfg[i].board_type];
> -
> -	while (1) {
> -		irqbits = inb(port->vector) & port->vectormask;
> -		if (irqbits == port->vectormask)
> -			break;
> -		for (i = 0, bits = 1; i < max; i++, irqbits |= bits, bits <<= 1) {
> -			if (irqbits == port->vectormask)
> -				break;
> -			if (bits & irqbits)
> -				continue;
> -			info = port + i;
> -			if (!info->tty ||
> -			  (inb(info->base + UART_IIR) & UART_IIR_NO_INT))
> -				continue;
> -			status = inb(info->base + UART_LSR) & info->read_status_mask;
> -			if (status & UART_LSR_DR)
> -				mxser_receive_chars(info, &status);
> -			msr = inb(info->base + UART_MSR);
> -			if (msr & UART_MSR_ANY_DELTA)
> -				mxser_check_modem_status(info, msr);
> -			if (status & UART_LSR_THRE) {
> -/* 8-2-99 by William
> -   if ( info->x_char || (info->xmit_cnt > 0) )
> - */
> -				mxser_transmit_chars(info);
> -			}
> -		}
> -		if (pass_counter++ > MXSER_ISR_PASS_LIMIT) {
> -#if 0
> -			printk("MOXA Smartio/Indusrtio family driver interrupt loop break\n");
> -#endif
> -			break;	/* Prevent infinite loops */
> -		}
> -	}
> -}
> -
>  static inline void mxser_receive_chars(struct mxser_struct *info,
>  					 int *status)

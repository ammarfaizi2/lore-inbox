Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263383AbTCUAed>; Thu, 20 Mar 2003 19:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263376AbTCUAeV>; Thu, 20 Mar 2003 19:34:21 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:34828
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S263381AbTCUAeM>; Thu, 20 Mar 2003 19:34:12 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DF0@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
Date: Thu, 20 Mar 2003 16:45:03 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 2:14 PM, Richard B. Johnson wrote:
> 
> [SNIPPED...]
> 
> This patch works (no other promises).
> 
> --- linux-2.4.20/drivers/char/serial.c.orig	2003-03-20 
> 16:21:55.000000000 -0500
> +++ linux-2.4.20/drivers/char/serial.c	2003-03-20 
> 16:31:23.000000000 -0500
> @@ -1538,8 +1538,12 @@
>  	serial_out(info, UART_LCR, serial_inp(info, UART_LCR) & 
> ~UART_LCR_SBC);
> 
>  	if (!info->tty || (info->tty->termios->c_cflag & HUPCL))
> -		info->MCR &= ~(UART_MCR_DTR|UART_MCR_RTS);
> -	serial_outp(info, UART_MCR, info->MCR);
> +        {
> +           serial_outp(info, UART_MCR,info->MCR & 
> ~(UART_MCR_DTR|UART_MCR_RTS));
> +           set_current_state(TASK_INTERRUPTIBLE);
> +           schedule_timeout(HZ/2);              /* 
> Disconnect modem  */
> +        }
> +	serial_outp(info, UART_MCR, info->MCR);  /* Don't keep it off */
> 
>  	/* disable FIFO's */
>  	serial_outp(info, UART_FCR, (UART_FCR_ENABLE_FIFO |
> 
Hi Richard,

I'm not sure it's a Good Thing(tm) to call schedule_timeout() with 
the interrupts disabled. The shutdown function is framed by 
save_flags();cli and restore_flags(). Don't know exactly what the 
downside of that could be. 

Is the re-enable of DTR actually necessary to get agetty to work? 
DTR is supposed to stay off until the next open. 

Still, if it works for you, it works. 

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

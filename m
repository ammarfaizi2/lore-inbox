Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263598AbTCUMMY>; Fri, 21 Mar 2003 07:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263599AbTCUMMY>; Fri, 21 Mar 2003 07:12:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52617 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263598AbTCUMMU>; Fri, 21 Mar 2003 07:12:20 -0500
Date: Fri, 21 Mar 2003 07:24:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ed Vance <EdV@macrolink.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33DF0@EXCHANGE>
Message-ID: <Pine.LNX.4.53.0303210721390.8584@chaos>
References: <11E89240C407D311958800A0C9ACF7D1A33DF0@EXCHANGE>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003, Ed Vance wrote:

> On Thu, Mar 20, 2003 at 2:14 PM, Richard B. Johnson wrote:
> >
> > [SNIPPED...]
> >
> > This patch works (no other promises).
> >
> > --- linux-2.4.20/drivers/char/serial.c.orig	2003-03-20
> > 16:21:55.000000000 -0500
> > +++ linux-2.4.20/drivers/char/serial.c	2003-03-20
> > 16:31:23.000000000 -0500
> > @@ -1538,8 +1538,12 @@
> >  	serial_out(info, UART_LCR, serial_inp(info, UART_LCR) &
> > ~UART_LCR_SBC);
> >
> >  	if (!info->tty || (info->tty->termios->c_cflag & HUPCL))
> > -		info->MCR &= ~(UART_MCR_DTR|UART_MCR_RTS);
> > -	serial_outp(info, UART_MCR, info->MCR);
> > +        {
> > +           serial_outp(info, UART_MCR,info->MCR &
> > ~(UART_MCR_DTR|UART_MCR_RTS));
> > +           set_current_state(TASK_INTERRUPTIBLE);
> > +           schedule_timeout(HZ/2);              /*
> > Disconnect modem  */
> > +        }
> > +	serial_outp(info, UART_MCR, info->MCR);  /* Don't keep it off */
> >
> >  	/* disable FIFO's */
> >  	serial_outp(info, UART_FCR, (UART_FCR_ENABLE_FIFO |
> >
> Hi Richard,
>
> I'm not sure it's a Good Thing(tm) to call schedule_timeout() with
> the interrupts disabled. The shutdown function is framed by
> save_flags();cli and restore_flags(). Don't know exactly what the
> downside of that could be.
>
> Is the re-enable of DTR actually necessary to get agetty to work?
> DTR is supposed to stay off until the next open.
>
> Still, if it works for you, it works.
>
> Cheers,
> Ed

Yes. DTR must be high or the modem will never answer an incoming call.
The `getty` waits in a blocking open until the carrier is detected.
The carrier will never be detected if DTR is low. After the hangup
occurs, you need to restore the modem settings.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


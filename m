Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbTCTWAl>; Thu, 20 Mar 2003 17:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbTCTV76>; Thu, 20 Mar 2003 16:59:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8073 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262655AbTCTV7o>; Thu, 20 Mar 2003 16:59:44 -0500
Date: Thu, 20 Mar 2003 17:13:42 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ed Vance <EdV@macrolink.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
In-Reply-To: <Pine.LNX.4.53.0303191959110.1386@chaos>
Message-ID: <Pine.LNX.4.53.0303201711550.6079@chaos>
References: <11E89240C407D311958800A0C9ACF7D1A33DEF@EXCHANGE>
 <Pine.LNX.4.53.0303191959110.1386@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, Richard B. Johnson wrote:

> On Wed, 19 Mar 2003, Ed Vance wrote:
>
> > On Wed, Mar 19, 2003 2:32 PM, Richard B. Johnson wrote:
> > > On Wed, 19 Mar 2003, Ed Vance wrote:
> > > [SNIPPED...]
> > >
> > > > Hi Richard,
> > > >
> > > > The following patch to serial.c in 2.4.20 is a brute-force addition
> > > > of a hang-up delay of 0.5 sec just before close returns to the user,
> > > > if the hupcl flag is set. Please try this to determine if there are
> > > > any other issues with the remote login. If it works, I'll write a
> > > > better patch that does not duplicate other delays, etc.
> > > >
> > > > Cheers,
> > > > Ed
> > > >
> > >
> > > Well, it's the "right church, but wrong pew". As soon as anything
> > > closes STDIO_FILENO, **bang** the modem hangs up. NotGood(tm)!
> > > So as long as I just execute the shell which was exec'ed ...
> > > getty...rlogin...bash never called close. However, `ls` on my
> > > machine is `color-ls` when it calls exit(0)... well you get
> > > the idea! I can log in, but can't actually execute anything that
> > > terminates, closing STDIO_FILENO...
> > >
> > >
> > Hi Richard,
> >
> > Bummer! Do you think that each of those events was a "last close"
> > of the port? Doesn't bash hold the port open while the `color-ls`
> > runs?
> >
> > Since the path only delays (doesn't change modem control), these
> > closes must have been hidden by quick reopens. Does the unmodified
> > agetty set the baud rate to zero to hangup, or was that your change?
> > I was thinking that I could move the delay to the code that
> > disconnects when baud rate zero is set.
> >
> > your thoughts?
> >
> > Cheers,
> > Ed

[SNIPPED...]

This patch works (no other promises).

--- linux-2.4.20/drivers/char/serial.c.orig	2003-03-20 16:21:55.000000000 -0500
+++ linux-2.4.20/drivers/char/serial.c	2003-03-20 16:31:23.000000000 -0500
@@ -1538,8 +1538,12 @@
 	serial_out(info, UART_LCR, serial_inp(info, UART_LCR) & ~UART_LCR_SBC);

 	if (!info->tty || (info->tty->termios->c_cflag & HUPCL))
-		info->MCR &= ~(UART_MCR_DTR|UART_MCR_RTS);
-	serial_outp(info, UART_MCR, info->MCR);
+        {
+           serial_outp(info, UART_MCR,info->MCR & ~(UART_MCR_DTR|UART_MCR_RTS));
+           set_current_state(TASK_INTERRUPTIBLE);
+           schedule_timeout(HZ/2);              /* Disconnect modem  */
+        }
+	serial_outp(info, UART_MCR, info->MCR);  /* Don't keep it off */

 	/* disable FIFO's */
 	serial_outp(info, UART_FCR, (UART_FCR_ENABLE_FIFO |



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


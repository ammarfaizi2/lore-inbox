Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263198AbTCSWSP>; Wed, 19 Mar 2003 17:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263197AbTCSWSO>; Wed, 19 Mar 2003 17:18:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:50567 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263196AbTCSWSH>; Wed, 19 Mar 2003 17:18:07 -0500
Date: Wed, 19 Mar 2003 17:32:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ed Vance <EdV@macrolink.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33DEE@EXCHANGE>
Message-ID: <Pine.LNX.4.53.0303191726180.808@chaos>
References: <11E89240C407D311958800A0C9ACF7D1A33DEE@EXCHANGE>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, Ed Vance wrote:
[SNIPPED...]

> Hi Richard,
>
> The following patch to serial.c in 2.4.20 is a brute-force addition
> of a hang-up delay of 0.5 sec just before close returns to the user,
> if the hupcl flag is set. Please try this to determine if there are
> any other issues with the remote login. If it works, I'll write a
> better patch that does not duplicate other delays, etc.
>
> Cheers,
> Ed
>

Well, it's the "right church, but wrong pew". As soon as anything
closes STDIO_FILENO, **bang** the modem hangs up. NotGood(tm)!
So as long as I just execute the shell which was exec'ed ...
getty...rlogin...bash never called close. However, `ls` on my
machine is `color-ls` when it calls exit(0)... well you get
the idea! I can log in, but can't actually execute anything that
terminates, closing STDIO_FILENO...


> diff -urN -X dontdiff.txt linux-2.4.20/drivers/char/serial.c
> patched-2.4.20/drivers/char/serial.c
> --- linux-2.4.20/drivers/char/serial.c	Thu Nov 28 15:53:12 2002
> +++ patched-2.4.20/drivers/char/serial.c	Tue Mar 18 16:03:43 2003
> @@ -2848,6 +2848,10 @@
>  		tty->driver.flush_buffer(tty);
>  	if (tty->ldisc.flush_buffer)
>  		tty->ldisc.flush_buffer(tty);
> +	if (tty->termios->c_cflag & HUPCL) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(HZ/2);	/* 0.5 sec to disconnect modem */
> +	}
>  	tty->closing = 0;
>  	info->event = 0;
>  	info->tty = 0;
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


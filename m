Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268040AbTBRWDY>; Tue, 18 Feb 2003 17:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268043AbTBRWDY>; Tue, 18 Feb 2003 17:03:24 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:28327 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268040AbTBRWDW>; Tue, 18 Feb 2003 17:03:22 -0500
Date: Tue, 18 Feb 2003 17:13:20 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200302182213.h1IMDKX31357@devserv.devel.redhat.com>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Toshiba keyboard workaroun
In-Reply-To: <mailman.1045603384.24857.linux-kernel2news@redhat.com>
References: <mailman.1045603384.24857.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- clean/drivers/char/keyboard.c	2003-02-15 18:51:18.000000000 +0100
> +++ linux/drivers/char/keyboard.c	2003-02-15 19:19:45.000000000 +0100
> @@ -1020,6 +1041,23 @@
>  	struct tty_struct *tty;
>  	int shift_final;
>  
> +        /*
> +         * Fix for Toshiba Satellites. Toshiba's like to repeat 
> +	 * "key down" event for A in combinations like shift-A.
> +	 * Thanx to Andrei Pitis <pink@roedu.net>.
> +         */
> +        static int prev_scancode = 0;
> +        static int stop_jiffies = 0;
> +
> +        /* new scancode, trigger delay */
> +        if (keycode != prev_scancode) 	       stop_jiffies = jiffies;
> +        else if (jiffies - stop_jiffies >= 10) stop_jiffies = 0;
> +        else {
> +	    printk( "Keyboard glitch detected, ignoring keypress\n" );
> +            return;
> +	}
> +        prev_scancode = keycode;
> +
>  	if (down != 2)
>  		add_keyboard_randomness((keycode << 1) ^ down);

This is incredibly broken, on many layers.

First, formatting does not respect the original code. Pavel, please,
I do not care what crap you write in softsuspend, but this is a
generic piece of code. Be kind to those who come next.

Second, no HZ or other way to specify a wall clock interval.
What if I run with HZ=4000? How do you protect against a
jiffies wraparound?

Third, I do not see how this is supposed to work at all.
What if I hit two letters like in a word "Fool"? The up event
is filtered already by this time, so, won't this code eat
the second 'o'?

-- Pete

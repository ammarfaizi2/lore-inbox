Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268063AbTBWIJo>; Sun, 23 Feb 2003 03:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268064AbTBWIJo>; Sun, 23 Feb 2003 03:09:44 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:25772 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S268063AbTBWIJh>;
	Sun, 23 Feb 2003 03:09:37 -0500
Date: Sun, 23 Feb 2003 09:19:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Toshiba keyboard workaroun
Message-ID: <20030223091936.B31359@ucw.cz>
References: <20030218211940.GA1048@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030218211940.GA1048@elf.ucw.cz>; from pavel@ucw.cz on Tue, Feb 18, 2003 at 10:19:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 10:19:40PM +0100, Pavel Machek wrote:

> You said that you'll submit toshiba keyboard fix for 2.4 to
> marcelo... Here goes 2.5 version, will you submit it to Linus? ;-).

This belongs into drivers/input/keyboard/atkbd.c, not here!

Subsequent keypresses are already ignored - autorepeat is done in
software, however if you get a very quick press-release-press of the
same key that means the keyboard controller didn't do proper debouncing
and you probably can ignore the later release and press. But you must
ignore the release as well. Further - comparing to 10 jiffies isn't a
good idea - jiffies speed is different on different archs.

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

-- 
Vojtech Pavlik
SuSE Labs

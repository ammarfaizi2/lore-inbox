Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286447AbSAIQg4>; Wed, 9 Jan 2002 11:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbSAIQgr>; Wed, 9 Jan 2002 11:36:47 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:6061 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286413AbSAIQgh>; Wed, 9 Jan 2002 11:36:37 -0500
Date: Wed, 9 Jan 2002 09:36:30 -0700
Message-Id: <200201091636.g09GaU705860@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Ivan Passos <ivan@cyclades.com>
Cc: Andrew Morton <akpm@zip.com.au>, "Michael H. Warfield" <mhw@wittsend.com>,
        David Weinehall <tao@acc.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C3B81D7.F1F43495@cyclades.com>
In-Reply-To: <3C33E0D3.B6E932D6@zip.com.au>
	<3C33BCF3.20BE9E92@cyclades.com>
	<200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca>
	<200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca>
	<3C38BC19.72ECE86@zip.com.au>
	<200201070636.g076asR25565@vindaloo.ras.ucalgary.ca>
	<3C3A7DA7.381D033D@zip.com.au>
	<20020108071548.J5235@khan.acc.umu.se>
	<3C3A9048.CB80061A@zip.com.au>
	<20020108165851.B26294@alcove.wittsend.com>
	<3C3B6E96.8FB0341A@zip.com.au>
	<3C3B81D7.F1F43495@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Passos writes:
> 
> Andrew Morton wrote:
> > 
> > "Michael H. Warfield" wrote:
> > >
> > > The trouble there is the problem with conventional lock files under
> > > /var/lock which only use the base name of the device name so cua/42
> > > and cuf/42 both have the same lock file of /var/lock/LCK..42 and
> > > would collide.
> > 
> > OK, thanks.  So it looks like we stick with
> > 
> >         http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre2/tty_name.patch
> > 
> > Which just puts %d's at the end of all the device names in the
> > non-devfs case.
> > 
> > I'll have another go at that patch, check for missed drivers,
> > then send it out again.  OK?
> 
> OK, just two comments:
> - As you'll have to patch all drivers anyway, in case Richard Gooch 
>   doesn't have a problem with this suggestion, I'd suggest you patch 
>   the kernel as follows:
> 
>   (1) drivers/char/tty_io.c
>       ---------------------
> @@ -193,10 +193,13 @@ _tty_make_name(struct tty_struct *tty, c
> 
>         if (!tty) /* Hmm.  NULL pointer.  That's fun. */
>                 strcpy(buf, "NULL tty");
>         else
> -               sprintf(buf, name,
> -                       idx + tty->driver.name_base);
> +               sprintf(buf, "%s%d", name, idx + tty->driver.name_base);
>  
>         return buf;
>  }
> 
>   (2) drivers/char/serial.c
>       ---------------------
> @@ -5387,7 +5387,7 @@ static int __init rs_init(void)
>         serial_driver.driver_name = "serial";
>  #endif
>  #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
> -       serial_driver.name = "tts/%d";
> +       serial_driver.name = "tts/";
>  #else
>         serial_driver.name = "ttyS";
>  #endif
> 
> 
>   (3) drivers/char/whatever_other_driver.c
>       ------------------------------------
> @@ -5387,7 +5387,7 @@ static int __init wod_init(void)
>         wod_driver.driver_name = "whatever_other_driver";
>  #endif
>  #ifdef CONFIG_DEVFS_FS
> -       wod_driver.name = "tts/N%d";
> +       wod_driver.name = "tts/N";
>  #else
>         wod_driver.name = "ttyN";
>  #endif
> 
>   I've already suggested this in a previous msg, but nobody gave 
>   feedback. I believe this is cleaner, as it removes the %d from 
>   the driver.name field, while fixes the problem I reported.

Since you have to change all the drivers anyway, I'd prefer if
_tty_make_name() was left unchanged, and instead you put the "%d" in
each driver.name, thusly:
#ifdef CONFIG_DEVFS_FS
	wod_driver.name = "tts/N%d";
#else
	wod_driver.name = "ttyN%d";
#endif

The reason: maximum flexibility in the kinds of names we can
support. If for some reason we want a name like "tts/N%d_A" and
"tts/N%d_B" (say a driver with linked ttys, like the pty driver), we
don't need to make a global change.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

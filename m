Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288238AbSAHSoz>; Tue, 8 Jan 2002 13:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288234AbSAHSop>; Tue, 8 Jan 2002 13:44:45 -0500
Received: from intra.cyclades.com ([209.81.55.6]:22532 "HELO
	intra.cyclades.com") by vger.kernel.org with SMTP
	id <S288230AbSAHSoe>; Tue, 8 Jan 2002 13:44:34 -0500
Message-ID: <3C3B3EDC.C59D48C8@cyclades.com>
Date: Tue, 08 Jan 2002 10:47:56 -0800
From: Ivan Passos <ivan@cyclades.com>
Organization: Cyclades Corporation
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C38BC19.72ECE86@zip.com.au>,
			<3C34024A.EDA31D24@zip.com.au>
			<3C33E0D3.B6E932D6@zip.com.au>
			<3C33BCF3.20BE9E92@cyclades.com>
			<200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca>
			<200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca>
			<3C38BC19.72ECE86@zip.com.au> <200201070636.g076asR25565@vindaloo.ras.ucalgary.ca> <3C3A7DA7.381D033D@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> 
> Richard, can we please get this wrapped up?
> 
> My preferred approach is to change the driver naming scheme
> so that we don't have to put printf control-strings everywhere.
> We can remove a number of ifdefs that way.
> 
> So for serial.c:
> 
> --- linux-2.4.18-pre2/drivers/char/tty_io.c     Mon Jan  7 16:48:02 2002
> +++ linux-akpm/drivers/char/tty_io.c    Mon Jan  7 20:56:38 2002
> @@ -193,10 +193,13 @@ _tty_make_name(struct tty_struct *tty, c
> 
>         if (!tty) /* Hmm.  NULL pointer.  That's fun. */
>                 strcpy(buf, "NULL tty");
> -       else
> -               sprintf(buf, name,
> -                       idx + tty->driver.name_base);
> -
> +       else {
> +#ifdef CONFIG_DEVFS_FS
> +               sprintf(buf, "%s/%d", name, idx + tty->driver.name_base);
> +#else
> +               sprintf(buf, "%s%d", name, idx + tty->driver.name_base);
> +#endif
> +       }
>         return buf;
>  }
> 
> --- linux-2.4.18-pre2/drivers/char/serial.c     Mon Jan  7 16:48:02 2002
> +++ linux-akpm/drivers/char/serial.c    Mon Jan  7 20:58:09 2002
> @@ -5387,7 +5387,7 @@ static int __init rs_init(void)
>         serial_driver.driver_name = "serial";
>  #endif
>  #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
> -       serial_driver.name = "tts/%d";
> +       serial_driver.name = "tts";
>  #else
>         serial_driver.name = "ttyS";
>  #endif

This doesn't cover all the drivers, because the definition for devfs 
is that the standard serial "translates" 'ttyS' to 'tts/', and other 
serial drivers "translate" 'ttyN' (where 'N' can be several 
different letters -- e.g. 'C' for Cyclades, 'R' for Comtrol, 'X' for 
Specialix, 'D' for Digi, etc.) to 'tts/N' (so that standard serial 
and other serial devices can share the same devfs directory).

So, I believe the best way to solve this would be:

drivers/char/tty_io.c:
@@ -193,10 +193,13 @@ _tty_make_name(struct tty_struct *tty, c

        if (!tty) /* Hmm.  NULL pointer.  That's fun. */
                strcpy(buf, "NULL tty");
        else
-               sprintf(buf, name,
-                       idx + tty->driver.name_base);
+               sprintf(buf, "%s%d", name, idx + tty->driver.name_base);
 
        return buf;
 }

drivers/char/serial.c:
@@ -5387,7 +5387,7 @@ static int __init rs_init(void)
        serial_driver.driver_name = "serial";
 #endif
 #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
-       serial_driver.name = "tts/%d";
+       serial_driver.name = "tts/";
 #else
        serial_driver.name = "ttyS";
 #endif


And then, for instance, for the Cyclades driver, we'd use:

#ifdef CONFIG_DEVFS_FS
	cy_serial_driver.name = "tts/C";
#else
	cy_serial_driver.name = "ttyC";
#endif

, and let's not forget the callout devices (which follow a similar 
rule):

#ifdef CONFIG_DEVFS_FS
	cy_callout_driver.name = "cua/C";
#else
	cy_callout_driver.name = "cub";
#endif

This would apply for other drivers as well, just replacing the 'C' 
by the proper letter.

So, what do you think?!?!?

Later,
-- 
Ivan Passos							 -o)
Integration Manager, Cyclades	- http://www.cyclades.com	 /\\
Project Leader, NetLinOS	- http://www.netlinos.org	_\_V
--------------------------------------------------------------------

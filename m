Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287940AbSAHGQ2>; Tue, 8 Jan 2002 01:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287941AbSAHGQT>; Tue, 8 Jan 2002 01:16:19 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:16059 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S287940AbSAHGQM>;
	Tue, 8 Jan 2002 01:16:12 -0500
Date: Tue, 8 Jan 2002 07:15:48 +0100
From: David Weinehall <tao@acc.umu.se>
To: Andrew Morton <akpm@zip.com.au>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Ivan Passos <ivan@cyclades.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
Message-ID: <20020108071548.J5235@khan.acc.umu.se>
In-Reply-To: <3C38BC19.72ECE86@zip.com.au>, <3C34024A.EDA31D24@zip.com.au> <3C33E0D3.B6E932D6@zip.com.au> <3C33BCF3.20BE9E92@cyclades.com> <200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca> <200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca> <3C38BC19.72ECE86@zip.com.au> <200201070636.g076asR25565@vindaloo.ras.ucalgary.ca> <3C3A7DA7.381D033D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C3A7DA7.381D033D@zip.com.au>; from akpm@zip.com.au on Mon, Jan 07, 2002 at 09:03:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 09:03:35PM -0800, Andrew Morton wrote:
> [ tty driver name breakage ]
> 
> Richard, can we please get this wrapped up?
> 
> My preferred approach is to change the driver naming scheme
> so that we don't have to put printf control-strings everywhere.
> We can remove a number of ifdefs that way.

Wouldn't it be cleaner to have:

#ifdef CONFIG_DEVFS_FS
	serial_driver.name = "tts/";
#else
	serial_driver.name = "tts";
#endif

and

	sprintf("buf, "%s%d", name, idx + tty->driver.name_base);

respectively?!


/David

> So for serial.c:
> 
> --- linux-2.4.18-pre2/drivers/char/tty_io.c	Mon Jan  7 16:48:02 2002
> +++ linux-akpm/drivers/char/tty_io.c	Mon Jan  7 20:56:38 2002
> @@ -193,10 +193,13 @@ _tty_make_name(struct tty_struct *tty, c
>  
>  	if (!tty) /* Hmm.  NULL pointer.  That's fun. */
>  		strcpy(buf, "NULL tty");
> -	else
> -		sprintf(buf, name,
> -			idx + tty->driver.name_base);
> -		
> +	else {
> +#ifdef CONFIG_DEVFS_FS
> +		sprintf(buf, "%s/%d", name, idx + tty->driver.name_base);
> +#else
> +		sprintf(buf, "%s%d", name, idx + tty->driver.name_base);
> +#endif
> +	}		
>  	return buf;
>  }
>  
> --- linux-2.4.18-pre2/drivers/char/serial.c	Mon Jan  7 16:48:02 2002
> +++ linux-akpm/drivers/char/serial.c	Mon Jan  7 20:58:09 2002
> @@ -5387,7 +5387,7 @@ static int __init rs_init(void)
>  	serial_driver.driver_name = "serial";
>  #endif
>  #if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
> -	serial_driver.name = "tts/%d";
> +	serial_driver.name = "tts";
>  #else
>  	serial_driver.name = "ttyS";
>  #endif

  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </

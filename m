Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267119AbSKXBlP>; Sat, 23 Nov 2002 20:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbSKXBlP>; Sat, 23 Nov 2002 20:41:15 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:21510 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267119AbSKXBlO>; Sat, 23 Nov 2002 20:41:14 -0500
Date: Sun, 24 Nov 2002 02:48:23 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Petr Baudis <pasky@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kconfig] Direct use of lxdialog routines by menuconfig
 (resent,v2)
In-Reply-To: <20021123095040.GY25628@pasky.ji.cz>
Message-ID: <Pine.LNX.4.44.0211240159240.2113-100000@serv>
References: <20021123095040.GY25628@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 23 Nov 2002, Petr Baudis wrote:

>   this patch (against 2.5.49) cleans up interaction between kconfig's mconf
> (menuconfig frontend) and lxdialog. Its commandline interface (called
> imaginatively lxdialog) no longer exists, instead a huge .o is packed from the
> lxdialog objects and the relevant functions are called directly from mconf.

It didn't apply cleanly, I had one reject from menubox.c, which I had to 
apply manually.
Anyway, some minor comments about the code:

> +struct dialog_list_item *items[16384]; /* FIXME: This ought to be dynamic. */
> +int item_no;
> +

These should be static.

> -static void cprint_init(void)
> +static void cinit(void)

You can join this with cdone(), they are always called together.

> +	if (!item_no)
> +		cmake();

This could be "if (!items[item_no]) cmake()" to allocate the data as 
needed. Increment item_no after you done, this avoids also all the 
"item_no - 1" as index.

> -static int cprint(const char *fmt, ...)
> +static int cprint_tag(const char *fmt, ...)
>  {
>  	va_list ap;
>  	int res;
>  
> -	*argptr++ = bufptr;
> +	if (!item_no)
> +		cmake();
>  	va_start(ap, fmt);
> -	res = vsprintf(bufptr, fmt, ap);
> +	res = vsnprintf(items[item_no - 1]->tag, 32, fmt, ap);
>  	va_end(ap);
> -	bufptr += res;
> -	*bufptr++ = 0;
>  
>  	return res;
>  }

Could you change the tag field of dialog_list_item into a "char type" and 
a void pointer? I don't really see a reason to convert them from/into 
strings anymore.

> -	sa.sa_handler = winch_handler;
> -	sigemptyset(&sa.sa_mask);
> -	sa.sa_flags = SA_RESTART;
> -	sigaction(SIGWINCH, &sa, NULL);

Could you please add this one back and just reinitialize curses? (I 
actually liked the new resize feature. :) )

BTW just add the other patch to this one, it's not that important to keep 
it separate.

bye, Roman


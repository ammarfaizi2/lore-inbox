Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265024AbSKFNEy>; Wed, 6 Nov 2002 08:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265025AbSKFNEy>; Wed, 6 Nov 2002 08:04:54 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:26630 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265024AbSKFNEv>; Wed, 6 Nov 2002 08:04:51 -0500
Date: Wed, 6 Nov 2002 14:11:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Petr Baudis <pasky@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kconfig] Single-menu mode support for make menuconfig
In-Reply-To: <20021103211632.GB20338@pasky.ji.cz>
Message-ID: <Pine.LNX.4.44.0211061359000.6949-100000@serv>
References: <20021103211632.GB20338@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Nov 2002, Petr Baudis wrote:

>   With this mode, when you enter a category, no new menu is open, but the
> category is unrolled to the current menu, thus the whole configuration is
> forming one single tree. Some users prefer this as a form of configuration, as
> they consider it easier to take in than the classical behaviour.

It looks mostly ok.

> diff -ru linux/scripts/kconfig/expr.h linux+pasky/scripts/kconfig/expr.h
> --- linux/scripts/kconfig/expr.h	Sun Nov  3 15:24:01 2002
> +++ linux+pasky/scripts/kconfig/expr.h	Sun Nov  3 15:00:17 2002
> @@ -169,6 +169,7 @@
>  	//char *help;
>  	struct file *file;
>  	int lineno;
> +	int expanded; /* solely for frontend use */
>  	//void *data;
>  };

The menu structure is mostly readonly, if front ends need to store 
something there, I'd rather reactivate the data field (which was meant for 
this, but it's currently not used).

> @@ -682,6 +699,9 @@
>  int main(int ac, char **av)
>  {
>  	int stat;
> +
> +	single_menu_mode = !!getenv("SINGLE_MENU");
> +
>  	conf_parse(av[1]);
>  	conf_read(NULL);
>  

Could you give it a different name (MENUCONFIG_MODE?) and check it 
contents instead of just testing for existence?

> diff -ru linux/scripts/lxdialog/util.c linux+pasky/scripts/lxdialog/util.c
> --- linux/scripts/lxdialog/util.c	Sun Nov  3 15:24:21 2002
> +++ linux+pasky/scripts/lxdialog/util.c	Sun Nov  3 15:11:44 2002
> @@ -348,7 +348,7 @@
>  		c = tolower(string[i]);
>  
>  		if (strchr("<[(", c)) ++in_paren;
> -		if (strchr(">])", c)) --in_paren;
> +		if (strchr(">])", c) && in_paren > 0) --in_paren;
>  
>  		if ((! in_paren) && isalpha(c) && 
>  		     strchr(exempt, c) == 0)

What's this needed for?

bye, Roman


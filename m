Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbTIJPzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbTIJPzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:55:48 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:14274 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S265085AbTIJPzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:55:43 -0400
Date: Wed, 10 Sep 2003 08:55:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030910155542.GD4559@ip68-0-152-218.tc.ph.cox.net>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <3F5DBC1F.8DF1F07A@eyal.emu.id.au> <20030910110225.GC27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910110225.GC27368@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 01:02:25PM +0200, Adrian Bunk wrote:

> On Tue, Sep 09, 2003 at 09:40:15PM +1000, Eyal Lebedinsky wrote:
> >...
>  In -test4 I have:
> > 
> > CONFIG_SERIO=m
> > CONFIG_SERIO_I8042=m
> > CONFIG_SERIO_SERPORT=m
> > CONFIG_SERIO_CT82C710=m
> > CONFIG_SERIO_PARKBD=m
> > CONFIG_SERIO_PCIPS2=m
> > 
> > but -test5 insists on:
> > 
> > CONFIG_SERIO=m
> > CONFIG_SERIO_I8042=y
> > CONFIG_SERIO_SERPORT=m
> > CONFIG_SERIO_CT82C710=m
> > CONFIG_SERIO_PARKBD=m
> > CONFIG_SERIO_PCIPS2=m
> > 
> > Removing the I8042 line and doing 'make oldconfig' does not even
> > ask about it but sets it to '=y'. As a result I get:
> > 
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > drivers/built-in.o: In function `atkbd_interrupt':
> > drivers/built-in.o(.text+0x6d10f): undefined reference to `serio_rescan'
> > drivers/built-in.o: In function `atkbd_disconnect':
> > drivers/built-in.o(.text+0x6d726): undefined reference to `serio_close'
> > drivers/built-in.o: In function `atkbd_connect':
> > drivers/built-in.o(.text+0x6d84e): undefined reference to `serio_open'
> > drivers/built-in.o(.text+0x6d883): undefined reference to `serio_close'
> > drivers/built-in.o: In function `atkbd_init':
> > drivers/built-in.o(.init.text+0x5fd6): undefined reference to
> > `serio_register_de
> > vice'
> > drivers/built-in.o: In function `atkbd_exit':
> > drivers/built-in.o(.exit.text+0x196): undefined reference to
> > `serio_unregister_d
> > evice'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> The patch below should fix it.
> 
> cu
> Adrian
> 
> --- linux-2.6.0-test4-mm5-modular-no-smp/drivers/input/keyboard/Kconfig.old	2003-09-04 19:03:45.000000000 +0200
> +++ linux-2.6.0-test4-mm5-modular-no-smp/drivers/input/keyboard/Kconfig	2003-09-04 19:04:49.000000000 +0200
> @@ -13,7 +13,8 @@
>  
>  config KEYBOARD_ATKBD
>  	tristate "AT keyboard support" if EMBEDDED || !X86 
> -	default y
> +	default y if INPUT=y && INPUT_KEYBOARD=y && SERIO=y
> +	default m
>  	depends on INPUT && INPUT_KEYBOARD && SERIO
>  	help
>  	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
> --- linux-2.6.0-test5+tr-modular-no-smp/drivers/input/serio/Kconfig.old	2003-09-10 12:52:22.000000000 +0200
> +++ linux-2.6.0-test5+tr-modular-no-smp/drivers/input/serio/Kconfig	2003-09-10 12:52:47.000000000 +0200
> @@ -20,7 +20,8 @@
>  
>  config SERIO_I8042
>  	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
> -	default y
> +	default y if SERIO=y
> +	default m
>  	depends on SERIO
>  	---help---
>  	  i8042 is the chip over which the standard AT keyboard and PS/2

A slightly better fix is for SERIO to default to Y on X86 and to
'select SERIO_I8042 if X86'.  Then have INPUT_KEYBOARD similarly select
KEYBOARD_ATKBD.

Or, IMHO, even better would be my patch to remove EMBEDDED and replace
it with STANDARD || NONSTD_ABI which also fixes the wierd uses of
EMBEDDED we have now.

-- 
Tom Rini
http://gate.crashing.org/~trini/

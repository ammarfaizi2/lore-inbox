Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbREQK2s>; Thu, 17 May 2001 06:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbREQK2i>; Thu, 17 May 2001 06:28:38 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:26116 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S261394AbREQK2Y>; Thu, 17 May 2001 06:28:24 -0400
Date: Thu, 17 May 2001 12:28:18 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] more initcall cleanups
In-Reply-To: <Pine.GSO.4.21.0105162217530.27492-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0105171202430.4285-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2001, Alexander Viro wrote:

> 	a) I2C stuff got converted to module_init() nicely. That took
> a lot of cruft away.

Definitely makes sense.

> 	b) init order is preserved. However, that worked only because
> none of the i2c initialization functions touch stuff from random.c

I don't think init order is preserved.

> 	c) I had to put i2c before char to preserve the ordering.
> Not a big deal, but I'm somewhat at loss here - how to do it without
> really ugly drivers/Makefile. Suggestions?

This part is not necessary. The ordering of subdir-y only has to do with
compilation ordering, not with link order. The link order for
drivers/char/* is set explicitly in the toplevel Makefile.

> 	d) if we set CONFIG_I2C to 'y' we don't include drivers/i2c
> into subdir-m. However, having i2c-core in kernel and the rest done as
> modules is OK with i2c itself. And I seriously suspect that it's
> a common situation. Am I right assuming that correct way to deal with
> that is to put i2c into mod-subdirs?

Yes, that's exactly what mod-subdirs is for.

> 	e) looks like rand_initialize() is in the same class as handling
> VFS/VM/etc. caches - global infrastructure. It definitely should be
> called before all other drivers. Notice that old device_init() was asking
> for trouble - it called parport_init() before chr_dev_init() (which calls
> rand_initialize()), so if somebody would try to feed some entropy into
> pool during the parport_init() we would get an interesting (and hard
> to understand) problem. Maybe we should move the call into basic_setup()?

I suppose I'm not the right one to comment on this, but it seems to make
sense to me.

> diff -urN S5-pre3-init-0/drivers/Makefile S5-pre3-init/drivers/Makefile
> --- S5-pre3-init-0/drivers/Makefile	Wed May 16 16:26:35 2001
> +++ S5-pre3-init/drivers/Makefile	Wed May 16 20:47:52 2001
> @@ -9,8 +9,13 @@
>  mod-subdirs :=	dio mtd sbus video macintosh usb input telephony sgi i2o ide \
>  		scsi md ieee1394 pnp isdn atm fc4 net/hamradio i2c acpi
>
> -subdir-y :=	parport char block net sound misc media cdrom
> -subdir-m :=	$(subdir-y)
> +subdir-y :=	parport
> +subdir-m :=	parport
> +
> +subdir-$(CONFIG_I2C)		+= i2c
> +
> +subdir-y +=	char block net sound misc media cdrom
> +subdir-m +=	char block net sound misc media cdrom
>
>
>  subdir-$(CONFIG_DIO)		+= dio
> @@ -40,7 +45,6 @@
>
>  # CONFIG_HAMRADIO can be set without CONFIG_NETDEVICE being set  -- ch
>  subdir-$(CONFIG_HAMRADIO)	+= net/hamradio
> -subdir-$(CONFIG_I2C)		+= i2c
>  subdir-$(CONFIG_ACPI)		+= acpi
>
>  include $(TOPDIR)/Rules.make

As stated above, this change won't affect vmlinux at all.

> diff -urN S5-pre3-init-0/drivers/char/random.c S5-pre3-init/drivers/char/random.c
> --- S5-pre3-init-0/drivers/char/random.c	Wed May 16 16:26:36 2001
> +++ S5-pre3-init/drivers/char/random.c	Wed May 16 20:40:12 2001
> @@ -1380,7 +1380,7 @@
>  	}
>  }
>
> -void __init rand_initialize(void)
> +static int __init rand_initialize(void)
>  {
>  	int i;
>
> @@ -1404,7 +1404,10 @@
>  	memset(&mouse_timer_state, 0, sizeof(struct timer_rand_state));
>  	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
>  	extract_timer_state.dont_count_entropy = 1;
> +	return 0;
>  }
> +
> +__initcall(rand_initialize);
>
>  void rand_initialize_irq(int irq)
>  {

prototype should be removed from include/linux/random.h

--Kai



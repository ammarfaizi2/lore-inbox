Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265661AbUFXVDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUFXVDE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265676AbUFXVDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:03:03 -0400
Received: from digitalimplant.org ([64.62.235.95]:11468 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S263820AbUFXVAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:00:24 -0400
Date: Thu, 24 Jun 2004 14:00:17 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: Re: SMP support for swsusp (this one actually works for me)
In-Reply-To: <20040623121727.GA26623@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0406241354340.32272-100000@monsoon.he.net>
References: <20040623121727.GA26623@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here's SMP support for swsusp; this one actually works for me [with
> keyboard hack], but I'd like more testers. If it looks okay, I'll
> merge simple pieces with andrew.

This looks cool, but I have some aesthetic nits about it:

> --- linux.orig/drivers/input/serio/i8042.c	2004-06-22 12:53:19.000000000 +0200
> +++ linux/drivers/input/serio/i8042.c	2004-06-22 12:38:06.000000000 +0200
> @@ -841,12 +841,13 @@
>  		return -1;
>  	}
>
> +#if 0
...
> +#endif
> +#if 0
...
> +#endif

If that's dead code, why not remove it?

> +#ifdef CONFIG_SMP
> +extern void smp_freeze(void);
> +extern void smp_restart(void);
> +#else
> +static inline void smp_freeze(void) {}
> +static inline void smp_restart(void) {}
> +#endif

Could you name those something more explicit, like swsusp_smp_freeze(),
etc, so you don't have potential namespace conflicts?

> +#if 1
>  			do_magic(0);
> +#else
> +			device_resume();
> +#endif

What is this? It looks completely gratuitous.

> --- linux.orig/arch/i386/power/cpu.c	2004-06-22 12:53:19.000000000 +0200
> +++ linux/arch/i386/power/cpu.c	2004-06-09 14:38:54.000000000 +0200

> -void save_processor_state(void)
> +void __save_processor_state(struct saved_context *ctxt)

> +void save_processor_state(void)
> +{
> +	__save_processor_state(&saved_context);
>  }

This also looks completely gratuitous and confusing - if you're not doing
anything else but calling the __function, then why even create __function?

>  EXPORT_SYMBOL(save_processor_state);
>  EXPORT_SYMBOL(restore_processor_state);

And, why are they exported in the first place?

> %diffstat
>  Documentation/power/swsusp.txt   |    5 +
>  Documentation/power/video.txt    |    4 +
>  arch/i386/kernel/cpu/mtrr/main.c |    3 +
>  arch/i386/kernel/signal.c        |    3 -
>  arch/i386/power/cpu.c            |  109 +++++++++++++++++++++------------------
>  arch/i386/power/swsusp.S         |    4 -
>  arch/x86_64/kernel/time.c        |   31 +++++++++--
>  drivers/acpi/event.c             |   24 +++-----
>  drivers/acpi/thermal.c           |   15 +++++
>  drivers/input/power.c            |   12 ++++
>  drivers/input/serio/i8042.c      |    6 +-
>  include/linux/suspend.h          |    8 ++
>  kernel/power/Makefile            |    1
>  kernel/power/process.c           |    1
>  kernel/power/smp.c               |   85 ++++++++++++++++++++++++++++++
>  kernel/power/swsusp.c            |   78 +++++++++++++++++++--------
>  kernel/signal.c                  |    6 +-
>  17 files changed, 293 insertions(+), 102 deletions(-)

Were there more files to the patch? Some of the ones listed here were not
in the email?

BTW, nice work.


	Pat

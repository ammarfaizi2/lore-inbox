Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263677AbREYKKy>; Fri, 25 May 2001 06:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263678AbREYKKo>; Fri, 25 May 2001 06:10:44 -0400
Received: from gold.MUSKOKA.COM ([216.123.107.5]:18706 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S263677AbREYKKk>;
	Fri, 25 May 2001 06:10:40 -0400
Message-ID: <3B0E210C.13B4DB8A@yahoo.com>
Date: Fri, 25 May 2001 05:08:28 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.4 i586)
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, akpm@uow.edu.au,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/net/others
In-Reply-To: <200105240102.DAA27178@green.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej, 

Some hopefully useful/constructive feedback:

Andrzej Krzysztofowicz wrote:
> 
> +static char version[]
> +#ifdef MODULE
> +       __initdata
> +#else
> +       __devinitdata
> +#endif
> +       = KERN_INFO RTL8139_DRIVER_NAME "\n";

This doesn't look right. If defined(MODULE) then __initdata
is a no-op (see linux/init.h).  You probably just want:

static char version[] __devinitdata = KERN_INFO ...... ;

assuming the drivers you are hacking are CONFIG_HOTPLUG capable.

Generally we should aim to reduce the number of #ifdef MODULE, rather
than add more.  If the driver load paths look the same regardless
of whether built in or modular then driver maintenance is easier.
(Ok, removing existing #ifdef MODULE is a 2.5 thing, but we should
avoid adding more in 2.4.x)

We can probably do something better with cases like these too:

> +#ifdef MODULE
> +       am79c961_banner();
> +#endif /* MODULE */

I think the days of kitchen sink kernels with 20 drivers all compiled in 
are over, and so we should just do the version printk/banner unconditionally. 
This way, if you have unused drivers built into your image, at least you 
will have a way of knowing it.  (People who don't use modules are clearly 
building their own kernels and don't want any unused drivers accidentally
glued into their image).

Other options for dealing with printing driver version info include:

(1) to replace the printk(...) with e.g. module_banner(...) and have the
conditional stuff hidden in how module_banner() is defined in module.h 

(2) have sys_create_module or sys_init_module print out the 
MODULE_DESCRIPTION and (optionally?) MODULE_AUTHOR for all modules
thus removing code replication from each module. (This assumes that
the modinfo section is, and will remain with modules in the future).

I personally like the sounds of (2) a lot.  Of course we would have to
make sure all modules had a useful MODULE_DESCRIPTION.

I'd avoid making patches like this:

> -#endif
> +#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */

...they fall into the category of "patching for the sake of patching"
(which is not good in 2.4.x) and you end up inflicting your style on 
the original author(s) who may not like it (especially if the corresponding
#ifdef is only one line up...).  One could argue that the printk(version)
vs. printk("%s\n", version) changes fall into the same category...

Also might want to avoid changes like this:

> -       if (ei_debug  &&  version_printed++ == 0)
> +       if (version_printed++ == 0)
>                 printk(version);

that are actually changing the original author's intention. In this case
(ne.c) the compiled output remains unchanged, and I'm okay with the
change in intention since we now have the "quiet" boot argument anyway.

Also, if you are changing version strings like this:

 static char version[] __initdata =
-    "at1700.c:v1.15 4/7/98  Donald\ Becker(becker@cesdis.gsfc.nasa.gov)\n";
+    KERN_INFO "at1700.c:v1.15 4/7/98  Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";

to add KERN_xxx tags, then you could also:
	 s/becker@cesdis.gsfc.nasa.gov/becker@scyld.com/
and I'm sure Donald would thank you for it.

Finally, breaking your patch into logical chunks / separate e-mails would 
also ensure that your work has a better chance of getting used - e.g.

 [PATCH] add KERN_INFO to version tags of net drivers
 [PATCH] missing __[dev]initdata in net drivers
 [PATCH] add MODULE_PARM_DESC to various net drivers

...and so on.  If somebody doesn't like one part, then at least 
the rest doesn't get tossed out as well.

Ok, I'll shut up now.  Hope you find this useful,

Paul.


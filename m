Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263719AbREYLjU>; Fri, 25 May 2001 07:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263720AbREYLjK>; Fri, 25 May 2001 07:39:10 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:12984 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S263719AbREYLi7>; Fri, 25 May 2001 07:38:59 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200105251138.NAA13986@sunrise.pg.gda.pl>
Subject: Re: [PATCH] drivers/net/others
To: p_gortmaker@yahoo.com (Paul Gortmaker)
Date: Fri, 25 May 2001 13:38:19 +0200 (MET DST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <3B0E210C.13B4DB8A@yahoo.com> from "Paul Gortmaker" at May 25, 2001 05:08:28 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul Gortmaker wrote:"
> Some hopefully useful/constructive feedback:
> 
> Andrzej Krzysztofowicz wrote:
> > 
> > +static char version[]
> > +#ifdef MODULE
> > +       __initdata
> > +#else
> > +       __devinitdata
> > +#endif
> > +       = KERN_INFO RTL8139_DRIVER_NAME "\n";
> 
> This doesn't look right. If defined(MODULE) then __initdata
> is a no-op (see linux/init.h).  You probably just want:

Currently it is no-op.
Hopefully it would change some day. I've seen a patch pointer somewhere.

Maybe you are right that potential only remove of one string from loaded
module code is not worth the change.

> Generally we should aim to reduce the number of #ifdef MODULE, rather
> than add more.  If the driver load paths look the same regardless
> of whether built in or modular then driver maintenance is easier.
> (Ok, removing existing #ifdef MODULE is a 2.5 thing, but we should
> avoid adding more in 2.4.x)

IMO there's no difference whoether there's 3 or 4 of them.
There's no point in adding an new #ifdef only if there's none currently
(IMHO).

> We can probably do something better with cases like these too:
> 
> > +#ifdef MODULE
> > +       am79c961_banner();
> > +#endif /* MODULE */
> 
> I think the days of kitchen sink kernels with 20 drivers all compiled in 
> are over, and so we should just do the version printk/banner unconditionally. 

Jeff, your opinion here ?

> This way, if you have unused drivers built into your image, at least you 
> will have a way of knowing it.  (People who don't use modules are clearly 
> building their own kernels and don't want any unused drivers accidentally
> glued into their image).

> Other options for dealing with printing driver version info include:
> 
> (1) to replace the printk(...) with e.g. module_banner(...) and have the
> conditional stuff hidden in how module_banner() is defined in module.h 
> 
> (2) have sys_create_module or sys_init_module print out the 
> MODULE_DESCRIPTION and (optionally?) MODULE_AUTHOR for all modules
> thus removing code replication from each module. (This assumes that
> the modinfo section is, and will remain with modules in the future).

> I personally like the sounds of (2) a lot.  Of course we would have to
> make sure all modules had a useful MODULE_DESCRIPTION.
> 
> I'd avoid making patches like this:
> 
> > -#endif
> > +#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */

OK.

> ...they fall into the category of "patching for the sake of patching"
> (which is not good in 2.4.x) and you end up inflicting your style on 
> the original author(s) who may not like it (especially if the corresponding
> #ifdef is only one line up...).  One could argue that the printk(version)
> vs. printk("%s\n", version) changes fall into the same category...
> 
> Also might want to avoid changes like this:
> 
> > -       if (ei_debug  &&  version_printed++ == 0)
> > +       if (version_printed++ == 0)
> >                 printk(version);

It was intentional. I follor Jeff's suggestion of printing the version banner
rules, i.e.
- print version unconditionally for modules
- print version only if hardware has been detected for built-in.

Having different behaviour of different modules here is very bad IMO.

> that are actually changing the original author's intention. In this case
> (ne.c) the compiled output remains unchanged, and I'm okay with the

Unfinished.

> change in intention since we now have the "quiet" boot argument anyway.
> 
> Also, if you are changing version strings like this:
> 
>  static char version[] __initdata =
> -    "at1700.c:v1.15 4/7/98  Donald\ Becker(becker@cesdis.gsfc.nasa.gov)\n";
> +    KERN_INFO "at1700.c:v1.15 4/7/98  Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
> 
> to add KERN_xxx tags, then you could also:
> 	 s/becker@cesdis.gsfc.nasa.gov/becker@scyld.com/

OK. Thanks for the suggestion.

> and I'm sure Donald would thank you for it.
> 
> Finally, breaking your patch into logical chunks / separate e-mails would 
> also ensure that your work has a better chance of getting used - e.g.

Final version will be splitted out with Cc: to the appropriate maintainers.

>  [PATCH] add KERN_INFO to version tags of net drivers
>  [PATCH] missing __[dev]initdata in net drivers
>  [PATCH] add MODULE_PARM_DESC to various net drivers

IMO, no chance. They are too close to be separated in many places.
I would rather find out which of the changes are bad/unacceptable.

Thanks for your comments.

Andrzej

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk


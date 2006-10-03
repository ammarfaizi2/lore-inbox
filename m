Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030457AbWJCSae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbWJCSae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbWJCSae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:30:34 -0400
Received: from xenotime.net ([66.160.160.81]:1215 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030457AbWJCSad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:30:33 -0400
Date: Tue, 3 Oct 2006 11:31:57 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Florin Malita <fmalita@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, Dave Jones <davej@redhat.com>,
       devzero@web.de, Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [PATCH] list module taint flags in Oops/panic
Message-Id: <20061003113157.17639526.rdunlap@xenotime.net>
In-Reply-To: <4521D340.9030301@gmail.com>
References: <20060928191200.5b76998c.rdunlap@xenotime.net>
	<4521D340.9030301@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2006 23:04:32 -0400 Florin Malita wrote:

> Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> >
> > When listing loaded modules during an oops or panic, also list each
> > module's Tainted flags if non-zero (P: Proprietary or F: Forced load only).
> >   
> 
> Funny, I was playing with something very similar last weekend, then I
> noticed your patch merged into mainline ;) So here are some comments...

Yep, all good.  Thanks for the fixes.
Acked-by: Randy Dunlap <rdunlap@xenotime.net>


> > --- linux-2618-g10.orig/include/linux/module.h
> > +++ linux-2618-g10/include/linux/module.h
> > @@ -320,6 +320,8 @@ struct module
> >  	/* Am I GPL-compatible */
> >  	int license_gplok;
> >  
> > +	unsigned int taints;	/* same bits as kernel:tainted */
> >   
> 
> No need to keep 'license_gplok' around anymore, it should be equivalent
> to !(taints & TAINT_PROPRIETARY_MODULE).
> 
> > @@ -851,6 +851,7 @@ static int check_version(Elf_Shdr *sechd
> >  		printk("%s: no version for \"%s\" found: kernel tainted.\n",
> >  		       mod->name, symname);
> >  		add_taint(TAINT_FORCED_MODULE);
> > +		mod->taints |= TAINT_FORCED_MODULE;
> >  	}
> >   
> 
> This seems wrong, it only dirties mod->taints if the kernel is not
> already F-tainted (the branch is conditioned by !(tainted &
> TAINT_FORCED_MODULE)). So only the first forcefully-loaded module gets
> its F bit set, which is probably not the intention...
> 
> > @@ -1325,6 +1326,7 @@ static void set_license(struct module *m
> >  		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
> >  		       mod->name, license);
> >  		add_taint(TAINT_PROPRIETARY_MODULE);
> > +		mod->taints |= TAINT_PROPRIETARY_MODULE;
> >  	}
> >   
> 
> Similarly here, will only take the branch upon loading the first
> proprietary module (conditional on !(tainted & TAINT_PROPRIETARY_MODULE)).
> 
> The currently merged version also has a problem in taint_flags():
> 
> static char *taint_flags(unsigned int taints, char *buf)
> {
>         *buf = '\0';
>         if (taints) {
>                 int bx;
> 
>                 buf[0] = '(';
>                 bx = 1;
>                 if (taints & TAINT_PROPRIETARY_MODULE)
>                         buf[bx++] = 'P';
>                 if (taints & TAINT_FORCED_MODULE)
>                         buf[bx++] = 'F';
>                 /*
>                  * TAINT_FORCED_RMMOD: could be added.
>                  * TAINT_UNSAFE_SMP, TAINT_MACHINE_CHECK, TAINT_BAD_PAGE
> don't
>                  * apply to modules.
>                  */
>                 buf[bx] = ')';
>         }
>         return buf;
> }
> 
> The buffer is not NULL-terminated after printing the flags.
> 
> Also, it would be nice to show per-module taint info in /proc/modules
> too. So how about the following (applies on top of the merged
> version/current git, tested):
> 
> Signed-off-by: Florin Malita <fmalita@gmail.com>
> ---
> 
>  include/linux/module.h |    3 -
>  kernel/module.c        |   94 +++++++++++++++++++++++++------------------------
>  2 files changed, 49 insertions(+), 48 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 4b2d809..d1d00ce 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -317,9 +317,6 @@ struct module
>  	/* Am I unsafe to unload? */
>  	int unsafe;
>  
> -	/* Am I GPL-compatible */
> -	int license_gplok;
> -
>  	unsigned int taints;	/* same bits as kernel:tainted */
>  
>  #ifdef CONFIG_MODULE_UNLOAD
> diff --git a/kernel/module.c b/kernel/module.c
> index 7c77a0a..a258cd5 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -87,6 +87,12 @@ static inline int strong_try_module_get(
>  	return try_module_get(mod);
>  }
>  
> +static inline void add_taint_module(struct module *mod, unsigned flag)
> +{
> +	add_taint(flag);
> +	mod->taints |= flag;
> +}
> +
>  /* A thread that wants to hold a reference to a module only while it
>   * is running can call ths to safely exit.
>   * nfsd and lockd use this.
> @@ -847,12 +853,10 @@ static int check_version(Elf_Shdr *sechd
>  		return 0;
>  	}
>  	/* Not in module's version table.  OK, but that taints the kernel. */
> -	if (!(tainted & TAINT_FORCED_MODULE)) {
> +	if (!(tainted & TAINT_FORCED_MODULE))
>  		printk("%s: no version for \"%s\" found: kernel tainted.\n",
>  		       mod->name, symname);
> -		add_taint(TAINT_FORCED_MODULE);
> -		mod->taints |= TAINT_FORCED_MODULE;
> -	}
> +	add_taint_module(mod, TAINT_FORCED_MODULE);
>  	return 1;
>  }
>  
> @@ -910,7 +914,8 @@ static unsigned long resolve_symbol(Elf_
>  	unsigned long ret;
>  	const unsigned long *crc;
>  
> -	ret = __find_symbol(name, &owner, &crc, mod->license_gplok);
> +	ret = __find_symbol(name, &owner, &crc,
> +			!(mod->taints & TAINT_PROPRIETARY_MODULE));
>  	if (ret) {
>  		/* use_module can fail due to OOM, or module unloading */
>  		if (!check_version(sechdrs, versindex, name, mod, crc) ||
> @@ -1335,12 +1340,11 @@ static void set_license(struct module *m
>  	if (!license)
>  		license = "unspecified";
>  
> -	mod->license_gplok = license_is_gpl_compatible(license);
> -	if (!mod->license_gplok && !(tainted & TAINT_PROPRIETARY_MODULE)) {
> -		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
> -		       mod->name, license);
> -		add_taint(TAINT_PROPRIETARY_MODULE);
> -		mod->taints |= TAINT_PROPRIETARY_MODULE;
> +	if (!license_is_gpl_compatible(license)) {
> +		if (!(tainted & TAINT_PROPRIETARY_MODULE))
> +			printk(KERN_WARNING "%s: module license '%s' taints"
> +				"kernel.\n", mod->name, license);
> +		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
>  	}
>  }
>  
> @@ -1619,8 +1623,7 @@ #endif
>  	modmagic = get_modinfo(sechdrs, infoindex, "vermagic");
>  	/* This is allowed: modprobe --force will invalidate it. */
>  	if (!modmagic) {
> -		add_taint(TAINT_FORCED_MODULE);
> -		mod->taints |= TAINT_FORCED_MODULE;
> +		add_taint_module(mod, TAINT_FORCED_MODULE);
>  		printk(KERN_WARNING "%s: no version magic, tainting kernel.\n",
>  		       mod->name);
>  	} else if (!same_magic(modmagic, vermagic)) {
> @@ -1714,14 +1717,10 @@ #endif
>  	/* Set up license info based on the info section */
>  	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
>  
> -	if (strcmp(mod->name, "ndiswrapper") == 0) {
> -		add_taint(TAINT_PROPRIETARY_MODULE);
> -		mod->taints |= TAINT_PROPRIETARY_MODULE;
> -	}
> -	if (strcmp(mod->name, "driverloader") == 0) {
> -		add_taint(TAINT_PROPRIETARY_MODULE);
> -		mod->taints |= TAINT_PROPRIETARY_MODULE;
> -	}
> +	if (strcmp(mod->name, "ndiswrapper") == 0)
> +		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
> +	if (strcmp(mod->name, "driverloader") == 0)
> +		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
>  
>  	/* Set up MODINFO_ATTR fields */
>  	setup_modinfo(mod, sechdrs, infoindex);
> @@ -1766,8 +1765,7 @@ #ifdef CONFIG_MODVERSIONS
>  	    (mod->num_unused_gpl_syms && !unusedgplcrcindex)) {
>  		printk(KERN_WARNING "%s: No versions for exported symbols."
>  		       " Tainting kernel.\n", mod->name);
> -		add_taint(TAINT_FORCED_MODULE);
> -		mod->taints |= TAINT_FORCED_MODULE;
> +		add_taint_module(mod, TAINT_FORCED_MODULE);
>  	}
>  #endif
>  
> @@ -2131,9 +2129,33 @@ static void m_stop(struct seq_file *m, v
>  	mutex_unlock(&module_mutex);
>  }
>  
> +static char *taint_flags(unsigned int taints, char *buf)
> +{
> +	int bx = 0;
> +	
> +	if (taints) {
> +		buf[bx++] = '(';
> +		if (taints & TAINT_PROPRIETARY_MODULE)
> +			buf[bx++] = 'P';
> +		if (taints & TAINT_FORCED_MODULE)
> +			buf[bx++] = 'F';
> +		/*
> +		 * TAINT_FORCED_RMMOD: could be added.
> +		 * TAINT_UNSAFE_SMP, TAINT_MACHINE_CHECK, TAINT_BAD_PAGE don't
> +		 * apply to modules.
> +		 */
> +		buf[bx++] = ')';
> +	}
> +	buf[bx] = '\0';
> +
> +	return buf;
> +}
> +
>  static int m_show(struct seq_file *m, void *p)
>  {
>  	struct module *mod = list_entry(p, struct module, list);
> +	char buf[8];
> +
>  	seq_printf(m, "%s %lu",
>  		   mod->name, mod->init_size + mod->core_size);
>  	print_unload_info(m, mod);
> @@ -2146,6 +2168,10 @@ static int m_show(struct seq_file *m, vo
>  	/* Used by oprofile and other similar tools. */
>  	seq_printf(m, " 0x%p", mod->module_core);
>  
> +	/* Taints info */
> +	if (mod->taints)
> +		seq_printf(m, " %s", taint_flags(mod->taints, buf));
> +
>  	seq_printf(m, "\n");
>  	return 0;
>  }
> @@ -2234,28 +2260,6 @@ struct module *module_text_address(unsig
>  	return mod;
>  }
>  
> -static char *taint_flags(unsigned int taints, char *buf)
> -{
> -	*buf = '\0';
> -	if (taints) {
> -		int bx;
> -
> -		buf[0] = '(';
> -		bx = 1;
> -		if (taints & TAINT_PROPRIETARY_MODULE)
> -			buf[bx++] = 'P';
> -		if (taints & TAINT_FORCED_MODULE)
> -			buf[bx++] = 'F';
> -		/*
> -		 * TAINT_FORCED_RMMOD: could be added.
> -		 * TAINT_UNSAFE_SMP, TAINT_MACHINE_CHECK, TAINT_BAD_PAGE don't
> -		 * apply to modules.
> -		 */
> -		buf[bx] = ')';
> -	}
> -	return buf;
> -}
> -
>  /* Don't grab lock, we're oopsing. */
>  void print_modules(void)
>  {
> 
> 
> -

---
~Randy

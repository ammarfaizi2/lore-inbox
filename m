Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUCLHA2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 02:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUCLHA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 02:00:28 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:61118 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261989AbUCLHAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 02:00:19 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: [Kgdb-bugreport] module scanning in kgdb 2.x
Date: Fri, 12 Mar 2004 12:30:00 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>
References: <200403121206.16130.amitkale@emsyssoft.com>
In-Reply-To: <200403121206.16130.amitkale@emsyssoft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403121230.00897.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The gdb code for this is completely different from the one that works with 2.4 
kernels. I'll post it at kgdb.sourceforge.net when I checkin this change.

-Amit

On Friday 12 Mar 2004 12:06 pm, Amit S. Kale wrote:
> Hi,
>
> Here is code to scan modules in kgdb for 2.6 kernels. It's been contributed
> by TimeSys Corporation.
>
> It does following things:
> 1. Adds MODULE_STATE_GONE to indicate that a module was removed. This is
> differnent from MODULE_STATE_GOING. gdb needs to be notified of a module
> event _after_ a module has been removed. Or else it'll still find the
> module during a module list scan and will not remove it from its core.
>
> 2. Defines a structure mod_section which stores module section names and
> offsets preserved during loading of a module.
>
> 3. Adds a couple of fields to struct module to keep module section
> information.
>
> 4. Adds a few notifications for gdb to know module related events.
>
> 5. Saves module section names and offsets in load_module.
>
> -Amit
>
> Index: linux-2.6.3-kgdb/include/linux/module.h
> ===================================================================
> --- linux-2.6.3-kgdb.orig/include/linux/module.h	2004-02-24
> 10:44:47.000000000 +0530
> +++ linux-2.6.3-kgdb/include/linux/module.h	2004-03-04 18:58:47.116645760
> +0530
> @@ -186,8 +186,17 @@
>  	MODULE_STATE_LIVE,
>  	MODULE_STATE_COMING,
>  	MODULE_STATE_GOING,
> +	MODULE_STATE_GONE,
>  };
>
> +#ifdef CONFIG_KGDB
> +#define MAX_SECTNAME 31
> +struct mod_section {
> +	void *address;
> +	char name[MAX_SECTNAME + 1];
> +};
> +#endif
> +
>  struct module
>  {
>  	enum module_state state;
> @@ -198,6 +207,13 @@
>  	/* Unique handle for this module */
>  	char name[MODULE_NAME_LEN];
>
> +#ifdef CONFIG_KGDB
> +	/* keep kgdb info at the begining so that gdb doesn't have a chance to
> +	 * miss out any fields */
> +	unsigned long num_sections;
> +	struct mod_section *mod_sections;
> +#endif
> +
>  	/* Exported symbols */
>  	const struct kernel_symbol *syms;
>  	unsigned int num_syms;
> Index: linux-2.6.3-kgdb/kernel/module.c
> ===================================================================
> --- linux-2.6.3-kgdb.orig/kernel/module.c	2004-02-24 10:44:56.000000000
> +0530 +++ linux-2.6.3-kgdb/kernel/module.c	2004-03-04 18:55:59.136182672
> +0530 @@ -727,6 +727,11 @@
>  	mod->state = MODULE_STATE_GOING;
>  	restart_refcounts();
>
> +	down(&notify_mutex);
> +	notifier_call_chain(&module_notify_list, MODULE_STATE_GOING,
> +				mod);
> +	up(&notify_mutex);
> +
>  	/* Never wait if forced. */
>  	if (!forced && module_refcount(mod) != 0)
>  		wait_for_zero_refcount(mod);
> @@ -734,6 +739,10 @@
>  	/* Final destruction now noone is using it. */
>  	mod->exit();
>  	free_module(mod);
> +	down(&notify_mutex);
> +	notifier_call_chain(&module_notify_list, MODULE_STATE_GONE,
> +				NULL);
> +	up(&notify_mutex);
>
>   out:
>  	up(&module_mutex);
> @@ -1087,6 +1096,11 @@
>  	/* Arch-specific cleanup. */
>  	module_arch_cleanup(mod);
>
> +#ifdef CONFIG_KGDB
> +	/* kgdb info */
> +	vfree(mod->mod_sections);
> +#endif
> +
>  	/* Module unload stuff */
>  	module_unload_free(mod);
>
> @@ -1302,6 +1316,30 @@
>  	return NULL;
>  }
>
> +#ifdef CONFIG_KGDB
> +int add_modsects (struct module *mod, Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> const +		char *secstrings)
> +{
> +	int i;
> +
> +	mod->num_sections = hdr->e_shnum - 1;
> +	mod->mod_sections = vmalloc((hdr->e_shnum - 1)* sizeof (struct
> mod_section));
> +
> +	if (mod->mod_sections == NULL) {
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 1; i < hdr->e_shnum; i++) {
> +		mod->mod_sections[i - 1].address = (void *)sechdrs[i].sh_addr;
> +		strncpy(mod->mod_sections[i - 1].name, secstrings +
> +				sechdrs[i].sh_name, MAX_SECTNAME);
> +		mod->mod_sections[i - 1].name[MAX_SECTNAME] = '\0';
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_KALLSYMS
>  int is_exported(const char *name, const struct module *mod)
>  {
> @@ -1650,6 +1688,12 @@
>  	percpu_modcopy(mod->percpu, (void *)sechdrs[pcpuindex].sh_addr,
>  		       sechdrs[pcpuindex].sh_size);
>
> +#ifdef CONFIG_KGDB
> +	if ((err = add_modsects(mod, hdr, sechdrs, secstrings)) < 0) {
> +		goto nomodsectinfo;
> +	}
> +#endif
> +
>  	err = module_finalize(hdr, sechdrs, mod);
>  	if (err < 0)
>  		goto cleanup;
> @@ -1688,6 +1732,11 @@
>   arch_cleanup:
>  	module_arch_cleanup(mod);
>   cleanup:
> +
> +#ifdef CONFIG_KGDB
> +nomodsectinfo:
> +	vfree(mod->mod_sections);
> +#endif
>  	module_unload_free(mod);
>  	module_free(mod, mod->module_init);
>   free_core:
> @@ -1758,7 +1807,12 @@
>  	if (ret < 0) {
>  		/* Init routine failed: abort.  Try to protect us from
>                     buggy refcounters. */
> +
>  		mod->state = MODULE_STATE_GOING;
> +		down(&notify_mutex);
> +		notifier_call_chain(&module_notify_list, MODULE_STATE_GOING,
> +					mod);
> +		up(&notify_mutex);
>  		synchronize_kernel();
>  		if (mod->unsafe)
>  			printk(KERN_ERR "%s: module is now stuck!\n",
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Kgdb-bugreport mailing list
> Kgdb-bugreport@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport


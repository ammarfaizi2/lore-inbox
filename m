Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVLLWBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVLLWBS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 17:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVLLWBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 17:01:18 -0500
Received: from ozlabs.org ([203.10.76.45]:23486 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932109AbVLLWBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 17:01:17 -0500
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel,
	avoiding Undefined behaviour
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Cc: anandhkrishnan@yahoo.com, linux-kernel@vger.kernel.org, rth@redhat.com,
       akpm@osdl.org, Greg KH <greg@kroah.com>
In-Reply-To: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 09:01:18 +1100
Message-Id: <1134424878.22036.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 18:09 +0530, Ashutosh Naik wrote:
> diff -Naurp linux-2.6.15-rc5-vanilla/kernel/module.c linux-2.6.15-rc5-mod/kernel/module.c
> --- linux-2.6.15-rc5-vanilla/kernel/module.c    2005-12-07 19:32:23.000000000 +0530
> +++ linux-2.6.15-rc5-mod/kernel/module.c        2005-12-12 17:47:28.000000000 +0530
> @@ -1204,6 +1204,63 @@ void *__symbol_get(const char *symbol)
>  }
>  EXPORT_SYMBOL_GPL(__symbol_get);
>  
> +/*
> + * Ensure that an exported symbol [global namespace] does not already exist
> + * in the Kernel or in some other modules exported symbol table.
> + */
> +static int verify_export_symbols(Elf_Shdr *sechdrs,
> +                           const char *strtab,
> +                           struct module *mod)
> +{
> +       struct kernel_symbol *exportsym, *gplsym;
> +       unsigned long i,ret=0,value=0;
> +       struct module *owner;
> +       const unsigned long *crc;
> +       unsigned long index=0;
> +        
> +       spin_lock_irq(&modlist_lock);
> +
> +       exportsym = (struct kernel_symbol *)mod->syms;
> +       gplsym = (struct kernel_symbol *)mod->gpl_syms;
> +
> +       if (exportsym)
> +               for (i = 0; i < mod->num_syms; exportsym++,i++) {

Hi,
	The check for exportsym not being NULL is redundant, since
mod->num_syms will be 0 in that case.  The cast is also redundant.  You
have two identical failure cases at the bottom.  And your use of index
is convoluted: do it after relocations.

How about something like:

	const struct kernel_symbol *sym;
	unsigned int i;
	const unsigned long *crc;
	struct module *owner;

	spin_lock_irq(&modlist_lock);
	for (i = 0; i < mod->num_syms; i++)
		if (__find_symbol(mod->syms[i].name, &owner, &crc, 1))
			goto dup;
	for (i = 0; i < num->num_gpl_syms; i++)
		if (__find_symbol(mod->gpl_syms[i].name,&owner,&crc,1))
			goto dup;
	spin_unlock_irq(&modlist_lock);
	return 0;
dup:
	printk("%s: exports duplicate symbol (owned by %s)\n",
		mod->name, module_name(owner));
	return -ENOEXEC;
}

Cheers,
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol


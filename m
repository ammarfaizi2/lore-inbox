Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTLAJS6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 04:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTLAJS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 04:18:58 -0500
Received: from dp.samba.org ([66.70.73.150]:46563 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262174AbTLAJSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 04:18:53 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Tiago Sant' Anna" <sapuglha@yahoo.com.br>
Cc: sisopiii-l@cscience.org, linux-kernel@vger.kernel.org,
       julianofs@pop.com.br
Subject: Re: New feature: Removal of the exceptions wich belongs to the init section 
In-reply-to: Your message of "Fri, 28 Nov 2003 15:58:53 -0200."
             <20031128155853.33283fec.sapuglha@yahoo.com.br> 
Date: Mon, 01 Dec 2003 17:03:09 +1100
Message-Id: <20031201091853.2EC342C01B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031128155853.33283fec.sapuglha@yahoo.com.br> you write:
> Hello Rusty,

Hi,

> We, Juliano (julianofs@pop.com.br) and I (Tiago Sant' Anna
> (sapuglha@yahoo.com.br) developed this patch.

	I've commented on your patch: I hope you find my feedback
useful.

> diff -Nur linux-2.6.0-test9-vanilla/arch/alpha/mm/extable.c linux-2.6.0-test9-modified/arch/alpha/mm/extable.c
> --- linux-2.6.0-test9-vanilla/arch/alpha/mm/extable.c	2003-10-25 16:42:52.000000000 -0200
> +++ linux-2.6.0-test9-modified/arch/alpha/mm/extable.c	2003-11-28 10:43:18.000000000 -0200
> @@ -27,3 +27,18 @@
>  
>          return NULL;
>  }

It's generally not a good idea to write code for architectures which
you don't have access to, but to leave them for arch maintainers to
sort out.

> +/* Exception_table_entry Comparison. Only the field insn is considered. 
> +   Results:
> +	equal: 0
> +	ex1 less than ex2: -1
> +	ex1 major than ex2: 1
> +*/

This comment is a little verbose: I would simply say:

/* Compare two exception table entries: < 0 if ex1 comes before ex2. */

> +int extable_cmp(const struct exception_table_entry ex1, const struct exception_table_entry ex2) {
> +	
> +	if (ex1.insn < ex2.insn)
> +		return(-1);
> +	else if (ex1.insn > ex2.insn)
> +		return(1);
> +	return(0);
> +}

And it can be implemented as "return (long)ex1.insn - ex2.insn;",
making it a candidate for an inline function in the asm/uaccess.h
header.

> +/* Verify if the addr belongs to the init section */
> +static inline int within_mod_init_section(unsigned long addr, 
> +                                          void *start, unsigned long size)
> +{
> +	    return ((void *)addr >= start && (void *)addr < start + size);
> +}
> +
> +/* Remove exception table entries that point to init area.
> + * It will be used in the unload of init section.
> + */
> +void remove_init_exceptions(struct module *mod) {

This comment is not quite true.  The exception entries themselves are
in the __ex_table section, which is in the module code.  Some of the
"insn" pointers are into the module init section, which is to be
discarded.

This function should be in kernel/extable.c.

> +
> +	static spinlock_t init_ex_remove = SPIN_LOCK_UNLOCKED;

Do not invent your own lock.  You only need to protect against the
exception table walk by other CPUs, for which modlist_lock is
sufficient.

> +
> +	const struct exception_table_entry *local;
> +	unsigned int i;
> +	int num_init_ex=0;
> +
> +
> +	local = mod->extable;
> +	i = 1;
> +
> +	while (i <= mod->num_exentries) {
> +		if (within_mod_init_section((unsigned long) local->insn, mod->module_init, mod->init_size)) {
> +			num_init_ex++;			
> +		}
> +		else break;
> +		local = local+1;
> +		i++;
> +	}
> +
> +	local = mod->extable;

This code is incorrect.  The init section could be before or after the
core section, meaning that all the init-related exceptions will be at
the start, or at the end.  So, the code would look like this:

void remove_init_exceptions(struct module *mod)
{
	int i;

	if (!mod->module_init)
		return;

	spin_lock(&modlist_lock);
	if (mod->module_init > mod->module_core) {
		/* init exception entries at the end.  Trim */
		for (i = mod->num_exentries-1; i >= 0; i--)
			if (within(mod->extable[i].insn,
				   mod->module_init, mod->init_size))
				mod->num_exentries--;
	} else {
		/* init exception entries at the start.  Move ptr. */
		for (i = 0; i < mod->num_exentries; i++) {
			if (!within(mod->extable[i].insn,
				    mod->module_init, mod->init_size))
				break;
		}
		mod->extable += i;
		mod->num_exentries -= i;
	}
	spin_nulock(&modlist_lock);
}
		
> +	/* Unload the init exceptions */
> +	for(i=0; i < num_init_ex; ++i)
> +		kfree(local+i);

This doesn't make sense: these are not pointers, but are part of
module->core!  They will be freed in the normal way.

>  /* Free memory returned from module_alloc */
>  void module_free(struct module *mod, void *module_region)
> -{
> +{	
> +	/* Remove exception entries of the init section */
> +	if (module_region == mod->module_init) {
> +		remove_init_exceptions(mod);
> +	}
> +	

Call this from kernel/module.c directly.

> +++ linux-2.6.0-test9-modified/include/linux/extable.h	2003-11-28 10:4
0:57.000000000 -0200
> @@ -0,0 +1,51 @@
> +#ifndef _EXTABLE_H
> +#define _EXTABLE_H
> +
> +/*
> + * Functions regarding to exception's table.
> + *
> + *	* Written by Juliano Silva and Tiago Silva, 2003
> + *	
> + **/
> +
> +
> +#include <linux/module.h>
> +#include <asm/uaccess.h>
> +#include <asm/sections.h>
> +#include <linux/init.h>
> + 
> +/* Exception_table_entry Comparison. Only the field insn is considered.
> + *   Results:
> + *            equal: 0
> + *            ex1 less than ex2: -1
> + *            ex1 major than ex2: 1
> + *                                                         */
> +extern int extable_cmp(struct exception_table_entry ex1,
> +                       struct exception_table_entry ex2);
> +
> +/* This code sorts an exception table. It is very used with modules code 
> + * void __init_or_module sort_ex_table(struct exception_table_entry *start,
> + * struct exception_table_entry *finish);
> + */
> +void __init_or_module sort_ex_table(struct exception_table_entry *start, struct exception_table_entry *finish)

Never put non-inline functions in a header file.  And never inline a
function this large.

Since this is only called from module.c, perhaps put it in
include/linux/moduleloader.h and the code in extable.c.

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

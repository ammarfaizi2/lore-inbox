Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVLMQuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVLMQuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVLMQuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:50:25 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:50376 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932393AbVLMQuY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:50:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dg/hDMctlNI5TG86o7fHw9v+RZESfFPC9s0K4XSL9XFDQKtA6PczITurpJzphGy6PS722vH63miD1ZdooPkPQc0IdLwizTN6uHHohjo0f7vBpDl4rt58PxHl0WW3aJKuvcFUD7cNdADxhSQ80+uIXODDBBurb7O8eA6KgQDQorY=
Message-ID: <9a8748490512130849o73c14313l166e6dd360f32d70@mail.gmail.com>
Date: Tue, 13 Dec 2005 17:49:44 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
Cc: Rusty Russell <rusty@rustcorp.com.au>, anandhkrishnan@yahoo.co.in,
       linux-kernel@vger.kernel.org, rth@redhat.com, akpm@osdl.org,
       Greg KH <greg@kroah.com>, alan@lxorguk.ukuu.org.uk
In-Reply-To: <81083a450512130626x417d86c9w31f300555c99fdb2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <1134424878.22036.13.camel@localhost.localdomain>
	 <81083a450512130626x417d86c9w31f300555c99fdb2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Ashutosh Naik <ashutosh.naik@gmail.com> wrote:
> On 12/13/05, Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > How about something like:
> >
[snip imrovement suggestion]
>
> Have tried that in the attached patch. However,  mod->syms[i].name
> would be valid only after a long relocation for loop has run through.
> While this adds a wee bit extra overhead, that overhead is only in the
> case where the module does actually export a Duplicate Symbol.
>
> This its a question, whether we do the search before relocation ( A
> little messier ) or after ( More straight forward)
>

hmm, patch still attached instead of inlined... :-(

Anyway, a few minor comments below.

>
> --- /usr/src/linux-2.6.15-rc5-vanilla/kernel/module.c	2005-12-07 19:32:23.000000000 +0530
> +++ /usr/src/linux-2.6.15-rc5/kernel/module.c	2005-12-13 19:44:43.000000000 +0530
> @@ -1204,6 +1204,42 @@ void *__symbol_get(const char *symbol)
>  }
>  EXPORT_SYMBOL_GPL(__symbol_get);
>
> +/*
> + * Ensure that an exported symbol [global namespace] does not already exist
> + * in the Kernel or in some other modules exported symbol table.
> + */
> +static int verify_export_symbols(struct module *mod)
> +{
> +	const char *name=0;

CodingStyle issue :
	const char *name = 0;

> +	unsigned long i, ret = 0;
> +	struct module *owner;
> +	const unsigned long *crc;
> +
> +	spin_lock_irq(&modlist_lock);
> +	for (i = 0; i < mod->num_syms; i++)
> +		if (unlikely(__find_symbol(mod->syms[i].name, &owner, &crc,1))) {

CodingStyle issue :
	if (unlikely(__find_symbol(mod->syms[i].name, &owner, &crc, 1))) {

> +			name = mod->syms[i].name;
> +			ret = -ENOEXEC;
> +			goto dup;
> +		}
> +	
> +	for (i = 0; i < mod->num_gpl_syms; i++)
> +		if (unlikely(__find_symbol(mod->gpl_syms[i].name, &owner, &crc,1))) {

CodingStyle issue :
	if (unlikely(__find_symbol(mod->gpl_syms[i].name, &owner, &crc, 1))) {

> +			name = mod->gpl_syms[i].name;
> +			ret = -ENOEXEC;
> +			goto dup;
> +		}
> +
> +dup:
> +	spin_unlock_irq(&modlist_lock);
> +	
> +	if (ret)
> +		printk("%s: exports duplicate symbol %s (owned by %s)\n",

I still think this should be printk(KERN_ERROR ...) and not just a
warning, since the loading of the module will fail completely. Others
may disagree ofcourse, but that's my oppinion.


> +			mod->name, name, module_name(owner));
> +
> +	return ret;
> +}
> +
>  /* Change all symbols so that sh_value encodes the pointer directly. */
>  static int simplify_symbols(Elf_Shdr *sechdrs,
>  			    unsigned int symindex,
> @@ -1767,6 +1804,12 @@ static struct module *load_module(void _
>  			goto cleanup;
>  	}
>
> +        /* Find duplicate symbols */
> +	err = verify_export_symbols(mod);
> +
> +	if (err < 0)
> +		goto cleanup;
> +
>    	/* Set up and sort exception table */
>  	mod->num_exentries = sechdrs[exindex].sh_size / sizeof(*mod->extable);
>  	mod->extable = extable = (void *)sechdrs[exindex].sh_addr;
>

A few general things:

I still worry a bit about the spinlock hold time, especially since you
are doing two linear searches through what could potentially be a
*lot* of symbols.. It may not be a problem (do you have any time
measurements?), but it still seems to me that using a lock type that
allows you to sleep + a call to schedule() would be a good thing for
those loops.

Also, what about the softlockup watchdog? Do we risk falsly triggering
that?  Would a call to touch_softlockup_watchdog() between the two
loops, or maybe even inside each loop, be a good idea?  again, depends
on how long this all takes.


All in all, looks a lot better to me than the previous version.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

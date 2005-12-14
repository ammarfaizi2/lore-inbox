Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbVLNEK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbVLNEK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 23:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbVLNEK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 23:10:29 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:23160 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030425AbVLNEK2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 23:10:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=abSzHq0BLLou4G+ZweHozwaHH+GudMqfNZRND0Ox9A9zTd8XvkbKHqs6bE6BLq+WcXjMp8rADeYaPYMKsrRRkjGrjNavlRdHOrxS7DuwaNol+spmXEbOZ//XXP0UY3nBlcYdjFCfrJjo7gk50VeoPBJ0KYupD1Nxgg67UFRVADs=
Message-ID: <81083a450512132010t2596046bsf7a36f85df19b89c@mail.gmail.com>
Date: Wed, 14 Dec 2005 09:40:27 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
Cc: Jesper Juhl <jesper.juhl@gmail.com>, anandhkrishnan@yahoo.co.in,
       linux-kernel@vger.kernel.org, rth@redhat.com, akpm@osdl.org,
       Greg KH <greg@kroah.com>, alan@lxorguk.ukuu.org.uk
In-Reply-To: <1134525816.30383.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <1134424878.22036.13.camel@localhost.localdomain>
	 <81083a450512130626x417d86c9w31f300555c99fdb2@mail.gmail.com>
	 <9a8748490512130849o73c14313l166e6dd360f32d70@mail.gmail.com>
	 <1134525816.30383.13.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, Rusty Russell <rusty@rustcorp.com.au> wrote:

>         Patch looks good!  A few nits still:

Have resolved all the nits ( hopefully :) )

> We already do this to resolve (more) symbols, so I don't see it as a
> problem.  However, I believe that lock is redundant here: we need both
> locks to write the list, but either is sufficient for reading, and we
> already hold the sem.

Ya, the lock is redundant here, as we are already inside a semaphore.

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>
Signed-off-by: Anand Krishnan <anandhkrishnan@yahoo.co.in>


--- linux-2.6.15-rc5/kernel/module.c.orig       2005-12-14
09:27:53.000000000 +0530
+++ linux-2.6.15-rc5/kernel/module.c    2005-12-14 09:18:31.000000000 +0530
@@ -1204,6 +1204,39 @@ void *__symbol_get(const char *symbol)
 }
 EXPORT_SYMBOL_GPL(__symbol_get);

+/*
+ * Ensure that an exported symbol [global namespace] does not already exist
+ * in the Kernel or in some other modules exported symbol table.
+ */
+static int verify_export_symbols(struct module *mod)
+{
+       const char *name = NULL;
+       unsigned long i, ret = 0;
+       struct module *owner;
+       const unsigned long *crc;
+
+       for (i = 0; i < mod->num_syms; i++)
+               if (!__find_symbol(mod->syms[i].name, &owner, &crc, 1)) {
+                       name = mod->syms[i].name;
+                       ret = -ENOEXEC;
+                       goto dup;
+               }
+
+       for (i = 0; i < mod->num_gpl_syms; i++)
+               if (!__find_symbol(mod->gpl_syms[i].name, &owner, &crc, 1)) {
+                       name = mod->gpl_syms[i].name;
+                       ret = -ENOEXEC;
+                       goto dup;
+               }
+
+dup:
+       if (ret)
+               printk(KERN_ERR "%s: exports duplicate symbol %s
(owned by %s)\n",
+                       mod->name, name, module_name(owner));
+
+       return ret;
+}
+
 /* Change all symbols so that sh_value encodes the pointer directly. */
 static int simplify_symbols(Elf_Shdr *sechdrs,
                            unsigned int symindex,
@@ -1767,6 +1800,12 @@ static struct module *load_module(void _
                        goto cleanup;
        }

+        /* Find duplicate symbols */
+       err = verify_export_symbols(mod);
+
+       if (err < 0)
+               goto cleanup;
+
        /* Set up and sort exception table */
        mod->num_exentries = sechdrs[exindex].sh_size / sizeof(*mod->extable);
        mod->extable = extable = (void *)sechdrs[exindex].sh_addr;

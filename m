Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVLMO0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVLMO0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVLMO0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:26:10 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:33350 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964914AbVLMO0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:26:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=ZSrrKaSZvauVNzm5kM4+uKIOXIhuSiMwrCjLdioJmQKJ/gXhnxf6jGB8YZZDk/u7P9HvLONU/vvaYtP44+KSvsujJvErN3LBKDlhfHFgyi1qDIlt3762Ty3k7GycrV38ciGGc8wfcS38kVAV4YFEZqIBrxrGB+8y0N5RRewV22Q=
Message-ID: <81083a450512130626x417d86c9w31f300555c99fdb2@mail.gmail.com>
Date: Tue, 13 Dec 2005 19:56:07 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
Cc: anandhkrishnan@yahoo.co.in, linux-kernel@vger.kernel.org, rth@redhat.com,
       akpm@osdl.org, Greg KH <greg@kroah.com>, alan@lxorguk.ukuu.org.uk,
       Jesper Juhl <jesper.juhl@gmail.com>
In-Reply-To: <1134424878.22036.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13700_30228728.1134483967255"
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <1134424878.22036.13.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_13700_30228728.1134483967255
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 12/13/05, Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> How about something like:
>
>         const struct kernel_symbol *sym;
>         unsigned int i;
>         const unsigned long *crc;
>         struct module *owner;
>
>         spin_lock_irq(&modlist_lock);
>         for (i =3D 0; i < mod->num_syms; i++)
>                 if (__find_symbol(mod->syms[i].name, &owner, &crc, 1))
>                         goto dup;
>         for (i =3D 0; i < num->num_gpl_syms; i++)
>                 if (__find_symbol(mod->gpl_syms[i].name,&owner,&crc,1))
>                         goto dup;
>         spin_unlock_irq(&modlist_lock);
>         return 0;
> dup:
>         printk("%s: exports duplicate symbol (owned by %s)\n",
>                 mod->name, module_name(owner));
>         return -ENOEXEC;
> }

Have tried that in the attached patch. However,  mod->syms[i].name
would be valid only after a long relocation for loop has run through.
While this adds a wee bit extra overhead, that overhead is only in the
case where the module does actually export a Duplicate Symbol.

This its a question, whether we do the search before relocation ( A
little messier ) or after ( More straight forward)

Regards
Ashutosh

------=_Part_13700_30228728.1134483967255
Content-Type: text/plain; name=mod13Decpatch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mod13Decpatch.txt"

--- /usr/src/linux-2.6.15-rc5-vanilla/kernel/module.c	2005-12-07 19:32:23.000000000 +0530
+++ /usr/src/linux-2.6.15-rc5/kernel/module.c	2005-12-13 19:44:43.000000000 +0530
@@ -1204,6 +1204,42 @@ void *__symbol_get(const char *symbol)
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
+/*
+ * Ensure that an exported symbol [global namespace] does not already exist
+ * in the Kernel or in some other modules exported symbol table.
+ */
+static int verify_export_symbols(struct module *mod)
+{
+	const char *name=0;
+	unsigned long i, ret = 0;
+	struct module *owner;
+	const unsigned long *crc;
+        
+	spin_lock_irq(&modlist_lock);
+	for (i = 0; i < mod->num_syms; i++)
+		if (unlikely(__find_symbol(mod->syms[i].name, &owner, &crc,1))) {
+			name = mod->syms[i].name;
+			ret = -ENOEXEC;
+			goto dup;
+		}
+	
+	for (i = 0; i < mod->num_gpl_syms; i++)
+		if (unlikely(__find_symbol(mod->gpl_syms[i].name, &owner, &crc,1))) {
+			name = mod->gpl_syms[i].name;
+			ret = -ENOEXEC;
+			goto dup;
+		}
+
+dup:
+	spin_unlock_irq(&modlist_lock);
+	
+	if (ret)
+		printk("%s: exports duplicate symbol %s (owned by %s)\n", 
+			mod->name, name, module_name(owner));
+
+	return ret;
+}
+
 /* Change all symbols so that sh_value encodes the pointer directly. */
 static int simplify_symbols(Elf_Shdr *sechdrs,
 			    unsigned int symindex,
@@ -1767,6 +1804,12 @@ static struct module *load_module(void _
 			goto cleanup;
 	}
 
+        /* Find duplicate symbols */
+	err = verify_export_symbols(mod);
+
+	if (err < 0)
+		goto cleanup;
+
   	/* Set up and sort exception table */
 	mod->num_exentries = sechdrs[exindex].sh_size / sizeof(*mod->extable);
 	mod->extable = extable = (void *)sechdrs[exindex].sh_addr;


------=_Part_13700_30228728.1134483967255--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVLPCIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVLPCIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 21:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVLPCII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 21:08:08 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:47646 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751284AbVLPCIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 21:08:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=o22RZ5XShZON/ePhCboWylmHFHYUOfaUbqUWGC3aF+gQoLqXr8Rs9q5TAiyL2S3tVijd+sq9SjiaXqo2oc5uoNEyXelZqGlWCiM6gAsLmXFxmroq9+rvSZc1RGekHPzuGt7hcksJrK11HBy+QdWwHRVOoWes1wU5MVYqHpvdteE=
Message-ID: <81083a450512142145u56075dfch16ae708f34d93e7c@mail.gmail.com>
Date: Thu, 15 Dec 2005 11:15:40 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
Cc: Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com,
       anandhkrishnan@yahoo.co.in, linux-kernel@vger.kernel.org,
       rth@redhat.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       kaos@ocs.com.au
In-Reply-To: <1134623704.7773.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2205_3853625.1134625540723"
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <1134424878.22036.13.camel@localhost.localdomain>
	 <81083a450512130626x417d86c9w31f300555c99fdb2@mail.gmail.com>
	 <9a8748490512130849o73c14313l166e6dd360f32d70@mail.gmail.com>
	 <1134525816.30383.13.camel@localhost.localdomain>
	 <81083a450512132010t2596046bsf7a36f85df19b89c@mail.gmail.com>
	 <81083a450512132102g77f4a92kc894fcda9e9dc2a6@mail.gmail.com>
	 <20051214204032.57c4c6ae.akpm@osdl.org>
	 <1134623704.7773.34.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2205_3853625.1134625540723
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 12/15/05, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Wed, 2005-12-14 at 20:40 -0800, Andrew Morton wrote:

> +               if (!__find_symbol(mod->syms[i].name, &owner, &crc, 1)) {

if (__find_symbol(mod->syms[i].name, &owner, &crc, 1)) {

>+               if (!__find_symbol(mod->gpl_syms[i].name, &owner, &crc, 1)=
) {

if (__find_symbol(mod->gpl_syms[i].name, &owner, &crc, 1)) {

Oops... I dunno how we missed it

This code is architecture independent.

Changelog -

This patch ensures that an exported symbol  does not already exist in
the kernel or in some other module's exported symbol table. This is
done by checking the symbol tables for the exported symbol at the time
of loading the module. Currently this is done after the relocation of
the symbol.

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>
Signed-off-by: Anand Krishnan <anandhkrishnan@yahoo.co.in>

------=_Part_2205_3853625.1134625540723
Content-Type: text/plain; name=patch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch.txt"

diff -Naurp linux-2.6.15-rc5-vanilla/kernel/module.c linux-2.6.15-rc5/kernel/module.c
--- linux-2.6.15-rc5-vanilla/kernel/module.c	2005-12-14 10:14:08.000000000 +0530
+++ linux-2.6.15-rc5/kernel/module.c	2005-12-15 11:01:17.000000000 +0530
@@ -1204,6 +1204,39 @@ void *__symbol_get(const char *symbol)
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
+/*
+ * Ensure that an exported symbol [global namespace] does not already exist
+ * in the Kernel or in some other modules exported symbol table.
+ */
+static int verify_export_symbols(struct module *mod)
+{
+	const char *name = NULL;
+	unsigned long i, ret = 0;
+	struct module *owner;
+	const unsigned long *crc;
+        
+	for (i = 0; i < mod->num_syms; i++)
+	        if (__find_symbol(mod->syms[i].name, &owner, &crc, 1)) {
+			name = mod->syms[i].name;
+			ret = -ENOEXEC;
+			goto dup;
+		}
+	
+	for (i = 0; i < mod->num_gpl_syms; i++)
+	        if (__find_symbol(mod->gpl_syms[i].name, &owner, &crc, 1)) {
+			name = mod->gpl_syms[i].name;
+			ret = -ENOEXEC;
+			goto dup;
+		}
+
+dup:
+	if (ret)
+		printk(KERN_ERR "%s: exports duplicate symbol %s (owned by %s)\n", 
+			mod->name, name, module_name(owner));
+
+	return ret;
+}
+
 /* Change all symbols so that sh_value encodes the pointer directly. */
 static int simplify_symbols(Elf_Shdr *sechdrs,
 			    unsigned int symindex,
@@ -1767,6 +1800,12 @@ static struct module *load_module(void _
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


------=_Part_2205_3853625.1134625540723--

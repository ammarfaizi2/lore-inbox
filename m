Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbVLLMj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVLLMj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 07:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVLLMj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 07:39:59 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:49913 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750876AbVLLMj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 07:39:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=IZWpLjn5mTtOSg4r8AOmhdvtFS+vdKspqIeWtlNVwiIiG+QWcXUiLwPiROWUUWWrPxaQV2pGmxcvR5ecv7S0jetyWn69w17rnBiKxLWGORW6Jk8a7XpA77PDthvcJxU7PK80x9vQj98uAxPIrhJmJDMXcWLEcgDu/D39NQljq4I=
Message-ID: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
Date: Mon, 12 Dec 2005 18:09:57 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: anandhkrishnan@yahoo.com, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, rth@redhat.com, akpm@osdl.org,
       Greg KH <greg@kroah.com>
Subject: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6792_6055943.1134391197809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_6792_6055943.1134391197809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch is the next logical step after the following two  threads

http://www.uwsg.iu.edu/hypermail/linux/kernel/0511.2/2505.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0511.3/0036.html

When a symbol is exported from the kernel, and say, a module would
export the same symbol, there currently exists no mechanism to prevent
the module from exporting this symbol. The module would still go ahead
and export the symbol, the symbol table would now contain two copies
of the exported symbol, and hell would break loose.

This patch prevents that from happening, by checking the symbol table
before relocation for all occurences of the Exported Symbol. If the
symbol already exists, we branch out with -ENOEXEC. Currently, this
search is sequential.


Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>
Signed-off-by: Anand Krishnan <anandhkrishnan@yahoo.com>

------=_Part_6792_6055943.1134391197809
Content-Type: text/plain; name=mod-patch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mod-patch.txt"

diff -Naurp linux-2.6.15-rc5-vanilla/kernel/module.c linux-2.6.15-rc5-mod/kernel/module.c
--- linux-2.6.15-rc5-vanilla/kernel/module.c	2005-12-07 19:32:23.000000000 +0530
+++ linux-2.6.15-rc5-mod/kernel/module.c	2005-12-12 17:47:28.000000000 +0530
@@ -1204,6 +1204,63 @@ void *__symbol_get(const char *symbol)
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
+/*
+ * Ensure that an exported symbol [global namespace] does not already exist
+ * in the Kernel or in some other modules exported symbol table.
+ */
+static int verify_export_symbols(Elf_Shdr *sechdrs,
+			    const char *strtab,
+			    struct module *mod)
+{
+	struct kernel_symbol *exportsym, *gplsym;
+	unsigned long i,ret=0,value=0;
+	struct module *owner;
+	const unsigned long *crc;
+	unsigned long index=0;
+        
+	spin_lock_irq(&modlist_lock);
+
+	exportsym = (struct kernel_symbol *)mod->syms;
+	gplsym = (struct kernel_symbol *)mod->gpl_syms;
+
+	if (exportsym)
+		for (i = 0; i < mod->num_syms; exportsym++,i++) {
+			index = (unsigned long)(exportsym->name);
+             		if (exportsym->name) {
+				value = __find_symbol(strtab + index, &owner, &crc,1);
+                
+				if (value != 0) 
+					goto duplicate_sym;
+        		}
+		}
+	
+	if (gplsym) 
+		for (i = 0; i < mod->num_gpl_syms; gplsym++,i++) {
+			index = (unsigned long)(gplsym->name);
+             		if (gplsym->name) {
+				value = __find_symbol(strtab + index, &owner, &crc,1);
+                
+				if (value != 0) 
+					goto duplicate_gpl_sym;
+        		}
+		}
+
+	spin_unlock_irq(&modlist_lock);
+	/*Done*/
+        return ret;
+
+duplicate_sym:
+	spin_unlock_irq(&modlist_lock);
+	printk("%s: Duplicate Exported Symbol found in %s\n", 
+			strtab + index, mod->name);
+	return -ENOEXEC;
+duplicate_gpl_sym:
+	spin_unlock_irq(&modlist_lock);
+	printk("%s: Duplicate Exported Symbol found in %s\n", 
+			strtab + index, mod->name);
+	return -ENOEXEC;
+}
+
 /* Change all symbols so that sh_value encodes the pointer directly. */
 static int simplify_symbols(Elf_Shdr *sechdrs,
 			    unsigned int symindex,
@@ -1502,10 +1559,10 @@ static struct module *load_module(void _
 {
 	Elf_Ehdr *hdr;
 	Elf_Shdr *sechdrs;
-	char *secstrings, *args, *modmagic, *strtab = NULL;
+	char *secstrings, *args, *modmagic, *strtab = NULL, *exportstrtab = NULL;
 	unsigned int i, symindex = 0, strindex = 0, setupindex, exindex,
-		exportindex, modindex, obsparmindex, infoindex, gplindex,
-		crcindex, gplcrcindex, versindex, pcpuindex;
+		exportindex, exportstringindex, modindex, obsparmindex, infoindex,
+		gplindex, crcindex, gplcrcindex, versindex, pcpuindex;
 	long arglen;
 	struct module *mod;
 	long err = 0;
@@ -1585,6 +1642,7 @@ static struct module *load_module(void _
 
 	/* Optional sections */
 	exportindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab");
+	exportstringindex = find_sec(hdr,sechdrs, secstrings, "__ksymtab_strings");
 	gplindex = find_sec(hdr, sechdrs, secstrings, "__ksymtab_gpl");
 	crcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab");
 	gplcrcindex = find_sec(hdr, sechdrs, secstrings, "__kcrctab_gpl");
@@ -1736,6 +1794,13 @@ static struct module *load_module(void _
 	if (gplcrcindex)
 		mod->gpl_crcs = (void *)sechdrs[gplcrcindex].sh_addr;
 
+        /* Find duplicate symbols */
+	exportstrtab = (void *)sechdrs[exportstringindex].sh_addr;
+	err = verify_export_symbols(sechdrs, exportstrtab, mod);
+
+	if (err < 0)
+		goto cleanup;
+
 #ifdef CONFIG_MODVERSIONS
 	if ((mod->num_syms && !crcindex) || 
 	    (mod->num_gpl_syms && !gplcrcindex)) {

------=_Part_6792_6055943.1134391197809--

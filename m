Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbUDAFjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 00:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUDAFjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 00:39:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:8889 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262442AbUDAFjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 00:39:12 -0500
Date: Wed, 31 Mar 2004 21:39:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: yusufg@outblaze.com, linux-kernel@vger.kernel.org
Subject: Re: Strange output from exportfs in 2.6.5-rc3-mm1
Message-Id: <20040331213902.147036f3.akpm@osdl.org>
In-Reply-To: <20040331144031.360c2c3f.rddunlap@osdl.org>
References: <20040331030439.GA23306@outblaze.com>
	<20040331144031.360c2c3f.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> On Wed, 31 Mar 2004 11:04:39 +0800 Yusuf Goolamabbas wrote:
> 
>  | In 2.6.5-rc3-mm1, I saw the following via dmesg
>  | 
>  | exportfs: no version for "init_module" found: kernel tainted.
>  | 
>  | I am exporting a few filesystems via NFS but this is the first 2.6.x
>  | kernel in which I have seen the above message
>  | Output of lsmod
>  | 
>  | nfsd                   94344  - 
>  | exportfs                5440  - 
>  | lockd                  59912  - 
>  | sunrpc                134312  - 
>  | e100                   28196  - 
>  | ext3                  116104  - 
>  | jbd                    55416  - 
>  | aic7xxx               164588  - 
>  | sd_mod                 17696  - 
>  | scsi_mod              109200  - 
> 
>  I can't reproduce that with 2.6.5-rc3-mm3 (but there are no
>  changes to exportfs in -mm3).

You probably didn't have modversions enabled?

Rusty sent me this:


From: Rusty Russell <rusty@rustcorp.com.au>

Brian Gerst's patch which moved __this_module out from module.h into the
module post-processing had a side effect.  genksyms didn't see the
undefined symbols for modules without a module_init (or module_exit), and
hence didn't generate a version for them, causing the kernel to be tainted.

The simple solution is to always include the versions for these functions. 
Also includes two cleanups:

1) alloc_symbol is easier to use if it populates ->next for us.

2) add_exported_symbol should set owner to module, not head of module
   list (we don't use this field in entries in that list, fortunately).


---

 25-akpm/scripts/modpost.c |   35 ++++++++++++++++-------------------
 1 files changed, 16 insertions(+), 19 deletions(-)

diff -puN scripts/modpost.c~modversions-fix scripts/modpost.c
--- 25/scripts/modpost.c~modversions-fix	2004-03-31 21:37:47.745773896 -0800
+++ 25-akpm/scripts/modpost.c	2004-03-31 21:37:47.749773288 -0800
@@ -113,12 +113,13 @@ static inline unsigned int tdb_hash(cons
  * the list of unresolved symbols per module */
 
 struct symbol *
-alloc_symbol(const char *name)
+alloc_symbol(const char *name, struct symbol *next)
 {
 	struct symbol *s = NOFAIL(malloc(sizeof(*s) + strlen(name) + 1));
 
 	memset(s, 0, sizeof(*s));
 	strcpy(s->name, name);
+	s->next = next;
 	return s;
 }
 
@@ -128,17 +129,15 @@ void
 new_symbol(const char *name, struct module *module, unsigned int *crc)
 {
 	unsigned int hash;
-	struct symbol *new = alloc_symbol(name);
+	struct symbol *new;
 
+	hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
+	new = symbolhash[hash] = alloc_symbol(name, symbolhash[hash]);
 	new->module = module;
 	if (crc) {
 		new->crc = *crc;
 		new->crc_valid = 1;
 	}
-
-	hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
-	new->next = symbolhash[hash];
-	symbolhash[hash] = new;
 }
 
 #define DOTSYM_PFX "__dot_"
@@ -177,7 +176,7 @@ add_exported_symbol(const char *name, st
 	struct symbol *s = find_symbol(name);
 
 	if (!s) {
-		new_symbol(name, modules, crc);
+		new_symbol(name, module, crc);
 		return;
 	}
 	if (crc) {
@@ -331,7 +330,6 @@ void
 handle_modversions(struct module *mod, struct elf_info *info,
 		   Elf_Sym *sym, const char *symname)
 {
-	struct symbol *s;
 	unsigned int crc;
 
 	switch (sym->st_shndx) {
@@ -368,13 +366,10 @@ handle_modversions(struct module *mod, s
 #endif
 		
 		if (memcmp(symname, MODULE_SYMBOL_PREFIX,
-			   strlen(MODULE_SYMBOL_PREFIX)) == 0) {
-			s = alloc_symbol(symname + 
-					 strlen(MODULE_SYMBOL_PREFIX));
-			/* add to list */
-			s->next = mod->unres;
-			mod->unres = s;
-		}
+			   strlen(MODULE_SYMBOL_PREFIX)) == 0)
+			mod->unres = alloc_symbol(symname +
+						  strlen(MODULE_SYMBOL_PREFIX),
+						  mod->unres);
 		break;
 	default:
 		/* All exported symbols */
@@ -431,10 +426,12 @@ read_symbols(char *modname)
 	 * the automatic versioning doesn't pick it up, but it's really
 	 * important anyhow */
 	if (modversions) {
-		s = alloc_symbol("struct_module");
-		/* add to list */
-		s->next = mod->unres;
-		mod->unres = s;
+		mod->unres = alloc_symbol("struct_module", mod->unres);
+
+		/* Always version init_module and cleanup_module, in
+		 * case module doesn't have its own. */
+		mod->unres = alloc_symbol("init_module", mod->unres);
+		mod->unres = alloc_symbol("cleanup_module", mod->unres);
 	}
 }
 

_


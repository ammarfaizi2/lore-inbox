Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268609AbUJMO7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268609AbUJMO7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUJMO7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:59:43 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:5760 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S268609AbUJMO7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:59:07 -0400
Date: Wed, 13 Oct 2004 16:58:44 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: [PATCH] Weak symbols in modules and versioned symbols
Message-ID: <20041013145844.GA16067@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  is there some reason why to not apply patch below?  Without patch below
I'm getting

vmmon: no version for "sys_ioctl" found: kernel tainted.

when loading vmmon into kernel which exports sys_ioctl (and vmmon uses 
weak import for sys_ioctl because I'm not able to determine sys_ioctl 
availablilty for modules at build time) and no error when loading it 
into the kernel which does not export sys_ioctl to modules.

  With added CRCs it also looks safer to me: I do not want just
random sys_ioctl; I need sys_ioctl with signature 0xABCDEFGH.
						Thanks,
							Petr Vandrovec


diff -urdN linux/scripts/mod/modpost.c linux/scripts/mod/modpost.c
--- linux/scripts/mod/modpost.c	2004-10-11 13:29:03.000000000 +0000
+++ linux/scripts/mod/modpost.c	2004-10-13 14:50:16.000000000 +0000
@@ -102,6 +102,7 @@
 	struct module *module;
 	unsigned int crc;
 	int crc_valid;
+	unsigned int weak:1;
 	char name[0];
 };
 
@@ -124,12 +125,13 @@
  * the list of unresolved symbols per module */
 
 struct symbol *
-alloc_symbol(const char *name, struct symbol *next)
+alloc_symbol(const char *name, unsigned int weak, struct symbol *next)
 {
 	struct symbol *s = NOFAIL(malloc(sizeof(*s) + strlen(name) + 1));
 
 	memset(s, 0, sizeof(*s));
 	strcpy(s->name, name);
+	s->weak = weak;
 	s->next = next;
 	return s;
 }
@@ -143,7 +145,7 @@
 	struct symbol *new;
 
 	hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
-	new = symbolhash[hash] = alloc_symbol(name, symbolhash[hash]);
+	new = symbolhash[hash] = alloc_symbol(name, 0, symbolhash[hash]);
 	new->module = module;
 	if (crc) {
 		new->crc = *crc;
@@ -347,7 +349,8 @@
 		break;
 	case SHN_UNDEF:
 		/* undefined symbol */
-		if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL)
+		if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL &&
+		    ELF_ST_BIND(sym->st_info) != STB_WEAK)
 			break;
 		/* ignore global offset table */
 		if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
@@ -368,6 +371,7 @@
 			   strlen(MODULE_SYMBOL_PREFIX)) == 0)
 			mod->unres = alloc_symbol(symname +
 						  strlen(MODULE_SYMBOL_PREFIX),
+						  ELF_ST_BIND(sym->st_info) == STB_WEAK,
 						  mod->unres);
 		break;
 	default:
@@ -433,7 +437,7 @@
 	 * the automatic versioning doesn't pick it up, but it's really
 	 * important anyhow */
 	if (modversions)
-		mod->unres = alloc_symbol("struct_module", mod->unres);
+		mod->unres = alloc_symbol("struct_module", 0, mod->unres);
 }
 
 #define SZ 500
@@ -505,7 +509,7 @@
 	for (s = mod->unres; s; s = s->next) {
 		exp = find_symbol(s->name);
 		if (!exp || exp->module == mod) {
-			if (have_vmlinux)
+			if (have_vmlinux && !s->weak)
 				fprintf(stderr, "*** Warning: \"%s\" [%s.ko] "
 				"undefined!\n",	s->name, mod->name);
 			continue;

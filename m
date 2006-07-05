Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWGETav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWGETav (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWGETav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:30:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964971AbWGETau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:30:50 -0400
Date: Wed, 5 Jul 2006 12:34:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NULL terminate over-long /proc/kallsyms symbols
Message-Id: <20060705123424.2d7d70a7.akpm@osdl.org>
In-Reply-To: <200607051859.41638.agruen@suse.de>
References: <200607051859.41638.agruen@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> wrote:
>
> Got a customer bug report (https://bugzilla.novell.com/190296)
> about kernel symbols longer than 127 characters which end up in
> a string buffer that is not NULL terminated, leading to garbage 
> in /proc/kallsyms. Using strlcpy prevents this from happening,
> even though such symbols still won't come out right.
> 
> A better fix would be to not use a fixed-size buffer, but it's
> probably not worth the trouble. (Modversion'ed symbols even have
> a length limit of 60.)
> 
> (This patch has been ested on a 2.6.16 kernel.)
> 
> Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
> 
> Index: linux-2.6.17/kernel/module.c
> ===================================================================
> --- linux-2.6.17.orig/kernel/module.c
> +++ linux-2.6.17/kernel/module.c
> @@ -1935,7 +1935,7 @@ struct module *module_get_kallsym(unsign
>  		if (symnum < mod->num_symtab) {
>  			*value = mod->symtab[symnum].st_value;
>  			*type = mod->symtab[symnum].st_info;
> -			strncpy(namebuf,
> +			strlcpy(namebuf,
>  				mod->strtab + mod->symtab[symnum].st_name,
>  				127);
>  			mutex_unlock(&module_mutex);

Yeah, that assume-the-caller-gave-us-a-128-byte-buffer is a bit rude.  How
about this?

 include/linux/module.h |    6 ++----
 kernel/kallsyms.c      |    4 ++--
 kernel/module.c        |   11 ++++-------
 3 files changed, 8 insertions(+), 13 deletions(-)

diff -puN kernel/module.c~null-terminate-over-long-proc-kallsyms-symbols kernel/module.c
--- a/kernel/module.c~null-terminate-over-long-proc-kallsyms-symbols
+++ a/kernel/module.c
@@ -2019,10 +2019,8 @@ const char *module_address_lookup(unsign
 	return NULL;
 }
 
-struct module *module_get_kallsym(unsigned int symnum,
-				  unsigned long *value,
-				  char *type,
-				  char namebuf[128])
+struct module *module_get_kallsym(unsigned int symnum, unsigned long *value,
+				char *type, char *name, size_t namelen)
 {
 	struct module *mod;
 
@@ -2031,9 +2029,8 @@ struct module *module_get_kallsym(unsign
 		if (symnum < mod->num_symtab) {
 			*value = mod->symtab[symnum].st_value;
 			*type = mod->symtab[symnum].st_info;
-			strncpy(namebuf,
-				mod->strtab + mod->symtab[symnum].st_name,
-				127);
+			strlcpy(name, mod->strtab + mod->symtab[symnum].st_name,
+				namelen);
 			mutex_unlock(&module_mutex);
 			return mod;
 		}
diff -puN include/linux/module.h~null-terminate-over-long-proc-kallsyms-symbols include/linux/module.h
--- a/include/linux/module.h~null-terminate-over-long-proc-kallsyms-symbols
+++ a/include/linux/module.h
@@ -362,10 +362,8 @@ int is_module_address(unsigned long addr
 
 /* Returns module and fills in value, defined and namebuf, or NULL if
    symnum out of range. */
-struct module *module_get_kallsym(unsigned int symnum,
-				  unsigned long *value,
-				  char *type,
-				  char namebuf[128]);
+struct module *module_get_kallsym(unsigned int symnum, unsigned long *value,
+				char *type, char *name, size_t namelen);
 
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
diff -puN kernel/kallsyms.c~null-terminate-over-long-proc-kallsyms-symbols kernel/kallsyms.c
--- a/kernel/kallsyms.c~null-terminate-over-long-proc-kallsyms-symbols
+++ a/kernel/kallsyms.c
@@ -275,8 +275,8 @@ static void upcase_if_global(struct kall
 static int get_ksymbol_mod(struct kallsym_iter *iter)
 {
 	iter->owner = module_get_kallsym(iter->pos - kallsyms_num_syms,
-					 &iter->value,
-					 &iter->type, iter->name);
+					 &iter->value, &iter->type,
+					 iter->name, sizeof(iter->name));
 	if (iter->owner == NULL)
 		return 0;
 
_


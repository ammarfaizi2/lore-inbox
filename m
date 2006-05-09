Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWEIU4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWEIU4e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWEIU4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:56:33 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:18081 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750715AbWEIU4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:56:33 -0400
Subject: Re: [PATCH] Check for license compliance at build time
From: Ram Pai <linuxram@us.ibm.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Greg KH <greg@kroah.com>, Jan Beulich <jbeulich@novell.com>,
       sam@ravnborg.org, linux-kernel@vger.kernel.org
In-Reply-To: <200605091931.49216.agruen@suse.de>
References: <445F0B6F.76E4.0078.0@novell.com>
	 <20060509042500.GA4226@kroah.com> <1147154238.7203.62.camel@localhost>
	 <200605091931.49216.agruen@suse.de>
Content-Type: text/plain
Organization: IBM 
Date: Tue, 09 May 2006 13:55:58 -0700
Message-Id: <1147208158.7203.107.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 19:31 +0200, Andreas Gruenbacher wrote:
> This patch on to of Ram Pai's modpost.diff patch at 
> http://sudhaa.com/~ram/misc/kernelpatch implements license compliance testing 
> in modpost. This prevents kbuild from producing modules that won't load.

Yes, I like this patch. Its a early warning system for a module having
no chance of getting inserted into the kernel.

Sam : do you want all these patches submitted togather? 

RP


> 
> Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
> 
> Index: linux-2.6.16/include/linux/license.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6.16/include/linux/license.h
> @@ -0,0 +1,14 @@
> +#ifndef __LICENSE_H
> +#define __LICENSE_H
> +
> +static inline int license_is_gpl_compatible(const char *license)
> +{
> +	return (strcmp(license, "GPL") == 0
> +		|| strcmp(license, "GPL v2") == 0
> +		|| strcmp(license, "GPL and additional rights") == 0
> +		|| strcmp(license, "Dual BSD/GPL") == 0
> +		|| strcmp(license, "Dual MIT/GPL") == 0
> +		|| strcmp(license, "Dual MPL/GPL") == 0);
> +}
> +
> +#endif
> Index: linux-2.6.16/kernel/module.c
> ===================================================================
> --- linux-2.6.16.orig/kernel/module.c
> +++ linux-2.6.16/kernel/module.c
> @@ -43,6 +43,7 @@
>  #include <asm/uaccess.h>
>  #include <asm/semaphore.h>
>  #include <asm/cacheflush.h>
> +#include <linux/license.h>
>  
>  #if 0
>  #define DEBUGP printk
> @@ -1248,16 +1249,6 @@ static void layout_sections(struct modul
>  	}
>  }
>  
> -static inline int license_is_gpl_compatible(const char *license)
> -{
> -	return (strcmp(license, "GPL") == 0
> -		|| strcmp(license, "GPL v2") == 0
> -		|| strcmp(license, "GPL and additional rights") == 0
> -		|| strcmp(license, "Dual BSD/GPL") == 0
> -		|| strcmp(license, "Dual MIT/GPL") == 0
> -		|| strcmp(license, "Dual MPL/GPL") == 0);
> -}
> -
>  static void set_license(struct module *mod, const char *license)
>  {
>  	if (!license)
> Index: linux-2.6.16/scripts/mod/modpost.c
> ===================================================================
> --- linux-2.6.16.orig/scripts/mod/modpost.c
> +++ linux-2.6.16/scripts/mod/modpost.c
> @@ -13,6 +13,7 @@
>  
>  #include <ctype.h>
>  #include "modpost.h"
> +#include "../../include/linux/license.h"
>  
>  /* Are we using CONFIG_MODVERSIONS? */
>  int modversions = 0;
> @@ -101,6 +102,7 @@ static struct module *new_module(char *m
>  
>  	/* add to list */
>  	mod->name = p;
> +	mod->gpl_compatible = -1;
>  	mod->next = modules;
>  	modules = mod;
>  
> @@ -454,13 +456,18 @@ static char *next_string(char *string, u
>  	return string;
>  }
>  
> -static char *get_modinfo(void *modinfo, unsigned long modinfo_len,
> -			 const char *tag)
> +static char *get_next_modinfo(void *modinfo, unsigned long modinfo_len,
> +			      const char *tag, char *info)
>  {
>  	char *p;
>  	unsigned int taglen = strlen(tag);
>  	unsigned long size = modinfo_len;
>  
> +	if (info) {
> +		size -= info - (char *)modinfo;
> +		modinfo = next_string(info, &size);
> +	}
> +
>  	for (p = modinfo; p; p = next_string(p, &size)) {
>  		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
>  			return p + taglen + 1;
> @@ -468,6 +475,13 @@ static char *get_modinfo(void *modinfo, 
>  	return NULL;
>  }
>  
> +static char *get_modinfo(void *modinfo, unsigned long modinfo_len,
> +			 const char *tag)
> +
> +{
> +	return get_next_modinfo(modinfo, modinfo_len, tag, NULL);
> +}
> +
>  /**
>   * Test if string s ends in string sub
>   * return 0 if match
> @@ -888,6 +902,7 @@ static void read_symbols(char *modname)
>  {
>  	const char *symname;
>  	char *version;
> +	char *license;
>  	struct module *mod;
>  	struct elf_info info = { };
>  	Elf_Sym *sym;
> @@ -903,6 +918,18 @@ static void read_symbols(char *modname)
>  		mod->skip = 1;
>  	}
>  
> +	license = get_modinfo(info.modinfo, info.modinfo_len, "license");
> +	while (license) {
> +		if (license_is_gpl_compatible(license))
> +			mod->gpl_compatible = 1;
> +		else {
> +			mod->gpl_compatible = 0;
> +			break;
> +		}
> +		license = get_next_modinfo(info.modinfo, info.modinfo_len,
> +					   "license", license);
> +	}
> +
>  	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
>  		symname = info.strtab + sym->st_name;
>  
> @@ -959,6 +986,31 @@ void buf_write(struct buffer *buf, const
>  	buf->pos += len;
>  }
>  
> +void check_license(struct module *mod)
> +{
> +	struct symbol *s, *exp;
> +
> +	for (s = mod->unres; s; s = s->next) {
> +		if (mod->gpl_compatible == 1) {
> +			/* GPL-compatible modules may use all symbols */
> +			continue;
> +		}
> +		exp = find_symbol(s->name);
> +		if (!exp || exp->module == mod)
> +			continue;
> +		if (exp->export_type == 1) {
> +			const char *basename = strrchr(mod->name, '/');
> +			if (basename)
> +				basename++;
> +
> +			fatal("modpost: GPL-incompatible module %s uses the "
> +			      "GPL-only symbol %s\n",
> +			      basename ? basename : mod->name,
> +			      exp->name);
> +		}
> +        }
> +}
> +
>  /**
>   * Header for the generated file
>   **/
> @@ -1244,6 +1296,12 @@ int main(int argc, char **argv)
>  	for (mod = modules; mod; mod = mod->next) {
>  		if (mod->skip)
>  			continue;
> +		check_license(mod);
> +	}
> +
> +	for (mod = modules; mod; mod = mod->next) {
> +		if (mod->skip)
> +			continue;
>  
>  		buf.pos = 0;
>  
> Index: linux-2.6.16/scripts/mod/modpost.h
> ===================================================================
> --- linux-2.6.16.orig/scripts/mod/modpost.h
> +++ linux-2.6.16/scripts/mod/modpost.h
> @@ -81,6 +81,7 @@ buf_write(struct buffer *buf, const char
>  struct module {
>  	struct module *next;
>  	const char *name;
> +	int gpl_compatible;
>  	struct symbol *unres;
>  	int seen;
>  	int skip;


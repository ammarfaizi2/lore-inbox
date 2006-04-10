Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWDJPUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWDJPUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 11:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWDJPUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 11:20:05 -0400
Received: from xenotime.net ([66.160.160.81]:24960 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750804AbWDJPUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 11:20:04 -0400
Date: Mon, 10 Apr 2006 08:22:21 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH 0/19] kconfig patches
Message-Id: <20060410082221.8809d3bb.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0604101331030.32445@scrub.home>
References: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
	<20060409235548.52b563a9.akpm@osdl.org>
	<Pine.LNX.4.64.0604101035240.32445@scrub.home>
	<20060410005153.2a5c19e2.akpm@osdl.org>
	<Pine.LNX.4.64.0604101122530.32445@scrub.home>
	<20060410014113.5ba40dd9.akpm@osdl.org>
	<Pine.LNX.4.64.0604101331030.32445@scrub.home>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2006 13:36:16 +0200 (CEST) Roman Zippel wrote:

> Hi,
> 
> On Mon, 10 Apr 2006, Andrew Morton wrote:
> 
> > > Pretty much every other tool removes the old file before or after creating 
> > > the new file. This allows it to work with a hardlinked tree, which 
> > > unfortunately is currently broken for other reasons in kbuild.
> > 
> > OK.  S_ISLNK?  `setenv DONT_BE_IRRITATING 1'?
> 
> An environment variable is a good compromise (I called it 
> KCONFIG_OVERWRITECONFIG). Another alternative is to allow overriding the 
> .config name via KCONFIG_CONFIG, so you shouldn't need a symlink at all 
> anymore.
> Lightly tested patch below.

Please document these environment variables somewhere.
No, not source code.  :)
Thanks.


> > > Could you send me link or a copy of your build tools, which deals with the 
> > > symlink?
> > 
> > Not sure what you mean really.  I use the normal in-tree things, plus the
> > patch in the earlier email.
> 
> What creates/updates the symlink and what does update the file the symlink 
> points to?
> 
> bye, Roman
> 
> ---
> 
>  Makefile                   |    6 +++--
>  scripts/kconfig/confdata.c |   46 ++++++++++++++++++++++++++++-----------------
>  scripts/kconfig/lkc.h      |    2 -
>  3 files changed, 33 insertions(+), 21 deletions(-)
> 
> Index: linux-2.6-git/Makefile
> ===================================================================
> --- linux-2.6-git.orig/Makefile
> +++ linux-2.6-git/Makefile
> @@ -178,6 +178,8 @@ CROSS_COMPILE	?=
>  # Architecture as present in compile.h
>  UTS_MACHINE := $(ARCH)
>  
> +KCONFIG_CONFIG	?= .config
> +
>  # SHELL used by kbuild
>  CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
>  	  else if [ -x /bin/bash ]; then echo /bin/bash; \
> @@ -439,13 +441,13 @@ ifeq ($(dot-config),1)
>  -include include/config/auto.conf
>  
>  # To avoid any implicit rule to kick in, define an empty command
> -.config include/config/auto.conf.cmd: ;
> +$(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
>  
>  # If .config is newer than include/config/auto.conf, someone tinkered
>  # with it and forgot to run make oldconfig.
>  # if auto.conf.cmd is missing then we are probarly in a cleaned tree so
>  # we execute the config step to be sure to catch updated Kconfig files
> -include/config/auto.conf: .config include/config/auto.conf.cmd
> +include/config/auto.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
>  	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
>  
>  else
> Index: linux-2.6-git/scripts/kconfig/confdata.c
> ===================================================================
> --- linux-2.6-git.orig/scripts/kconfig/confdata.c
> +++ linux-2.6-git/scripts/kconfig/confdata.c
> @@ -21,8 +21,6 @@ static void conf_warning(const char *fmt
>  static const char *conf_filename;
>  static int conf_lineno, conf_warnings, conf_unsaved;
>  
> -const char conf_def_filename[] = ".config";
> -
>  const char conf_defname[] = "arch/$ARCH/defconfig";
>  
>  static void conf_warning(const char *fmt, ...)
> @@ -36,6 +34,13 @@ static void conf_warning(const char *fmt
>  	conf_warnings++;
>  }
>  
> +const char *conf_get_configname(void)
> +{
> +	char *name = getenv("KCONFIG_CONFIG");
> +
> +	return name ? name : ".config";
> +}
> +
>  static char *conf_expand_value(const char *in)
>  {
>  	struct symbol *sym;
> @@ -91,7 +96,7 @@ int conf_read_simple(const char *name, i
>  	} else {
>  		struct property *prop;
>  
> -		name = conf_def_filename;
> +		name = conf_get_configname();
>  		in = zconf_fopen(name);
>  		if (in)
>  			goto load;
> @@ -381,7 +386,7 @@ int conf_write(const char *name)
>  		if (!stat(name, &st) && S_ISDIR(st.st_mode)) {
>  			strcpy(dirname, name);
>  			strcat(dirname, "/");
> -			basename = conf_def_filename;
> +			basename = conf_get_configname();
>  		} else if ((slash = strrchr(name, '/'))) {
>  			int size = slash - name + 1;
>  			memcpy(dirname, name, size);
> @@ -389,16 +394,24 @@ int conf_write(const char *name)
>  			if (slash[1])
>  				basename = slash + 1;
>  			else
> -				basename = conf_def_filename;
> +				basename = conf_get_configname();
>  		} else
>  			basename = name;
>  	} else
> -		basename = conf_def_filename;
> +		basename = conf_get_configname();
>  
> -	sprintf(newname, "%s.tmpconfig.%d", dirname, (int)getpid());
> -	out = fopen(newname, "w");
> +	sprintf(newname, "%s%s", dirname, basename);
> +	env = getenv("KCONFIG_OVERWRITECONFIG");
> +	if (!env || !*env) {
> +		sprintf(tmpname, "%s.tmpconfig.%d", dirname, (int)getpid());
> +		out = fopen(tmpname, "w");
> +	} else {
> +		*tmpname = 0;
> +		out = fopen(newname, "w");
> +	}
>  	if (!out)
>  		return 1;
> +
>  	sym = sym_lookup("KERNELVERSION", 0);
>  	sym_calc_value(sym);
>  	time(&now);
> @@ -498,19 +511,18 @@ int conf_write(const char *name)
>  		}
>  	}
>  	fclose(out);
> -	if (!name || basename != conf_def_filename) {
> -		if (!name)
> -			name = conf_def_filename;
> -		sprintf(tmpname, "%s.old", name);
> -		rename(name, tmpname);
> +
> +	if (*tmpname) {
> +		strcat(dirname, name ? name : conf_get_configname());
> +		strcat(dirname, ".old");
> +		rename(newname, dirname);
> +		if (rename(tmpname, newname))
> +			return 1;
>  	}
> -	sprintf(tmpname, "%s%s", dirname, basename);
> -	if (rename(newname, tmpname))
> -		return 1;
>  
>  	printf(_("#\n"
>  		 "# configuration written to %s\n"
> -		 "#\n"), tmpname);
> +		 "#\n"), newname);
>  
>  	sym_change_count = 0;
>  
> Index: linux-2.6-git/scripts/kconfig/lkc.h
> ===================================================================
> --- linux-2.6-git.orig/scripts/kconfig/lkc.h
> +++ linux-2.6-git/scripts/kconfig/lkc.h
> @@ -64,8 +64,6 @@ int zconf_lineno(void);
>  char *zconf_curname(void);
>  
>  /* confdata.c */
> -extern const char conf_def_filename[];
> -
>  char *conf_get_default_confname(void);
>  
>  /* kconfig_load.c */
> -

---
~Randy

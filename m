Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbTIHSTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263442AbTIHSTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:19:40 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:58635 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263440AbTIHSTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:19:36 -0400
Date: Mon, 8 Sep 2003 20:19:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ricky Beam <jfbeam@bluetronic.net>, zippel@linux-m68k.org
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [BK PATCH] build: config vs. everything else
Message-ID: <20030908181929.GA3627@mars.ravnborg.org>
Mail-Followup-To: Ricky Beam <jfbeam@bluetronic.net>,
	zippel@linux-m68k.org,
	Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <Pine.GSO.4.33.0309081241130.13584-200000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0309081241130.13584-200000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricky, I like your patch, but have a few comments.

> The rules for config (and %config) depend on "scripts" which will build
> basically everything in scripts.  However, there are two problems with this.
> First, *config only NEEDS fixdep.
Correct.

> Second, the complete build environment is
> not setup at config time, so the compiler settings are not consistant.  To
> illustrate the point, compare scripts/.empty.o.cmd after a "make config" and
> "make image" (zImage, whatever)
Again correct, which is also why we see modpost being built so often.

A few comments to your patch:
 
> The "bk send" is attached.  Below is the diff.  Excuse the "@/bin/true"...
> It's the fastest way to get make to shutup.
@: is faster, and used by kbuld today.

> +scripts/fixdep:
> +	$(Q)$(MAKE) $(build)=scripts fixdep
Try to avoid special targets when the full name is OK.
No need for the fixdep target in scripts/Makefile

> -include/linux/autoconf.h: scripts/fixdep .config
> -	$(Q)$(MAKE) $(build)=scripts/kconfig silentoldconfig
> +include/linux/autoconf.h: .config
> +	$(Q)$(MAKE) -f $(TOPDIR)/Makefile silentoldconfig

Nice. But notice that TOPDIR is obsolete, use srctree.

> +fixdep: $(obj)/fixdep
> +	@/bin/true
As noted above, this shortcut target is not needed.

>  targets += elfconfig.h
> +
Avoid random white space changes.

> --- 1.9/scripts/kconfig/Makefile	Sun Aug 31 19:13:49 2003
> +++ 1.10/scripts/kconfig/Makefile	Fri Sep  5 22:25:25 2003
> @@ -21,7 +21,7 @@
>  	$< -o arch/$(ARCH)/Kconfig
> 
>  silentoldconfig: $(obj)/conf
> -	$< -s arch/$(ARCH)/Kconfig
> +	$(Q)$< -s arch/$(ARCH)/Kconfig
Unrelated change.

> --- 1.9/scripts/kconfig/conf.c	Fri Jun  6 10:51:38 2003
> +++ 1.10/scripts/kconfig/conf.c	Fri Sep  5 22:25:25 2003
> @@ -532,7 +532,8 @@
>  		}
>  		break;
>  	case ask_silent:
> -		if (stat(".config", &tmpstat)) {
> +		name = ".config";
> +		if (stat(name, &tmpstat)) {
>  			printf("***\n"
>  				"*** You have not yet configured your kernel!\n"
>  				"***\n"
> @@ -541,6 +542,8 @@
>  				"***\n");
>  			exit(1);
>  		}
> +		conf_read(name);
> +		break;

What is the purpose of this change?
If it fixes kconfig behaviour it should go separate to Roman Zippel.

I have modified your the patch according to my cooments:

===== Makefile 1.424 vs edited =====
--- 1.424/Makefile	Mon Sep  1 01:14:39 2003
+++ edited/Makefile	Mon Sep  8 20:09:54 2003
@@ -253,12 +253,14 @@
 
 # Helpers built in scripts/
 
-scripts/docproc scripts/fixdep scripts/split-include : scripts ;
+scripts/docproc scripts/split-include : scripts ;
 
-.PHONY: scripts
+.PHONY: scripts scripts/fixdep
 scripts:
 	$(Q)$(MAKE) $(build)=scripts
 
+scripts/fixdep:
+	$(Q)$(MAKE) $(build)=scripts $@
 
 # To make sure we do not include .config for any of the *config targets
 # catch them early, and hand them over to scripts/kconfig/Makefile
@@ -336,8 +338,8 @@
 
 # If .config is newer than include/linux/autoconf.h, someone tinkered
 # with it and forgot to run make oldconfig
-include/linux/autoconf.h: scripts/fixdep .config
-	$(Q)$(MAKE) $(build)=scripts/kconfig silentoldconfig
+include/linux/autoconf.h: .config
+	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
 
 endif
 


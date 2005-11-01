Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVKARNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVKARNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVKARNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:13:51 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:5059 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751007AbVKARNu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:13:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rtkymz6DZ3Fbfd9X1h7oSx2ZNkq3X8mHZ8zn70tX562ipGWhiLEwi9SdnKF+sh4M4OBvzBEuQf2YN1RhPVdVyBDta8AjwcfDK7JuQXkMsJVOks/SudeEPdbuW6A3dCKhhURI2ayqh9jZA8hPgxOgdGzExMuIW8CH8Uex/XVjmsk=
Message-ID: <29495f1d0511010913l540ce99bkc9488fa21c0a250b@mail.gmail.com>
Date: Tue, 1 Nov 2005 09:13:50 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Yuri Vasilevski <yvasilev@duke.math.cinvestav.mx>
Subject: Re: Patch that allows >=2.6.12 kernel to build on nls free systems
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Daniel Drake <dsd@gentoo.org>
In-Reply-To: <20051026115014.2dbb0bfc@dune.math.cinvestav.mx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051026115014.2dbb0bfc@dune.math.cinvestav.mx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/05, Yuri Vasilevski <yvasilev@duke.math.cinvestav.mx> wrote:
> Hi all,
>
> I made a patch that detects if libintl.h (needed for nls) is present on
> the host system and if it's not, it nls support is disabled by
> providing dummies for the used nls functions.
>
> This way if there is nls support on the host system the *config targets
> will build according to Arnaldo Carvalho de Melo's i18n modifications,
> else it just uses the original English messages.
>
> I have also made a bug report at kernel's bugzilla:
> http://bugzilla.kernel.org/show_bug.cgi?id=5501
> And there is a discussion about this problem in Gentoo's bugzilla:
> http://bugs.gentoo.org/show_bug.cgi?id=99810
>
> diff -Naur linux-2.6.14_rc2.orig/scripts/kconfig/Makefile linux-2.6.14_rc2/scripts/kconfig/Makefile
> --- linux-2.6.14_rc2.orig/scripts/kconfig/Makefile      2005-11-06 04:13:01 +0000
> +++ linux-2.6.14_rc2/scripts/kconfig/Makefile   2005-11-18 03:52:03 +0000
> @@ -116,6 +116,15 @@
>  clean-files    := lkc_defs.h qconf.moc .tmp_qtcheck \
>                    .tmp_gtkcheck zconf.tab.c zconf.tab.h lex.zconf.c
>
> +# Needed for systems without gettext
> +KBUILD_HAVE_NLS := $(shell \
> +     if echo "\#include <libint.h>" | $(HOSTCC) $(HOSTCFLAGS) -E - > /dev/null 2>&1 ; \
> +     then echo yes ; \
> +     else echo no ; fi)
> +ifeq ($(KBUILD_HAVE_NLS),no)
> +HOSTCFLAGS     += -DKBUILD_NO_NLS
> +endif
> +
>  # generated files seem to need this to find local include files
>  HOSTCFLAGS_lex.zconf.o := -I$(src)
>  HOSTCFLAGS_zconf.tab.o := -I$(src)
> diff -Naur linux-2.6.14_rc2.orig/scripts/kconfig/lkc.h linux-2.6.14_rc2/scripts/kconfig/lkc.h
> --- linux-2.6.14_rc2.orig/scripts/kconfig/lkc.h 2005-11-06 04:13:01 +0000
> +++ linux-2.6.14_rc2/scripts/kconfig/lkc.h      2005-11-18 02:23:07 +0000
> @@ -8,7 +8,13 @@
>
>  #include "expr.h"
>
> -#include <libintl.h>
> +#ifndef KBUILD_NO_NLS
> +# include <libintl.h>
> +#else
> +# define gettext(Msgid) ((const char *) (Msgid))
> +# define textdomain(Domainname) ((const char *) (Domainname))
> +# define bindtextdomain(Domainname, Dirname) ((const char *) (Dirname))
> +#endif
>
>  #ifdef __cplusplus
>  extern "C" {
>

Looks like this patch was merged:

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=70a6a0cb92f24fd6bbe2e75299168909f735676a

I noticed with builds of -git3/-git4, I get the following complaints
from oldconfig:

scripts/kconfig/mconf.c: In function `main':
scripts/kconfig/mconf.c:1048: warning: statement with no effect
scripts/kconfig/mconf.c:1049: warning: statement with no effect

Not a big deal, just more complaints to have to see during the build
process (with CONFIG_NLS=y) :)

Thanks,
Nish

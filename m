Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbWBNPvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWBNPvi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWBNPvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:51:38 -0500
Received: from mail16.bluewin.ch ([195.186.19.63]:35303 "EHLO
	mail16.bluewin.ch") by vger.kernel.org with ESMTP id S1161094AbWBNPvi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:51:38 -0500
Date: Tue, 14 Feb 2006 10:50:57 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove duplicate #includes
Message-ID: <20060214155057.GE14516@krypton>
References: <20060213093959.GA10496@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213093959.GA10496@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.11
From: apgo@patchbomb.org (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 10:39:59AM +0100, Herbert Poetzl wrote:
> 
> Hi Andrew! Folks!
> 
> recently I stumbled over a few files which #include the 
> same .h file twice -- sometimes even in the immediately
> following line. so I thought I'd look into that to reduce 
> the amount of duplicate includes in the kernel ...
> 
> I first searched for 'potential' duplicates with the
> following command sequence ...
> 
>   find . -type f -name '*.[hcS]' -exec gawk '/^#include/ { X[$2]++ } END { for (n in X) if (X[n]>1) printf("%s: %s[%d]\n",FILENAME,n,X[n]); }' {} \;

scripts/checkincludes.pl ;-)

> .. then, I inspected each of the results, and if it was
> valid, I removed every but the first occurence (of course 
> only after detailed inspection)
>
> I will do a bunch of further tests with this patch to
> make absolutely 100% sure that there are no bad changes.
> the patch contains the obvious cases first, and the not
> so obvious ones at the end.

Please, please, split this into smaller, readable chunks. As is, it is
bound to break patches queued up in -mm and other subsystem trees. You
don't want the angry mob coming after you, really.

[snip]

> --- linux-2.6.16-rc2/arch/parisc/kernel/signal.c	2006-01-03 17:29:13 +0100
> +++ linux-2.6.16-rc2-mpf/arch/parisc/kernel/signal.c	2006-02-13 01:24:26 +0100
> @@ -24,7 +24,6 @@
>  #include <linux/ptrace.h>
>  #include <linux/unistd.h>
>  #include <linux/stddef.h>
> -#include <linux/compat.h>

Second occurrence is the redundant one here; include/linux/compat.h
already wrapped around #ifdef CONFIG_COMPAT ..

>  #include <linux/elf.h>
>  #include <linux/personality.h>
>  #include <asm/ucontext.h>

[snip]

> diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/platforms/powermac/setup.c linux-2.6.16-rc2-mpf/arch/powerpc/platforms/powermac/setup.c
> --- linux-2.6.16-rc2/arch/powerpc/platforms/powermac/setup.c	2006-02-07 11:52:12 +0100
> +++ linux-2.6.16-rc2-mpf/arch/powerpc/platforms/powermac/setup.c	2006-02-13 01:35:28 +0100
> @@ -76,7 +76,6 @@
>  #include <asm/smu.h>
>  #include <asm/pmc.h>
>  #include <asm/lmb.h>
> -#include <asm/udbg.h>

You broke CONFIG_PPC_PMAC when CONFIG_PPC64=n

>  #include "pmac.h"
>  

[snip]

> diff -NurpP --minimal linux-2.6.16-rc2/drivers/char/drm/drm.h linux-2.6.16-rc2-mpf/drivers/char/drm/drm.h
> --- linux-2.6.16-rc2/drivers/char/drm/drm.h	2006-02-07 11:52:24 +0100
> +++ linux-2.6.16-rc2-mpf/drivers/char/drm/drm.h	2006-02-13 01:48:55 +0100
> @@ -51,11 +51,9 @@
>  #if defined(__FreeBSD__) && defined(IN_MODULE)
>  /* Prevent name collision when including sys/ioccom.h */
>  #undef ioctl
> -#include <sys/ioccom.h>
>  #define ioctl(a,b,c)		xf86ioctl(a,b,c)
> -#else
> -#include <sys/ioccom.h>
>  #endif				/* __FreeBSD__ && xf86ioctl */
> +#include <sys/ioccom.h>

This changes semantics, like Bastian pointed out..

>  #define DRM_IOCTL_NR(n)		((n) & 0xff)
>  #define DRM_IOC_VOID		IOC_VOID
>  #define DRM_IOC_READ		IOC_OUT

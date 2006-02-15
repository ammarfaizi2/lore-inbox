Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWBOJsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWBOJsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 04:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWBOJsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 04:48:22 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:21906 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751051AbWBOJsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 04:48:21 -0500
Date: Wed, 15 Feb 2006 10:48:20 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Arthur Othieno <apgo@patchbomb.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove duplicate #includes
Message-ID: <20060215094820.GB28677@MAIL.13thfloor.at>
Mail-Followup-To: Arthur Othieno <apgo@patchbomb.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060213093959.GA10496@MAIL.13thfloor.at> <20060214155057.GE14516@krypton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214155057.GE14516@krypton>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 10:50:57AM -0500, Arthur Othieno wrote:
> On Mon, Feb 13, 2006 at 10:39:59AM +0100, Herbert Poetzl wrote:
> > 
> > Hi Andrew! Folks!
> > 
> > recently I stumbled over a few files which #include the 
> > same .h file twice -- sometimes even in the immediately
> > following line. so I thought I'd look into that to reduce 
> > the amount of duplicate includes in the kernel ...
> > 
> > I first searched for 'potential' duplicates with the
> > following command sequence ...
> > 
> >   find . -type f -name '*.[hcS]' -exec gawk '/^#include/ { X[$2]++ } END { for (n in X) if (X[n]>1) printf("%s: %s[%d]\n",FILENAME,n,X[n]); }' {} \;
> 
> scripts/checkincludes.pl ;-)

darn! I knew it was there, but I could not remember
where I saw it! thanks for the hint with the cluebat

> > .. then, I inspected each of the results, and if it was
> > valid, I removed every but the first occurence (of course 
> > only after detailed inspection)
> >
> > I will do a bunch of further tests with this patch to
> > make absolutely 100% sure that there are no bad changes.
> > the patch contains the obvious cases first, and the not
> > so obvious ones at the end.
> 
> Please, please, split this into smaller, readable chunks. As is, it is
> bound to break patches queued up in -mm and other subsystem trees. You
> don't want the angry mob coming after you, really.

okay, maybe a good idea .. for now it was just to
get an idea how many worms are in this can :)

thanks,
Herbert

> [snip]
> 
> > --- linux-2.6.16-rc2/arch/parisc/kernel/signal.c	2006-01-03 17:29:13 +0100
> > +++ linux-2.6.16-rc2-mpf/arch/parisc/kernel/signal.c	2006-02-13 01:24:26 +0100
> > @@ -24,7 +24,6 @@
> >  #include <linux/ptrace.h>
> >  #include <linux/unistd.h>
> >  #include <linux/stddef.h>
> > -#include <linux/compat.h>
> 
> Second occurrence is the redundant one here; include/linux/compat.h
> already wrapped around #ifdef CONFIG_COMPAT ..
> 
> >  #include <linux/elf.h>
> >  #include <linux/personality.h>
> >  #include <asm/ucontext.h>
> 
> [snip]
> 
> > diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/platforms/powermac/setup.c linux-2.6.16-rc2-mpf/arch/powerpc/platforms/powermac/setup.c
> > --- linux-2.6.16-rc2/arch/powerpc/platforms/powermac/setup.c	2006-02-07 11:52:12 +0100
> > +++ linux-2.6.16-rc2-mpf/arch/powerpc/platforms/powermac/setup.c	2006-02-13 01:35:28 +0100
> > @@ -76,7 +76,6 @@
> >  #include <asm/smu.h>
> >  #include <asm/pmc.h>
> >  #include <asm/lmb.h>
> > -#include <asm/udbg.h>
> 
> You broke CONFIG_PPC_PMAC when CONFIG_PPC64=n
> 
> >  #include "pmac.h"
> >  
> 
> [snip]
> 
> > diff -NurpP --minimal linux-2.6.16-rc2/drivers/char/drm/drm.h linux-2.6.16-rc2-mpf/drivers/char/drm/drm.h
> > --- linux-2.6.16-rc2/drivers/char/drm/drm.h	2006-02-07 11:52:24 +0100
> > +++ linux-2.6.16-rc2-mpf/drivers/char/drm/drm.h	2006-02-13 01:48:55 +0100
> > @@ -51,11 +51,9 @@
> >  #if defined(__FreeBSD__) && defined(IN_MODULE)
> >  /* Prevent name collision when including sys/ioccom.h */
> >  #undef ioctl
> > -#include <sys/ioccom.h>
> >  #define ioctl(a,b,c)		xf86ioctl(a,b,c)
> > -#else
> > -#include <sys/ioccom.h>
> >  #endif				/* __FreeBSD__ && xf86ioctl */
> > +#include <sys/ioccom.h>
> 
> This changes semantics, like Bastian pointed out..
> 
> >  #define DRM_IOCTL_NR(n)		((n) & 0xff)
> >  #define DRM_IOC_VOID		IOC_VOID
> >  #define DRM_IOC_READ		IOC_OUT

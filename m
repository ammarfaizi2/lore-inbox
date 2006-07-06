Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbWGFBBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWGFBBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 21:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWGFBBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 21:01:20 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:27867 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965108AbWGFBBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 21:01:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tm3BuAMBiUEZ7FgNs9+DYfXqNKzf8EwS/RJreiJUSYEGl1jV1urFMDNt0n7L6WoWAJWoXTgkHJDygw7Uj3e/ErLJCUGwa/VGfAkzSe+TWEYu03rIntcMmE1KdiQvtp/OwIW9VAMaWqnFQ2BmD0WtG1WEw0KNoLKg31xkmOv8AnE=
Message-ID: <44AC60D0.7030107@gmail.com>
Date: Thu, 06 Jul 2006 09:01:04 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: davem@davemloft.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
References: <200607060020.k660Krv1009111@harpo.it.uu.se>
In-Reply-To: <200607060020.k660Krv1009111@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> To: davem@davemloft.net
> Subject: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
> Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
> 
> In recent sparc64 kernels, starting a 32-bit mode X server on
> a machine with a Mach64 framebuffer (CONFIG_FB_ATY_CT=y) like
> an Ultra5, results in the kernel complaining:
> 
> ioctl32(X:1977): Unknown cmd fd(6) cmd(40584606){00} arg(ef8dd6d8) on /dev/fb0
> ioctl32(X:1977): Unknown cmd fd(6) cmd(40184600){00} arg(ef8dd6e0) on /dev/fb0
> 
> That's FBIOGTYPE and FBIOGATTR. These errors occur because
> kernel 2.6.15-rc2 changed the way sparc64 handles SPARC-specific
> framebuffer ioctls from 32-bit processes: before 2.6.15-rc2
> arch/sparc64/kernel/ioctl32.c handled them for all devices,
> but 2.6.15-rc2 dropped that support and changed SPARC-only
> framebuffer drivers like ffb.c to set up ->compat_ioctl methods
> pointing to sbusfb_compat_ioctl in drivers/video/sbuslib.c.
> However, drivers for framebuffers like the Mach64 that can exist
> on both SPARCs and non-SPARCs were not adjusted, so in sparc64
> kernels SPARC-specific framebuffer ioctls on Mach64 devices are
> no longer accepted from 32-bit mode processes. Hence the errors.
> 
> The fix is to make atyfb_base.c set up a ->compat_ioctl pointing
> to sbusfb_compat_ioctl when running in a sparc64 kernel with
> compatibility for sparc32 user-space, and to compile and link
> sbuslib.o with the frambuffer driver.
> 
> A complication is that sbuslib.c doesn't compile on non-SPARC
> machines, so we must be careful to only enable it in the case
> described above. That's why the patch puts an ugly "if" statement
> in the Makefile.

Why not something like this?

1. In Kconfig

config FB_SBUSLIB
tristate
default n

Then all the sbus drivers will have this:

select FB_SBUSLIB

and atyfb will have this

select FB_SBUSLIB if SPARC64 && COMPAT

2. In Makefile
obj-$(CONFIG_FB_SBUSLIB)  += sbuslib.o

3. In sbuslib.h

#ifdef CONFIG_COMPAT
int sbusfb_compat_ioctl(...);
#else
#define sbusfb_compat_ioctl NULL;
#endif

This way, we can also eliminate all the #ifdef CONFIG_COMPAT in all the
cg* drivers and atyfb.

Tony

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbUAABrB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 20:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUAABrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 20:47:01 -0500
Received: from waste.org ([209.173.204.2]:37577 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265309AbUAABq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 20:46:58 -0500
Date: Wed, 31 Dec 2003 19:46:55 -0600
From: Matt Mackall <mpm@selenic.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.6.0-tiny1 tree for small systems
Message-ID: <20040101014655.GD18208@waste.org>
References: <20031227215606.GO18208@waste.org> <20031228103500.GA29298@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228103500.GA29298@alpha.home.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 11:35:00AM +0100, Willy Tarreau wrote:
> On Sat, Dec 27, 2003 at 03:56:06PM -0600, Matt Mackall wrote:
> > This is the second release of the -tiny kernel tree. The aim of this
> > tree is to collect patches that reduce kernel disk and memory
> > footprint as well as tools for working on small systems. Target users
> > are things like embedded systems, small or legacy desktop folks, and
> > handhelds.
> 
> Hi Matt,
> 
> This looks very interesting. I could produce a small "bloated" kernel
> which I use for kexec and remote recovery on a VIA C3-based system :
> 
>    text    data     bss     dec     hex filename
> 1328734  118955   52016 1499705  16e239 vmlinux
> 
> This was with gcc-3.3.1 which is more efficient than its predecessors
> on -Os.
> 
> I changed -march=c3 to -march=i386, which generally gives me better
> numbers :
> 
>    text    data     bss     dec     hex filename
> 1287578  118955   52016 1458549  164175 vmlinux
> 
> => this is 40 kB saved. I simply changed this :
> 
> +++ ./arch/i386/Makefile	Sun Dec 28 11:16:10 2003
> @@ -44,7 +44,7 @@
>  cflags-$(CONFIG_MWINCHIPC6)	+= $(call check_gcc,-march=winchip-c6,-march=i586)
>  cflags-$(CONFIG_MWINCHIP2)	+= $(call check_gcc,-march=winchip2,-march=i586)
>  cflags-$(CONFIG_MWINCHIP3D)	+= $(call check_gcc,-march=winchip2,-march=i586)
> -cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
> +cflags-$(CONFIG_MCYRIXIII)	+= -march=i386 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
>  cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)
>  
>  CFLAGS += $(cflags-y)
> 
> 
> So it might be interesting to have an option to drop back to the smallest
> common arch during compilation. Note that this is not the same as choosing
> i386 as the target system, since this kernel still has C3 features. Perhaps
> the simplest and most portable way would be to create a new config entry
> which would override default cflags ?

Ok, I added the ability to override the arch-default CFLAGS, but sadly
I'm unable to reproduce your space savings here with gcc 3.3.2. The
default -march=i586 seems to produce the smallest code for me.

 tiny-mpm/arch/i386/Makefile |    4 ++++
 tiny-mpm/init/Kconfig       |   14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff -puN arch/i386/Makefile~tiny-cflags arch/i386/Makefile
--- tiny/arch/i386/Makefile~tiny-cflags	2003-12-31 19:02:54.000000000 -0600
+++ tiny-mpm/arch/i386/Makefile	2003-12-31 19:41:14.000000000 -0600
@@ -26,6 +26,9 @@ CFLAGS += $(call check_gcc,-mpreferred-s
 
 align := $(subst -functions=0,,$(call check_gcc,-falign-functions=0,-malign-functions=0))
 
+ifdef CONFIG_TINY_CFLAGS
+cflags-y += $(CONFIG_TINY_CFLAGS_VAL)
+else
 cflags-$(CONFIG_M386)		+= -march=i386
 cflags-$(CONFIG_M486)		+= -march=i486
 cflags-$(CONFIG_M586)		+= -march=i586
@@ -46,6 +49,7 @@ cflags-$(CONFIG_MWINCHIP2)	+= $(call che
 cflags-$(CONFIG_MWINCHIP3D)	+= $(call check_gcc,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)
+endif
 
 CFLAGS += $(cflags-y)
 
diff -puN init/Kconfig~tiny-cflags init/Kconfig
--- tiny/init/Kconfig~tiny-cflags	2003-12-31 19:02:54.000000000 -0600
+++ tiny-mpm/init/Kconfig	2003-12-31 19:44:42.000000000 -0600
@@ -446,6 +446,20 @@ config OOL_THREADINFO
 	  This simplifies the code for finding information about the current
           thread. Saves about 4k on small kernels.
 
+config TINY_CFLAGS
+	default n
+	bool "Set compiler arch flags for small 386 code" if EMBEDDED
+	help
+	  This allows user to replace the architecture CFLAGS despite the arch
+	  setting in an attempt to build smaller code.
+
+config TINY_CFLAGS_VAL
+	depends TINY_CFLAGS
+	default "-march=i386"
+	string "Arch CFLAGS"
+	help
+	  Enter CFLAGS to override ARCH defaults.
+
 endmenu		# General setup
 
 config SLAB

_

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbTL1KfM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 05:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbTL1KfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 05:35:12 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:41990 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265053AbTL1KfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 05:35:06 -0500
Date: Sun, 28 Dec 2003 11:35:00 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.6.0-tiny1 tree for small systems
Message-ID: <20031228103500.GA29298@alpha.home.local>
References: <20031227215606.GO18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031227215606.GO18208@waste.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 03:56:06PM -0600, Matt Mackall wrote:
> This is the second release of the -tiny kernel tree. The aim of this
> tree is to collect patches that reduce kernel disk and memory
> footprint as well as tools for working on small systems. Target users
> are things like embedded systems, small or legacy desktop folks, and
> handhelds.

Hi Matt,

This looks very interesting. I could produce a small "bloated" kernel
which I use for kexec and remote recovery on a VIA C3-based system :

   text    data     bss     dec     hex filename
1328734  118955   52016 1499705  16e239 vmlinux

This was with gcc-3.3.1 which is more efficient than its predecessors
on -Os.

I changed -march=c3 to -march=i386, which generally gives me better
numbers :

   text    data     bss     dec     hex filename
1287578  118955   52016 1458549  164175 vmlinux

=> this is 40 kB saved. I simply changed this :

--- ./arch/i386/Makefile	Sun Dec 28 10:35:23 2003
+++ ./arch/i386/Makefile	Sun Dec 28 11:16:10 2003
@@ -44,7 +44,7 @@
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call check_gcc,-march=winchip-c6,-march=i586)
 cflags-$(CONFIG_MWINCHIP2)	+= $(call check_gcc,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MWINCHIP3D)	+= $(call check_gcc,-march=winchip2,-march=i586)
-cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
+cflags-$(CONFIG_MCYRIXIII)	+= -march=i386 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)
 
 CFLAGS += $(cflags-y)


So it might be interesting to have an option to drop back to the smallest
common arch during compilation. Note that this is not the same as choosing
i386 as the target system, since this kernel still has C3 features. Perhaps
the simplest and most portable way would be to create a new config entry
which would override default cflags ?

Cheers,
Willy

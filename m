Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSEZIdC>; Sun, 26 May 2002 04:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315860AbSEZIdB>; Sun, 26 May 2002 04:33:01 -0400
Received: from h-64-105-34-58.SNVACAID.covad.net ([64.105.34.58]:994 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315856AbSEZIdB>; Sun, 26 May 2002 04:33:01 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 26 May 2002 01:32:50 -0700
Message-Id: <200205260832.BAA01132@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.18: DRM + cmpxchg issues
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Under linux-2.5.18, several drivers for Direct Render Manager
(drivers/char/drm) call cmpxchg(), which is not defined for many
architectures including base i386 (i.e., if you want a kernel that runs
across the whole x86 processor line).

	2.5.18 also removed the cmpxchg() implementation for alpha that
was buried in drivers/char/drm, which I suspect was an incomplete patch
which was supposed to move the definition to somewhere in include/asm-alpha/.

	Here is the list of the effected DRM drivers;

	gamma.o
	i810.o		-- Pentium III chipset, requires AGP bus support
	i830.o		-- Pentium III chipset, requires AGP bus support
	mga.o		-- requires AGP bus
	r128.o
	radeon.o	-- requires AGP bus
	tdfx.o

	For, i830 and i830, I can define CONFIG_X86_CMPXCHG and use
the optimized cmpxchg(), because I know the code is running on a
Pentium III, regardless of the kernel compilation options.  The question
is what to do with the other drivers.  I guess my choices are:

	   1. Define CONFIG_X86_CMPXCHG in these drivers and have them abort
	      under x86 if a runtime check shows that the processor lacks
	      cmpxchg.  (It looks like 2.5.17 generated code that uesd
	      the cmpxchg without checking the processor type).

	   2. Write a generic cmpxchg routine (or find one in old
	      kernel sources) and use that in everything except i810.o
	      and i830.o.

	   3. Try to rewrite these drivers without cmpxchg.

	Any advice would be appreciated.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

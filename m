Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbTLNEVN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 23:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265340AbTLNEVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 23:21:13 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:2948 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S265338AbTLNEVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 23:21:07 -0500
Date: Sun, 14 Dec 2003 04:20:22 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
Message-ID: <20031214042022.GA21241@mail.shareable.org>
References: <20031213114134.GA9896@skeleton-jack> <20031213222626.GA20153@mail.shareable.org> <Pine.LNX.4.58.0312131740120.14336@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312131740120.14336@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > D-cache incoherence with unsuitably aligned multiple MAP_FIXED
> > mappings is also observed on SH4, SH5, PA-RISC 1.1d.  The kernel may
> > have the same behaviour on those platforms: allowing a mapping that
> > should not be allowed.
> 
> Why?
> 
> If the user asks for it, it's the users own damn fault. Nobody guarantees
> cache coherency to users who require fixed addresses.

I agree, the users asks for it and in rare cases it's even useful.

If that's your view, then several architectures have code in
arch_get_unmapped_base which tests MAP_FIXED - but that function isn't
called in the MAP_FIXED case any more.  The attached patch removes
those branches.  Trivial, but untested.

(It would be nice to be able to query the kernel to learn what mapping
alignment, if any, can be used to avoid aliasing problems though.
Something like "SHMLBA: 16k" or "SHMLBA: none" in /proc/cpuinfo and
whatever other interfaces present CPU info.  On some architectures the
value depends on the CPU model, determined at run time.  On some
architectures, there isn't a value).

-- Jamie

Patch: irq_idle-2.6.0-test4-01jl
Summary: Remove unused MAP_FIXED branches from arch_get_unmapped_area

Several architectures have code in arch_get_unmapped_base which tests
MAP_FIXED - but that function isn't called in the MAP_FIXED case any more.

For example, this code in arch/sparc/kernel/sys_sparc.c is quite typical:

        if (flags & MAP_FIXED) {
                /* We do not accept a shared mapping if it would violate
                 * cache aliasing constraints.
                 */
                if ((flags & MAP_SHARED) && (addr & (SHMLBA - 1)))
                        return -EINVAL;
                return addr;
        }

The function containing that test isn't called with MAP_FIXED these
days, so it's redundant and misleading.  This patch removes those tests
from all the arch_get_unmapped_area functions which have them.


diff -urN --exclude-from=dontdiff orig-2.6.0-test11/arch/mips/kernel/syscall.c mapalign-2.6.0-test11/arch/mips/kernel/syscall.c
--- orig-2.6.0-test11/arch/mips/kernel/syscall.c	2003-09-02 20:49:13.000000000 +0100
+++ mapalign-2.6.0-test11/arch/mips/kernel/syscall.c	2003-12-14 04:08:10.000000000 +0000
@@ -63,16 +63,6 @@
 	struct vm_area_struct * vmm;
 	int do_color_align;
 
-	if (flags & MAP_FIXED) {
-		/*
-		 * We do not accept a shared mapping if it would violate
-		 * cache aliasing constraints.
-		 */
-		if ((flags & MAP_SHARED) && (addr & shm_align_mask))
-			return -EINVAL;
-		return addr;
-	}
-
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 	do_color_align = 0;
diff -urN --exclude-from=dontdiff orig-2.6.0-test11/arch/sh/kernel/sys_sh.c mapalign-2.6.0-test11/arch/sh/kernel/sys_sh.c
--- orig-2.6.0-test11/arch/sh/kernel/sys_sh.c	2003-07-08 21:55:03.000000000 +0100
+++ mapalign-2.6.0-test11/arch/sh/kernel/sys_sh.c	2003-12-14 04:07:20.000000000 +0000
@@ -54,15 +54,6 @@
 {
 	struct vm_area_struct *vma;
 
-	if (flags & MAP_FIXED) {
-		/* We do not accept a shared mapping if it would violate
-		 * cache aliasing constraints.
-		 */
-		if ((flags & MAP_SHARED) && (addr & (SHMLBA - 1)))
-			return -EINVAL;
-		return addr;
-	}
-
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 	if (!addr)
diff -urN --exclude-from=dontdiff orig-2.6.0-test11/arch/sparc/kernel/sys_sparc.c mapalign-2.6.0-test11/arch/sparc/kernel/sys_sparc.c
--- orig-2.6.0-test11/arch/sparc/kernel/sys_sparc.c	2003-08-27 22:55:57.000000000 +0100
+++ mapalign-2.6.0-test11/arch/sparc/kernel/sys_sparc.c	2003-12-14 04:06:33.000000000 +0000
@@ -40,15 +40,6 @@
 {
 	struct vm_area_struct * vmm;
 
-	if (flags & MAP_FIXED) {
-		/* We do not accept a shared mapping if it would violate
-		 * cache aliasing constraints.
-		 */
-		if ((flags & MAP_SHARED) && (addr & (SHMLBA - 1)))
-			return -EINVAL;
-		return addr;
-	}
-
 	/* See asm-sparc/uaccess.h */
 	if (len > TASK_SIZE - PAGE_SIZE)
 		return -ENOMEM;
diff -urN --exclude-from=dontdiff orig-2.6.0-test11/arch/sparc64/kernel/sys_sparc.c mapalign-2.6.0-test11/arch/sparc64/kernel/sys_sparc.c
--- orig-2.6.0-test11/arch/sparc64/kernel/sys_sparc.c	2003-08-27 22:55:57.000000000 +0100
+++ mapalign-2.6.0-test11/arch/sparc64/kernel/sys_sparc.c	2003-12-14 04:06:46.000000000 +0000
@@ -52,15 +52,6 @@
 	unsigned long start_addr;
 	int do_color_align;
 
-	if (flags & MAP_FIXED) {
-		/* We do not accept a shared mapping if it would violate
-		 * cache aliasing constraints.
-		 */
-		if ((flags & MAP_SHARED) && (addr & (SHMLBA - 1)))
-			return -EINVAL;
-		return addr;
-	}
-
 	if (test_thread_flag(TIF_32BIT))
 		task_size = 0xf0000000UL;
 	if (len > task_size || len > -PAGE_OFFSET)


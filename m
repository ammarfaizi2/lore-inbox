Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRALDrY>; Thu, 11 Jan 2001 22:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130204AbRALDrO>; Thu, 11 Jan 2001 22:47:14 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11608 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129742AbRALDrH>; Thu, 11 Jan 2001 22:47:07 -0500
Date: Fri, 12 Jan 2001 04:45:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Message-ID: <20010112044554.A809@athlon.random>
In-Reply-To: <20010111184645.B828@athlon.random> <Pine.LNX.4.10.10101111803580.18517-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101111803580.18517-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jan 11, 2001 at 06:08:21PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 06:08:21PM -0800, Linus Torvalds wrote:
> 
> Could people with Athlons please verify that pre3 works for them?

It works fine.

> It also makes the fxsr disable act the same way the TSC disable does.

Note that there was a precise reason for not implementing it as the TSC disable
(infact at first in 2.2.x I was clearing the bigflag in x86_capabilities too).
The reason is that the way TSC gets disabled breaks /proc/cpuinfo.  Furthmore
in english sense if "the cpu has fxsr or xmm" doesn't mean we can use them at
runtime in the kernel. Such wrong assumption was the source of the 2.4.0 md bug
in first place ;). So I'm not excited we're back in the old way. But of course
those are minor issues and I'm not that concerned /proc/cpuinfo changes even if
the CPU remains the same because nobody should need nofxsr and notsc anyways...

This is a leftover btw:

--- 2.4.1pre3/include/asm-i386/xor.h.~1~	Fri Jan 12 04:14:36 2001
+++ 2.4.1pre3/include/asm-i386/xor.h	Fri Jan 12 04:23:32 2001
@@ -843,7 +843,7 @@
 	do {						\
 		xor_speed(&xor_block_8regs);		\
 		xor_speed(&xor_block_32regs);		\
-	        if (HAVE_XMM)				\
+	        if (cpu_has_xmm)				\
 			xor_speed(&xor_block_pIII_sse);	\
 	        if (md_cpu_has_mmx()) {			\
 	                xor_speed(&xor_block_pII_mmx);	\
@@ -855,4 +855,4 @@
    We may also be able to load into the L1 only depending on how the cpu
    deals with a load to a line that is being prefetched.  */
 #define XOR_SELECT_TEMPLATE(FASTEST) \
-	(HAVE_XMM ? &xor_block_pIII_sse : FASTEST)
+	(cpu_has_xmm ? &xor_block_pIII_sse : FASTEST)



Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

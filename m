Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUDSQSy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUDSQSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:18:54 -0400
Received: from witte.sonytel.be ([80.88.33.193]:35997 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261358AbUDSQSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:18:49 -0400
Date: Mon, 19 Apr 2004 18:18:41 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (m68k)
In-Reply-To: <E1BFYiF-00055y-3q@dyn-67.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.58.0404191815100.3430@waterleaf.sonytel.be>
References: <20040418231720.C12222@flint.arm.linux.org.uk>
 <20040418232314.A2045@flint.arm.linux.org.uk> <E1BFYiF-00055y-3q@dyn-67.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004, Russell King wrote:
> This patch cleans up needless includes of asm/pgalloc.h from the
> arch/m68k/ subtree.  This has not been compile tested, so
> needs the architecture maintainers (or willing volunteers) to
> test.
>
> Please ensure that at least the first two patches have already
> been applied to your tree; they can be found at:
>
> 	http://lkml.org/lkml/2004/4/18/86
> 	http://lkml.org/lkml/2004/4/18/87
>
> This patch is part of a larger patch aiming towards getting the
> include of asm/pgtable.h out of linux/mm.h, so that asm/pgtable.h
> can sanely get at things like mm_struct and friends.
>
> In the event that any of these files fails to build, chances are
> you need to include some other header file rather than pgalloc.h.
> Normally this is either asm/pgtable.h (unlikely), asm/cacheflush.h
> or asm/tlbflush.h.

The patch below fixes all compile-issues on m68k, except when compiling for
Sun-3.

include/asm-generic/tlb.h now includes <asm/pgalloc.h>, which includes
<asm/sun3_pgalloc.h>. But the last file needs tlb_remove_page(), which is
defined in include/asm-generic/tlb.h

Do you really need <asm/pgalloc.h> in include/asm-generic/tlb.h? If yes, can it
be moved down, after the definition of tlb_remove_page()?

--- linux-m68k-2.6.6-rc1-rmk/arch/m68k/kernel/m68k_ksyms.c	2004-04-19 15:35:42.000000000 +0200
+++ linux-m68k-2.6.6-rc1-geert/arch/m68k/kernel/m68k_ksyms.c	2004-04-19 16:19:39.000000000 +0200
@@ -16,6 +16,7 @@
 #include <asm/semaphore.h>
 #include <asm/checksum.h>
 #include <asm/hardirq.h>
+#include <asm/cacheflush.h>

 asmlinkage long long __ashldi3 (long long, int);
 asmlinkage long long __ashrdi3 (long long, int);
--- linux-m68k-2.6.6-rc1-rmk/arch/m68k/kernel/traps.c	2004-04-19 15:35:42.000000000 +0200
+++ linux-m68k-2.6.6-rc1-geert/arch/m68k/kernel/traps.c	2004-04-19 15:53:54.000000000 +0200
@@ -39,6 +39,7 @@
 #include <asm/traps.h>
 #include <asm/machdep.h>
 #include <asm/siginfo.h>
+#include <asm/tlbflush.h>

 /* assembler routines */
 asmlinkage void system_call(void);
--- linux-m68k-2.6.6-rc1-rmk/arch/m68k/mm/kmap.c	2004-04-19 15:35:42.000000000 +0200
+++ linux-m68k-2.6.6-rc1-geert/arch/m68k/mm/kmap.c	2004-04-19 16:04:18.000000000 +0200
@@ -20,6 +20,7 @@
 #include <asm/page.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include <asm/tlbflush.h>

 #undef DEBUG

--- linux-m68k-2.6.6-rc1-rmk/arch/m68k/mm/memory.c	2004-04-19 15:35:42.000000000 +0200
+++ linux-m68k-2.6.6-rc1-geert/arch/m68k/mm/memory.c	2004-04-19 16:04:46.000000000 +0200
@@ -19,6 +19,7 @@
 #include <asm/system.h>
 #include <asm/traps.h>
 #include <asm/machdep.h>
+#include <asm/tlbflush.h>


 /* ++andreas: {get,free}_pointer_table rewritten to use unused fields from
--- linux-m68k-2.6.6-rc1-rmk/arch/m68k/mm/motorola.c	2004-04-19 15:35:42.000000000 +0200
+++ linux-m68k-2.6.6-rc1-geert/arch/m68k/mm/motorola.c	2004-04-19 16:05:22.000000000 +0200
@@ -30,6 +30,8 @@
 #ifdef CONFIG_ATARI
 #include <asm/atari_stram.h>
 #endif
+#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>

 #undef DEBUG

--- linux-m68k-2.6.6-rc1-rmk/arch/m68k/sun3x/dvma.c	2004-04-19 15:35:42.000000000 +0200
+++ linux-m68k-2.6.6-rc1-geert/arch/m68k/sun3x/dvma.c	2004-04-19 17:38:35.000000000 +0200
@@ -23,6 +23,7 @@
 #include <asm/io.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/tlbflush.h>

 /* IOMMU support */

--- linux-m68k-2.6.6-rc1-rmk/include/asm-m68k/motorola_pgalloc.h	2003-05-06 14:08:25.000000000 +0200
+++ linux-m68k-2.6.6-rc1-geert/include/asm-m68k/motorola_pgalloc.h	2004-04-19 15:50:33.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _MOTOROLA_PGALLOC_H
 #define _MOTOROLA_PGALLOC_H

+#include <asm/tlbflush.h>
 #include <asm/tlb.h>

 extern pmd_t *get_pointer_table(void);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

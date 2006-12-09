Return-Path: <linux-kernel-owner+w=401wt.eu-S936678AbWLIJel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936678AbWLIJel (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936679AbWLIJel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:34:41 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:51026 "EHLO
	astra.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936678AbWLIJek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:34:40 -0500
Date: Sat, 9 Dec 2006 10:34:38 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Sam Creasey <sammy@sammy.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Sun3: General updates
Message-ID: <Pine.LNX.4.64.0612091033340.11749@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Creasey <sammy@sammy.net>

General compile fixes for 2.6.16 for sun3, and some updates to make the new
bootloader work correctly.  Tested on 3/50, 3/60, 3/80.

Signed-off-by: Sam Creasey <sammy@sammy.net>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

---
 arch/m68k/kernel/sun3-head.S      |   10 ----------
 arch/m68k/kernel/vmlinux-sun3.lds |    2 +-
 arch/m68k/mm/sun3mmu.c            |    7 +++++--
 include/asm-m68k/sun3-head.h      |    1 -
 include/asm-m68k/sun3ints.h       |    1 +
 5 files changed, 7 insertions(+), 14 deletions(-)

--- linux-m68k-2.6.19.orig/arch/m68k/kernel/sun3-head.S
+++ linux-m68k-2.6.19/arch/m68k/kernel/sun3-head.S
@@ -67,16 +67,6 @@ ENTRY(_start)
 1:	lea	init_task,%curptr			| get initial thread...
 	lea	init_thread_union+THREAD_SIZE,%sp	| ...and its stack.
 
-/* copy bootinfo records from the loader to _end */
-	lea	_end, %a1
-	lea	BI_START, %a0
-	/* number of longs to copy */
-	movel	%a0@, %d0
-1:	addl	#4, %a0
-	movel   %a0@, %a1@
-	addl	#4, %a1
-	dbf	%d0, 1b
-
 /* Point MSP at an invalid page to trap if it's used. --m */
 	movl	#(PAGESIZE),%d0
 	movc	%d0,%msp
--- linux-m68k-2.6.19.orig/arch/m68k/kernel/vmlinux-sun3.lds
+++ linux-m68k-2.6.19/arch/m68k/kernel/vmlinux-sun3.lds
@@ -8,7 +8,7 @@ ENTRY(_start)
 jiffies = jiffies_64 + 4;
 SECTIONS
 {
-  . = 0xE004000;
+  . = 0xE002000;
   _text = .;			/* Text and read-only data */
   .text : {
 	*(.head)
--- linux-m68k-2.6.19.orig/arch/m68k/mm/sun3mmu.c
+++ linux-m68k-2.6.19/arch/m68k/mm/sun3mmu.c
@@ -49,7 +49,6 @@ void __init paging_init(void)
 	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
 	unsigned long size;
 
-
 #ifdef TEST_VERIFY_AREA
 	wp_works_ok = 0;
 #endif
@@ -94,7 +93,11 @@ void __init paging_init(void)
 	/* memory sizing is a hack stolen from motorola.c..  hope it works for us */
 	zones_size[ZONE_DMA] = ((unsigned long)high_memory - PAGE_OFFSET) >> PAGE_SHIFT;
 
-	free_area_init(zones_size);
+	/* I really wish I knew why the following change made things better...  -- Sam */
+/*	free_area_init(zones_size); */
+	free_area_init_node(0, NODE_DATA(0), zones_size,
+			    (__pa(PAGE_OFFSET) >> PAGE_SHIFT) + 1, NULL);
+
 
 }
 
--- linux-m68k-2.6.19.orig/include/asm-m68k/sun3-head.h
+++ linux-m68k-2.6.19/include/asm-m68k/sun3-head.h
@@ -4,7 +4,6 @@
 
 #define KERNBASE        0xE000000  /* First address the kernel will eventually be */
 #define LOAD_ADDR       0x4000      /* prom jumps to us here unless this is elf /boot */
-#define BI_START (KERNBASE + 0x3000) /* beginning of the bootinfo records */
 #define FC_CONTROL  3
 #define FC_SUPERD    5
 #define FC_CPU      7
--- linux-m68k-2.6.19.orig/include/asm-m68k/sun3ints.h
+++ linux-m68k-2.6.19/include/asm-m68k/sun3ints.h
@@ -16,6 +16,7 @@
 #include <asm/intersil.h>
 #include <asm/oplib.h>
 #include <asm/traps.h>
+#include <asm/irq.h>
 
 #define SUN3_INT_VECS 192
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

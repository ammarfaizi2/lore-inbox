Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265680AbUFTRkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265680AbUFTRkw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbUFTRbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:31:07 -0400
Received: from nl-ams-slo-l4-01-pip-5.chellonetwork.com ([213.46.243.21]:43330
	"EHLO amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S265801AbUFTRZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:25:46 -0400
Date: Sun, 20 Jun 2004 19:25:31 +0200
Message-Id: <200406201725.i5KHPVUF001467@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 449] M68k IFPSP060
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IFPSP060: Make sure that the destination address of a misaligned cas access is
properly mapped in, so the kernel won't oops in the emulation handler (from
Roman Zippel).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.7/arch/m68k/ifpsp060/iskeleton.S	2004-05-03 11:01:24.000000000 +0200
+++ linux-m68k-2.6.7/arch/m68k/ifpsp060/iskeleton.S	2004-05-23 10:55:54.000000000 +0200
@@ -196,14 +196,57 @@
 | Expected outputs:
 |	d0 = 0 -> success; non-zero -> failure
 |
-| Linux/68k: As long as ints are disabled, no swapping out should
-| occur (hopefully...)
+| Linux/m68k: Make sure the page is properly paged in, so we use
+| plpaw and handle any exception here. The kernel must not be
+| preempted until _060_unlock_page(), so that the page stays mapped.
 |
 	.global		_060_real_lock_page
 _060_real_lock_page:
-	clr.l		%d0
+	move.l	%d2,-(%sp)
+	| load sfc/dfc
+	moveq	#5,%d0
+	tst.b	%d0
+	jne	1f
+	moveq	#1,%d0
+1:	movec.l	%dfc,%d2
+	movec.l	%d0,%dfc
+	movec.l	%d0,%sfc
+
+	clr.l	%d0
+	| prefetch address
+	.chip	68060
+	move.l	%a0,%a1
+1:	plpaw	(%a1)
+	addq.w	#1,%a0
+	tst.b	%d1
+	jeq	2f
+	addq.w	#2,%a0
+2:	plpaw	(%a0)
+3:	.chip	68k
+
+	| restore sfc/dfc
+	movec.l	%d2,%dfc
+	movec.l	%d2,%sfc
+	move.l	(%sp)+,%d2
 	rts
 
+.section __ex_table,"a"
+	.align	4
+	.long	1b,11f
+	.long	2b,21f
+.previous
+.section .fixup,"ax"
+	.even
+11:	move.l	#0x020003c0,%d0
+	or.l	%d2,%d0
+	swap	%d0
+	jra	3b
+21:	move.l	#0x02000bc0,%d0
+	or.l	%d2,%d0
+	swap	%d0
+	jra	3b
+.previous
+
 |
 | _060_unlock_page():
 |
@@ -216,8 +259,7 @@
 |	d0 = `xxxxxxff -> supervisor; `xxxxxx00 -> user
 |	d1 = `xxxxxxff -> longword; `xxxxxx00 -> word
 |
-| Linux/68k: As we do no special locking operation, also no unlocking
-| is needed...
+| Linux/m68k: perhaps reenable preemption here...
 
 	.global		_060_real_unlock_page
 _060_real_unlock_page:

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

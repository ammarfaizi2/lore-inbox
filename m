Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266509AbUGUPgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUGUPgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 11:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUGUPgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 11:36:14 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:63796
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S266509AbUGUPgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 11:36:09 -0400
Date: Wed, 21 Jul 2004 17:36:01 +0200
Message-Id: <200407211536.i6LFa1uO020399@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 157] M68k ifpsp060
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

68060 Integer Support Package: Make sure that the destination address of a
misaligned cas access is properly mapped in, so the kernel won't oops later in
the emulation handler (from Roman Zippel)

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.27-rc3/arch/m68k/ifpsp060/iskeleton.S	2004-04-27 17:19:38.000000000 +0200
+++ linux-m68k-2.4.27-rc3/arch/m68k/ifpsp060/iskeleton.S	2004-07-04 21:55:43.000000000 +0200
@@ -196,14 +196,58 @@
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
+	tst.b	%d0
+	jne	1f
+	moveq	#1,%d0
+	jra	2f
+1:	moveq	#5,%d0
+2:	movec.l	%dfc,%d2
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
@@ -216,8 +260,7 @@
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264935AbUAAUsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264883AbUAAUDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:03:04 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:37674 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S264565AbUAAUBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:50 -0500
Date: Thu, 1 Jan 2004 21:01:48 +0100
Message-Id: <200401012001.i01K1mo7031703@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 343] M68k head pic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Make console functions position independent (from Roman Zippel)

--- linux-2.6.0/arch/m68k/kernel/head.S	13 Oct 2003 22:52:42 -0000	1.12
+++ linux-m68k-2.6.0/arch/m68k/kernel/head.S	13 Oct 2003 22:56:19 -0000
@@ -273,6 +273,7 @@
  */
 
 #define CONSOLE
+#define CONSOLE_PENGUIN
 
 /*
  * Macintosh serial debug support; outputs boot info to the printer
@@ -1245,10 +1246,10 @@
 	 */
 
 	movel	#VIDEOMEMMASK,%d0
-	andl	L(mac_videobase),%d0
+	andl	%pc@(L(mac_videobase)),%d0
 
 	mmu_map		#VIDEOMEMBASE,%d0,#VIDEOMEMSIZE,%d3
-	/* The ROM starts at 4000 0000		    	*/
+	/* ROM from 4000 0000 to 4200 0000 (only for mac_reset()) */
 	mmu_map_eq	#0x40000000,#0x02000000,%d3
 	/* IO devices (incl. serial port) from 5000 0000 to 5300 0000 */
 	mmu_map_eq	#0x50000000,#0x03000000,%d3
@@ -1464,6 +1465,12 @@
 	andl	L(mac_videobase),%d0
 	addl	#VIDEOMEMBASE,%d0
 	movel	%d0,L(mac_videobase)
+#if defined(CONSOLE)
+	movel	%pc@(L(phys_kernel_start)),%d0
+	subl	#PAGE_OFFSET,%d0
+	subl	%d0,L(console_font)
+	subl	%d0,L(console_font_data)
+#endif
 #ifdef MAC_SERIAL_DEBUG
 	orl	#0x50000000,L(mac_sccbase)
 #endif		
@@ -3331,26 +3338,24 @@
 	 */
 
 	lea	%pc@(L(console_globals)),%a2
-	lea	%pc@(L(mac_videobase)),%a0
-	movel	%a0@,%a1
-	lea	%pc@(L(mac_rowbytes)),%a0
-	movel	%a0@,%d5
-	lea	%pc@(L(mac_dimensions)),%a0
-	movel	%a0@,%d3	/* -> low byte */
+	movel	%pc@(L(mac_videobase)),%a1
+	movel	%pc@(L(mac_rowbytes)),%d5
+	movel	%pc@(L(mac_dimensions)),%d3	/* -> low byte */
 	movel	%d3,%d4
 	swap	%d4		/* -> high byte */
 	andl	#0xffff,%d3	/* d3 = screen width in pixels */
 	andl	#0xffff,%d4	/* d4 = screen height in pixels */
 
 	movel	%d5,%d6
-	subl	#20,%d6
+|	subl	#20,%d6
 	mulul	%d4,%d6		/* scan line bytes x num scan lines */
 	divul	#8,%d6		/* we'll clear 8 bytes at a time */
+	moveq	#-1,%d0		/* Mac_black */
 	subq	#1,%d6
 
 L(console_clear_loop):
-	movel	#0xffffffff,%a1@+	/* Mac_black */
-	movel	#0xffffffff,%a1@+	/* Mac_black */
+	movel	%d0,%a1@+
+	movel	%d0,%a1@+
 	dbra	%d6,L(console_clear_loop)
 
 	/* Calculate font size */
@@ -3375,6 +3380,11 @@
 	movel	%a0,%a1@	/* store pointer to struct fbcon_font_desc in console_font */
 	tstl	%a0
 	jeq	1f
+	lea	%pc@(L(console_font_data)),%a4
+	movel	%a0@(FONT_DESC_DATA),%d0
+	subl	#L(console_font),%a1
+	addl	%a1,%d0
+	movel	%d0,%a4@
 
 	/*
 	 *	Calculate global maxs
@@ -3452,7 +3462,7 @@
 	subil	#64,%d0		/* snug up against the right edge */
 	clrl	%d1		/* start at the top */
 	movel	#73,%d7
-	lea	%pc@(that_penguin),%a1
+	lea	%pc@(L(that_penguin)),%a1
 L(console_penguin_row):
 	movel	#31,%d6
 L(console_penguin_pixel_pair):
@@ -3470,6 +3480,10 @@
 	dbra	%d7,L(console_penguin_row)
 
 func_return	console_put_penguin
+
+/* include penguin bitmap */
+L(that_penguin):
+#include "../mac/mac_penguin.S"	
 #endif
 
 	/*
@@ -3600,7 +3614,7 @@
  */
 L(console_not_home):
 	movel	%a0@(Lconsole_struct_cur_column),%d0
-	addil	#1,%a0@(Lconsole_struct_cur_column)
+	addql	#1,%a0@(Lconsole_struct_cur_column)
 	movel	%a0@(Lconsole_struct_num_columns),%d1
 	cmpl	%d1,%d0
 	jcs	1f
@@ -3613,7 +3627,7 @@
 	 *	a0 = address of pointer to font data (fbcon_font_desc)
 	 */
 	movel	%pc@(L(console_font)),%a0
-	movel	%a0@(FONT_DESC_DATA),%a1	/* Load fbcon_font_desc.data into a1 */
+	movel	%pc@(L(console_font_data)),%a1	/* Load fbcon_font_desc.data into a1 */
 	andl	#0x000000ff,%d7
 		/* ASSERT: a0 = contents of Lconsole_font */
 	mulul	%a0@(FONT_DESC_HEIGHT),%d7	/* d7 = index into font data */
@@ -3836,6 +3850,8 @@
 	.long	0		/* mac putc */
 L(console_font):
 	.long	0		/* pointer to console font (struct font_desc) */
+L(console_font_data):
+	.long	0		/* pointer to console font data */
 #endif /* CONSOLE */
 
 #if defined(MMU_PRINT)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbUAAUC0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbUAAUC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:02:26 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:11575 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S264557AbUAAUBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:49 -0500
Date: Thu, 1 Jan 2004 21:01:46 +0100
Message-Id: <200401012001.i01K1kHL031685@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 340] M68k head console
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Use function macros and local macro for console functions (from Roman
Zippel)

--- linux-2.6.0/arch/m68k/kernel/head.S	13 Mar 2003 06:45:11 -0000	1.9
+++ linux-m68k-2.6.0/arch/m68k/kernel/head.S	13 Oct 2003 22:47:10 -0000
@@ -483,6 +483,12 @@
 func_define	serial_putc,1
 func_define	console_putc,1
 
+func_define	console_init
+func_define	console_put_stats
+func_define	console_put_penguin
+func_define	console_plot_pixel,3
+func_define	console_scroll
+
 .macro	putc	ch
 #if defined(CONSOLE) || defined(SERIAL_DEBUG)
 	pea	\ch
@@ -960,11 +966,11 @@
 #ifdef CONFIG_MAC
 	is_not_mac(L(nocon))
 #ifdef CONSOLE
-	jbsr	L(console_init)
+	console_init
 #ifdef CONSOLE_PENGUIN
-	jbsr	L(console_put_penguin)
+	console_put_penguin
 #endif	/* CONSOLE_PENGUIN */
-	jbsr	L(console_put_stats)
+	console_put_stats
 #endif	/* CONSOLE */
 L(nocon):
 #endif	/* CONFIG_MAC */
@@ -3313,7 +3319,7 @@
 #define Lconsole_struct_left_edge	16
 #define Lconsole_struct_penguin_putc	20
 
-L(console_init):
+func_start	console_init,%a0-%a4/%d0-%d7
 	/*
 	 *	Some of the register usage that follows
 	 *		a0 = pointer to boot_info
@@ -3327,7 +3333,6 @@
 	 *		d5 = number of bytes per scan line
 	 *		d6 = number of bytes on the entire screen
 	 */
-	moveml	%a0-%a4/%d0-%d7,%sp@-
 
 	lea	%pc@(L(console_globals)),%a2
 	lea	%pc@(L(mac_videobase)),%a0
@@ -3347,10 +3352,10 @@
 	divul	#8,%d6		/* we'll clear 8 bytes at a time */
 	subq	#1,%d6
 
-console_clear_loop:
+L(console_clear_loop):
 	movel	#0xffffffff,%a1@+	/* Mac_black */
 	movel	#0xffffffff,%a1@+	/* Mac_black */
-	dbra	%d6,console_clear_loop
+	dbra	%d6,L(console_clear_loop)
 
 	/* Calculate font size */
 
@@ -3401,17 +3406,15 @@
 	/*
 	 * Initialization is complete
 	 */
-1:	moveml	%sp@+,%a0-%a4/%d0-%d7
-	rts
+1:
+func_return	console_init
 
-L(console_put_stats):
+func_start	console_put_stats,%a0/%d7
 	/*
 	 *	Some of the register usage that follows
 	 *		a0 = pointer to boot_info
 	 *		d7 = value of boot_info fields
 	 */
-	moveml	%a0/%d7,%sp@-
-
 	puts	"\nMacLinux\n\n"
 
 #ifdef SERIAL_DEBUG
@@ -3439,17 +3442,14 @@
 #  endif /* MMU_PRINT */
 #endif /* SERIAL_DEBUG */
 
-	moveml	%sp@+,%a0/%d7
-	rts
+func_return	console_put_stats
 
 #ifdef CONSOLE_PENGUIN
-L(console_put_penguin):
+func_start	console_put_penguin,%a0-%a1/%d0-%d7
 	/*
 	 *	Get 'that_penguin' onto the screen in the upper right corner
 	 *	penguin is 64 x 74 pixels, align against right edge of screen
 	 */
-	moveml	%a0-%a1/%d0-%d7,%sp@-
-
 	lea	%pc@(L(mac_dimensions)),%a0
 	movel	%a0@,%d0
 	andil	#0xffff,%d0
@@ -3457,34 +3457,32 @@
 	clrl	%d1		/* start at the top */
 	movel	#73,%d7
 	lea	%pc@(that_penguin),%a1
-console_penguin_row:
+L(console_penguin_row):
 	movel	#31,%d6
-console_penguin_pixel_pair:
+L(console_penguin_pixel_pair):
 	moveb	%a1@,%d2
 	lsrb	#4,%d2
-	jbsr	console_plot_pixel
+	console_plot_pixel %d0,%d1,%d2
 	addq	#1,%d0
 	moveb	%a1@+,%d2
-	jbsr	console_plot_pixel
+	console_plot_pixel %d0,%d1,%d2
 	addq	#1,%d0
-	dbra	%d6,console_penguin_pixel_pair
+	dbra	%d6,L(console_penguin_pixel_pair)
 
 	subil	#64,%d0
 	addq	#1,%d1
-	dbra	%d7,console_penguin_row
+	dbra	%d7,L(console_penguin_row)
 
-	moveml	%sp@+,%a0-%a1/%d0-%d7
-	rts
+func_return	console_put_penguin
 #endif
 
-console_scroll:
-	moveml	%a0-%a4/%d0-%d7,%sp@-
-
 	/*
 	 * Calculate source and destination addresses
 	 *	output	a1 = dest
 	 *		a2 = source
 	 */
+
+func_start	console_scroll,%a0-%a4/%d0-%d7
 	lea	%pc@(L(mac_videobase)),%a0
 	movel	%a0@,%a1
 	movel	%a1,%a2
@@ -3517,7 +3515,7 @@
 	divul	#32,%d6		/* we'll move 8 longs at a time */
 	subq	#1,%d6
 
-console_scroll_loop:
+L(console_scroll_loop):
 	movel	%a2@+,%a1@+
 	movel	%a2@+,%a1@+
 	movel	%a2@+,%a1@+
@@ -3526,7 +3524,7 @@
 	movel	%a2@+,%a1@+
 	movel	%a2@+,%a1@+
 	movel	%a2@+,%a1@+
-	dbra	%d6,console_scroll_loop
+	dbra	%d6,L(console_scroll_loop)
 
 	lea	%pc@(L(mac_rowbytes)),%a0
 	movel	%a0@,%d6
@@ -3536,7 +3534,7 @@
 	subq	#1,%d6
 
 	moveq	#-1,%d0
-console_scroll_clear_loop:
+L(console_scroll_clear_loop):
 	movel	%d0,%a1@+
 	movel	%d0,%a1@+
 	movel	%d0,%a1@+
@@ -3545,17 +3543,17 @@
 	movel	%d0,%a1@+
 	movel	%d0,%a1@+
 	movel	%d0,%a1@+
-	dbra	%d6,console_scroll_clear_loop
+	dbra	%d6,L(console_scroll_clear_loop)
 
-1:	moveml	%sp@+,%a0-%a4/%d0-%d7
-	rts
+1:
+func_return	console_scroll
 
 
 func_start	console_putc,%a0/%a1/%d0-%d7
 
-	is_not_mac(console_exit)
+	is_not_mac(L(console_exit))
 	tstl	%pc@(L(console_font))
-	jeq	console_exit
+	jeq	L(console_exit)
 
 	/* Output character in d7 on console.
 	 */
@@ -3569,7 +3567,7 @@
 	lea	%pc@(L(console_globals)),%a0
 
 	cmpib	#10,%d7
-	jne	console_not_lf
+	jne	L(console_not_lf)
 	movel	%a0@(Lconsole_struct_cur_row),%d0
 	addil	#1,%d0
 	movel	%d0,%a0@(Lconsole_struct_cur_row)
@@ -3578,22 +3576,22 @@
 	jcs	1f
 	subil	#1,%d0
 	movel	%d0,%a0@(Lconsole_struct_cur_row)
-	jbsr	console_scroll
+	console_scroll
 1:
-	jra	console_exit
+	jra	L(console_exit)
 
-console_not_lf:
+L(console_not_lf):
 	cmpib	#13,%d7
-	jne	console_not_cr
+	jne	L(console_not_cr)
 	clrl	%a0@(Lconsole_struct_cur_column)
-	jra	console_exit
+	jra	L(console_exit)
 
-console_not_cr:
+L(console_not_cr):
 	cmpib	#1,%d7
-	jne	console_not_home
+	jne	L(console_not_home)
 	clrl	%a0@(Lconsole_struct_cur_row)
 	clrl	%a0@(Lconsole_struct_cur_column)
-	jra	console_exit
+	jra	L(console_exit)
 
 /*
  *	At this point we know that the %d7 character is going to be
@@ -3604,7 +3602,7 @@
  *		d1 = cursor row to draw the character
  *		d7 = character number
  */
-console_not_home:
+L(console_not_home):
 	movel	%a0@(Lconsole_struct_cur_column),%d0
 	addil	#1,%a0@(Lconsole_struct_cur_column)
 	movel	%a0@(Lconsole_struct_num_columns),%d1
@@ -3616,10 +3614,10 @@
 
 	/*
 	 *	At this point we make a shift in register usage
-	 *	a0 = address of pointer to font data (font_desc)
+	 *	a0 = address of pointer to font data (fbcon_font_desc)
 	 */
 	movel	%pc@(L(console_font)),%a0
-	movel	%a0@(FONT_DESC_DATA),%a1	/* Load font_desc.data into a1 */
+	movel	%a0@(FONT_DESC_DATA),%a1	/* Load fbcon_font_desc.data into a1 */
 	andl	#0x000000ff,%d7
 		/* ASSERT: a0 = contents of Lconsole_font */
 	mulul	%a0@(FONT_DESC_HEIGHT),%d7	/* d7 = index into font data */
@@ -3637,32 +3635,30 @@
 		/* ASSERT: a0 = contents of Lconsole_font */
 	mulul	%a0@(FONT_DESC_WIDTH),%d0
 	mulul	%a0@(FONT_DESC_HEIGHT),%d1
-	movel	%a0@(FONT_DESC_HEIGHT),%d7	/* Load font_desc.height into d7 */
+	movel	%a0@(FONT_DESC_HEIGHT),%d7	/* Load fbcon_font_desc.height into d7 */
 	subq	#1,%d7
-console_read_char_scanline:
+L(console_read_char_scanline):
 	moveb	%a1@+,%d3
 
 		/* ASSERT: a0 = contents of Lconsole_font */
-	movel	%a0@(FONT_DESC_WIDTH),%d6	/* Load font_desc.width into d6 */
+	movel	%a0@(FONT_DESC_WIDTH),%d6	/* Load fbcon_font_desc.width into d6 */
 	subql	#1,%d6
 
-console_do_font_scanline:
+L(console_do_font_scanline):
 	lslb	#1,%d3
 	scsb	%d2		/* convert 1 bit into a byte */
-	jbsr	console_plot_pixel
+	console_plot_pixel %d0,%d1,%d2
 	addq	#1,%d0
-	dbra	%d6,console_do_font_scanline
+	dbra	%d6,L(console_do_font_scanline)
 
 		/* ASSERT: a0 = contents of Lconsole_font */
 	subl	%a0@(FONT_DESC_WIDTH),%d0
 	addq	#1,%d1
-	dbra	%d7,console_read_char_scanline
-
-console_exit:
+	dbra	%d7,L(console_read_char_scanline)
 
+L(console_exit):
 func_return	console_putc
 
-console_plot_pixel:
 	/*
 	 *	Input:
 	 *		d0 = x coordinate
@@ -3670,14 +3666,14 @@
 	 *		d2 = (bit 0) 1/0 for white/black (!)
 	 *	All registers are preserved
 	 */
-	moveml	%a0-%a1/%d0-%d4,%sp@-
+func_start	console_plot_pixel,%a0-%a1/%d0-%d4
 
-	lea	%pc@(L(mac_videobase)),%a0
-	movel	%a0@,%a1
-	lea	%pc@(L(mac_videodepth)),%a0
-	movel	%a0@,%d3
-	lea	%pc@(L(mac_rowbytes)),%a0
-	mulul	%a0@,%d1
+	movel	%pc@(L(mac_videobase)),%a1
+	movel	%pc@(L(mac_videodepth)),%d3
+	movel	ARG1,%d0
+	movel	ARG2,%d1
+	mulul	%pc@(L(mac_rowbytes)),%d1
+	movel	ARG3,%d2
 
 	/*
 	 *	Register usage:
@@ -3686,13 +3682,10 @@
 	 *		d2 = black or white (0/1)
 	 *		d3 = video depth
 	 *		d4 = temp of x (d0) for many bit depths
-	 *		d5 = unused
-	 *		d6 = unused
-	 *		d7 = unused
 	 */
-test_1bit:
+L(test_1bit):
 	cmpb	#1,%d3
-	jbne	test_2bit
+	jbne	L(test_2bit)
 	movel	%d0,%d4		/* we need the low order 3 bits! */
 	divul	#8,%d0
 	addal	%d0,%a1
@@ -3700,16 +3693,16 @@
 	andb	#7,%d4
 	eorb	#7,%d4		/* reverse the x-coordinate w/ screen-bit # */
 	andb	#1,%d2
-	jbne	white_1
+	jbne	L(white_1)
 	bsetb	%d4,%a1@
-	jbra	console_plot_pixel_exit
-white_1:
+	jbra	L(console_plot_pixel_exit)
+L(white_1):
 	bclrb	%d4,%a1@
-	jbra	console_plot_pixel_exit
+	jbra	L(console_plot_pixel_exit)
 
-test_2bit:
+L(test_2bit):
 	cmpb	#2,%d3
-	jbne	test_4bit
+	jbne	L(test_4bit)
 	movel	%d0,%d4		/* we need the low order 2 bits! */
 	divul	#4,%d0
 	addal	%d0,%a1
@@ -3718,20 +3711,20 @@
 	eorb	#3,%d4		/* reverse the x-coordinate w/ screen-bit # */
 	lsll	#1,%d4		/* ! */
 	andb	#1,%d2
-	jbne	white_2
+	jbne	L(white_2)
 	bsetb	%d4,%a1@
 	addq	#1,%d4
 	bsetb	%d4,%a1@
-	jbra	console_plot_pixel_exit
-white_2:
+	jbra	L(console_plot_pixel_exit)
+L(white_2):
 	bclrb	%d4,%a1@
 	addq	#1,%d4
 	bclrb	%d4,%a1@
-	jbra	console_plot_pixel_exit
+	jbra	L(console_plot_pixel_exit)
 
-test_4bit:
+L(test_4bit):
 	cmpb	#4,%d3
-	jbne	test_8bit
+	jbne	L(test_8bit)
 	movel	%d0,%d4		/* we need the low order bit! */
 	divul	#2,%d0
 	addal	%d0,%a1
@@ -3740,7 +3733,7 @@
 	eorb	#1,%d4
 	lsll	#2,%d4		/* ! */
 	andb	#1,%d2
-	jbne	white_4
+	jbne	L(white_4)
 	bsetb	%d4,%a1@
 	addq	#1,%d4
 	bsetb	%d4,%a1@
@@ -3748,8 +3741,8 @@
 	bsetb	%d4,%a1@
 	addq	#1,%d4
 	bsetb	%d4,%a1@
-	jbra	console_plot_pixel_exit
-white_4:
+	jbra	L(console_plot_pixel_exit)
+L(white_4):
 	bclrb	%d4,%a1@
 	addq	#1,%d4
 	bclrb	%d4,%a1@
@@ -3757,38 +3750,37 @@
 	bclrb	%d4,%a1@
 	addq	#1,%d4
 	bclrb	%d4,%a1@
-	jbra	console_plot_pixel_exit
+	jbra	L(console_plot_pixel_exit)
 
-test_8bit:
+L(test_8bit):
 	cmpb	#8,%d3
-	jbne	test_16bit
+	jbne	L(test_16bit)
 	addal	%d0,%a1
 	addal	%d1,%a1
 	andb	#1,%d2
-	jbne	white_8
+	jbne	L(white_8)
 	moveb	#0xff,%a1@
-	jbra	console_plot_pixel_exit
-white_8:
+	jbra	L(console_plot_pixel_exit)
+L(white_8):
 	clrb	%a1@
-	jbra	console_plot_pixel_exit
+	jbra	L(console_plot_pixel_exit)
 
-test_16bit:
+L(test_16bit):
 	cmpb	#16,%d3
-	jbne	console_plot_pixel_exit
+	jbne	L(console_plot_pixel_exit)
 	addal	%d0,%a1
 	addal	%d0,%a1
 	addal	%d1,%a1
 	andb	#1,%d2
-	jbne	white_16
+	jbne	L(white_16)
 	clrw	%a1@
-	jbra	console_plot_pixel_exit
-white_16:
+	jbra	L(console_plot_pixel_exit)
+L(white_16):
 	movew	#0x0fff,%a1@
-	jbra	console_plot_pixel_exit
+	jbra	L(console_plot_pixel_exit)
 
-console_plot_pixel_exit:
-	moveml	%sp@+,%a0-%a1/%d0-%d4
-	rts
+L(console_plot_pixel_exit):
+func_return	console_plot_pixel
 #endif /* CONSOLE */
 
 #if 0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

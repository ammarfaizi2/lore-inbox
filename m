Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTJVUcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 16:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTJVUcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 16:32:21 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:52622
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S261384AbTJVUcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 16:32:17 -0400
From: John Mock <kd6pag@qsl.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Experimental patch for 'vga=ask' shows VESA modes [2.6.0-test8, 2.4.21] [RFC]
Message-Id: <E1ACPeg-0000Qx-00@penngrove.fdns.net>
Date: Wed, 22 Oct 2003 13:32:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While struggling to get past the 256 color limitation on VAIO R505EL, i 
made an attempt to list the BIOS-implemented VESA modes under 'vga=ask' 
while trying to how get the VAIO BIOS to do something useful for me. 
Here is what might be thought of as a work-in-progress on the video mode 
selection code.  This patch seems to work both on the most recent kernel
and 2.4.21, and might also apply to earlier versions as well.

It does several things, not all of which may be appropriate in some cases.

First, when it goes over the list of VESA modes returned by the BIOS (via
int 10, code 0x4f00), it now accepts both color text and graphics  modes. 
Because the current selection code has no place to remember the size of 
the screen in raster coordinates, the code uses the BIOS's description of 
character size to convert the graphics mode size into an equivalent text
size in columns and rows.  These then appear in the list of available 
graphics modes.

I consider this part to be controversial, as no attempt is made in 'video.S'
to determine if there is a framebuffer driver available to use this mode.
So i currently don't have much idea what this code will do in the absense
of such, and hence it needs more testing.  (Furthermore, at least 'intelfb' 
[i830 framebuffer driver for 2.4] seems to ignore results of 'vga=ask', so
more work is needed there at least.)  For the moment, perhaps it should be
dependent on CONFIG_FB_VESA and/or have its own CONFIG variable.

Second, it defines as a symbol the expected value for what is described in
the VESA/BIOS documentation as "start segment of window A" (and also found
hard-coded at drivers/video/console/vgacon.c:216). If that symbol is not
defined, then that address is not checked.  That address appears to be
specific to color text mode, and thus checking that rejects graphics mode.
Hence it needed to be turned off to accept graphics mode.  In any case, it
is probably better not being hard-coded hexadecimal.

Third, i've conditionalized out code that merges 'duplicate' row/column 
modes, since if a frame buffer is involved, different color depths are not 
going to be duplicates anymore.  Those depths aren't listed or even saved, 
as that would involve more substantial changes than i'm willing to look at
at this point.  This may or may not be a good idea and perhaps belongs in
'.config' instead of here.

While it might be an improvement, i'm not that happy with the changes, and
wonder of 'video.S' is more in need of a major overhaul than another patch.

So in absence of feedback to the contrary, i consider this patch to be an
experimental one and likely not ready for prime-time.

Suggestions would be appreciated on whether to pursue this further and/or
what else might be needed here.
					-- JM

-------------------------------------------------------------------------------
--- arch/i386/boot/video.S.orig	2003-10-17 14:42:57.000000000 -0700
+++ arch/i386/boot/video.S	2003-10-22 13:15:37.000000000 -0700
@@ -20,7 +20,15 @@
 #define CONFIG_VIDEO_VESA
 
 /* Enable compacting of mode table */
+#ifndef CONFIG_FB
 #define CONFIG_VIDEO_COMPACT
+#endif
+
+/* Check start of Window A in VESA mode if defined.  (n.b. this might be 
+   shifted 4 bits and/or byte-swapped, and is for color text mode only??) */
+#ifndef CONFIG_FB
+#define CONFIG_VGA_BIOS_CTEXT_ADDR 0xB800 */
+#endif
 
 /* Retain screen contents when switching modes */
 #define CONFIG_VIDEO_RETAIN
@@ -1036,13 +1044,15 @@
 	jnz	vesan			# Don't report errors (buggy BIOSES)
 
 	movb	(%di), %al			# Check capabilities. We require
-	andb	$0x19, %al			# a color text mode.
+	andb	$0x09, %al			# color text or graphics mode.
 	cmpb	$0x09, %al
 	jnz	vesan
 	
-	cmpw	$0xb800, 8(%di)		# Standard video memory address required
-	jnz	vesan
-
+#ifdef CONFIG_VGA_BIOS_CTEXT_ADDR
+	cmpw	$CONFIG_VGA_BIOS_CTEXT_ADDR, 8(%di)	
+					# Standard video memory address required
+	jnz	vesan			# If wrong address, maybe not color text
+#endif
 	testb	$2, (%di)			# Mode characteristics supplied?
 	movw	%bx, (%di)			# Store mode number
 	jz	vesa3
@@ -1050,12 +1060,12 @@
 	xorw	%dx, %dx
 	movw	0x12(%di), %bx			# Width
 	orb	%bh, %bh
-	jnz	vesan
+	jnz	vesag				# More than 256 -> graphics
 	
 	movb	%bl, 0x3(%di)
 	movw	0x14(%di), %ax			# Height
 	orb	%ah, %ah
-	jnz	vesan
+	jnz	vesag				# More than 256 -> graphics
 	
 	movb	%al, 2(%di)
 	mulb	%bl
@@ -1064,6 +1074,21 @@
 
 	jmp	vesaok
 
+# Graphics mode, invent character dimensions rather than re-write selection 
+# code for now.
+vesag:	movw	0x16(%di),%ax	# Make sure we're not going to divide by zero
+	orb	%al,%al
+	jz	vesan
+	orb	%ah,%ah
+	jz	vesan
+	movw	0x12(%di),%ax	# Get raster width in pixels
+	divb	0x16(%di)	# Divide by BIOS's opinion of pixels/character
+	movb	%al,0x3(%di)	# Save number of columns
+	movw	0x14(%di),%ax	# Do same with height
+	divb	0x17(%di)
+	movb	%al,0x2(%di)	# Save number of rows
+	jmp	vesaok
+	
 vesa3:	subw	$0x8108, %bx	# This mode has no detailed info specified,
 	jc	vesan		# so it must be a standard VESA mode.
 
@@ -1073,13 +1098,15 @@
 	movw	vesa_text_mode_table(%bx), %ax
 	movw	%ax, 2(%di)
 vesaok:	addw	$4, %di				# The mode is valid. Store it.
-vesan:	loop	vesa1			# Next mode. Limit exceeded => error
+vesan:	loop	_vesa1			# Next mode. Limit exceeded => error
 vesae:	leaw	vesaer, %si
 	call	prtstr
 	movw	%bp, %di			# Discard already found modes.
 vesar:	popw	%gs
 	ret
 
+_vesa1:	jmp	vesa1		# may not always reach
+
 # Dimensions of standard VESA text modes
 vesa_text_mode_table:
 	.byte	60, 80				# 0108
===============================================================================

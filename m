Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271343AbTHDAsv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 20:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271352AbTHDAsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 20:48:51 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:62045 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S271343AbTHDAsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 20:48:45 -0400
Message-ID: <3F2DAD6D.2010605@telefabel.cjb.net>
Date: Mon, 04 Aug 2003 02:48:45 +0200
From: Sander ten Broek <sander@telefabel.cjb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030711
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, riley@williams.name, kraxel@bytesex.org
Subject: [PATCH] Use EDID/DDC data to set better refreshrates on VBE3.0+ videocards
 on boot
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch requests EDID data from the monitor/graphics card, 
check it against the vga= setting the user set and when it finds a match 
sets the refresh rate to the EDID supplied mode (So should be safe, even 
on broken biosses). This makes working in vesafb mode _allot_ better for 
your eyes. If either no vesa 3.0 card or VBE/DC EDID data is available 
it just sets the vesa graphic mode the old tried and tested way (60Hz ugh!).

I have tested the patch on the following cards with different feature 
support (All same type monitor though):

- Geforce2 MX/MX 400: Working at 85hz
- Geforce 256 SDR: Working at 85Hz
- GeForce2 - nForce GPU: Not working, no EDID data available
- VMWare v4: Not working, not a VBE v3.00 card

Not working, in this case, means that it just used normal 60hz vesa 
mode. The graphic mode was otherwise working fine.

What do you think? :)

Other patches:
http://nitrate.et.tudelft.nl/~sander/patches/linux-2.4.20-vesa-edid.patch
http://nitrate.et.tudelft.nl/~sander/patches/linux-2.6.0-test2-vesa-edid.patch

Patch for v2.4.20 and v2.4.21 (the same):

--- Documentation/fb/vesafb.txt.orig	2003-08-03 16:05:25.000000000 +0200
+++ Documentation/fb/vesafb.txt	2003-08-03 16:14:38.000000000 +0200
@@ -97,11 +97,17 @@
 
  * configure and load the DOS-Tools for your the graphics board (if
    available) and boot linux with loadlin.
- * use a native driver (matroxfb/atyfb) instead if vesafb.  If none
+ * use a native driver (matroxfb/atyfb) instead of vesafb.  If none
    is available, write a new one!
- * VBE 3.0 might work too.  I have neither a gfx board with VBE 3.0
-   support nor the specs, so I have not checked this yet.
 
+If you have a VBE 3.0 card and your monitor and graphic card combination
+support VBE/DC, linux will attempt to set the monitor supplied refresh
+rates before linux is loaded. This will happen automagicly when you supply 
+your kernel with a vga= option. If this for some reason fails and leaves 
+you stuck with 60 Hz, you can use read-edid (1) to see if and what modes 
+your monitor reports to the kernel. 
+
+(1) http://tcsu.trin.cam.ac.uk/~john/programs/linux/read-edid/
 
 Configuration
 =============
--- arch/i386/boot/video.S.orig	2003-08-03 13:31:47.000000000 +0200
+++ arch/i386/boot/video.S	2003-08-03 13:33:40.000000000 +0200
@@ -19,6 +19,13 @@
 /* Enable autodetection of VESA modes */
 #define CONFIG_VIDEO_VESA
 
+/* Enable setting better monitor timings when using a VESA v3 videocard */
+#ifndef CONFIG VIDEO_VESA
+# undef CONFIG_VIDEO_VESA_TIMINGS
+#elseif
+# define CONFIG_VIDEO_VESA_TIMINGS
+#endif
+
 /* Enable compacting of mode table */
 #define CONFIG_VIDEO_COMPACT
 
@@ -453,7 +460,7 @@
 	
 	cmpb	$VIDEO_FIRST_V7>>8, %ah
 	jz	setv7
-	
+ 
 	cmpb	$VIDEO_FIRST_VESA>>8, %ah
 	jnc	check_vesa
 	
@@ -549,6 +556,133 @@
 	jnz	_setbad				# Doh! No linear frame buffer.
 
 	subb	$VIDEO_FIRST_VESA>>8, %bh
+
+#ifdef CONFIG_VIDEO_VESA_TIMINGS 
+
+	movw	%di, %si			# need resolution info later
+	
+	leaw    modelist+512, %di		# using 512b temporary space
+
+	movw	0x02B3, %ax
+	movw	%ax, (%di)
+	movw	0x9D4A, %ax
+	movw	%ax, 2(%di)			# set signature to "vbe2"
+
+	movw    $0x4f00, %ax
+	int     $0x10
+
+	cmpw	$0x004f, %ax
+	jne	bios_def_tim
+
+	cmpw	$0x300, 4(%di)	
+	jne	bios_def_tim			# no vesa v3+, so no timings support
+
+	pusha
+
+	call	store_edid
+
+	leaw	modelist+2102, %di		# point to monitor detailed timing (2048+0x36)
+
+	movw	$5, %cx
+chk_vactive:
+	movb	7(%di), %ah
+	shrb	$4, %ah
+	movb	5(%di), %al
+
+	cmpw	20(%si), %ax			# check against vactive
+	je	chk_hactive			# is the vertical resolution the same?
+
+	addw	$0x12, %di
+	decw	%cx
+	jnz	chk_vactive
+
+	#failed
+
+	popa
+	jmp	bios_def_tim			# our mode is not there :(
+
+chk_hactive:
+	movb	4(%di), %ah
+	shrb	$4, %ah
+	movb	2(%di), %al
+	
+	cmpw	18(%si), %ax
+	je	calc_timings			# we have a winner
+
+	addw	$0x12, %di
+	decw	%cx
+	jnz	chk_vactive
+
+	#definatly failed
+	popa
+	jmp	bios_def_tim
+
+calc_timings: # (%ax has hactive) 
+
+	movb	4(%di), %dh			# get hblanking
+	andb	$15, %dh
+	movb	3(%di), %dl
+	addw	%ax, %dx			# hactive + hblanking
+	movw	%dx, htotal
+
+	movb	11(%di), %dh			# get hsync_offset
+	shrw	$6, %dx
+	movb	8(%di), %dl
+	addw	%ax, %dx			# hactive + hsync_offset
+
+	movw	%dx, hsyncstart
+
+	movb	11(%di), %ah			# get hsync_width (%dx holds hsyncstart)
+	andb	$48, %ah
+	shrb	$4, %ah
+	movb	9(%di), %al
+	addw	%dx, %ax			# hsyncstart + hsync_width
+	movw	%ax, hsyncend
+
+	movw	20(%si), %ax			# move in vactive
+
+	movb	7(%di), %dh			# get vblanking
+	andb	$15, %dh
+	movb	6(%di), %dl
+	addw	%ax, %dx			# vactive + vblanking
+	movw	%dx, vtotal
+
+	movb	11(%di), %dh			# get vsync start
+	andb	$12, %dh
+	shrb	$2, %dh
+	movb	10(%di), %dl		
+	shrb	$4, %dl
+	addw	%ax, %dx			# vactive + voffset
+	movw	%dx, vsyncstart
+
+	movb	11(%di), %ah			# get vsync width (%dx holds sycnstart)
+	andb	$3, %ah
+	movb	10(%di), %al
+	andb	$15, %al
+	addw	%dx, %ax
+	movw	%ax, vsyncend	
+
+	movw	(%di), %ax			# get pixclock 
+	imul	$10000, %eax, %eax
+	movl	%eax, pixelclock 
+		
+	#todo: refreshrate ( pixelclock / ( htotal * vtotal ) * 100 ), unused? 
+	
+	movb	17(%di), %al
+	testb	$127, %al				# interlaced mode?
+	jnz	vbe_supplied_tim		
+
+	movb	$127, monflags
+
+vbe_supplied_tim:	
+	popa
+
+	leaw	crtcinfoblock, %di		
+	orw	$0x0800, %bx			# we got our own timing...
+bios_def_tim:
+
+#endif /* CONFIG_VIDEO_VESA_TIMINGS */
+
 	orw	$0x4000, %bx			# Use linear frame buffer
 	movw	$0x4f02, %ax			# VESA BIOS mode set call
 	int	$0x10
@@ -1884,6 +2018,29 @@
 	popw	%ax
 	ret
 
+store_edid:
+
+	pusha
+
+	movw	$0x1313, %ax
+	movw	$64, %cx
+	leaw	modelist+2048, %di
+	rep	stosw
+
+	leaw	modelist+2048, %di
+
+	movw	$0x4f15, %ax
+	movw	$0x01, %bx
+	movw	%bx, %dx
+	xorw	%cx, %cx
+	int	$0x10
+
+	popa
+
+	ret
+
+	
+
 # VIDEO_SELECT-only variables
 mt_end:		.word	0	# End of video mode table if built
 edit_buf:	.space	6	# Line editor buffer
@@ -1932,3 +2089,19 @@
 adapter:	.byte	0	# Video adapter: 0=CGA/MDA/HGA,1=EGA,2=VGA
 video_segment:	.word	0xb800	# Video memory segment
 force_size:	.word	0	# Use this size instead of the one in BIOS vars
+
+#ifdef CONFIG_VIDEO_VESA_TIMINGS
+
+crtcinfoblock: /* going to be written by vbe/dc code */
+htotal: 	.word	0
+hsyncstart: 	.word	0
+hsyncend: 	.word	0
+vtotal: 	.word	0
+vsyncstart: 	.word	0
+vsyncend: 	.word	0
+monflags: 	.byte	0
+pixelclock: 	.long	0
+refreshrate: 	.word	0
+filler: 	.space  40
+
+#endif /* CONFIG_VIDEO_VESA_TIMINGS








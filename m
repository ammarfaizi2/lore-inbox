Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314516AbSEBO5H>; Thu, 2 May 2002 10:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314526AbSEBO5G>; Thu, 2 May 2002 10:57:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10601 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314516AbSEBO4S>; Thu, 2 May 2002 10:56:18 -0400
To: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.12] x86 Boot enhancements, bzImage/zImage code differentiation  3/11
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org>
	<m1wuumy5eo.fsf@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 May 2002 08:48:27 -0600
Message-ID: <m1sn5ay5ac.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply

Differentiate the code that is needed in setup.S for zImage and bzImages.

Eric

diff -uNr linux-2.5.12.boot.vmlinuxlds/arch/i386/boot/setup.S linux-2.5.12.boot.spring-cleaning/arch/i386/boot/setup.S
--- linux-2.5.12.boot.vmlinuxlds/arch/i386/boot/setup.S	Mon Apr 29 00:17:11 2002
+++ linux-2.5.12.boot.spring-cleaning/arch/i386/boot/setup.S	Wed May  1 09:38:54 2002
@@ -166,7 +166,12 @@
 # End of setup header #####################################################
 
 start_of_setup:
+#ifndef __BIG_KERNEL__
 # Bootlin depends on this being done early
+#NOTE:  Bootlin was written before the kernel had hooks for anything
+# 	used the BIOS calls setup.S made as hooks (ouch!)
+#       Bootlin only loaded zImages, so we can drop support for it
+#       when we are loading a bzImage.
 	movw	$0x01500, %ax
 	movb	$0x81, %dl
 	int	$0x13
@@ -177,6 +182,7 @@
 	movb	$0x80, %dl
 	int	$0x13
 #endif
+#endif /* __BIG_KERNEL__ */
 
 # Set %ds = %cs, we know that SETUPSEG = %cs at this point
 	movw	%cs, %ax		# aka SETUPSEG
@@ -226,6 +232,7 @@
 
 # We now have to find the rest of the setup code/data
 bad_sig:
+#ifndef __BIG_KERNEL__
 	movw	%cs, %ax			# SETUPSEG
 	subw	$DELTA_INITSEG, %ax		# INITSEG
 	movw	%ax, %ds
@@ -255,7 +262,7 @@
 	jne	no_sig
 
 	jmp	good_sig
-
+#endif /* __BIG_KERNEL__ */
 no_sig:
 	lea	no_sig_mess, %si
 	call	prtstr
@@ -268,10 +275,8 @@
 	movw	%cs, %ax			# aka SETUPSEG
 	subw	$DELTA_INITSEG, %ax 		# aka INITSEG
 	movw	%ax, %ds
+#ifdef __BIG_KERNEL__
 # Check if an old loader tries to load a big-kernel
-	testb	$LOADED_HIGH, %cs:loadflags	# Do we have a big kernel?
-	jz	loader_ok			# No, no danger for old loaders.
-
 	cmpb	$0, %cs:type_of_loader 		# Do we have a loader that
 						# can deal with us?
 	jnz	loader_ok			# Yes, continue.
@@ -284,6 +289,7 @@
 	jmp	no_sig_loop
 
 loader_panic_mess: .string "Wrong loader, giving up..."
+#endif /* __BIG_KERNEL__ */
 
 loader_ok:
 # Get memory size (extended mem, kB)
@@ -561,15 +567,8 @@
 	movl	%cs:code32_start, %eax
 	movl	%eax, %cs:code32
 
-# Now we move the system to its rightful place ... but we check if we have a
-# big-kernel. In that case we *must* not move it ...
-	testb	$LOADED_HIGH, %cs:loadflags
-	jz	do_move0			# .. then we have a normal low
-						# loaded zImage
-						# .. or else we have a high
-						# loaded bzImage
-	jmp	end_move			# ... and we skip moving
-
+#ifndef __BIG_KERNEL__
+# Move the kernel image where it expects to be loaded.
 do_move0:
 	movw	$0x100, %ax			# start of destination segment
 	movw	%cs, %bp			# aka SETUPSEG
@@ -595,6 +594,8 @@
 	jb	do_move
 
 end_move:
+#endif /* !__BIG_KERNEL__ */
+	
 # then we load the segment descriptors
 	movw	%cs, %ax			# aka SETUPSEG
 	movw	%ax, %ds

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310241AbSDQQ61>; Wed, 17 Apr 2002 12:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310258AbSDQQ60>; Wed, 17 Apr 2002 12:58:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16718 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310241AbSDQQ6Y>; Wed, 17 Apr 2002 12:58:24 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 boot enhancements, dead code elimination 3/11
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Apr 2002 10:51:07 -0600
Message-ID: <m1zo02gtfo.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus please apply,


Some pieces of code only make sense if we are a bzImage or
a zImage.  Since size is relatively important use conditional
compilation to select between the two.

Plus this clearly marks dead code that we can kill we we drop
support for the zImage format.

Eric

diff -uNr linux-2.5.8.boot.footprint/arch/i386/boot/setup.S linux-2.5.8.boot.spring-cleaning/arch/i386/boot/setup.S
--- linux-2.5.8.boot.footprint/arch/i386/boot/setup.S	Tue Apr 16 13:21:40 2002
+++ linux-2.5.8.boot.spring-cleaning/arch/i386/boot/setup.S	Tue Apr 16 13:39:26 2002
@@ -177,7 +177,12 @@
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
@@ -188,6 +193,7 @@
 	movb	$0x80, %dl
 	int	$0x13
 #endif
+#endif /* __BIG_KERNEL__ */
 
 # Set %ds = %cs, we know that SETUPSEG = %cs at this point
 	movw	%cs, %ax		# aka SETUPSEG
@@ -237,6 +243,7 @@
 
 # We now have to find the rest of the setup code/data
 bad_sig:
+#ifndef __BIG_KERNEL__
 	movw	%cs, %ax			# SETUPSEG
 	subw	$DELTA_INITSEG, %ax		# INITSEG
 	movw	%ax, %ds
@@ -266,7 +273,7 @@
 	jne	no_sig
 
 	jmp	good_sig
-
+#endif /* __BIG_KERNEL__ */
 no_sig:
 	lea	no_sig_mess, %si
 	call	prtstr
@@ -279,10 +286,8 @@
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
@@ -295,6 +300,7 @@
 	jmp	no_sig_loop
 
 loader_panic_mess: .string "Wrong loader, giving up..."
+#endif /* __BIG_KERNEL__ */
 
 loader_ok:
 # Get base memory size
@@ -581,15 +587,8 @@
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
@@ -615,6 +614,8 @@
 	jb	do_move
 
 end_move:
+#endif /* !__BIG_KERNEL__ */
+	
 # then we load the segment descriptors
 	movw	%cs, %ax			# aka SETUPSEG
 	movw	%ax, %ds

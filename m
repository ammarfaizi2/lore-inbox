Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264429AbUEEI55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbUEEI55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 04:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbUEEI55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 04:57:57 -0400
Received: from everest.2mbit.com ([24.123.221.2]:61651 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S264429AbUEEI5s (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 May 2004 04:57:48 -0400
Message-ID: <4098AC80.8030607@greatcn.org>
Date: Wed, 05 May 2004 16:57:36 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel@vger.kernel.org
CC: akpm@osdl.org
References: <4087DFEC.60704@greatcn.org>
In-Reply-To: <4087DFEC.60704@greatcn.org>
X-Scan-Signature: 788d58d58ee3d9945c92af1f5af9dfd6
X-SA-Exim-Connect-IP: 218.24.176.243
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH] Remove bootsect_helper on x86_64 and pc98
Content-Type: multipart/mixed;
 boundary="------------090706030909090501030609"
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.0 (built Tue, 16 Mar 2004 14:56:42 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090706030909090501030609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Coywolf Qi Hunt wrote:

> Since "Direct booting from floppy is no longer supported", this patch is
> to remove the bootsect_helper code. And also a comment fix.
>
> The other two platforms x86_64 and PC-9800 should also be cleaned up too.

The same patches for x86_64 and pc98 enclosed.

-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org


--------------090706030909090501030609
Content-Type: text/plain;
 name="remove-bootsect_helper-x86_64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove-bootsect_helper-x86_64.patch"

--- linux-2.6.5/arch/x86_64/boot/setup.S	Mon Mar  8 10:30:36 2004
+++ linux/arch/x86_64/boot/setup.S	Mon May  3 09:31:58 2004
@@ -132,7 +132,7 @@
 ramdisk_size:	.long	0		# its size in bytes
 
 bootsect_kludge:
-		.word  bootsect_helper, SETUPSEG
+		.long	0		# obsolete
 
 heap_end_ptr:	.word	modelist+1024	# (Header version 0x0201 or later)
 					# space from here (exclusive) down to
@@ -757,87 +757,6 @@
 	outb	%al, $0x70
 	lret
 
-# This routine only gets called, if we get loaded by the simple
-# bootsect loader _and_ have a bzImage to load.
-# Because there is no place left in the 512 bytes of the boot sector,
-# we must emigrate to code space here.
-bootsect_helper:
-	cmpw	$0, %cs:bootsect_es
-	jnz	bootsect_second
-
-	movb	$0x20, %cs:type_of_loader
-	movw	%es, %ax
-	shrw	$4, %ax
-	movb	%ah, %cs:bootsect_src_base+2
-	movw	%es, %ax
-	movw	%ax, %cs:bootsect_es
-	subw	$SYSSEG, %ax
-	lret					# nothing else to do for now
-
-bootsect_second:
-	pushw	%cx
-	pushw	%si
-	pushw	%bx
-	testw	%bx, %bx			# 64K full?
-	jne	bootsect_ex
-
-	movw	$0x8000, %cx			# full 64K, INT15 moves words
-	pushw	%cs
-	popw	%es
-	movw	$bootsect_gdt, %si
-	movw	$0x8700, %ax
-	int	$0x15
-	jc	bootsect_panic			# this, if INT15 fails
-
-	movw	%cs:bootsect_es, %es		# we reset %es to always point
-	incb	%cs:bootsect_dst_base+2		# to 0x10000
-bootsect_ex:
-	movb	%cs:bootsect_dst_base+2, %ah
-	shlb	$4, %ah				# we now have the number of
-						# moved frames in %ax
-	xorb	%al, %al
-	popw	%bx
-	popw	%si
-	popw	%cx
-	lret
-
-bootsect_gdt:
-	.word	0, 0, 0, 0
-	.word	0, 0, 0, 0
-
-bootsect_src:
-	.word	0xffff
-
-bootsect_src_base:
-	.byte	0x00, 0x00, 0x01		# base = 0x010000
-	.byte	0x93				# typbyte
-	.word	0				# limit16,base24 =0
-
-bootsect_dst:
-	.word	0xffff
-
-bootsect_dst_base:
-	.byte	0x00, 0x00, 0x10		# base = 0x100000
-	.byte	0x93				# typbyte
-	.word	0				# limit16,base24 =0
-	.word	0, 0, 0, 0			# BIOS CS
-	.word	0, 0, 0, 0			# BIOS DS
-
-bootsect_es:
-	.word	0
-
-bootsect_panic:
-	pushw	%cs
-	popw	%ds
-	cld
-	leaw	bootsect_panic_mess, %si
-	call	prtstr
-	
-bootsect_panic_loop:
-	jmp	bootsect_panic_loop
-
-bootsect_panic_mess:
-	.string	"INT15 refuses to access high mem, giving up."
 
 # This routine checks that the keyboard command queue is empty
 # (after emptying the output buffers)

--------------090706030909090501030609
Content-Type: text/plain;
 name="remove-bootsect_helper-pc98.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove-bootsect_helper-pc98.patch"

--- linux-2.6.5/arch/i386/boot98/setup.S	Wed Feb 18 11:57:15 2004
+++ linux/arch/i386/boot98/setup.S	Mon May  3 09:39:29 2004
@@ -146,7 +146,7 @@
 ramdisk_size:	.long	0		# its size in bytes
 
 bootsect_kludge:
-		.word  bootsect_helper, SETUPSEG
+		.long	0		# obsolete
 
 heap_end_ptr:	.word	modelist+1024	# (Header version 0x0201 or later)
 					# space from here (exclusive) down to
@@ -691,91 +691,6 @@
 						# sequence
 	lret
 
-# This routine only gets called, if we get loaded by the simple
-# bootsect loader _and_ have a bzImage to load.
-# Because there is no place left in the 512 bytes of the boot sector,
-# we must emigrate to code space here.
-bootsect_helper:
-	cmpw	$0, %cs:bootsect_es
-	jnz	bootsect_second
-
-	movb	$0x20, %cs:type_of_loader
-	movw	%es, %ax
-	shrw	$4, %ax
-	movb	%ah, %cs:bootsect_src_base+2
-	movw	%es, %ax
-	movw	%ax, %cs:bootsect_es
-	subw	$SYSSEG, %ax
-	lret					# nothing else to do for now
-
-bootsect_second:
-	pushw	%bx
-	pushw	%cx
-	pushw	%si
-	pushw	%di
-	testw	%bp, %bp			# 64K full ?
-	jne	bootsect_ex
-
-	xorw	%cx, %cx			# zero means full 64K
-	pushw	%cs
-	popw	%es
-	movw	$bootsect_gdt, %bx
-	xorw	%si, %si			# source address
-	xorw	%di, %di			# destination address
-	movb	$0x90, %ah
-	int	$0x1f
-	jc	bootsect_panic			# this, if INT1F fails
-
-	movw	%cs:bootsect_es, %es		# we reset %es to always point
-	incb	%cs:bootsect_dst_base+2		# to 0x10000
-bootsect_ex:
-	movb	%cs:bootsect_dst_base+2, %ah
-	shlb	$4, %ah				# we now have the number of
-						# moved frames in %ax
-	xorb	%al, %al
-	popw	%di
-	popw	%si
-	popw	%cx
-	popw	%bx
-	lret
-
-bootsect_gdt:
-	.word	0, 0, 0, 0
-	.word	0, 0, 0, 0
-
-bootsect_src:
-	.word	0xffff
-
-bootsect_src_base:
-	.byte	0x00, 0x00, 0x01		# base = 0x010000
-	.byte	0x93				# typbyte
-	.word	0				# limit16,base24 =0
-
-bootsect_dst:
-	.word	0xffff
-
-bootsect_dst_base:
-	.byte	0x00, 0x00, 0x10		# base = 0x100000
-	.byte	0x93				# typbyte
-	.word	0				# limit16,base24 =0
-	.word	0, 0, 0, 0			# BIOS CS
-	.word	0, 0, 0, 0			# BIOS DS
-
-bootsect_es:
-	.word	0
-
-bootsect_panic:
-	pushw	%cs
-	popw	%ds
-	cld
-	leaw	bootsect_panic_mess, %si
-	call	prtstr
-
-bootsect_panic_loop:
-	jmp	bootsect_panic_loop
-
-bootsect_panic_mess:
-	.string	"INT1F refuses to access high mem, giving up."
 
 # This routine prints one character (in %al) on console.
 # PC-9800 doesn't have BIOS-function to do it like IBM PC's INT 10h - 0Eh,

--------------090706030909090501030609--

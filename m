Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUDVPJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUDVPJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264112AbUDVPJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:09:23 -0400
Received: from everest.2mbit.com ([24.123.221.2]:64461 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S264097AbUDVPJS (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:09:18 -0400
Message-ID: <4087DFEC.60704@greatcn.org>
Date: Thu, 22 Apr 2004 23:08:28 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hpa@zytor.com, davej@codemonkey.org.uk
CC: Linux-Kernel@vger.kernel.org, kernel-janitors@osdl.org
X-Scan-Signature: 4f1f009c37df0ac1e6740cb932197d8b
X-SA-Exim-Connect-IP: 218.24.188.23
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH] Remove bootsect_helper and A comment fix (III)
Content-Type: multipart/mixed;
 boundary="------------090207090907090703020103"
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.0 (built Tue, 16 Mar 2004 14:56:42 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090207090907090703020103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Since "Direct booting from floppy is no longer supported", this patch is
to remove the bootsect_helper code. And also a comment fix.

Wish my patch is in correct format this time. The other two platforms 
x86_64 and PC-9800 should also be cleaned up too.


-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

--------------090207090907090703020103
Content-Type: text/plain;
 name="patch-040422a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-040422a.diff"

--- arch/i386/boot/setup.S.orig	Sat Mar  6 23:49:33 2004
+++ arch/i386/boot/setup.S	Sun Mar  7 04:38:08 2004
@@ -133,7 +133,7 @@
 ramdisk_size:	.long	0		# its size in bytes
 
 bootsect_kludge:
-		.word  bootsect_helper, SETUPSEG
+		.long	0		# obsolete
 
 heap_end_ptr:	.word	modelist+1024	# (Header version 0x0201 or later)
 					# space from here (exclusive) down to
@@ -837,7 +837,7 @@
 	subw	$DELTA_INITSEG, %si
 	shll	$4, %esi			# Convert to 32-bit pointer
 
-# jump to startup_32 in arch/i386/kernel/head.S
+# jump to startup_32 in arch/i386/boot/compressed/head.S
 #	
 # NOTE: For high loaded big kernels we need a
 #	jmpi    0x100000,__BOOT_CS
@@ -871,88 +871,6 @@
 						# sequence
 	outb	%al, $0x70
 	lret
-
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
 
 
 #ifndef CONFIG_X86_VOYAGER

--------------090207090907090703020103--

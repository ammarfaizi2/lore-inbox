Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUBWQWB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUBWQWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:22:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261957AbUBWQV4
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:21:56 -0500
Date: Mon, 23 Feb 2004 11:21:47 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Coywolf Qi Hunt <coywolf@greatcn.org>
cc: tao@acc.umu.se, alan@lxorguk.ukuu.org.uk,
       Linux kernel <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix GDT limit in setup.S for 2.0 and 2.2
In-Reply-To: <Pine.LNX.4.53.0402231012590.8959@chaos>
Message-ID: <Pine.LNX.4.53.0402231114150.505@chaos>
References: <403114D9.2060402@lovecn.org> <403A07D8.5050704@greatcn.org>
 <Pine.LNX.4.53.0402230933190.8770@chaos> <Pine.LNX.4.53.0402231012590.8959@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



If you are going to muck with the startup code, I suggest this:

--- linux-2.4.24/arch/i386/boot/setup.S.orig	Mon Feb 23 10:34:11 2004
+++ linux-2.4.24/arch/i386/boot/setup.S	Mon Feb 23 11:07:09 2004
@@ -822,12 +822,16 @@
 a20_done:

 # set up gdt and idt
+	movl	$idt_48,%eax			# End of GDT
+	subl	$gdt, %eax			# Subtract beginning
+	decl	%eax				# One less
+	movw	%ax, (gdt_48)			# Length of the table
 	lidt	idt_48				# load idt with 0,0
 	xorl	%eax, %eax			# Compute gdt_base
 	movw	%ds, %ax			# (Convert %ds:gdt to a linear ptr)
 	shll	$4, %eax
 	addl	$gdt, %eax
-	movl	%eax, (gdt_48+2)
+	movl	%eax, (gdt_lo)
 	lgdt	gdt_48				# load gdt with whatever is
 						# appropriate

@@ -1080,8 +1084,11 @@
 delay:
 	outb	%al,$0x80
 	ret
-
-# Descriptor tables
+#
+# Descriptor tables, note that more entries will be entered when the
+# kernel starts. However, we do not want to load tables that don't
+# exist at this time!
+#
 gdt:
 	.word	0, 0, 0, 0			# dummy
 	.word	0, 0, 0, 0			# unused
@@ -1100,11 +1107,12 @@
 idt_48:
 	.word	0				# idt limit = 0
 	.word	0, 0				# idt base = 0L
-gdt_48:
-	.word	0x8000				# gdt limit=2048,
-						#  256 GDT entries
-
-	.word	0, 0				# gdt base (filled in later)
+#
+#	Filled in by startup code around label a20_done.
+#
+gdt_48:	.word	0				# Length of GDT -1
+gdt_lo:	.word	0				# GDT base low word
+gdt_hi:	.word	0				# GDT base high word

 # Include video setup & detection code


FYI, this machine is running with that change. The current
code loads a discriptor table with a (non-existant) length
of 0x8000 (plus a byte) bytes. For some reason, it's lucky.

Later on, more entries are added and the new table is loaded
with another LGDT instruction, fine. But, in the existing
code, any "entries" after those shown are video setup code.

The correct code will load the correct table length, not some
length that might be used in the future.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



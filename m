Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTLCWbn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 17:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTLCW3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 17:29:02 -0500
Received: from aun.it.uu.se ([130.238.12.36]:33985 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262038AbTLCW2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 17:28:51 -0500
Date: Wed, 3 Dec 2003 23:28:41 +0100 (MET)
Message-Id: <200312032228.hB3MSf92023850@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.23] fix reboot/no_idt bug
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling 2.4.23 with gcc-3.3.2, gcc generates the
following warning for arch/i386/kernel/process.c:

process.c: In function `machine_restart':
process.c:427: warning: use of memory input without lvalue in asm operand 0 is deprecated

The warning identifies a real bug. no_idt is passed to
lidt with an "m" constraint, which requires an l-value.
Since no_idt is faked as an array, gcc creates an anonymous
variable pointing to no_idt and passes that to lidt(*),
so at runtime lidt sees the wrong address. Not good.
(The bug, while real, is unlikely to trigger since it
sits in an infrequently used path in the reboot code.)

The fix is to make no_idt a struct (and thus an l-lvalue)
like the other gdt/idt descriptors.

This patch is a backport of the fix Linus made for the
same bug in 2.6.0-test4.

[Andi: x86-64 appears to have the same bug]

(*) Verified by inspection of the assembly code.

/Mikael

diff -ruN linux-2.4.23/arch/i386/kernel/process.c linux-2.4.23.no_idt-fix/arch/i386/kernel/process.c
--- linux-2.4.23/arch/i386/kernel/process.c	2003-11-29 00:28:10.000000000 +0100
+++ linux-2.4.23.no_idt-fix/arch/i386/kernel/process.c	2003-12-03 20:20:58.000000000 +0100
@@ -153,7 +153,6 @@
 
 __setup("idle=", idle_setup);
 
-static long no_idt[2];
 static int reboot_mode;
 int reboot_thru_bios;
 
@@ -224,7 +223,8 @@
 	unsigned long long * base __attribute__ ((packed));
 }
 real_mode_gdt = { sizeof (real_mode_gdt_entries) - 1, real_mode_gdt_entries },
-real_mode_idt = { 0x3ff, 0 };
+real_mode_idt = { 0x3ff, 0 },
+no_idt = { 0, 0 };
 
 /* This is 16-bit protected mode code to disable paging and the cache,
    switch to real mode and jump to the BIOS reset code.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbTIDTox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265491AbTIDTow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:44:52 -0400
Received: from sponsa.its.uu.se ([130.238.7.36]:65206 "EHLO sponsa.its.uu.se")
	by vger.kernel.org with ESMTP id S265298AbTIDTov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:44:51 -0400
Date: Thu, 4 Sep 2003 21:44:39 +0200 (MEST)
Message-Id: <200309041944.h84JidWc028949@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.23-pre3] fix two gcc-3.3.1 warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sent to Marcelo, forgot to cc: LKML]

This patch fixes two sources of gcc-3.3.1 warnings in 2.4.23-pre3:
- a non-lvalue in an asm() memory operand in arch/i386/kernel/process.c
- invalid tokens after #endif in arch/i386/kernel/head.S

The first is because no_ldt is defined as an array, and is thus
not an lvalue as required for an asm() memory operand. Fixed by
wrapping it in a struct -- this is similar to what 2.6 does.

gcc -D__KERNEL__ -I/tmp/linux-2.4.23-pre3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=process  -c -o process.o process.c
process.c: In function `machine_restart':
process.c:427: warning: use of memory input without lvalue in asm operand 0 is deprecated

gcc -D__ASSEMBLY__ -D__KERNEL__ -I/tmp/linux-2.4.23-pre3/include -traditional -c head.S -o head.o
head.S:116: warning: extra tokens at end of #endif directive

/Mikael

diff -ruN linux-2.4.23-pre3/arch/i386/kernel/head.S linux-2.4.23-pre3.gcc-fixes/arch/i386/kernel/head.S
--- linux-2.4.23-pre3/arch/i386/kernel/head.S	2003-09-04 18:53:59.000000000 +0200
+++ linux-2.4.23-pre3.gcc-fixes/arch/i386/kernel/head.S	2003-09-04 19:01:04.000000000 +0200
@@ -113,7 +113,7 @@
 	popfl
 	jmp checkCPUtype
 1:
-#endif CONFIG_SMP
+#endif /* CONFIG_SMP */
 
 /*
  * Clear BSS first so that there are no surprises...
diff -ruN linux-2.4.23-pre3/arch/i386/kernel/process.c linux-2.4.23-pre3.gcc-fixes/arch/i386/kernel/process.c
--- linux-2.4.23-pre3/arch/i386/kernel/process.c	2003-09-04 18:53:59.000000000 +0200
+++ linux-2.4.23-pre3.gcc-fixes/arch/i386/kernel/process.c	2003-09-04 19:01:04.000000000 +0200
@@ -152,7 +152,7 @@
 
 __setup("idle=", idle_setup);
 
-static long no_idt[2];
+static struct { long x[2]; } no_idt;
 static int reboot_mode;
 int reboot_thru_bios;
 

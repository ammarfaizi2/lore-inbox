Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271567AbTGRJmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271486AbTGRJlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:41:47 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:26351 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S271517AbTGRJa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:30:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  On v850, use a long jump to start_kernel
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030718094540.6B9EA3702@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 18 Jul 2003 18:45:40 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This allows the low-level start code to be located far away from the
rest of the kernel, which is sometimes necessary.

diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/head.S linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/head.S
--- linux-2.6.0-test1-moo/arch/v850/kernel/head.S	2003-06-16 14:52:16.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/head.S	2003-07-15 19:06:36.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/head.S -- Lowest-level startup code
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -115,7 +115,14 @@
 	jarl	CSYM(memset), lp
 #endif
 
-	// Start Linux kernel.
+	// What happens if the main kernel function returns (it shouldn't)
 	mov	hilo(CSYM(machine_halt)), lp
-	jr	CSYM(start_kernel)
+
+	// Start the linux kernel.  We use an indirect jump to get extra
+	// range, because on some platforms this initial startup code
+	// (and the associated platform-specific code in mach_early_init)
+	// are located far away from the main kernel, e.g. so that they
+	// can initialize RAM first and copy the kernel or something.
+	mov	hilo(CSYM(start_kernel)), r12
+	jmp	[r12]
 C_END(start)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVHYF0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVHYF0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVHYFVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:21:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:204 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751543AbVHYFVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:21:31 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (11/22) memory input should be an lvalue (mac/misc.c)
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AE8-0005cZ-DC@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:24:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc4 is less forgiving and wants memory inputs to be real lvalues; variable
added and value stored in it explicitly before doing __asm__.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-scc/arch/m68k/mac/misc.c RC13-rc7-m68k-reset/arch/m68k/mac/misc.c
--- RC13-rc7-scc/arch/m68k/mac/misc.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-m68k-reset/arch/m68k/mac/misc.c	2005-08-25 00:54:12.000000000 -0400
@@ -466,12 +466,13 @@
 		/* make a 1-to-1 mapping, using the transparent tran. reg. */
 		unsigned long virt = (unsigned long) mac_reset;
 		unsigned long phys = virt_to_phys(mac_reset);
+		unsigned long addr = (phys&0xFF000000)|0x8777;
 		unsigned long offset = phys-virt;
 		local_irq_disable(); /* lets not screw this up, ok? */
 		__asm__ __volatile__(".chip 68030\n\t"
 				     "pmove %0,%/tt0\n\t"
 				     ".chip 68k"
-				     : : "m" ((phys&0xFF000000)|0x8777));
+				     : : "m" (addr));
 		/* Now jump to physical address so we can disable MMU */
 		__asm__ __volatile__(
                     ".chip 68030\n\t"

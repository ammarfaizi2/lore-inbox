Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbUKKJgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUKKJgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 04:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbUKKJgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 04:36:48 -0500
Received: from aun.it.uu.se ([130.238.12.36]:28323 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262193AbUKKJfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 04:35:34 -0500
Date: Thu, 11 Nov 2004 10:35:27 +0100 (MET)
Message-Id: <200411110935.iAB9ZRAJ028747@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc1-mm4][1/4] perfctr x86 core updates
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 1/4 of the perfctr interrupt fixes:
- Move perfctr_suspend_thread() call from __switch_to()
  to the beginning of switch_to(). Ensures that suspend
  actions are done when the owner task still is 'current'.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/i386/kernel/process.c |    2 --
 include/asm-i386/system.h  |    1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff -rupN linux-2.6.10-rc1-mm4/arch/i386/kernel/process.c linux-2.6.10-rc1-mm4.perfctr-x86-core-update/arch/i386/kernel/process.c
--- linux-2.6.10-rc1-mm4/arch/i386/kernel/process.c	2004-11-10 18:02:47.000000000 +0100
+++ linux-2.6.10-rc1-mm4.perfctr-x86-core-update/arch/i386/kernel/process.c	2004-11-11 00:19:11.294844304 +0100
@@ -600,8 +600,6 @@ struct task_struct fastcall * __switch_t
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
-	perfctr_suspend_thread(prev);
-
 	__unlazy_fpu(prev_p);
 
 	/*
diff -rupN linux-2.6.10-rc1-mm4/include/asm-i386/system.h linux-2.6.10-rc1-mm4.perfctr-x86-core-update/include/asm-i386/system.h
--- linux-2.6.10-rc1-mm4/include/asm-i386/system.h	2004-10-28 19:28:41.000000000 +0200
+++ linux-2.6.10-rc1-mm4.perfctr-x86-core-update/include/asm-i386/system.h	2004-11-11 00:19:39.000000000 +0100
@@ -14,6 +14,7 @@ extern struct task_struct * FASTCALL(__s
 
 #define switch_to(prev,next,last) do {					\
 	unsigned long esi,edi;						\
+	perfctr_suspend_thread(&(prev)->thread);			\
 	asm volatile("pushfl\n\t"					\
 		     "pushl %%ebp\n\t"					\
 		     "movl %%esp,%0\n\t"	/* save ESP */		\

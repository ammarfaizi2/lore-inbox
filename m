Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWFKTPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWFKTPV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 15:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWFKTPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 15:15:21 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:40628 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750819AbWFKTPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 15:15:17 -0400
Date: Sun, 11 Jun 2006 15:07:23 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: use C code for current_thread_info()
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200606111512_MC3-1-C229-37D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using C code for current_thread_info() lets the compiler optimize it.
With gcc 4.0.2, kernel is smaller:

    text           data     bss     dec     hex filename
 3645212         555556  312024 4512792  44dc18 2.6.17-rc6-nb-post/vmlinux
 3647276         555556  312024 4514856  44e428 2.6.17-rc6-nb/vmlinux
 -------
   -2064

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.17-rc6-32.orig/include/asm-i386/thread_info.h
+++ 2.6.17-rc6-32/include/asm-i386/thread_info.h
@@ -84,17 +84,15 @@ struct thread_info {
 #define init_stack		(init_thread_union.stack)
 
 
+/* how to get the current stack pointer from C */
+register unsigned long current_stack_pointer asm("esp") __attribute_used__;
+
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
-	struct thread_info *ti;
-	__asm__("andl %%esp,%0; ":"=r" (ti) : "0" (~(THREAD_SIZE - 1)));
-	return ti;
+	return (struct thread_info *)(current_stack_pointer & ~(THREAD_SIZE - 1));
 }
 
-/* how to get the current stack pointer from C */
-register unsigned long current_stack_pointer asm("esp") __attribute_used__;
-
 /* thread information allocation */
 #ifdef CONFIG_DEBUG_STACK_USAGE
 #define alloc_thread_info(tsk)					\
-- 
Chuck

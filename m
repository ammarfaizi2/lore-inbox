Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWDMNpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWDMNpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 09:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWDMNpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 09:45:13 -0400
Received: from mail.renesas.com ([202.234.163.13]:59896 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S964930AbWDMNpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 09:45:11 -0400
Date: Thu, 13 Apr 2006 22:45:06 +0900 (JST)
Message-Id: <20060413.224506.432825768.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] m32r: update include/asm-m32r/semaphore.h
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates include/asm-m32r/semaphore.h for good readability
and maintainability.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/semaphore.h |   64 ++-----------------------------------------
 1 file changed, 4 insertions(+), 60 deletions(-)

Index: linux-2.6.17-rc1-mm2/include/asm-m32r/semaphore.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/asm-m32r/semaphore.h	2006-04-10 10:37:29.826236194 +0900
+++ linux-2.6.17-rc1-mm2/include/asm-m32r/semaphore.h	2006-04-10 11:09:36.730041093 +0900
@@ -9,7 +9,7 @@
  * SMP- and interrupt-safe semaphores..
  *
  * Copyright (C) 1996  Linus Torvalds
- * Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
+ * Copyright (C) 2004, 2006  Hirokazu Takata <takata at linux-m32r.org>
  */
 
 #include <linux/config.h>
@@ -77,27 +77,8 @@ asmlinkage void __up(struct semaphore * 
  */
 static inline void down(struct semaphore * sem)
 {
-	unsigned long flags;
-	long count;
-
 	might_sleep();
-	local_irq_save(flags);
-	__asm__ __volatile__ (
-		"# down				\n\t"
-		DCACHE_CLEAR("%0", "r4", "%1")
-		M32R_LOCK" %0, @%1;		\n\t"
-		"addi	%0, #-1;		\n\t"
-		M32R_UNLOCK" %0, @%1;		\n\t"
-		: "=&r" (count)
-		: "r" (&sem->count)
-		: "memory"
-#ifdef CONFIG_CHIP_M32700_TS1
-		, "r4"
-#endif	/* CONFIG_CHIP_M32700_TS1 */
-	);
-	local_irq_restore(flags);
-
-	if (unlikely(count < 0))
+	if (unlikely(atomic_dec_return(&sem->count) < 0))
 		__down(sem);
 }
 
@@ -107,28 +88,10 @@ static inline void down(struct semaphore
  */
 static inline int down_interruptible(struct semaphore * sem)
 {
-	unsigned long flags;
-	long count;
 	int result = 0;
 
 	might_sleep();
-	local_irq_save(flags);
-	__asm__ __volatile__ (
-		"# down_interruptible		\n\t"
-		DCACHE_CLEAR("%0", "r4", "%1")
-		M32R_LOCK" %0, @%1;		\n\t"
-		"addi	%0, #-1;		\n\t"
-		M32R_UNLOCK" %0, @%1;		\n\t"
-		: "=&r" (count)
-		: "r" (&sem->count)
-		: "memory"
-#ifdef CONFIG_CHIP_M32700_TS1
-		, "r4"
-#endif	/* CONFIG_CHIP_M32700_TS1 */
-	);
-	local_irq_restore(flags);
-
-	if (unlikely(count < 0))
+	if (unlikely(atomic_dec_return(&sem->count) < 0))
 		result = __down_interruptible(sem);
 
 	return result;
@@ -174,26 +137,7 @@ static inline int down_trylock(struct se
  */
 static inline void up(struct semaphore * sem)
 {
-	unsigned long flags;
-	long count;
-
-	local_irq_save(flags);
-	__asm__ __volatile__ (
-		"# up				\n\t"
-		DCACHE_CLEAR("%0", "r4", "%1")
-		M32R_LOCK" %0, @%1;		\n\t"
-		"addi	%0, #1;			\n\t"
-		M32R_UNLOCK" %0, @%1;		\n\t"
-		: "=&r" (count)
-		: "r" (&sem->count)
-		: "memory"
-#ifdef CONFIG_CHIP_M32700_TS1
-		, "r4"
-#endif	/* CONFIG_CHIP_M32700_TS1 */
-	);
-	local_irq_restore(flags);
-
-	if (unlikely(count <= 0))
+	if (unlikely(atomic_inc_return(&sem->count) <= 0))
 		__up(sem);
 }
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/


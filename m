Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbULQLNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbULQLNr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 06:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbULQLNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 06:13:47 -0500
Received: from mail.renesas.com ([202.234.163.13]:26072 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262781AbULQLNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 06:13:42 -0500
Date: Fri, 17 Dec 2004 20:13:31 +0900 (JST)
Message-Id: <20041217.201331.1015305956.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: include/asm-m32r/thread_info.h minor
 updates (1/2)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041217.200641.1059989756.takata.hirokazu@renesas.com>
References: <20041217.200641.1059989756.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.10-rc3-mm1] m32r: include/asm-m32r/thread_info.h minor updates (1/2)
- Use THREAD_SIZE for __ASSEMBLY__ portion.
- Update comments.
- Fix a typo: user-thead --> user-thread.

NOTE: Now there are two THREAD_SIZE definitions in the following patch,
one is in C part and the other is in __ASSEMBLY__ part.
I'm going to consolidate these THREAD_SIZE definitions.  So, I have to
change PAGE_SIZE definition of include/asm-m32r/page.h to be includable
into asm portion...

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/thread_info.h |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)


diff -ruNp a/include/asm-m32r/thread_info.h b/include/asm-m32r/thread_info.h
--- a/include/asm-m32r/thread_info.h	2004-12-16 12:52:41.000000000 +0900
+++ b/include/asm-m32r/thread_info.h	2004-12-16 13:39:33.000000000 +0900
@@ -1,12 +1,13 @@
-/* thread_info.h: i386 low-level thread information
+#ifndef _ASM_M32R_THREAD_INFO_H
+#define _ASM_M32R_THREAD_INFO_H
+
+/* thread_info.h: m32r low-level thread information
  *
  * Copyright (C) 2002  David Howells (dhowells@redhat.com)
  * - Incorporating suggestions made by Linus Torvalds and Dave Miller
+ * Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
  */
 
-#ifndef _ASM_THREAD_INFO_H
-#define _ASM_THREAD_INFO_H
-
 #ifdef __KERNEL__
 
 #ifndef __ASSEMBLY__
@@ -30,7 +31,7 @@ struct thread_info {
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
-					 	   0-0xBFFFFFFF for user-thead
+					 	   0-0xBFFFFFFF for user-thread
 						   0-0xFFFFFFFF for kernel-thread
 						*/
 	struct restart_block    restart_block;
@@ -77,22 +78,23 @@ struct thread_info {
 #define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
 
+#define THREAD_SIZE (2*PAGE_SIZE)
+
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
 	struct thread_info *ti;
 
 	__asm__ __volatile__ (
-		"ldi	%0, #0xffffe000;	\n\t"
-		"and	%0, sp;			\n\t"
-		: "=r" (ti)
+		"ldi	%0, #%1			\n\t"
+		"and	%0, sp			\n\t"
+		: "=r" (ti) : "i" (~(THREAD_SIZE - 1))
 	);
 
 	return ti;
 }
 
 /* thread information allocation */
-#define THREAD_SIZE (2*PAGE_SIZE)
 #define alloc_thread_info(task) \
 	((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
 #define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
@@ -116,10 +118,12 @@ static inline unsigned int get_thread_fa
 
 #else /* !__ASSEMBLY__ */
 
+#define THREAD_SIZE	8192
+
 /* how to get the thread information struct from ASM */
 #define GET_THREAD_INFO(reg)	GET_THREAD_INFO reg
 	.macro GET_THREAD_INFO reg
-	ldi	\reg, #0xffffe000
+	ldi	\reg, #-THREAD_SIZE
 	and	\reg, sp
 	.endm
 
@@ -162,4 +170,4 @@ static inline unsigned int get_thread_fa
 
 #endif /* __KERNEL__ */
 
-#endif /* _ASM_THREAD_INFO_H */
+#endif /* _ASM_M32R_THREAD_INFO_H */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

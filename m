Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbULQLOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbULQLOJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 06:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbULQLOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 06:14:08 -0500
Received: from mail.renesas.com ([202.234.163.13]:63172 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262784AbULQLOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 06:14:01 -0500
Date: Fri, 17 Dec 2004 20:13:47 +0900 (JST)
Message-Id: <20041217.201347.628204375.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Use kmalloc for m32r stacks (2/2)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041217.200641.1059989756.takata.hirokazu@renesas.com>
References: <20041217.200641.1059989756.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.10-rc3-mm1] m32r: Use kmalloc for m32r stacks (2/2)
- Use kmalloc for m32r stacks (cf. changeset 1.1046.533.10)
- Update for CONFIG_DEBUG_STACK_USAGE

This modification was taken from include/asm-i386/thread_info.h.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/thread_info.h |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)


diff -ruNp a/include/asm-m32r/thread_info.h b/include/asm-m32r/thread_info.h
--- a/include/asm-m32r/thread_info.h	2004-12-16 13:41:57.000000000 +0900
+++ b/include/asm-m32r/thread_info.h	2004-12-16 13:42:32.000000000 +0900
@@ -95,9 +95,21 @@ static inline struct thread_info *curren
 }
 
 /* thread information allocation */
-#define alloc_thread_info(task) \
-	((struct thread_info *) __get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+#if CONFIG_DEBUG_STACK_USAGE
+#define alloc_thread_info(tsk)					\
+	({							\
+		struct thread_info *ret;			\
+	 							\
+	 	ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
+	 	if (ret)					\
+	 		memset(ret, 0, THREAD_SIZE);		\
+	 	ret;						\
+	 })
+#else
+#define alloc_thread_info(tsk) kmalloc(THREAD_SIZE, GFP_KERNEL)
+#endif
+
+#define free_thread_info(info) kfree(info)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWFMTno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWFMTno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 15:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFMTno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 15:43:44 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:38594 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751174AbWFMTnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 15:43:43 -0400
Date: Tue, 13 Jun 2006 14:43:40 -0500
To: discuss@x86-64.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86_64 stack usage debugging
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20060613194340.AB1A910CC671@attica.americas.sgi.com>
From: sandeen@sgi.com (Eric Sandeen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applies to git & 2.6.17-rc6 after CONFIG_DEBUG_STACKOVERFLOW patch

uses same stack-zeroing mechanism as on i386 to discover maximum stack excursions.

Signed-off-by: Eric Sandeen <sandeen@sgi.com>

Index: linux/arch/x86_64/Kconfig.debug
===================================================================
--- linux.orig/arch/x86_64/Kconfig.debug	2006-06-13 08:54:36.923001750 -0500
+++ linux/arch/x86_64/Kconfig.debug	2006-06-13 08:59:32.941501750 -0500
@@ -42,6 +42,15 @@
 	  This option will cause messages to be printed if free stack space
 	  drops below a certain limit.
 
+config DEBUG_STACK_USAGE
+        bool "Stack utilization instrumentation"
+        depends on DEBUG_KERNEL
+        help
+	  Enables the display of the minimum amount of free stack which each
+	  task has ever had available in the sysrq-T and sysrq-P debug output.
+
+	  This option will slow down process creation somewhat.
+
 #config X86_REMOTE_DEBUG
 #       bool "kgdb debugging stub"
 
Index: linux/include/asm-x86_64/thread_info.h
===================================================================
--- linux.orig/include/asm-x86_64/thread_info.h	2006-03-19 23:53:29.000000000 -0600
+++ linux/include/asm-x86_64/thread_info.h	2006-06-13 08:59:32.953502500 -0500
@@ -73,8 +73,21 @@
 }
 
 /* thread information allocation */
+#ifdef CONFIG_DEBUG_STACK_USAGE
+#define alloc_thread_info(tsk)					\
+    ({								\
+	struct thread_info *ret;				\
+								\
+	ret = ((struct thread_info *) __get_free_pages(GFP_KERNEL,THREAD_ORDER)); \
+	if (ret)						\
+		memset(ret, 0, THREAD_SIZE);			\
+	ret;							\
+    })
+#else
 #define alloc_thread_info(tsk) \
 	((struct thread_info *) __get_free_pages(GFP_KERNEL,THREAD_ORDER))
+#endif
+
 #define free_thread_info(ti) free_pages((unsigned long) (ti), THREAD_ORDER)
 
 #else /* !__ASSEMBLY__ */

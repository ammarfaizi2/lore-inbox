Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVK3EYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVK3EYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 23:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVK3EYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 23:24:38 -0500
Received: from kanga.kvack.org ([66.96.29.28]:27624 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750919AbVK3EYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 23:24:25 -0500
Date: Tue, 29 Nov 2005 23:21:37 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] x86-64 untangle smp.h vs thread_info
Message-ID: <20051130042137.GD19112@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the include dependancy in seccomp.h, an inline function in
smp.h introduces messy ordering requirements on thread_info by way of
using an inline function instead of macro.  Convert on_each_cpu to a
macro in order to avoid a big include mess.

---

 include/linux/smp.h |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

applies-to: a156afeaa4d82cdc6ac938c8c06b35d55a65e7fa
887d01c129bdf271901064625b1a01e5dbfc3e0f
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 9dfa3ee..a341b4d 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -57,19 +57,20 @@ extern int smp_call_function (void (*fun
 			      int retry, int wait);
 
 /*
- * Call a function on all processors
+ * Call a function on all processors.
+ * This needs to be a macro to allow for arch specific dependances on 
+ * sched.h in preempt_*().
  */
-static inline int on_each_cpu(void (*func) (void *info), void *info,
-			      int retry, int wait)
-{
-	int ret = 0;
-
-	preempt_disable();
-	ret = smp_call_function(func, info, retry, wait);
-	func(info);
-	preempt_enable();
-	return ret;
-}
+#define on_each_cpu(func, info, retry, wait)			\
+({								\
+	int ret = 0;						\
+								\
+	preempt_disable();					\
+	ret = smp_call_function(func, info, retry, wait);	\
+	func(info);						\
+	preempt_enable();					\
+	ret;							\
+})
 
 #define MSG_ALL_BUT_SELF	0x8000	/* Assume <32768 CPU's */
 #define MSG_ALL			0x8001
---
0.99.9.GIT

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVK3EYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVK3EYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 23:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbVK3EYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 23:24:17 -0500
Received: from kanga.kvack.org ([66.96.29.28]:27624 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750903AbVK3EYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 23:24:15 -0500
Date: Tue, 29 Nov 2005 23:21:31 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] x86-64 untangle seccomp.h vs thread_info
Message-ID: <20051130042131.GC19112@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling on x86-64 SMP, seccomp.h introduces an ordering dependancy
on asm/thread_info.h by using inline functions which reference the thread
info declaration before struct task_struct is finished being defined.  In
order to avoid this nasty include mess, convert the definitions in
seccomp.h into macros.

---

 include/linux/seccomp.h |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

applies-to: 610619c4af824b70bd81f228b24357838223ee50
194f04991a44fec3b21d30f1a137d402132996fc
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index dc89116..61eabc3 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -13,16 +13,13 @@
 typedef struct { int mode; } seccomp_t;
 
 extern void __secure_computing(int);
-static inline void secure_computing(int this_syscall)
-{
-	if (unlikely(test_thread_flag(TIF_SECCOMP)))
-		__secure_computing(this_syscall);
-}
+#define secure_computing(this_syscall)			\
+do {							\
+	if (unlikely(test_thread_flag(TIF_SECCOMP)))	\
+		__secure_computing(this_syscall);	\
+} while (0)
 
-static inline int has_secure_computing(struct thread_info *ti)
-{
-	return unlikely(test_ti_thread_flag(ti, TIF_SECCOMP));
-}
+#define has_secure_computing(ti) unlikely(test_ti_thread_flag(ti, TIF_SECCOMP))
 
 #else /* CONFIG_SECCOMP */
 
---
0.99.9.GIT

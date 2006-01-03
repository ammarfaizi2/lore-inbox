Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWACVIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWACVIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWACVH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:27791 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932575AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 08/50] i386: task_thread_info()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008PS-6y@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/i386/kernel/process.c |    4 ++--
 arch/i386/kernel/vm86.c    |    2 +-
 include/asm-i386/i387.h    |    8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

d0cf455569f14bd2720d57b724aa1a8b0a2fd212
diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
index 2333aea..b48cfe1 100644
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -612,8 +612,8 @@ static inline void disable_tsc(struct ta
 	 * gcc should eliminate the ->thread_info dereference if
 	 * has_secure_computing returns 0 at compile time (SECCOMP=n).
 	 */
-	prev = prev_p->thread_info;
-	next = next_p->thread_info;
+	prev = task_thread_info(prev_p);
+	next = task_thread_info(next_p);
 
 	if (has_secure_computing(prev) || has_secure_computing(next)) {
 		/* slow path here */
diff --git a/arch/i386/kernel/vm86.c b/arch/i386/kernel/vm86.c
index fc19935..312ee0b 100644
--- a/arch/i386/kernel/vm86.c
+++ b/arch/i386/kernel/vm86.c
@@ -310,7 +310,7 @@ static void do_sys_vm86(struct kernel_vm
 		"movl %1,%%ebp\n\t"
 		"jmp resume_userspace"
 		: /* no outputs */
-		:"r" (&info->regs), "r" (tsk->thread_info) : "ax");
+		:"r" (&info->regs), "r" (task_thread_info(tsk)) : "ax");
 	/* we never return here */
 }
 
diff --git a/include/asm-i386/i387.h b/include/asm-i386/i387.h
index 6747006..152d0ba 100644
--- a/include/asm-i386/i387.h
+++ b/include/asm-i386/i387.h
@@ -49,19 +49,19 @@ static inline void __save_init_fpu( stru
 		X86_FEATURE_FXSR,
 		"m" (tsk->thread.i387.fxsave)
 		:"memory");
-	tsk->thread_info->status &= ~TS_USEDFPU;
+	task_thread_info(tsk)->status &= ~TS_USEDFPU;
 }
 
 #define __unlazy_fpu( tsk ) do { \
-	if ((tsk)->thread_info->status & TS_USEDFPU) \
+	if (task_thread_info(tsk)->status & TS_USEDFPU) \
 		save_init_fpu( tsk ); \
 } while (0)
 
 #define __clear_fpu( tsk )					\
 do {								\
-	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
+	if (task_thread_info(tsk)->status & TS_USEDFPU) {		\
 		asm volatile("fnclex ; fwait");				\
-		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
+		task_thread_info(tsk)->status &= ~TS_USEDFPU;	\
 		stts();						\
 	}							\
 } while (0)
-- 
0.99.9.GIT


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVGRUlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVGRUlk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 16:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVGRUlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 16:41:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51606 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261899AbVGRUkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 16:40:46 -0400
Date: Mon, 18 Jul 2005 22:40:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: christoph@lameter.com, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: [swsusp] swsusp process freezing: remove smp races
Message-ID: <20050718204027.GA2112@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <christoph@lameter.com>

The current suspend code modifies thread->flags from outside the
context of the thread. This creates a SMP race.

This patch fixes that by introducing a TIF_FREEZE flag in thread_info.

(This is not the end of the races in the suspend code since TIF_FREEZE
is cleared when setting PF_FROZEN creating a window for
freeze_processes(). OTOH, this patch actually works :-)

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit b3ace94a1a465a2084bed642021aa8c8ddd912d1
tree 479de81d32de97f456f5d2929597f4047e1aab6f
parent e83468048173e800bfc4dc09c2d609f9983cd29d
author <pavel@amd.(none)> Mon, 18 Jul 2005 22:20:46 +0200
committer <pavel@amd.(none)> Mon, 18 Jul 2005 22:20:46 +0200

 include/asm-alpha/thread_info.h     |    1 +
 include/asm-arm/thread_info.h       |    1 +
 include/asm-arm26/thread_info.h     |    1 +
 include/asm-cris/thread_info.h      |    1 +
 include/asm-frv/thread_info.h       |    1 +
 include/asm-h8300/thread_info.h     |    1 +
 include/asm-i386/thread_info.h      |    1 +
 include/asm-ia64/thread_info.h      |    1 +
 include/asm-m32r/thread_info.h      |    1 +
 include/asm-m68k/thread_info.h      |    1 +
 include/asm-m68knommu/thread_info.h |    1 +
 include/asm-mips/thread_info.h      |    1 +
 include/asm-parisc/thread_info.h    |    1 +
 include/asm-ppc/thread_info.h       |    1 +
 include/asm-ppc64/thread_info.h     |    1 +
 include/asm-s390/thread_info.h      |    1 +
 include/asm-sh/thread_info.h        |    1 +
 include/asm-sh64/thread_info.h      |    1 +
 include/asm-sparc/thread_info.h     |    1 +
 include/asm-sparc64/thread_info.h   |    1 +
 include/asm-um/thread_info.h        |    1 +
 include/asm-v850/thread_info.h      |    1 +
 include/asm-x86_64/thread_info.h    |    1 +
 include/asm-xtensa/thread_info.h    |    1 +
 include/linux/sched.h               |    9 ++++-----
 25 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/asm-alpha/thread_info.h b/include/asm-alpha/thread_info.h
--- a/include/asm-alpha/thread_info.h
+++ b/include/asm-alpha/thread_info.h
@@ -78,6 +78,7 @@ register struct thread_info *__current_t
 #define TIF_UAC_NOFIX		7
 #define TIF_UAC_SIGBUS		8
 #define TIF_MEMDIE		9
+#define TIF_FREEZE		10
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
diff --git a/include/asm-arm/thread_info.h b/include/asm-arm/thread_info.h
--- a/include/asm-arm/thread_info.h
+++ b/include/asm-arm/thread_info.h
@@ -132,6 +132,7 @@ extern void iwmmxt_task_release(struct t
 #define TIF_POLLING_NRFLAG	16
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
diff --git a/include/asm-arm26/thread_info.h b/include/asm-arm26/thread_info.h
--- a/include/asm-arm26/thread_info.h
+++ b/include/asm-arm26/thread_info.h
@@ -127,6 +127,7 @@ extern void free_thread_info(struct thre
 #define TIF_USED_FPU		16
 #define TIF_POLLING_NRFLAG	17
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
diff --git a/include/asm-cris/thread_info.h b/include/asm-cris/thread_info.h
--- a/include/asm-cris/thread_info.h
+++ b/include/asm-cris/thread_info.h
@@ -86,6 +86,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17
+#define TIF_FREEZE		18
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
diff --git a/include/asm-frv/thread_info.h b/include/asm-frv/thread_info.h
--- a/include/asm-frv/thread_info.h
+++ b/include/asm-frv/thread_info.h
@@ -133,6 +133,7 @@ register struct thread_info *__current_t
 #define TIF_IRET		5	/* return with iret */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17	/* OOM killer killed process */
+#define TIF_FREEZE		18
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
diff --git a/include/asm-h8300/thread_info.h b/include/asm-h8300/thread_info.h
--- a/include/asm-h8300/thread_info.h
+++ b/include/asm-h8300/thread_info.h
@@ -94,6 +94,7 @@ static inline struct thread_info *curren
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_MEMDIE		5
+#define TIF_FREEZE		6
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
--- a/include/asm-i386/thread_info.h
+++ b/include/asm-i386/thread_info.h
@@ -143,6 +143,7 @@ register unsigned long current_stack_poi
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17
+#define TIF_FREEZE		18	/* Freeze thread */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
diff --git a/include/asm-ia64/thread_info.h b/include/asm-ia64/thread_info.h
--- a/include/asm-ia64/thread_info.h
+++ b/include/asm-ia64/thread_info.h
@@ -76,6 +76,7 @@ struct thread_info {
 #define TIF_SIGDELAYED		5	/* signal delayed from MCA/INIT/NMI/PMI context */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17
+#define TIF_FREEZE		18	/* Freeze process */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
diff --git a/include/asm-m32r/thread_info.h b/include/asm-m32r/thread_info.h
--- a/include/asm-m32r/thread_info.h
+++ b/include/asm-m32r/thread_info.h
@@ -156,6 +156,7 @@ static inline unsigned int get_thread_fa
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 					/* 31..28 fault code */
 #define TIF_MEMDIE		17
+#define TIF_FREEZE		18
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
diff --git a/include/asm-m68k/thread_info.h b/include/asm-m68k/thread_info.h
--- a/include/asm-m68k/thread_info.h
+++ b/include/asm-m68k/thread_info.h
@@ -49,6 +49,7 @@ struct thread_info {
 #define TIF_SIGPENDING		3	/* signal pending */
 #define TIF_NEED_RESCHED	4	/* rescheduling necessary */
 #define TIF_MEMDIE		5
+#define TIF_FREEZE		6
 
 extern int thread_flag_fixme(void);
 
diff --git a/include/asm-m68knommu/thread_info.h b/include/asm-m68knommu/thread_info.h
--- a/include/asm-m68knommu/thread_info.h
+++ b/include/asm-m68knommu/thread_info.h
@@ -91,6 +91,7 @@ static inline struct thread_info *curren
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_MEMDIE		5
+#define TIF_FREEZE		6
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/include/asm-mips/thread_info.h b/include/asm-mips/thread_info.h
--- a/include/asm-mips/thread_info.h
+++ b/include/asm-mips/thread_info.h
@@ -117,6 +117,7 @@ register struct thread_info *__current_t
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/include/asm-parisc/thread_info.h b/include/asm-parisc/thread_info.h
--- a/include/asm-parisc/thread_info.h
+++ b/include/asm-parisc/thread_info.h
@@ -64,6 +64,7 @@ struct thread_info {
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT               5       /* 32 bit binary */
 #define TIF_MEMDIE		6
+#define TIF_FREEZE		7
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
diff --git a/include/asm-ppc/thread_info.h b/include/asm-ppc/thread_info.h
--- a/include/asm-ppc/thread_info.h
+++ b/include/asm-ppc/thread_info.h
@@ -80,6 +80,7 @@ static inline struct thread_info *curren
 #define TIF_MEMDIE		5
 #define TIF_SYSCALL_AUDIT       6       /* syscall auditing active */
 #define TIF_SECCOMP             7      /* secure computing */
+#define TIF_FREEZE		8
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/include/asm-ppc64/thread_info.h b/include/asm-ppc64/thread_info.h
--- a/include/asm-ppc64/thread_info.h
+++ b/include/asm-ppc64/thread_info.h
@@ -102,6 +102,7 @@ static inline struct thread_info *curren
 #define TIF_SINGLESTEP		9	/* singlestepping active */
 #define TIF_MEMDIE		10
 #define TIF_SECCOMP		11	/* secure computing */
+#define TIF_FREEZE		12
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/include/asm-s390/thread_info.h b/include/asm-s390/thread_info.h
--- a/include/asm-s390/thread_info.h
+++ b/include/asm-s390/thread_info.h
@@ -102,6 +102,7 @@ static inline struct thread_info *curren
 					   TIF_NEED_RESCHED */
 #define TIF_31BIT		18	/* 32bit process */ 
 #define TIF_MEMDIE		19
+#define TIF_FREEZE		20
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
diff --git a/include/asm-sh/thread_info.h b/include/asm-sh/thread_info.h
--- a/include/asm-sh/thread_info.h
+++ b/include/asm-sh/thread_info.h
@@ -84,6 +84,7 @@ static inline struct thread_info *curren
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18
+#define TIF_FREEZE		19
 #define TIF_USERSPACE		31	/* true if FS sets userspace */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/include/asm-sh64/thread_info.h b/include/asm-sh64/thread_info.h
--- a/include/asm-sh64/thread_info.h
+++ b/include/asm-sh64/thread_info.h
@@ -80,6 +80,7 @@ static inline struct thread_info *curren
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_MEMDIE		4
+#define TIF_FREEZE		5
 
 
 #endif /* __KERNEL__ */
diff --git a/include/asm-sparc/thread_info.h b/include/asm-sparc/thread_info.h
--- a/include/asm-sparc/thread_info.h
+++ b/include/asm-sparc/thread_info.h
@@ -139,6 +139,7 @@ BTFIXUPDEF_CALL(void, free_thread_info, 
 #define TIF_POLLING_NRFLAG	9	/* true if poll_idle() is polling
 					 * TIF_NEED_RESCHED */
 #define TIF_MEMDIE		10
+#define TIF_FREEZE		11
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/include/asm-sparc64/thread_info.h b/include/asm-sparc64/thread_info.h
--- a/include/asm-sparc64/thread_info.h
+++ b/include/asm-sparc64/thread_info.h
@@ -230,6 +230,7 @@ register struct thread_info *current_thr
 #define TIF_ABI_PENDING		12
 #define TIF_MEMDIE		13
 #define TIF_POLLING_NRFLAG	14
+#define TIF_FREEZE		15
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
diff --git a/include/asm-um/thread_info.h b/include/asm-um/thread_info.h
--- a/include/asm-um/thread_info.h
+++ b/include/asm-um/thread_info.h
@@ -72,6 +72,7 @@ static inline struct thread_info *curren
 #define TIF_RESTART_BLOCK 	4
 #define TIF_MEMDIE	 	5
 #define TIF_SYSCALL_AUDIT	6
+#define TIF_FREEZE		7
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
diff --git a/include/asm-v850/thread_info.h b/include/asm-v850/thread_info.h
--- a/include/asm-v850/thread_info.h
+++ b/include/asm-v850/thread_info.h
@@ -85,6 +85,7 @@ struct thread_info {
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_MEMDIE		5
+#define TIF_FREEZE		6
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/include/asm-x86_64/thread_info.h b/include/asm-x86_64/thread_info.h
--- a/include/asm-x86_64/thread_info.h
+++ b/include/asm-x86_64/thread_info.h
@@ -108,6 +108,7 @@ static inline struct thread_info *stack_
 #define TIF_FORK		18	/* ret_from_fork */
 #define TIF_ABI_PENDING		19
 #define TIF_MEMDIE		20
+#define TIF_FREEZE		21	/* Freeze process */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
diff --git a/include/asm-xtensa/thread_info.h b/include/asm-xtensa/thread_info.h
--- a/include/asm-xtensa/thread_info.h
+++ b/include/asm-xtensa/thread_info.h
@@ -118,6 +118,7 @@ static inline struct thread_info *curren
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
 #define TIF_MEMDIE		6
+#define TIF_FREEZE		7
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -811,7 +811,6 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
-#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
@@ -1287,16 +1286,15 @@ static inline int frozen(struct task_str
  */
 static inline int freezing(struct task_struct *p)
 {
-	return p->flags & PF_FREEZE;
+	return test_ti_thread_flag(p->thread_info, TIF_FREEZE);
 }
 
 /*
  * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
  */
 static inline void freeze(struct task_struct *p)
 {
-	p->flags |= PF_FREEZE;
+	set_ti_thread_flag(p->thread_info, TIF_FREEZE);
 }
 
 /*
@@ -1317,7 +1315,8 @@ static inline int thaw_process(struct ta
  */
 static inline void frozen_process(struct task_struct *p)
 {
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
+	p->flags |= PF_FROZEN;
+	clear_ti_thread_flag(p->thread_info, TIF_FREEZE);
 }
 
 extern void refrigerator(void);

-- 
teflon -- maybe it is a trademark, but it should not be.

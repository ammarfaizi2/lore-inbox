Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWGJBP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWGJBP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 21:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWGJBP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 21:15:56 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:30872 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964874AbWGJBPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 21:15:55 -0400
Date: Sun, 9 Jul 2006 21:12:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch, take 3] i386: use thread_info flags for debug regs
  and IO bitmaps
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-ID: <200607092113_MC3-1-C488-170F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@hpl.hp.com>

Use thread info flags to track use of debug registers and IO bitmaps.
 
	- add TIF_DEBUG to track when debug registers are active
 	- add TIF_IO_BITMAP to track when I/O bitmap is used
 	- modify __switch_to() to use the new TIF flags

Performance tested on Pentium II, ten runs of LMbench context switch
benchmark (smaller is better:)

	before	after
avg	3.65	3.39
min	3.55	3.33
 
Signed-off-by: Stephane Eranian <eranian@hpl.hp.com>
Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Acked-by: Andi Kleen <ak@suse.de>

---

 arch/i386/kernel/ioport.c      |    1 
 arch/i386/kernel/process.c     |   50 +++++++++++++++++++++++------------------
 arch/i386/kernel/ptrace.c      |    5 +++-
 include/asm-i386/thread_info.h |    7 +++++
 4 files changed, 41 insertions(+), 22 deletions(-)

--- 2.6.18-rc1-nb.orig/arch/i386/kernel/ioport.c
+++ 2.6.18-rc1-nb/arch/i386/kernel/ioport.c
@@ -79,6 +79,7 @@ asmlinkage long sys_ioperm(unsigned long
 
 		memset(bitmap, 0xff, IO_BITMAP_BYTES);
 		t->io_bitmap_ptr = bitmap;
+		set_thread_flag(TIF_IO_BITMAP);
 	}
 
 	/*
--- 2.6.18-rc1-nb.orig/arch/i386/kernel/process.c
+++ 2.6.18-rc1-nb/arch/i386/kernel/process.c
@@ -359,16 +359,16 @@ EXPORT_SYMBOL(kernel_thread);
  */
 void exit_thread(void)
 {
-	struct task_struct *tsk = current;
-	struct thread_struct *t = &tsk->thread;
-
 	/* The process may have allocated an io port bitmap... nuke it. */
-	if (unlikely(NULL != t->io_bitmap_ptr)) {
+	if (unlikely(test_thread_flag(TIF_IO_BITMAP))) {
+		struct task_struct *tsk = current;
+		struct thread_struct *t = &tsk->thread;
 		int cpu = get_cpu();
 		struct tss_struct *tss = &per_cpu(init_tss, cpu);
 
 		kfree(t->io_bitmap_ptr);
 		t->io_bitmap_ptr = NULL;
+		clear_thread_flag(TIF_IO_BITMAP);
 		/*
 		 * Careful, clear this in the TSS too:
 		 */
@@ -387,6 +387,7 @@ void flush_thread(void)
 
 	memset(tsk->thread.debugreg, 0, sizeof(unsigned long)*8);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));	
+	clear_tsk_thread_flag(tsk, TIF_DEBUG);
 	/*
 	 * Forget coprocessor state..
 	 */
@@ -431,7 +432,7 @@ int copy_thread(int nr, unsigned long cl
 	savesegment(gs,p->thread.gs);
 
 	tsk = current;
-	if (unlikely(NULL != tsk->thread.io_bitmap_ptr)) {
+	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.io_bitmap_ptr) {
 			p->thread.io_bitmap_max = 0;
@@ -439,6 +440,7 @@ int copy_thread(int nr, unsigned long cl
 		}
 		memcpy(p->thread.io_bitmap_ptr, tsk->thread.io_bitmap_ptr,
 			IO_BITMAP_BYTES);
+		set_tsk_thread_flag(p, TIF_IO_BITMAP);
 	}
 
 	/*
@@ -533,10 +535,24 @@ int dump_task_regs(struct task_struct *t
 	return 1;
 }
 
-static inline void
-handle_io_bitmap(struct thread_struct *next, struct tss_struct *tss)
+static noinline void __switch_to_xtra(struct task_struct *next_p,
+				    struct tss_struct *tss)
 {
-	if (!next->io_bitmap_ptr) {
+	struct thread_struct *next;
+
+	next = &next_p->thread;
+
+	if (test_tsk_thread_flag(next_p, TIF_DEBUG)) {
+		set_debugreg(next->debugreg[0], 0);
+		set_debugreg(next->debugreg[1], 1);
+		set_debugreg(next->debugreg[2], 2);
+		set_debugreg(next->debugreg[3], 3);
+		/* no 4 and 5 */
+		set_debugreg(next->debugreg[6], 6);
+		set_debugreg(next->debugreg[7], 7);
+	}
+
+	if (!test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
 		/*
 		 * Disable the bitmap via an invalid offset. We still cache
 		 * the previous bitmap owner and the IO bitmap contents:
@@ -544,6 +560,7 @@ handle_io_bitmap(struct thread_struct *n
 		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 		return;
 	}
+
 	if (likely(next == tss->io_bitmap_owner)) {
 		/*
 		 * Previous owner of the bitmap (hence the bitmap content)
@@ -671,20 +688,11 @@ struct task_struct fastcall * __switch_t
 		set_iopl_mask(next->iopl);
 
 	/*
-	 * Now maybe reload the debug registers
+	 * Now maybe handle debug registers and/or IO bitmaps
 	 */
-	if (unlikely(next->debugreg[7])) {
-		set_debugreg(next->debugreg[0], 0);
-		set_debugreg(next->debugreg[1], 1);
-		set_debugreg(next->debugreg[2], 2);
-		set_debugreg(next->debugreg[3], 3);
-		/* no 4 and 5 */
-		set_debugreg(next->debugreg[6], 6);
-		set_debugreg(next->debugreg[7], 7);
-	}
-
-	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
-		handle_io_bitmap(next, tss);
+	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
+	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
+		__switch_to_xtra(next_p, tss);
 
 	disable_tsc(prev_p, next_p);
 
--- 2.6.18-rc1-nb.orig/arch/i386/kernel/ptrace.c
+++ 2.6.18-rc1-nb/arch/i386/kernel/ptrace.c
@@ -468,8 +468,11 @@ long arch_ptrace(struct task_struct *chi
 				  for(i=0; i<4; i++)
 					  if ((0x5f54 >> ((data >> (16 + 4*i)) & 0xf)) & 1)
 						  goto out_tsk;
+				  if (data)
+					  set_tsk_thread_flag(child, TIF_DEBUG);
+				  else
+					  clear_tsk_thread_flag(child, TIF_DEBUG);
 			  }
-
 			  addr -= (long) &dummy->u_debugreg;
 			  addr = addr >> 2;
 			  child->thread.debugreg[addr] = data;
--- 2.6.18-rc1-nb.orig/include/asm-i386/thread_info.h
+++ 2.6.18-rc1-nb/include/asm-i386/thread_info.h
@@ -140,6 +140,8 @@ static inline struct thread_info *curren
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 #define TIF_MEMDIE		16
+#define TIF_DEBUG		17	/* uses debug registers */
+#define TIF_IO_BITMAP		18	/* uses I/O bitmap */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -151,6 +153,8 @@ static inline struct thread_info *curren
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
+#define _TIF_DEBUG		(1<<TIF_DEBUG)
+#define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
@@ -159,6 +163,9 @@ static inline struct thread_info *curren
 /* work to do on any return to u-space */
 #define _TIF_ALLWORK_MASK	(0x0000FFFF & ~_TIF_SECCOMP)
 
+/* flags to check in __switch_to() */
+#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP)
+
 /*
  * Thread-synchronous status.
  *
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush

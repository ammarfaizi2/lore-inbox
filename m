Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318875AbSHLXdG>; Mon, 12 Aug 2002 19:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318876AbSHLXdG>; Mon, 12 Aug 2002 19:33:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4615 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318875AbSHLXc5>;
	Mon, 12 Aug 2002 19:32:57 -0400
Message-ID: <3D5845FF.C6668B15@zip.com.au>
Date: Mon, 12 Aug 2002 16:34:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Robert Love <rml@tech9.net>, Skip Ford <skip.ford@verizon.net>,
       "Adam J. Richter" <adam@yggdrasil.com>, ryan.flanigan@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.31: modules don't work at all
References: <3D57F5D6.C54F5A2A@zip.com.au> <Pine.LNX.4.33.0208121330310.1289-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 12 Aug 2002, Andrew Morton wrote:
> >
> > Gets tricky with nested lock_kernels.
> 
> No, lock-kernel already only increments once, at the first lock_kernel. We
> have a totally separate counter for the BKL depth, see <asm/smplock.h>
> 

There are eighteen smplock.h's, all different.  At least one (SuperH)
hasn't been converted to preempt.  I'd rather like to decouple the kmap
optimisation work from that mini-quagmire.  It's very easy to do, with

	current->flags |= PF_ATOMIC;
	__copy_to_user(...);
	current->flags &= ~PF_ATOMIC;

and that all works fine.

However, soldiering on leads us to some difficulties.  You're proposing,
effectively, that preempt_count gets shifted left one bit and that bit
zero becomes "has done lock_kernel()".

So bits 0-31 of preempt_count mean "may not be preempted" and "should
not preempt self".  And bits 1-31 of preempt count mean "must not
explicitly call schedule".

Problem is, the semantics of this vary too much between preemptible
and non-preemptible kernels.  Because non-preemptible kernels do
not increment preempt_count in spin_lock().

Maybe my penny hasn't dropped yet, but I tend to feel that the
semantics of my "may_schedule()" below are too fragile for it to
be part of the API.

(Untested, uncompiled code)


 arch/i386/mm/fault.c       |    2 -
 include/asm-i386/smplock.h |   20 +++++++++++++-----
 include/linux/preempt.h    |   49 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 51 insertions, 20 deletions

--- 2.5.31/arch/i386/mm/fault.c~fix-faults	Mon Aug 12 16:14:21 2002
+++ 2.5.31-akpm/arch/i386/mm/fault.c	Mon Aug 12 16:14:21 2002
@@ -192,7 +192,7 @@ asmlinkage void do_page_fault(struct pt_
 	 * If we're in an interrupt, have no user context or are running in an
 	 * atomic region then we must not take the fault..
 	 */
-	if (preempt_count() || !mm)
+	if (!may_schedule() || !mm)
 		goto no_context;
 
 #ifdef CONFIG_X86_REMOTE_DEBUG
--- 2.5.31/include/linux/preempt.h~fix-faults	Mon Aug 12 16:14:21 2002
+++ 2.5.31-akpm/include/linux/preempt.h	Mon Aug 12 16:14:21 2002
@@ -5,29 +5,60 @@
 
 #define preempt_count() (current_thread_info()->preempt_count)
 
+/*
+ * Bit zero of preempt_count means "holds lock_kernel".
+ * So a non-zero value in preempt_count() means "may not be preempted" and a
+ * non-zero value in bits 1-31 means "may not explicitly schedule".
+ */
+
 #define inc_preempt_count() \
 do { \
-	preempt_count()++; \
+	preempt_count() += 2; \
 } while (0)
 
 #define dec_preempt_count() \
 do { \
-	preempt_count()--; \
+	preempt_count() -= 2; \
+} while (0)
+
+#define lock_kernel_enter() \
+do { \
+	preempt_count() |= 1; \
+} while (0)
+
+#define lock_kernel_exit() \
+do { \
+	preempt_count() &= ~1; \
 } while (0)
 
+/*
+ * The semantics of this depend upon CONFIG_PREEMPT.
+ *
+ * With CONFIG_PREEMPT=y, may_schedule() returns false in irq context and
+ * inside spinlocks, and returns true inside lock_kernel().
+ *
+ * With CONFIG_PREEMPT=n, may_schedule() returns false in irq context, returns
+ * true inside spinlocks and returns true inside lock_kernel().
+ *
+ * But may_schedule() will also return false if the task has performed an
+ * explicit inc_preempt_count(), regardless of CONFIG_PREEMPT.  Which is really
+ * the only situation in which may_schedule() is useful.
+ */
+#define may_schedule()	(!(preempt_count() >> 1))
+
 #ifdef CONFIG_PREEMPT
 
 extern void preempt_schedule(void);
 
 #define preempt_disable() \
 do { \
-	inc_preempt_count(); \
+	preempt_count() += 2; \
 	barrier(); \
 } while (0)
 
 #define preempt_enable_no_resched() \
 do { \
-	dec_preempt_count(); \
+	preempt_count() -= 2; \
 	barrier(); \
 } while (0)
 
@@ -44,22 +75,12 @@ do { \
 		preempt_schedule(); \
 } while (0)
 
-#define inc_preempt_count_non_preempt()	do { } while (0)
-#define dec_preempt_count_non_preempt()	do { } while (0)
-
 #else
 
 #define preempt_disable()		do { } while (0)
 #define preempt_enable_no_resched()	do {} while(0)
 #define preempt_enable()		do { } while (0)
 #define preempt_check_resched()		do { } while (0)
-
-/*
- * Sometimes we want to increment the preempt count, but we know that it's
- * already incremented if the kernel is compiled for preemptibility.
- */
-#define inc_preempt_count_non_preempt()	inc_preempt_count()
-#define dec_preempt_count_non_preempt()	dec_preempt_count()
 
 #endif
 
--- 2.5.31/include/asm-i386/smplock.h~fix-faults	Mon Aug 12 16:14:21 2002
+++ 2.5.31-akpm/include/asm-i386/smplock.h	Mon Aug 12 16:15:20 2002
@@ -25,8 +25,10 @@ extern spinlock_t kernel_flag;
  */
 #define release_kernel_lock(task)		\
 do {						\
-	if (unlikely(task->lock_depth >= 0))	\
+	if (unlikely(task->lock_depth >= 0)) {	\
 		spin_unlock(&kernel_flag);	\
+		lock_kernel_exit();		\
+	}					\
 } while (0)
 
 /*
@@ -34,8 +36,10 @@ do {						\
  */
 #define reacquire_kernel_lock(task)		\
 do {						\
-	if (unlikely(task->lock_depth >= 0))	\
+	if (unlikely(task->lock_depth >= 0)) {	\
+		lock_kernel_enter();		\
 		spin_lock(&kernel_flag);	\
+	}					\
 } while (0)
 
 
@@ -49,13 +53,17 @@ do {						\
 static __inline__ void lock_kernel(void)
 {
 #ifdef CONFIG_PREEMPT
-	if (current->lock_depth == -1)
+	if (current->lock_depth == -1) {
+		lock_kernel_enter();
 		spin_lock(&kernel_flag);
+	}
 	++current->lock_depth;
 #else
 #if 1
-	if (!++current->lock_depth)
+	if (!++current->lock_depth) {
+		lock_kernel_enter();
 		spin_lock(&kernel_flag);
+	}
 #else
 	__asm__ __volatile__(
 		"incl %1\n\t"
@@ -73,8 +81,10 @@ static __inline__ void unlock_kernel(voi
 	if (current->lock_depth < 0)
 		BUG();
 #if 1
-	if (--current->lock_depth < 0)
+	if (--current->lock_depth < 0) {
 		spin_unlock(&kernel_flag);
+		lock_kernel_exit();
+	}
 #else
 	__asm__ __volatile__(
 		"decl %1\n\t"

.

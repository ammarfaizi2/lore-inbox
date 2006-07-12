Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWGLVnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWGLVnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWGLVnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:43:19 -0400
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:8174 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751433AbWGLVnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:43:19 -0400
Date: Wed, 12 Jul 2006 17:37:08 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Adrian Bunk <bunk@stusta.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, andrea <andrea@cpushare.com>
Message-ID: <200607121739_MC3-1-C4D3-28B9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <p73wtain80h.fsf@verdi.suse.de>

On 12 Jul 2006 17:43:42 +0200, Andi Kleen wrote:

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > 
> > I really don't care about cpushare and patents for some users of the
> > code in question. On the other hand turning on performance harming code
> > for a tiny number of users is dumb. If it were a loadable module it
> > would be different.
> 
> Actually there are some promising applications of seccomp outside
> cpushare.
> 
> e.g. Andrea at some point proposed to run codecs which often
> have security issues in a simple cpusec jail.  That's ok for 
> them because they normally don't need to do any system calls.
> 
> I liked the idea. While this can be done with LSM (e.g. apparmor) too 
> seccomp is definitely much easier and simpler and more "obviously safe"
> than anything LSM based.
> 
> If the TSC disabling code is taken out the runtime overhead
> of seccomp is also very small because it's only tested in slow
> paths.

We can just fold the TSC disable stuff into the new thread_flags test
at context-switch time:

[compile tested only; requires just-sent fix to i386 system.h]

 arch/i386/kernel/process.c     |   61 ++++++++++++++---------------------------
 include/asm-i386/thread_info.h |    3 +-
 2 files changed, 24 insertions(+), 40 deletions(-)

--- 2.6.18-rc1-nb.orig/arch/i386/kernel/process.c
+++ 2.6.18-rc1-nb/arch/i386/kernel/process.c
@@ -535,12 +535,11 @@ int dump_task_regs(struct task_struct *t
 	return 1;
 }
 
-static noinline void __switch_to_xtra(struct task_struct *next_p,
-				    struct tss_struct *tss)
+static noinline void
+__switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
+		 struct tss_struct *tss)
 {
-	struct thread_struct *next;
-
-	next = &next_p->thread;
+	struct thread_struct *next = &next_p->thread;
 
 	if (test_tsk_thread_flag(next_p, TIF_DEBUG)) {
 		set_debugreg(next->debugreg[0], 0);
@@ -552,6 +551,19 @@ static noinline void __switch_to_xtra(st
 		set_debugreg(next->debugreg[7], 7);
 	}
 
+	/*
+	 * Context switch may need to tweak the TSC disable bit in CR4.
+	 * The optimizer should remove this code when !CONFIG_SECCOMP.
+	 */
+	if (has_secure_computing(task_thread_info(prev_p)) ^
+	    has_secure_computing(task_thread_info(next_p))) {
+		/* prev and next are different */
+		if (has_secure_computing(task_thread_info(next_p)))
+			write_cr4(read_cr4() | X86_CR4_TSD);
+		else
+			write_cr4(read_cr4() & ~X86_CR4_TSD);
+	}
+
 	if (!test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
 		/*
 		 * Disable the bitmap via an invalid offset. We still cache
@@ -561,7 +573,7 @@ static noinline void __switch_to_xtra(st
 		return;
 	}
 
-	if (likely(next == tss->io_bitmap_owner)) {
+	if (likely(tss->io_bitmap_owner == next)) {
 		/*
 		 * Previous owner of the bitmap (hence the bitmap content)
 		 * matches the next task, we dont have to do anything but
@@ -583,33 +595,6 @@ static noinline void __switch_to_xtra(st
 }
 
 /*
- * This function selects if the context switch from prev to next
- * has to tweak the TSC disable bit in the cr4.
- */
-static inline void disable_tsc(struct task_struct *prev_p,
-			       struct task_struct *next_p)
-{
-	struct thread_info *prev, *next;
-
-	/*
-	 * gcc should eliminate the ->thread_info dereference if
-	 * has_secure_computing returns 0 at compile time (SECCOMP=n).
-	 */
-	prev = task_thread_info(prev_p);
-	next = task_thread_info(next_p);
-
-	if (has_secure_computing(prev) || has_secure_computing(next)) {
-		/* slow path here */
-		if (has_secure_computing(prev) &&
-		    !has_secure_computing(next)) {
-			write_cr4(read_cr4() & ~X86_CR4_TSD);
-		} else if (!has_secure_computing(prev) &&
-			   has_secure_computing(next))
-			write_cr4(read_cr4() | X86_CR4_TSD);
-	}
-}
-
-/*
  *	switch_to(x,yn) should switch tasks from x to y.
  *
  * We fsave/fwait so that an exception goes off at the right time
@@ -688,13 +673,11 @@ struct task_struct fastcall * __switch_t
 		set_iopl_mask(next->iopl);
 
 	/*
-	 * Now maybe handle debug registers and/or IO bitmaps
+	 * Now maybe handle debug registers, IO bitmaps, TSC disable
 	 */
-	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
-	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
-		__switch_to_xtra(next_p, tss);
-
-	disable_tsc(prev_p, next_p);
+	if (unlikely(task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW_PREV ||
+		     task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT))
+		__switch_to_xtra(prev_p, next_p, tss);
 
 	return prev_p;
 }
--- 2.6.18-rc1-nb.orig/include/asm-i386/thread_info.h
+++ 2.6.18-rc1-nb/include/asm-i386/thread_info.h
@@ -164,7 +164,8 @@ static inline struct thread_info *curren
 #define _TIF_ALLWORK_MASK	(0x0000FFFF & ~_TIF_SECCOMP)
 
 /* flags to check in __switch_to() */
-#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP)
+#define _TIF_WORK_CTXSW_NEXT (_TIF_IO_BITMAP | _TIF_SECCOMP | _TIF_DEBUG)
+#define _TIF_WORK_CTXSW_PREV (_TIF_IO_BITMAP | _TIF_SECCOMP)
 
 /*
  * Thread-synchronous status.
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush

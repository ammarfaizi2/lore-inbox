Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVE0Crl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVE0Crl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 22:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVE0Crl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 22:47:41 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22319
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261368AbVE0CrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 22:47:24 -0400
Date: Fri, 27 May 2005 04:47:19 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1
Message-ID: <20050527024719.GV5691@g5.random>
References: <20050525134933.5c22234a.akpm@osdl.org> <17045.36727.602005.757948@alkaid.it.uu.se> <20050526130402.GN5691@g5.random> <17046.8270.55088.771900@alkaid.it.uu.se> <20050526222256.GS5691@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526222256.GS5691@g5.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here an update that passed successfully basic testing verifying task
gets killed with sig11 if rdtsc is used in seccomp mode on x86-64 (i686
still untested but fully symmetric).

From: Andrea Arcangeli <andrea@cpushare.com>

I believe at least for seccomp it's worth to turn off the tsc, not just for
HT but for the L2 cache too.  So it's up to you, either you turn it off
completely (which isn't very nice IMHO) or I recommend to apply this below
patch.

This has been tested successfully on x86-64 against current cogito
repository (i686 compiles so I didn't bother testing ;).  People selling
the cpu through cpushare may appreciate this bit for a peace of mind. 

There's no way to get any timing info anymore with this applied
(gettimeofday is forbidden of course).  The seccomp environment is
completely deterministic so it can't be allowed to get timing info, it has
to be deterministic so in the future I can enable a computing mode that
does a parallel computing for each task with server side transparent
checkpointing and verification that the output is the same from all the 2/3
seller computers for each task, without the buyer even noticing (for now
the verification is left to the buyer client side and there's no
checkpointing, since that would require more kernel changes to track the
dirty bits but it'll be easy to extend once the basic mode is finished).

Eliminating a cold-cache read of the cr4 global variable will save one
cacheline during the tlb flush while making the code per-cpu-safe at the
same time. Thanks to Mikael Pettersson for noticing the tlb flush wasn't
per-cpu-safe. 

The global tlb flush can run from irq (IPI calling do_flush_tlb_all) but
it'll be transparent to the switch_to code since the IPI won't make any
change to the cr4 contents from the point of view of the interrupted
code and since it's now all per-cpu stuff, it will not race. So no need
to disable irqs in switch_to slow path.

Signed-off-by: Andrea Arcangeli <andrea@cpushare.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/process.c   |   21 +++++++++++++++++++++
 arch/x86_64/kernel/process.c |   21 +++++++++++++++++++++
 include/linux/seccomp.h      |    6 ++++++
 3 files changed, 48 insertions(+)

Index: arch/i386/kernel/process.c
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/arch/i386/kernel/process.c  (mode:100644)
+++ uncommitted/arch/i386/kernel/process.c  (mode:100644)
@@ -561,6 +561,25 @@
 }
 
 /*
+ * This function selects if the context switch from prev to next
+ * has to tweak the TSC disable bit in the cr4.
+ */
+static void disable_tsc(struct thread_info *prev,
+			struct thread_info *next)
+{
+	if (unlikely(has_secure_computing(prev) ||
+		     has_secure_computing(next))) {
+		/* slow path here */
+		if (has_secure_computing(prev) &&
+		    !has_secure_computing(next)) {
+			write_cr4(read_cr4() & ~X86_CR4_TSD);
+		} else if (!has_secure_computing(prev) &&
+			   has_secure_computing(next))
+			write_cr4(read_cr4() | X86_CR4_TSD);
+	}
+}
+
+/*
  *	switch_to(x,yn) should switch tasks from x to y.
  *
  * We fsave/fwait so that an exception goes off at the right time
@@ -639,6 +658,8 @@
 	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
 		handle_io_bitmap(next, tss);
 
+	disable_tsc(prev_p->thread_info, next_p->thread_info);
+
 	return prev_p;
 }
 
Index: arch/x86_64/kernel/process.c
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/arch/x86_64/kernel/process.c  (mode:100644)
+++ uncommitted/arch/x86_64/kernel/process.c  (mode:100644)
@@ -439,6 +439,25 @@
 }
 
 /*
+ * This function selects if the context switch from prev to next
+ * has to tweak the TSC disable bit in the cr4.
+ */
+static void disable_tsc(struct thread_info *prev,
+			struct thread_info *next)
+{
+	if (unlikely(has_secure_computing(prev) ||
+		     has_secure_computing(next))) {
+		/* slow path here */
+		if (has_secure_computing(prev) &&
+		    !has_secure_computing(next)) {
+			write_cr4(read_cr4() & ~X86_CR4_TSD);
+		} else if (!has_secure_computing(prev) &&
+			   has_secure_computing(next))
+			write_cr4(read_cr4() | X86_CR4_TSD);
+	}
+}
+
+/*
  * This special macro can be used to load a debugging register
  */
 #define loaddebug(thread,r) set_debug(thread->debugreg ## r, r)
@@ -556,6 +575,8 @@
 		}
 	}
 
+	disable_tsc(prev_p->thread_info, next_p->thread_info);
+
 	return prev_p;
 }
 
Index: include/asm-i386/tlbflush.h
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/include/asm-i386/tlbflush.h  (mode:100644)
+++ uncommitted/include/asm-i386/tlbflush.h  (mode:100644)
@@ -22,16 +22,18 @@
  */
 #define __flush_tlb_global()						\
 	do {								\
-		unsigned int tmpreg;					\
+		unsigned int tmpreg, cr4, cr4_orig;			\
 									\
 		__asm__ __volatile__(					\
-			"movl %1, %%cr4;  # turn off PGE     \n"	\
+			"movl %%cr4, %2;  # turn off PGE     \n"	\
+			"movl %2, %1;                        \n"	\
+			"andl %3, %1;                        \n"	\
+			"movl %1, %%cr4;                     \n"	\
 			"movl %%cr3, %0;                     \n"	\
 			"movl %0, %%cr3;  # flush TLB        \n"	\
 			"movl %2, %%cr4;  # turn PGE back on \n"	\
-			: "=&r" (tmpreg)				\
-			: "r" (mmu_cr4_features & ~X86_CR4_PGE),	\
-			  "r" (mmu_cr4_features)			\
+			: "=&r" (tmpreg), "=&r" (cr4), "=&r" (cr4_orig)	\
+			: "i" (~X86_CR4_PGE)				\
 			: "memory");					\
 	} while (0)
 
Index: include/asm-x86_64/tlbflush.h
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/include/asm-x86_64/tlbflush.h  (mode:100644)
+++ uncommitted/include/asm-x86_64/tlbflush.h  (mode:100644)
@@ -22,16 +22,18 @@
  */
 #define __flush_tlb_global()						\
 	do {								\
-		unsigned long tmpreg;					\
+		unsigned long tmpreg, cr4, cr4_orig;			\
 									\
 		__asm__ __volatile__(					\
-			"movq %1, %%cr4;  # turn off PGE     \n"	\
+			"movq %%cr4, %2;  # turn off PGE     \n"	\
+			"movq %2, %1;                        \n"	\
+			"andq %3, %1;                        \n"	\
+			"movq %1, %%cr4;                     \n"	\
 			"movq %%cr3, %0;  # flush TLB        \n"	\
 			"movq %0, %%cr3;                     \n"	\
 			"movq %2, %%cr4;  # turn PGE back on \n"	\
-			: "=&r" (tmpreg)				\
-			: "r" (mmu_cr4_features & ~X86_CR4_PGE),	\
-			  "r" (mmu_cr4_features)			\
+			: "=&r" (tmpreg), "=&r" (cr4), "=&r" (cr4_orig)	\
+			: "i" (~X86_CR4_PGE)				\
 			: "memory");					\
 	} while (0)
 
Index: include/linux/seccomp.h
===================================================================
--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/include/linux/seccomp.h  (mode:100644)
+++ uncommitted/include/linux/seccomp.h  (mode:100644)
@@ -19,6 +19,11 @@
 		__secure_computing(this_syscall);
 }
 
+static inline int has_secure_computing(struct thread_info *ti)
+{
+	return unlikely(test_ti_thread_flag(ti, TIF_SECCOMP));
+}
+
 #else /* CONFIG_SECCOMP */
 
 #if (__GNUC__ > 2)
@@ -28,6 +33,7 @@
 #endif
 
 #define secure_computing(x) do { } while (0)
+#define has_secure_computing(x) 0
 
 #endif /* CONFIG_SECCOMP */
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbTBXSL3>; Mon, 24 Feb 2003 13:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTBXSKx>; Mon, 24 Feb 2003 13:10:53 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:30633 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S266907AbTBXSKK> convert rfc822-to-8bit; Mon, 24 Feb 2003 13:10:10 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (1/13): base s390 fixes.
Date: Mon, 24 Feb 2003 19:07:21 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302241907.21554.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 arch changes/bug fixes:
 * add sys_fadvise64 system call
 * add initialization of init_sighand
 * add support for clone option CLONE_SETTLS
 * make use of ptrace_notify
 * sig -> sighand rename
 * move ptrace_signal_deliver to the correct place
 * make eieio a memory barrier
 * fix race condition on cpu_vm_mask in __flush_tlb_mm
 * add missing KM_SOFTIRQ0, KM_SOFTIRQ1 in asm-s390x/kmap_types.h
 * add inline assmelby for _raw_write_trylock

diff -urN linux-2.5.62/arch/s390/kernel/entry.S linux-2.5.62-s390/arch/s390/kernel/entry.S
--- linux-2.5.62/arch/s390/kernel/entry.S	Mon Feb 24 18:17:42 2003
+++ linux-2.5.62-s390/arch/s390/kernel/entry.S	Mon Feb 24 18:18:24 2003
@@ -616,7 +616,8 @@
 	.long  sys_epoll_ctl		 /* 250 */
 	.long  sys_epoll_wait
 	.long  sys_set_tid_address
-	.rept  255-252
+	.long  sys_fadvise64
+	.rept  255-253
 	.long  sys_ni_syscall
 	.endr
 
diff -urN linux-2.5.62/arch/s390/kernel/init_task.c linux-2.5.62-s390/arch/s390/kernel/init_task.c
--- linux-2.5.62/arch/s390/kernel/init_task.c	Mon Feb 17 23:56:20 2003
+++ linux-2.5.62-s390/arch/s390/kernel/init_task.c	Mon Feb 24 18:18:24 2003
@@ -16,6 +16,7 @@
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
+static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
 
 /*
diff -urN linux-2.5.62/arch/s390/kernel/process.c linux-2.5.62-s390/arch/s390/kernel/process.c
--- linux-2.5.62/arch/s390/kernel/process.c	Mon Feb 17 23:56:44 2003
+++ linux-2.5.62-s390/arch/s390/kernel/process.c	Mon Feb 24 18:18:24 2003
@@ -196,8 +196,6 @@
 
         /* new return point is ret_from_fork */
         frame->gprs[8] = (unsigned long) ret_from_fork;
-	/* start disabled because of schedule_tick and rq->lock being held */
-	frame->childregs.psw.mask &= ~0x03000000;
 
         /* fake return stack for resume(), don't go back to schedule */
         frame->gprs[9]  = (unsigned long) frame;
@@ -213,6 +211,10 @@
 	p->thread.ar4 = get_fs().ar4;
         /* Don't copy debug registers */
         memset(&p->thread.per_info,0,sizeof(p->thread.per_info));
+
+	/* Set a new TLS ?  */
+	if (clone_flags & CLONE_SETTLS)
+		frame->childregs.acrs[0] = regs->gprs[6];
         return 0;
 }
 
@@ -335,7 +337,7 @@
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
-	stack_page = (unsigned long) p;
+	stack_page = (unsigned long) p->thread_info;
 	r15 = p->thread.ksp;
         if (!stack_page || r15 < stack_page || r15 >= 8188+stack_page)
                 return 0;
diff -urN linux-2.5.62/arch/s390/kernel/ptrace.c linux-2.5.62-s390/arch/s390/kernel/ptrace.c
--- linux-2.5.62/arch/s390/kernel/ptrace.c	Mon Feb 17 23:56:55 2003
+++ linux-2.5.62-s390/arch/s390/kernel/ptrace.c	Mon Feb 24 18:18:24 2003
@@ -359,11 +359,9 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code =
-		SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) ? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
+
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -urN linux-2.5.62/arch/s390/kernel/signal.c linux-2.5.62-s390/arch/s390/kernel/signal.c
--- linux-2.5.62/arch/s390/kernel/signal.c	Mon Feb 17 23:56:45 2003
+++ linux-2.5.62-s390/arch/s390/kernel/signal.c	Mon Feb 24 18:18:24 2003
@@ -391,7 +391,7 @@
 handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
 	struct pt_regs * regs)
 {
-	struct k_sigaction *ka = &current->sig->action[sig-1];
+	struct k_sigaction *ka = &current->sighand->action[sig-1];
 
 	/* Are we from a system call? */
 	if (regs->trap == __LC_SVC_OLD_PSW) {
diff -urN linux-2.5.62/arch/s390x/kernel/entry.S linux-2.5.62-s390/arch/s390x/kernel/entry.S
--- linux-2.5.62/arch/s390x/kernel/entry.S	Mon Feb 24 18:17:42 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/entry.S	Mon Feb 24 18:18:24 2003
@@ -644,7 +644,8 @@
 	.long  SYSCALL(sys_epoll_ctl,sys_ni_syscall)
 	.long  SYSCALL(sys_epoll_wait,sys_ni_syscall)
 	.long  SYSCALL(sys_set_tid_address,sys_ni_syscall)
-        .rept  255-252
+	.long  SYSCALL(sys_fadvise64,sys_ni_syscall)
+        .rept  255-253
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
 	.endr
 
diff -urN linux-2.5.62/arch/s390x/kernel/init_task.c linux-2.5.62-s390/arch/s390x/kernel/init_task.c
--- linux-2.5.62/arch/s390x/kernel/init_task.c	Mon Feb 17 23:56:11 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/init_task.c	Mon Feb 24 18:18:24 2003
@@ -16,6 +16,7 @@
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
+static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
 
 /*
diff -urN linux-2.5.62/arch/s390x/kernel/process.c linux-2.5.62-s390/arch/s390x/kernel/process.c
--- linux-2.5.62/arch/s390x/kernel/process.c	Mon Feb 17 23:56:29 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/process.c	Mon Feb 24 18:18:24 2003
@@ -203,6 +203,19 @@
 	p->thread.ar4 = get_fs().ar4;
         /* Don't copy debug registers */
         memset(&p->thread.per_info,0,sizeof(p->thread.per_info));
+
+	/* Set a new TLS ?  */
+	if (clone_flags & CLONE_SETTLS) {
+		if (current->thread.flags & S390_FLAG_31BIT) {
+			frame->childregs.acrs[0] =
+				(unsigned int) regs->gprs[6];
+		} else {
+			frame->childregs.acrs[0] =
+				(unsigned int)(regs->gprs[6] >> 32);
+			frame->childregs.acrs[1] =
+				(unsigned int) regs->gprs[6];
+		}
+	}
         return 0;
 }
 
@@ -319,7 +332,7 @@
         int count = 0;
         if (!p || p == current || p->state == TASK_RUNNING)
                 return 0;
-        stack_page = (unsigned long) p;
+	stack_page = (unsigned long) p->thread_info;
         r15 = p->thread.ksp;
         if (!stack_page || r15 < stack_page || r15 >= 16380+stack_page)
                 return 0;
diff -urN linux-2.5.62/arch/s390x/kernel/ptrace.c linux-2.5.62-s390/arch/s390x/kernel/ptrace.c
--- linux-2.5.62/arch/s390x/kernel/ptrace.c	Mon Feb 17 23:55:53 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/ptrace.c	Mon Feb 24 18:18:24 2003
@@ -598,11 +598,9 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code =
-		SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) ? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
+
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -urN linux-2.5.62/arch/s390x/kernel/signal.c linux-2.5.62-s390/arch/s390x/kernel/signal.c
--- linux-2.5.62/arch/s390x/kernel/signal.c	Mon Feb 17 23:56:20 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/signal.c	Mon Feb 24 18:18:24 2003
@@ -385,7 +385,7 @@
 handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
 	struct pt_regs * regs)
 {
-	struct k_sigaction *ka = &current->sig->action[sig-1];
+	struct k_sigaction *ka = &current->sighand->action[sig-1];
 
 	/* Are we from a system call? */
 	if (regs->trap == __LC_SVC_OLD_PSW) {
diff -urN linux-2.5.62/include/asm-s390/signal.h linux-2.5.62-s390/include/asm-s390/signal.h
--- linux-2.5.62/include/asm-s390/signal.h	Mon Feb 17 23:56:40 2003
+++ linux-2.5.62-s390/include/asm-s390/signal.h	Mon Feb 24 18:18:24 2003
@@ -159,6 +159,9 @@
 struct k_sigaction {
         struct sigaction sa;
 };
+
+#define ptrace_signal_deliver(regs, cookie) do { } while (0)
+
 #else
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
@@ -175,8 +178,6 @@
 #define sa_handler      _u._sa_handler
 #define sa_sigaction    _u._sa_sigaction
 
-#define ptrace_signal_deliver(regs, cookie) do { } while (0)
-
 #endif /* __KERNEL__ */
 
 typedef struct sigaltstack {
diff -urN linux-2.5.62/include/asm-s390/spinlock.h linux-2.5.62-s390/include/asm-s390/spinlock.h
--- linux-2.5.62/include/asm-s390/spinlock.h	Mon Feb 17 23:57:22 2003
+++ linux-2.5.62-s390/include/asm-s390/spinlock.h	Mon Feb 24 18:24:47 2003
@@ -122,4 +122,17 @@
                      : "+m" ((rw)->lock) : "a" (&(rw)->lock) \
 		     : "2", "3", "cc" )
 
+extern inline int _raw_write_trylock(rwlock_t *rw)
+{
+	unsigned int result, reg;
+	
+	__asm__ __volatile__("   lhi  %0,1\n"
+			     "   sll  %0,31\n"
+			     "   basr %1,0\n"
+			     "0: cs   %0,%1,0(%3)\n"
+			     : "=&d" (result), "=&d" (reg), "+m" (rw->lock)
+			     : "a" (&rw->lock) : "cc" );
+	return !result;
+}
+
 #endif /* __ASM_SPINLOCK_H */
diff -urN linux-2.5.62/include/asm-s390/system.h linux-2.5.62-s390/include/asm-s390/system.h
--- linux-2.5.62/include/asm-s390/system.h	Mon Feb 17 23:57:19 2003
+++ linux-2.5.62-s390/include/asm-s390/system.h	Mon Feb 24 18:18:24 2003
@@ -222,7 +222,7 @@
  * all memory ops have completed wrt other CPU's ( see 7-15 POP  DJB ).
  */
 
-#define eieio()  __asm__ __volatile__ ("BCR 15,0") 
+#define eieio()  __asm__ __volatile__ ( "bcr 15,0" : : : "memory" ) 
 # define SYNC_OTHER_CORES(x)   eieio() 
 #define mb()    eieio()
 #define rmb()   eieio()
diff -urN linux-2.5.62/include/asm-s390/tlbflush.h linux-2.5.62-s390/include/asm-s390/tlbflush.h
--- linux-2.5.62/include/asm-s390/tlbflush.h	Mon Feb 17 23:57:18 2003
+++ linux-2.5.62-s390/include/asm-s390/tlbflush.h	Mon Feb 24 18:18:24 2003
@@ -91,15 +91,17 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
+	preempt_disable();
 	if (mm->cpu_vm_mask != (1UL << smp_processor_id())) {
 		/* mm was active on more than one cpu. */
 		if (mm == current->active_mm &&
-		    atomic_read(&mm->mm_count) == 1)
+		    atomic_read(&mm->mm_users) == 1)
 			/* this cpu is the only one using the mm. */
 			mm->cpu_vm_mask = 1UL << smp_processor_id();
 		global_flush_tlb();
 	} else
 		local_flush_tlb();
+	preempt_enable();
 }
 
 static inline void flush_tlb(void)
diff -urN linux-2.5.62/include/asm-s390/unistd.h linux-2.5.62-s390/include/asm-s390/unistd.h
--- linux-2.5.62/include/asm-s390/unistd.h	Mon Feb 17 23:57:22 2003
+++ linux-2.5.62-s390/include/asm-s390/unistd.h	Mon Feb 24 18:18:24 2003
@@ -248,6 +248,7 @@
 #define __NR_epoll_ctl		250
 #define __NR_epoll_wait		251
 #define __NR_set_tid_address	252
+#define __NR_fadvise64		253
 
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
diff -urN linux-2.5.62/include/asm-s390x/kmap_types.h linux-2.5.62-s390/include/asm-s390x/kmap_types.h
--- linux-2.5.62/include/asm-s390x/kmap_types.h	Mon Feb 17 23:56:13 2003
+++ linux-2.5.62-s390/include/asm-s390x/kmap_types.h	Mon Feb 24 18:18:24 2003
@@ -14,6 +14,8 @@
 	KM_PTE1,
 	KM_IRQ0,
 	KM_IRQ1,
+	KM_SOFTIRQ0,
+	KM_SOFTIRQ1,	
 	KM_TYPE_NR
 };
 
diff -urN linux-2.5.62/include/asm-s390x/signal.h linux-2.5.62-s390/include/asm-s390x/signal.h
--- linux-2.5.62/include/asm-s390x/signal.h	Mon Feb 17 23:56:19 2003
+++ linux-2.5.62-s390/include/asm-s390x/signal.h	Mon Feb 24 18:18:24 2003
@@ -159,6 +159,9 @@
 struct k_sigaction {
         struct sigaction sa;
 };
+
+#define ptrace_signal_deliver(regs, cookie) do { } while (0)
+
 #else
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
@@ -175,8 +178,6 @@
 #define sa_handler      _u._sa_handler
 #define sa_sigaction    _u._sa_sigaction
 
-#define ptrace_signal_deliver(regs, cookie) do { } while (0)
-
 #endif /* __KERNEL__ */
 
 typedef struct sigaltstack {
diff -urN linux-2.5.62/include/asm-s390x/spinlock.h linux-2.5.62-s390/include/asm-s390x/spinlock.h
--- linux-2.5.62/include/asm-s390x/spinlock.h	Mon Feb 17 23:55:57 2003
+++ linux-2.5.62-s390/include/asm-s390x/spinlock.h	Mon Feb 24 18:24:47 2003
@@ -139,5 +139,17 @@
 		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND) \
 		     : "2", "3", "cc" )
 
+extern inline int _raw_write_trylock(rwlock_t *rw)
+{
+	unsigned int result, reg;
+	
+	__asm__ __volatile__("   llihh %0,0x8000\n"
+			     "   basr  %1,0\n"
+			     "0: csg %0,%1,0(%3)\n"
+			     : "=&d" (result), "=&d" (reg), "+m" (rw->lock)
+			     : "a" (&rw->lock) : "cc" );
+	return !result;
+}
+
 #endif /* __ASM_SPINLOCK_H */
 
diff -urN linux-2.5.62/include/asm-s390x/system.h linux-2.5.62-s390/include/asm-s390x/system.h
--- linux-2.5.62/include/asm-s390x/system.h	Mon Feb 17 23:56:59 2003
+++ linux-2.5.62-s390/include/asm-s390x/system.h	Mon Feb 24 18:18:24 2003
@@ -233,7 +233,7 @@
  * all memory ops have completed wrt other CPU's ( see 7-15 POP  DJB ).
  */
 
-#define eieio()  __asm__ __volatile__ ("BCR 15,0") 
+#define eieio()  __asm__ __volatile__ ( "bcr 15,0" : : : "memory" ) 
 # define SYNC_OTHER_CORES(x)   eieio() 
 #define mb()    eieio()
 #define rmb()   eieio()
diff -urN linux-2.5.62/include/asm-s390x/tlbflush.h linux-2.5.62-s390/include/asm-s390x/tlbflush.h
--- linux-2.5.62/include/asm-s390x/tlbflush.h	Mon Feb 17 23:56:25 2003
+++ linux-2.5.62-s390/include/asm-s390x/tlbflush.h	Mon Feb 24 18:18:24 2003
@@ -88,15 +88,17 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
+	preempt_disable();
 	if (mm->cpu_vm_mask != (1UL << smp_processor_id())) {
 		/* mm was active on more than one cpu. */
 		if (mm == current->active_mm &&
-		    atomic_read(&mm->mm_count) == 1)
+		    atomic_read(&mm->mm_users) == 1)
 			/* this cpu is the only one using the mm. */
 			mm->cpu_vm_mask = 1UL << smp_processor_id();
 		global_flush_tlb();
 	} else
 		local_flush_tlb();
+	preempt_enable();
 }
 
 static inline void flush_tlb(void)
diff -urN linux-2.5.62/include/asm-s390x/unistd.h linux-2.5.62-s390/include/asm-s390x/unistd.h
--- linux-2.5.62/include/asm-s390x/unistd.h	Mon Feb 17 23:56:25 2003
+++ linux-2.5.62-s390/include/asm-s390x/unistd.h	Mon Feb 24 18:18:24 2003
@@ -215,6 +215,7 @@
 #define __NR_epoll_ctl		250
 #define __NR_epoll_wait		251
 #define __NR_set_tid_address	252
+#define __NR_fadvise64		253
 
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */

